# Week 7

## Recurrence Relation

### Homobeneous Linear Recurrence Relation

問題：找出所有滿足
$$
T(n) = \sum_{i = 1}^{k}a_k T(n - k)
$$
的解。

### 觀察 1

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

### 觀察 2

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

### 觀察 3

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
\Rightarrow T_1(n) + T_2(n) &= (T_1(n) + T_2(n)) + (T_1(n) + T_2(n))
\end{align}
$$
即可證明。

---

### 觀察 4

所以，在這個問題中，任意 $c_1, c_2$：
$$
c_12^{n} + c_2(-1)^{n}
$$
都是遞迴關係的解。

這樣確實生出了很多解，但實際上的解會不會更多？實際上這就是全部的解了。

### Claim

Claim : 

給定任意初始條件：
$$
\begin{align}
T(1) &= n_1 \newline
T(2) &= n_2 \newline
\end{align}
$$
則：

1. $T(n)$ 有唯一解。
2. 存在一個具有下列形式的解：

$$
c_1 2^{n} + c_2 (-1)^{n}
$$

因此可以推論 2. 的解就是那個唯一解。

---

`1` ：給定 $T(1), T(2)$ 之後，思考計算 $T(n)$ 的方式，每一步計算都是唯一決定的。
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
因此 $c_1, c_2$ 可以唯一地解出來：
$$
\begin{cases}c_1 &= \frac {n_1 + n_2}{6} \newline
c_2 &= \frac {2n_2 - n_1}{6} \newline
\end{cases}
$$
故將 $c$帶入之後：
$$
\left(\frac {n_1 + n_2}{6}\right) 2^{n} + \left(\frac {2n_2- n_1}{6}\right)(-1)^n
$$
是一個 $T(n)$ 的解。 

## 一般地解法

`1` ：計算特徵多項式的根

`2`：假定 $r$ 為 $m$ 重根，則 $\left(\sum_{i = 0}^{m - 1}a_in^i\right)r^n$ 是一個解。

`3`：將各自的解線性組合起來。



### 例子

$$
T(n) = T(n - 1) + 6T(n - 2)
$$

其中：
$$
T(1) = T(2) = 5
$$


特徵多項式：
$$
r^2 - r - 6 = 0 \Rightarrow r = 3, -2
$$
故解的形式為：
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

### 例子

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

## Linear Recurrence

下面形式的遞迴關係式：
$$
T(n) = f(n) + \sum_{i = 1}^k a_i T(n - i)
$$
$f(n)$ 的話，上面的方法就能解了。所以關鍵是要怎麼解多了 $f(n)$ 帶來的影響。

1. 解沒有 $f(n)$ 的版本 $G(n)$
2. 猜一個原先版本的解 $P(n)$
3. $T(n) = G(n) + P(n)$

比如：
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
