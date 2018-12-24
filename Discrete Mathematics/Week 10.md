# Week 10

# Generating Function

數列 $\{a_n\}$ 的生成函數定義為以下的表示式：
$$
\sum_{i = 1}^{\infty} a_i x_i
$$

## 例

$$
T(n) = 8T(n - 1) + 10^{n - 1}, T(0) = 1
$$

考慮：
$$
G(x) = \sum_{i = 0}^{\infty}T(i)x^i = T(0) + \sum_{i = 1}^{\infty}T(i)x^i
$$
使用遞迴關係帶入：
$$
G(x) =  T(0) + \sum_{i = 1}^{\infty}T(i)x^i = 1 + \sum_{i = 1}^{\infty}\left[8T(i - 1) + 10^{i - 1}\right]x^i
$$
觀察右式：
$$
\begin{align}
\sum_{i = 1}^{\infty}8T(i - 1) + 10^{i - 1} &= \sum_{i = 1}^{\infty}8T(i - 1)x^i + \sum_{i = 1}^{\infty}10^{i - 1} x^i\newline
&= 8x\sum_{i = 1}^{\infty}T(i - 1)x^{i - 1} + \sum_{i = 1}^{\infty}10^{i - 1} x^i \newline
&= 8x G(x) + \frac {1}{1 - 10x}
\end{align}
$$
帶回原式：
$$
G(x) = 1 + 8x G(x) + \frac {1}{1 - 10x}
$$
解得：
$$
G(x) = \frac {1 - 9x}{(1 - 10x)(1 - 8x)}
$$
為了求出各項係數，進行部分分式：
$$
\begin{align}
G(x) &= \frac {1}{2}\left(\frac {1}{1 - 8x} + \frac {1}{1 - 10x}\right)\newline
&= \sum_{i = 0}^{\infty}\frac {1}{2}(8^i + 10^i)x^i\newline
&= \sum_{i = 0}^{\infty}T(i)x^i
\end{align}
$$
故：
$$
T(i) = \frac {1}{2}(8^i + 10^i)
$$
