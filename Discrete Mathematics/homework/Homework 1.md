# Homework 1

## Problem 1

### 1.

Since $u\to v\equiv \neg u \or v$ , then:
$$
u \or v \equiv (\neg u) \to v
$$
Furthermore, 
$$
\begin{align}
\neg(u \to \neg v) &\equiv \neg(\neg u \or \neg v) \newline
& \equiv u \and v
\end{align}
$$
Thus, all logical statements that can be represented with $\{\neg, \and, \or\}$ can be represented with $\{\to, \neg\}$. Since $\{\neg ,\and, \or\}$ is complete, we've reached the conclusion that $\{\to , \neg\}$ is also complete.  

### 2. 

$\{\and, \or\}$ is not complete. 

`CLAIM` : 

if $f$ is a logical statement composed of $\{\and, \or, \mathbb T, \mathbb F, p\}$ only, where $p$ is arbritrary proposition, then the $f$ can only be equivlaent to：  
$$
\begin{align}
f & \equiv p \newline
f & \equiv \mathbb F \newline
f & \equiv \mathbb T
\end{align}
$$
`Base Case`：Statement hold trivially for the cases where  $f \in \{p, \mathbb T, \mathbb F\}$。

`Induction Step`：Suppose $f_1, f_2$ are logical statements composed of $\{\and, \or, \mathbb T, \mathbb F, p\}$ only, and they can only be equivalent to $p$, $\mathbb T$, or $\mathbb F$, then, by cases analysis, and Idempotent Law of $\and$ and $\or​$, we have： 

</br>

</br>

</br>

</br>

|                   | $f_1 = p$                                                    | $f_1 = \mathbb T$                                            | $f_1 = \mathbb F$                                            |
| ----------------- | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| $f_2 = p$         | $\begin{align}f_1 \and f_2 &= p \and p = p\newline f_1 \or f_2 &= p \or p = p\end{align}$ | $\begin{align}f_1 \and f_2 &= \mathbb T \and p = p\newline f_1\or f_2 &= \mathbb T \or p = \mathbb T\end{align}$ | $\begin{align}f_1 \and f_2 &= \mathbb F\and p = \mathbb F\newline f_1 \or f_2 &= \mathbb F \or p =  p\end{align}$ |
| $f_2 = \mathbb T$ |                                                              | $\begin{align}f_1 \and f_2 &= \mathbb T \and \mathbb T = \mathbb T\newline f_1 \or f_2 &= \mathbb T \or \mathbb T = \mathbb T\end{align}$ | $\begin{align}f_1 \and f_2 &= \mathbb F \and \mathbb T = \mathbb F\newline f_1\or f_2 &= \mathbb F \or \mathbb T = \mathbb T\end{align}$ |
| $f_2 = \mathbb F$ |                                                              |                                                              | $\begin{align}f_1 \and f_2 &= \mathbb F \and \mathbb F = \mathbb F\newline f_1 \or f_2 &= \mathbb F \or \mathbb F = \mathbb F\end{align}$ |

Other cases left blanked also hold, since commutative law holds for $\and$ and $\or$. 

By `CLAIM` above, there's no logical statement $f$ composed of $\{\and, \or, \mathbb T, \mathbb F, p\}$ only such that $f \equiv \neg p$ , since it contradicts to `CLAIM`.

---

以下是老師的解法：

定義：假定 $\phi$ 當中任意的變數，真值由 $0 \to 1$ 時，$\phi$ 的真值永遠不會 $1 \to 0$。

`CLAIM`：用 $\{\and \or\}$ 組成的敘述，只能是 Monotone。

假定 $S$ 是所有用最少連接詞連接的，由 $\{\and, \or \}$組成，非 monotone 的命題形成的集合。但對於任意敘述 $S_1, S_2$：
$$
\begin{align}
S &= S_1 \and S_2 \newline
S &= S_1 \or S_2
\end{align}
$$
都是 monotone。因此矛盾。

## Problem 2

### 1. 

Prove that $[\neg q \and (p \to q)]\to \neg p$ is tautology
$$
\begin{align}
[\neg q \and (p \to q)]\to \neg p & \equiv [\neg q \and (\neg p \or q)]\to \neg p & (\text{implication law}) \newline
& \equiv \neg[\neg q \and (\neg p \or q)]\or \neg p & (\text{implication law}) \newline
& \equiv [\neg(\neg q) \or \neg(\neg p \or q)]\or \neg p & \text{(De Morgan's Law)}\newline
& \equiv [q \or \neg(\neg p \or q)]\or \neg p & \text{(Double Negation Law)}\newline
& \equiv [\neg(\neg p \or q) \or q]\or \neg p & \text{(Commutative Law)}\newline
& \equiv \neg(\neg p \or q) \or (q\or \neg p) & \text{(Associative Law)}\newline
& \equiv \neg(\neg p \or q) \or (\neg p \or q) & \text{(Commutative Law)}\newline
& \equiv \mathbb T& \text{Negation Law}
\end{align}
$$

### 2. 

Prove that $(\neg p \and (q \and r))\or ((\neg p \and q)\and \neg r)$ 	is equivalent to $q \and \neg p$
$$
\begin{align}
原題  &\equiv ((\neg p \and q) \and r)\or ((\neg p \and q)\and \neg r) & \text{(Associative Law)} \newline
& \equiv (\neg p \and q) \or (r \and \neg r) & \text{(Distributive Law)} \newline
& \equiv(\neg p \and q) \or \mathbb F & \text{(Negation Law)} \newline
& \equiv(\neg p \and q)  & \text{(Identity Law)} \newline
& \equiv(q \and \neg p )  & \text{(Comutative Law)} \newline
\end{align}
$$

## Problem 3

### 1. 

Define：
$$
\begin{align}
P(x) &: \text{student $x$ has a person computer}\newline
E(x) &: \text{student $x$ is in EE}\newline
C(x) &: \text{student $x$ is in CS}\newline
c &: \text{Paul}
\end{align}
$$

Then:

| Steps                              | Reason | No |
| ---------------------------------- | ------ | ---- |
| $\forall x(\neg P(x) \to \neg E(x))$ | Premise | 1 |
| $\forall x(C(x) \to P(x))$    | Premise | 2 |
| $E(c) \or C(c)$                 | Premise | 3 |
| $\neg P(c) \to \neg E(c)$ | 1, Universal Instantiation | 4 |
| $C(c) \to P(c)$ | 2, Universal Instantiation | 5 |
| $\neg \neg(P(c)) \or \neg E(c)$ | 4, Implication Law | 6 |
| $P(c) \or \neg E(c)$ | 6. Double Negation Law | 7 |
| $\neg C(c) \or P(c)$ | 5, Implication Law | 8 |
| $C(c)\or E(c)$ | 3, Commutative Law | 9 |
| $P(c) \or E(c)$ | 8, 9 Resolution | 10 |
| $\neg E(c)\or P(c)$ | 7, Commutative | 11 |
| $E(c) \or P(c)$ | 10, Commutative | 12 |
| $P(c) \or P(c)$ | 11, 12, Resolution | 13 |
| $P(c)$ | 13, Idempotent. QED. | 14 |

### 2.

$$
\begin{align}
P &: \text{superman is able to prevent evil}\newline
Q &: \text{superman does prevent evil}\newline
E &: \text{superman exists}\newline
I &: \text{superman is impotent}\newline
L & : \text{It is impossible to learn logic}
\end{align}
$$

then：

| No   | Steps               | Reason                       |
| ---- | ------------------- | ---------------------------- |
| 1    | $P \to Q$           | Premise                      |
| 2    | $\neg P \to I$      | Premise                      |
| 3    | $E \to \neg I$      | Premise                      |
| 4    | $E \to \neg P$      | Premise                      |
| 5    | $\neg E \or \neg I$ | 3, Implication Law           |
| 6    | $\neg I \or \neg E$ | 5, Commutative Law           |
| 7    | $I \to \neg E$      | 6, Implication Law           |
| 8    | $E \to I$           | 4, 2, Hypothetical Syllogism |
| 9    | $E \to \neg E$      | 8, 7, Hypothetical Syllogism |
| 10   | $\neg E \or \neg E$ | 9, Implication Law           |
| 11   | $\neg E$            | 10, Idempotent Law           |
| 12   | $\neg E \or L$      | 11, Addition                 |
| 13   | $E \to L$           | 12, Implication Law. QED     |
|      |                     |                              |

### 3. 

$$
\begin{align}
T(x) &: \text{$x$ lives in Taipei}\newline
D(x) &: \text{$x$ lives within 100 km to the ocean}\newline
F(x) &: \text{$x$ never eats seafood}\newline
\end{align}
$$

Then:

| No   | Steps                       | Reason                             |
| ---- | --------------------------- | ---------------------------------- |
| 1    | $\forall x(T(x) \to D(x))$  | Premise                            |
| 2    | $\exists y(T(y) \and F(y))$ | Premise                            |
| 3    | $T(c) \and F(c)$            | 2, Existential Instantiation       |
| 4    | $T(c) \to D(c)$             | 1, Universal Instantiation         |
| 5    | $T(c)$                      | 3, Simplification                  |
| 6    | $D(c)$                      | 4, 5, Modus Ponens                 |
| 7    | $D(c) \and T(c)$            | 5, 6, Conjunction                  |
| 8    | $\exists z.D(z) \and T(z)$  | 7, Existential Generalization. QED |
|      |                             |                                    |

### 4. 

$$
\begin{align}
D(x) &: \text{$x$ in discrete mathematic class}\newline
S(x) &: \text{$x$ knows calculus}\newline
C(x) &: \text{$x$ knows C++}\newline
p &: \text{Peter}
\end{align}
$$

then

| No   | Step                                 | Reason                      |
| ---- | ------------------------------------ | --------------------------- |
| 1    | $\forall x(D(x) \to S(x))$           | Premise                     |
| 2    | $\forall x(\neg C(x) \to \neg D(x))$ | Premise                     |
| 3    | $S(p) \to \neg C(p)$                 | Premise                     |
| 4    | $D(p) \to S(p)$                      | 1, Universal Instantiation  |
| 5    | $\neg C(p)\to \neg D(p)$             | 2, Universal Instantiation  |
| 6    | $D(p) \to \neg C(p)$                 | 4, 3 Hypothetical Syllogism |
| 7    | $D(p) \to \neg D(p)$                 | 6, 5 Hypothetical Syllogism |
| 8    | $\neg D(p) \or \neg D(p)$            | 7, Implication Law          |
| 7    | $\neg D(p)$                          | 8, Idempotent Law. QED.     |

## Problem 4

### 1. 

$$
\begin{align}
\neg ((p \or q) \and (r \or s)) &\equiv \neg ((r \or s) \and (p \or q)) & \text{(Commutative Law)} \newline
& \equiv\neg(r \or s) \or \neg (p \or q) & \text{(De Morgan's Law)} \newline
& \equiv (\neg r \and  \neg s) \or \neg (p \or q) & \text{(De Morgan's Law)} \newline
& \equiv (\neg r \and  \neg s) \or (\neg p \and \neg q) & \text{(De Morgan's Law)} \newline
& \equiv (\neg s \and \neg r ) \or (\neg p \and \neg q) & \text{(Commutative Law)} \newline
\end{align}
$$

### 2.

$$
\begin{align}
\overline{(A \cup B)\cap (C \cup D)} &\equiv \overline{(A \cup B)}\cup \overline{(C \cup D)} & \text{(De Morgan's Law)} \newline
&\equiv {(\bar A \cap \bar B)}\cup \overline{(C \cup D)} & \text{(De Morgan's Law)}\newline
&\equiv {(\bar A \cap \bar B)}\cup {(\bar C \cap \bar D)} & \text{(De Morgan's Law)}\newline
&\equiv {(\bar A \cap \bar B)}\cup {(\bar D \cap \bar C)} & \text{(Commutative Law)}\newline
&\equiv {(\bar D \cap \bar C)}\cup{(\bar A \cap \bar B)} & \text{(Commutative Law)}\newline
\end{align}
$$

---
實際上的解法是要求把集合定義的敘述轉換成邏輯敘述，接下來再化簡。

## Problem 5

$$
\begin{align}
2^{S_1} &= \{\varnothing, \{\{1, 2\}\}\}\newline
2^{S_2} &= \{\varnothing\}
\end{align}
$$

# Collaborators & Reference

我是外系邊緣人，所以沒有跟人一起討論作業，也沒有 Reference。