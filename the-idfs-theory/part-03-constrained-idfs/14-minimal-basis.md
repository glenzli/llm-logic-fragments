## §14 最小基理论

§8 建立了一般算子空间 $(\Omega, d_\Omega)$ 上的代数结构（可分解性、子链替换、纤维吸收提升、可分解性的度量关系）。本节将这些工具特化到 IDFS 框架，分析基函数库 $F$ 的冗余度对链深和纤维质量的影响。

#### 不可约核

§8 定义了一般算子空间上的可分解性。特化到 IDFS 框架（$\psi, \phi_i \in F$），可分解性的否定给出不可约性。

称 $f \in F$ 为**全局 $\delta_0$-不可约的**（globally $\delta_0$-irreducible），若：

$$\nexists\; U \subseteq \mathcal{X}\;(\text{非空开}),\; k \geq 2,\; \phi_1, \ldots, \phi_k \in F \setminus \{f\}:\quad d_\Omega(f,\; \phi_k \circ \cdots \circ \phi_1)\big|_U \leq \delta_0$$

即不存在 $F$ 中其他成员的复合在任何非空开集上以偏差 $\leq \delta_0$ 逼近 $f$。$\delta_0 = 0$ 退化为精确不可约。

$F$ 的 **$\delta_0$-不可约核**：

$$F_{\min}^{\delta_0} \;\triangleq\; \{f \in F \mid f \text{ 全局 } \delta_0\text{-不可约}\}$$

**冗余度**：$\rho_{\delta_0}(F) \triangleq |F| - |F_{\min}^{\delta_0}|$。$\delta_0$ 越大，不可约条件越严格，$F_{\min}^{\delta_0}$ 越大。

**命题 14.0（$\delta_0$-不可约核的生成性）**：$F_{\min}^{\delta_0}$ 以偏差不超过 $|F| \cdot \delta_0$ 生成 $F$ 的 f-chain 覆盖——对任意 $g \in F \setminus F_{\min}^{\delta_0}$，存在开子集 $U$ 和 $F_{\min}^{\delta_0}$ 中的成员链，使得 $d_\Omega(g, f_k \circ \cdots \circ f_1)|_U \leq |F| \cdot \delta_0$。

**证明**：由 $g \notin F_{\min}^{\delta_0}$，$g$ 在某个非空开集 $U$ 上可被 $F$ 中其他成员的复合以偏差 $\leq \delta_0$ 逼近。若复合中某个 $f_i \notin F_{\min}^{\delta_0}$，继续递归替换，每步引入至多 $\delta_0$ 的额外偏差。由 $|F|$ 有限，递归必终止，总偏差 $\leq |F| \cdot \delta_0$。$\square$

> **注（局部不可约）**：全局 $\delta_0$-不可约是最强条件。更精细的概念是**局部不可约性**：$f$ 在特定子集 $U$ 上不可被 $\delta_0$-逼近，但在另一子集 $V$ 上可以。全局不可约核 $F_{\min}^{\delta_0} = \bigcap_U F_{\min}^{\delta_0, L}(U)$（遍历所有非空开集）是最小的不可约集。

#### 定义（拟合等价类）

对目标 $(r_j, \mathcal{X}(r_j)) \in \mathcal{S}$ 和容差 $\tau > 0$，定义 $r_j$ 的**拟合等价类**：

$$[r_j]_\tau \;\triangleq\; \{q \in F^{\leq \mathcal{D}} \mid \sup_{x \in \mathcal{X}(r_j)} d(q(x), r_j(x)) \leq \tau\}$$

即所有在 $\mathcal{X}(r_j)$ 上以容差 $\tau$ 拟合 $r_j$ 的 f-chain 集合。§8.3 的子链替换直接膨胀等价类（三角不等式）。

$F_{\min}^{\delta_0}$ 是 $F$ 的 $\delta_0$-不可约核。冗余基 $F \supsetneq F_{\min}^{\delta_0}$ 中的额外成员 $g$ 将多步 f-chain 复合预编译为单步——有效链深降低。

**命题 14.1（链深不增性）**：对目标 $r_j$，定义：

- $k_{\min}(r_j) = \min\{k \mid \exists\, q \in (F_{\min}^{\delta_0})^{\leq k} : q \in [r_j]_\tau\}$：用不可约核拟合 $r_j$ 的最短链深
- $k_F(r_j) = \min\{k \mid \exists\, q \in F^{\leq k} : q \in [r_j]_\tau\}$：用完整基拟合 $r_j$ 的最短链深

则 $k_F(r_j) \leq k_{\min}(r_j)$。

**证明**：$F_{\min}^{\delta_0} \subseteq F$，故 $F$ 的链空间包含 $F_{\min}^{\delta_0}$ 的链空间，最短链深不增。$\square$

#### 冗余的微观收益

链深降低 $\Delta k = k_{\min} - k_F \geq 0$ 在微观层面的直接推论：

**命题 14.2（有效消耗步数上界）**：链 $q$ 的有效消耗步集 $\mathcal{A}^c(q)$（§7.6）满足 $|\mathcal{A}^c(q)| \leq k$，其中 $k$ 为 $q$ 的链长。因此：

$$|\mathcal{A}^c(q_F)| \;\leq\; k_F \;\leq\; k_{\min}$$

即更短的链有更紧的分辨率消耗上界（定理 7.10）。注意这是上界的比较，不是实际消耗步数的比较——短链的实际 $|\mathcal{A}^c|$ 不一定小于长链。

**证明**：$\mathcal{A}^c(x) \subseteq \{1, \ldots, k\}$（§7.6），故 $|\mathcal{A}^c| \leq k$。由命题 14.1，$k_F \leq k_{\min}$。$\square$

更精确的收益需要命题 8.9（可分解性的度量关系）的纤维保持条件。当冗余算子 $g \in F \setminus F_{\min}^{\delta_0}$ 以偏差 $\delta \leq \delta_0$ $(\phi_1, \phi_2)$-可分解，且满足纤维保持条件时：

- **拟合代价有界**：单步 $g$ 相对于展开链 $\phi_2 \circ \phi_1$ 的拟合偏差 $\leq \delta$（命题 8.9(i)）
- **吸收半径不退化**：$\underline{\alpha}_g^\varepsilon \geq \underline{\alpha}_{\phi_2 \circ \phi_1}^\varepsilon$——宏算子的纤维至少与其展开链一样厚（命题 8.9(ii)）

因此，冗余基在满足纤维保持条件时，以至多 $\delta$ 的拟合代价换取更短的链深和不退化的纤维厚度。

> **注（最小基的类比）**：$F_{\min}^{\delta_0}$ 可类比为系统的"基本指令集"——仅包含不可再分解的操作，一切复杂行为由组合推导。命题 14.1–10.8 表明这类最小配置的有效链深 $k_{\min}$ 最大，分辨率消耗上界最宽松。实际系统中冗余算子的存在——将常用子链预编译为单步——可视为以 $|F|$ 的增长换取链深的降低。

> **注（与 Kolmogorov 复杂度的类比）**：$F_{\min}^{\delta_0}$ 类似最短程序描述——最紧凑但执行需要最多步骤；冗余的 $F$ 类似带子程序缓存的描述——描述更长但执行更快。

> **注（纤维保持条件的限制）**：以上纤维层面的收益依赖命题 8.9 的纤维保持条件 $\underline{\alpha}_\psi^\varepsilon \geq \min(\underline{\alpha}_{\phi_1}^\varepsilon, \underline{\alpha}_{\phi_2}^\varepsilon)$。该条件要求宏算子的纤维至少与其组成部分的瓶颈一样厚——这是一个关于宏算子**内部结构**的非平凡假设，不能从可分解性本身推出。当条件不满足时，冗余仍降低链深，但纤维层面的优势无法保证。

----
*[IDFS] ⊢ [GLENZLI] ⊢ [Part 03] ⊢ [14-minimal-basis] ⊢ [284331b819e3db53]*
