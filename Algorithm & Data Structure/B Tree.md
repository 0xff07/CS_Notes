# B Tree

## Def (B Tree)

一個 *B Tree* $T$ 是一顆有根樹（根用 $T.root$ 表示） ，並且滿足以下性質：

`1`：每個點當中會有以下的資料：
$$
\begin{cases}
n & \text{(節點中的資料數目)}\newline
key_1 \dots key_n & \text{(存資料的陣列)}\newline
leaf & \text{(若為 TRUE，則為不存資料的葉。反之則為 internal Node)}\newline
c_1 \dots c_{n + 1} & \text{(指向子樹的節點)} \newline
t & \text{(Biswas 用的符號是 B)}
\end{cases}
$$
`2` ：$key_1 \dots key_n$ 中的資料滿足：
$$
\forall i < j.\ key_i \leq key_j
$$
`3`：每一個根節點往葉節點的簡單路徑都一樣長，等於樹的高度 $h$

`4`：資料至少半滿：
$$
t - 1\leq n< 2t - 1
$$
