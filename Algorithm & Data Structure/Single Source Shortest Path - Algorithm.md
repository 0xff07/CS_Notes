# Single Source Shortest Path - Algorithm

## Problem (Single Source Shortest Path)

### 輸入

一張圖 $G = (V, E)$ ，權重函數 $w : E \to \R$，某一個起點 $s \in V$，且 $G$ 沒有負環。

### 輸出

對於任意 $v \in V$，尋找路徑 $s\overset{p}{\leadsto}v$，使得：
$$
w(p) = \sum_{e \in p} w(e)
$$
最小。

---

## Scheme : Initialization and Relaxation

在進行 Single Source Shortest Path 的計算前，通常會把圖初始化成下面那樣：

```pseudocode
INITIALIZE(G, S):
	for v in V:
		v.d <- INFINITY
		v.pi <- NIL
	s.d <- 0
```

接著用特定順序「更新」到每個點的最短距離。這個步驟叫做「鬆弛」：

```
RELAX (u, v, w):
if v.d > u.d + w(u, v):
	v.d <- u.d + w.d
	v.pi <- u
```

要用什麼順序進行鬆弛？這就是要設計的地方。後面設計的演算法中，其實只是在初始化之後，用某個特定的「鬆弛順序」依序更新到每個點的最短路徑，並且說明這個順序是正確的。

一些對於鬆弛的「順序」粗略的想法包含：

1. 暴力鬆弛整張圖到不能再鬆弛，畢竟最短路徑最多也只有 $|V|$ 個點。
2. 有 Optimal Substructure，所以可以期待有某種像 DP 的方式可以找到最短路徑。
3. 如果更進一步這張圖還是個 DAG，那填表順序應該可以更簡化。

---

## Relaxation

中文有翻譯稱作「鬆弛」，Relaxation 嚴格來說不是一種演算法，它是一個接下來的演算法中會用到的一個小步驟：

```pseudocode
RELAX (u, v, w):
if v.d > u.d + w(u, v):
	v.d <- u.d + w.d
	v.pi <- u
```

白話文是：如果發現先走到 $u$ 點，再 $(u,v)$ 邊，長度比原來的路徑短，那就把最短路徑換成這條。

注意吃的參數是一條邊，所以 `RELAX` 的對象是某條邊。

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

### Thm (Upper-Bound Property)

1. $G$ 經過初始化之後，無論程式對任意點執行多少次 `RELAX`，以下性質必定成立 ：

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

對鬆弛次數 $n$ 歸納。 

$n = 0$：初始化後 $\forall v \in V.\ \ v.d = \infty \geq \delta(s, v)$ 顯然成立。

$n > 0$：假設第 $n - 1$ 次鬆弛時，這件事對所有點仍然成立。若第 $n$ 次鬆弛發生在 $v \in V$：

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
且：
$$
w(p) = \delta(s, v_k)
$$
定義 `RELAX` 的順序 $\mathtt{R} = \langle \mathtt{relax(v_i, v_{i + 1}, w):i = 0\dots k-1} \rangle$。

若 $\mathtt{R}$ 是某個鬆弛順序 $\mathtt{S}$ 的子序列，則在所有 $\mathtt S$ 的鬆弛動作結束之後：
$$
v_k.d = \delta(s, v_k)
$$

---

把

## Bellman-Ford Algorithm

```pseudocode
BELLMAN_FORD(G)
INITIALIZE(G) // 把 d 都設成無限
for i in 1 ... |V|-1:
	for (u,v) in E:
		if u.d + w(u,v) > v.d
			v.d = u.d + w(u,v)
			v.pi = u
```

直觀來說：

最長的最短路徑也只有 $|V|$ 個點，所以暴力把全部邊 `RELAX` $|V| - 1$ 次之後，就沒更長的路徑能 `RELAX` 了。只有一種狀況例外：圖有負環。所以如果發現再 `RELAX`  1 次時，還有點的值被更動，就知道有負環。

