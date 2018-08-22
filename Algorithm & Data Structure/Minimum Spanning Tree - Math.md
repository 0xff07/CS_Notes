# Algorithm : Minimun Spanning Tree

## Problem (Minimun Spanning Tree)

#### 輸入

一張圖 $G = (V, E)$，權重函數 $w：E \to \R$

#### 輸出

請構造一棵樹 $M = (V, E_M)$，$E_M \subseteq V$，使得：
$$
\sum_{e \in M}w(e)
$$
最小。

---

## Def (Cut)

$G = (V, E)$。是一張無向圖。則一個 $G$ 的「分割」(cut)，定義為：
$$
(S, V - S)
$$
其中 $S \subseteq V$。

---

### Def (Cross)

$G = (V, E)$，$(S, V - S)$ 是 $G$ 的一個分割。若 $e = (u, v) \in E$ 滿足：
$$
\begin{cases}
u \in S\text{ and } v \in V - S & \text{or}\newline
u \in V - S\text{ and } v \in S
\end{cases}
$$

---

白話文：「端點各自在 $S$ 跟 $V - S$ 當中」。

---

### Def (Repects)

假定，$(S, V - S)$ 是 $G$ 的一個分割。若對於某一個邊的集合 $E$，$(S, V - S)$ 滿足：
$$
\neg\left(\exist (u, v) \in E.(u,v)\text{ crosses $(S, V-S)$}\right)
$$
則稱 $(S, V - S)$ respects $E$。

---

這還真不知道中文要怎麼翻。

---

### Def (Light Edge)

$G = (V, E)$，$(S, V - S)$ 是 $G$ 的一個分割。若 $e = (u, v) \in E$ 穿越 $(S, V - S)$ ，且滿足：
$$
w(e) = \min \{c\mid c \in E, \text{and $c$ crosses }(S, V - S)\}
$$
則稱 $e$ 是一個 Light Edge。

---

未必唯一。

---

## Thm (合併 MST)

$G = (V, E)$ 是一張無向圖，且 $G$ 連通。$w : E \to \R$ 是一個權重函數。假定存在一個 MST，$T$，使：
$$
A \subseteq E\left(T\right)
$$
 且：
$$
A \text{ respects }(S, V-S)
$$
則：
$$
\begin{align}
(u, v) & \text{ is a light edge crossing }(S, V - S) \newline 
& \Rightarrow A \cup \{(u,v)\} \subseteq E(T)\newline
&
\end{align}
$$

---

假定 $T'$ 是一個不含 $(u, v)$ 的 MST。

1. 因 $T'$ 是 MST，故 $\exists (x, y) \in T'$.$(x, y)$ crosses $(S, V - S)$ 。否則 $(S,V-S)$ 之間的點不連通。
2. 但 $T'$ 中連接 $(S, V - S)$ 的邊只能有一條，否則將形成環，與 $T'$ 是樹的前提矛盾。
3. 因此，$(x,y)$ 是 $T'$ 中連接 $(S,V-S)$ 的唯一邊。

因為 $A$ respects $(S, V-S)$，故可以知道
$$
(x, y) \not\in A
$$
令 $T$：
$$
T =  T' \setminus \{(x, y)\}\cup \{(u, v)\}
$$
則可知：

1. 因 $(x,y)$ 是 $T'$ 中連接 $(S, V-S)$ 的唯一邊。故 $T '\setminus \{(x, y)\}$ 會變成分屬  $(S, V - S)$ 的兩棵樹。

2. 但 $T'$ 又加上了 $\{(u, v)\}$ ，因此兩棵樹又恢復連通，變回一棵樹。

3. $A \subseteq T$：因為定義 $T$ 時唯一被去掉的邊 $(x, y) \not\in A$：
	$$
	\begin{cases}
	A \subseteq T'\newline
	T = T' \setminus\{(x, y)\}\cup \{(u, x)\}\newline
	(x, y) \not \in A
	\end{cases}
	\Rightarrow A \subseteq T
	$$


這時計算 $T'$ 的權重：
$$
\begin{align}
w(T) &= w(T') - w(x,y) + w(u,v) \newline
&\leq w(T') \newline \newline 
 (\ (u&,v)\text{ 是 light edge} \Rightarrow w(x, y) \geq w(u,v))
\end{align}
$$
但 $T'$ 是 MST，因此：
$$
w(T') \leq w(T)
$$
綜合起來：
$$
w(T) = w(T')
$$
故 $T$ 也是個 MST，且：
$$
\begin{cases}
(u,v) \in T & (\text{T 的定義}) \newline
A \subseteq T & (\text{上面 3. })
\end{cases}\Rightarrow
A\cup\{(u,v)\} \subseteq T
$$
由此得證。

