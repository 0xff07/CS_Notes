# Week 4

## Def

$$
\begin{cases}
|A| \neq |B| \iff \not \exists f:A\to B.f\text{ surjective} \newline
|A| > B \iff |A| \geq |B| \and |A| \neq B \newline
|A| < B \iff |A| \leq |B| \and |A| \neq B
\end{cases}
$$

## Def (Countable)

$$
S \text{ is countable} \iff |S| < \infty \text{ or }|S| = \|\mathbb N\| 
$$

---

可數 = 有限的集合 或 最小的無限集合。

### Thm (Smallest Infinite Cardinality)

$$
\forall S,|S| < \infty.|S| \geq |\mathbb N|
$$

---

$$
\begin{cases}
a_0 \in S \overset{f}{\rightarrow} 0 \newline
a_0 \neq a_1 \in S  \overset{f}{\rightarrow} 1 \newline
a_0 \neq a_2, a_1 \neq a_2 \in S  \overset{f}{\rightarrow} 2 \newline
\dots
\newline
\end{cases}
$$

因為列出來的 mapping 數目剛好和正整數的數目一樣多，所以剛好把所有正整數對應完。因此 $|S| \geq |\mathbb N|$。

實際上需要假定「選完有限數目的元素之後，永遠可以找到下一個相異的元素」。

---

### Corollary (Countability of Positive Rational Numbers)

$$
\mathbb Q^+ \text{ is countable}
$$

---

把所有有理數列出來：

![main-qimg-62c544944228bbb033739dea63e7c4f1](/Users/0xf0/.2018Q3/Descrete Mathematics/Week 4.assets/main-qimg-62c544944228bbb033739dea63e7c4f1.png)

如下構造 $f : \mathbb N \to \mathbb Q^+$：$f(i)$ = 沿著方向數，有重複數到就跳過。數到第 $i$ 個相異的有理數，就是 $f(i)$ 。因為所有相異的整數都對應到相異的有理數，因此為 1-1。又因為所有有理數都被列舉出來，因此 onto。故 $f$ 是 1-1 onto。

實際上也可以不要跳過重複的數。這時 $f$ 只保證 onto，所以 $|\mathbb N| \geq |S|$，但前面已經證明 $|\mathbb N| \leq |S|$，合起來得到 $|\mathbb N|  = |S|$。

---

## Thm (Uncountability of Real Number)

$$
[0,1] \text{ is not countable}
$$

---

僅證：
$$
\forall f:\mathbb N \to [0,1].f\text{ is not onto}
$$
即可。但證法大家都知道。就是對角線證法。先挑一堆
$$
\begin{align}
f(0) &= 0.111111\dots\newline
f(1) &= 0.123456\dots \newline
f(2) &= 0.000000\dots\newline
f(3) &= 0.999999\dots\newline
\dots &= \dots
\end{align}
$$
並且構造 $x$，$x$ 是所有對角線元素 
$$
\begin{align}
f(0) &= 0.\underline111111\dots\newline
f(1) &= 0.1\underline23456\dots \newline
f(2) &= 0.00\underline0000\dots\newline
f(3) &= 0.999\underline999\dots\newline
\dots &= \dots
\end{align}
$$
然後通通換上一個相異的數字。這樣就可以構造出一個不在 $f(\mathbb N) $ 的數字。

這個證明有一個細節：要把數字換成超過原來數字 2 的數字。不然就會有：
$$
0.59999999\dots = 0.6000000
$$
的問題。這時就有可能對到同樣的數字。去翻數學之美投影片。

---

## Def (Powerset)

假定 $S$ 是一個集合，則 $S$ 的 powerset：
$$
2^S = \{a \mid a \subseteq S\}
$$

---

如：假定 $S = \{a, b\}$，則：
$$
2^S = \{\varnothing,\{a\}, \{b\}, \{a, b\}\}
$$

---

## Thm (Cardinality of Powerset)

對於任意集合 $S$：
$$
|S| \neq |2^S|
$$

---
對於任意 $f:S \to 2^S$，都可以構造出一個沒被 $f$ map 到的集合。構造法如下：

$$
B = \{e \in S \mid e \not \in f(e)\}
$$

則顯然 $B \in 2^S$。接下來證明 $\not\exists a \in S.f(a) = B$ 。證法是反証，假定 $f(a) = B$：

CASE：$a \not\in B$

則由 $B$ 的定義：$a \in f(a) =B$，矛盾。

CASE：$a \in B$

則由 $B$ 集合的定義立刻知道 $a \not \in f(a) = B$。 又矛盾。

