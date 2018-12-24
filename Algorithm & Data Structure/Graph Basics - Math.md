# Data Structure : Graph Basics

# Def (Graph)

一個圖 (Graph)  $G = (V, E)$  由兩個部分組成：

1. $V$ 是一個有限的集合，稱作 Virtices。

2. $E$ 是一個 V 上的 Binary Relation，稱作 Edge Set。這個 Relation 通常用 $(\_,\_)$ 表示。

3. 如果 $E$ 是 ordered pair，則這個圖稱作「有向圖」;  如果 $E$ 是 unordered pair，則稱作無向圖。 

---

1. 雖然 $E$ 中的元素有 order/unordered 之別，但符號上都用 $(u, v)$ 表示。
2. 在無向圖中 $(u, v) \not\Rightarrow (u, v)$; 但有向圖中 $(u, v) \Rightarrow (u, v)$

---

# Def (Incident)

1. 若 $G = (V, E)$ 是有向圖，且 $(u, v) \in E$，則稱 $(u, v)$ 「incident from / leaves u」，且「incident to / enters v」。
2.  若 $G = (V, E)$ 是無向圖，且 $(u, v) \in E$，則稱 $(u, v)$ 「incident on u and v」。

---

1. 其實這比較像英文的用語介紹。
2. 接下來的內文為了方便，在有向圖中，用「從 $u$ 離開」表示「incident from/leaves u」 ; 用「進入 $u$」表示「incident to / enters v」。
3. 用「經過 $u$ 的邊」表示「incident on u」。

---

# Def (Degree)

1. 若 $G = (V, E)$ 是個有向圖，$u \in V$, 則：


     1. In-degree of $u$：進入 $u$ 的邊數。


     $$
       d_{u, i} = |\{(i, u)| (i, u) \in E\}|
     $$


     2. Out-degree of $u$：從 $u$ 出發的邊數。


     $$
            	d_{u, o} = |\{(u, i)| (u, i) \in E\}|
     $$


     3. Degree of u：$u$ 的 in-degree 加 out-degree。
    
     	$$
     	\deg(u) = d_{u, i} + d_{u, o}
     	$$





2. 若 $G = (V, E)$ 是個無向圖，且 $u\in V$，則： 
    1. Degree of $u​$：


    $$
      \deg(u) = |\{(u, i) | (u, i) \in E\}|
    $$

---

# Thm (Hand-Shaking Lemma)

假定 $G = (V, E)$ 是個無向圖，則：

$$
\sum_{u\in V} \deg(u) = 2|E|
$$

---

因為無向圖的 adjacency matrix 對稱，由此得證。

用邊來計數 Degree 的數目即得。

歸納法：

1. 圖為空，顯然成立
2. 假定一張圖 $G = (V, E)$  滿足 hand-shaking lemma，則任意增加一個邊， deg 增加 2，因此仍然為偶數。

## Corollary

degree 為奇數的節點一定有偶數個

---

# Def (Path)

一個從 $u$ 到 $u'$，長度為 $k$ $\geq 0$ 的 path,  $p$, 定義為一個由 $V$ 中的元素形成的序列：
$$
p = \langle v_0, v_1...v_k \rangle
$$

 且該序列滿足「$(v_i, v_{i + 1})$ 是邊」「頭尾分別是 $u$, $u'$」即：

$$
\begin{cases}
  v_0 = u \newline 
  v_k = u' \newline
  \forall i \in \{0 ... k-1\}.(v_i, v_{i + 1}) \in E
  \end{cases}
$$

---

用：
$$
u  \overset{p}{ \leadsto } v
$$

  來說明 $p$ 是一個從 $u$ 到 $v$ 的 path

---

## Def (Simple) 

若 $u \overset{p}{\leadsto} u'$，且 $p$ 的長度為 $k$。若 $p$ 中沒有重複經過的點，即：
$$
\forall(i, j) \in \{(i, j)|0\leq i, j \leq k, i\neq j\}.v_i \neq v_j
$$

---

## Def (Cycle) 

若 $u \overset{p}{\leadsto} u'$，且：

$$
u = u'
$$

則稱 $p$ 為一個 「cycle」。

---

# Def (Reachable) 

$G = (V, E)$ 是一張圖。若 $u, v \in V$ ，且：

$$
\exists p.u \overset{p}{\leadsto}v
$$

 則稱「$v$ is reachable from $u$ via $p$」。

---

1. $k$ 可以是 0，所以不管是否 $(u, u)$，$u$ 自己一定跟自己是 reachable 的。

---

# Def (Connected) 

$G = (V, E)$ 是一張圖。假定：

$$
\forall {u, u'} \in V.u \overset{}{\leadsto}u'
$$

則稱圖是 Connected. 

---

# Def (Cyclic Graph) 

$G = (V, E)$ 。假定：

$$
\exists p.p\ \mathrm{is\ a\ cycle}
$$

 則稱 $G$ 是 cyclic。

---

# Thm : 無向圖有 Path ⇒ 有 Simple Path

$G = (V, E)$ 是個無向圖。則：
$$
u \overset{p}{\leadsto} v\Rightarrow u\overset{p'}{\leadsto}v,p'\text{is simple}
$$

---

$|V| = 2$: 只有兩個點。顯然成立。

假定 $|V| = |V'| - 1$ 時命題成立，則對於任意 $u, v \in V$：

1. $u, v \in V'$：由歸納法假設可知命題成立。

2. $u \in V', v\not \in V'$，且 $u, v$ 存在 path，且僅有最後一個點為 $v$。令該 path 為：


$$
p = \langle u, u_1 ... u_{k-1}, v \rangle
$$

3. 由歸納法假設知 $u, u_{k-1}$ 間存在 simple path, $p'$。又 $v \not \in V'$，故 $v \not \in p'$，因此可知 $p$ 為一 simple path。
4. $u \in V', v\not \in V'$，且 $u, v$ 存在 path，且 $v$ 不只最後一個點為 $v$：
  * 假定 $v$ 第一次出現在 $u_k$
  * 取 $p' = \langle u, ...u_{k}\rangle$
  * 由於 $p'$ 中 $v$ 僅在最後出現，故套用 2. 可知 $u, u_k = v$ 之間存在 simple path。

---

# Thm：Undirected, Connected ⇒ |E|  ≥ |V| - 1

1. |V| = 1 原題顯然成立。

2. 假定 $|V| = |V'| + 1$，隨便挑出一個點 $v \in V$，並令剩下的子圖 $G' = (V', E')$ 。$V = V' \cup \{v\}$, $v \not \in V'$, $E' \subset E$：

     已知：$|E'| \geq |V'| - 1$，且 $|V| = |V'| + 1$。若原圖 $G = (V, E) = ( V' \cup \{v\}, E)$ 連通，則 $\exists u \in V'.(u, v) =: e \in E$，否則 $v$ 不連通。而 $v \not \in V'$，故 $e \not \in E'$，因此：



$$
|E| \geq |E'| + 1 \geq|V'| + 1=|V|
$$
3. 由數學歸納法知原題成立。

# Def (Isomorphism of Graphs)

假定 $G_1 = (V_1, E_1)$，$G_2 = (V_2, E_2)$。若：
$$
\exists f : V_1 \to V_2,f\text{ bijective}.\forall\{u,v\}\subseteq V.\{u,v\} \in E \iff\{f(u), f(v)\} \in E_2
$$

## Def (Graph Invariant)

 properties preserved by isomorphism：

1. 節點數目
2. 邊的數目
3. 最大/最小的 degree
4. degree sequence
5. length of simple cycles
6. Connectivity
7. Euler/Hamiltonian Path
8. Planarity
9. Coloring