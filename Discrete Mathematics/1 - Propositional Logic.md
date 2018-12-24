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

