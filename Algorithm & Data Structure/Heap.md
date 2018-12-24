# Heap

## Observation (No. of Complete Binary Tree)

假定把一顆 Complete 的二元樹由根開始，由上(根部)往下，由右而左編號，如下圖：

![Tree_Numbering](Heap.assets/Tree_Numbering.png)

假定 `i` 是某一個節點的編號，則該節點的左、右子節點的編號，分別用 `left(i)` 與 `right(i)` 表示，為：
$$
\begin{cases}
\mathtt{left(i) = 2*i} \newline
\mathtt{right(i) = 2*i + 1}
\end{cases}
$$

---

爆開計數就好。

假定某一個節點位於第 $j$ 層，的第 $k$ 個，則該節點的編號為：
$$
i = (2^{j-1}-1) + k
$$
若某一個節點編號為 $i' = (2^{j' - 1} -1) + k'$，則該節點的左子節點與右子節點編號分別為：
$$
\begin{cases}
i_L = (2^{j'} -1) + 2k' - 1 &= 2i' \newline
i_R = (2^{j'} -1) + 2k' &= 2i' + 1
\end{cases}
$$

---

### Observation (No. of Parent)

假定依照上述過程編號，並且某個節點的編號為 $i \geq 2$，則該節點的父節點為：
$$
\mathtt{parent(i) = i/2}
$$

---

上面觀察的直接結論。

---

## Def (Binary Heap)

$$
\text{A binary heap is a complete binary tree}
$$

---

## Heapify

假定對一個 Heap 中的根元素進行修改，假定他的編號是 $i$。則修改過後，這個陣列可能不滿足 Heap 的性質。但可以觀察到：因為對第 $i$ 個元素的左、右子樹並未進行修改，所以他們仍然保持 Heap 性質。只有那些包含 $i$ 節點的子樹需要進行修正

因為左右子樹都是 Heap，所以 

```pseudocode
HEAPIFY(A, i):
	greatest = i
	l = left(i)
	r = right(i)
	if (left(i) < A.size && GREATOR(A[l], A[greatest])):
		greatest = l
	if (right(i) < A.size && GREATOR(A[r], A[greatest])):
		greatest = r
	if (greatest != i):
		SWAP(A[greatest], A[i])
		HEAPIFY(A, greatest)
```

在每一次呼叫中，假定有往下遞迴呼叫下去，那麼最多進行跟樹高一樣那麼多的運算，因此複雜度是 $O(\lg n)$。

## Build Heap

因為已經知道左右子樹都滿足 Heap 性質時，要怎麼樣把這個東西修正成 Heap，因此可以 Bottom Up 的把整堆陣列修正成 Heap 的方法：

```pseudocode
BUILD_HEAP (A)
	for i in A.size to A.size/2:
		HEAPIFY(i)
```



## Reference

1. CLRS，