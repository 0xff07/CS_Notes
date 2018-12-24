# Week 5

## Modular Arithmetic

$$
\forall a, d \in \mathbb Z.\exists! q, r \in \mathbb Z, 0 \leq r < d.a = d\cdot q + r
$$

---

`UNIQUENESS`

假定：
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

---
在這個狀況下，用：
$$
r = a \text{ mod } d
$$
表示 $r$ 是 Mpdular Arithmetic 保證的那個餘數。

---

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

---

$$
a \equiv b (\text{ mod } m) \iff a \text{ mod }m = b \text{ mod }m
$$
$$
a \equiv b (\text{ mod } m) \iff \exists k \in \mathbb Z.a = b + km
$$

---

### Thm (相加相乘保同餘)

$$
a \equiv c (\text{mod }m),b \equiv d (\text{mod }m) \Rightarrow \begin{cases}
a + b \equiv c + d (\text{mod }m)\newline
ab \equiv cd (\text{mod }m)
\end{cases}
$$

---

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

---

## Lemma

假定 $a, b, r$為 Modular Arithmetic 保證的
$$
a = bq + r
$$
則：
$$
\gcd(a, b) = \gcd(b, r)
$$

---

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

## Thm (The Euclidean Algorithm)

 $a, b \in \mathbb Z^+, a > b$，則以下步驟可找出 $\gcd(a, b)$：

```pseudocode
gcd(a, b):
	return b ? a : gcd(b, a % b);
```

---

### Corollary

$$
\forall a, b \in \mathbb Z^+.\exists s,t \in \mathbb Z.\gcd(a, b) = sa + tb
$$

---

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

## Thm

$a, b, c \in \mathbb Z^+, \gcd(a, b) = 1$，則：
$$
a \mid bc \Rightarrow a \mid c
$$

---

由 Corollary，可知：
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

---

## Lemma

假定 $p$ 是一個質數，且：
$$
p \mid \prod_{i = 1}^{n} a_i
$$
則：
$$
\exists a_i \in \{a_1, a_2 \dots a_n\}.p\mid a_i
$$

---

當 $n = 1$ 時，顯然成立。

當 $n = k > 1$，假定 $n = k-1$ 時原題成立，則：

若 $p \mid a_k$：原命題成立。

若 $p \not \mid a_{k}$，因 $p \mid a_k (a_{k-1} \dots a_{1})$，套用剛剛的定理知 $p \mid a_1 \dots a_{k-1}$，歸納法假設知命題成立。