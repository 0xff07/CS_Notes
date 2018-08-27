# Single Source Shortest Path - Algorithm 2

## Bellman-Ford Algorithm

```pseudocode
BELLMAN_FORD_BASIC(G, w, s)
INITIALIZE_SINGLE_SOURCE(G, s) // 把 d 都設成無限
for i in 1 ... |V|-1:
	for (u,v) in E:
		if u.d + w(u,v) > v.d
			v.d = u.d + w(u,v)
			v.pi = u
```

這個演算法的出發點是這樣：最長的最短路徑也只有 $|V|$ 個點，所以暴力把全部邊 `RELAX` $|V| - 1$ 次之後，Path-Relaxation Property 就直接說所有 $v.d = \delta(s, v)$ 了，而且也沒更長的路徑能 `RELAX` 了。

只有一種狀況例外：圖有負環。所以如果發現再 `RELAX`  1 次時，還有點的值被更動，就知道有負環。把偵測負環的部分加進去，就會變成 CLRS 版的 Bellman-Ford：

```pseudocode
BELLMAN_FORD(G, w, s)
INITIALIZE_SINGLE_SOURCE(G, s)
for i = 1 to |G.V| - 1:
	for each (u,v) in G.E:
		RELAX(u, v, w)
for each (u,v) in G.E:
	if v.d > u.d + w(u,v):
		return FALSE
return TRUE
```

code 寫出來，接下來就是正確性的證明：

### Lemma (沒負環的話，Code 是對的)

假定 $G$ 中沒有 $s$ 到的了的負環，則開始執行第 6 行之前：
$$
\forall v \in V.\ \ v.d = \delta(s, v)
$$

------

乍看之下像是 Path-Relaxation Property 的直接結論，事實上也是使用 Path-Relaxation Property。

對於任意 $s$ 到 $v \in V$ 的最短路徑：
$$
p = \langle v_0, v_1 \dots v_k \rangle\text{  where $v_0 = s$, $v_k = v$}
$$
都是 Simple Path，因此必定滿足：
$$
k \leq |V| - 1
$$
而在 3 到 5 行的 $|V| - 1$ 次迴圈執行中，每一次都鬆弛了 $G$ 中所有的邊，所以第 $i$ 次執行必定包含 $\mathtt{RELAX(v_i, v_{i + 1}, w)}$。因此到迴圈執行結束前，一定會依序把所有 $p$ 中的邊鬆弛過至少一次。由 Path-Relaxation Property 知道迴圈結束後：
$$
v_k.d = \delta (v_0, v_k) \Rightarrow v.d = \delta(s, v)
$$

------

#### Corollary

若 $G$ 中沒有 $s$ 可以到達的負環，則在程式執行開始執行第 6 行之前：
$$
\forall v \in V. s\leadsto v \iff v.d < \infty
$$

------

($\Rightarrow$)：因為$s\leadsto v \Rightarrow \delta(s, v) < \infty$，而 Lemma 知道這時 $v.d = \delta(s, v)$，因此 $v.d = \delta(s, v) < \infty$ 成立。

($\Leftarrow$)：如果 $s \not \leadsto v$，則由定義 $\delta(s, v) = \infty$，立刻矛盾。

------

## Thm (Correctness of Bellman-Ford Algorithm)

在 `BELLMAN_FORD(G, w, s)` 結束執行之後，回傳 `TRUE` 或 `FALSE` 的條件為：

 `TRUE` ：如果 $G$ 沒有 $s$ 到得了的負環。且這時：

1. $\forall v \in V.\ \ v.d = \delta(s, v)$
2. $G_{\pi}$ 是個 $s$ 為根的 Shortest-Path Tree

`FALSE`：如果 $G$ 沒有 $s$ 到得了的負環。

------

`TRUE`：

若沒有 $s$ 到的了的負環，上面那堆性質都會成立。由 Lemma 知程式開始執行第 6 行前：
$$
\begin{align}
\forall (u, v) \in E.\ v.d &= \delta(s, v)\newline
& \leq \delta(s, u) + w(u, v) & \text{(三角不等式)} \newline
&= u.d + w(u,v) & \left(\delta(s, u) = u.d\right)
\end{align}
$$
永遠不可能滿足第 7 行的 `if v.d > u.d + w(u,v)`。故永遠不可能執行到 `return FALSE`。直到迴圈結束後，執行到最後一行時 `return TRUE`。

而對於 (1.) 的敘述：

1. $s \not\leadsto v$，則由 No-Path Property 知道一直到程式結束前， $v.d = \delta(s, v)$ 

1. $s \leadsto v$，上一個 Lemma 就把它證完了。

對於 (2. ) ，直接套用 Predecessor Subgraph Property 得證。

`FALSE`：

若有 $s$ 到得了的負環，假定該負環為：
$$
\langle v_0, v_1 \dots v_k\rangle\text{  where $v_0 = v_k$}
$$
反證：假定這時回傳 `TRUE`，則對於任意邊，第 7 行的 `if v.d > u.d + w(u,v)` 永遠不可能滿足。故：
$$
\forall i \in \{0\dots k-1\}.v_{i + 1}.d \leq v_i.d + w(v_{i-1}, v_i)
$$
對 $c$ 中的邊全部加總起來：
$$
\sum_{i = 0}^{k-1}v_{i + 1}.d \leq \sum_{i = 0}^{k-1}v_i.d + \sum_{i =0}^{k-1}w(v_{i-1}, v_i)
$$
但 $v_0 = v_k \Rightarrow v_0.d = v_k.d$，故：
$$
\sum_{i = 0}^{k-1}v_{i + 1}.d = \sum_{i = 0}^{k-1}v_i.d
$$
左右同時消去。得：
$$
0 \leq \sum_{i =0}^{k-1}w(v_{i-1}, v_i)
$$
與 $c$ 是負環的假設矛盾。因此一定在某個時刻會滿足 `if v.d > u.d + w(u,v)`，這時便執行 `return FALSE`。

---

## Dijkstra Algorithm

做 BFS，不過是對以 $v.d$ 為 key 的 `Priority Queue` 做 BFS： 

```pseudocode
DIJKSTRA(G, w, s):
INITIALIZE_SINGLE_SOURCE(G, s)
S = {}
Q = MIN_QUEUE(G.V)
while !Q.EMPTY():
	u = Q.EXTRACT_MIN()
	S = SＵ{u}
	for each v in G.Adj[u]:
		RELAX(u, v, w)
```

### Claim 

在執行過程中：
$$
\forall v \in S.\ \ v.d = \delta(s, v)
$$

---

(INITIALIZE) ：$s.d = 0 = \delta(s, s)$，顯然成立。

(MAITENANCE)：假定存在某一個時刻：

1. $u \in S$，但 $u.d \neq \delta(s, u)$。
2. 由於 $s.d = \delta(s, s)$ 一開始就對，所以 $u \neq s$
3. 由於 $u\neq s$，因此在把 $u$ 加入 $s$ 之前， $S \neq \varnothing$。因為至少有 $s$。
4. 再由 $u.d \neq \delta(s, u)$ 可以知道 $s \leadsto u$，否則由 No-Path Property，無論怎麼鬆弛， $u.d = \delta(s, u) = \infty$。
5. 因為 $s \leadsto u$，所以 $s, u$ 間必定存在最短路徑 $p$