# AVL Tree

是在二元搜尋樹為基礎上，多加一些東西，讓二元搜尋樹盡量維持在平衡狀態。

---

# 定義

如果一一棵樹 $T$ 滿足：
$$
\begin{align}
1. & T\text{ is a Binary Search Tree} \newline
2.& \forall \text{ node $v$ that's not a leaf. }|h(\text{v.left}) - h(\text{v.right})| \leq 1
\end{align}
$$
則稱 $T$ 是一顆 AVL 樹。其中 $h(v)$  是以 $v$ 為根的樹之樹高。為了方便，若 $v$ 是葉節點，則 $h(v)$ 定義為 0。

---

## Observation (構造觀察)

假定一顆樹 $T$ 的根節點是 $r$，左右子樹分別是 $T_L$ 跟 $T_R$，則：
$$
\text{T is AVL Tree of height $h \geq 2$ } \iff 
\text{both $T_L$ and $T_R$ are AVL Tree, and }
\begin{cases}
h(T_L) = h - 1,\ h(T_R) = h - 2 & \text{or}\newline
h(T_L) = h - 2,\ h(T_R) = h - 1 & \text{or}\newline
h(T_L) = h - 1,\ h(T_R) = h - 1
\end{cases}
$$
「$\Leftarrow$」：已知 $T_L, T_R$ 是 AVL 樹，所以唯一不可能滿足 AVL 性質的點就是 $r$。但已經知道左右子樹的高度差不超過 1 了，所以根也滿足平衡條件。

「$\Rightarrow$」：因為 $T$ 自己就是一顆 AVL 樹，而 $T_L$, $T_R$ 中的每一個點都在 $T$ 裡面，所以都必須滿足平衡性質。既然 $T_L$ 與 $T_R$ 中每一個點都滿足平衡性質，所以 $T_L$ 與 $T_R$ 都是 AVL 樹。更進一步，$T$ 是一顆 AVL 樹，所以 $|h(T_L) - h(T_R)| \leq 1$，由此得證。

---

## Observation (樹高觀察)

假定 $T$ 是一顆 AVL 樹，且 $T$ 有 $n​$ 個節點，則：
$$
h(T) = O(\lg n)
$$
如果直接從 $n$ 推樹高，因為高度平衡是「差 1」的關係，所以有點難考慮。所以就往另外一個方向問：如果一顆樹的樹高是 $h$，那麼 $n$ 至少要是多少？

令 $n_{min}(h)$ 為「高度 $h$ 時，形成 AVL 樹至少需要的節點樹」。則由暴力窮舉的方式，可以驗證：
$$
\begin{cases}
n_{min}(1) = 1 \newline
n_{min}(2) = 2
\end{cases}
$$
而對於任意 $h \geq 3$，首先觀察：因爲高度 $h$ 的樹，為兩顆 $h - 2 \leq $高度 $\leq h - 1 $ 的子樹加上根節點組成，因此：
$$
n_{min}(h) = 1 + n(h(T_L)) + n(h(T_R))
$$
其中 $n(h(T_L))$ 與 $n(h(T_R))$ 分別是左子樹與右子樹的節點數目。但因為左右至少有一棵樹高度是 $h - 1$，因此：
$$
n_{min}(h) > n_{min}(h - 1) \quad \forall h \geq 3
$$
所以進一步可以推論 $n_{min}$ 是嚴格遞增的： 
$$
n_{min}(h_i) \geq n_{min}(h_j) \quad \forall h_i > h_j
$$
更進一步，由前面「構造觀察」可以知道：若要使高度 $h$ 的 AVL 樹最小，那麼一顆子樹是高度 $h - 2$ 的最小（節點樹最少）的子樹; 而另外一顆子樹要是高度 $h - 1$ 的最小子樹。也就是：
$$
n_{min}(h) = 1 + n_{min}(h - 1) + n_{min}(h - 2) \quad \forall h \geq 3
$$
用看的可以發現差不多就是費式數列的樣子：只要把 $a(h) = n_{min}(h) + 1​$，就會發現：
$$
a(h) = a(h - 1) + a(h - 2)
$$
不過這邊有一個細節，就是邊界條件是 $a(1) = 2$，$a(2) = 3$。但這也沒差，因為只是把費式數列往後移幾個而已。也就是：
$$
a(h) = F_{h + 2} \Rightarrow n_{min}(h) = F_{h + 2} - 1
$$
用一費式數列的公式帶進去，隨便湊一湊就會發現：
$$
n_{min}(h) \geq \frac {1}{2}\phi^{h + 2}
$$
前面那個 $1/2$ 是隨便湊的，這個常數 $c$ 只要比 1 小，但大到足夠使得 $c \cdot \phi^{h + 2}$ 比 1 大就好。湊到這邊就可以發現：
$$
h = O(\lg (n_{min}(h))) = O(\lg n)
$$

---

## Corollary：查詢複雜度

使用 AVL 樹查詢的複雜度是 $O(\lg n)$

# 操作

一開始的插入跟 BST 一樣，唯一不同的地方是高度差有可能會太大，這時候就要進行調整。因為插入時，會間進行搜尋，由根往葉搜尋的那些路徑，所以只要成功插入之後，回溯的過程中，一面更新高度差，一面針對高度差進行調整就好。

首先思考一下插入結束後，往上回朔的過程中，碰到第一個不滿足 AVL 平衡性質節點時，會有哪些可能的狀況。因為高度差是 2，所以有可能的狀況是：
$$
\begin{align}
\text{左高}\begin{cases}\text{左高} \newline \text{右高}\end{cases}\newline
\text{右高}\begin{cases}
左高 \newline
右高
\end{cases}
\end{align}
$$
因為一次樹旋轉，可以讓左右高度差減少 1，所以只要依照狀況旋轉就可以了：

```
         z                                      y 
        / \                                   /   \
       y   T4      Right Rotate (z)          x      z
      / \          - - - - - - - - ->      /  \    /  \ 
     x   T3                               T1  T2  T3  T4
    / \
  T1   T2
```

```
     z                               z                           x
    / \                            /   \                        /  \ 
   y   T4  Left Rotate (y)        x    T4  Right Rotate(z)    y      z
  / \      - - - - - - - - ->    /  \      - - - - - - - ->  / \    / \
T1   x                          y    T3                    T1  T2 T3  T4
    / \                        / \
  T2   T3                    T1   T2
```

```
   z                            z                            x
  / \                          / \                          /  \ 
T1   y   Right Rotate (y)    T1   x      Left Rotate(z)   z      y
    / \  - - - - - - - - ->     /  \   - - - - - - - ->  / \    / \
   x   T4                      T2   y                  T1  T2  T3  T4
  / \                              /  \
T2   T3                           T3   T4
```

```
  z                                y
 /  \                            /   \ 
T1   y     Left Rotate(z)       z      x
    /  \   - - - - - - - ->    / \    / \
   T2   x                     T1  T2 T3  T4
       / \
     T3  T4
```

其中，左旋轉像是：

```c
struct Node *leftRotate(struct Node *x) 
{ 
    struct Node *y = x->right; 
    struct Node *T2 = y->left; 
  
    // Perform rotation 
    y->left = x; 
    x->right = T2; 
  
    //  Update heights 
    x->height = max(height(x->left), height(x->right))+1; 
    y->height = max(height(y->left), height(y->right))+1; 
  
    // Return new root 
    return y; 
} 
```

右旋轉：

```c
struct Node *rightRotate(struct Node *y) 
{ 
    struct Node *x = y->left; 
    struct Node *T2 = x->right; 
  
    // Perform rotation 
    x->right = y; 
    y->left = T2; 
  
    // Update heights 
    y->height = max(height(y->left), height(y->right))+1; 
    x->height = max(height(x->left), height(x->right))+1; 
  
    // Return new root 
    return x; 
} 
```

一個看旋轉的方式是「父子邊逆向，並且把靠裡面的那個子樹移去另外一個內側」。

# References

1. [Geeks for Geeks - AVL Tree | Set 1 (Insertion)](https://www.geeksforgeeks.org/avl-tree-set-1-insertion/)

