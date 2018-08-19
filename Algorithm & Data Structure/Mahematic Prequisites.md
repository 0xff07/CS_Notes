# Mathematic Foundations

## Floors & Ceilings

$$
\lfloor x \rfloor = \max \{ n \in \mathbf{Z}, n \leq x  \}
$$

$$
\lfloor x \rfloor = \min \{ n \in \mathbf{Z}, n \geq x  \}
$$

### 性質

$$
x - 1 < \lfloor x \rfloor \leq x \leq \lceil x \rceil< x + 1
$$

$$
\forall n \in \mathcal {z}. \lfloor n \rfloor + \lceil n \rceil = n
$$

$$
\forall a, b \in \mathbf{N}.\ \left\lfloor \frac {a}{b} \right\rfloor \geq \frac {a - (b - 1)}{b}
$$

$$
\forall a, b \in \mathbf{N}.\ \left \lceil \frac {a}{b}\right\rceil \leq \frac {a + (b - 1)}{b}
$$

$$
\forall x \geq 0.\ \forall a, b \in \mathbf{N}.\left\lceil\frac { \left\lceil\frac {x}{a}\right\rceil}{b}\right\rceil=  \left\lceil\frac {x}{ab}\right\rceil
$$

$$
\forall x \geq 0.\ \forall a, b \in \mathbf{N}.\left\lfloor\frac { \left\lfloor\frac {x}{a}\right\rfloor}{b}\right\rfloor=  \left\lfloor\frac {x}{ab}\right\rfloor
$$

## mod

對應整數除法的部分：


$$
a\mod n = a - n \lfloor a/n \rfloor
$$
因此：


$$
0 \leq a \mod n < n
$$




## Exponentials & Logarithms

因為高中就教過了所以省略。

Remark：

1. 在這本書中使用的符號是：

   $$
   \begin{align}
   & lg ^k n := (\lg n)^k \newline
   \newline
   & lg ^{(k)} n := \underbrace{\lg \lg ... \lg}_{k 次}\ n \newline
   \end{align}
   $$

2. 有一個近似是
  $$
  \frac {x}{1 + x} \leq \lg (1 + x) \leq x
  $$

3.  iterated logarithm function ($\lg^*$)

	
	$$
	\lg^*n := min\{i \geq 0 : lg^{(i)}n \leq 1\}
	$$
	白話文有點像是問：

	
	$$
	2^{2^{2^{.^{.}}}}
	$$
	要做幾次之後才會比 1 小。

## Factorial

大部分微積分都教過，除了最強大的史特林公式：



$$
n! = \sqrt{2 \pi n} \left(\frac {n}{e}\right)^{n}\left(1 + \Theta \left(\frac {1}{n}\right)\right) = \sqrt{2 \pi n} \left(\frac {n}{e}\right)^{n}e^{\alpha_n}
$$



其中：

$$
\frac {1}{12n + 1}<\alpha_n < \frac {1}{12n}
$$

另外微積分有一些有用的結論，比如說當 n 夠大時：

$$
(n!)^2 >> n^n >> n! >> r^n >> n^{\epsilon} >> (\lg n)^{a}
$$
其中 $\epsilon > 0$, $a > 0$。另外微積分有教到級數也有一些審斂法，可以參考。