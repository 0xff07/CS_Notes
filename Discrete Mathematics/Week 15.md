# Euler's Formula

對於任意「簡單」「平面」圖「畫法」，有：
$$
r = e - v + c + 1
$$
其中：
$$
\begin{cases}
r & \text{#of regions}\newline
v & \text{#of vertices} \newline
e & \text{#of edges} \newline
c & \text{#of components} \newline
\end{cases}
$$
使用歸納法：

==n = 0==：顯然成立

==n = k==

假定再加入一條邊 $\{u, v\}$，則：

Case 1：假定 u, v 在同一個 Connected Component，則增加這個邊時：
$$
\begin{cases}
r =r+1\newline
v = v \newline
e = e + 1 \newline
c = c
\end{cases}
$$
因此維持不變。

Cse2：假定他們在不同的 Component。這時：
$$
\begin{cases}
r =r\newline
v = v \newline
e = e + 1 \newline
c = c - 1
\end{cases}
$$
因此仍然維持。

證明的關鍵是因為：邊沒有重疊，所以可以確定 region 增加時只會有那幾種狀況。

# Thm

對於任意簡單平面圖畫法：
$$
\text{if }e > 2\text{ then }3r \leq 2e
$$

> Def (Degree of region)
> $$
> \deg(R) = \text{# of edges surrounding the region}
> $$
>

可以觀察：

$$
\sum \deg(R) = 2e
$$

因為每個邊內、外都被數到一次。因為除了外圍之外，要形成一個 Region，至少要有 3 個邊。因此：
$$
\underbrace{\sum \deg(R)}_{\leq 3r} = 2e
$$
故：
$$
3r \geq\sum \deg(R) = 2e
$$
這裡有一個小細節：如果只有 1 個邊，還是可以形成 region（就是最外圍那個）。不過，因為前面已經有

## Thm

對於任意平面圖（i.e. 只要有一種畫法是平面圖）。找出那個平面圖的畫法，套用前面的定理：
$$
e \leq 3v - 6
$$
因：
$$
e \geq \frac {3}{2}r
$$
以及 Euler's Formula：
$$
\frac {2}{3}e \geq r = e - v + c + 1 \geq e - v + 2 \Rightarrow e \leq 3v - 6
$$

### Corollary

$K_5$ 不是平面圖。

因為 $v = 5$。$e = 10$，$10 > 3 \cdot 5 - 6$。

### Corollary

任意簡單的平面圖，都存在一個節點 $v$，$\deg(v) \leq 5$

反證：假定這個點不存在，表示：
$$
\forall v_i \in V.\deg(v_i)\geq 6
$$
因此：
$$
\sum\deg(v_i)\geq 6 v
$$
但根據 Hand-Shaking Lemma：
$$
2e = \sum\deg(v_i)\geq 6 v
$$
與 Thm 矛盾。

## Thm

# Sufficient Condition of Planar Graph

## Def (Subdivision o Graph)

### Thm 

Subdivision of a non-planar graph is also not a planar graph

## Thm (Kuratowski)

$$
G\text{ 是平面圖 } \iff \exists G' \subseteq G.G'\text{ is isomorphic to subdivision of }K_{3,3}\text{ or }K_5
$$

# Graph Coloring

## Def (Coloring)

圖的「著色方式」是一個函數：
$$
f : V \to \text{colors}
$$
且 $f$ 滿足「相鄰的節點，顏色不同」。

## Def

給定一個圖 $G$，$G$ 的 Chromatic Number, $\chi(G)$, 定義為「使圖合法著色的最少顏色」。

## Thm

任意平面圖 $G$：
$$
\chi (G) \leq 6
$$
對節點數目使用歸納法：

==v <= 6==：顯然成立

==v = k + 1> 6==

對於任意有 $k + 1 $ 個節點的平面圖，存在一個節點 $v$，使得 $v \leq 5$。

將 $v$ 以及其相鄰的邊移除。剩下的圖：

1. 因為有 $k$ 個節點，而且也是平面圖，因此有 6 色的著色法
2. 把邊裝回去，因為 $v$ 最多只有 5 個相鄰的邊，至少有一個顏色沒有用到。把 $v$ 著上剩下的顏色就好。