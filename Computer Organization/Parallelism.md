# Parallelalization

# Instruction Level Parallelism

指得是在 CPU 架構設計方面的平行化，讓 CPU 有機會可以讓不同指令重疊執行，進而增加效率。比如說 Pipeline 就是一種 Instruction Level Parallelism 的設計方式。而需要考慮的議題也就是那些之前在 pipeline 中需要考慮的議題：每個 Stage 的設計、Hazard、Branch Prediction 等等。

# Data Level Parallelism

Data Level Parallelism 思考的點在於「資料的相依性」。如果不同資料之間的計算沒有相依性，那麼就可以考慮把這些沒有相依性的資料運算同時處理。比如說加兩個矩陣，相應位置的每個元素的加法，並不仰賴於其他元素加法的結果。這時就可以考慮如「在 1 個 cycle 中，同時進行 8 個加法」這種方式來加速程式。

## SIMD

>Vector architectures grab sets of data elements scattered about memory, place them into large, sequential register files, operate on data in those register files, and then disperse the results back into memory.

這個意思是 Single-Instruction Multiple Data。字面上的意思是「用單一一個指令，一次處理很多資料」。比如說如果要把 `float M[256]` 中的內容加到 `float N[256]` 當中。如果是使用一般的作法，最直覺的方法可能會寫出像下面這樣的東西：

```c
for (int i = 0; i < 256; i++)
	N[i] += M[i];
```

但在做這件事情的時候會發現：既然都已經知道要加 256 個東西了，那可不可以不要一個一個加，而是一批一批的加，比如說 4 個 4 個加、8 個 8 個加．．．？有點像是：

1. 有一種「可以一次塞進很多浮點數（比如說 8 個）的暫存器」。
2. 可以一次從記憶體中同時 Load 一堆值（比如說也用 8 個好了）到那種暫存器中。
3. 然後，那種暫存器一次可以同時加 8 個浮點數。
4. 加完之後，也可以把 8 個浮點數一次塞回連續的位置中。

這樣一來，本來要「分開做 8 次」的東西，就可以「一次做 8 個」，聽起來就非常棒。這種「一次做一堆」的精神，就是 Single Instruction Multiple Data 的精神。

### 例子：Intel AVX

比如說，在 Intel 處理器中，就有 AVX 這種東西可以用。上面那個作法用 AVX 的方式，大致上如下：

```C
for (int i = 0; i < 32; i++) {
	/* __m256 是某個可以一次塞 8 個浮點數的暫存器 */
    __m256 vector_M;
    __m256 vector_N;
    
    /* 一次塞連續的 8 個浮點數到那種暫存器中 */
    vector_M = _mm256_loadu_ps(&M[i]);
    vector_N = _mm256_loadu_ps(&N[i]);
    
    /* 然後把兩個暫存器進行相加 */
    vector_N = _mm256_add_ps (vector_N, vector_M);
    
    /* 最後把計算結果塞回目標中  */
    _mm256_store_ps (&M[i], vector_N);
}
```

`gcc` 打開 `-mavx` 後，就會認出那堆 `__mm256` 開頭的東西，並且使用對應的向量運算指令編譯進去。

但這時有一個問題：要怎麼知道這些指令真的有比較快呢？首先，可以去查處理器廠商給的資料，比如 Intel 的 [Intel Intrinsic Guide](https://software.intel.com/sites/landingpage/IntrinsicsGuide/)。分別查 `_mm256_loadu_ps` 為例，可以查到下面的內容：

> ### Synopsis
>
> `__m256 _mm256_add_ps (__m256 a, __m256 b)`
> `#include <immintrin.h>`
> Instruction: `vaddps ymm, ymm, ymm`
> CPUID Flags: `AVX`
>
> ### Description
>
> Add packed single-precision (32-bit) floating-point elements in a and b, and store the results in dst.
>
> ### Operation
>
> ```
> FOR j := 0 to 7
> 	i := j*32
> 	dst[i+31:i] := a[i+31:i] + b[i+31:i]
> ENDFOR
> dst[MAX:256] := 0
> ```
>
> ### Performance
>
> | Archetecture | Latency | Throughput(CPI) |
> | ------------ | ------- | --------------- |
> | Skylake      | 4       | 0.5             |
> | Broadwell    | 3       | 1               |
> | Haswell      | 3       | 1               |
> | Ivy Bridge   | 3       | 1               |
>

上面可以發現有 Latency 跟 Throughput 兩項。他們的在 Intel [官方的定義](https://software.intel.com/en-us/articles/measuring-instruction-latency-and-throughput)分別是指：

> ### Latency and Throughput
>
> Latency is the number of processor clocks it takes for an instruction to have its data available for use by another instruction. Therefore, an instruction which has a latency of 6 clocks will have its data available for another instruction that many clocks after it starts its execution.
>
> Throughput is the number of processor clocks it takes for an instruction to execute or perform its calculations. An instruction with a throughput of 2 clocks would tie up its execution unit for that many cycles which prevents an instruction needing that execution unit from being executed. Only after the instruction is done with the execution unit can the next instruction enter.

若查詢[Intel 指令的性能實驗值](https://www.agner.org/optimize/instruction_tables.pdf)可以發現，以 Skylake 為例，浮點數加法 `ADDSS` 指令的 Latency 也是 4，throughput 也是 0.5，但這只是「加一個浮點數」需要的時間而已，而 `VADDPS` 指令一次可以加 8 個浮點數。

舉例來說，像下面這種個程式：

```c
float a[8] = {2.125, 2.125, 2.125, 2.125, 2.125, 2.125, 2.125, 2.125}, 
      b[8] = {4.375, 4.275, 4.375, 4.375, 4.375, 4.375, 4.375, 4.375}, 
      c[8];

int main()
{
    for (int i = 0; i < 8; i++)
        c[i] = a[i] + b[i];
}
```

這段程式使用 `gcc -O1`編譯之後結果如下：

```objc
0000000000001125 <main>:
    1125:       b8 00 00 00 00          mov    $0x0,%eax
    112a:       48 8d 35 4f 2f 00 00    lea    0x2f4f(%rip),%rsi        # 4080 <c>
    1131:       48 8d 0d 08 2f 00 00    lea    0x2f08(%rip),%rcx        # 4040 <a>
    1138:       48 8d 15 e1 2e 00 00    lea    0x2ee1(%rip),%rdx        # 4020 <b>
    113f:       f3 0f 10 04 01          movss  (%rcx,%rax,1),%xmm0
    1144:       f3 0f 58 04 02          addss  (%rdx,%rax,1),%xmm0
    1149:       f3 0f 11 04 06          movss  %xmm0,(%rsi,%rax,1)
    114e:       48 83 c0 04             add    $0x4,%rax
    1152:       48 83 f8 20             cmp    $0x20,%rax
    1156:       75 e7                   jne    113f <main+0x1a>
    1158:       b8 00 00 00 00          mov    $0x0,%eax
    115d:       c3                      retq
    115e:       66 90                   xchg   %ax,%ax
```

可以觀察到：這個程式是非常標準的迴圈寫法：首先把 `a`, `b`, `c` 陣列的位址使用 `lea` (Load Effective Address) 指令，放到暫存器中，並以 `%rax` 作為計數器，一次 +4 byte 作為 offset ，去找 `a` `b` 陣列中相對位置相同的資料，直到做了 8 次，也就是 offset 到 256 (`0x20`) 為止。

這樣很明顯迴圈需要執行 8 次。接著看看 AVX 的程式：

```c
#include <immintrin.h>
float a[8] = {2.125, 2.125, 2.125, 2.125, 2.125, 2.125, 2.125, 2.125}, 
      b[8] = {4.375, 4.275, 4.375, 4.375, 4.375, 4.375, 4.375, 4.375}, 
      c[8];

int main()
{
    __m256 A;
    __m256 B;
    
    A = _mm256_load_ps (&a[0]);
    B = _mm256_load_ps (&b[0]);
    B = _mm256_add_ps (A, B);
    _mm256_store_ps (&c[0], B);
}
```

編譯再反組譯之後，結果如下：

```objc
0000000000001125 <main>:
    1125:       c5 fc 28 0d 13 2f 00    vmovaps 0x2f13(%rip),%ymm1        # 4040 <a>
    112c:       00
    112d:       c5 f4 58 05 eb 2e 00    vaddps 0x2eeb(%rip),%ymm1,%ymm0        # 4020 <b>
    1134:       00
    1135:       c5 f8 29 05 43 2f 00    vmovaps %xmm0,0x2f43(%rip)        	# 4080 <c>
    113c:       00
    113d:       c4 e3 7d 19 05 49 2f    vextractf128 $0x1,%ymm0,0x2f49(%rip)        # 4090 <c+0x10>
    1144:       00 00 01
    1147:       b8 00 00 00 00          mov    $0x0,%eax
    114c:       c3                      retq
    114d:       0f 1f 00                nopl   (%rax)
```

可以發現：程式當中明顯沒有迴圈出現，取而代之的是 `vmovaps` 指令一次，把整個 `a`跟 `b` 塞分別進去 `ymm0` 跟 `ymm1` 暫存器中，然後將兩個暫存器一次相加，最後把東西塞向 `c` 裡面。

這樣看起來，向量運算應該要超級快嗎？實際上未必。比如說上述這個程式來說，有沒有使用 AVX 其實沒有顯著的差異，使用 `perf` 統計起來，甚至無法分辨這個誤差屬於統計上的誤差，或是真的由此推論是 AVX 帶來優化。但是如果換一個程式，就有非常明顯的差異。舉例來說，考慮一個矩陣加法的程式。一個直覺的實作方式是：

```c
float a[8192][8192];
float b[8192][8192];
float c[8192][8192];

int main()
{
    for (int i = 0; i < 8192; i++)
        for (int j = 0; j < 8192; j++)
            c[i][j] = a[i][j] + b[i][j];
}
```

使用 `gcc -O1` 編譯，並且 `objdump -d -t` 之後，得到：

```objc
0000000000001125 <main>:
    1125:       48 8d 15 14 2f 00 20    lea    0x20002f14(%rip),%rdx    # 20004040 <a>
    112c:       48 8d 35 0d 2f 00 00    lea    0x2f0d(%rip),%rsi        # 4040 <b>
    1133:       48 8d 0d 06 2f 00 10    lea    0x10002f06(%rip),%rcx    # 10004040 <c>
    113a:       48 8d ba 00 00 00 10    lea    0x10000000(%rdx),%rdi
    1141:       eb 1a                   jmp    115d <main+0x38>
    1143:       48 81 c2 00 80 00 00    add    $0x8000,%rdx
    114a:       48 81 c6 00 80 00 00    add    $0x8000,%rsi
    1151:       48 81 c1 00 80 00 00    add    $0x8000,%rcx
    1158:       48 39 fa                cmp    %rdi,%rdx
    115b:       74 22                   je     117f <main+0x5a>
    115d:       b8 00 00 00 00          mov    $0x0,%eax
    1162:       f3 0f 10 04 02          movss  (%rdx,%rax,1),%xmm0
    1167:       f3 0f 58 04 06          addss  (%rsi,%rax,1),%xmm0
    116c:       f3 0f 11 04 01          movss  %xmm0,(%rcx,%rax,1)
    1171:       48 83 c0 04             add    $0x4,%rax
    1175:       48 3d 00 80 00 00       cmp    $0x8000,%rax
    117b:       75 e5                   jne    1162 <main+0x3d>
    117d:       eb c4                   jmp    1143 <main+0x1e>
    117f:       b8 00 00 00 00          mov    $0x0,%eax
    1184:       c3                      retq
    1185:       66 2e 0f 1f 84 00 00    nopw   %cs:0x0(%rax,%rax,1)
    118c:       00 00 00
    118f:       90                      nop

```

這個程式使用用 `%rdi` 暫存器當成 `i`，`%rax` 當成 `j`，執行兩層迴圈（跟上一個例子類似，只是變成兩曾）。而用 `AVX` 寫的程式如下：

```c
# include <immintrin.h>
float a[8192][8192];
float b[8192][8192];
float c[8192][8192];

int main()
{
    for (int i = 0; i < 8192; i++)
        for (int j = 0; j < 1024; j += 8) {
            __m256 A;
            __m256 B;
            A = _mm256_load_ps (&a[i][j]);
            B = _mm256_load_ps (&b[i][j]);
            B = _mm256_add_ps (A, B);
            _mm256_store_ps (&c[i][j], B);
        }
}
```

使用 `gcc -O1 -mavx` 進行編譯，並且使用 `objdump -t -d` 反組譯後，得到：

```objc
0000000000001125 <main>:
    1125:       48 8d 15 14 2f 00 20    lea    0x20002f14(%rip),%rdx    # 20004040 <a>
    112c:       48 8d 35 0d 2f 00 00    lea    0x2f0d(%rip),%rsi        # 4040 <b>
    1133:       48 8d 0d 06 2f 00 10    lea    0x10002f06(%rip),%rcx    # 10004040 <c>
    113a:       48 8d ba 00 00 00 10    lea    0x10000000(%rdx),%rdi
    1141:       eb 1a                   jmp    115d <main+0x38>
    1143:       48 81 c2 00 80 00 00    add    $0x8000,%rdx
    114a:       48 81 c6 00 80 00 00    add    $0x8000,%rsi
    1151:       48 81 c1 00 80 00 00    add    $0x8000,%rcx
    1158:       48 39 fa                cmp    %rdi,%rdx
    115b:       74 22                   je     117f <main+0x5a>
    115d:       b8 00 00 00 00          mov    $0x0,%eax
    1162:       c5 fc 28 0c 02          vmovaps (%rdx,%rax,1),%ymm1
    1167:       c5 f4 58 04 06          vaddps (%rsi,%rax,1),%ymm1,%ymm0
    116c:       c5 fc 29 04 01          vmovaps %ymm0,(%rcx,%rax,1)
    1171:       48 83 c0 20             add    $0x20,%rax
    1175:       48 3d 00 10 00 00       cmp    $0x1000,%rax
    117b:       75 e5                   jne    1162 <main+0x3d>
    117d:       eb c4                   jmp    1143 <main+0x1e>
    117f:       b8 00 00 00 00          mov    $0x0,%eax
    1184:       c3                      retq
    1185:       66 2e 0f 1f 84 00 00    nopw   %cs:0x0(%rax,%rax,1)
    118c:       00 00 00
    118f:       90                      nop
```

一樣是兩層回圈，只是本來的 `movss`, `addss` 換成了向量運算的 `vmovaps`, `vaddps` 指令。根據官方的說明，可能會預期在 load/store 的時間可以變成原先的 1/8 倍左右。若使用 perf 對編譯出來的結果進行效能測試：

```shell
$ perf perf stat -r 10 -d ./matrix_naive; stat -r 10 -d ./matrix_avx;
```

會得到：

```shell
 Performance counter stats for './matrix_naive' (10 runs):

        171.325308      task-clock (msec)         #    0.999 CPUs utilized            ( +-  0.23% )
                 1      context-switches          #    0.004 K/sec                    ( +- 44.44% )
                 0      cpu-migrations            #    0.000 K/sec                  
           196,658      page-faults               #    1.148 M/sec                    ( +-  0.00% )
       621,283,329      cycles                    #    3.626 GHz                      ( +-  0.17% )  (47.85%)
       731,456,903      instructions              #    1.18  insn per cycle           ( +-  0.20% )  (61.86%)
       129,022,563      branches                  #  753.085 M/sec                    ( +-  0.27% )  (64.08%)
           225,988      branch-misses             #    0.18% of all branches          ( +-  1.05% )  (64.98%)
       238,205,415      L1-dcache-loads           # 1390.369 M/sec                    ( +-  0.24% )  (59.15%)
         5,312,765      L1-dcache-load-misses     #    2.23% of all L1-dcache hits    ( +-  0.74% )  (23.35%)
           105,188      LLC-loads                 #    0.614 M/sec                    ( +-  0.52% )  (23.35%)
            71,016      LLC-load-misses           #   67.51% of all LL-cache hits     ( +-  0.67% )  (35.02%)

          0.171542 +- 0.000401 seconds time elapsed  ( +-  0.23% )

 Performance counter stats for './matrix_avx' (10 runs):

         41.280908      task-clock (msec)         #    0.995 CPUs utilized            ( +-  1.39% )
                 0      context-switches          #    0.002 K/sec                    ( +-100.00% )
                 0      cpu-migrations            #    0.000 K/sec                  
            49,201      page-faults               #    1.192 M/sec                    ( +-  0.00% )
       133,717,861      cycles                    #    3.239 GHz                      ( +-  0.88% )  (44.22%)
        86,337,819      instructions              #    0.65  insn per cycle           ( +-  1.61% )  (63.60%)
        17,418,854      branches                  #  421.959 M/sec                    ( +-  1.32% )  (69.98%)
            66,559      branch-misses             #    0.38% of all branches          ( +-  0.97% )  (70.94%)
        30,976,393      L1-dcache-loads           #  750.381 M/sec                    ( +-  0.58% )  (46.10%)
         1,449,312      L1-dcache-load-misses     #    4.68% of all L1-dcache hits    ( +-  1.25% )  (19.37%)
            44,650      LLC-loads                 #    1.082 M/sec                    ( +-  1.70% )  (19.37%)
            17,809      LLC-load-misses           #   39.89% of all LL-cache hits     ( +- 10.48% )  (29.06%)

          0.041499 +- 0.000581 seconds time elapsed  ( +-  1.40% )

```

上面是有 AVX 的版本，下面是沒有 AVX 的版本。沒有 AVX 的版本，Instruction Per Cycle 是 1.18，而有使用 AVX 的只有 0.65。如果只看這個指標，可能還會以為不用 AVX 的速度比較快。但如果看看 `cycles` 的話，會發現沒使用 AVX 的話，需要 621,283,329 個 cycle，但使用 AVX 的結果卻只有 133,717,861 個，幾乎只有前者的五分之一！而最下方的執行時間，也呈現類似的趨勢：沒有使用 AVX 的時間是 0.171542 秒，而有使用 AVX 則呈現類似趨勢，為 0.041499 秒，大約只有前者的 1/4 。這件事情可以觀察到：==IPC 並不保證程式效能比較高，還有很多因素會影響程式效能。==

那麼，速度可能差在哪呢？可以發現沒有使用 AVX 時，光看 `L1-dcache-loads` ，沒優化的版本比有優化的版本多了 7.6 倍，而 `L1-dcache-load-misses`更多了 3 倍; 另外，`page-faults` 數目也大約是 5 倍。因此，可以推論沒有使用 AVX 時， Load/Store 的負擔較大，使得 panalty 變的更大。

另外， branch 的數目也是將近 7.5 倍，就算優化的版本中， Branch Misses 的積機率稍高，因為基數大大減少的關係，使得 branch miss 的數目反而不如未優化前多。或可推論為「因為需要執行的迴圈次數變得更多，使得 branch 的基數變大，也對效能帶來了衝擊」。

而最後一個因素是 `context-switches`，如果執行時間太久，容易被作業系統換下來，反而雪上加霜。

# Thread Level Parallelism



