# Week 2 - Predicate Logic

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

## Def (Argument)

給定「前提」 $\alpha, \beta, \gamma \dots$(i.e. 假定 $\alpha, \beta, \gamma \dots$ 為真) ，證明一個結論的過程

---

### Observation

這件事其實是在證：
$$
\bigcap(前提) \to (結論)
$$
是個 tautology。而要證明這個東西是 tautology，可以使用 Truth Table。

---

### Example

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

| $p$  | $q$  | $p$ | $\to$ |$q$ | $\and$ |$p$| $\to$ |
| ---- | ---- | ---- |---| ----- | ------ | --|-- |
| 0    | 0    | 0 | 1 | 0 | 0 | 0 | 1 |
| 0    | 1    | 0 | 1 | 1 | 0 | 0 | 1 |
| 1    | 0    | 1 | 0 | 0 | 0 | 1 | 1 |
| 1    | 1    | 1 | 1 | 1 | 1 | 1 | 1 |
|      |      |      |    |   |        |   |   |

## Def (Inference Rules)

除了用真值表爆開以外，也可以使用各種 Inference Rules 來進行推論。這些規則有：

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

這個步驟提供一個機械化的方法證明所有的命題。w