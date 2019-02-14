# Number Theory

## Thm (除法原理)

對於任意整數 $a, d \in \mathbb Z$，存在唯一的 $q, r \in \mathbb Z$，其中 $0 \leq r < d$，使得：
$$
a = d\cdot q + r
$$
其中，$q$ 稱作「商數」，$r$ 稱作「餘數」。

換言之，任意兩個整數進行整數相除，得到的商跟餘數都是唯一的。證明方法跟所有證明唯一性的方法一樣，假定：
$$
\begin{cases}
a = dq_1 + r_1 \newline
a = dq_2 + r_2
\end{cases}
$$
相減，得：
$$
0 = d(q_1 - q_2) + (r_1 - r_2)
$$
其中：
$$
-(d-1)\leq r_1 - r_2 \leq d - 1
$$
因為 $|r_1 - r_2| \leq d - 1$，不論 $q_2 - q_2$ 是哪個非零整數，都不可能使兩個相加/減之後變成 0 。因此唯一可能為：
$$
q_1 = q_2
$$
因此連帶地：
$$
r_1 = r_2
$$

------

在這個狀況下，用：
$$
a = r \text{ mod } d
$$
表示 $r$ 是 Mpdular Arithmetic 保證的那個餘數。

------

## Def (Congruent)

假定 $a, b \in \mathbb Z, m \in \mathbb Z^+$。若 $a, b, m$ 滿足：
$$
m \mid (a - b)
$$
則稱 $a, b$ 「同餘」。用：
$$
a \equiv b (\text{mod }m)
$$
表示。

### Observation (同餘等價條件)

$$
a \equiv b (\text{ mod } m) \iff a \text{ mod }m = b \text{ mod }m
$$

$$
a \equiv b (\text{ mod } m) \iff \exists k \in \mathbb Z.a = b + km
$$

------

### Thm (相加相乘保同餘)

$$
a \equiv c (\text{mod }m),b \equiv d (\text{mod }m) \Rightarrow \begin{cases}
a + b \equiv c + d (\text{mod }m)\newline
ab \equiv cd (\text{mod }m)
\end{cases}
$$

------

爆開：
$$
\begin{cases}
a = c + k_1 m \newline
b = d + k_2m
\end{cases}\Rightarrow
\begin{cases}
a + b = c + d + (k_1 + k_2)m\newline
ab = cd + (ck_2 + dk_1 + k_1k_2m)m
\end{cases}
$$

------

## Lemma (除法觀察)

假定 $a, b, r$為 Modular Arithmetic 保證的
$$
a = bq + r
$$
則：
$$
\gcd(a, b) = \gcd(b, r)
$$

------

`1. gcd(a, b) | r`
$$
d_1 \mid a, d_1 \mid b \Rightarrow d_1 \mid (a - bq) \Rightarrow d_1 \mid r
$$
`2. gcd(b, r) | a`
$$
d_2 \mid b, d_2\mid r \Rightarrow d_2 \mid (bq + r) \Rightarrow d_2 \mid a
$$
`3. `

因此：
$$
d_1 \mid d_1, d_2 \mid d_1 \Rightarrow d_1 = d_2
$$

---

## Thm (The Euclidean Algorithm)

 $a, b \in \mathbb Z^+, a > b$，則以下步驟可找出 $\gcd(a, b)$：

```pseudocode
gcd(a, b):
	return b ? a : gcd(b, a % b);
```

------

### Corollary (Bezout's Identity)

對於任意 $a, b \in \mathbb N​$，存在 $s, t \in \mathbb Z​$，使得：
$$
\gcd(a, b) = sa + tb
$$

------

`gcd` 一直帶回去就可以得到了。例：

$a = 35 = r_0, b = 25 = r_1$

則：
$$
\begin{align}
35 &= 25 \cdot 1 & a = 35,b = 35\newline
25 &= 10 \cdot 2 + 10 & r_2 = 10 = a-b\newline
10 &= 5 \cdot 2 + 5 & r_3 = 5 = (b - r_2 \cdot 2) = 3b-2a\newline&
\end{align}
$$
這個組合並不是唯一的。可以加減一個公倍數，然後就湊出新的解。

---

## Thm (因數選擇一)

假定 $a, b, c \in \mathbb N, \gcd(a, b) = 1$。則：
$$
a \mid bc \Rightarrow a \mid c
$$

------

因為 $\gcd(a, b) = 1$，所以由 Corollary，可知：
$$
\exists s,t \in \mathbb Z.as + bt = 1
$$
因此：
$$
acs + bct = c
$$
又因爲：
$$
a \mid acs, a \mid (bc)t \Rightarrow a \mid acs + bcd
$$
故：
$$
a \mid c
$$

------

## Lemma (因數選擇二)

假定 $p$ 是一個質數，且：
$$
p \mid \prod_{i = 1}^{n} a_i
$$
則：
$$
\exists a_i \in \{a_1, a_2 \dots a_n\}.p\mid a_i
$$

------

當 $n = 1$ 時，顯然成立。

當 $n = k > 1$，假定 $n = k-1$ 時原題成立，則：

若 $p \mid a_k$：原命題成立。

若 $p \not \mid a_{k}$，因 $p \mid a_k (a_{k-1} \dots a_{1})$，套用剛剛的定理知 $p \mid a_1 \dots a_{k-1}$，歸納法假設知命題成立。

---

## Thm (Uniqueness of Prime Factorization)

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

---

---

# Congruent Equation

Goal : Find the smallest $x \in \mathbb Z^+$s.t. 
$$
ax \equiv b\mod m
$$

where $\gcd(a, m) = 1$

---

## Thm (因數消去律)

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
& \Rightarrow a \equiv b \mod m & \text{Def. of congruent}
\end{align}
$$

---

實際上那些以歐幾里德演算法為基礎的東西可以擴展到 $\mathbb Z$。

---

## Thm (群反元素)

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

---

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

---

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

## Euler's Totient Function

Euler's Totient Function 定義為：
$$
\phi : \mathbb N \to \mathbb N
$$
其中：
$$
\phi(\mathbb N) = n \prod_{p \mid n, p\text{ is prime}} \left(1 - \frac {1}{p}\right)
$$

---

### Observation (質數的 Euler Totient Function)

1. 假定 $p$ 是一個質數，則：
   $$
   \phi(p) = p - 1
   $$

2. 假定 $\gcd(a, b) = 1$ 則：
   $$
   \phi(ab) = \phi(a) \phi(b)
   $$

3. 假定 $p$ 是質數，則對於任意 $k \in \mathbb N$，有：
   $$
   \phi(p^k) = p^{k-1}(p - 1)
   $$

證明方法就是暴力帶進去。

---

### Thm (Euler's Theorem)

假定 $\gcd(a, n) = 1$，則：
$$
a^{\phi(n)} \equiv 1 \mod n
$$
這個證明方法可以這其實是個 overkill 。因為若 $(a, n) = 1$，$n$ 一定可以寫成某些質數的次方積，而且這些質數都跟 $a$ 互質，否則公因數就不是 1 。隨便找一個這樣的質數 $p$ ，假定質數在標準分解式中有 $k$ 次，則：
$$
a^{\phi(p^k)} = a^{(p - 1)p^{k - 1}} =\left(a^{p - 1}\right)^{p^{k - 1}} = 1^{p^{k - 1}} = 1 \mod n
$$
然後用尤拉函數的乘法性質：
$$
\phi(n) = \prod_i\phi(p_i^{k_i})
$$
就立刻得到結論。