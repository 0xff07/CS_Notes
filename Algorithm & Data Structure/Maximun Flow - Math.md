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

---

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

一個網路流 (Flow Network) 由一個有向圖 $G = (V, E)$，以及一個「容量函數」 $c$ 組成。其中：

$G$ 滿足：
$$
\begin{cases}
    (u, v) \in E \Rightarrow (v, u) \not \in E & (\text{no parallel edges})\newline 
    \forall v \in V.(v, v) \not\in E & \text{(no self-loop)} \newline
    \end{cases}
$$
且圖中存在一個「源點」 $s \in V$ 與一個「匯點」 $t \in V$，滿足：
$$
\exists s, t.\forall v \in V.s\leadsto v\leadsto t
$$

$c$ 滿足：
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

因為是個「函數」，所以一組 $(u, v)$ 只能有一個 $c(u, v)$ 值，也就暗示重邊是不允許的。但重邊的容量可以加總起來，因此問題又回到沒重邊的狀況。

---

## Def (Flow)

假定 $G = (V, E)$  是個網路流，$c$ 是網路流的容量函數， $s$ , $t$ 分別為源點與匯點。$G$  上的一個流(Flow) 是一個函數：
$$
f : V \times V \to \mathbb R^+ \cup \{0\}
$$
並且該函數滿足：
$$
\begin{cases}
\forall u, v \in V.0 \leq f(u,v)\leq c(u, v) &(\text{Capacity Constrain})\newline \newline
\forall u \in V \setminus\{s, t\}.\sum_{v \in V}f(v, u)= \sum_{v \in V}f(u, v) & \text{(Flow Conservation)} \newline 
\end{cases}
$$

---

類似地，因為是個 $f$ 函數，所以一個 $(u, v)$ 只有一個 $f(u, v)$ 值，但重邊的流量可以加總起來，因此問題又回到沒重邊的狀況。

---

### Observation

$$
\forall (u, v) \not \in E.f(u, v) = 0
$$

---

因為容量函數的定義為：
$$
c(u, v)  \begin{cases}
    \geq 0 & \text{if $(u,v) \in E$} \newline
    =0 & \text{if $(u,v)\not \in E$}
    \end{cases}
$$
因此，若 $(u, v) \not \in E$，$c(u, v) = 0$，而 $0 \leq f(u, v) \leq c(u, v) = 0$，因此 $f(u, v) = 0$。

---

### Def (Value)

假定 $f$ 是一個 flow，則 $f$ 的 value 定義為：
$$
|f| := \sum_{v \in V}f(s, v) - \sum_{v \in V}f(v, s)
$$

---
Value 的意思像是「從源點流出的淨流量」。

---

## Residual Network

### Def (Residual Capacity)

假定 $G = (V, E)$ 是一個網路流，$c$ 是 $G$ 的容量函數，$f$ 是一個 $G$ 上的流。則 $G$ 「剩餘容量」是一個函數：
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

$c_f$ 直觀上的意義：

1. 如果原來的網路流 $G$ 在加上 $f$ 之後， $u$ 往 $v$ 的容量有剩，那麼 $(u, v)$ 方向的容量，就是剩餘的容量。
2. 如果在 $f$ 中，有 $v$ 往 $u$ 的成分，那麼這個成分可以拿來抵銷反方向(也就是 $v$ 往 $u$ 的流)的流，因此可以有反方向的容量。

---

### Def (Residual Network)

假定 $G = (V, E)$ 是個網路流，容量函數為 $c$。若 $f$ 是一個 $G$ 上的流，則 $f$ 的「剩餘網絡」$G_f$ 定義為：
$$
G_f = (V_f, E_f) ,\text{ where }\begin{cases}
V_f = V \newline\newline
E_f = \{(u, v) \mid (u, v) \in V \times V,\text{ and }c_f(u, v) > 0\}
\end{cases}
$$
其中，$E_f$ 稱作「殘留邊」(Residual Edge)

---

照定義來看，「剩餘網絡」並不是一個網路流。因為依照前面對網路流的定義，一個網路流必須滿足 $(u, v )\in E \Rightarrow(v, u) \not \in E$。但 $G_f$ 在 $0 < f(u, v) < c(u, v) $ 時，$c_f(u, v)$ 跟 $c_f(v, u)$ 都不為 0，因此 $(u, v) \in E_f$ 且 $(v, u) \in E_f$。

---

### Def (Flow on Residual Network)

一個剩餘網絡 $G_f = (V, E_f)$ 上的流 $f'$ 定義為：
$$
f' : V \times V \to \mathbb R
$$
其中：
$$
\begin{cases}
\forall u, v \in V.0 \leq f'(u,v)\leq c_f(u, v) &(\text{Capacity Constrain})\newline \newline
\forall u \in V \setminus\{s, t\}.\sum_{v \in V}f'(v, u)= \sum_{v \in V}f'(u, v) & \text{(Flow Conservation)}
\end{cases}
$$

---

跟網路流的流定義是完全一樣的。只是因為剩餘網路並不是個網路流，但前面定義的流是在 $G$ 是網路流的基礎上，所以多寫一次。

---

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

### Observation

$$
(f \uparrow f') \text{ is a flow in }G
$$

---

要證什麼東西是個流，就是要證明它滿足流的兩個限制。

(Capacity Constrain)：目標是 $\forall (u, v) \in E.0 \leq (f\uparrow f')(u, v) \leq c(u, v)$

$ (f\uparrow f')(u, v) \leq c(u, v)$：對於任一邊 $(u, v) \in E$：
$$
\begin{align}
&\begin{cases}
0 \leq f(u, v) \leq c(u, v) & \quad (1)\newline
0\leq f'(u, v) \leq c_f(u, v) = c(u, v) - f(u, v) & \quad(2)\newline
0\leq f'(v, u) \leq c_f(v, u) = f(u, v) & \quad(3)
\end{cases}\newline\newline

\Rightarrow &  f'(u, v) + f(u, v) \leq c(u, v) & \text{by (1), (2)}\newline
\Rightarrow & f'(u, v) + f(u,v) - f'(v, u) \leq c(u,v) - f'(v, u) \leq c(u,v) & \text{左右同減 $f'(v, u)$}
\end{align}
$$
$0 \leq (f\uparrow f')(u, v)$：另一方面：
$$
\begin{align}
f'(v, u) \leq f(u, v) & \Rightarrow\  0\leq f(u, v) - f'(v, u) &\text{(3)} \newline
&\Rightarrow\  f'(u,v)\leq f(u, v) - f'(v, u) + f'(u, v) & \text{(左右同加 $f'(u,v)$)}\newline
&\Rightarrow\ 0\leq f(u, v) - f'(v, u) + f'(u, v) & \text{($f'(u,v)\geq 0$)}
\end{align}
$$
因滿足容量限制。

(Flow Conservation)：證明方向大概是 $f, f'$ 守恆 $\Rightarrow$ $(f\uparrow f')$ 守恆。

對於任意 $v \in V$。由定義知 $f$ 與 $f'$ 都滿足 Flow Conservation。因此對於任意 $u \in V \setminus\{s, t\}$：
$$
\begin{align}
\sum_{v \in V}(f \uparrow f')(u, v) &= \sum_{v\in V}\left(f(u,v) + f'(u,v) - f'(v,u)\right) & \text{(定義)}\newline
&= \sum_{v\in V}f(u,v) + \sum_{v\in V}f'(u,v) - \sum_{v\in V}f'(v,u) &\text{(爆開)}\newline
&= \sum_{v\in V}f(v,u) + \sum_{v\in V}f'(v,u) - \sum_{v\in V}f'(u,v) & \text{(Flow Cons. of $f, f'$)}\newline
&= \sum_{v\in V}f(v,u) + f'(v,u) - f'(u,v) \newline
&=\sum_{v \in V}(f \uparrow f')(v, u)
\end{align}
$$

---

### Lemma

$$
|f \uparrow f'| = |f| + |f'|
$$

---

因為 $G$ 無重邊，因此 $(s, v)$ 或 $(v, s)$ 只有其中一個存在。令：
$$
\begin{cases}
V_{out} &= \{v \mid (s, v) \in E\} \newline
V_{in} &= \{v \mid (v, s) \in E\}
\end{cases}
$$
根據網絡流的定義，有 $\forall v \in V.(s, v) \in G \Rightarrow(v, s) \not \in G$，所以可知：
$$
V_{in} \cap V_{out} = \varnothing
$$
而由 $V_{in}$ 與 $V_{out}$ 的定義，顯然有：
$$
V_{in} \cup V_{out} \subseteq V
$$
依照 Value 的定義：
$$
\begin{align}
|f\uparrow f'| &= \sum_{v \in V_{out}}\left(f(s, v) + f'(s, v) - f'(v, s)\right) -\sum_{v \in V_{in}}\left(f(v, s) + f'(v, s) - f'(s, v)\right)\newline
&= \left(\sum_{v \in V_{out}}f(s, v) - \sum_{v \in V_{in}}f(v, s)\right) + \newline  &\quad\ \left(\left(\sum_{v \in V_{out}}f'(s, v) + \sum_{v \in V_{in}}f'(s, v)\right) - \left(\sum_{v \in V_{out}}f'(v, s) + \sum_{v \in V_{in}}f'(v, s)\right)\right) \newline
&= \left(\sum_{v \in V_{out}}f(s, v) - \sum_{v \in V_{in}}f(v, s)\right) + \left(\sum_{v \in V_{in}\cup V_{out}}f'(s, v) - \sum_{v \in V_{in}\cup V_{out}}f'(v, s)\right)
\end{align}
$$
因為由 Observation 知道 $\forall (u, v) \not \in E.f(u,v) = 0$，故：
$$
\forall v \in V - \left(V_{in}\cup V_{out}\right).f(v,s) = f(s, v) = 0
$$
所以可以把上式的 $\sum$ 範圍寫成整個 $V$：
$$
\begin{align}
|f\uparrow f'| &= \left(\sum_{v \in V_{out}}f(s, v) - \sum_{v \in V_{in}}f(v, s)\right) + \left(\sum_{v \in V_{in}\cup V_{out}}f'(s, v) - \sum_{v \in V_{in}\cup V_{out}}f'(v, s)\right) \newline
&= \left(\sum_{v \in V}f(s, v) - \sum_{v \in V}f(v, s)\right) + \left(\sum_{v \in V}f'(s, v) - \sum_{v \in V}f'(v, s)\right) \newline
&= |f| + |f'|
\end{align}
$$

---


## Def (Augmenting Path)

若 $G$ 是一個網路流，$f$ 是一個上面的流。若剩餘網絡 $G_f$ 上的路徑 $p$ 滿足：
$$
\begin{cases}
s \overset {p}{\leadsto} t\newline 
p \text{ is a simple path on } G_f \newline
\end{cases}
$$
則稱 $p$ 是一個「增廣路徑」(Augmenting Path)。

---

### Def (Residual Capacity of Augmenting Path)

若 $p$ 是一個增廣路徑，則 $p$ 的 Residual Capacity 定義為：
$$
c_f(p) = \min \{c_f(u, v) : (u, v) \in p\}
$$

---

### Observation (增廣路徑的流)

假定 $p$ 是一個增廣路徑，則：
$$
f_p = \begin{cases}
c_f(p) & \text{if } (u, v) \in p \newline
0 & \text{otherwise}
\end{cases}
$$
是個 $G_f$ 上的流，並且 $f_p$ 滿足：
$$
|f_p| = c_f(p) > 0
$$

---

假定這條路徑是：
$$
p = \langle v_0, v_1 \dots v_k \rangle \quad \text{where} \begin{cases}
v_0 = s\newline
v_k = t
\end{cases}
$$
因為 $f_p(u, v)$ 不是 $0$ ，就是 $\min \{c_f(u, v) : (u, v) \in p\}$，故：
$$
\forall (u, v) \in V \times V.f_p(u, v) \leq c_f(u, v)
$$
因此滿足容量限制。又：
$$
\begin{align}
\forall i \in \{1...k-1\}.&\sum_{u \in V} f_p(u, v_i) = \sum_{u \in p} f_p(u, v_i) = f_p(v_{i-1},v_i) = c_f(p) \newline
& \sum_{v \in V} f_p(v_i, v) = \sum_{v \in p} f_p(v_i, v) = f_p(v_{i},v_{i+1}) = c_f(p) \newline\newline
\Rightarrow &\sum_{u \in V} f_p(u, v_i) = \sum_{v \in V} f_p(v_i, v)
\end{align}
$$
因此也滿足 Flow Conservation。

### Corollary

$$
|f \uparrow f_p| = |f| + |f_p| > 0
$$

---

因為$f$ 是 $G$ 上的流， $f_p$ 是 $G_f$ 上的流，套用 Lemma 即得。

---

## Def (Cut)

若 $G = (V, E)$ 是個網路流， 一個 $G$ 的分割 $C$ 是一對集合的 pair $C = (S, T)$，並且滿足 ：
$$
\begin{cases}
s \in S \subseteq V & \text{and}\newline
t \in T = V - S
\end{cases}
$$

---

### Def (Cut-Set)

假定 $C = (S, T)$ 是一個網路流 $G$ 的分割，則 $C$ 的 cut-set 定義為：
$$
X_C = \{(u, v)\mid (u, v) \in E, u \in S, v \in T, \} = (S \times T)\cap E
$$

---

### Def (Net Flow between Cut)

若 $G$ 是一個網路流，  $C = (S, T)$ 是一個 $G$ 的分割。則分割 $(S, T)$ 之間的「淨流」定義為：
$$
f(S, T) = \sum_{(u, v) \in X_C} f(u, v) - \sum_{(u, v) \in X_c} f(v, u)
$$

---

### Def (Minimum Cut)

若一個 網路流 $G$ 的分割 $(S_m, T_m)$ 是所有分割中，使 $f(S_m, T_m)$ 最小的。則稱 $(S_m, T_m)$ 是一過 minimum cut。

---

### Def (Capacity of Cut)

若 $G$ 是一個網路流，  $C = (S, T)$ 是一個 $G$ 的分割。則分割 $(S, T)$ 之間的「容量」定義為：
$$
c(S, T) = \sum_{(u, v \in X_C)}c(u, v)
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

這不就是流體版的 Control Surface 嗎！



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

---

Yeah

---

這樣就把最大流問題，變成一個 Reachability 的問題。