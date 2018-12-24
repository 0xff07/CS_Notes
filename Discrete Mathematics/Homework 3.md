# Homwwork 3

# Problem 1

## 1. 

特徵方程式為：
$$
r^2 - r - 2 = 0
$$
根為：
$$
r = 2, -1
$$
因此，通解為：
$$
G(n) = c_1\cdot 2^{n} + c_2 \cdot (-1)^n
$$
接著解：
$$
P_1(n)  = P_1(n - 1) + 2P_1(n - 2) + 3\cdot 2^{n}
$$
及：
$$
P_2(n)  = P_2(n - 1) + 2 P_2(n - 2) + 4
$$
前者令：
$$
P_1 (n) = a n 2^{n}
$$
代回得：
$$
a(n)2^{n} = a(n - 1)2^{n - 1} + a(n - 2) 2^{n - 1} + 3 \cdot 2^{n}
$$
左右同除 $2^{n - 1}$，得到：
$$
(2a)(n) = (a)(n) + (-a) + (a)(n) + (-2a) + 6
$$
得到：
$$
a = 2
$$
故：
$$
P_1 (n) = 2 \cdot n \cdot  2^{n}
$$
令：
$$
P_2(n) = c
$$
則：
$$
c = c + 2c + 4 \Rightarrow c = -2
$$
故：
$$
P_2(n) = -2
$$
因此，解為：
$$
T(n) = c_1 2^{n} + c_2 (-1)^{n} + 2 \cdot n \cdot 2^n - 2
$$
帶入初始條件，得：
$$
\begin{cases}
T(0) = c_1 + c_2 - 2 = 0 \newline
T(1) = 2c_1 - c_2 + 2 = 0
\end{cases}\Rightarrow c_1 = 0, c_2 = 2
$$
故：
$$
T(n) = 2 \cdot (-1)^{n} + 2 \cdot n \cdot 2^{n} - 2
$$

## 2. 

特徵方程式為：
$$
r^2 - 4r + 3 = 0 \Rightarrow r = -3, -1
$$
因此通解 $G(n)$ 為：
$$
G(n) = c_1 3^n + c_2 1^n
$$
令特解 $P(n)$ 為：
$$
P(n) = a \cdot n \cdot 1^{n} = an
$$
帶回方程式：
$$
an = 4a(n - 1) - 3a(n - 2) - 10
$$
因此：
$$
a = 5
$$
故：
$$
P(n) = 5n
$$
因此，解的形式為：
$$
T(n) = c_13^{n} + c_2 + 5n
$$
帶入初始條件：
$$
\begin{cases}
T(0) = c_1 + c_2 = 2 \newline
T(1) = 3c_1 + c_2 + 5 = 9
\end{cases}
$$
解得：
$$
\begin{cases}
c_1 = 1 \newline
c_2 = 1
\end{cases}
$$
故解為：
$$
T(n) = 3^{n} + 1 + 5n
$$

## 3. 

令：
$$
K(n) = nT(n) - \lg n
$$
則原遞迴關係可改寫為：
$$
K(n) = 
\begin{cases}
2K(n - 1) & \text{ if } n > 1\newline
2 & \text{ if }n = 1
\end{cases}
$$
顯然：
$$
K(n) = 2^{n}
$$
故：
$$
K(n) = 2^{n} = nT(n) - \lg n
$$
解得：
$$
T(n) = \frac {2^{n} + \lg n}{n}
$$

## 4. 

將原式改寫為：
$$
\frac {T(n)}{n + 3} = \frac {T(n - 1)}{n + 5} + \frac {1}{2} \left(\frac {1}{n + 3} - \frac {1}{n + 5}\right)
$$
即：
$$
\frac {T(n) - \frac {1}{2}}{n + 3} = \frac {T(n -1) - \frac {1}{2}}{n + 5}
$$
令：
$$
K(n) = T(n) - \frac {1}{2}
$$
因此：
$$
K(n) = \frac {n + 3}{n + 5}K(n - 1)
$$
試著逐步展開觀察：
$$
\begin{align}
K(n) &= \frac {n + 3}{n + 5}K(n - 1)\newline
&= \frac {(n + 3)(n + 2)}{(n + 5)(n + 4)}K(n - 2)\newline
&= \dots \newline
&= \frac {\prod_{i = 1}^{n - 1}(n + 4 - i)}{\prod_{i = 1}^{n - 1}(n + 6 - i)}K(1)
\end{align}
$$
即：
$$
K(n) = \frac {(n + 3)!}{(4!)} \cdot \frac {6!}{(n + 5)!}K(1) = \frac {30}{(n + 5)(n + 4)}K(1) = \frac {15}{(n + 4)(n + 5)}
$$
因此：
$$
T(n) = \frac {15}{(n + 4)(n + 5)} + \frac {1}{2} = \frac {15}{n + 4} - \frac {15}{n + 5}  + \frac {1}{2}
$$

驗證：


$$
(n + 5)T(n) = 15 \cdot \frac {n + 5}{n + 4} - 15  + \frac {(n + 5)}{2} = \frac {15}{n + 4} + \frac {n + 5}{2}
$$

$$
(n + 3)T(n - 1) + \frac {1}{2} = 15 - 15 \cdot \frac {n + 3}{n + 4}  + \frac {(n + 3)}{2} + \frac {1}{2} = \frac {1}{n + 4} + \frac {n + 5}{2}
$$



