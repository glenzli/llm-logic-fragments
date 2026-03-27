## 分量分析

### 2.1 算子的分量分划

**定义（分量分划，Component Decomposition）**：设 $\phi \in \Omega$，$\mathcal{G} = \{d_i\}_{i \in I}$ 为规范结构。定义：

- **恒等分量** $I_{\mathrm{id}}(\phi) = \{i \in I : \forall x \in \mathrm{dom}(\phi),\; d_i(\phi(x), x) = 0\}$。
- **常值分量** $I_{\mathrm{const}}(\phi) = \{i \in I \setminus I_{\mathrm{id}}(\phi) : \forall x, y \in \mathrm{dom}(\phi),\; d_i(\phi(x), \phi(y)) = 0\}$。
- **活跃分量** $I_{\mathrm{act}}(\phi) = I \setminus (I_{\mathrm{id}}(\phi) \cup I_{\mathrm{const}}(\phi))$。

三者互斥且穷尽：$I = I_{\mathrm{id}} \sqcup I_{\mathrm{const}} \sqcup I_{\mathrm{act}}$。若 $i$ 同时满足恒等与常值条件（$\mathrm{dom}(\phi)$ 中所有点在 $d_i$ 下不可区分且 $\phi$ 在 $d_i$ 上为恒等），优先归入 $I_{\mathrm{id}}$。$|I| = 1$ 时，分划退化为 $I_{\mathrm{act}} = I$（除非 $\phi = \mathrm{id}$ 或 $\phi$ 为常值映射）。

分量分划对应算子 $\phi$ 在每个分量伪度量上的三种行为模式：
- $i \in I_{\mathrm{id}}$：$\phi$ 在分量 $d_i$ 上**透明**——$d_i(\phi(x), x) = 0$ 对所有 $x \in \mathrm{dom}(\phi)$，输入的 $d_i$-结构被原封保持。
- $i \in I_{\mathrm{const}}$：$\phi$ 在分量 $d_i$ 上**遮蔽**——$d_i(\phi(x), \phi(y)) = 0$ 对所有 $x, y \in \mathrm{dom}(\phi)$，所有输出在 $d_i$ 下不可区分，$d_i$-信息被完全擦除。
- $i \in I_{\mathrm{act}}$：$\phi$ 在分量 $d_i$ 上**活跃**——$\phi$ 在 $d_i$ 下既非恒等亦非常值，输入的 $d_i$-差异被非平凡变换。

> **注（常值分量的跨界平庸化）**：设 $\mathbf{L} \in \mathscr{L}(\phi)$ 为任一合法 Lip 矩阵。如果 $i \in I_{\mathrm{const}}(\phi)$，意味着算子在目标分量 $d_i$ 上的输出差分恒为 $0$。因此目标为分量 $i$ 的 Lip 不等式自动退化为 $0 \leq \sum_{k \in I} L_{k \to i} \cdot d_k(x, y)$。这使得所有指向该分量 $i$ 的**接收端**约束 $L_{k \to i}$ 对系统性能全无限制。为捕捉最紧致拓扑，我们倾向于（且永远可以）将该分量的输入权值 $L_{k \to i}$ 彻底清零，宣告其对物理输入完全免疫。这与输出端 $L_{i \to j}$ 的约束（$d_i$ 的波动是否影响 $d_j$）毫无干系。

### 2.2 分量正交性

**定义（分量正交，Component Orthogonality）**：设 $\mathbf{L} \in \mathscr{L}(\phi)$。称 $\phi$ 在 $\mathbf{L}$ 下于分量对 $(d_i, d_j)$（$i \neq j$）上**正交**，若 $L_{i \to j} = 0$——在此归因方式下，$d_i$-输入对 $d_j$-输出无贡献。

**命题 2.1（正交性的单向隔离）**：设 $L_{i \to j} = 0$。若对于某对输入 $x, y \in \mathrm{dom}(\phi)$，它们仅在 $d_i$ 分量上可区分（即对所有 $k \in I \setminus \{i\}$，$d_k(x, y) = 0$），则其经过变换后在 $d_j$ 分量上的输出必不可区分。

**证明**：对上述 $x, y \in \mathrm{dom}(\phi)$，由 Lip 不等式及 $L_{i \to j} = 0$ 展开：
$$d_j(\phi(x), \phi(y)) \leq \sum_{k \in I} L_{k \to j} \cdot d_k(x, y) = L_{i \to j} \cdot d_i(x, y) + \sum_{k \in I \setminus \{i\}} L_{k \to j} \cdot 0$$
在 $\bar{\mathbb{R}}_+$ 算术下（特别是由 $0 \cdot \infty = 0$ 约定消除 $L_{k \to j}$ 为 $+\infty$ 时的发散风险）：
$$d_j(\phi(x), \phi(y)) \leq 0 \cdot d_i(x, y) + 0 = 0$$
故 $d_j(\phi(x), \phi(y)) = 0$，即纯 $d_i$-差异被 $d_j$ 输出通道严格屏蔽。$\square$

当 $\mathbf{L}$ 为对角矩阵时，$\phi$ 在该 Lip 矩阵下**分量完全解耦**——各分量独立演化，无跨分量耦合。

**命题 2.2（完全解耦等价性）**：$\phi \in \Omega$ 存在非负对角的合法 Lip 矩阵 $\mathbf{L}$（系统完全解耦），当且仅当对于任意分量 $i \in I$ 存在常数 $K_i \in \bar{\mathbb{R}}_+$，使得对任意输入 $x, y \in \mathrm{dom}(\phi)$，均满足独立分量隔离约束：
$$d_i(\phi(x), \phi(y)) \leq K_i \cdot d_i(x, y)$$

**证明**：此结论分两个方向证明。

**必要性（$\Rightarrow$）**：若存在合法的非负对角矩阵 $\mathbf{L} \in \mathscr{L}(\phi)$，则对所有 $k \in I \setminus \{i\}$ 有 $L_{k \to i} = 0$。根据合法 Lip 矩阵的定义公式展开：
$$d_i(\phi(x), \phi(y)) \leq \sum_{k \in I} L_{k \to i} \cdot d_k(x, y) = L_{i \to i} \cdot d_i(x, y)$$
令 $K_i = L_{i \to i} \in \bar{\mathbb{R}}_+$ 即可满足独立约束。

**充分性（$\Leftarrow$）**：若对于受检 $\phi$，各个分量对应的解耦约束均成立。直接构造矩阵 $\mathbf{L} = (L_{u \to v})_{u,v \in I}$，指定对角元 $L_{i \to i} = K_i$，非对角元 $L_{k \to i} = 0$（$k \in I \setminus \{i\}$）。则对于任意 $x, y \in \mathrm{dom}(\phi)$ 和 $i \in I$：
$$d_i(\phi(x), \phi(y)) \leq K_i \cdot d_i(x,y) = \sum_{k \in I} L_{k \to i} \cdot d_k(x, y)$$
放缩成立，故构造的非负对角矩阵 $\mathbf{L} \in \mathscr{L}(\phi)$，其代表着一个严格数学意义下的解耦结构。$\square$

**命题 2.3（正交性的链式阻断）**：对于算子复合 $\phi_2 \circ \phi_1$，其在合法 Lip 矩阵 $\mathbf{L}_2 \cdot \mathbf{L}_1 \in \mathscr{L}(\phi_2 \circ \phi_1)$ 上维持对分量 $(d_i, d_j)$ 的正交性（即 $(\mathbf{L}_2 \cdot \mathbf{L}_1)_{i \to j} = 0$），当且仅当对于任意中间分量 $k \in I$，均有：
$$L^{(1)}_{i \to k} = 0 \quad \text{或} \quad L^{(2)}_{k \to j} = 0$$

**证明**：由矩阵乘法定义，展开端到端合法 Lip 矩阵的 $(i, j)$ 条目：
$$(\mathbf{L}_2 \cdot \mathbf{L}_1)_{i \to j} = \sum_{k \in I} L^{(2)}_{k \to j} \cdot L^{(1)}_{i \to k}$$

由于求和项 $L^{(2)}_{k \to j} \cdot L^{(1)}_{i \to k}$ 均为非负的 $\bar{\mathbb{R}}_+$ 元素，总和为 $0$ 的充要条件是每一子项均严格为 $0$。即对所有中间分量 $k \in I$：
$$L^{(2)}_{k \to j} \cdot L^{(1)}_{i \to k} = 0$$

在 $\bar{\mathbb{R}}_+$ 中，非零元素的乘积非零（$0 \cdot (+\infty) = 0$ 为唯一涉及零因子的特殊约定），因此乘积为零意味着至少一侧为零：
$$L^{(1)}_{i \to k} = 0 \quad \text{或} \quad L^{(2)}_{k \to j} = 0$$
得证。$\square$

> **注（正交性网络）**：命题 2.3 揭示了算子链误差传播具有有向无环图（DAG）的代数结构性质。由于全是非负矩阵乘法（没有负权抵消），要在代数网络中隔绝任意两点的影响，必须严格斩断每一条途径全段链路的串扰可能。由于 $\mathscr{L}(\phi)$ 的不唯一性，某特定非对角 $\mathbf{L}$ 下未能展示被切断网络的事实，并不排除存在对角的 $\mathbf{L}^*$ 下展示了此隔离。

### 2.3 算子空间的复合几何

在算子空间 $(\Omega, d_{\Omega, d_i})$（§1.2）上，函数复合作用于算子间距离的性质。左复合与右复合具有根本不同的几何行为。

#### 左复合

**命题 2.4（左复合放缩）**：设交互截面 $U_{12} = (\mathrm{Im}(\phi_1) \cup \mathrm{Im}(\phi_2)) \cap \mathrm{dom}(\psi)$。若外层 $\psi$ 存在子集受限 Lip 矩阵 $\mathbf{L} \in \mathscr{L}(\psi)\big|_{U_{12}}$，则对 $\phi_1, \phi_2 \in \Omega$ 和 $j \in I$：

**(i) 受限放缩上界**：
$$d_{\Omega, d_j}(\psi \circ \phi_1,\; \psi \circ \phi_2) \;\leq\; \sum_{i \in I} L_{i \to j} \cdot d_{\Omega, d_i}(\phi_1, \phi_2)$$
此操作使得全域空间上算子间的测度差异，在各个分量上受制于外层受限矩阵组合包络。由于上确界的脱钩现象（见下注），在形式化方程中作为代数乘子的 $\mathbf{L}$ 并不能被直接定义为具备全域极值可达性的严格映射参数。

**(ii) 部分退耦**：当该受限矩阵的指定通路存在 $L_{i \to j} = 0$ 时，复合操作 $d_{\Omega, d_j}(\psi \circ \phi_1, \psi \circ \phi_2)$ 的距离放缩上界**仅依赖于**正交子集 $\{d_{\Omega, d_k}(\phi_1, \phi_2) \mid k \in I \setminus \{i\}\}$，而不受 $d_{\Omega, d_i}(\phi_1, \phi_2)$ 的绝对量值影响。这证明了：即使外层算子 $\psi$ 在全域 Lip 矩阵上 $i \to j$ 存在强耦合（$L_{i \to j} > 0$），只要内侧算子 $\phi_1, \phi_2$ 的实际像集落入 $\psi$ 的局部退耦区域（即受限矩阵 $\mathbf{L}\big|_{U_{12}}$ 在该通路上归零），系统在受限截面上依然呈现绝对断接。

**(iii) 完全退耦**：更进一步地，若该受限矩阵 $\mathbf{L}$ 在像集子流形上已剥离为一枚非负对角矩阵，则针对每个独立分量 $i \in I$，距离极值必定遵循一维形式的不互扰不等式：
$$d_{\Omega, d_i}(\psi \circ \phi_1,\; \psi \circ \phi_2) \;\leq\; L_{i \to i} \cdot d_{\Omega, d_i}(\phi_1, \phi_2)$$
此时各分量的测度演化彼此严格正交，彻底杜绝了任何跨分量的交叉放大。

> **注（上确界次可加性诱导的界限松弛）**：左乘放缩公式应用了不等式 $\sup \sum \leq \sum \sup$。在多面度量组中，各自独立截取极值解除了统一输入变量对各个分量原本施加的物理耦合关联。为对抗这种绝对连加产生的虚拟极大值膨胀，本命题强制采用受限于真实像集交的紧致子集矩阵 $\mathbf{L}\big|_{U_{12}}$，该受限机制在随后推衍的连续长链复合（推论 2.5）中发挥了核心收敛作用。

**证明**：**(i)** 对任意 $x \in \mathrm{dom}(\psi \circ \phi_1) \cap \mathrm{dom}(\psi \circ \phi_2)$，由复合定义有 $\phi_1(x), \phi_2(x) \in U_{12}$。根据受限 Lip 不等式有：
$$d_j(\psi(\phi_1(x)), \psi(\phi_2(x))) \leq \sum_{i \in I} L_{i \to j} \cdot d_i(\phi_1(x), \phi_2(x))$$
取局部的 $\sup_x$，由 $\sup$ 在 $\bar{\mathbb{R}}_+$ 中依然成立的次可加性，推导限制放大关系：
$$\begin{aligned}
d_{\Omega, d_j}(\psi \circ \phi_1, \psi \circ \phi_2) &\leq \sup_x \sum_{i \in I} L_{i \to j} \cdot d_i(\phi_1(x), \phi_2(x)) \\
&\leq \sum_{i \in I} L_{i \to j} \cdot \sup_x d_i(\phi_1(x), \phi_2(x)) \\
&= \sum_{i \in I} L_{i \to j} \cdot d_{\Omega, d_i}(\phi_1, \phi_2)
\end{aligned}$$
**(ii)(iii)** 将 $L_{i \to j} = 0$ 和 $L_{k \to j} = 0 \, (k \neq j)$ 分别代入 (i) 之结果不等式，即显著成立。$\square$

**推论 2.5（左复合链拉伸）**：设外部存在长度为 $k$ 的算子链 $c_\psi = \psi_k \circ \cdots \circ \psi_1$。对内部待映射算子 $\phi_1, \phi_2 \in \Omega$，设定逐层截面 $U_p = (\mathrm{Im}(\psi_{p-1} \circ \cdots \circ \phi_1) \cup \mathrm{Im}(\psi_{p-1} \circ \cdots \circ \phi_2)) \cap \mathrm{dom}(\psi_p)$。若存在受限 Lip 矩阵阵列 $\mathbf{L}^{(p)} \in \mathscr{L}(\psi_p)\big|_{U_p}$，则全链复合的距离放缩天然满足多级连乘：
$$d_{\Omega, d_j}(c_\psi \circ \phi_1,\; c_\psi \circ \phi_2) \;\leq\; \sum_{i \in I} \left( \mathbf{L}^{(k)}\big|_{U_k} \cdots \mathbf{L}^{(1)}\big|_{U_1} \right)_{i \to j} \cdot d_{\Omega, d_i}(\phi_1, \phi_2)$$
此推论揭示了：当左侧发生连续多级算子复合时，外侧算子链的**特化矩阵连乘展开**共同构成了对内侧算子极差的级联放大矩阵包络。

**证明**：对链长 $k$ 进行数学归纳。当 $k=1$ 时，定义域交集退化为 $U_1 = (\mathrm{Im}(\phi_1) \cup \mathrm{Im}(\phi_2)) \cap \mathrm{dom}(\psi_1)$，不等式完全等同于命题 2.4(i)。假设结论对长度 $k-1$ 成立，当外部算子链左侧追加复合 $\psi_k$ 时，应用命题 2.4(i)，其外层放缩矩阵 $\mathbf{L}^{(k)}\big|_{U_k}$ 将线性左乘于内侧已形成的级差上限向量积左侧。利用矩阵乘法的完全结合律，该连乘结构在归纳步中完美保持。$\square$

#### 右复合

**命题 2.6（右复合收缩）**：对任意算子及伪度量分量 $d_i \in \mathcal{G}$：

**(i) 单体右复合收缩**：对 $\psi, \phi_1, \phi_2 \in \Omega$：
$$d_{\Omega, d_i}(\phi_1 \circ \psi,\; \phi_2 \circ \psi) \;=\; d_{\Omega, d_i}(\phi_1, \phi_2)\big|_{\mathrm{Im}(\psi)} \;\leq\; d_{\Omega, d_i}(\phi_1, \phi_2)$$
即右乘 $r_\psi: \phi \mapsto \phi \circ \psi$ 在每个分量 $d_{\Omega, d_i}$ 上是严格的 **1-Lipschitz** 映射——从不放大。当且仅当 $\mathrm{Im}(\psi)$ 全覆盖后续导致最大误差的极值子集时取等。

**(ii) 像集单调萎缩**：设外部前置端存在长度为 $k$ 的右侧级联算子链 $c_\psi = \psi_k \circ \cdots \circ \psi_1$。由于算子间映射存在天然的子集包含关系：
$$\mathrm{Im}(\psi_k \circ \cdots \circ \psi_1) \;\subseteq\; \mathrm{Im}(\psi_{k-1} \circ \cdots \circ \psi_1) \;\subseteq\; \cdots \;\subseteq\; \mathrm{Im}(\psi_1) \;\subseteq\; \mathcal{X}$$
在复合链前缀逐步延长的全过程中，后端响应算子组 $\phi_1, \phi_2$ 实际能评估到的有效测评定义域将呈现绝对单调萎缩。因此，系统前端处理历史越深，整体距离极值的上限必单调收敛（非增）：
$$d_{\Omega, d_i}(\phi_1 \circ c_\psi,\; \phi_2 \circ c_\psi) \;\leq\; d_{\Omega, d_i}(\phi_1 \circ \psi_1,\; \phi_2 \circ \psi_1) \;\leq\; d_{\Omega, d_i}(\phi_1, \phi_2)$$

**证明**：**(i)** 依据空间伪度量定义完成域限制解析：
$$d_{\Omega, d_i}(\phi_1 \circ \psi, \phi_2 \circ \psi) = \sup_{x \in \mathrm{dom}(\phi_1 \circ \psi) \cap \mathrm{dom}(\phi_2 \circ \psi)} d_i(\phi_1(\psi(x)), \phi_2(\psi(x)))$$
令 $y = \psi(x)$。当 $x$ 遍历定义域时，$y$ 仅遍历 $\mathrm{Im}(\psi)$ 的有效子集。因该子集 $\subseteq \mathcal{X}$，故局部层面的上确界绝无可能突破全域极值界限：
$$\sup_{y \in \mathrm{Im}(\psi)} d_i(\phi_1(y), \phi_2(y)) \;\leq\; \sup_{y \in \mathcal{X}} d_i(\phi_1(y), \phi_2(y)) \;=\; d_{\Omega, d_i}(\phi_1, \phi_2)$$
**(ii)** 利用集合依序嵌套 $\mathrm{Im}(c_\psi) \subseteq \mathrm{Im}(\psi_1)$ 代入即得。随着前置处理链路越发深长，极值评估的截面集合不断缩小，目标上确界 $\sup$ 理应呈现逐级单调非增的退缩趋势。$\square$

> **注（探测域截断）**：右乘复合 $r_\psi$ 等价于对目标算子族施加了**前置输入域截断**。既然内层映射将状态点压缩至 $\mathrm{Im}(\psi)$，那么外层算子 $\phi_1, \phi_2$ 仅在该子集上的映射行为会被系统触及。它们在补集 $\mathcal{X} \setminus \mathrm{Im}(\psi)$（即那些永远无法被 $\psi$ 抵达的孤立输入区域）上无论存在何种极端的映射规则分裂，这些差异都将对复合系统的评估绝对隔离（不可见）。

#### 左右复合的结构性对比

综合命题 2.4–2.6，左右复合在 $(\Omega, \mathcal{G}_\Omega)$ 上的度量行为具有根本性非对称：

- **左乘** $\ell_\psi: \phi \mapsto \psi \circ \phi$：以受限 Lip 矩阵 $\mathbf{L}\big|_U$ 为系数的广义 Lipschitz 映射（命题 2.4）。非对角元 $L_{i \to j} > 0$ 引入跨分量耦合放大。
- **右乘** $r_\psi: \phi \mapsto \phi \circ \psi$：在每个分量 $d_{\Omega, d_i}$ 上均为 $1$-Lipschitz 映射（命题 2.6），等价于将距离评估域限制至 $\mathrm{Im}(\psi) \subseteq \mathcal{X}$，无跨分量项。

> **注（链内算子的对偶角色）**：在链 $c_\phi = \phi_k \circ \cdots \circ \phi_1$ 中，$\phi_m$（$1 < m < k$）同时扮演两个角色：作为上游 $\phi_{m-1} \circ \cdots \circ \phi_1$ 的**左乘因子**，其 Lip 矩阵决定上游差异的乘性放大上界；作为下游 $\phi_{m+1}$ 的**右乘因子**，其累积像集 $\mathrm{Im}(\phi_m \circ \cdots \circ \phi_1)$ 限定下游的距离评估域。

> **注（首发算子的像集约束与跨分量再激活）**：$\phi_1$ 直接作用于全域 $\mathcal{X}$，其像集 $\mathrm{Im}(\phi_1)$ 构成后续全部下游评估域的初始上界。若 $\phi_1$ 在某分量 $d_i$ 上产生常值坍缩（$d_i(\phi_1(x), \phi_1(y)) = 0$，$\forall x, y \in \mathrm{dom}(\phi_1)$），则 $d_i^{(1)} = 0$。然而此归零**不必然持续**：若下游受限 Lip 矩阵存在非对角元 $L_{l \to i}^{(p)}\big|_{U_p} > 0$（$l \neq i$），其他未坍缩分量的残余测距可通过跨分量耦合重新注入分量 $i$（命题 2.13(i)）。$d_i$ 归零的不可逆性仅在以下条件下成立：后续连积矩阵 $\mathbf{L}_{\mathrm{down}}$ 的第 $i$ 列满足 $(\mathbf{L}_{\mathrm{down}})_{l \to i} = 0$（$\forall l \neq i$），即下游不存在向分量 $i$ 的跨分量耦合（命题 2.13(iii)）。

#### 算子链内部摄动的双端隔离

**命题 2.7（单步摄动隔离）**：设 $c_\phi = \phi_k \circ \cdots \circ \phi_1$（$k \geq 2$），在第 $m$ 步（$1 < m < k$）将 $\phi_m$ 替换为 $\psi_m$，得 $c_{\phi'} = \phi_k \circ \cdots \circ \phi_{m+1} \circ \psi_m \circ \phi_{m-1} \circ \cdots \circ \phi_1$。记 $R_{\mathrm{up}} = \phi_{m-1} \circ \cdots \circ \phi_1$，$L_{\mathrm{down}} = \phi_k \circ \cdots \circ \phi_{m+1}$。则对任意分量 $j \in I$：

$$d_{\Omega, d_j}(c_\phi, c_{\phi'}) \;\leq\; \sum_{i \in I} \left( \mathbf{L}^{(k)}\big|_{U_k} \cdots \mathbf{L}^{(m+1)}\big|_{U_{m+1}} \right)_{i \to j} \cdot d_{\Omega, d_i}(\phi_m, \psi_m)\Big|_{\mathrm{Im}(R_{\mathrm{up}})}$$

该上界的结构由两个独立机制控制：

**(i) 上游评估域截断**：替换差异 $d_{\Omega, d_i}(\phi_m, \psi_m)$ 仅在 $\mathrm{Im}(R_{\mathrm{up}})$ 上评估（而非全域 $\mathcal{X}$）。若 $\phi_m$ 与 $\psi_m$ 在 $\mathrm{Im}(R_{\mathrm{up}})$ 上一致（$d_{\Omega, d_i}(\phi_m, \psi_m)\big|_{\mathrm{Im}(R_{\mathrm{up}})} = 0$），则该分量的贡献为零——上游链路未到达的输入区域上的差异不影响复合输出。

**(ii) 下游受限放缩**：非零的替换差异经下游链路 $L_{\mathrm{down}}$ 的受限 Lip 矩阵连积 $\mathbf{L}_{\mathrm{down}} = \prod_{p=m+1}^{k} \mathbf{L}^{(p)}\big|_{U_p}$ 放缩。若连积矩阵在某通路 $(i, j)$ 上为零（$(\mathbf{L}_{\mathrm{down}})_{i \to j} = 0$），则分量 $i$ 上的替换差异不传播至分量 $j$。

**证明**：$c_\phi = L_{\mathrm{down}} \circ \phi_m \circ R_{\mathrm{up}}$，$c_{\phi'} = L_{\mathrm{down}} \circ \psi_m \circ R_{\mathrm{up}}$。对 $L_{\mathrm{down}}$ 应用推论 2.5（左复合链拉伸）：
$$d_{\Omega, d_j}(c_\phi, c_{\phi'}) \;\leq\; \sum_{i \in I} (\mathbf{L}_{\mathrm{down}})_{i \to j} \cdot d_{\Omega, d_i}(\phi_m \circ R_{\mathrm{up}},\; \psi_m \circ R_{\mathrm{up}})$$
对右乘 $R_{\mathrm{up}}$ 应用命题 2.6（右复合收缩）：
$$d_{\Omega, d_i}(\phi_m \circ R_{\mathrm{up}},\; \psi_m \circ R_{\mathrm{up}}) \;=\; d_{\Omega, d_i}(\phi_m, \psi_m)\Big|_{\mathrm{Im}(R_{\mathrm{up}})}$$
代入即得。$\square$

**命题 2.8（等长链距离界）**：设 $c_\phi = \phi_k \circ \cdots \circ \phi_1$ 与 $c_\psi = \psi_k \circ \cdots \circ \psi_1$ 为等长算子链。则对任意分量 $j \in I$：
$$d_{\Omega, d_j}(c_\phi, c_\psi) \;\leq\; \sum_{m=1}^k \sum_{i \in I} \left( \prod_{p=m+1}^{k} \mathbf{L}^{(p)}[\phi] \right)_{i \to j} \cdot d_{\Omega, d_i}(\phi_m, \psi_m)\Big|_{\mathrm{Im}(\psi_{m-1} \circ \cdots \circ \psi_1)}$$
*（约定：$m=k$ 时连积为单位矩阵；$m=1$ 时像集限定为 $\mathcal{X}$）*

**证明**：构造中间链序列 $H_m = \phi_k \circ \cdots \circ \phi_{m+1} \circ \psi_m \circ \cdots \circ \psi_1$（$0 \leq m \leq k$），则 $H_0 = c_\phi$，$H_k = c_\psi$。由三角不等式：
$$d_{\Omega, d_j}(c_\phi, c_\psi) \;\leq\; \sum_{m=1}^k d_{\Omega, d_j}(H_{m-1}, H_m)$$
$H_{m-1}$ 与 $H_m$ 仅在第 $m$ 步不同：$H_{m-1} = L_{\mathrm{down}}^{(m)} \circ \phi_m \circ R_{\mathrm{up}}^{(m)}$，$H_m = L_{\mathrm{down}}^{(m)} \circ \psi_m \circ R_{\mathrm{up}}^{(m)}$，其中 $L_{\mathrm{down}}^{(m)} = \phi_k \circ \cdots \circ \phi_{m+1}$，$R_{\mathrm{up}}^{(m)} = \psi_{m-1} \circ \cdots \circ \psi_1$。对每一项应用命题 2.7 的结构：右侧像集限定于 $\mathrm{Im}(R_{\mathrm{up}}^{(m)})$；下游放缩使用 $\mathbf{L}^{(p)}[\phi]$（全域 Lip 矩阵而非受限矩阵，因为 $R_{\mathrm{up}}^{(m)}$ 来自 $\psi$ 链，其像集未必落在 $\phi$ 链的受限截面内）。代回求和即得。$\square$

> **注（受限矩阵与全域矩阵的退化）**：命题 2.7 中下游放缩使用受限 Lip 矩阵 $\mathbf{L}^{(p)}\big|_{U_p}$，可利用特定通路上的局部归零获得更紧界。命题 2.8 中由于中间链的前置部分来自 $\psi$ 而非 $\phi$，像集 $\mathrm{Im}(R_{\mathrm{up}}^{(m)})$ 可能超出 $\phi$ 链原有的受限域，迫使下游退回全域 Lip 矩阵 $\mathbf{L}^{(p)}[\phi]$。这是两条链之间距离估计较单步替换更为宽松的代数原因。


**推论 2.9（交换子界，Commutator Bound）**：对任意 $\phi, \psi \in \Omega$，设 $U = (\mathrm{Im}(\phi) \cup \mathrm{Im}(\psi)) \cap \mathrm{dom}(\psi)$。复合的非交换偏差在各分量 $j \in I$ 上严格界定为：
$$d_{\Omega, d_j}(\psi \circ \phi,\; \phi \circ \psi) \;\leq\; \sum_{i \in I} L^{(\psi)}_{i \to j}\big|_U \cdot d_{\Omega, d_i}(\phi, \psi) \;+\; d_{\Omega, d_j}(\phi, \psi)\Big|_{\mathrm{Im}(\psi)}$$
第一项为左乘 $\psi$ 对算子差异的矩阵耦合放大，第二项为右乘 $\psi$ 提供的像集域限制截断，二者分别源于复合的左右不对称性。

**证明**：插入中间项 $\psi \circ \psi$，由伪度量三角不等式展开：
$$d_{\Omega, d_j}(\psi \circ \phi,\; \phi \circ \psi) \;\leq\; d_{\Omega, d_j}(\psi \circ \phi,\; \psi \circ \psi) \;+\; d_{\Omega, d_j}(\psi \circ \psi,\; \phi \circ \psi)$$
对第一项，$\psi$ 作为左乘因子。由**命题 2.4（左复合放缩）**：
$$d_{\Omega, d_j}(\psi \circ \phi,\; \psi \circ \psi) \;\leq\; \sum_{i \in I} L^{(\psi)}_{i \to j}\big|_U \cdot d_{\Omega, d_i}(\phi, \psi)$$
对第二项，$\psi$ 作为右乘因子。由**命题 2.6（右复合收缩）**：
$$d_{\Omega, d_j}(\psi \circ \psi,\; \phi \circ \psi) \;=\; d_{\Omega, d_j}(\psi, \phi)\big|_{\mathrm{Im}(\psi)}$$
合并即得。$\square$

> **注（交换子界的退化条件）**：若 $\psi$ 在 $U$ 上的受限 Lip 矩阵为纯对角阵且各对角项 $L^{(\psi)}_{j \to j}\big|_U \leq 1$（即 $\psi$ 在各分量上均为非扩张映射），则第一项 $\leq d_{\Omega,d_j}(\phi,\psi)$，第二项 $\leq d_{\Omega,d_j}(\phi,\psi)$，总界退化为 $2 d_{\Omega,d_j}(\phi, \psi)$。反之，若 $\psi$ 的 Lip 矩阵存在 $L^{(\psi)}_{i \to j}\big|_U \gg 1$ 的强耦合放大项，则交换子偏差可远超算子距离本身——非交换程度随放缩强度同步加剧。

> **注（对偶形式）**：上述证明选取 $\psi \circ \psi$ 作为中间项，使 $\psi$ 同时承担左乘放缩与右乘截断的角色。对称地，选取 $\phi \circ \phi$ 可得对偶界，其中 $\phi$ 的 Lip 矩阵 $\mathbf{L}^{(\phi)}\big|_{U'}$ 出现在矩阵放大项，而 $\mathrm{Im}(\phi)$ 承担像集截断。取二者中较紧者，即获最优交换子估计。

### 2.4 算子空间极值的点态退化

对于定义域 $\mathcal{X}$ 内的任意固定点 $x_0 \in \mathcal{X}$，构造常值映射 $\phi_{x_0}: \mathcal{X} \to \mathcal{X}$，$\phi_{x_0}(z) \equiv x_0$。该映射满足 $\mathbf{L}(\phi_{x_0}) = \mathbf{0}$（零矩阵），且 $\mathrm{Im}(\phi_{x_0}) = \{x_0\}$。对于任意算子 $\psi \in \Omega$，复合 $\psi \circ \phi_{x_0}$ 即为常值映射 $z \mapsto \psi(x_0)$。因此，对任意两个固定点 $x_0, y_0 \in \mathcal{X}$ 及其对应的常值算子 $\phi_{x_0}, \phi_{y_0}$，算子空间伪度量退化为点态伪度量：

$$d_{\Omega, d_j}(\phi_{x_0}, \phi_{y_0}) = \sup_{z \in \mathcal{X}} d_j(x_0, y_0) = d_j(x_0, y_0)$$

利用该退化关系，2.3 节诸命题可直接导出以下点态演化界限。此外，由于算子空间伪度量本身即为逐点伪度量的上确界（$d_{\Omega,d_j}(\phi,\psi) = \sup_x d_j(\phi(x),\psi(x))$），对于任意固定点 $x_0$，逐点值始终不超过上确界：

$$d_j(\phi(x_0), \psi(x_0)) \;\leq\; d_{\Omega, d_j}(\phi, \psi)$$

该不等式在以下 (ii)-(iv) 中作为从泛函界限向逐点界限的直接下降通道。

**推论 2.10（算子空间界限的点态退化）**：

**(i)（点对的级联极差界限，对应推论 2.5）**：设 $c_\psi = \psi_k \circ \cdots \circ \psi_1$，令 $\phi_1 = \phi_{x_0}$，$\phi_2 = \phi_{y_0}$。推论 2.5 中逐层截面退化为 $U_m = \{\psi_{m-1} \circ \cdots \circ \psi_1(x_0),\; \psi_{m-1} \circ \cdots \circ \psi_1(y_0)\} \cap \mathrm{dom}(\psi_m)$（两点集或其子集）。代入推论 2.5 并利用上述退化等式，得：

$$d_j(c_\psi(x_0), c_\psi(y_0)) \;\leq\; \sum_{i \in I} \left( \prod_{m=1}^k \mathbf{L}^{(m)}\big|_{U_m} \right)_{i \to j} \cdot d_i(x_0, y_0)$$

**(ii)（单步替换的轨线定域界限，对应命题 2.7）**：设算子链 $c_\phi = \phi_k \circ \cdots \circ \phi_1$，在第 $m$ 步替换 $\phi_m \to \psi_m$，得新链 $c_{\phi'}$。对任意固定输入 $x_0 \in \mathcal{X}$，由逐点值不超过上确界，直接从命题 2.7 的结论下降：

$$d_j(c_\phi(x_0), c_{\phi'}(x_0)) \;\leq\; d_{\Omega, d_j}(c_\phi, c_{\phi'}) \;\leq\; \sum_{i \in I} (\mathbf{L}_{\text{down}})_{i \to j} \cdot d_{\Omega, d_i}(\phi_m, \psi_m)\Big|_{\mathrm{Im}(R_{\text{up}})}$$

其中 $R_{\text{up}} = \phi_{m-1} \circ \cdots \circ \phi_1$，$\mathbf{L}_{\text{down}} = \prod_{p=m+1}^{k} \mathbf{L}^{(p)}\big|_{U_p}$。进一步地，右端受限算子距离项同样可做逐点下降：令 $u_m = R_{\text{up}}(x_0)$，则

$$d_{\Omega, d_i}(\phi_m, \psi_m)\Big|_{\mathrm{Im}(R_{\text{up}})} \;\geq\; d_i(\phi_m(u_m), \psi_m(u_m))$$

需注意此逐点下降产生的是上界的进一步松弛而非收紧：$u_m$ 处的映射一致性仅保证该点位贡献为零，泛函界限仍可能由 $\mathrm{Im}(R_{\text{up}})$ 中其他点的偏差主导。

**(iii)（全链替换的轨迹离散差分和，对应命题 2.8）**：设旧链 $c_\phi$ 与新链 $c_\psi$ 等长。对任意固定输入 $x_0 \in \mathcal{X}$，同样由逐点下降直接从命题 2.8 得：

$$d_j(c_\phi(x_0), c_\psi(x_0)) \;\leq\; d_{\Omega, d_j}(c_\phi, c_\psi) \;\leq\; \sum_{m=1}^k \sum_{i \in I} \left( \prod_{p=m+1}^{k} \mathbf{L}^{(p)}[\phi] \right)_{i \to j} \cdot d_{\Omega, d_i}(\phi_m, \psi_m)\Big|_{\mathrm{Im}(R_{\text{up}}^{(m)})}$$

其中 $R_{\text{up}}^{(m)} = \psi_{m-1} \circ \cdots \circ \psi_1$。令 $u_m^{(\psi)} = R_{\text{up}}^{(m)}(x_0)$，各项受限算子距离均可进一步逐点松弛至 $d_i(\phi_m(u_m^{(\psi)}), \psi_m(u_m^{(\psi)}))$，给出沿新链轨迹各步中间态实点处新旧算子映射差异的加权离散求和的单点下界估计。

**(iv)（交换子偏差的单点位移界限，对应推论 2.9）**：对任意 $\phi, \psi \in \Omega$ 和固定点 $x_0 \in \mathcal{X}$，由逐点下降直接从推论 2.9 得：

$$d_j(\psi(\phi(x_0)),\; \phi(\psi(x_0))) \;\leq\; \sum_{i \in I} L^{(\psi)}_{i \to j}\big|_U \cdot d_{\Omega, d_i}(\phi, \psi) \;+\; d_{\Omega, d_j}(\phi, \psi)\Big|_{\mathrm{Im}(\psi)}$$

其中 $U = (\mathrm{Im}(\phi) \cup \mathrm{Im}(\psi)) \cap \mathrm{dom}(\psi)$。特别地，令 $\phi = \phi_{x_0}$（常值算子），则 $\psi \circ \phi_{x_0}$ 为常值映射 $z \mapsto \psi(x_0)$，$\phi_{x_0} \circ \psi$ 为常值映射 $z \mapsto x_0$。交换子界退化为算子 $\psi$ 在单点 $x_0$ 上的位移量界限：

$$d_j(\psi(x_0), x_0) \;\leq\; \sum_{i \in I} L^{(\psi)}_{i \to j}\big|_{\{x_0\}} \cdot d_i(x_0, \psi(x_0)) \;+\; d_j(x_0, \psi(x_0))\Big|_{\mathrm{Im}(\psi)}$$

> **注（(i) 与 (ii)-(iv) 的退化机制差异）**：(i) 通过将常值算子 $\phi_{x_0}, \phi_{y_0}$ 代入推论 2.5 的内侧位置实现严格代数退化——这是唯一需要常值算子构造的子项，因为推论 2.5 要求对两个不同的内侧算子求取泛函距离。(ii)-(iv) 的退化则更为直接：泛函上确界天然地逐点支配，故对于固定的 $x_0$，逐点值直接不超过已有的泛函界限，无需引入额外的代数构造。

### 2.5 复合系统中的分量传递律

在确立了算子复合对空间测度极差放缩的各种代数约束（2.3 节）及其点态退化形式（2.4 节）之后，我们需回溯剖析算子内禀特征在级联下的布尔态演化（即 2.2 节所定义的透明 $I_{\mathrm{id}}$、遮蔽 $I_{\mathrm{const}}$ 与活跃 $I_{\mathrm{act}}$ 分划）。
当处于不同局部拓扑相态的前后算子发生链式闭合时，宏观系统 $\phi_2 \circ \phi_1$ 在各个隔离伪度量分量 $i \in I$ 上的测度命运绝非两者的简单线性拼接。以下的命题群严格框定了这三种信息通道状态在复合运算下的代数继承约束。

**命题 2.11（活跃分量包含律）**：

**(i)** 对任意复合 $\phi_2 \circ \phi_1 \in \Omega$：
$$I_{\mathrm{act}}(\phi_2 \circ \phi_1) \;\subseteq\; I_{\mathrm{act}}(\phi_1) \cup I_{\mathrm{act}}(\phi_2)$$

**(ii)** 对任意有限算子链 $c_\phi = \phi_k \circ \cdots \circ \phi_1$（$k \ge 2$），由 (i) 的数学归纳直接推广：
$$I_{\mathrm{act}}(c_\phi) \subseteq \bigcup_{m=1}^k I_{\mathrm{act}}(\phi_m)$$
如果全链中所有单体算子对某一测度分量 $d_i$ 均表现为透明或遮蔽，则级联复合算子链无法在该分量上构成活跃指标。

**证明**：**(i)** 取逆否：设 $i \notin I_{\mathrm{act}}(\phi_1) \cup I_{\mathrm{act}}(\phi_2)$，即 $\phi_1$ 和 $\phi_2$ 在 $d_i$ 上各自为恒等或常值。需证 $i \notin I_{\mathrm{act}}(\phi_2 \circ \phi_1)$。以下推导假定 $x, y \in \mathrm{dom}(\phi_2 \circ \phi_1)$。分四种情况：

**(a)** $i \in I_{\mathrm{id}}(\phi_1)$ 且 $i \in I_{\mathrm{id}}(\phi_2)$：
$$d_i((\phi_2 \circ \phi_1)(x), x) \leq d_i(\phi_2(\phi_1(x)), \phi_1(x)) + d_i(\phi_1(x), x) = 0 + 0 = 0$$
故 $i \in I_{\mathrm{id}}(\phi_2 \circ \phi_1)$。

**(b)** $i \in I_{\mathrm{id}}(\phi_1)$ 且 $i \in I_{\mathrm{const}}(\phi_2)$：
$$d_i(\phi_2(\phi_1(x)), \phi_2(\phi_1(y))) = 0$$
故复合在 $d_i$ 上非活跃。

**(c)** $i \in I_{\mathrm{const}}(\phi_1)$ 且 $i \in I_{\mathrm{id}}(\phi_2)$：
两次应用三角不等式得：
$$d_i(\phi_2(\phi_1(x)), \phi_2(\phi_1(y))) \leq d_i(\phi_2(\phi_1(x)), \phi_1(x)) + d_i(\phi_1(x), \phi_1(y)) + d_i(\phi_1(y), \phi_2(\phi_1(y)))$$
其中：$d_i(\phi_2(\phi_1(x)), \phi_1(x)) = 0$（由 $i \in I_{\mathrm{id}}(\phi_2)$，令 $z = \phi_1(x)$）；$d_i(\phi_1(x), \phi_1(y)) = 0$（由 $i \in I_{\mathrm{const}}(\phi_1)$）；$d_i(\phi_1(y), \phi_2(\phi_1(y))) = d_i(\phi_2(\phi_1(y)), \phi_1(y)) = 0$（由伪度量对称性与 $i \in I_{\mathrm{id}}(\phi_2)$）。
故复合在 $d_i$ 上非活跃。

**(d)** $i \in I_{\mathrm{const}}(\phi_1)$ 且 $i \in I_{\mathrm{const}}(\phi_2)$：
$$d_i(\phi_2(\phi_1(x)), \phi_2(\phi_1(y))) = 0$$
故复合在 $d_i$ 上非活跃。

**(ii)** 对 (i) 施加链长 $k$ 的数学归纳即得。$\square$

> **注（包含可能严格）**：即使 $i \in I_{\mathrm{act}}(\phi_1) \cap I_{\mathrm{act}}(\phi_2)$，复合后 $\phi_2 \circ \phi_1$ 在 $d_i$ 上也可能退化为恒等或常值——两步活跃变换可能互相抵消。

**命题 2.12（恒等分量保留律）**：$I_{\mathrm{id}}(\phi_1) \cap I_{\mathrm{id}}(\phi_2) \subseteq I_{\mathrm{id}}(\phi_2 \circ \phi_1)$。

**证明**：设 $i$ 包含于交集，即 $\phi_1, \phi_2$ 均在 $d_i$ 分量上为恒等映射。对所有可复合输入 $x \in \mathrm{dom}(\phi_2 \circ \phi_1)$，由三角不等式公设：
$$d_i(\phi_2(\phi_1(x)), x) \leq d_i(\phi_2(\phi_1(x)), \phi_1(x)) + d_i(\phi_1(x), x) = 0 + 0 = 0$$
故 $d_i((\phi_2 \circ \phi_1)(x), x) = 0$，即推得 $i \in I_{\mathrm{id}}(\phi_2 \circ \phi_1)$。$\square$

> **注（恒等分量非严格单调）**：互为逆元的操作可复合出新的恒等分量。若 $\phi_2 = \phi_1^{-1}$ 且二者能够发生定义域接驳，即便各自在 $d_i$ 上皆非透明操作，其复合算子链 $\phi_2 \circ \phi_1 = \mathrm{id}$ 亦必定在 $d_i$ 上触发透明特征。这印证了 $I_{\mathrm{id}}$ 随操作链路深化**不强制**保持单向缩减。

**命题 2.13（常值分量的反渗与退化）**：设 $i \in I_{\mathrm{const}}(\phi_m)$，算子链 $c_\phi = \phi_k \circ \cdots \circ \phi_1$（$k > m$）。
**(i)（代数耦合反渗情形）** $\phi_m$ 虽在分量 $d_i$ 上使输入极差测度归零，但若后续下游存在非对角的受限 Lip 矩阵（即在相应子集截面上满足存在 $j \neq i$ 使得 $L_{j \to i} > 0$），且前驱分量 $j$ 依然残存不为零的极差，则该残余测度将在乘法约束下重新映射回分量 $i$ 方向，引致 $i \in I_{\mathrm{act}}(c_\phi)$。

**(ii)（严格解耦退化情形）** 若后续所有算子 $\phi_{m+1}, \ldots, \phi_k$ 在对应的像集演化交面 $U_p$ 上均持有**纯对角阵**构型的受限 Lip 矩阵，则 $i \in I_{\mathrm{const}}(c_\phi) \cup I_{\mathrm{id}}(c_\phi)$。

**(iii)（连积矩阵列零判据）** 更一般地，提取下游全部有效演化连积矩阵 $\mathbf{L}_{\text{down}} = \prod_{p=m+1}^{k} \mathbf{L}^{(p)}\big|_{U_p}$。若该合并矩阵的第 $i$ 列满足 $(\mathbf{L}_{\text{down}})_{j \to i} = 0$ 对所有 $j \in I \setminus \{i\}$ 成立，则 $i \in I_{\mathrm{const}}(c_\phi) \cup I_{\mathrm{id}}(c_\phi)$。

**证明**：
**(i)** 利用非对角特化矩阵跨分量乘积的加法分配即可直接构造出正值极差结论反例。
**(ii)** $\phi_m$ 在 $d_i$ 上为常值映射，由此对所有 $x, y \in \mathrm{dom}(\phi_m)$ 恒有 $d_i(\phi_m(x), \phi_m(y)) = 0$。后续的对角化受限算则等效于：对任意 $p \in [m+1, k]$，除 $j=i$ 外不存在 $L_{j \to i} > 0$。利用 $\bar{\mathbb{R}}_+$ 下的零元乘法消去：
$$d_i(\phi_{m+1}(\phi_m(x)), \phi_{m+1}(\phi_m(y))) \leq L^{(m+1)}_{i \to i} \cdot 0 = 0$$
逐环递推即得 $d_i(c_\phi(x), c_\phi(y)) \equiv 0$。
**(iii)** 令 $R_{\text{up}} = \phi_{m-1} \circ \cdots \circ \phi_1$，对 $x, y \in \mathrm{dom}(c_\phi)$ 取 $u = R_{\text{up}}(x), v = R_{\text{up}}(y)$，已知 $d_i(\phi_m(u), \phi_m(v)) = 0$。展开：
$$d_i(c_\phi(x), c_\phi(y)) \leq \sum_{j \in I} (\mathbf{L}_{\text{down}})_{j \to i} \cdot d_j(\phi_m(u), \phi_m(v)) = (\mathbf{L}_{\text{down}})_{i \to i} \cdot 0 + \sum_{j \neq i} 0 \cdot d_j(\phi_m(u), \phi_m(v)) = 0$$
故 $c_\phi$ 在分量 $d_i$ 上退归恒等或常值。$\square$

----
*[IDFS] ⊢ [GLENZLI] ⊢ [Part 01] ⊢ [02-component-analysis] ⊢ [6d792afb104baafb]*
