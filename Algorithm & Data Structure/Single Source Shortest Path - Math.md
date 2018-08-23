# Single Source Shortest Path - Math

## Problem (Single Source Shortest Path)

### 輸入

一張圖 $G = (V, E)$ ，權重函數 $w : E \to \R$，某一個起點 $s \in V$。

### 輸出

對於任意 $v \in V$，尋找路徑 $s\overset{p}{\leadsto}v$，使得：
$$
w(p) = \sum_{e \in p} w(e)
$$
最小。

## Def (Shortest Path Weight)

$$
\delta(u, v) = \begin{cases}
\min \{w(p)\mid u \overset{p}{\leadsto} v\} & \text{if } u \leadsto v\newline \newline
\infty & \text{otherwise}
\end{cases}
$$

### Def (Shortest Path)

$$
\{p \mid w(p) = \delta(u,v)\}
$$

### Thm (Triangular Inequality)

$$
\forall (u,v) \in E.\delta(s,v) \leq \delta(s,u) + w(u,v)
$$

---

假定存在 $p_1$, $p_2$ 兩條各往 $u, v$ 的最短路徑。因：
$$
\begin{cases}
s \overset{p_1}{\leadsto} u,\ w(p_1) = \delta(s,u) \newline
s \overset{p_2}{\leadsto} v,\ w(p_2) = \delta(s,v) \newline
(u,v) \in E
\end{cases}
\Rightarrow s \overset{p}{\leadsto}v\text{ , where }p = p_1 +\!\!\!\!+\ v
$$
所以：
$$
\begin{align}
w(p) \leq \delta(s, v) \Rightarrow w(p) &= w(p_1) + w(u,v) \newline
&= \delta(s, u) + w(u,v)\newline
& \leq \delta(s, v)
\end{align}
$$

---

## Lemma (最短路徑的子路徑都是最短路徑)

若：
$$
p = \langle v_0 ... v_k \rangle
$$
滿足：
$$
\begin{align}
\forall 0& \leq i \leq j \leq k.\newline
&p_{ij} = \langle v_i ... v_j \rangle \text{ is a shortest path from $v_i$ to $v_j$}
\newline
\end{align}
$$

---

不然就可以構造出更短的最短的路徑，然後矛盾。

## Observation (最短路徑沒有環)

### Observation (有負環，沒最短路徑)

假定 $p$ 是一個最短路徑，而且中間有一個負環。那麼多繞一圈負環就會產生一個更短的最短路徑。矛盾。

---

### Observation (最短路徑沒有正環)

把所有環砍掉後會得到一條更短的最短路徑。

---

## Observation (最短路徑至多 |V| - 1 條邊)

因為最短路徑必定 simple，而最長的 simple path 只可能有 $|V|$ 個頂點，也就是 $|V| - 1$ 條邊。

---

## Def (Shortest Path Tree)

若 $G'$ 滿足：
$$
G'(V', E'),\text{ where }\begin{cases}
V' = \{u \mid u \in V, s \leadsto u\} \newline
E' \subseteq E
\end{cases}
$$


且：
$$
\begin{align}
\forall v & \in V.\exists!\ p. \newline 
& s\overset{p} {\rightsquigarrow} v \text{,  and   }w(p) = \delta(s, v)
\end{align}
$$
則稱 $G'$ 是一個「Shortest Path Tree」。

---

## (Algo) Relaxaton

```pseudocode
REXATION (u, v, w)
if v.d > u.d + w(u, v)
	v.d = u.d + w.d
	v.pi = u
```

### Thm (Upper-Bound Property)

無論程式對 $G$ 執行多少次 `RELAX` ：
$$
\begin{align}
\forall & v \in V.\newline
& v.d \geq \delta(s, v)
\end{align}
$$
且在任意時刻，若：
$$
v.d = \delta(s, v)
$$
則在這之後，任意次的 Relax 都不會影響 $v.d$ 的值。

---

### Thm (No-Path Property)

$$
\neg (\exists p.s \overset{p}{\leadsto}v) \Rightarrow v.d = \delta(s,v) = \infty 
$$

---

