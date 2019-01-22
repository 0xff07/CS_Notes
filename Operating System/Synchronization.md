# 同步機制

# 初步概念

想要做一個「如果有人在裡面，那就等到別人出來」的機制。其中一個方法是用下面種作法：

```c
# define lock_t int
# define LOCKED 1
# define UNLOCKED 0
void spin_lock(lock_t *lock) {
	while (lock)
		;
	*lock = LOCKED;
}
void spin_unlock (lock_t *lock) {
	*lock = UNLOCKED;
}
```

然後設置一個全域的鎖：

```c
lock_t global_lock;
...
void *thread (void* lock) {
	spin_lock((lock_t*)&lock);
	/* this is critical section */
	spin_unlock((lock_t*)&lock);
}
```

這樣一來：

1. 假設有一個執行單元正在執行，而且 `lock` 的狀態是在 `UNLOCKED`，那麼 `spin_lock` 函數中的 `while` 會直接跳過，把東西鎖上。
2. 如果 `lock` 的狀態是 `LOCKED`，那麼其他執行單元在執行 `spin_lock` 函數時，`while(lock) 無窮迴圈中， ``*lock` 被設成 0，才會往下執行。

雖然概念上很簡單，但實際上實作有超超超超超超多的問題要考慮。上面釀的 code 只是期待達成的演算法，實際上上面的 code 一下就會爆掉。

# 問題

```c
void spin_lock(lock_t *lock) {
	while (lock)
		;
	*lock = 1;
}
void spin_unlock (lock_t *lock) {
	*lock = 0;
}
```

概念上是這樣，但實際上如果用這個東西下去的話，會跑出一大堆問題。因為用 objdump 去看編出來的東西：

```c
0000000000000000 <_spin_lock>:
   0:   55                      push   %rbp
   1:   48 89 e5                mov    %rsp,%rbp
   4:   48 89 7d f8             mov    %rdi,-0x8(%rbp)
   8:   48 83 7d f8 00          cmpq   $0x0,-0x8(%rbp)
   d:   0f 84 05 00 00 00       je     18 <_spin_lock+0x18>
  13:   e9 f0 ff ff ff          jmpq   8 <_spin_lock+0x8>
  18:   48 8b 45 f8             mov    -0x8(%rbp),%rax
  1c:   c6 00 01                movb   $0x1,(%rax)
  1f:   5d                      pop    %rbp
  20:   c3                      retq
  21:   66 66 66 66 66 66 2e    data16 data16 data16 data16 data16 nopw %cs:0x0(%rax,%rax,1)
  28:   0f 1f 84 00 00 00 00
  2f:   00

0000000000000030 <_spin_unlock>:
  30:   55                      push   %rbp
  31:   48 89 e5                mov    %rsp,%rbp
  34:   48 89 7d f8             mov    %rdi,-0x8(%rbp)
  38:   48 8b 7d f8             mov    -0x8(%rbp),%rdi
  3c:   c6 07 00                movb   $0x0,(%rdi)
  3f:   5d                      pop    %rbp
  40:   c3                      retq
```

所以，光是想要把這個 code 寫對，會發現一個明顯的問題：在 `spin_lock` 的程式中，`cmpq` 成功後，到真的把這個變數設成 1，中間還會經過一堆指令。萬一在中間這些指令執行時，有其他執行單元把它設成 1 （也就是搶了這個鎖），那麼 `cmpq` 的結果就沒有意義了，這樣這個鎖就會被鎖 2 次。也就是說，「發現鎖開著」跟「上鎖」之間，不能有其他東西改變 `lock` 。

1. ==Atomic Instruction==：其中一種保證方法是「讓這兩步中間沒有指令」比如說如就可以確保「比較 + 寫入」是個指令的最小單位，中間不會有其他指令的指令，那麼就可以確定鎖在矮變狀態的過程中，中間不會有其他人打擾。

但這樣還有可能有其他問題：就算「發現沒鎖 + 跑去上鎖」是會一氣呵成完成的，但還是有一些問題：

1. ==Interrupt==：如果鎖到一半的過程中，有中斷發生，然後 Interrupt Service Routine 剛好也用了這個鎖，那該怎麼辦。或是鎖到一半被 context switch 掉，也會發生這個悲劇
2. ==Kernel Preemption==：如果不希望上面這些事情發生，就要在上鎖的過程中，暫時不允許 Interrupt。但如果又要求作業系統即時，往往需要讓優先權高的任務搶佔; 但不准 Interrupt 之後，就沒辦法搶佔了！所以這對搶佔式系統的效能就會帶來影響。

這還只是軟體上的問題。在多核心的架構之下，每個 CPU 都有自己的 L1 Cache，那就會有超級大亂鬥：

1. ==Energy Consumption==：因為所有等待資源的執行單元，都在做 busy wait。這樣一來能源就浪費掉了。
2. ==Cache Line Bouncing==：每個 CPU 的 L1 Cache 裡面都可能鎖的副本。那當有人改變鎖的狀態時，要把鎖的狀態通通更新到所有 CPU 的 Cache 上。如果鎖的狀態每更新一次，都要同步一次所有 CPU 上的 Cache，這樣在資料同步上會花超多時間。除了更新要花時間，也會耗費非常多電力在上面。
3. ==公平性==：類似的狀況，Cache 的更新速度，會因為 CPU 位置遠近有所影響。這樣就會造成「Cache 比較快被更新到的 CPU，永遠有辦法比別的 CPU 先發現鎖開了，因此有辦法更快搶到鎖」，而 Cache 比較慢更新到的 CPU 就會一直搶不到。這對公平性來說是一大問題。

除了實作上的問題之外，還有些使用上的問題：

1. ==沒人解鎖==：假設有一個執行單元把資源鎖住，結果在還沒開鎖之前就結束了，那不就沒人打得開了？
2. ==解鈴不是繫鈴人==：解鎖的人跟開鎖的人不一樣的話，要怎麼辦？

最後是一些非常微妙的狀況：

1. ==Deadlock==：A 等 B，B 等 A，結果大家都互等，沒有人讓出來。
2. ==Priority Inversion==：就算規定可以搶佔，那麼也可能發生等很久的狀況。假設優先順序 A > B > C。現在 A 要搶 C 的東西，但在 C 準備把東西收拾好給 A 之前，B 突然出現要搶 C 的東西，這時 C 只能把東西給 B。但是 A 從頭到尾不知道 B 有在搶 C 的東西，就算要發揮 A > B 的優先順序，他也要先知道有 B 在搶 C 的東西。所以他只以為是 C 東西收拾很久，以至於要等 B 用完還給 C 之後，C 才可以把東西順利交給 A。

## Interrupt

這個問題以 Linux Kernel 為例，提供不同的實作來在不同的場合進行鎖。

* `spin_lock`、`spin_unlock`：鎖跟解鎖一個 `spinlock` 。

* `spin_lock_bh`、`spin_unlock_bh`：把軟體的 Interrupt 停掉，然後再鎖  `spinlock`; 解鎖的話則相反：把 `spinlock` 解鎖，然後恢復軟體 Interrupt。

  這邊會有「`bh`」字樣，是跟 Interrupt 的分段有關。一個 Interrupt 的流程會分成需要立即處理的「上半段」(top-half)，以及比較不緊急的「下半段」(buttom-half)。比如說封包來的時後，就需要立刻收下來，但至於這個封包內容後續的解析，可能不那麼緊急，所以就可能把前者放在 top-half，後者放在 buttom half。

* `spin_lock_irqsave` 、 `spin_lock_irq`：關掉目前這個 CPU 上，硬體的 Interrupt，然後再鎖。差別是前面儲存 CPU 暫存器的狀態，後者不會。

## Cache Line Bouncing

這個問題是這樣的：

1. 有 1 個 CPU 上的執行單元把鎖鎖住。但這個「鎖上」目前只在它自己的 L1 Cache 上發生。
2. 爲了維持 Cache 跟記憶體的一致性，不管用什麼機制，其他 CPU 也要把自己的 L1 Cache 中的鎖的副本更新。

但這樣會有的問題是：

1. 明明只有 1 顆 CPU 在使用鎖，但其他沒使用這個鎖的 CPU ，除了要 busy wait 之外，還要不時更新自己的 Cache。
2. 除了這之外，公平性也會有問題。不同 CPU 上的 L1 Cache 知道「鎖狀態改變」的時間未必一樣，較遠的 CPU 可能總是比較晚才更新鎖的狀態，導致永遠後知後覺，一直搶不到鎖。

## 改良 0：

## 改良 1：Ticket Lock

改良的其中一種方式是：叫大家不要搶，乖乖「叫號」排隊。這種作法就做「Ticket Lock」。運作機制如下：

```c
typedef struct {
    union {
        unsigned int slock;
        struct __raw_tickets {
            unsigned short owner;
            unsigned short next;
        } tickets;
    };
} arch_spinlock_t; 
```

鎖的資料結構中，除了鎖的狀態 `slock` 之外，還有一個包含 `owner` 跟 `next` 的結構體。`owner` 是目前持有的人是第幾號，而 `next` 是下一號要處理的人。作法是：

1. 每個人在 busy wait 時，不斷地看現在幾號。
2. 如果號碼跳到自己，就進去把他鎖住。
3. 用完之後，把號碼 +1

在 Linux 4.20 中，ARM 架構的[相關程式碼](https://elixir.bootlin.com/linux/v4.20/source/arch/arm/include/asm/spinlock.h#L56)長這樣：

```c
static inline void arch_spin_lock(arch_spinlock_t *lock)
{
	unsigned long tmp;
	u32 newval;
	arch_spinlock_t lockval;

	prefetchw(&lock->slock);
	__asm__ __volatile__(
"1:	ldrex	%0, [%3]\n"
"	add	%1, %0, %4\n"
"	strex	%2, %1, [%3]\n"
"	teq	%2, #0\n"
"	bne	1b"
	: "=&r" (lockval), "=&r" (newval), "=&r" (tmp)
	: "r" (&lock->slock), "I" (1 << TICKET_SHIFT)
	: "cc");

	while (lockval.tickets.next != lockval.tickets.owner) {
		wfe();
		lockval.tickets.owner = READ_ONCE(lock->tickets.owner);
	}

	smp_mb();
}
```

這個演算法翻譯成 C 語言大概是：

```c
static inline void arch_spin_lock(arch_spinlock_t *lock) {
    arch_spinlock_t old_lock;
 
    old_lock.slock = lock->slock; /* 1 */
    lock->tickets.next++; /* 2 */
    while (old_lock.tickets.next != old_lock.tickets.owner) { /* 3 */
        wfe(); /* 4 */
        old_lock.tickets.owner = lock->tickets.owner; /* 5 */
    }
}
```

這邊使用 C 語言寫並不是說這個 C 語言就會編出上面那坨東西，只是因為 C 語言比較好理解，一個把 C 語言當成 pesudo code 的概念。比較大的差異在 `ldrex` 跟 `strex` 那邊，這兩個指令是 `exclusive load` 跟 `exclusive store` 的意思：

不過，總之這邊的關鍵在於 code 的概念。畢竟實作會一直演化。

而如果要解鎖的話：

```c
static inline void arch_spin_unlock(arch_spinlock_t *lock)
{
	smp_mb();
	lock->tickets.owner++;
	dsb_sev();
}
```

這個解鎖其實滿單純的，就是叫下一號。 `smp_mb` 是memory barrier，而 `dsb_sev()` 是用來喚醒在睡覺的 CPU，叫他們起來等下一位。

## 改良 2：MCS Lock

# Semaphore

# Reader-Writer Lock

這個改良是在考慮：如果有很多人同時讀這個資料，那這樣讀資料的過程中，又不會改到資料，照理來說應該不用「每個人要讀的時候，就把他鎖起來不讓其他人讀」。所以，可以把 lock 機制改成「如果大家都是同時讀，那不用鎖; 但如果有任何一個人要寫，就要把讀者通通趕走，把東西鎖起來給他改」。這種機制叫做 Reader-Writer Lock。在 Kernel 中對應的[機制](https://elixir.bootlin.com/linux/v4.20/source/arch/arm/include/asm/spinlock_types.h#L30)是：

```c
typedef struct {
	u32 lock;
} arch_rwlock_t;
```

就是一個 32 位元的整數。而使用機制是這樣：

```
+----+-------------------------------------------------+
| 31 | 30                                            0 |
+----+-------------------------------------------------+
  |                    |
  |                    +----> [0:30] Read Thread Counter
  +-------------------------> [31]  Write Thread Counter
```

最高位元表示「有沒有 write 在裡面」。因為寫入的時候，一次只允許一個 writer 進入，所以就只要一個位元表示有沒有人在讀寫就好。而後面的 31 個位元是一個 counter，用來計數現在有多少個 reader 在裡面。

對於 Reader 來說，進入 critical section 的程式為：

```c
static inline void arch_read_lock(arch_rwlock_t *rw)
{
	unsigned long tmp, tmp2;

	prefetchw(&rw->lock);
	__asm__ __volatile__(
"1:	ldrex	%0, [%2]\n"
"	adds	%0, %0, #1\n"
"	strexpl	%1, %0, [%2]\n"
	WFE("mi")
"	rsbpls	%0, %1, #0\n"
"	bmi	1b"
	: "=&r" (tmp), "=&r" (tmp2)
	: "r" (&rw->lock)
	: "cc");

	smp_mb();
}
```

概念上來說，對應的 C 語言是：

```c
    do {
        wfe();
        tmp = rw->lock;
        tmp++; /* 1 */
    } while(tmp & (1 << 31)); /* 2 */
    rw->lock = tmp;
```

其實也滿直覺的，首先做 `wait for event`，等到鎖打開被通知之後，去拿鎖的副本，把 Reader 的 Counter + 1，接著看準備更新時有沒有 writer 在裡面，如果有的話，那就回去前面 `wfe()` 繼續等; 如果沒有 writer，就把鎖的狀態更新。

# Mutex vs. Semaphore





概念上來說，Mutex 用在「有一個 Critical Section，這段 code 一次只能有一個執行單元進入」; 而 Semaphore，「有個一定數量的資源，必須控制」，比如說 Producer-Consumer 狀況中，行程間通訊的狀況。

另外，Mutex 有「持有」的語意，即當一個執行單元「持有」鎖上這個 Mutex 時，應該被當成這個執行單元「擁有」這個 Mutex，而這個 Mutex 也必須由鎖上的人進行解鎖。雖說如此，但 Linux 核心中的 Mutex 實作中，只有特定條件被開啟時，Mutex 才會有這個「持有」的行為：

```c
struct mutex {
        atomic_t                count;
        spinlock_t              wait_lock;
        struct list_head        wait_list;
#if defined(CONFIG_DEBUG_MUTEXES) || defined(CONFIG_MUTEX_SPIN_ON_OWNER)
        struct task_struct      *owner;
#endif
#ifdef CONFIG_MUTEX_SPIN_ON_OWNER
        struct optimistic_spin_queue osq;
#endif
#ifdef CONFIG_DEBUG_MUTEXES
        void                    *magic;
#endif
#ifdef CONFIG_DEBUG_LOCK_ALLOC
        struct lockdep_map      dep_map;
#endif
};
```

話雖然是這樣說，但在實作來說，兩者的界線其實很曖昧。比如說去翻 `struct semaphore` 在 Linux Kernel 的[原始程式](https://elixir.bootlin.com/linux/latest/source/include/linux/semaphore.h)，會發現：

```c
/* Please don't access any members of this structure directly */
struct semaphore {
	raw_spinlock_t		lock;
	unsigned int		count;
	struct list_head	wait_list;
};
```

這...看起來根本超級像的啊！雖然說資料結構上的實作很像，但是支援的操作 (`lock` vs. `up`) 完全不一樣。

另外，一般常說的 semaphore 有 2 種：一種是 POSIX 規範下的 semaphore，稱做 POSIX Semaphore; 另外一種是 XSI 下規定的 semaphore，叫做 System V Semaphore。兩個光用法就完全不一樣。

順帶一提，在 4.20 版的 Kernel 中，Mutex 變成：

```c
struct mutex {
	atomic_long_t		owner;
	spinlock_t		wait_lock;
#ifdef CONFIG_MUTEX_SPIN_ON_OWNER
	struct optimistic_spin_queue osq; /* Spinner MCS lock */
#endif
	struct list_head	wait_list;
#ifdef CONFIG_DEBUG_MUTEXES
	void			*magic;
#endif
#ifdef CONFIG_DEBUG_LOCK_ALLOC
	struct lockdep_map	dep_map;
#endif
};
```

會發現多了一個 MCS lock 相關的選項。MCS 是一個讓鎖變得比較「公平」的新機制。