# Week 3 - 2

## Def (Notation of Set)

集合可以用窮舉的方式列出：
$$
S = \{a, b, c\} = \{c, b, a\}
$$
或是使用描述的：
$$
S = \{x \mid x \in \mathbb N, x \text{ is a prime}\}
$$

---

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

---

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

---

最下面 2 條是空集合與宇集合的定義。

---

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

---

## Def (Cardinality)

一個集合 $A$ 的 Cardinality ，用 $|A|$ 表示，定義為，$A$ 中元素的個數。

---

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

---

假定 $x$ 出現在 $r$ 個 $A_i$ 集合中，則左式中 $x$ 被計數了一次，右式被計數了：
$$
C^{r}_1 - C^{r}_2 + C^{r}_3 \dots (-1)^{r + 1} C^{r}_r = 1-(1 - 1)^r
$$

---

## Def (Function)

假定 $A, B$ 是集合，假定 $f$ 指定一個 $b\in B$ 給任意 $a \in A$，則稱 $f$ 為一個 $A$ 到 $B$ 的函數。表示為：
$$
f : A \to B
$$

其中 $A$ 稱作 $f$ 的「定義域」(Domain)，$B$ 稱作 $f$ 的對應域 (Codomain)。 

---

### Def (Injective, Surjective, Bijective)

假定 $f : A \to B$，則：
$$
\begin{align}
\text{$f$ is injective} & \iff \forall a_1 , a_2 \in A, a_1 \neq a_2. f(a_1) \neq f(a_2) \newline
\text{$f$ is surjective} & \iff \forall b \in B.\exists a \in A.f(a) = b \newline
\text{$f$ is bijective} & \iff f \text{ is both injective and surjective} \newline
\end{align}
$$

## Def (Compare Cardinality of Sets)

假定 $A, B$ 是集合。則：
$$
\begin{align}
|A| \geq |B| &\iff \exists f:A\to B.f\text{ is surjective} \newline
|A| \leq |B| &\iff \exists f:A\to B.f\text{ is injective} \newline
|A| = |B| &\iff \exists f:A\to B.f\text{ is bijective} \newline
\end{align}
$$

---

如果 $A, B$有限，可以用鴿籠原理直接等價於元素個數。如果 $A, B$ 無限，這個定義可以直接延伸到無限集合。

---

### Observation

$$
\begin{align}
|\mathbb N| &= |\mathbb Z^+| \newline
|\mathbb Z^+| &= |2\cdot\mathbb Z^+| \newline
|\mathbb N| &= |\mathbb Z| 
\end{align}
$$

---

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

