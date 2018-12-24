# Week 12

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

## Thm 

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

# Partial Ordering

## Def (Equivalence Relation)

假定 $R \subseteq A \times A$ 均滿足 1) reflexive 2) transitive 3)==anti==symmentric，則稱 $R$ 是一個 ==equivalence relation==。其中

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



   則稱 $a​$ 是 greatest element

4. 假定：
   $$
   \forall b.a \preceq b
   $$
   則稱 $a$ 是 least element

### Lemma

假定 $R \subseteq A \times A$ 是個 partial ordering，且 $|A| < \infty$。則 `minimal element` 存在。

---

反證：假定這個元素不存在，則對於任意元素都可以找到比他小的。但 $|A|$ 有限，故矛盾。

### Thm (Partial Ordering can be Sorted)

---

### Representation of Partial Ordering

## Def (Total Ordering)

假定 $T$ 是一個 partial ordering，且：
$$
\forall a,b.(a,b) \in T \text{ or } (b,a) \in T
$$

### Def (Compatable)

假定 $T$ 是一個 total ordering, $R$ 是一個 partial ordering。若：
$$
R \subseteq T
$$
則稱 $R$ 是 compatible