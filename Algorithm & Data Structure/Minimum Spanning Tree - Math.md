# Algorithm : Minimun Spanning Tree

## Problem (Minimun Spanning Tree)

#### 輸入

一張連通的無向圖 $G = (V, E)$，權重函數 $w：E \to \mathbb R$

#### 輸出

請構造一棵樹 $M = (V, E_M)$，$E_M \subseteq V$，使得：
$$
\sum_{e \in M}w(e)
$$
最小。

---

這個問題的直覺其實只有一個：==對於任何一個點，他伸出去（想要說成進入也可以，反正是無向圖）的邊中權重最小的那條，一定會在 Minumun Spanning Tree 裡面==。證明方法很簡單，假定那條邊沒有在 MST 裡面，那把 MST 中，連到這個點的邊移除，換成那條最小的邊，就可以構造出權重更小的 MST（然後就矛盾，所以這條邊一定要在裡面）（然後這樣就可以開始刷題目了）。

---

## Def (Cut)

$G = (V, E)$。是一張無向圖。則一個 $G$ 的「分割」(cut)，定義為：
$$
(S, V - S)
$$
其中 $S \subseteq V$。

白話文就是把一張圖的點們分割成兩個集合。

### Def (Cross)

$G = (V, E)$，$(S, V - S)$ 是 $G$ 的一個分割。若 $e = (u, v) \in E$ 滿足：
$$
\begin{cases}
u \in S\text{ and } v \in V - S & \text{or}\newline
u \in V - S\text{ and } v \in S
\end{cases}
$$

白話文：「端點各自在 $S$ 跟 $V - S$ 當中」。

### Def (Repects)

假定 $(S, V - S)$ 是 $G$ 的一個分割。若對於某一個邊的集合 $E$，$(S, V - S)$ 滿足：
$$
\neg\left(\exists (u, v) \in E.(u,v)\text{ crosses $(S, V-S)$}\right)
$$
則稱 $(S, V - S)$ respects $E$。

白話文就是：這個集合包含的所有邊，沒有一條穿越這個 cut 所定義的兩個頂點的集合，就稱作這個分割「repects」這個邊的集合（這還真不知道中文要怎麼翻）。

### Def (Light Edge)

$G = (V, E)​$，$(S, V - S)​$ 是 $G​$ 的一個分割。若 $e = (u, v) \in E​$ 穿越 $(S, V - S)​$ ，且滿足：
$$
w(e) = \min \{c\mid c \in E, \text{and $c$ crosses }(S, V - S)\}
$$
則稱 $e$ 是一個 Light Edge。

可以觀察到：如果允許邊的權重可以重複，那麼這樣的邊未必唯一。

### Observation

可以發現：定義一個分割之後，會把圖上所有邊分成三類：兩個端點都在 $S$ 裡面、兩個點都在 $V - S$ 裡面，以及一個端點在 $S$，一個端點在 $V - S​$ 的邊。然後就想要猜：如果已經找出兩個分割形成的圖各自的生成樹，那是不是把這兩顆生成樹用彼此之間權重最小的邊連起來，就找出整張圖的最小生成樹了？答案是可以的。

---

## Thm (合併 MST)

$G = (V, E)​$ 是一張無向圖，且 $G​$ 連通。$w : E \to \mathbb R​$ 是一個權重函數。若：
$$
\exists T',T'\text{ is a MST}.A \subseteq E\left(T'\right)
$$
 且：
$$
A \text{ respects }(S, V-S)
$$
則：
$$
\begin{align}
(u, v) & \text{ is a light edge crossing }(S, V - S) \newline 
& \Rightarrow \exists T,T\text{ is a MST}.A \cup \{(u,v)\} \subseteq E(T)\newline
&
\end{align}
$$

---

假定 $T'$ 是一個不含 $(u, v)$ 的 MST，且 $A \subseteq T'$。

1. 因 $T'$ 是 MST，故 $\exists (x, y) \in T'$.$(x, y)$ crosses $(S, V - S)$ 。否則 $(S,V-S)$ 之間的點不連通。
2. 但 $T'$ 中連接 $(S, V - S)$ 的邊只能有一條，否則將形成環，與 $T'$ 是樹的前提矛盾。
3. 因此，$(x,y)$ 是 $T'$ 中連接 $(S,V-S)$ 的唯一邊。

因為 $A$ respects $(S, V-S)$，故可知：
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

3. $A \subseteq T$。因為定義 $T$ 時，唯一被去掉的邊 $(x, y) \not\in A$：
	$$
	\begin{cases}
	A \subseteq T' & (\text{前提})\newline
	T = T' \setminus\{(x, y)\}\cup \{(u, x)\} & (\text{$T'$ 的定義})\newline
	(x, y) \not \in A  & (\text{A respects})
	\end{cases}
	\Rightarrow A \subseteq T
	$$


這時計算 $T$ 的權重：
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
\end{cases} \quad \Rightarrow
A\cup\{(u,v)\} \subseteq T
$$
由此得證。

