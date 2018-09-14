# van Emde Boas Tree

## Overview

是一種給定整數範圍 $\{0 \dots u-1\}$，可以在 $\lg\lg u$ 時間內達成：

1. `SEARCH` 
2. `INSERT`
3. `DELETE`
4. `SUCC`

兩個 $\lg$ 看起來超級快，但這裡 $u$ 是 「key 的範圍」不是「樹裡面的資料個數」，所以聽起來這個 $\lg\lg u$ 沒有想像中那麼那麼好。不過，如果 $u = 2^{O(1)}$，比如說 $2^32$，這樣也保證它可以真的跟想像中的 $\lg\lg u$ 那樣那麼快。

在這之前，可以先思考一下要怎麼樣的動作，才生的出 $\lg\lg u$ 這種時間複雜度 ?首先考慮二分搜的時間複雜度：

$$
T(n) = T(n/2) + O(1)
$$
的複雜度是 $T(n) = O(\lg n)$。如果這裡 $n = \lg u$，那麼時間複雜度就是 $O(\lg \lg u)$，關係就會像：

$$
T(\lg u) = T\left(\frac {\lg u}{2}\right) + O(1)
$$
要怎麼做到這件事？如果把 $\lg u$ 想像成是某棵樹的樹高，那麼「樹高進行二分搜」感覺就會產生這個複雜度。這是第一個直覺。順帶一提，如果吧 1/2 寫進去，那麼這個遞迴關係解起來跟：

$$
T(u) = T(\sqrt{u}) + O(1)
$$
一樣。還記不記得一開始解遞迴關係式的時候有個帶入法啊？

## A Heuristic Method

在思考怎麼構造這個東西之前，可以先想一下幾個資料結構：

### Idea 1 : Bit Field

這個資料結構可以做到：

1. `SEARCH`：$O(1)$
2. `INSERT`：$O(1)$
3. `DELETE`：$O(1)$
4. `SUCC`：$O(u)$

前面 3 個看起來很好，但 `SUCC` 有點糟糕。

### Idea 2 : Summary Vector

這個解法類似競賽程式中的線段樹。在陣列上面長樹，並且記錄樹高一半的那一層 (有 $\sqrt{u}$ 個元素) 的 OR 值。

``` pseudocode
SUCC(n):
	搜尋 n 所在區間中， n 以後的所有東西。
	if (有 1):
		return 1 的位置
	else:
		找 summary vector 中第一個非零元素
		搜尋該元素代表的區間
		return 該區間第一個非零元素
	
```

這樣 `SUCC` 要進行兩次 $O(\sqrt{u})$ 的搜尋，所以複雜度是 $O(\sqrt{u})$。雖然離 $O(\lg \lg u)$ 滿遠的，但至少有改進。而且感覺做了某種遞迴之後（就像是前面的遞迴關係式那樣），就可以有 $O(\lg \lg u)$ 的效率。

這裡觀察一件事：假定有長度為 $u$ 位元的位元陣列，並且有一個大小 $\sqrt{u}$ 位元的 Summary Vector。假定每一個 Summary Vector 都代表長度為 $\sqrt{u}$ 的區間中的元素 OR 起來的結果，那麼類似 C 語言中多維陣列編號的原理，第 n 個元素可以表達為：
$$
n = i\sqrt{u} + j
$$
其中 $i$ 是一個整數，$0 \leq j < \sqrt{u}$  (這就是整數的除法原理)。所以給了 $n$ 就可以知道這個東西屬於第幾個 summary vector。

再進一步觀察：對於一個 $u$ 位元，其中 $u$ 是偶數，的整數，「開根號」的意思跟「取前 $u/2$ 個位元」是一樣的，而除掉 $\sqrt{u}$ 的意思跟「取後面 $u/2$ 個位元」一樣。因此可以定義兩個運算：

```pseudocode
HIGH(x) = 取前 u/2 位元
LOW(x) = 取後 u/2 位元
```

但這樣還不是很夠，效率也只有到 $O(\sqrt{u})$。所以還要想辦法改進。

> Erik : "Let's recurse, shall we ?"

### Idea 3 : Recurse

可以發現 `SUCC ` 的動作，只是把問題變成 3 個同樣的問題：

1. 在所屬的 Cluster 中找 SUCC：$\sqrt{u}$ 大小的 `SUCC`
2. 如果沒有，搜尋 summary array 裡面的下一個 1：$\sqrt{u}$ 大小的 `SUCC`
3. 在 summary array 裡面找到第一個 1 之後，往那個 cluster 中找第一個出現的 1：$\sqrt{u}$ 大小的 `SUCC`

```pseudocode
SUCC (V, x):
	i = HIGH(x);
	j = SUCC(V.cluster[i], LOW(x))
	if (!j)  
		i = SUCC(V.summary, HIGH(x))
		j = SUCC(V.cluster[next], -1)
	return index(i, j)
```

所以，這個問題有遞迴的結構。類似的道理，`SEARCH` 跟`INSERT` 也有類似的結構。

比如 `INSERT`：

1. 在 cluster 中，第 `HIGH(x)` 個 cluster 中第 `LOW(x)` 個元素：$\sqrt{u}$ 大小的 `INSERT`
2. 插入 $\sqrt{u}$ 大小的 summary array 中的第 `HIGH(x) `：$\sqrt{u}$ 大小的 `INSERT`

```pseudocode
INSERT(V, x):
	INSERT(V.cluster[HIGH(x)], LOW(x))
	INSERT(V.summary, HIGH(x))
```

而 SEARCH：

1. 先看所屬的 summary array 是不是 0。如果沒有，就不用繼續找：$O(\sqrt{u})$ 的 `SEARCH`
2. 如果 summary array 裡面有，就查詢第 `HIGH(x)` 個 cluster 中的第 `LOW(x) `個元素：$O(\sqrt{u})$ 的 `SEARCJ`

```pseudocode
SEARCH(V, x):
	/* some base case */
	i = SEARCH(V.summary, HIGH(x))
	if (!i)return NIL;
	else return SEARCH(V.cluster[HIGH(x)], LOW(x)));
```

#### 分析

看起來有解決到問題，但效能？非～常～差～～。以 `SUCC` 來說：
$$
\mathtt {SUCC(u) = 3\cdot SUCC \left(\sqrt{u}\right) + O(1)} \Rightarrow \mathtt{SUCC(u) = O\left((lg(u))^{\log_{2}3}\right)}
$$
以 `INSERT` 來說：
$$
\mathtt{INSERT(u) = 2 \cdot INSERT(\sqrt{u}) + O(1)} \Rightarrow \mathtt{INSERT(u) = O(lg(u))}
$$
同樣的道理，`SEARCH` 也爆掉了。所以要想個辦法改良。

### Idea 3 : Store MAX and MIN

上面演算法效能變不好的理由是遞迴呼叫超過一次。如果想要做到 $O(\lg \lg u)$ 的效能，就只能遞迴呼叫自己一次：
$$
T(u) = T(\sqrt{u}) + O(1)
$$
首先觀察一下 `SUCC`：

```pseudocode
SUCC (V, x):
	i = HIGH(x);
	j = SUCC(V.cluster[i], LOW(x))
	if (!j)  
		i = SUCC(V.summary, HIGH(x))
		j = SUCC(V.cluster[next], -1)
	return index(i, j)
```

最好的狀況是呼叫一次就找到所有東西。如果沒有，就要把兩個遞迴變成某個 $O(1)$ 的動作。

如果儲存每一個區間的 `MAX`，就可以省掉第 3 行的工作：因為只要 $x$ 比區間中最大的值大，因為 `MAX` 已經是一個區間中最後面的元素了，所以就不用查詢。因此可以把 `SUCC` 變成：

```pseudocode
SUCC (V, x):
	i = HIGH(x);
	if LOW(x) < V.cluster[i].MAX
		j = SUCC(V.cluster[i], LOW(x))
	else  
		i = SUCC(V.summary, HIGH(x))
		j = SUCC(V.cluster[next], -1)
	return index(i, j)
```

類似的道理，第 6 行的 `SUCC` 的任務是找到區間中最小的元素。如果這個值，假定叫做 `MIN`，已經儲存好的話，那後這個遞迴也可以直接查：

```pseudocode
SUCC (V, x):
	i = HIGH(x);
	if LOW(x) < V.cluster[i].MAX
		j = SUCC(V.cluster[i], LOW(x))
	else  
		i = SUCC(V.summary, HIGH(x))
		j = V.cluster[i].MIN
	return index(i, j)
```

這樣一來，只要修改一下 `INSERT` 就可以了：

```pseudocode
INSERT(V, x):
	if x < V.MIN:
		V.MIN = x
	if x > V.MAX:
		V.MAX = x
	INSERT(V.cluster[HIGH(x)], LOW(x))
	INSERT(V.summary, HIGH(x))
```

這樣一來，`SUCC` 就解決了。不過有點難過的是 `INSERT` 還是沒有達到 $O(\lg \lg u)$。因此要再修改。仔細看一下 `INSERT` 的結構：

```pseudocode
INSERT(V, x):
	if x < V.MIN:
		V.MIN = x
	if x > V.MAX:
		V.MAX = x
	INSERT(V.cluster[HIGH(x)], LOW(x))
	INSERT(V.summary, HIGH(x))
```

任務是希望後面兩個遞迴呼叫，每次都只有一個會被呼叫。如果不能只呼叫一個，至少要把其中一個的成本減到 $O(1)$。

直覺來看，更新 Summary Array 的步驟應該只在需要的時候去做他。更明確的說，是只有「第一次對這個區間進行插入」的時候，以及「清掉區間裡面最後一個東西」的時候，會需要進行`INSERT(V.summary.HIGH(x))`。只要有辦法 $O(1)$ 地分辨這兩種狀況， 聽起來就有機會。

但這仍然有一個問題：這樣一來，第一次使用這個區間的時候，仍然會進行兩次遞迴呼叫，因此仍然很貴。但是只有這時候才需要呼叫 `INSERT(V.summary, HIGH(x))`，如果在這個場合有什麼辦法可以讓前面的 `INSERT(V.cluster[HIGH(x)], LOW(x))` 只花費常數時間，這樣效果就等於只有一次遞迴呼叫。

### Idea 5 : Lazy Propogation

「第一次使用這個區間」的時候，這個區間的 `MIN` 應該要是 -1，所以每次發生「把 `MIN` 從 -1 更新成其他值」的時候，就知道準備要呼叫   `INSERT(V.summary, HIGH(x))` 了，但如果這時候整個區間只有一個元素的話，那 `MIN` 不就直接是這個元素了嗎？所以把這個元素存在 `MIN` 裡面就好了。這時候只要修改 `MIN` ($O(1)$ 時間)，並且修改 summary array。簡單來說，「所有區間最小的元素，都會儲存在 `MIN` 裡面，不會被傳遞下去」。

```pseudocode
INSERT(V, x):
	if V.min == -1:
		V.MIN = V.MAX = x
		return
	if x < V.MIN:
		SWAP(x, V.MIN)
	if x > V.MAX:
		V.MAX = x
	if V.cluster[HIGH(x)].MIN == -1:
		INSERT(V.summary, HIGH(x))
	INSERT(V.cluster[HIGH(x)], LOW(x))
```

注意在 `x < V.MIN` 當中，因為要把所有最小的東西存在 `MIN` 當中，所以這時候要把 `MIN` 更新成 `x`，然後把舊的東西一路 Propogate 下去。

這樣看起來還是遞迴呼叫了兩次。但實際上只有一次。因為 `if V.cluster[HIGH(x)].MIN == -1` 條件為真時，`V.cluster[HIGH(x)].MIN ` 的值是 `-1`，因此在呼叫第 11 行的遞迴時，只會進行進行 `V.MIN = V.MAX = -1` 就立刻回傳。所以這個呼叫實際上只有 $O(1)$ 的時間。

這樣一來，就把效率提升到 $O(\lg \lg u)$ 了。不過還有一個小問題：第一次使用一個區間的時候，這個區間的 summaryr array 並不會被更新，而如果這之後又呼叫 `SUCC`，這個 `SUCC` 就會錯掉。不過這個問題不難修，既然 `MIN` 一直都會是對的，包含第一次使用區間時也是，所以叫 `SUCC` 優先判斷 `x` 有沒有在 `MIN` 前面，再考慮後面跟 summary array 有關的部分就好。假設是在之前，即 `x < V.MIN`，那麼 `x` 的下一個一定是 `V.MIN` （不然 `V.MIN` 就前面就會有其他東西，他就不應該是 `MIN`），這時直接回傳 `V.MIN` 就好。這樣一來，就避開了區間內第一次插入元素時，對 summary array 的查詢。

所以幫 `SUCC` 加上這個判斷，就會得到：

```pseudocode
SUCC (V, x):
	if x < V.MIN:
		return V.MIN
	i = HIGH(x);
	if LOW(x) < V.cluster[i].MAX
		j = SUCC(V.cluster[i], LOW(x))
	else  
		i = SUCC(V.summary, HIGH(x))
		j = V.cluster[i].MIN
	return index(i, j)
```

這樣就有 $O(\lg \lg u)$ 的 `SUCC`, `INSERT` 以及 `SEARCH` 了。不過有沒有發現從頭到尾都沒有 `DELETE` ？現在 `DELETE` 要登場了。

`DELETE` 的雛形大致是把 `INSERT` 倒過來做：

```pseudocode
DELETE(V, x):
	if x = V.MIN:
		/* to be implemented */
	DELETE(V.cluster[HIGH(x)], LOW(x))
	if V.cluster[HIGH(x)].MIN == -1:
		DELETE(V.summary, HIGH(x))
	if x = V.MAX:
		/* to be implemented */
		
```

但類似地，會發現似乎一不小心就會遞迴呼叫這個東西兩次，所以會希望需要遞迴呼叫其中一個時，另外一個遞迴呼叫花費常數時間。仔細思考一下：當刪除最後一個元素時，那個元素一定會是 `V.MIN`。所以需要特別設計刪除 `V.MIN` 的狀況，使得 `V.MIN` 是最後一個元素時，只會花費常數時間刪除他。

```pseudocode
DELETE(V, x):
	if x = V.MIN:
		i = V.summary.MIN
		if i = -1:
			V.MIN = -1
			return
		x = V.MIN = INDEX(i, V.cluster[i].MIN)
	DELETE(V.cluster[HIGH(x)], LOW(x))
	if V.cluster[HIGH(x)].MIN == -1:
		DELETE(V.summary, HIGH(x))
	if x = V.MAX:
		/* to be implemented */
		
```

如果 `x = V.MIN` 的話，就要看這時候刪除的東西，是最後一個元素，還是這個區間中有其他元素。 另外，因為我們沒有對 `V.MAX` 進行 Lazy Propogation，所以當刪除的東西是 `V.MAX` 時，我們還需要更新的 `V.MAX` 值。

在 `x = V.MIN` 的狀況方法就是問 summary array 「你裡面出現的第一個東西是在哪個區間出現？」。如果找不到，就表示 `V.MIN` 必定是區間中剩下來的最後一個元素，這時候就要把整個區間清空，或至少讓他「看起來是空的」。要怎麼要讓他「看起來是空的」？把 `V.MIN` 設成 `-1` ！這樣一來，`INSERT` 就會看到這是一個空的區間，

```pseudocode
DELETE(V, x):
	if x = V.MIN:
		i = V.summary.MIN
		if i = -1:
			V.MIN = -1
			return
		x = V.MIN = INDEX(i, V.cluster[i].MIN)
	DELETE(V.cluster[HIGH(x)], LOW(x))
	if V.cluster[HIGH(x)].MIN == -1:
		DELETE(V.summary, HIGH(x))
	if x = V.MAX:
		/* to be implemented */
		
```

在 `x = V.MAX` 的狀況，這時候要把自己的 `MAX` 進行更新（也就是找 Predecessor 的意思）。作法就是問 summary array 「哪裡有第一個非零元素」，並且把它找出來，然後再進去那個 cluster，找出 cluster 裡面最大的元素回傳：

```pseudocode
i = V.summary.MAX
V.MAX = INDEX(i, V.cluster[i].MAX)
```

但這樣會有一個小問題：有可能 `V.summary.MAX` 也找不到，比如現在刪掉的東西是前無古人，後無來者，整個區間都是空的時候; 或是刪除時整個區間裡面只有 2 個元素，而這時刪除的是 2 個元素中比較大的那個元素，