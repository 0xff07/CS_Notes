## Problem (Maximum Flow)

### 輸入

給定一張圖 $G = (V, E)$，以及一個源點 $s \in V$，匯點 $t \in V$ ，以及一個容量函數 (Capacity Function) ：
$$
c : V \times V \to \mathbb R^+ \cup \{0\}
$$
其中，$G$ 與 $s$, $t$ 兩點滿足：
$$
\begin{cases}
(u, v) \in E \Rightarrow (v, u) \not \in E \newline
\forall v \in V.(v, v) \not\in E & \text{(no self-loop)} \newline
\forall v \in V.s\leadsto v\leadsto t
\end{cases}
$$
而 $c$ 滿足：
$$
c(u, v)  \begin{cases}
\geq 0 & \text{if $(u,v) \in E$} \newline
=0 & \text{if $(u,v)\not \in E$}
\end{cases}
$$

### 輸出

尋找一個函數 $f$：
$$
f : V \times V \to \mathbb R^+ \cup \{0\}
$$
在滿足以下的狀況下：
$$
\begin{cases}
\forall u, v \in V.0 \leq f(u,v)\leq c(u, v) \newline \newline
\forall u \in V \setminus\{s, t\}.\sum_{v \in V}f(v, u)= \sum_{v \in V}f(u, v) 
\end{cases}
$$
使得：
$$
|f| := \sum_{v \in V}f(s, v) - \sum_{v \in V}f(v, s)
$$
最大。

---

## Def (Flow Network)

網路流 (flow network) 由一張有向圖 $G = (V, E)$，以及一個容量函數 $c$ 組成。其中：

1. $G$  滿足：
$$
  \begin{cases}
    (u, v) \in E \Rightarrow (v, u) \not \in E \newline
    \forall v \in V.(v, v) \not\in E & \text{(no self-loop)} 
    \end{cases}
$$
  且存在一個「源點」 $s$ 與一個匯點 $t$，滿足：
$$
  \exists s, t.\forall v \in V.s\leadsto v\leadsto t
$$

2. $c$ 滿足：
$$
  c:V \times V \to \mathbb R^+ \cup \{0\}
$$
  且：
$$
  c(u, v)  \begin{cases}
    \geq 0 & \text{if $(u,v) \in E$} \newline
    =0 & \text{if $(u,v)\not \in E$}
    \end{cases}
$$
---

## Def (Flow)

假定 $G = (V, E)$  是個網路流，$c$ 是網路流的容量函數， $s$ , $t$ 分別為源點與匯點。$G$  上的一個流(Flow) 是一個函數：
$$
f : V \times V \to \mathbb R^+ \cup \{0\}
$$
並且滿足：
$$
\begin{cases}
\forall u, v \in V.0 \leq f(u,v)\leq c(u, v) &(\text{Capacity Constrain})\newline \newline
\forall u \in V \setminus\{s, t\}.\sum_{v \in V}f(v, u)= \sum_{v \in V}f(u, v) & \text{(Flow Conservation)}
\end{cases}
$$

---

### Def (Value)

假定 $f$ 是一個 flow，則 $f$ 的 value 定義為：
$$
|f| := \sum_{v \in V}f(s, v) - \sum_{v \in V}f(v, s) 
$$

---
## Residual Network

### Def (Residual Capacity)

假定 $G = (V, E)$ 是一個 flow network，$c$ 是 $G$ 的 Capacity Function，$f$ 是一個 $G$ 上的 flow。則 $f$ 的 Residual Capacity 定義為函數：
$$
c_f : V \times V \to \mathbb R^+ \cup \{0\}
$$
其中：
$$
c_f = \begin{cases}
c(u, v) - f(u, v) & \text{if $(u, v) \in E$} \newline
f(v, u) & \text{if $(v, u) \in E$} \newline
0 & \text{otherwise}
\end{cases}
$$

---

$c_f$ 的感覺有點像是：

1. 如果 $u$ 往 $v$ 的容量有剩，那麼 $(u, v)$ 方向的容量，就是剩下的容量。
2. 如果有 $v$ 往 $u$ 的流，那麼這個流可以拿來抵銷反方向的流，也就是 $v$ 往 $u$ 的流。 

### Def (Residual Network)

假定 $G = (V, E)$ 是個網路流，容量函數為 $c$。若 $f$ 是一個 $G$ 上的流，則 $f$ 的「殘留網路」$G_f$，定義為：
$$
G_f = (V_f, E_f) ,\text{ where }\begin{cases}
V_f = V \newline\newline
E_f = \{(u, v) \mid (u, v) \in V \times V,\text{ and }c_f(u, v) > 0\}
\end{cases}
$$
其中，$E_f$ 稱作「殘留邊」(Residual Edge)

---

「殘留網路」並不是一個「網路流」。因為依照前面網路流的定義，一個網路流必須滿足 $(u, v )\in E \Rightarrow(v, u) \not \in E$。但 $G_f$ 在 $0 < f(u, v) < c(u, v) $ 時，$c_f(u, v)$ 跟 $c_f(v, u)$ 都有定義，因此 $(u, v) \in E_f$ 且 $(v, u) \in E_f$。

### Def (Flow on Residual Network)

若 $G_f$ 是個殘留網路，一個殘留網路上的流 $f'$ 定義為：
$$
\begin{cases}
\forall u, v \in V_f.0 \leq f'(u,v)\leq c_f(u, v) &(\text{Capacity Constrain})\newline \newline
\forall u \in V_f \setminus\{s, t\}.\sum_{v \in V_f}f'(v, u)= \sum_{v \in V_f}f'(u, v) & \text{(Flow Conservation)}
\end{cases}
$$

---

跟網路流的流定義是完全一樣的。只是因為殘留網路並不是個網路流，但前面定義的流是在 $G$ 是網路流的基礎上，所以多寫一次。

## Def (Augmentation)

假定 $G$ 是一個網路流，容量函數為 $c$，$f$ 是一個 $G$ 上的流。假定 $G_f$ 是殘留網路，$f'$ 是一個 $G_f$ 上的流，則 augmentation of flow $f$ by $f'$ ，$f \uparrow f'$，是一個函數：
$$
(f \uparrow f') : V \times V \to \mathbb R
$$
其中：
$$
(f \uparrow f')(u, v) = \begin{cases}
f(u, v) + f'(u, v) - f'(v, u) & \text{if (u, v)} \in E \newline\newline
0 & \text{otherwise}
\end{cases} 
$$

---

把一個流跟一個殘流網路的流合併成一個流。

### Lemma

$$
|f \uparrow f'| = |f| + |f'|
$$

## Def (Augmenting Path)

若 $G$ 是一個網路流，$f$ 是一個上面的流。若一個 $G_f$ 上的路徑 $p$ 滿足：
$$
p \text{ is a simple path on } G_f
$$
則稱 $p$ 是一個「增廣路徑」(Augmenting Path)。

---

### Def (Residual Capacity of Augmenting Path)

若 $p$ 是一個增廣路徑，則 $p$ 的 Residual Capacity 定義為：
$$
c_f(p) = \min \{c_f(u, v) : (u, v) \in p\}
$$

---

### Lemma (增廣路徑的流)

假定 $p$ 是一個增廣路徑，則：
$$
f_p = \begin{cases}
c_f(p) & \text{if } (u, v) \in p \newline
0 & \text{otherwise}
\end{cases} \quad\text{is a flow in }G_f
$$
且滿足：
$$
|f_p| = c_f(p) > 0
$$

---

### Corollary

$$
|f \uparrow f_p| = |f| + |f_p| \geq 0
$$

---

因為$f$ 是 $G$ 上的流， $f_p$ 是 $G_f$ 上的流，套用 Lemma 即得。

---

## Def (Cut)

若 $G = (V, E)$ 是個網路流， 一個 $G$ 的分割是一對集合的 pair $(S, T)$，並且滿足 ：
$$
\begin{cases}
s \in S \subseteq V & \text{and}\newline
t \in T = V - S
\end{cases}
$$

---

### Def (Net Flow between Cut)

若 $G$ 是一個網路流，  $(S, T)$ 是一個 $G$ 的分割。則分割 $(S, T)$ 之間的「淨流」定義為：
$$
f(S, T) = \sum_{u \in S}\sum_{v \in T} f(u, v) - \sum_{u \in S}\sum_{v \in T} f(v, u)
$$

---

### Def (Minimum Cut)

若一個 網路流 $G$ 的分割 $(S_m, T_m)$ 是所有分割中， $f(S_m, T_m)$ 最小的。則稱 $(S_m, T_m)$ 是一過 minimum cut。

---

### Def (Capacity of Cut)

若 $G$ 是一個網路流，  $(S, T)$ 是一個 $G$ 的分割。則分割 $(S, T)$ 之間的「容量」定義為：
$$
c(S, T) = \sum_{u \in S} \sum_{v\in T}c(u, v)
$$

---

### Lemma (圖論版 Control Surface 分析！)

假定 $G$ 是一個網路流，$s \in V$ 是個源點，$t \in V$ 是個匯點，$(S, T)$ 是 $G$ 的一個分割，則：
$$
\begin{align}
\forall \text{ cut } (S, T)\text{ of }G,\text{ flow }f \text{ of }G.\ \ f(S, T) = |f|
\end{align}
$$

---

### Corollary 

任意網路流 $G$ 上的流 $f$，都有：
$$
\forall \text{ cut } (S, T)\text{ of }G,\text{ flow }f \text{ of }G.\ \ f(S, T) \leq c(S, T)
$$

---

## Thm (Max-Flow Min-Cut Theorem)

若 $f$ 是一個網路流 $G$ 上的流，則下列 3 個敘述等價：
$$
\begin{cases}
1.\ f \text{ is a maxmimun flow in G} \newline\newline
2. \ G_f \text{ exists no augmenting path} \newline \newline
3. \ \exist\text{ cut }(S, T)\text{ of }G.|f| = c(S, T)
\end{cases}
$$


