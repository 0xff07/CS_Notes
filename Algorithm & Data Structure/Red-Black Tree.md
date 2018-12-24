# Red-Black Tree

動機：希望可以改良二元樹，使得樹的高度盡量維持 $\lg n$ 而不是最糟狀況的 $n$ 

## Def (Red-Black Tree)

一個紅黑樹是個滿足以下條件的二元搜尋樹：

1. 每個點可能有兩種顏色：紅、黑
2. 根節點規定為黑色; 若有節點的子節點指向 `NIL` ，則 `NIL` 也視為一個節點，顏色規定為黑色，這樣的節點稱作「leaf」。
3. 每個紅節點的父節點，必定是黑節點。
4. 對於任意一個點 $x$ ，由該節點出發往所屬的 leaf 的所有簡單路徑，都會經過相同數目的黑節點。這個數目稱為 `black-height`。接下來用 $bh(x)$ 表示這個值。 這邊「經過」並不包含路徑的頭跟尾。

---

### Observation

對於任意紅黑樹的內部節點 $x$：
$$
bh(x) \leq h(x)/2
$$

---

由定義 4. 直接得到。

### Thm (Height of Red-Black Tree)

假定 $T$ 是一個有 $n$ 個 Internal Node 的紅黑樹，則：
$$
height(T) \leq 2 \lg (n + 1)
$$

---

#### Lemma

$$
\text{以任意節點 $x$ 為根的子樹，至少有 $2^{bh(x)}-1$ 個節點}
$$

對 $x$ 所在的高度做歸納。假定 $h(x) = 0$ ，則這棵子樹只能是 `NIL` 。因此有 0 個 internal node，故：
$$
2^{bh(x)} - 1 = 0 \leq 0
$$
成立。

對於以任意一個節點 $x$ 為根的子樹，若子節點為黑，則 $bh(子節點) = bh(x) - 1$，若為紅，則 $bh(子節點) = bh(x)$。因此可套用歸納法假設，即：
$$
n \geq 2 \cdot (2^{bh(x)-1} - 1) + 1 = 2^{bh(x)} - 1
$$
由歸納法知 Lemma 成立。

---

#### Proof 

假定紅黑樹的樹高是 $h$，由性質 4 知由根往 leaf 的路徑中， $bh(root) \geq h/2$ 。因此套用 Lemma：
$$
n \geq 2^{h/2} - 1 \Rightarrow 2 \cdot \lg (n + 1) \geq n
$$

---

Erik Demaine 用了一種很神奇的看法：把所有紅節點跟他們的父節點合併，這樣就會產生一個高度為 bh(root) 的 2-3-4 樹。

### Corollary

Query 的複雜度都是 $O(\lg n)$

