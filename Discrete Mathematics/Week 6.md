# Week 6

## Uniqueness of Prime Factorization

Suppose that $n \in \mathbb N$, and
$$
n = \prod_{i = 1}^{s}p_s = \prod_{j = 1}^sq_i
$$
Where $p_i, q_i$ are **prime numbers** with:
$$
\begin{align}
p_1 &\leq p_2 \dots \leq p_{s-1} \leq p_s\newline
q_1 &\leq q_2 \dots \leq q_{t-1} \leq q_t
\end{align}
$$
then
$$
s = t, \forall 1\leq i \leq s.p_i = q_i
$$
---

Assume, by contradiction,  $p_1 \neq q_1$. WLOG assume $p_1 < q_1$ then:
$$
p_1 < q_1 \leq q_2 \leq q_3 \dots
$$
But
$$
p_1 \mid n \Rightarrow p_1 \mid \prod_{i = 1}^t q_i
$$
Thus, by Lemma:
$$
\exists q_i.p_1 \mid q_i
$$
Which leads to contradiction that $q_1 \dots q_t$ are all primes, so:
$$
p_1 = q_1
$$
Cancelling out $p_1, q_1$ on the both side we have:
$$
\prod_{i = 2}^{s}p_s = \prod_{j = 2}^tq_i =: n'
$$
Inductively we reach the conclusion that $p_i = q_i$ and $s = t$ .

# Congruent Equation

Goal : Find the smallest $x \in \mathbb Z^+$s.t. 
$$
ax \equiv b\mod m
$$

where $\gcd(a, m) = 1$

## Thm

$\forall a,b,c \in \mathbb Z,m\in \mathbb Z ^+$, then
$$
\begin{cases}
ac \equiv bc \mod m \newline
\gcd(c, m) \equiv 1
\end{cases} \Rightarrow a \equiv b \mod m
$$

---

$$
\begin{align}
m \mid (ac - bc) & \Rightarrow m \mid c(a - b) \newline
& \Rightarrow m \mid (a - b) & \text{Thm}\newline
& \Rightarrow a \equiv b \mod m & \text{Def. of conruent}
\end{align}
$$

---

實際上那些以歐幾里德演算法為基礎的東西可以擴展到 $\mathbb Z$。

---

## Thm

$\gcd(a, m) = 1, m > 1$, then:
$$
\exists ! \bar{a} \in \{0, 1, \dots m-1\}.a \bar{a} = 1 \mod m
$$

---

`EXISTENCE`

By previous theorem:
$$
\begin{align}
\exists s, t.&sq + tm = \gcd(a, m) = 1\newline
&\Rightarrow sa = 1 + m(-t)\newline
& \Rightarrow sa \equiv 1 \mod m \newline
& \Rightarrow \underbrace{(s\ \text{mod}\ m)}_{\bar a} a \equiv a \mod m
\end{align}
$$
`UNIQUENESS`

Suppose that
$$
a\bar a_1 \equiv 1 \equiv a \bar a_2 \mod m
$$
since $\gcd(a, m) = 1$, apply Thm above to elimate $a$ from both sides:
$$
\bar a_1 \equiv \bar a_2 \mod m
$$
Since $0 \leq \bar a_1, \bar a_2 \leq m-1$ and $\bar a_1, \bar a_2 \in \mathbb N$ , we have
$$
\bar a_1 = \bar a_2
$$

---

## Algorithm to Solve Congruent Equation

Find $\bar a$ such that
$$
a \bar a \equiv 1 \mod m
$$
then
$$
\begin{align}
& a \bar a \equiv 1 \mod m \newline
\Rightarrow & a\bar a\cdot b \equiv b \mod m \newline
\Rightarrow & a (\bar a b) \equiv b \mod m
\end{align}
$$
And
$$
x = (\bar a b \text{ mod } m)
$$
is the solution.

---

$$
35x \equiv 2 \mod 3
$$

$$
\begin{align}
\bar{35} = 2 &\Rightarrow 35 \cdot 2 \equiv 1\mod 3\newline
& \Rightarrow 35 \cdot 2 \cdot 2 \equiv 2\mod 3\newline
& \Rightarrow 35 \cdot (2 \cdot 2) \equiv 2\mod 3\newline
& \Rightarrow 4 \text{ mod 3} = 1 
\end{align}
$$

## Chinese Remainder Theorem

$$
\begin{cases}
x \equiv a_1 \mod m_1\newline
x \equiv a_2 \mod m_2\newline
\dots \newline
x \equiv a_n \mod m_n\newline
\end{cases}
$$

has unique solution $x$ in $\{0, 1, \dots, m-1\}$, where 
$$
m = \prod_{i = 1}^n m_i
$$

and

$$
\gcd(m_i, m_j) = 1 \forall i \neq j
$$

---

> 解法根本是整數版的 Lagrange Polynomial 

`EXISTENCE`

One of the possible solutions can be construct as following:

Let
$$
M_i = m/m_i
$$
Find $y_i$ s.t.
$$
M_i y_i \equiv 1 \mod m_i
$$
Observe that:
$$
M_i y_i \text{ mod } m_j = \begin{cases}
1 & \text{if }i = j\newline
0 & \text{otherwise}
\end{cases}
$$
Consider the number:
$$
X = \sum_{i = 1}^n a_iM_iy_i
$$
Finally
$$
x = X \text{ mod m}
$$

`UNIAUENESS`

Suppose there exists $x_1, x_2$. Let $z = x_1 - x_2$, then:
$$
\forall i.z \equiv 0 \mod m_i
$$
Thus:
$$
\begin{align}
x_1 &= x_2 + c\cdot \text{lcm}(m_1, m_2 \dots m_n)\newline
&= x_2 + c \prod_{i = 1}^{n}m_i
\end{align}
$$
Since $x_1, x_2 \leq \prod_{i = 1}^{n}m_i $ , the only possibility is $c = 0$, which leads to $x_1 = x_2$.

## Fermat's Little Theorem

Suppose $p$ is a prime number, and $p \not \mid a$, then:
$$
a^{p - 1} \equiv 1 \mod p
$$

---

Consider
$$
S = \{1, 2, \dots, p-1\}
$$
And 
$$
y_i = (i \cdot s) \mod p
$$
Claim
$$
S = \{y_1 \dots y_{p-1}\}
$$
then
$$
\begin{align}
\prod_{i = 1}^{p-1} i &\equiv \prod_{i = 1}^{p-1} y_i &\mod p \newline
&\equiv \prod_{i = 1}^{p-1}(a \cdot i) &\mod p\newline
& \equiv a^{p-1}\prod_{i = 1}^{p-1}i &\mod p\newline
&\Rightarrow 1 \equiv a^{p-1} &\mod p
\end{align}
$$
Proof of claim

`1` $\forall i. y_i \in S$：Directly from $\mod p$ operation. 

`2` $\forall i \neq j.y_i \neq y_j$

proof by contraciction
$$
\begin{align}
y_i = y_j &\Rightarrow (i\cdot a) \equiv (j \cdot a) \mod p\newline
& \Rightarrow i = j\mod p
\end{align}
$$
