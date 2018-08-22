# Algorithm : Minimun Spanning Tree

## Problem (Minimun Spanning Tree)

#### 輸入

一張圖 $G = (V, E)$，權重函數 $w：E \to \R$

#### 輸出

請構造一張圖 $M = (V, E_M)$，$E_M \subseteq V$，使得：
$$
\sum_{e \in M}w(w)
$$
最小。

---

## Def (Cut)

$G = (V, E)$。是一張無向圖。則一個 $G$ 的「分割」(cut)，定義為：
$$
(S, V\setminus S)
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

$G = (V, E)$ 是一張無向圖，且 $G$ 連通。$w : E \to \R$ 是一個權重函數。假定 $A \subseteq E\left(\text{MST}(G)\right)\subseteq E(G)$ ，且 $A$ respects $(S, V - S)$。則：
$$
\begin{align}
(u, v) & \text{ is a light edge crossing }(S, V - S) \newline 
& \Rightarrow A \cup \{(u,v)\} \subseteq E(\text{MST}(G))\newline
&
\end{align}
$$

---

