# Single Source Shortest Path - Algorithm

## Bellman-Ford Algorithm

```pseudocode
BELLMAN_FORD(G)
INITIALIZE(G) // 把 d 都設成無限
for i in len(V) - 1:
	for (u,v) in E:
		if u.d + w(u,v) > v.d
			v.d = u.d + w(u,v)
			v.pi = u
```



直觀來說：

最長的最短路徑也只有 $|V|$ 個點，所以暴力把全部邊 `RELAX` $|V| - 1$ 次之後，就沒更長的路徑能 `RELAX` 了。只有一種狀況例外：圖有負環。所以如果發現再 `RELAX`  1 次時，還有點的值被更動，就知道有負環。