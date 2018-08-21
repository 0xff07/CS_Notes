# Data Structure : Tree Basics


## Def (樹等價定義們)

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
  2. $\forall e \in E.  G' =  (V, E\setminus e)\mathrm{\ is\ not\ connected}$

4. 連通，而且邊數 = 點數 - 1 的圖：
  1. $G \mathrm{\ is\ connected}$, and 
  2. $|E| = |V| - 1$

5. 無環，而且邊數 = 點數 - 1 的圖

	  1. $G \mathrm{\ is\ acyclic}$, and

	  2. $|E| = |V| - 1$

6. 無環， 但任意加一條邊之後就有環。

	  1. $G\ \mathrm{is\ acyclic}$
	  2. $\forall e \in \{(u_i, u_j) | u_i, u_j \in V, (u_i, u_j)\notin E\}.\forall G' \in \{(V,E\cup e)\}$.$G'\mathrm{\ is\ cyclic}$ 

---

(1. $\Rightarrow$ 2. )：反證

1. 如果不存在 path，顯然與連通的前提矛盾。
2. 若存在超過兩個相異 simple path，任選兩條 $p_1 = (a_0...a_{k_a})$, $p_2 = (b_0...b_{k_b})$，其中 $a_0 = b_0$, $a_{k_A} = b_{k_b}$。
	1. 在 $p_1, p_2$ 中，選擇最小的 $k_1$ 與最小的 $k_2$，使得 $a_{k_1} = b_{k_2}$。以及次小的 $k_1', k_2'$，使得 $a_{k_1'} = b_{k_2'}$。
	2. 這樣的 $k_1, k_2$ 與 $k_1', k_2'$必定存在，因為最差狀況下 $k_1 = 0, k_2 =0$，以及 $k_1' = a_{k_a}, k_2' = b_{k_b}$。
	3. $p = (a_{k_1}...a_{k_1'},b_{k_2' - 1}...b_{b_{k_1}})$ 為一個 cycle。與前提矛盾。

Remark : 敘述的意思並不是「任兩點存在的 path 都是 simple path」，而是「如果兩點間有 simple path，則該 simple path 唯一」。

(2. $\Rightarrow$ 3. )：

1. 因為任兩點都存在 simple path，故 connected.
2. 假定 $\exists e = (u, v).G' = (V, E\setminus(u, v)) \mathrm{\ is\ connected}$，則可知 $u, v$ 仍然 $\mathrm{rechable}$，令這條 path 為 $p'$，則可知 $G$ 當中，至少有兩個方法構造 $u$ 往 $v$ 的相異 simple path：
  1. $p'$：因為「$u, v $ 有 path $\Rightarrow $ $u, v$ 有 simple path」
  2. $(u, v)$

  發現 $u, v$ 沒有唯一的 simple path，矛盾。

（3.$\Rightarrow$4.）：

前面 Thm 已經證完 $|E| \geq |V| - 1$，僅證 $|E| \leq |V| - 1$ 即可。

