# Ford - Fulkerson Algoriithm

這個東西的作法是這樣：只要 $s, t$ 之間有增廣路徑，那麼就把這條增廣路徑盡可能注入新的流，直到沒辦法再注入，這時宣稱「無法再增廣 $\iff$ 流已達到最大」。也就是：

```c
# define N // Number of Node
int ford_fulkerson(int s, int t)
{
    int f = 0;
    int path[N] = {0};
	while (reachable(s, t, path))
        f += augment(s, t, path);
}
```

如果使用 Adjacency Matrix 實作（這樣 $c(i, j) = c[i][j]$ 就好）的一個方法如下：

```c
# define c(cur, i) cap[cur][i]
# define f(cur, i) flow[cur][i]
# define reachable (s, t) dfs(s, t)
bool dfs (int cur, int t, int *p)
{
	visited[cur] = 1;
    if (cur == t)
        return true;
    for (int i = 0; i < N; i++) {
		bool viable = 	!visited[i] && 
            			(c(cur, i) - f(cur, i) > 0 || f (i, cur) > 0);
        if (viable) {
        	p[i] = cur;
            if (dfs(i, t))
                return true;
        }
    }
    return false;
}

#define INF INT_MIN
int augment (int s, int t, int *p)
{
    int cf_p = INF;
	for (int i = t; i != s; i = p[i])
        cf_p = c(p[i], i) - f(p[i], i) > 0 ? 
            	min (cf_p, c(p[i], i) - f(p[i], i)):
        		min (cf_p, f(i, p[i]));
    
    for (int i = t; i != s; i = p[i]) {
        if (c(p[i], i) - f(p[i], i) > 0)
            f (p[i], i) += f;
        else 
            f (i, p[i]) -= f;
    }
    return f;
}
```

因為最大流是個常數，而且可增廣 $\iff$ 增廣後流量增加，因此流量是嚴格遞增的。所以當增廣到不能再增廣時，流量就達到最大。

雖然「每次增廣，流量嚴格遞增」，但這樣會有的問題是：如果流量、容量不是有理數，那麼就算可以保證每次增廣流量可以嚴格遞增，也未必可以確定能在有限次增廣找出最大流（比如最大流量是 $\sqrt{2}$，每次增廣依序增加 $1, 0.4, 0.01, 0.004 \dots$ 等等 $\sqrt{2}$ 的各個位數）。所以這個演算法只能用在流量跟容量都是有理數的時後。

---

# Edmond - Karp Algorithm

上面的做法是用 DFS 找增廣路徑，複雜度是 $O(Ef_{\max})$，缺點是會仰賴流量，如果流量很大的話，會有讓他很慢的例子。有沒有改進的空間？改進方法很簡單：把 DFS 換成 BFS，每次都找 BFS 下最短的路徑進行增廣。注意==最短路徑指得是邊的「數目」最少==，而不是容量加權或流量的。

為什麼改成 BFS 就可以解決這個問題呢？是因為有這個關鍵性質：
$$
\text{對最短的增廣路徑增廣後，$s$ 到任何 $t$ 以外的點的最短路徑必定變長}
$$
有這個性質之後，假設 $(u, v)​$ 是某次增廣時，殘餘流量最小的邊。因為這次增廣時就會把 $(u, v)​$ 塞滿，所以下一次增廣時一定沒辦法增加 $(u, v)​$ 流量，最快也要等到下下次（也就是要有人先沿 $(v, u)​$ 增廣之後，才能再次從 $(u, v)​$ 增廣）。所以，一直到下一次 $(u, v)​$ 變成「增廣路徑中，殘餘流量最小的邊」時， $\delta(s, u)​$ 至少會被增加 2 次，所以至少變成 $\delta(s, u) + 2​$。因為這個圖中最短的最長路徑是 $|V| - 1​$，對於任意邊 $(u, v)​$，他最多可以當「增廣路徑中，殘餘流量最小的邊」 $(|V| -2)/2​$ 次。所以最差狀況是「所有邊都當了 $|V|/2 - 1​$ 次剩餘流量最小的邊」。這時，表示經過了 $O(VE)​$ 次增廣; 而每次增廣需要 $O(V + E)​$，所以複雜度是 $O(V^2E + VE^2) ​$。但 $E = O(V^2)​$，所以複雜度是 $O(VE^2)​$。

那為甚麼會有那個「關鍵性質」呢？先用一個直覺的方式想：假設有一條最短路徑是 $s \leadsto (u, v) \leadsto w$，而現在把 $(v, u)$ 反向，那就只能「繞路」了。

假定某一次增廣時，走了一條最短路徑，而這條最短路徑中，剩餘容量最小的邊是 $(u, v)​$，並且在這一次增廣把 $(u, v)​$ 邊的流量加滿。不過，「剩餘的容量最小的邊」可能有很多條，這邊為了討論方便，就找那條最短路徑中，離源點 $s​$ 最近的那個邊。

接著利用反證法：假定增廣之後，源點 $s$ 到某些點的 BFS 距離減少了。為了證明方便，假定 $v$ 是那些「距離減少的點」中，離 $s$ 最近的; 令 $\delta_f(s, v)$ 是增廣前，$s, v$ 的最短距離; 而 $\delta_{f'}(s, v)$ 函數，表示增廣之後，$s, v$ 的最短距離。

==假定增廣之後，「到 $v$ 的那條最短路徑」最後一個邊是 $(u', v)$==。因為這條邊在最短路徑上，所以：
$$
\delta_{f'} (s, v) = \delta_{f'}(s, u') + 1
$$
接著可以發現：==$(u', v)​$ 一定不會出現在增廣「前」的圖上==，因為如果 $(u', v)​$ 出現了，那麼最由 BFS 的性質：若 $(u', v)​$ 有邊，則：
$$
\delta_f(s, v) \leq \delta_f(s, u') + 1
$$
但因為 $v$ 是第一個「最短路徑變短的點」，所以 $\delta_{f'}(s, u')$ 不會 $\delta_{f}(s, u')$ 短，不然「第一個」增廣後最短路徑變短的點就不會是 $v$ ，而是 $u'$。既然 $s$ 到 $u'$ 的最短路徑，在增廣之後沒有變短，也就是說： $\delta_f(s, u')\leq \delta_{f'}(s, u')$ 。因此，把這個條件帶入上式：
$$
\delta_f(s, v) \leq \underbrace{\delta_{f}(s, u')}_{\leq \delta_{f'}(s, u')} + 1 \leq \delta_{f'}(s, u') + 1
$$
但因為 $(u', v)$ 是在增廣後 $s$ 到 $v$ 的最短路徑上，所以：$\delta_{f'}(s, u') + 1 = \delta_{f'}(s, v)$，所以：
$$
\delta_f(s, v) \leq \delta_{f'}(s, v)
$$
這樣就立刻矛盾了！

上面的討論可以發現：==$(u', v)$ 是在增廣之後，才出現在圖上的邊==，所以知道：當時在增廣時，一定是沿著 $(v. u')$ 方向增廣。因為每次都沿著最短路徑增廣，所以 $(v, u')$ 出現在某條 $s$ 到 $t$ 的最短路徑上。既然他出現在最短路徑上，所以：
$$
\delta_f(s, v) + 1 = \delta_f(s, u')
$$
因此：
$$
\delta(s, v) = \delta_f(s, u') - 1
$$
但回到第一條算式說：
$$
\delta_{f'} (s, v) = \delta_{f'}(s, u') + 1
$$
整理一下有：
$$
\begin{cases}
\delta_f (s, u') = \delta(s, v) + 1 \newline
\delta_{f'}(s, u') = \delta_{f'}(s, v) - 1
\end{cases} 
$$
因為 $\delta_f(s, u') \leq \delta_f(s, u')​$，所以：
$$
\delta_f(s, v) + 1 \leq \delta_{f'}(s, v) - 1
$$
但這樣就發現 $\delta_{f'}(s, v)  \geq \delta_f(s, v) + 2$，跟本來的 $\delta_{f'}(s, v) < \delta_f(s, v)$ 矛盾。由此得證。

