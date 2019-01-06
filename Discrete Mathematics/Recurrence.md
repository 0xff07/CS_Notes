# Recurrence Relation

## Homogeneous Linear Recurrence Relation

問題：找出所有滿足形如：
$$
T(n) = \sum_{i = 1}^{k}a_k T(n - k)
$$
的 $T(n)$ 的解。

### 觀察 1：特徵方程式

$$
T(n) = T(n - 1) + 2T(n-2)
$$

考慮以下步驟：令 $T(n) = r^n$。帶入方程式，得到：
$$
r^{n} = r^{n-1} + 2r^{n-2} \Rightarrow r^2 - r - 2
$$
令該方程式為 0。解得：
$$
r = 2, -1
$$
則可發現：
$$
2^n, (-1)^{n}
$$
是遞迴關係的解。驗證方法就是把上面的步驟倒過來帶進去。

> 這個特徵方程式怎麼來有很多種「解釋」方法。比如說生成函數解。

### 觀察 2：係數積可提

假定 $T(n)$ 是個上述遞迴關係的解，則對於任意常數 $c$， $cT(n)$ 也是遞迴關係的解

---

在上述的關係中，把關係式左右同乘常數 $c$：
$$
T(n) = T(n) + 2T(n) \Rightarrow cT(n) = cT(n) + 2cT(n)
$$
因此：
$$
S(n) = cT(n)
$$
也是一個滿足遞迴關係的解。

### 觀察 3：加法可拆

假定 $T_1(n), T_2(n)$ 都是遞迴關係的解，則：
$$
T_1(n) + T_2 (n)
$$
也是遞迴關係的解。

---

把兩個關係都寫出來：
$$
\begin{align}
T_1(n) &= T_1(n - 1) + 2T_1(n - 2)\newline
T_2(n) &= T_2(n - 1) + 2T_2(n - 2) \newline
\Rightarrow  T_1(n) + T_2(n) &= (T_1(n) + T_2(n)) + 2(T_1(n) + T_2(n))
\end{align}
$$
即可證明。

---

### 推論：

所以，在這個問題中，任意 $c_1, c_2$：
$$
c_12^{n} + c_2(-1)^{n}
$$
都是遞迴關係的解。

> 「這些解 $\subseteq $ 所有的解」。那反過來說，是否「所有的解 $\subseteq $ 這些解」？這個答案是肯定的。接下來就在說明這件事。

### Claim

對於：
$$
T(n) = T(n - 1) + 2T(n-2)
$$
這個遞迴關係。若初始條件已給定：
$$
\begin{align}
T(1) &= n_1 \newline
T(2) &= n_2 \newline
\end{align}
$$
則：

1. $T(n)$ 有唯一解。
2. 存在具有下列形式的解：

$$
c_1 2^{n} + c_2 (-1)^{n}
$$

因為解唯一，所以隨便抓一組解，就一定是那個唯一解。因此可以推論 2. 得到的解，就是那個唯一解。

---

`1` ：給定 $T(1), T(2)$ 之後，思考計算 $T(n)$ 的方式，每一步計算都只有一個結果。所以遞推下去也只有有一個結果：
$$
\begin{align}
T(3) &= T(2) + 2T(1) = n_2 + 2n_2 \newline
T(4) &= T(3) + 2T(2) = \dots \newline
\end{align}
$$

`2`：考慮：
$$
\begin{align}
T(1) &= c_1 2^{1} + c_2(-1)^{1} = n_1\newline
T(2) &= c_1 2^{2} + c_2(-1)^{2} = n_2\newline
\end{align}
$$
則 $c_1, c_2$ 可以唯一地解出來：
$$
\begin{cases}c_1 &= \frac {n_1 + n_2}{6} \newline
c_2 &= \frac {2n_2 - n_1}{6} \newline
\end{cases}
$$
故將  $c_1, c_2$ 帶入之後：
$$
\left(\frac {n_1 + n_2}{6}\right) 2^{n} + \left(\frac {2n_2- n_1}{6}\right)(-1)^n
$$
是一個 $T(n)$ 的解。 

---

## Observation (General Homogeneous Linear Recurrence)

> 其實這邊沒有對於解法進行推廣。

`1` ：計算特徵多項式的根

`2`：假定 $r$ 為 $m$ 重根，則 $\left(\sum_{i = 0}^{m - 1}a_in^i\right)r^n$ 是一個解。

`3`：將各自的解線性組合起來，即得到解。

---

### 例子 1

$$
T(n) = T(n - 1) + 6T(n - 2)
$$

其中：
$$
T(1) = T(2) = 5
$$

`1. ` 特徵多項式：
$$
r^2 - r - 6 = 0 \Rightarrow r = 3, -2
$$
`2. ` 故解的形式為：
$$
T(n) = c_1 3^n + c_2 (-2)^n
$$
帶入 $T(1), T(2)$ 解出常數：
$$
\begin{align}
T(1) &= 3c_1 - 2c_2 = 5 \newline
T(2) &= 9c_1 + 4c_2 = 5
\end{align}
\Rightarrow c_1 = 1, c_2 = -1
$$
故：
$$
T(n) = 3^n - (-2)^n
$$

---

### 例子 2

$$
T(n) = 6T(n - 1) - 9T(n - 2)
$$

其中：
$$
T(1) = 0, T(2) = 9
$$
特徵方程式：
$$
r^2 - 6r + 9 = 0 \Rightarrow r = 3, 3
$$
因此解的形式為：
$$
T(n) = [c_1 n + c_0]3^n
$$
帶回解：
$$
\begin{align}
T(1) &= [c_1 + c_0]\cdot 3 = 0 \newline
T(2) &= [2c_1 + c_0] \cdot 3^2 = 9
\end{align}
\Rightarrow c_1 = 1, c_2 = -1
$$
故解為：
$$
T(n) = [n - 1]\cdot 3^n
$$

---

## Thm (Nonhomogeneous Recurrence)

假定有一個遞迴關係：
$$
T(n) = \sum_{i = 1}^k a_i T(n - i) + f(n)
$$
則以下方法得到的解，是這個遞迴關係的所有解：

1. 解 $G(n) = \sum_{i = 1}^k a_i G(n - i)$
2. 尋找一個解 $P(n)$，使得：$P(n) = \sum_{i = 1}^k a_i P(n - i) + f(n)$
3. $T(n) = G(n) + P(n)$ 即為所求。 

---

假定 $S(n)$ 是個 $T(n)$ 的解：
$$
\Delta(n) := S(n) - P(n) = \left(\sum_{i = 1}^{k}a_i S(n - i) + f(n)\right) - \left(\sum_{i = 1}^{k}a_i P(n - i) + f(n)\right) = \sum_{i = 1}^{k}a_i (S(n - i) - P(n - i))
$$
因此可知 $\Delta(n)$ 是Homogeneous Solution 的解。反之，所有具有 $T(n) = P(n) + G(n)$ 的解，帶入之後都滿足遞迴方程式。因此兩個集合一樣大。

---

### 例子 1

$$
T(n) = 2 T(n - 1) + 8T(n - 2) + 9n
$$

其中：
$$
T(1) = 1, T(2) = 12
$$

1. 解沒有 $f(n)$ 的部分
   $$
   T(n) = 2T(n - 1) + 8T(n - 2) \Rightarrow G(n) = c_1 4^n + c_2 (-2)^n
   $$

2. 猜一個解：就猜 $P(n) = c_2n + c_4$。這個目前只是漫無目的的猜，後面會有一個比較一般的猜法。帶進去解：
   $$
   c_3n + c_4 = 2 [c_3 (n - 1) + c_4] + 8[c_3 (n - 2) + c_4] + 9n
   $$
   解出來得到：
   $$
   -9c_3 n + 18c_2 - 9c_4 = 9n \Rightarrow c_3 = -1, c_4 = -2
   $$

3. 兩個解合起來：
   $$
   T(n) = G(n) + P(n) = c_1 4^n + c_2 (-2)^n -n - 2
   $$










然後把初始條件帶進去解：
$$
\begin{align}
T(1) &= 4c_1 - 2c_2 - 1 - 2 = 1 \newline
T(2) &= 16c_1 + 4c_2 - 2 - 2 = 12
\end{align}
\Rightarrow c_1 = 1, c_2 = 0
$$
故解為：
$$
T(n) = 4^n - n - 2
$$

---

### 例子 2

$$
T(n) = 2T(n - 1) - 2 T(n - 2) + 2
$$
其中：
$$
\begin{cases}
T(0) = 2 \newline
 T(1) = 4
 \end{cases}
$$
「解 $G(n)$」：
$$
G(n) = C_1 (1 + i)^{n} + C_2 (1 - i)^{n}
$$
因為 $G(n)$ 要是實數，所以 $C_1 = \bar{C_2}$，即 $G(n)$ 需要有：
$$
G(n) = (c  +di) (1 + i)^{n} + (c - di)(1 - i)^{n}
$$
的形式。

「解 $P(n)$」：

猜：
$$
P(n) = c_0
$$
帶回得：
$$
c_0 = 2c_0 - 2c_0 + 2 \Rightarrow c_0 = 2
$$
故：
$$
P(n) = 2
$$
「解 $T(n)$」：

因此：
$$
T(n) = (c + di)(1 + i)^n + (c - di)(1 - i)^n + 2
$$
使用初始挑件：
$$
\begin{cases}
T(0) = 2c + 2 = 2\newline
T(1) = 2c - 2d + 2 = 4
\end{cases}
$$
因此解得：
$$
\begin{cases}
c = 0 \newline
d = -1
\end{cases}
$$
故：
$$
T(n) = -i(1 + i)^n + i (1 - i)^n + 2
$$
有些書會把它用利美佛定律化簡成：
$$
T(n) = 2 (\sqrt 2)^{n} \sin\left(\frac {n \pi}{4}\right) + 2
$$

---

### Observation (猜 P)

大致上有以下的方向：

| $f(n)$              | $P(n)$                               | 註解                                                         |
| ------------------- | ------------------------------------ | ------------------------------------------------------------ |
| $P_d (n) \cdot r^n$ | $P_d'(n) \cdot r^n \cdot n^{\alpha}$ | $P_d, P_d' \in \mathbb P_d$ $\alpha$ 是 $r$ 在 特徵多項式的次數 |
| $g_1(n) + g_2(n)$   |                                      | 分開猜再加起來                                               |
|                     |                                      |                                                              |

以下提供一些例子：

| $f(n)$                               | $P(n)$                            | 註備                                                         |
| ------------------------------------ | --------------------------------- | ------------------------------------------------------------ |
| $T(n) = 3T(n - 1) + n^2 2^n$         | $(c_2 n^2 + c_1n + c_0)2^n$       |                                                              |
| $T(n) = 2T(n - 1) + n^2$             | $(c_2n^2 + c_1n + c_0) \cdot 1^n$ | $\begin{align}T(n) &= 2T(n - 1) + n^2 \newline &= 2T(n - 1) + n^2 1^n \end{align}$ |
| $T(n) = 3T(n - 1) + (1) \cdot 2^{n}$ | $c_0 2^n$                         |                                                              |
| $T(n) = 3 T(n - 1) + 2^n$            | $c_0 \cdot n \cdot 3^n$           | $3$ 是特徵多項式 $r - 3$ 的根，且重數是 1                    |
| $T(n) = 6T(n - 1) - 9T(n - 2) + 3^n$ | $c_0 \cdot 3^n \cdot n^2$         | $3$ 是特徵多項式 $r - 3$ 的根，且重數是 2                    |
| $T(n) = 3T(n - 1) + 2^n + 5^n$       | $c_1 2^n + c_2 5^n$               | 分開猜再加起來                                               |

##  Generating Function

> 上課沒有多著墨。

數列 $\{a_n\}$ 的生成函數定義為以下的表示式：
$$
\sum_{i = 1}^{\infty} a_i x_i
$$

### 例

$$
T(n) = 8T(n - 1) + 10^{n - 1}, T(0) = 1
$$

考慮：
$$
G(x) = \sum_{i = 0}^{\infty}T(i)x^i = T(0) + \sum_{i = 1}^{\infty}T(i)x^i
$$
使用遞迴關係帶入：
$$
G(x) =  T(0) + \sum_{i = 1}^{\infty}T(i)x^i = 1 + \sum_{i = 1}^{\infty}\left[8T(i - 1) + 10^{i - 1}\right]x^i
$$
觀察右式：
$$
\begin{align}
\sum_{i = 1}^{\infty}8T(i - 1) + 10^{i - 1} &= \sum_{i = 1}^{\infty}8T(i - 1)x^i + \sum_{i = 1}^{\infty}10^{i - 1} x^i\newline
&= 8x\sum_{i = 1}^{\infty}T(i - 1)x^{i - 1} + \sum_{i = 1}^{\infty}10^{i - 1} x^i \newline
&= 8x G(x) + \frac {1}{1 - 10x}
\end{align}
$$
帶回原式：
$$
G(x) = 1 + 8x G(x) + \frac {1}{1 - 10x}
$$
解得：
$$
G(x) = \frac {1 - 9x}{(1 - 10x)(1 - 8x)}
$$
為了求出各項係數，進行部分分式：
$$
\begin{align}
G(x) &= \frac {1}{2}\left(\frac {1}{1 - 8x} + \frac {1}{1 - 10x}\right)\newline
&= \sum_{i = 0}^{\infty}\frac {1}{2}(8^i + 10^i)x^i\newline
&= \sum_{i = 0}^{\infty}T(i)x^i
\end{align}
$$
故：
$$
T(i) = \frac {1}{2}(8^i + 10^i)
$$

