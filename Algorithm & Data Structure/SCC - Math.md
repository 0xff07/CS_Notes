# Strongly Connected Components - Math

## Def (Strongly Connected Component)

$G = (V, E)$ 是個有向圖，$C \subseteq V$ 是個 $G$ 的 connected component。若：
$$
\forall u,v \in G.\ u \leadsto v \text{ and } v \leadsto u
$$
且：
$$
\forall w \in V \setminus C.V \cup \{w\} \text{ is not a connected component}
$$
則稱 $C$ 是個 Strongly Connected Component.

---

更精簡的訂法：
$$
\text{SCC is the equivalent class of  "mutually reachable"}
$$

---

### Observation (轉置後 SCC 不變)

$G = (V, E)$ 是一張有向圖，則：
$$
U \text{ is a SCC of }\ G \iff U \text{ is a SCC of }\ G^T
$$

---

假定 $G$ 中 $u \overset{p_1}{\leadsto} v$ 且 $v \overset{p_2}{\leadsto} u$。則顯然 $G^\text{T}$ 中  $v \overset{p_1^\text T}{\leadsto} u$ 且 $u \overset{p_2^\text T}{\leadsto} v$，因此在 $G$ 中連通的各點，在 $G^\text T$ 中仍然連通。

因為 $G = (G ^ \text T)^ \text {T}$，所以 $G^\text T$ 中連通的各點，在 $G$ 中也保持連通。

所以知道：
$$
u, v\text{ mutually reachable in }G \iff u, v \text{ mutually reachable in }G^{\text{T}}
$$
由此得證。

---

###  Lemma (SCC 們是個 DAG)

$G = (V, E)$ 是一張有向圖，$C', C$ 是 $G$ 相異的 SCC，$u, v \in C$，$u',v' \in C'$，則：
$$
u \leadsto u' \Rightarrow v' \not \leadsto v
$$

---

若 $v \leadsto v'$，則對於 $C$ 中的任意點 $w$ 及 $C'$ 中任一點 $w'$ ：
$$
\begin{align}
& w \leadsto u \newline
& u \leadsto u' \newline
& u' \leadsto w'
\end{align}\Rightarrow w \leadsto w'
$$
及：
$$
\begin{align}
& w' \leadsto v' \newline
& v' \leadsto v \newline
& v \leadsto w
\end{align}\Rightarrow w' \leadsto w
$$
故 $C'$，$C$ 都不是 Strongly Connected Component，矛盾。

---

## Def (Discovery and Finish Time for Sets of Vertices)

$G = (V, E)$ 是一張有向圖，$U \subseteq V$，則定義 DFS 的起始與結束時間：
$$
\begin{cases}
d(U) = \min \left(\{u.d\mid u \in U\}\right)\newline \newline
d(U) = \max \left(\{u.d\mid u \in U\}\right)\newline
\end{cases}
$$

---

### Lemma (邊的指向就是遍歷順序)

$G = (V, E)$ 是一張有向圖，$C', C$ 是 $G$ 相異的 SCC。假定 $v \in C$，$v' \in C'$，且 $(v, v') \in E$，則：
$$
f(C) > f(C')
$$

---

假定 $d(C) < d(C')$，令 $x \in C$ 是 $C$ 中第一個被發現的點。在 $x.d$ 時間時，$C, C'$ 全白。對於任意 $w' \in C'$：
$$
x \leadsto v \to v' \leadsto w
$$
是一條全白路徑。因此 $C$ 中所有點都是 $x$ 的子節點。由 Nestings 得證。

假定 $d(C) > d(C')$，假定 $x'$ 是 $C'$ 中第一個發現的點。因 $d(C) > d(C')$，故在 $x'.d$ 時， $C$ 為全白。由 Lemma 知 ：
$$
\neg \exists u \in C,u' \in C'.(u',u) \in E
$$
所以在 $x'.d$ 時：
$$
\forall w \in C. x' \cancel{\xrightarrow{\mathtt{WHITE}}} w
$$
因此 $C$ 中任意點，都不是 $x'$ 的子節點。由 Nestings 的狀況 1. 知 $C$ 中每一點的 $f$ 值都比 $C'$ 中每一點的 $f$ 值大。由此得證。

---

如果把 SCC 收縮之後的圖想成 DAG，再用 DAG 的性質下去做感覺也可以？

---

### Corollary 

$G = (V, E)$ 是一張有向圖，$C', C$ 是 $G$ 相異的 SCC。假定 $v \in C$，$v' \in C'$，且 $(v', v) \in E^T$，則:
$$
f(C) > f(C')
$$

---

$$
(v',v) \in E^T \iff (v,v') \in E
$$

因為 $G$ 和 $G^T$ 的 SCC 相同，因此套用 Lemma 即得證。

---

