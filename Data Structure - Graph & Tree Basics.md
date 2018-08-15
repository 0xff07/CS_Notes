# Data Structure : Graph & Tree Basics

# Graph



## Definition (Graph)

一個圖 (Graph)  $G = (V, E)$  由兩個部分組成：

1. $V$ 是一個有限的集合，稱作 Virtices。

2. $E$ 是一個 V 上的 Binary Relation，稱作 Edge Set。這個 Relation 通常用 $(\_,\_)$ 表示。

3. 如果 $E$ 是 ordered pair，則這個圖稱作「有向圖」;  如果 $E$ 是 unordered pair，則稱作無向圖。 

### Remark

1. 雖然 $E$ 中的元素有 order/unordered 之別，但符號上都用 $(u, v)$ 表示。
2. 在無向圖中 $(u, v) \not\Rightarrow (u, v)$; 但有向圖中 $(u, v) \Rightarrow (u, v)$



## Definition (Incident)

1. 若 $G = (V, E)$ 是有向圖，且 $(u, v) \in E$，則稱 $(u, v)$ 「incident from / leaves u」，且「incident to / enters v」。
2.  若 $G = (V, E)$ 是無向圖，且 $(u, v) \in E$，則稱 $(u, v)$ 「incident on u and v」。

### Remark

1. 其實這比較像英文的用語介紹。
2. 接下來的內文為了方便，在有向圖中，用「從 $u$ 離開」表示「incident from/leaves u」 ; 用「進入 $u$」表示「incident to / enters v」。
3. 用「經過 $u$ 的邊」表示「incident on u」。



## Definition (Degree)

1. 若 $G = (V, E)$ 是個有向圖，$u \in V$, 則：

     ​    

     1. In-degree of $u$：進入 $u$ 的邊數。

       

     $$
       d_{u, i} = |\{(i, u)| (i, u) \in E\}|
     $$

       

     2. Out-degree of $u$：從 $u$ 出發的邊數。

       

     $$
            	d_{u, o} = |\{(u, i)| (u, i) \in E\}|
     $$

       

     3. Degree of u：$u$ 的 in-degree 加 out-degree。

     	
     	$$
     	\deg(u) = d_{u, i} + d_{u, o}
     	$$
     	




2. 若 $G = (V, E)$ 是個無向圖，且 $u\in V$，則： 

    

    1. Degree of $u$：

      

    $$
      \deg(u) = |\{(u, i) | (u, i) \in E\}|
    $$
      ​     

3. (Hand-Shaking Lemma)

    假定 $G = (V, E)$ 是個無向圖，則：

    

    $$
    \sum_{u\in V} \deg(u) = 2|E|
    $$




## Definition (Path)



1. 一個從 $u$ 到 $u'$，長度為 $k$ $\geq 0$ 的 path,  $p$, 定義為一個由 $V$ 中的元素形成的序列：

	


$$
  p = \langle v_0, v_1...v_k \rangle
$$

  

  	且該序列滿足「$(v_i, v_{i + 1})$ 是邊」「頭尾分別是 $u$, $u'$」即：



$$
\begin{cases}
  v_0 = u \newline 
  v_k = u' \newline
  \forall i \in \{0 ... k-1\}.(v_i, v_{i + 1}) \in E
  \end{cases}
$$


​	因為上面這個東西定義要塞進邏輯裡面實在是太長了，所以用：



$$
u  \overset{p}{ \leadsto } v
$$

  

​	來說明 $p$ 是一個從 $u$ 到 $v$ 的 path

  

2. (Simple) 若 $u \overset{p}{\leadsto} u'$，且 $p$ 的長度為 $k$。若 $p$ 中沒有重複經過的點，即：

	


$$
  \forall(i, j) \in \{(i, j)|0\leq i, j \leq k, i\neq j\}.v_i \neq v_j
$$

  

​	則稱 p 為「simple」 path。因為把 path 的定義跟 simple 的定義全部塞進邏輯裡面實在是太長了，所以就用：


$$
u \overset{p}{\leadsto} u,\ p\ \mathrm{is\ simple}
$$

​	

​	表示 $p$ 是一個滿足 simple  path 。

  

3. (Cycle) 若 $u \overset{p}{\leadsto} u'$，且：


$$
  u = u'
$$

  	則稱 $p$ 為一個 「cycle」。一樣因為實在是太長了，所以



$$
p\ \mathrm{is\ a\ cycle}
$$

  	表示 $p$ 是一個滿足 cycle 跟 path 性質的序列。

  

4. (Reachable) 若 $u, v$ 間存在 path，即：


$$
\exists p.u \overset{p}{\leadsto}v
$$

  	則稱「$v$ is reachable from $u$ via $p$」。因為在 formal logic 中把 Reachable 的定義全部填上去實在太麻煩，所以用：

  

$$
\__{1}\ \__{2}\ \mathrm{reachable}
$$

  

 	表示兩個點 $\__1$, $\__2$ 是 reachable 的。以及：

  

$$
\__{1}\ \__{2}\ \mathrm{\ is\ not\ reachable}
$$
​	表示：$\neg\left( \__{1}\ \__{2}\ \mathrm{reachable} \right)$

  

  	另外，因為 $k$ 可以是 0，所以不管是否 $(u, u)$，$u$ 自己一定跟自己是 reachable 的。

5. (Connected) 假定：


$$
\forall {u, u'} \in V.u \overset{}{\leadsto}u'
$$


​	則稱圖是 Connected. 用：



$$
  G\ \mathrm{is\ connected}
$$

  	

​	表示 $G$ 是一個滿足 connected 性質的 graph; 用：

  

$$
  G\ \mathrm{is\ not\ connected}
$$
  	表示 $\neg\left(G\ \mathrm{is\ connected}\right)$

  

6. (cyclic) 假定：


$$
\exists p.p\ \mathrm{is\ a\ cycle}
$$


  	則稱 $G$ 是 cyclic。相反地，若：


$$
\neg(\exists p.p\ \mathrm{is\ a\ cycle})
$$
 	則稱 $G$ 是 acyclic. 分別用：


$$
  \begin{cases}
  G \mathrm{\ is\ cyclic} \newline
  G \mathrm{\ is\ acyclic}
  \end{cases}
$$
  	表示有環跟無環。

### Thm : 無向圖有 Path ⇒ 有 Simple Path



$$
存在 path \Rightarrow 存在\ simple\ path
$$

1. $|V| = 2$: 只有兩個點。顯然成立。

2. 假定 $|V| = |V'| - 1$ 時命題成立，則對於任意 $u, v \in V$：

     1. $u, v \in V'$：由歸納法假設可知命題成立。

     2. $u \in V', v\not \in V'$，且 $u, v$ 存在 path，且僅有最後一個點為 $v$。令該 path 為：

     
     $$
       p = \langle u, u_1 ... u_{k-1}, v \rangle
     $$

       由歸納法假設知 $u, u_{k-1}$ 間存在 simple path, $p'$。又 $v \not \in V'$，故 $v \not \in p'$，因此可知 $p$ 為一 simple path。

     3. $u \in V', v\not \in V'$，且 $u, v$ 存在 path，且 $v$ 不只最後一個點為 $v$：
       * 假定 $v$ 第一次出現在 $u_k$
       * 取 $p' = \langle u, ...u_{k}\rangle$
       * 由於 $p'$ 中 $v$ 僅在最後出現，故套用 2. 可知 $u, u_k = v$ 之間存在 simple path。

### Thm：Undirected, Connected ⇒ |E|  ≥ |V| - 1

1. |V| = 1 原題顯然成立。

	

2. 假定 $|V| = |V'| + 1$，隨便挑出一個點 $v \in V$，並令剩下的子圖 $G' = (V', E')$ 。$V = V' \cup \{v\}$, $v \not \in V'$, $E' \subset E$：

	  已知：$|E'| \geq |V'| - 1$

	  且：$|V| = |V'| + 1$

	  若原圖 $G = (V, E) = ( V' \cup \{v\}, E)$ 連通，則 $\exists u \in V'.(u, v) =: e \in E$，否則 $v$ 不連通。而 $v \not \in V'$，故 $e \not \in E'$，因此：


$$
|E| \geq |E'| + 1 \geq|V'| + 1=|V|
$$
3. 由數學歸納法知原題成立。

# Free Trees

## Definition (樹等價定義們)

下列敘述等價：

1. $G$ 是 Tree $\equiv$ G 是個連通、無環、無向的圖。


$$
  G \mathrm{\ is\ a\ tree} \equiv 
  \begin{cases}
  G\mathrm{\ is\ undirected}, and\newline
  G\mathrm{\ is\ connected},\ and \newline
  G\mathrm{\ is\ acyclic}
  \end{cases}
$$

2. 任兩點存在唯一 simple path 的圖：


$$
\forall u, u' \in V,u\neq u'. \exists!p .p\mathrm{\ is\ a\ simple\ path}
$$

3. 隨便砍一條邊就會不連通的連通圖：

     1. $G \mathrm{\ is\ connected}$, and
       4. $\forall e \in E.  G' =  (V, E\setminus e)\mathrm{\ is\ not\ connected}$

  

4. 連通，而且邊數 = 點數 - 1 的圖：

	  1. $G \mathrm{\ is\ connected}$, and 

	  2. $|E| = |V| - 1$

  

5. 無環，而且邊數 = 點數 - 1 的圖

	  1. $G \mathrm{\ is\ acyclic}$, and

	  2. $|E| = |V| - 1$

		 

6. 無環，  

	  1. $G\ \mathrm{is\ acyclic}$

	  2. $\forall e \in \{(u_i, u_j) | u_i, u_j \in V, (u_i, u_j)\notin E\}.\forall G' \in \{(V,E\cup e)\}$.$G'\mathrm{\ is\ cyclic}$ 

		​	

### 證明

1. 「1. $\Rightarrow$ 2. 」

     反證：

     1. 如果不存在 path，顯然與連通的前提矛盾。
     2. 若存在超過兩個相異 simple path，任選兩條 $p_1 = (a_0...a_{k_a})$, $p_2 = (b_0...b_{k_b})$，其中 $a_0 = b_0$, $a_{k_A} = b_{k_b}$。
         1. 在 $p_1, p_2$ 中，選擇最小的 $k_1$ 與最小的 $k_2$，使得 $a_{k_1} = b_{k_2}$。以及次小的 $k_1', k_2'$，使得 $a_{k_1'} = b_{k_2'}$。
         2. 這樣的 $k_1, k_2$ 與 $k_1', k_2'$必定存在，因為最差狀況下 $k_1 = 0, k_2 =0$，以及 $k_1' = a_{k_a}, k_2' = b_{k_b}$。
         3. $p = (a_{k_1}...a_{k_1'},b_{k_2' - 1}...b_{b_{k_1}})$ 為一個 cycle。與前提矛盾。

     

       Remark : 敘述的意思並不是「任兩點存在的 path 都是 simple path」，而是「如果兩點間有 simple path，則該 simple path 唯一」。

     

     

2. 「2. $\Rightarrow$ 3. 」

     1. 因為任兩點都存在 simple path，故 connected.
       2. 假定 $\exists e = (u, v).G' = (V, E\setminus(u, v)) \mathrm{\ is\ connected}$，則可知 $u, v$ 仍然 $\mathrm{rechable}$，令這條 path 為 $p'$，則可知 $G$ 當中，至少有兩個方法構造 $u$ 往 $v$ 的相異 simple path：
     	1. $p'$：因為「$u, v $ 有 path $\Rightarrow $ $u, v$ 有 simple path」
     	2. $(u, v)$

     

     故：
     $$
     \neg \left(\exists e = (u, v).G' = (V, E\setminus(u, v)) \mathrm{\ is\ connected}\right) 
     $$

     把 $\neg$ 塞進去之後得證原敘述成立。



3. 「3. $\Rightarrow$4. 」

	前面 Thm 已經證完 $|E| \geq |V| - 1$，僅證 $|E| \leq |V| - 1$ 即可。

