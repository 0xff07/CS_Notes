# Relation

## Def (Relation)

一個「關係」(relation) 是個集合：
$$
A \times B = \{(a, b) \mid a \in A, b \in B\}
$$
的子集。

---

`1`

有兩種表示法。第一種是用矩陣，概念就像 Adjacenct Matrix 一樣。假定 $R$ 是一個 relation，定義：
$$
M_{ij} = \begin{cases}
1 & \text{if }(a_i, b_j) \in R \newline
0 & \text{if }(a_i, b_j) \not\in R
\end{cases}
$$
另外一種是用圖。不過都寫出矩陣了，圖應該不難想像。

`2`

因為是集合，所以集合定義的運算都可以做到 ($\cup \cap -\dots$)。另外，函數也只是 relation 的一種，因此 relation  也有一部分跟函數很像的運算。

### Def (Composition of Relations)

假定 $S \subset A \times B, S \subset B \times C$ 是兩個 relation。則
$$
S \circ R := \{(a, c) \mid \exist b .(a,b) \in R \text{ and }(b,c) \in S\}
$$
稱作 $S, R$ 的 composition。

---

每一個 $(a, c)$ 的中介 $b$ 不一定是唯一的。

---

### Observation (Matrix Representation of Relation Composition)

$$
M_{S \circ R} = M_R \circ M_{S}
$$

其中兩個矩陣的 $\circ$ 是指：把兩個矩陣相乘，把所有非 0 元素改成 1。

---

## Def (Relation on a Set)

如果一個 relation $R$ 滿足：
$$
R \subseteq A \times A
$$
則稱 $R$ 是一個 $A$ 上的 Relation

---

###  Def (Reflexive)

假定 $R \subseteq A \times A$，且滿足：
$$
\forall a \in A.(a,a) \in R
$$
則稱 $R$ 為 Reflexive

---

Remark：寫成矩陣表示法就是「主對角線都必須為 1」。

---

### Def (Symmetric)

假定 $R \subseteq A \times A$，且滿足：
$$
(a, b) \in R \iff (b, a) \in R
$$
則稱 $R$ 為 symmetric。

---

Remark：寫成矩陣表示法就是「$M_R$ 是對稱矩陣」。

---

### Def (Antisymmetric)

$$
(a, b) \in R \and (b,a) \in R \Rightarrow a = b
$$

---

Remark：就是除了對角線之外，對稱的元素都要是 0 - 1 或 1 - 0。比如：
$$
R_{div} = \left\{(a,b) \mid \frac {b}{a} \in \mathbb Z\right\}
$$

---

### Def (Transitive)

$$
(a, b) \in R \and (b, c) \in R \Rightarrow (a, c) \in R
$$

---

### Thm (Transitive and Graph)

下面幾種敘述等價：

1. 一個 relation 是 transitive
2. 如果兩點 $u, v$ 有長度為 2 的 path ，則 $(u, v) \in R$
3. 如果任兩點 $u, v$ 聯通，則 $(u, v) \in R$

---

「$1 \Rightarrow 2$」：定義下去爆開就解決了。

「$2 \Rightarrow 3$」：任兩點連通，表示存在一個 path。對於 Path 的長度歸納就解決了。

「$3 \Rightarrow 1$」：若 $(a, b) \in R, (b, c) \in R$，則顯然 $a, b, c$  是一個 $a$ 到 $c$ 的路徑。因此 $a, c$ 連通，由 `3` 知 $(a, c) \in R$，但這個結論推出來後就發現 $R$ 是 transitive。

# Def (Closure)

$R \in A \times A$，假定 $S$ 滿足：

1. $S$ 滿足性質 A
2. $R \subseteq S$
3. $S$ 是滿足 1. 2. 的最小 relation，即：若有 $S'$ 滿足 1. 2.，則 $S' \subseteq S$

則稱 $S$ 是一個 A - Closure。

---

## Thm (Reflexive Closure)

給定 $R \subseteq A \times A$，則 $R$ 的 reflexive closure 是：
$$
R \cup \Delta
$$
其中：
$$
\Delta = \{(a, a) \mid \forall a \in A\}
$$

---

## Thm (Symmetric Closure)

給定 $R \subseteq A \times A$，則 $R$ 的 symmentric closure 是：
$$
R \cup R^{-1}
$$
其中：
$$
R^{-1} = \{(a, b) \mid (b, a) \in R\}
$$
Q : 要怎麼證明這是 minimal ?

---

## Thm (Transitive Closure)

假定 $R \subseteq A \times A$，則集合：
$$
S = \{(a, b) \mid (a\in R) \and (b \in R) \and  (\exists p. a \overset{p}{\leadsto}b)\}
$$

---

`TRANSITIVITY`

對於 $S$ 裡面的任意 $(a, b), (b, c)$，顯然 $a$ 和 $c$ 聯通，因此$(a, c ) \in S$。故 $S$ 為 transitive

`R is subset of S`

假定 $(a, b) \in R$，但顯然 $(a, b)$ 就是一個 $a$ 往 $b$ 的路徑，因此 $(a, b) \in S$。

`MINIMAL`

假定 $S_1$ 是 transitive，且 $S_1 \subseteq R$，則對於任意 $(a, b) \in S$，僅證 $(a, b) \in S_1$ 即可。

又：
$$
\begin{align}
(a, b) \in S & \Rightarrow  a \overset{p_1}{\leadsto} b & p_1 \subseteq R \newline
& \Rightarrow  a \overset{p_2}{\leadsto} b & p_2 \subseteq S_1\newline
&\Rightarrow (a,b) \in S_1
\end{align}
$$

---

### Observation 

$$
S = \bigcup_{i = 1}^{\infty}R^{i}
$$

其中：
$$
R^i = \begin{cases}
R & \text{if }i = 1 \newline
R \circ R^{i-1} & \text{if }i > 1 
\end{cases}
$$

### Observation

假定：
$$
S' = \{(a, b) \mid a \overset{p}{\leadsto}b \and \text{len}(p) \leq |A|\and p \subseteq R\}
$$
則：
$$
S' = S
$$

---

因為「有路徑就有最短路徑」，最短路徑最多又只有 $V(R)$ 個頂點。

### Observation

$$
S = \bigcup_{i = 1}^{n}R^i
$$

---

上一個 Observation 的直接結果。

---

# Equivalence Relation

## Def (Equivalence Relation)

假定 $R \subseteq A \times A$ 均滿足 1) reflexive 2) transitive 3)symmentric，則稱 $R$ 是一個 ==equivalence relation==

---

例：$R_{\equiv 3} = \{(a, b) \mid a \equiv b (\text{mod }3)\} \subseteq \mathbb N \times \mathbb N$ 

例：$R = \{(a,b) \mid a - b \in \mathbb Z\}\subseteq \mathbb N \times \mathbb N$

---

## Def (Equivalence Class)

假定 $R$ 是一個 equivlence relation，則 Equivalence of an element $a$ 定義為：
$$
[a]_{R} = \{s \mid (a,s) \in R\}
$$

---

會是 square matrix with diagonal blocks of all ones

## Thm (Equivalence Class)

假定 $R$ 是一個 equivalence relation，則以下敘述等價：
$$
\begin{cases}
(a,b) \in R \newline
[a]_R = [b]_R \newline
[a]_R \cap [b]_R \neq \phi
\end{cases}
$$

---

「1 -> 2」：
$$
(a,b) \in R \Rightarrow (b, a) \in R
$$
而：
$$
\forall s \in [a]_R. (a,s) \in R
$$
因此：
$$
\forall s \in R.(b,s) \in R \iff s \in [b]_{R}
$$
「2 -> 3」：trivial

「3 -> 1」：課本有寫

---

# Partial Ordering

## Def (Equivalence Relation)

假定 $R \subseteq A \times A$ 均滿足 1) reflexive 2) transitive 3)==anti==symmentric，則稱 $R$ 是一個 ==partial ordering==。其中

1. $(a, b) \in R$，用 $a \preceq b$ 表示

2. $(a, b) \in R, a \neq b$ 用 $a \prec b$ 表示

---

例：$R = \{(a, b) \mid a \leq b\} \subseteq \mathbb Z^+ \times \mathbb Z^+$

例：$R = \{(a, b) \mid \frac {b}{a} \in \mathbb N\} \subseteq \mathbb Z^+ \times \mathbb Z^+$

---

### Def (Minimal & Maximal)

1. 假定：
   $$
   \not \exists b.b \prec a
   $$
   則稱 $a$ 是 Maximal

2. 假定：
   $$
   \not \exists b. a \prec b
   $$
   則稱 $a$ 是 Minimal

3. 假定：
   $$
   \forall b.b\preceq a
   $$
   則稱 $a$ 是 greatest element

4. 假定：
   $$
   \forall b.a \preceq b
   $$
   則稱 $a$ 是 least element

### Lemma

假定 $R \subseteq A \times A$ 是個 partial ordering，且 $|A| < \infty$。則 `minimal element` 存在。

---

反證：假定這個元素不存在，則對於任意元素都可以找到比他小的。但 $|A|$ 有限，故矛盾。

## Observation (Elements can be Sorted by Partial Ordering)

---

## Def (Hasse Diagram)

> Hard to draw with computer. Reference the textbook please.

---

# Def (Total Ordering)

假定 $T$ 是一個 partial ordering，且：
$$
\forall a,b.(a,b) \in T \text{ or } (b,a) \in T
$$

---

## Def (Compatable)

假定 $T$ 是一個 total ordering, $R$ 是一個 partial ordering。若：
$$
R \subseteq T
$$
則稱 $R$ 是 compatible