# Propositional Logic



## Def (Proposition)

A __proposition__ is a declarative sentence denoted by proposition variables, e.g. $p, q, r, s$. Each variable can either be TRUE or FALSE. For convenience, TRUE is often denoted by $1$, while FALSE is denoted by $0$.

e.g.
$$
p : \text{ It is raining}
$$
Is p proposition.
$$
\text{How do you do ?}
$$
is not a proposition, for the truth value cannot be determined.



## Def (Connectors)

Connectors can be defined by truth table : 

| $p$      | $q$    | $\neg p$ |$p \or q$ |$p \and q$ |$p \to q$ |$p \leftrightarrow q$|$p \oplus q$|$p | q$|$p \downarrow q$|
| --- | --- | --- |---|---|---|---|---|---|---|
| 0       |   0   |    1      |0|0|1|1|0|1|1|
|  0      |    1  |     1     |1|0|1|0|1|1|0|
|   1     |    0  |      0    |1|0|0|0|1|1|0|
|    1    |    1  |       0   |1|1|1|1|0|0|0|

> For implication, whenever p is TRUE, q must be TRUE. Otherwise the truth value can be anything.

>NAND and NOR is litterary "NOT p AND q" and "NOT p OR q", repectively.

More symbols can be defined, e.g. 

$$
 M(p, q, r) = \begin{cases}
 1 &\text{ if 2 or more of p, q, r is true} \newline
 0 & \text{ otherwise}
 \end{cases}
$$

However, too many symbol may looks clumsy and may not be necessary.


### Def (Tautology)

A __tautology__ is a proposition that is always TRUE, no matter what the truth values of its variables are.

e.g.
$$
p \or (\neg p)
$$
is a tautology.

### Def (Contradiction)

A __contradiction__ is a proposition that always yields FALSE, no matter what the truth values of its variables are.

e.g.
$$
p \and (\neg p)
$$
is a contradiction.

## Def (Equivalent)

Propositions $x$ and $y$ are equivalent, denoted by $x \equiv y$, is defined as：
$$
x \equiv y \iff x \leftrightarrow  y \text{ is a tautology}
$$
e.g.
$$
p \or q \equiv q \or p
$$

### Observation (Verification of Equivalent propositions)

We can use truth table to verify wether two propositions are equivalent. For example : 

| p    | q    | $p \or q$ | $q \or p$ |
| ---- | ---- | --------- | --------- |
| 0    | 0    | 0         | 0         |
| 0    | 1    | 1         | 1         |
| 1    | 0    | 1         | 1         |
| 1    | 1    | 1         | 1         |

## Def (Equivalent Rules)

### Commutative Rules

$$
\begin{align}
p \or q \equiv q \or p \newline
p \and q \equiv q \and p
\end{align}
$$

### Identity

$$
\begin{align}
p \and 1 &\equiv p \newline
p \or 0 &\equiv p
\end{align}
$$

### Associative

$$
\begin{align}
(p \or q) \or r & \equiv p \or (q \or r)\newline
(p \and q)\and r & \equiv p \and (q \and r)
\end{align}
$$

### Destributive

$$
\begin{align}
p \and (q \or r) &\equiv (p \and q) \or (p \and r) \newline
p \or (q \and r) &\equiv (p \or q) \and (p \or r)
\end{align}
$$

### De Morgan's Rule

$$
\begin{align}
\neg(p \or q) &\equiv\neg p \and \neg q \newline
\neg(p \and q) &\equiv\neg p \or \neg q
\end{align}
$$

### Remark

There's a correspondence between operators in Boolean Algebra and formal logic :
$$
\begin{cases}
\and \Rightarrow\cdot\newline
\or \Rightarrow + \newline
\mathbb T \Rightarrow 1 \newline
\mathbb F \Rightarrow 0
\end{cases}
$$
which makes most of the equivalent rules look obvious in arithmetic sense：
$$
\begin{align}
(p + 0) &= p\newline
(p \cdot 1) &= p \newline
p(q + r) &= p\cdot q + p\cdot r
\end{align}
$$
However, some rules may look counterintuitive. For example the destributive law becomes：
$$
p + q\cdot r = (p + q)(p + r)
$$

## Proof of Equivalent Propositions

Enumerating truth value of variables may be tedeous. Another way to prove two logic statements are equivalent is going step by step through equivalent rules. For example：

$$
\neg(p \or (\neg p \or q))\equiv \neg p \or \neg q
$$

can be proved by following steps: 
$$
\begin{align}
\neg(p \or (\neg p \or q)) &\equiv p' \cdot (p' \cdot q )' & \text{(De Morgan's)} \newline
&\equiv p' \cdot  (p'' + q') & \text{(De Morgan's)} \newline
&\equiv p' \cdot (p + q') & \text{(Double Negation)} \newline
&\equiv (p' \cdot p) + (p' \cdot q') & \text{(Distributive)} \newline
& \equiv (0) + (p'\cdot q') & \text{(Negation)} \newline
& \equiv (p'\cdot q') + 0 & \text{(Commutative)}\newline
&\equiv p' \cdot q' & \text{(Identity)}
\end{align}
$$

Note that when you're asked to prove equivalence between two propositions, strickly following the rules step by step is necessary.

## Def (Complete)

A collection $\mathcal S$ of logical proposition is __complete__ if 
$$
\text{ Every compound proposition is logically equivalent to a propoition which only use operotors in $\mathcal S$}
$$

### Thm (Completeness of AND, OR, NOT)


$$
\{\and, \or, \neg\} \text{ is complete}
$$

For example, suppose that there are three propositions, $X(p, q, r)$, $f(p, q, r)$, and $g(p, q, r)$, with truth value as follows： 

| p    | q    | r    | X    | f    | g    |
| ---- | ---- | ---- | ---- | ---- | ---- |
| 0    | 0    | 0    | 0    | 0    | 0    |
| 0    | 0    | 1    | 0    | 0    | 0    |
| 0    | 1    | 0    | 1    | 1    | 0    |
| 0    | 1    | 1    | 0    | 0    | 0    |
| 1    | 0    | 0    | 0    | 0    | 0    |
| 1    | 0    | 1    | 0    | 0    | 0    |
| 1    | 1    | 0    | 1    | 0    | 1    |
| 1    | 1    | 1    | 0    | 0    | 0    |

It's obvious that : 
$$
X \equiv f \or g
$$
Observe that $f$ is TRUE only when：
$$
(\neg p \and q \and \neg r)
$$
is TRUE, and thus：
$$
f \equiv (\neg p \and q \and \neg r)
$$
Similarily, for $g$： 
$$
g \equiv （p \and q \and \neg r） \
$$
and thus : 
$$
X \equiv (\neg p \and q \and \neg r) \and（p \and q \and \neg r）
$$
this way of construction, however,  doesn't always yields representation with fewest symbols. For example, in the above case : 
$$
X \equiv (\neg p \and q \and \neg r) \and（p \and q \and \neg r） \equiv q \and \neg r
$$

 ### Thm (Completeness of NOT and OR)

$$
\mathcal S = \{\neg, \or \} \text{ is complete}
$$

pf : 

Since $\{\or, \and, \neg\}$ is complete, it is sufficient to show AND, OR, NOT can be construct via $\{\neg, \or\}$. Since $\neg, \or$ already in $\mathcal S$, it remains to show that $\and$ can be constructed with $\mathcal S$: 
$$
p \and q \equiv \neg(\neg p \or \neg q)
$$

### Thm (Completeness of NOT and AND)

$$
\{\neg, \and\} \text{ is a complete set}
$$

### Thm (Completeness of NAND)

$$
\{ | \} \text{ is a complete set}
$$

pf : (Why not draw a Karnaut Map ?)

### Thm (Completeness of NOR)

$$
\{ \downarrow \} \text{ is a complete set}
$$

# Predicate Logic

## Prologue

有一些東西在 Propositional Logic 有點難說明。比如說：
$$
\begin{cases}
\text{All integers are primes}\newline
\text{There exists an onteger that is not prime}
\end{cases}
$$
這兩個敘述在 Propositional Logic 中會是兩個不相干的命題，但聽起來至兩個敘述是相反的。有沒有什麼邏輯系統是可以表現這件事的？看起來關鍵就是少了描述「全部」「存在」這種東西。

---

## Def (Predicate)

$$
\text{A predicate is a sentence with variable(s)} 
$$

---

假定有一個敘述：
$$
\text{$x$ is a prime}
$$
可以把它表達成：
$$
P(x):\text{ $x$ is a prime}
$$
注意 $P(x)$ 本身並不是一個命題，因為 $x$ 不同，$P(x)$ 可能是真或是假。但 $P(2)$ 是個命題，因為在指定 $x$ 之後，就會生出一個命題，所以可以用命題之間的連接詞連接。比如：
$$
\neg P(0) \and \neg P(1)\and \neg P(2)
$$
因此，對於第一個敘述，可以寫成：
$$
\dots P(-2) \and P(-1) \and P(0) \and P(1) \and P(2) \dots
$$
是一個無限長的敘述。但這樣一來這個敘述會畀的很冗長。所以希望有個方法可以去除這個麻煩。

另外也注意這裡 Prediacate 不一定只有一個變數。比如說可以定義：
$$
R(x, y) : x = y + 3
$$

---

## Def (Quantifier)

$$
\begin{cases}
\forall x.P(x) & \text{$P(x)$ is TRUE for all $x$ in the domain}\newline
\exists x.P(x) & \text{There exists at least a value $c$ in the domain s.t. $P(c)$ is TRUE}
\end{cases}
$$

---

比如敘述 $A$ 可以表示成：
$$
\forall x.P(x)
$$
而敘述 $B$ 可以表成：
$$
\exists x.\neg P(x)
$$

---

### Example

$$
\text{Every student in this class has studied calculus}
$$

假定：
$$
\begin{cases}
P(x) & \text{$x$ is in the class} \newline
Q(x) & \text{$x$ has studied calculus}
\end{cases}
$$
並且 Domain 是所有人。

考慮下面兩種翻譯：
$$
\begin{cases}
\forall x.P(x) \to Q(x) & (1) \newline
\forall x.P(x) \and Q(x) & (2)
\end{cases}
$$
第一個是正確的，第二個是錯誤的。

如果定義域是限定在「這個班上的所有人」的話，那麼上面這兩個敘述真值是一樣的，因為 $P(x)$永遠為真。但如果定義域是考慮「所有人的話」，假定 $y_1, y_2, y_3$ 是「不在班上的人」，$P(y_i) \to Q(y_i)$ 會恆為真，$P(y_i) \and Q(y_i)$ 會恆為假。假定 $x_1 \dots x_n$ 是在班上的人，$y_1 \dots y_m$ 是不在班上的人，那麼：
$$
\begin{cases}
L_1(x_1) \and L_1(x_2) \dots L_1(x_n)\and \mathbb T \and \mathbb T \dots & (1)\newline
L_2(x_1) \and L_2(x_2) \dots L_2(x_n)\and \mathbb F \and \mathbb F \dots & (2)
\end{cases}
$$
第一種翻譯可以把「不在班上的人」忽略。但第二種翻譯，不管 $L_2(x_i)$ 是不是真的，也就是不管班上的人有沒有學過微積分， 命題都會變成假的。

接著考慮：
$$
\text{Exists a student in this class who has studied calculus.}
$$
一樣考慮兩種翻譯：
$$
\begin{cases}
\exists x.P(x) \to Q(x) & (1) \newline
\exists x.P(x) \and Q(x) & (2)
\end{cases}
$$

這次換成第 2 個是正確的翻譯。

---

## Def (Logical Equivalence)

$$
\begin{align}
\neg (\forall x.P(x) ) & \equiv \exists x.\neg P(x) \newline
\neg(\exists x.P(x)) & \equiv \forall x.\neg P(x)\newline
\forall x.P(x)\and Q(x) & \equiv (\forall x. P(x)) \and (\forall x.Q(x)) \newline
\exists x.P(x)\or Q(x) & \equiv (\exists x. P(x)) \and (\exists x.Q(x)) \newline
\end{align}
$$

---

注意有些東西看起來對，但起其實不那麼對。比如說：
$$
\forall x.P(x)\or Q(x) \not\equiv (\forall x. P(x)) \or (\forall x.Q(x))
$$
因為式右至少要所有 $x$滿足 $P$，不然就是全滿足 $Q$。 

---

## Def (Nested Quantifier)

量詞可以 Nested。這時候是右結合的：
$$
\begin{align}
\forall x.\exists y.p(x, y) \equiv \forall x .(\exists y.p(x,y)) \newline
\exists y.\forall x.p(y, x) \equiv \exists y .(\forall x.p(x,y))
\end{align}
$$

---

但顯然 $\forall x.\exists y.p(x, y)  \not \equiv \exists y.\forall x.p(y, x) $。所以量詞順序不能亂調換。

---

# Def (Argument)

給定「前提」 $\alpha, \beta, \gamma \dots$(i.e. 假定 $\alpha, \beta, \gamma \dots$ 為真) ，證明一個結論的過程

---

## Observation

這件事其實是在證：
$$
\bigcap(前提) \to (結論)
$$
是個 tautology。而要證明這個東西是 tautology，可以使用 Truth Table。

---

## Example

前提為：
$$
\begin{align}
\text{Premise}&:
\begin{cases}
p:\text{If you have an account, then you can access the website.}\newline
q:\text{You have an account.}
\end{cases}\newline
\text{Conclusion}&: \text{You can access website ($p$)}
\end{align}
$$
用符號簡化成：
$$
\begin{align}
\text{Premise}&:
\begin{cases}
p\to q & (1)\newline
p & (2)
\end{cases}\newline
\text{Conclusion}&:\quad q
\end{align}
$$
套用剛剛的觀察，可以知道是要證：
$$
((p\to q)\and p) \to q
$$
使用真值表：

| $p$  | $q$  | $p$  | $\to$ | $q$  | $\and$ | $p$  | $\to$ |
| ---- | ---- | ---- | ----- | ---- | ------ | ---- | ----- |
| 0    | 0    | 0    | 1     | 0    | 0      | 0    | 1     |
| 0    | 1    | 0    | 1     | 1    | 0      | 0    | 1     |
| 1    | 0    | 1    | 0     | 0    | 0      | 1    | 1     |
| 1    | 1    | 1    | 1     | 1    | 1      | 1    | 1     |
|      |      |      |       |      |        |      |       |

## Def (Inference Rules of Proposition Logic)

除了用真值表爆開以外，也可以使用各種 Inference Rules 來進行推論。這些規則有比如說：

### Modus Ponens

$$
\frac {p \qquad q \to q}{q}(\text{Modus Ponens})
$$

### Modus Tollens

$$
\frac {\neg q \qquad p\to q}{\neg p}(\text{Modus Tollens})
$$

### Simplification

$$
\frac {p \and q}{q}\text{(Simplification)}
$$

### Resolution

$$
\frac {p \or q \qquad \neg p\or r}{q \or r}\text{(Resolution)}
$$

### More

更多規則可以去查課本。

> 實際上可以用 FLOLAC 教的真值樹法反推。會好用很多。

### Example

$$
\begin{align}
&\begin{cases}
\text{"$If$ }\underbrace{ \text{it's not sunny}}_{\neg p}\ and\ \underbrace{\text{it's colder than yesterday."}}_{q} & (\neg p \and q)\newline
\underbrace{\text{"We will go swimming}}_{r}\ only\ if\ \underbrace{\text{it's sunny."}}_{p} & (r \to p)\newline
\underbrace{\text{"If we don't go swimming}}_{\neg r},\ then\ \underbrace{\text{we will go to the class."}}_{s} & (\neg r \to s)
\end{cases}\newline\newline
&\text{Therefore}\underbrace{\text{"We will go to the class"}}_{s} & 
\end{align}
$$

因此，這個東西就變成：
$$
\begin{align}
\text{Premises}&:\begin{cases}
\neg p \and q \newline
r \to p \newline
\neg r \to s
\end{cases}\newline
\text{Conclusion} &:s
\end{align}
$$
可以用下面的方式證明：

| X    | steps           | Reason             |
| ---- | --------------- | ------------------ |
| 1    | $\neg p \and q$ | Premise            |
| 2    | $\neg p$        | Simplification, 1  |
| 3    | $r \to p$       | Premise            |
| 4    | $\neg r \to s$  | Premise            |
| 5    | $\neg r$        | Modus Tollens 2, 3 |
| 6    | $s$             | Modus Ponens 4, 5  |
|      |                 |                    |

這個格式需要盡量遵守。只有一個例外，就是 Equivalence。可以寫成 Lemma 再使用。

證明方法並不是唯一的，舉例來說，同樣的命題也有另外一種作法。比如：

| No   | Steps           | Reasons          |
| ---- | --------------- | ---------------- |
| 1    | $\neg p \and q$ | Premise          |
| 2    | $r \to p$       | Premise          |
| 3    | $\neg r \to s$  | Premise          |
| 4    | $\neg p$        | Simplification 1 |
| 5    | $\neg r \or p$  | Equivalence 2    |
| 6    | $r \or s$       | Equivalence 4    |
| 7    | $p \or s$       | Resolution 5, 6  |
| 8    | $s$             | Resolution 4. 7  |
|      |                 |                  |

可以發現這個動作其實可以歸納成一個步驟：

1. 把所有連接詞爆開成只有 $\{\neg, \or, \and\}$ 的形式。
2. 用 Resolution 消去所有出現一對 $\neg$ 跟 $\not \neg$ 的敘述。 

這個步驟提供一個機械化的方法證明所有的命題。

## Def (Rules of Infrence of Predicate Logic)

量詞有下面四條推論規則。前兩條是消去量詞，後兩條是把量詞加回去。通常的用法是先用前兩條把敘述變成 Propositional Logic，推論出結果之後，再用後二條把量詞加回去。

### Universal Instantiation

$$
\frac {\forall x.P(x)}{P(c)\quad \text{c arbritrary}}
$$

### Existential Instantiation

$$
\frac {\exists x.P(x)}{P(c)\quad \text{for some c}}
$$

### Universal Generalization

$$
\frac {P(c) \text{ for arbritrary c}}{\forall x.P(x)}
$$

### Existential Generalization

$$
\frac {P(c) \text{ for some c}}{\exists x.P(x)}
$$

------

### 例子：

$$
\begin{align}
&\begin{cases}
\text{Everyone in this class knows calculus.} & \forall x(P(x) \to R(x))\newline
\text{Jason is in this class.}& P(\text{Jason})\newline
\text{Jason is in EE.} & Q(\text{Jason})\newline
\end{cases}\newline
&\Rightarrow\text{There exists a person in EE who knows calculus} \newline
&\qquad\exists x.Q(x)\and R(x)
\end{align}
$$

scope：all people

| Steps                                  | Reason                     | Remark                                |
| -------------------------------------- | -------------------------- | ------------------------------------- |
| $\forall x.P(x) \to R(x)$              | Premise                    |                                       |
| $P(\text{Jason})$                      | Premise                    |                                       |
| $Q(\text{Jason})$                      | Premise                    |                                       |
| $P(Jason) \to R(Jason)$                | Universal Instantiation, 1 | 不能直接用 MP， 因爲 $x$ 的意義不一樣 |
| $R(\text{Jason})$                      | Modus Ponens, 2, 4         |                                       |
| $Q(\text{Jason}) \and R(\text{Jason})$ | Conjunction 3, 5           |                                       |
| $\exists x.Q(x)\and R(x)$              | Existential Generalization |                                       |
|                                        |                            |                                       |

### 例子 (錯誤的證明)

| Steps                      | Reason                        | Remark                                                       |
| -------------------------- | ----------------------------- | ------------------------------------------------------------ |
| $\forall x.P(x)$           | Premise                       |                                                              |
| $\exists x. P(x) \to Q(x)$ | Premise                       |                                                              |
| $P(c)$                     | Universal Instantiation       |                                                              |
| $P(c) \to Q(c)$            | Exitential Instantiation      | 這裡錯。因為前提只有 $\exists$，不保證 $c$ 是那裡面的東西 。但如果這一行跟上一行交換，就是正確的論證。 |
| $Q(c)$                     | MP 3, 4                       |                                                              |
| $\exists x.Q(x)$           | Existential Generalization, 5 |                                                              |
|                            |                               |                                                              |
|                            |                               |                                                              |

### Remark

上面這個推論在巢狀量詞的時候並不正確。所以考試出題會盡量避免。不過 FLOLAC 有教過了。



## Program Verification

## Def (一個符號)

用以下的符號表示「在指令 $s$ 執行前，$p$ 成立; 而執行過後 $q$  成立」：
$$
p\ \{s\}\ q
$$

------

### Def (Loop Invariant)

考慮程式：

```pseudocode
while (condition)
	S;
```

 若命題 $p$ 滿足：
$$
p \and \text{condition} \{S\}\ p
$$
則稱 $p$ 是一個 loop invariant

------

最明顯的例子如最短路徑中的 Relax、最短路徑、DFS 的白路性質...。

> 實際上很多 verification 都是用 Chrch-Russel Correspondence 來做，不一定要是這種難用的 Loop Invariant