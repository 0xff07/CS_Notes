# 集合

## Def (Notation of Set)

集合可以用窮舉的方式列出：
$$
S = \{a, b, c\} = \{c, b, a\}
$$
或是使用描述的：
$$
S = \{x \mid x \in \mathbb N, x \text{ is a prime}\}
$$

------

常用的符號慣例：
$$
\mathbb N = \{0, 1, 2 \dots\}
$$
自然數有很多定義。這裡採用 0 是自然數的定義。
$$
\mathbb Z : \text{set of all integers.}
$$

$$
\mathbb Z^+ = \{1, 2, 3 \dots\}
$$

$$
\mathbb Q : \text{rational numbers}
$$

$$
\mathbb Q^+ : \text{positive real numbers}
$$

------

## Def (Set Operations)

假定 $A, B$ 是集合，則：
$$
\begin{align}
A \cup B &= \{x \mid (x \in A) \or (x \in B) \}\newline
A \cap B &= \{x \mid (x \in A) \and (x \in B) \}\newline
\bar{A} &= \{x \mid x \not \in A\} \newline
\phi &= \{x \mid \mathbb F \} \newline
\mathbb U &= \{x \mid \mathbb T\}
\end{align}
$$

------

最下面 2 條是空集合與宇集合的定義。

------

### Observation (Venn Diagram)

判斷兩個集合是否等價，常用文氏圖。

### Observation (證明集合相等)

也可以用證明的方式證明兩個集合相等：
$$
\begin{align}
\overline{A \cup B} &= \{x \mid x \not \in A \cup B\} \newline
&= \{x \mid \neg (x \in A \cup B)\} \newline
&= \{x \mid \neg ((x \in A) \or (A \in B))\} \newline
&= \{x \mid \neg(x \in A) \and \neg (x \in B)\} \newline
&= \{x \mid (x \in \bar{A}) \and (x \in \bar B)\}
\end{align}
$$

### Observation (集合運算與邏輯相對應)

$$
\begin{cases}
\cup & \iff \or \newline
\cap & \iff \and \newline
- & \iff \neg \newline
\mathbb U &\iff \mathbb T\newline
\phi & \iff \mathbb F
\end{cases}
$$

------

## Def (Cardinality)

一個集合 $A$ 的 Cardinality ，用 $|A|$ 表示，定義為，$A$ 中元素的個數。

------

例：
$$
|\{1, 2, 3\}| = 3
$$

### Thm (Principle of Inclusion and Exclusion)

$$
\begin{align}
\left | \bigcup_{i = 1}^N A_i \right| = \sum_{i = 1}^N |A_i| - \sum_{i_1 \neq i_2 \leq N} |A_{i_1} \cap A_{i_2}| + \sum_{i_1 \neq i_2 \neq i_3 \leq N} |A_{i_1} \cap A_{i_2} \cap A_{i_3}|\dots + (-1)^{n + 1} \left|\bigcap _{i = 1}^N A_i\right|
\end{align}
$$

------

假定 $x$ 出現在 $r$ 個 $A_i$ 集合中，則左式中 $x$ 被計數了一次，右式被計數了：
$$
C^{r}_1 - C^{r}_2 + C^{r}_3 \dots (-1)^{r + 1} C^{r}_r = 1-(1 - 1)^r
$$

------

## Def (Function)

假定 $A, B$ 是集合，假定 $f$ 指定一個 $b\in B$ 給任意 $a \in A$，則稱 $f$ 為一個 $A$ 到 $B$ 的函數。表示為：
$$
f : A \to B
$$
其中 $A$ 稱作 $f$ 的「定義域」(Domain)，$B$ 稱作 $f$ 的對應域 (Codomain)。 

------

### Def (Injective, Surjective, Bijective)

假定 $f : A \to B$，則：
$$
\begin{align}
\text{$f$ is injective} & \iff \forall a_1 , a_2 \in A, a_1 \neq a_2. f(a_1) \neq f(a_2) \newline
\text{$f$ is surjective} & \iff \forall b \in B.\exists a \in A.f(a) = b \newline
\text{$f$ is bijective} & \iff f \text{ is both injective and surjective} \newline
\end{align}
$$

## Def (Compare Cardinality of Sets 1)

假定 $A, B$ 是集合。則：
$$
\begin{align}
|A| \geq |B| &\iff \exists f:A\to B.f\text{ is surjective} \newline
|A| \leq |B| &\iff \exists f:A\to B.f\text{ is injective} \newline
|A| = |B| &\iff \exists f:A\to B.f\text{ is bijective} \newline
\end{align}
$$

------

如果 $A, B$有限，可以用鴿籠原理直接等價於元素個數。如果 $A, B$ 無限，這個定義可以直接延伸到無限集合。

------

### Observation

$$
\begin{align}
|\mathbb N| &= |\mathbb Z^+| \newline
|\mathbb Z^+| &= |2\cdot\mathbb Z^+| \newline
|\mathbb N| &= |\mathbb Z| 
\end{align}
$$

------

`1`：
$$
f : \mathbb N \to \mathbb Z^+ \text{ where } f(x) = x + 1
$$
`2`
$$
f : \mathbb Z^+ \to 2\cdot \mathbb Z^+ \text{ where } f(x) = 2x
$$
`3`
$$
f:\mathbb N \to \mathbb Z \text{ where }f(x) = \begin{cases}
\frac {n}{2} & \text {if $n$ is even} \newline
-\frac {n + 1}{2} & \text{otherwise}
\end{cases}
$$

## Def (Compare Cardinality of Sets 2)

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

### Thm (Cardinality of Powerset)

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

