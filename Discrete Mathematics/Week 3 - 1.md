# Week 3 - 1

## Def (Rules of Infrence of Predicate Logic)

量詞有下面四條推論規則。前兩條是消去量詞，後兩條是把量詞加回去。通常的用法是先用前兩條把敘述變成 Propositional Logic，推論出結果之後，再用後二條把量詞加回去。

### Universal Instantiation

$$
\frac {\forall x.P(x)}{P(c)\quad \text{c arbritrary}}
$$

### Existential Instantiation

$$
\frac {\exists x.P(x)}{P(c)\quad \text{for some c}}
$$

### Universal Generalization

$$
\frac {P(c) \text{ for arbritrary c}}{\forall x.P(x)}
$$

### Existential Generalization

$$
\frac {P(c) \text{ for some c}}{\exists x.P(x)}
$$

---

### 例子：

$$
\begin{align}
&\begin{cases}
\text{Everyone in this class knows calculus.} & \forall x(P(x) \to R(x))\newline
\text{Jason is in this class.}& P(\text{Jason})\newline
\text{Jason is in EE.} & Q(\text{Jason})\newline
\end{cases}\newline
&\Rightarrow\text{There exists a person in EE who knows calculus} \newline
&\qquad\exists x.Q(x)\and R(x)
\end{align}
$$

scope：all people

| Steps                                  | Reason                     | Remark                                |
| -------------------------------------- | -------------------------- | ------------------------------------- |
| $\forall x.P(x) \to R(x)$              | Premise                    |                                       |
| $P(\text{Jason})$                      | Premise                    |                                       |
| $Q(\text{Jason})$                      | Premise                    |                                       |
| $P(Jason) \to R(Jason)$                | Universal Instantiation, 1 | 不能直接用 MP， 因爲 $x$ 的意義不一樣 |
| $R(\text{Jason})$                      | Modus Ponens, 2, 4         |                                       |
| $Q(\text{Jason}) \and R(\text{Jason})$ | Conjunction 3, 5           |                                       |
| $\exists x.Q(x)\and R(x)$              | Existential Generalization |                                       |
|                                        |                            |                                       |

### 例子 (錯誤的證明)

| Steps                      | Reason                        | Remark                                                       |
| -------------------------- | ----------------------------- | ------------------------------------------------------------ |
| $\forall x.P(x)$           | Premise                       |                                                              |
| $\exists x. P(x) \to Q(x)$ | Premise                       |                                                              |
| $P(c)$                     | Universal Instantiation       |                                                              |
| $P(c) \to Q(c)$            | Exitential Instantiation      | 這裡錯。因為前提只有 $\exists$，不保證 $c$ 是那裡面的東西 。但如果這一行跟上一行交換，就是正確的論證。 |
| $Q(c)$                     | MP 3, 4                       |                                                              |
| $\exists x.Q(x)$           | Existential Generalization, 5 |                                                              |
|                            |                               |                                                              |
|                            |                               |                                                              |

### Remark

上面這個推論在巢狀量詞的時候並不正確。所以考試出題會盡量避免。不過 FLOLAC 有教過了。



## Program Verification

## Def
用以下的符號表示「在指令 $s$ 執行前，$p$ 成立; 而執行過後 $q$  成立」：
$$
p\ \{s\}\ q
$$

---

### Def (Loop Invariant)

考慮程式：

```pseudocode
while (condition)
	S;
```

 若命題 $p$ 滿足：
$$
p \and \text{condition} \{S\}\ p
$$

則稱 $p$ 是一個 loop invariant

---

最明顯的例子如最短路徑中的 Relax、最短路徑、DFS 的白路性質...。