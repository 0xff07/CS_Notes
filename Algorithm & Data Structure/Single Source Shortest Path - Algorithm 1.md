# Single Source Shortest Path - Algorithm 1

## Problem (Single Source Shortest Path)

### 輸入

一張圖 $G = (V, E)$ ，權重函數 $w : E \to \R$，某一個起點 $s \in V$，且 $G$ 沒有可以從 $s$ 到達的負環。

### 輸出

對於任意 $v \in V$，在初始化過後，尋找路徑 $s\overset{p}{\leadsto}v$，使得：
$$
w(p) := \sum_{e \in p} w(e) = \delta(s, v)
$$
---

## Scheme : Initialization + Relaxation

這邊所有的演算法都是建立在這樣的架構之下：

1. 進行初始化：`INITIALIZE_SINGLE_SOURCE(G, s)`
2. 對圖中的邊進行一連串的「鬆弛」來更新最短距離：`RELAX(u, v, w)`

`RELAX` 這個動作會有一些性質，可以幫助我們設計出可以求出最短距離的各種演算法。

### Initialization 

在進行 Single Source Shortest Path 的計算前，通常會把圖初始化成下面那樣：

```pseudocode
INITIALIZE_SINGLE_SOURCE(G, S):
	for v in V:
		v.d <- INFINITY
		v.pi <- NIL
	s.d <- 0
```

出發點自己到自己的最短距離是 0，而在所有動作開始前，假設出發點 $s$ 到所有點的最短距離是 $\infty$。

接下來只要有發現更短的距離與路徑，就把資訊更新。這個「更新」的步驟，稱作 `RELAX`。

### Relaxation

`INITIALIZE_SINGLE_SOURCE` 之後，接著會用特定順序「更新」到每個點的最短距離。這個步驟叫做「鬆弛」：

```
RELAX (u, v, w):
if v.d > u.d + w(u, v):
	v.d <- u.d + w.d
	v.pi <- u
```

白話文是：如果發現先走到 $u$ 點，再 $(u,v)$ 邊，長度比原來的路徑短，那就把最短路徑換成這條。注意吃的參數是一條邊，所以 `RELAX` 的對象是某條邊。

至於要用什麼順序進行鬆弛，才能用最少步找出最短距離？這就是要設計的地方。後面設計的演算法中，其實只是在初始化之後，用某個特定的「鬆弛順序」依序更新到每個點的最短路徑，並且說明這個順序是正確的。

一些對於鬆弛的「順序」粗略的想法包含：

1. 暴力鬆弛整張圖到不能再鬆弛，畢竟最短路徑最多也只有 $|V|$ 個點。
2. 有 Optimal Substructure，所以可以期待有某種像 DP 的方式可以找到最短路徑。
3. 如果更進一步這張圖還是個 DAG，那填表順序應該可以更簡化。

---

### Observation

假定初始化後，某一次鬆弛對 $(u,v) \in E$ 進行。則鬆弛後必定滿足：
$$
v.d \leq u.d + w(u,v)
$$

---

證法是分狀況討論：

1. $v.d > u.d + w(u,v)$：那麼會把 $v.d$ 從原來的值更新成 $u.d + w(u,v)$，因此成立。
2. $v.d \leq u.d + w(u,v)$：鬆弛時不會更動 $v.d$ 的值，所以仍然保持 $v.d \leq u.d + w(u,v)$。

---

## Effects of Relaxations

在進行 `INITIALIZE_SINGLE_SOUTCE(G, s)` ，接著進行一連串 `RELAX` 的過程中，圖中各點的資料會神奇地保持一些性質。這些性質可以幫助理解最短路徑的演算法是怎麼設計的。

### Thm (Upper-Bound Property)

1. $G$ 經過 `INITIALIZE_SINGLE_SOUTCE(G, s)`之後，無論程式對任意點執行多少次 `RELAX`，必定滿足 ：

$$
\begin{align}
\forall & v \in V.\newline
& v.d \geq \delta(s, v)
\end{align}
$$
2. 若在某一次的 `RELAX` 之後：
	$$
	v.d == \delta(s, v)
	$$
	則在這之後，$v.d$ 的值都不會變（不管之後做了多少次 `RELAX`）。
---

這個道理跟 BFS 時一樣，$V.d$ 有限表示有可以從 $s$ 出發走到 $v$ 的路徑，而任意路徑的權重都不應該比最短路徑的權重小。聽起來合理，但程式有沒有符合這件事呢？

對鬆弛次數 $n$ 歸納。 

($n = 0$)：初始化後 $\forall v \in V.\ \ v.d = \infty \geq \delta(s, v)$ 顯然成立。

($n > 0$)：假設第 $n - 1$ 次鬆弛時，這件事對所有點仍然成立。若第 $n$ 次鬆弛發生在 $v \in V$：

1. 如果沒有更動 $v.d$ 的值：直接由歸納法假設說原性質成立。因此如果 $v.d == \delta(s,v)$，由三角不等式：
	$$
	u.d + w(u,v) \leq \delta(s,v)
	$$
	無論如何都不滿足鬆弛中更新 $v.d$ 的條件 `v.d > u.d + w(u, v)`，$v.d$ 永遠不可能再被更新，得證 (2.)  

2. 如果有更動 $v.d$ 的值，則：
	$$
	\begin{align}
	  v.d &= u.d + w(u,v) \newline 
	  &\leq \delta(s,u) + w(u,v) & \text{(歸納法假設)}\newline
	  &\leq \delta(s,v)
	  \end{align}
	$$
	仍然滿足 (1.)。
------

#### Corollary (No-Path Property)

「起點到不了的點，最短距離是 $\infty$」：
$$
\neg (\exists p.s \overset{p}{\leadsto}v) \Rightarrow v.d = \delta(s,v) = \infty
$$

------

這是 Upper-Bound Property 的特例：
$$
\begin{align}
\neg (\exists p.s \overset{p}{\leadsto}v) &\Rightarrow \delta(s, v) = \infty & \text{($\delta$ 的定義)} \newline
& \Rightarrow v.d \geq \delta(s,v) = \infty
 & \text{(No-Path Property)}\end{align}
$$
由此得證。

---

### Thm (Convergence Property)

假定：
$$
\exists u,v \in V.s \leadsto u \to v \text{ is a shortest path}
$$
則若在進行 `RELAX(u, v, w)` 之前：
$$
u.d = \delta(s, u)
$$
則 `RELAX(u, v, w)` 之後：
$$
v.d = \delta(s, v)
$$

且在這之後，無論對 $G$ 進行多少次鬆弛，都會保持 $u.d = \delta(s,v)$。

---

由 Upper-Bound Theorem 可知：假定某一次鬆弛之後，$v.d = \delta(s, u)$，則在這之後不管進行多少次鬆弛，$v.d = \delta(s, v)$，包含在鬆弛 $(u, v)$ 時。

在對 $(u, v)$ 進行鬆弛後：
$$
\begin{align}
v.d &\leq u.d + w(u,v) &\text{(Observation)}\newline
& = \delta(s, u) + w(u,v) & \text{(前提)} \newline
& \leq \delta(s, v) & \text{(三角不等式)}
\end{align}
$$
因此 `RELAX(u, v, w)` 之後：
$$
v.d \leq \delta(s, v)
$$
另一方面，在初始化後任一時候：
$$
v.d \geq \delta(s, v)
$$
因此：
$$
v.d = \delta(s, v)
$$
由此得證。

---

### Thm (Path-Relaxation Property)

假定：
$$
p = \langle v_0, v_1, v_2 \dots v_k \rangle
$$
是條 $v_0 = s$ 到 $v_k$ 的一條最短路徑。定義對整條 $p$  `RELAX` 的順序： 
$$
\mathtt{R} = \langle \mathtt{relax(v_i, v_{i + 1}, w):i = 0\dots k-1} \rangle
$$
則：若 $\mathtt{R}$ 是某個鬆弛順序 $\mathtt{S}$ 的子序列，則在所有 $\mathtt S$ 的鬆弛動作結束之後：
$$
v_k.d = \delta(s, v_k)
$$

---

鬆弛只要「照順序集滿」某條最短路徑的所有邊，就一定會把 $d$ 值更新成最短路徑。

(Base Case)：`INITIALIZE(G, s)` 之後，未進行任何鬆弛步驟之前， $s.d = 0 = \delta(s, s)$，成立。

(Inductive Step)：假設 $\mathtt{\left\langle RELAX(v_j, v_{j + 1}, w):j\in \langle1\dots i-1\rangle \right\rangle}$ 都依序執行過，且 $v_i.d = \delta(s, v_i)$。則：

1. 在鬆弛完 $e_{i - 1} = (v_{i - 1}, v_{i})$，至鬆弛 $e_i = (v_i, v_{i + 1})$ 之前， $v_{i}.d = \delta(s, v_i)$，則之後不管經過多少次鬆弛，由 Upper-Bound Property 可知均保持 $v_{i}.d = \delta(s, v_i)$。

2. 在對 $e_i = (v_i, v_{i + 1})$ 鬆弛時，因 $v_i.d = \delta(s, v_i)$，且由「最短路徑的子路徑也是最短路徑」知 $\langle v_0 ... v_{i + 1} \rangle$ 是一條由 $v_{0}$ 至 $v_{i + 1}$ 的最短路徑。

	因此，由 Convergence Property 知：鬆弛之後 $v_{i + 1}.d = \delta(s, v_{i + 1})$。

	由數學歸納法知原題成立。

## Shortest Path Tree

### Lemma (任意鬆弛後的 Predecessor Graph 是以 s 為根的樹)

`INITIALIZE(G, s)` 後，並經過任意次的鬆馳之後，形成的 $G_{\pi}$ 必定是一棵以 $s$ 為根的樹。

---

(Base Case)：0 次鬆弛，這時候 $G_{\pi} = (\{s\}, \varnothing)$ 顯然是一棵樹。

(Induction Step)：

(Part 1：$s$ 和 $G_{\pi}$ 各點連通)

鬆弛開始之前，$s \leadsto s$，顯然成立。

假定 $n$ 次鬆弛之後，所有更新過 $d$ 值的點 $u$ ，都 $s\leadsto u$，並且在 `RELAX(u, v, w)` 的過程中，將對 $v.d$ 進行更新。

( $v.d < \infty$)：則因 Upper-Bound Property 及 $\infty > v.d \geq \delta(s, v)$ ，知道 $s \leadsto v$。

($v.d = \infty$)：由於 $\delta(s, u)\leq u.d < \infty$，因此 $s \leadsto u$。又此時正將 $v.\pi = u$，故 $(u,v) \in G_{\pi}$，

(Part 2： $G_{\pi}$ 無環)：

假定有環：
$$
c = \langle v_0 ... v_k \rangle\text{.   where }v_0 = v_k
$$
已知 $\forall v \in V_\pi.s \leadsto v$  ，因此 $c$ 中每一點均 reachable from $s$。

Claim：若經過一連串鬆弛後，形成一個環 $c \subseteq G_\pi$，則 $c$ 必定是個負環：

因為 $c = \langle v_0 \dots v_k \rangle \subseteq G_{\pi}$ ，依照鬆弛順序遞推 $v_{k-1}$ 的值：
$$
v_{k-1}.d = v_0.d + \sum_{i = 0}^{k-2}w(v_i, v_{i+1})
$$
因為鬆弛 $(v_{k-1}, v_k) = (v_{k-1}, v_0)$ 時，有更新 $v_{k}.d$，因此：
$$
v_{k-1}.d + w(v_{k-1}, v_k) < v_0.d
$$
即：
$$
v_0.d + \sum_{i = 0}^{k-1}w(v_i, v_{i+1}) < v_0.d
$$
但這表示：
$$
\sum_{i = 0}^{k-1}w(v_i, v_{i+1}) < 0
$$
加上 $v_k = v_0$，因此知道 $c$ 是個可以從 $s$ 到達的負環。矛盾。

(Part 3：$\forall v \in V_\pi$，$s \leadsto v$ 的 simple path 唯一)

假定經過某一個鬆弛順序之後，$v \in G_\pi$ 存在兩條相異的 simple path：
$$
\begin{align}
p_1 = \langle s, v_1 \dots v_n,v \rangle \newline
p_2 = \langle s, v_1',\dots v'_{n'}, v\rangle
\end{align}
$$
WLOG，令 $n' \geq n$。因為 $\forall v \in V_\pi$，$v.\pi$ 唯一。因此：
$$
\begin{align}
v.\pi = v_{n} = v_{n'}'\newline
\end{align}
$$
由上式可繼續知道：
$$
v_n.\pi = v_{n-1} = v_{n' - 1}'.\pi = v_{n'-1}'
$$
繼續遞推，得到：
$$
\forall i \in \{ 0 \dots n-1\}.v_{n - i}.\pi = v_{n-i-1} = v_{n' - i - 1}'.\pi = v_{n'-i-1}'
$$

當 $i = n - 1$ 時：
$$
v_{1}.\pi = s = v_{n' - n}'.\pi = v_{n'-n -1}'
$$
若 $n' > n$，則由對 $p_2$ 的假設知 $s.\pi = v'_{n' - n - 1} \neq \mathtt{NIL}$，與 `INITIALIZE(G, s)` 後的結果矛盾。因此 $n' \leq n$。

又，已知 $n' \geq n$，因此：
$$
n' = n
$$
故得證 $p_1 = p_2$。

### Thm (Predecessor-Subgraph Property)

假定在 `INITIALIZE(G, s)` ，並經過一連串 `RELAX` 後，$G$ 滿足：
$$
\forall v\in V(G).v.d = \delta(s, v)
$$
則 $G_\pi$ 是個 shortest path tree。

---

要證的三件事是：

1. $V(G_{\pi}) $ 恰好是所有可從 $s$ 到達的點。
2. $\forall v \in V(G_\pi).\exists! p.s\overset{p}{\leadsto}v$
3. $\forall v \in V(G_\pi).\exists! p.s\overset{p}{\leadsto}v,w(p) = \delta(s, v)$

(1. ) 由 `RELAX` 定義知：

$$
v.d < \infty \iff v.\pi \neq \mathtt{NIL} \quad \text(1)
$$
由最短路徑的定義知：
$$
\delta(s, v) < \infty \iff v \text{ is reachable from }s \quad (2)
$$
因此，由 Predecessor Graph 的定義，加上 $v.d = \delta(s, v)$ 的前提知：
$$
\begin{align}
\forall v \in V_\pi\setminus \{s\}.v.\pi \neq \mathtt{NIL} &\Rightarrow v.d \underbrace{=}_{前提} \delta(s, v)  \underbrace{\leq}_{(1)} \infty \newline
& \underbrace{\Rightarrow}_{(2)} v \text{ is reachable from }s
\end{align}
$$
(2.) 上一個 Lemma 說 $G_\pi$ 是一棵以 $s$ 為根的樹，故由該 Lemma 直接得到 $s$ 和各點間的 simple path 唯一。

(3.) 假定 $s \overset{p}{\leadsto}v_k$ 是 $G_\pi$ 中 由 $s$ 到 $v_k \in V(G_\pi)$ 的一個 simple path，且：
$$
p = \langle v_0, \dots ,v_k \rangle \text{  where $s = v_0$}
$$
因為 $p$ 中每邊都是鬆弛來的，所以：
$$
v._{i + 1}.d - v_i.d = w(v_i, v_{i + 1})
$$
但已知：
$$
\forall v_i \in V_\pi.\ v_i.d = \delta(s, v_i)
$$
因此：
$$
\forall i \in \{0\dots k-1\}.\delta(s, v_{i+1}) - \delta(s, v_i) = w(v_i, v_{i + 1})
$$
加總起來計算 $w(p)$：
$$
\begin{align}
w(p) &= \sum_{i = 0}^{k-1}w(v_i, v_{i + 1})\newline
&= \sum_{i = 0}^{k-1}\delta(s, v_{i+1}) - \delta(s, v_i)\newline
&= \delta(s, v_k) - \delta(s, v_0) & (v_0 = s)\newline
&= \delta(s, v_k)
\end{align}
$$
由 (1.) (2.) (3.) 得證 $G_\pi$ 是 shortest path tree.

