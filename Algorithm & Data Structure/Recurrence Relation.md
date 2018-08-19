# Recursion

1. 例子
2. 歸納法
3. 一般式解法
4. 複雜度計算（3 種方法）



[Berkley 數學系的介紹](https://math.berkeley.edu/~arash/55/8_2.pdf)

把遞迴定義數列的一般式找出來的幾個方法。

## 用猜的，事後補證明。

例子：
$$
\begin{cases}S(n) = 2 S(n - 1) \newline
S(1) = 2
\end{cases}
$$
可以觀察：


$$
\begin{align}S(n) &= 2S(n-1)\newline
&=2 \cdot 2 S(n - 2) \newline
&=2 \cdot 2 \cdot 2S(n - 3)\newline
& . 
\newline
& . 
\newline
&= 2^{n-1}S(1)= 2^{n}\end{align}
$$
因此猜測：



​	


$$
S(n) = 2^n\ \ \ \ \  \forall n \in N
$$
接著證明滿足上述給定的定義：


$$
\begin{cases}S(1) = 2^1 = 2\newline
S^{n} = 2^n = 2 \cdot 2^{n-1} = 2\cdot S(n-1)
\end{cases}
$$
因此這確實是 S(n) 的一個一般式。



## 特殊案例

$$
S(n) = c \cdot S(n-1) + g(n)
$$

可以使用類似的方式展開：


$$

$$

$$
\begin{align}S(n) &= c S(n-1) + g(n)\newline
&=c \cdot c S(n - 2) + cg(n-1) + g(n)\newline
&=c \cdot c \cdot cS(n - 3) + c^2g(n-2) + cg(n-1) + g(n)\newline
& . 
\newline
& . 
\newline
&= c^{n-1}S(1) + \sum_{i = 2}^{n}c^{n - i}g(i)\end{align}
$$

最後帶回可以證明這個確實滿足原來的定義（待證）。

## Linear Homo Recursion

這邊考慮形如：
$$
a_n = c_{1}a_{n-1} + c_2 a_{n-2} + .. + c_k a_{n-k}
$$
的遞迴關係。



## Solution

1. 令：

	$$
	P(t) = t^{k} - (c_1 t^{k-1} + c_2 t^{k-2} + ... + c_k)
	$$
	
2. 解：

	$$
	P(t) = 0
	$$
	
	之根。假定根為：
	
	$$
	r_1 ... r_l
	$$
	
	且重數為：
	
	$$
	m_1 ... m_l
	$$

	則：
	
	$$
	a_n = \sum_{i = 1}^{l} P_{i}(n)\cdot r_i^{n}
	$$

	其中 $P_{k}(n)$ 是 $m_k - 1$ 次多項式。

### Observation 1

數列$\{1, r, r^2, ... r^n, ...\}$滿足 $a_n = c_{1}a_{n-1} + c_2 a_{n-2} + .. + c_k a_{n-k}$$\iff$

 $r$ 滿足 $r^k - c_1r^{k-1} -c_2 r^{k-2} ... - c_{k-1} r - c_{k} = 0 $



**Remark**：$t^k - c_1t^{k-1} -c_2 t^{k-2} ... - c_{k-1} t- c_{k}$ 稱作 ${a_n}$ 的特徵多項式。



### Lemma 1

假定
$$
\begin{cases}
\{\alpha_{1,n}\} = a_{11}, a_{12},  ... \newline
\{\alpha_{2,n}\} = a_{21}, a_{22},  ...\newline
...\newline
\{\alpha_{k,n}\} = a_{k1}, a_{k2} , ...\newline
\end{cases}
$$
均為：
$$
a_n = c_{1}a_{n-1} + c_2 a_{n-2} + .. + c_k a_{n-k}
$$
的解，則：



$$$$

 的特徵多項式有

