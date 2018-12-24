# Parallelalization

# Instruction Level Parallelism

指得是在 CPU 架構設計方面的平行化，讓 CPU 有機會可以讓不同指令重疊執行，進而增加效率。比如說 Pipeline 就是一種 Instruction Level Parallelism 的設計方式。而需要考慮的議題也就是那些之前在 pipeline 中需要考慮的議題：每個 Stage 的設計、Hazard、Branch Prediction 等等。

# Data Level Parallelism

## SIMD

>Vector architectures grab sets of data elements scattered about memory, place them into large, sequential register files, operate on data in those register files, and then disperse the results back into memory.

這個意思是 Single-Instruction Multiple Data。字面上的意思是「用單一一個指令，一次處理很多資料」。比如說如果要把 `float M[256]` 中的內容加到 `float N[256]` 當中。如果是使用一般的作法，最直覺的方法可能會寫出像下面這樣的東西：

```c
for (int i = 0; i < 256; i++) {
	N[i] += M;
}
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

> # Synopsis
>
> `__m256 _mm256_add_ps (__m256 a, __m256 b)`
> `#include <immintrin.h>`
> Instruction: `vaddps ymm, ymm, ymm`
> CPUID Flags: `AVX`
>
> # Description
>
> Add packed single-precision (32-bit) floating-point elements in a and b, and store the results in dst.
>
> # Operation
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

若查詢[Intel 指令的性能實驗值](https://www.agner.org/optimize/instruction_tables.pdf)可以發現，以 Skylake 為例，浮點數加法 `ADDSS` 指令的 Latency 也是 4，throughput 也是 0.5，但這只是「加一個浮點數」需要的時間而已！所以聽起來向量運算超級快嗎？其實也未必。畢竟這件事還得看編譯器的臉色。

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

這段程式編譯之後結果如下：

```objc
0000000100000f70 <_main>:
   100000f70:   55                      push   %rbp
   100000f71:   48 89 e5                mov    %rsp,%rbp
   100000f74:   31 c0                   xor    %eax,%eax
   100000f76:   48 8d 0d 83 00 00 00    lea    0x83(%rip),%rcx        # 100001000 <_a>
   100000f7d:   48 8d 15 9c 00 00 00    lea    0x9c(%rip),%rdx        # 100001020 <_b>
   100000f84:   48 8d 35 b5 00 00 00    lea    0xb5(%rip),%rsi        # 100001040 <_c>
   100000f8b:   0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
   100000f90:   f3 0f 10 04 08          movss  (%rax,%rcx,1),%xmm0
   100000f95:   f3 0f 58 04 10          addss  (%rax,%rdx,1),%xmm0
   100000f9a:   f3 0f 11 04 06          movss  %xmm0,(%rsi,%rax,1)
   100000f9f:   48 83 c0 04             add    $0x4,%rax
   100000fa3:   48 83 f8 20             cmp    $0x20,%rax
   100000fa7:   75 e7                   jne    100000f90 <_main+0x20>
   100000fa9:   31 c0                   xor    %eax,%eax
   100000fab:   5d                      pop    %rbp
   100000fac:   c3                      retq
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
Disassembly of section .text:

0000000100000f90 <_main>:
   100000f90:   55                      push   %rbp
   100000f91:   48 89 e5                mov    %rsp,%rbp
   100000f94:   c5 fc 28 05 64 00 00    vmovaps 0x64(%rip),%ymm0        	# 100001000 <_a>
   100000f9b:   00
   100000f9c:   c5 fc 58 05 7c 00 00    vaddps 0x7c(%rip),%ymm0,%ymm0       # 100001020 <_b>
   100000fa3:   00
   100000fa4:   48 8d 05 95 00 00 00    lea    0x95(%rip),%rax        		# 100001040 <_c>
   100000fab:   c5 fc 11 00             vmovups %ymm0,(%rax)
   100000faf:   31 c0                   xor    %eax,%eax
   100000fb1:   5d                      pop    %rbp
   100000fb2:   c5 f8 77                vzeroupper
   100000fb5:   c3                      retq

```

可以發現：程式當中明顯沒有迴圈出現，取而代之的是 `vmovaps` 指令一次，把整個 `a`跟 `b` 塞分別進去 `ymm0` 跟 `ymm1` 暫存器中，然後將兩個暫存器一次相加，最後把東西塞向 `c` 裡面。

## Thread Level Parallelism



