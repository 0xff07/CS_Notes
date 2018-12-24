# Week 11

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
則稱 $R$ 是一個 $A$ 上的集合

---

###  Def (Reflexive)

假定 $R \subseteq A \times A$，且滿足：
$$
\forall a \in A.(a,a) \in R
$$
則稱 $R$ 為 Reflexive

---

Remark：寫成矩陣表示法寄售「主對角線都必須為 1」。

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

「一個 relation 是 transitive」和下面幾種敘述等價：

1. 如果兩點 $u, v$ 有長度為 2 的 path ，則 $(u, v) \in R$
2. 如果任兩點 $u, v$ 聯通，則 $(u, v) \in R$



## Def (Closure)

$R \in A \times A$，假定 $S$ 滿足：

1. $S$ 是 Reflexive
2. $R \subseteq S$
3. $S$ 是滿足 1. 2. 的最小 relation，即：若有 $S'$ 滿足 1. 2.，則 $S' \subseteq S$

