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

這樣複雜度