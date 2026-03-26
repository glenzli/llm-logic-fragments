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

> **注（常值分量的跨界平庸化）**：设 $\mathbf{L} \in \mathscr{L}(\phi)$ 为任一合法 Lip 矩阵。如果 $i \in I_{\mathrm{const}}(\phi)$，意味着算子在目标分支 $d_i$ 上的输出差分恒为 $0$。因此目标为 $i$ 维度的 Lip 不等式自动退化为 $0 \leq \sum_{k \in I} L_{k \to i} \cdot d_k(x, y)$。这使得所有指向该分量 $i$ 的**接收端**约束 $L_{k \to i}$ 对系统性能全无限制。为捕捉最紧致拓扑，我们倾向于（且永远可以）将该分量的输入权值 $L_{k \to i}$ 彻底清零，宣告其对物理输入完全免疫。这与输出端 $L_{i \to j}$ 的约束（$d_i$ 的波动是否影响 $d_j$）毫无干系。

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

**证明**：由矩阵乘法定义，展开端到端端合法 Lip 矩阵的 $(i, j)$ 条目：
$$(\mathbf{L}_2 \cdot \mathbf{L}_1)_{i \to j} = \sum_{k \in I} L^{(2)}_{k \to j} \cdot L^{(1)}_{i \to k}$$

由于求和项 $L^{(2)}_{k \to j} \cdot L^{(1)}_{i \to k}$ 均为非负的 $\bar{\mathbb{R}}_+$ 元素，总和为 $0$ 的充要条件是每一子项均严格为 $0$。即对所有中间分量 $k \in I$：
$$L^{(2)}_{k \to j} \cdot L^{(1)}_{i \to k} = 0$$

在 $\bar{\mathbb{R}}_+$ 实数公理系中，两乘数均非负且无零因子的其他来源结构下，乘积为零意味着至少存在一侧的阻断：
$$L^{(1)}_{i \to k} = 0 \quad \text{或} \quad L^{(2)}_{k \to j} = 0$$
得证。$\square$

> **注（正交性网络）**：命题 2.3 揭示了算子链误差传播具有有向无环图（DAG）的代数结构性质。由于全是非负矩阵乘法（没有负权抵消），要在代数网络中隔绝任意两点的影响，必须严格斩断每一条途径全段链路的串扰可能。由于 $\mathscr{L}(\phi)$ 的不唯一性，某特定非对角 $\mathbf{L}$ 下未能展示被切断网络的事实，并不排除存在对角的 $\mathbf{L}^*$ 下展示了此隔离。

### 2.3 算子空间的复合几何

在算子空间 $(\Omega, d_{\Omega, d_i})$（§1.2）上，函数复合作用于算子间距离的性质。左复合与右复合具有根本不同的几何行为。

#### 左复合

**命题 2.4（左复合放缩）**：设交互截面 $S_{12} = (\mathrm{Im}(\phi_1) \cup \mathrm{Im}(\phi_2)) \cap \mathrm{dom}(\psi)$。若外层 $\psi$ 存在子集受限 Lip 矩阵 $\mathbf{L} \in \mathscr{L}(\psi)\big|_{S_{12}}$，则对 $\phi_1, \phi_2 \in \Omega$ 和 $j \in I$：

**(i) 受限多维放缩上界**：
$$d_{\Omega, d_j}(\psi \circ \phi_1,\; \psi \circ \phi_2) \;\leq\; \sum_{i \in I} L_{i \to j} \cdot d_{\Omega, d_i}(\phi_1, \phi_2)$$
此操作使得全域空间上算子间的测度差异，在各个分量上受制于外层受限矩阵组合包络。由于上确界的脱钩现象（见下注），在形式化方程中作为代数乘子的 $\mathbf{L}$ 并不能被直接定义为具备全域极值可达性的严格映射参数。

**(ii) 拓扑断接与隔离（部分退耦）**：当该受限矩阵的指定通路存在 $L_{i \to j} = 0$ 时，复合操作 $d_{\Omega, d_j}(\psi \circ \phi_1, \psi \circ \phi_2)$ 的距离放缩上界**仅依赖于**正交子集 $\{d_{\Omega, d_k}(\phi_1, \phi_2) \mid k \in I \setminus \{i\}\}$，而不受 $d_{\Omega, d_i}(\phi_1, \phi_2)$ 绝对偏导值的影响。这证明了：即使算子的全域测度上 $i \to j$ 存在强耦合关联，只要内侧算子的实际像集截面未触发该发散区域，系统在局部连通拓扑中依然会呈现绝对断接。

**(iii) 多维独立演化（完全退耦）**：更进一步地，若该受限矩阵 $\mathbf{L}$ 在像集子流形上已剥离为一枚非负对角矩阵，则针对每个独立分量 $i \in I$，距离极值必定遵循一维形式的不互扰不等式：
$$d_{\Omega, d_i}(\psi \circ \phi_1,\; \psi \circ \phi_2) \;\leq\; L_{i \to i} \cdot d_{\Omega, d_i}(\phi_1, \phi_2)$$
此时各分量的测度演化彼此严格正交，彻底杜绝了任何跨分量的交叉放大。

> **注（上确界次可加性诱导的界限松弛）**：左乘放缩公式应用了不等式 $\sup \sum \leq \sum \sup$。在多面度量组中，各自独立截取极值解除了统一输入变量对各个分量原本施加的物理耦合关联。为对抗这种绝对连加产生的虚拟极大值膨胀，本命题强制采用受限于真实像集交的紧致子集矩阵 $\mathbf{L}\big|_{S_{12}}$，该受限机制在随后推衍的连续长链复合（推论 2.5）中发挥了核心收敛作用。

**证明**：**(i)** 对任意 $x \in \mathrm{dom}(\psi \circ \phi_1) \cap \mathrm{dom}(\psi \circ \phi_2)$，由复合定义有 $\phi_1(x), \phi_2(x) \in S_{12}$。根据受限 Lip 不等式有：
$$d_j(\psi(\phi_1(x)), \psi(\phi_2(x))) \leq \sum_{i \in I} L_{i \to j} \cdot d_i(\phi_1(x), \phi_2(x))$$
取局部的 $\sup_x$，由 $\sup$ 在 $\bar{\mathbb{R}}_+$ 中依然成立的次可加性，推导限制放大关系：
$$\begin{aligned}
d_{\Omega, d_j}(\psi \circ \phi_1, \psi \circ \phi_2) &\leq \sup_x \sum_{i \in I} L_{i \to j} \cdot d_i(\phi_1(x), \phi_2(x)) \\
&\leq \sum_{i \in I} L_{i \to j} \cdot \sup_x d_i(\phi_1(x), \phi_2(x)) \\
&= \sum_{i \in I} L_{i \to j} \cdot d_{\Omega, d_i}(\phi_1, \phi_2)
\end{aligned}$$
**(ii)(iii)** 将 $L_{i \to j} = 0$ 和 $L_{k \to j} = 0 \, (k \neq j)$ 分别代入 (i) 之结果不等式，即显著成立。$\square$

**推论 2.5（左复合链拉伸）**：设外部存在长度为 $k$ 的算子链 $c_\psi = \psi_k \circ \cdots \circ \psi_1$。对内部待映射算子 $\phi_1, \phi_2 \in \Omega$，设定逐层截面 $S_p = (\mathrm{Im}(\psi_{p-1} \circ \cdots \circ \phi_1) \cup \mathrm{Im}(\psi_{p-1} \circ \cdots \circ \phi_2)) \cap \mathrm{dom}(\psi_p)$。若存在受限 Lip 矩阵阵列 $\mathbf{L}^{(p)} \in \mathscr{L}(\psi_p)\big|_{S_p}$，则全链复合的距离放缩天然满足多级连乘：
$$d_{\Omega, d_j}(c_\psi \circ \phi_1,\; c_\psi \circ \phi_2) \;\leq\; \sum_{i \in I} \left( \mathbf{L}^{(k)}\big|_{S_k} \cdots \mathbf{L}^{(1)}\big|_{S_1} \right)_{i \to j} \cdot d_{\Omega, d_i}(\phi_1, \phi_2)$$
此推论揭示了：当左侧发生连续多级算子复合时，外侧算子链的**特化矩阵连乘展开**共同构成了对内侧算子极差的级联放大矩阵包络。

**证明**：对链长 $k$ 进行数学归纳。当 $k=1$ 时，定义域交集退化为 $S_1 = (\mathrm{Im}(\phi_1) \cup \mathrm{Im}(\phi_2)) \cap \mathrm{dom}(\psi_1)$，不等式完全等同于命题 2.4(i)。假设结论对长度 $k-1$ 成立，当外部算子链左侧追加复合 $\psi_k$ 时，应用命题 2.4(i)，其外层放缩矩阵 $\mathbf{L}^{(k)}\big|_{S_k}$ 将线性左乘于内侧已形成的级差上限向量积左侧。利用矩阵乘法的完全结合律，该连乘结构在归纳步中完美保持。$\square$

#### 右复合

**命题 2.6（右复合收缩）**：对任意算子及伪度量分量 $d_i \in \mathcal{G}$：

**(i) 单体右复合收缩**：对 $\psi, \phi_1, \phi_2 \in \Omega$：
$$d_{\Omega, d_i}(\phi_1 \circ \psi,\; \phi_2 \circ \psi) \;=\; d_{\Omega, d_i}(\phi_1, \phi_2)\big|_{\mathrm{Im}(\psi)} \;\leq\; d_{\Omega, d_i}(\phi_1, \phi_2)$$
即右乘 $r_\psi: \phi \mapsto \phi \circ \psi$ 在每个分量 $d_{\Omega, d_i}$ 上是严格的 **1-Lipschitz** 映射——从不放大。当且仅当 $\mathrm{Im}(\psi)$ 全覆盖后续导致最大误差的极值流形时取等。

**(ii) 算子链的单调像集萎缩（Monotonic Domain Atrophy）**：设外部前置端存在长度为 $k$ 的右侧级联算子链 $c_\psi = \psi_k \circ \cdots \circ \psi_1$。由于算子间映射存在天然的子集包含关系：
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

综合命题 2.4–2.6 的结论，算子空间 $(\Omega, \circ, \mathcal{G}_\Omega)$ 中左右复合对测度的作用表现出根本性的非交换结构：左乘 $\ell_\psi: \phi \mapsto \psi \circ \phi$ 构成以受限 Lip 矩阵 $\mathbf{L}\big|_S$ 为系数的广义 Lipschitz 映射（命题 2.4），对于非对角阵 $\mathbf{L}$，可通过 $L_{i \to j} > 0$ 将分量 $i$ 上的算子差异耦合放大至分量 $j$；右乘 $r_\psi: \phi \mapsto \phi \circ \psi$ 在每个独立分量 $d_{\Omega, d_i}$ 上均为 $1$-Lipschitz 映射（命题 2.6），其效应等价于将距离核算区域限定至 $\mathrm{Im}(\psi) \subseteq \mathcal{X}$，不引入任何跨分量项。

> **注（内部算子的对偶射影属性）**：在链 $c_\phi = \phi_k \circ \cdots \circ \phi_1$ 中，任取中间元素 $\phi_m$（$1 < m < k$）：相对于其上游 $\phi_{m-1} \circ \cdots \circ \phi_1$ 而言，它是**左乘因子**，所以其内部的 Lip 因子直接决定了上游差异在此段的乘性放大上限；相对于其下游 $\phi_{m+1}$ 而言，它是**右乘因子**，故其累积产生的像集 $\mathrm{Im}(\phi_m \circ \cdots \circ \phi_1)$ 直接构成了下游后续测距的有效几何评价域上限。

> **注（前端算子对极差的条件截断）**：将宏观复合链视作一个演化管线时，处于下游的中间或末端算子仅在既存的前驱管线测度内执行依序放缩；而前端首发算子 $\phi_1$ 作为输入始基，直接承接全域空间 $\mathcal{X}$ 并定义了初始有效像集 $\mathrm{Im}(\phi_1)$，该像集构成了后续一切下游核算的理论最大流形基底。
> 若 $\phi_1$ 的初级映射在特定伪度量分量 $d_i$ 上发生了状态坍缩（即 $\sup d_i(\phi_1(x), \phi_1(y)) = 0$），该分量上的原始极差将转为零。然而，由于规范空间中各个伪度量族并无先验的正交隔离假定，这种坍缩**并不必然意味着该分量在后续演化链中永久归零**。如果下游的受限矩阵阵列 $\mathbf{L}^{(p)}\big|_{S_p}$ 存在从其他未坍缩分量向分量 $i$ 的满射（即存在 $m \neq i$ 使得矩阵元素 $L_{m \to i} > 0$），那么跨分量的耦合放缩就能将系统其他分量上的残余本征差异重新“注入”该测度。因此，前端首发阶段的局部极差归零，**仅在当前分量局部退耦（例如后续传递矩阵该列为空集）或所有存在潜在耦合前驱的分量群均被同步坍缩的严苛条件下**，才是单向且代数不可逆的。这进一步警示：在处理高度交织的复杂复合算子链时，对少数极差分量的强压并不能彻底切断全局不确定性在管线中的代数反渗。

#### 算子链内部摄动的双端隔离

**命题 2.7（单步摄动的双端隔离，Dual-End Perturbation Isolation）**：对于任意长度为 $k \geq 2$ 的级联算子链 $c_\phi = \phi_k \circ \cdots \circ \phi_1$，若在链条中途第 $m$ 步（$1 < m < k$）发生单步操作差分/摄动，导致替换为新链 $c_{\phi'} = (\phi_k \circ \cdots \circ \phi_{m+1}) \circ \psi_m \circ (\phi_{m-1} \circ \cdots \circ \phi_1)$。局部单步偏差 $(\phi_m, \psi_m)$ 对系统最终输出的分量测度 $j$ 的放缩影响，在代数结构上表现出严格的双端退耦切断特性：

**(i) 上游前置约化（定义域萎缩与条件归零）**：误差的初始激发测度，被上游空间严格限制在其前置算子链 $R_{\text{up}} = \phi_{m-1} \circ \cdots \circ \phi_1$ 传导而来的像集子流形上。若 $d_{\Omega, d_i}(\phi_m, \psi_m)\big|_{\mathrm{Im}(R_{\text{up}})} = 0$（即原副算子仅在输入盲区流形上存在偏离），该项极差即因未被触发而**直接归零**。

**(ii) 下游受限传递（连乘降维与代数切断）**：即便局部误差产生非零偏置，其向外层网络蔓延的代数测度扩散路径，已被强制锁定为下游各后续链路在实际像集截面 $S_p = \mathrm{Im}(\phi_{p-1} \circ \cdots \circ \phi_1) \cap \mathrm{dom}(\phi_p)$ 上的受限算子矩阵的连乘包络 $\mathbf{L}_{\text{down}} = \prod_{p=m+1}^{k} \mathbf{L}^{(p)}\big|_{S_p}$。一旦在这条受限传递路径内，发散通量触及了特定降层像集或引发了测度不关联，导致对应系数项 $(\mathbf{L}^{(p)}\big|_{S_p})_{i \to j} = 0$，代数上的乘法零元传递将彻底阻断剩余极差的一切传递，使该偏差项**彻底归零**。

因此对任意分量 $j \in I$，基于上述双端切断特性的宏观距离上限被数学锁定为以下乘积强约束形式：
$$d_{\Omega, d_j}(c_\phi, c_{\phi'}) \;\leq\; \sum_{i \in I} \left( \mathbf{L}^{(k)}\big|_{S_k} \cdots \mathbf{L}^{(m+1)}\big|_{S_{m+1}} \right)_{i \to j} \cdot d_{\Omega, d_i}(\phi_m, \psi_m)\Big|_{\mathrm{Im}(\phi_{m-1} \circ \cdots \circ \phi_1)}$$

**证明**：定义下游包含一切外层后置步骤的群左乘复合操作 $L_{\text{down}} = \phi_k \circ \cdots \circ \phi_{m+1}$，上游包含一切前置条件状态的群右乘复合操作 $R_{\text{up}} = \phi_{m-1} \circ \cdots \circ \phi_1$。此时系统等价于 $c_\phi = L_{\text{down}} \circ \phi_m \circ R_{\text{up}}$ 且 $c_{\phi'} = L_{\text{down}} \circ \psi_m \circ R_{\text{up}}$。
首先处理左端包络，由于 $L_{\text{down}}$ 构成单侧级联组系，利用前文**推论 2.5（算子链左复合多级拉伸）**，其天然的最紧代数上限界限直接退化为内部各个特化算子局部受限矩阵的左乘连积 $\mathbf{L}_{\text{down}}$：
$$d_{\Omega, d_j}(L_{\text{down}} \circ (\phi_m \circ R_{\text{up}}),\; L_{\text{down}} \circ (\psi_m \circ R_{\text{up}})) \;\leq\; \sum_{i \in I} (\mathbf{L}_{\text{down}})_{i \to j} \cdot d_{\Omega, d_i}(\phi_m \circ R_{\text{up}},\; \psi_m \circ R_{\text{up}})$$
随后锁定对上述连加式括号内各项基础极差残量进行内部化约。沿管线直接套用**命题 2.6（右复合收缩）**的核心结论，将原本的宽泛全域差异收缩至 $R_{\text{up}}$ 的输出截断面：
$$d_{\Omega, d_i}(\phi_m \circ R_{\text{up}},\; \psi_m \circ R_{\text{up}}) \;=\; d_{\Omega, d_i}(\phi_m, \psi_m)\Big|_{\mathrm{Im}(R_{\text{up}})}$$
将该缩量的像集距离重写入方程，结合乘法零元吸收法则，上述 (i)(ii) 所述之双端退耦切断特性与公式完全同态。$\square$

**命题 2.8（全局漂移级联界，Global Telescoping Drift Bound）**：对于任意长度为 $k \geq 2$ 的基准算子链 $c_\phi = \phi_k \circ \cdots \circ \phi_1$ 与全新的平行算子链 $c_\psi = \psi_k \circ \cdots \circ \psi_1$。在规范测度下全量替换的全局漂移偏置，严格界定为各单向演化断面加权摄动差之和：
$$d_{\Omega, d_j}(c_\phi, c_\psi) \;\leq\; \sum_{m=1}^k \sum_{i \in I} \left( \prod_{p=m+1}^{k} \mathbf{L}^{(p)}[\phi] \right)_{i \to j} \cdot d_{\Omega, d_i}(\phi_m, \psi_m)\Big|_{\mathrm{Im}(\psi_{m-1} \circ \cdots \circ \psi_1)}$$
*(约定：当 $m=k$ 时，左侧连积退化为恒等测度；当 $m=1$ 时，局部像集限定拓展为全域 $\mathcal{X}$)*

**证明**：构造套叠的中间态序列 $H_m$（$0 \leq m \leq k$）：
设 $H_0 = c_\phi$，$H_m = \phi_k \circ \cdots \circ \phi_{m+1} \circ \psi_m \circ \cdots \circ \psi_1$，$H_k = c_\psi$。
由扩展伪度量 $d_{\Omega, d_j}$ 固有的三角不等式，全局偏差可平展开为：
$$d_{\Omega, d_j}(H_0, H_k) \;\leq\; \sum_{m=1}^k d_{\Omega, d_j}(H_{m-1}, H_m)$$
考察第 $m$ 步单次漂移差分。依定义：$H_{m-1} = L_{\text{down}}^{(m)} \circ \phi_m \circ R_{\text{up}}^{(m)}$ 且 $H_m = L_{\text{down}}^{(m)} \circ \psi_m \circ R_{\text{up}}^{(m)}$，其中 $L_{\text{down}}^{(m)} = \phi_k \circ \cdots \circ \phi_{m+1}$ 而 $R_{\text{up}}^{(m)} = \psi_{m-1} \circ \cdots \circ \psi_1$。
根据命题 2.7，在对下游应用 $L_{\text{down}}^{(m)}$ 放缩时，由于前端算子已全部洗换异构，输入坐标系不再内含于原 $\phi$ 链对应的狭窄像集流形 $S_p(\phi)$ 内。此时必须退回调用未受限面约束的全域 Lip 矩阵 $\mathbf{L}^{(p)}[\phi]$ 承接乘积演化；而基于右侧，其前驱输入依然严格等效限制于 $\mathrm{Im}(R_{\text{up}}^{(m)})$。单项代回求和算子即获本命题。$\square$

> **注（像集逸出与泛化矩阵退化）**：上述演化界揭示了全链路平移替换过程中的测度不对称性：当用新算子群 $c_\psi$ 整体替换旧群 $c_\phi$ 时，新前置级联体系 $\psi_{<m}$ 生成的流形依然服从前置收缩（受限于 $\mathrm{Im}(R_{\text{up}})$ 极差截面）；然而，由于新激发的像集点极易发生“像集逸出（Image Escape）”，不再被旧有的受限相空间截面 $S_p(\phi)$ 完全包含，该放缩估值将被迫全价代入未经局部限制的全域放缩矩阵阵列 $\mathbf{L}^{(p)}[\phi]$。这种测度域的边界逃逸，直接造成了下游原本依赖特定极差零点面所构筑的交叉乘性退耦发生全面失效。其代数必然性表明：在不满足纯对角化强隔离的复杂算子网络中执行基础算系换轨，由于不可避免地穿透原局部截面的零元限制区，系统将在几何量纲上大概率面临总体极差偏置的剧烈乘性上溢。

**推论 2.9（交换子界，Commutator Bound）**：对任意 $\phi, \psi \in \Omega$，设 $S = (\mathrm{Im}(\phi) \cup \mathrm{Im}(\psi)) \cap \mathrm{dom}(\psi)$。复合的非交换偏差在各分量 $j \in I$ 上严格界定为：
$$d_{\Omega, d_j}(\psi \circ \phi,\; \phi \circ \psi) \;\leq\; \sum_{i \in I} L^{(\psi)}_{i \to j}\big|_S \cdot d_{\Omega, d_i}(\phi, \psi) \;+\; d_{\Omega, d_j}(\phi, \psi)\Big|_{\mathrm{Im}(\psi)}$$
第一项为左乘 $\psi$ 对算子差异的矩阵耦合放大，第二项为右乘 $\psi$ 提供的像集域限制截断，二者分别源于复合的左右不对称性。

**证明**：插入中间项 $\psi \circ \psi$，由伪度量三角不等式展开：
$$d_{\Omega, d_j}(\psi \circ \phi,\; \phi \circ \psi) \;\leq\; d_{\Omega, d_j}(\psi \circ \phi,\; \psi \circ \psi) \;+\; d_{\Omega, d_j}(\psi \circ \psi,\; \phi \circ \psi)$$
对第一项，$\psi$ 作为左乘因子。由**命题 2.4（左复合放缩）**：
$$d_{\Omega, d_j}(\psi \circ \phi,\; \psi \circ \psi) \;\leq\; \sum_{i \in I} L^{(\psi)}_{i \to j}\big|_S \cdot d_{\Omega, d_i}(\phi, \psi)$$
对第二项，$\psi$ 作为右乘因子。由**命题 2.6（右复合收缩）**：
$$d_{\Omega, d_j}(\psi \circ \psi,\; \phi \circ \psi) \;=\; d_{\Omega, d_j}(\psi, \phi)\big|_{\mathrm{Im}(\psi)}$$
合并即得。$\square$

> **注（交换子界的退化条件）**：若 $\psi$ 在 $S$ 上的受限 Lip 矩阵为纯对角阵且各对角项 $L^{(\psi)}_{j \to j}\big|_S \leq 1$（即 $\psi$ 在各分量上均为非扩张映射），则第一项 $\leq d_{\Omega,d_j}(\phi,\psi)$，第二项 $\leq d_{\Omega,d_j}(\phi,\psi)$，总界退化为 $2 d_{\Omega,d_j}(\phi, \psi)$。反之，若 $\psi$ 的 Lip 矩阵存在 $L^{(\psi)}_{i \to j}\big|_S \gg 1$ 的强耦合放大项，则交换子偏差可远超算子距离本身——非交换程度随放缩强度同步加剧。

> **注（对偶形式）**：上述证明选取 $\psi \circ \psi$ 作为中间项，使 $\psi$ 同时承担左乘放缩与右乘截断的角色。对称地，选取 $\phi \circ \phi$ 可得对偶界，其中 $\phi$ 的 Lip 矩阵 $\mathbf{L}^{(\phi)}\big|_{S'}$ 出现在矩阵放大项，而 $\mathrm{Im}(\phi)$ 承担像集截断。取二者中较紧者，即获最优交换子估计。

### 2.4 复合系统中的分量传递律

在确立了算子复合对空间测度极差放缩的各种代数天堑（2.3 节）之后，我们需回溯剖析算子内禀特征在级联下的布尔态演化（即 2.2 节所定义的透明 $I_{\mathrm{id}}$、遮蔽 $I_{\mathrm{const}}$ 与活跃 $I_{\mathrm{act}}$ 分划）。
当处于不同局部拓扑相态的前后算子发生链式闭合时，宏观系统 $\phi_2 \circ \phi_1$ 在各个隔离伪度量分量 $i \in I$ 上的测度命运绝非两者的简单线性拼接。以下的命题群严格框定了这三种信息通道状态在复合运算下的代数继承约束。

**命题 2.10（活跃分量包含律）**：

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
$$d_i(\phi_2(\phi_1(x)), \phi_2(\phi_1(y))) \leq d_i(\phi_2(\phi_1(x)), \phi_1(x)) + d_i(\phi_1(x), \phi_1(y)) + d_i(\phi_1(y), \phi_2(\phi_1(y))) = 0$$
故复合在 $d_i$ 上非活跃。

**(d)** $i \in I_{\mathrm{const}}(\phi_1)$ 且 $i \in I_{\mathrm{const}}(\phi_2)$：
$$d_i(\phi_2(\phi_1(x)), \phi_2(\phi_1(y))) = 0$$
故复合在 $d_i$ 上非活跃。

**(ii)** 对 (i) 施加链长 $k$ 的数学归纳即得。$\square$

> **注（包含可能严格）**：即使 $i \in I_{\mathrm{act}}(\phi_1) \cap I_{\mathrm{act}}(\phi_2)$，复合后 $\phi_2 \circ \phi_1$ 在 $d_i$ 上也可能退化为恒等或常值——两步活跃变换可能互相抵消。

**命题 2.11（恒等分量保留律）**：$I_{\mathrm{id}}(\phi_1) \cap I_{\mathrm{id}}(\phi_2) \subseteq I_{\mathrm{id}}(\phi_2 \circ \phi_1)$。

**证明**：设 $i$ 包含于交集，即 $\phi_1, \phi_2$ 均在 $d_i$ 分量上为恒等映射。对所有可复合输入 $x \in \mathrm{dom}(\phi_2 \circ \phi_1)$，由三角不等式公设：
$$d_i(\phi_2(\phi_1(x)), x) \leq d_i(\phi_2(\phi_1(x)), \phi_1(x)) + d_i(\phi_1(x), x) = 0 + 0 = 0$$
故 $d_i((\phi_2 \circ \phi_1)(x), x) = 0$，即推得 $i \in I_{\mathrm{id}}(\phi_2 \circ \phi_1)$。$\square$

> **注（恒等分量非严格单调）**：互为逆元的操作可复合出新的恒等分量。若 $\phi_2 = \phi_1^{-1}$ 且二者能够发生定义域接驳，即便各自在 $d_i$ 上皆非透明操作，其复合算子链 $\phi_2 \circ \phi_1 = \mathrm{id}$ 亦必定在 $d_i$ 上触发透明特征。这印证了 $I_{\mathrm{id}}$ 随操作链路深化**不强制**保持单向缩减。

**命题 2.12（常值分量的反渗与退化）**：设 $i \in I_{\mathrm{const}}(\phi_m)$，算子链 $c_\phi = \phi_k \circ \cdots \circ \phi_1$（$k > m$）。
**(i)（代数耦合反渗情形）** $\phi_m$ 虽在分量 $d_i$ 上使输入极差测度归零，但若后续下游存在非对角的受限 Lip 矩阵（即在相应子集截面上满足存在 $j \neq i$ 使得 $L_{j \to i} > 0$），且前驱分量 $j$ 依然残存不为零的极差，则该残余测度将在乘法约束下重新映射回分量 $i$ 方向，引致 $i \in I_{\mathrm{act}}(c_\phi)$。

**(ii)（严格解耦退化情形）** 若后续所有算子 $\phi_{m+1}, \ldots, \phi_k$ 在对应的像集演化交面 $S_p$ 上均持有**纯对角阵**构型的受限 Lip 矩阵，则 $i \in I_{\mathrm{const}}(c_\phi) \cup I_{\mathrm{id}}(c_\phi)$。

**(iii)（连积矩阵列零判据）** 更一般地，提取下游全部有效演化连积矩阵 $\mathbf{L}_{\text{down}} = \prod_{p=m+1}^{k} \mathbf{L}^{(p)}\big|_{S_p}$。若该合并矩阵的第 $i$ 列满足 $(\mathbf{L}_{\text{down}})_{j \to i} = 0$ 对所有 $j \in I \setminus \{i\}$ 成立，则 $i \in I_{\mathrm{const}}(c_\phi) \cup I_{\mathrm{id}}(c_\phi)$。

**证明**：
**(i)** 利用非对角特化矩阵跨分量乘积的加法分配即可直接构造出正值极差结论反例。
**(ii)** $\phi_m$ 在 $d_i$ 上为常值映射，由此对所有 $x, y \in \mathrm{dom}(\phi_m)$ 恒有 $d_i(\phi_m(x), \phi_m(y)) = 0$。后续的对角化受限算则等效于：对任意 $p \in [m+1, k]$，除 $j=i$ 外不存在 $L_{j \to i} > 0$。利用 $\bar{\mathbb{R}}_+$ 下的零元乘法消去：
$$d_i(\phi_{m+1}(\phi_m(x)), \phi_{m+1}(\phi_m(y))) \leq L^{(m+1)}_{i \to i} \cdot 0 = 0$$
逐环递推即得 $d_i(c_\phi(x), c_\phi(y)) \equiv 0$。
**(iii)** 令 $R_{\text{up}} = \phi_{m-1} \circ \cdots \circ \phi_1$，对 $x, y \in \mathrm{dom}(c_\phi)$ 取 $u = R_{\text{up}}(x), v = R_{\text{up}}(y)$，已知 $d_i(\phi_m(u), \phi_m(v)) = 0$。展开：
$$d_i(c_\phi(x), c_\phi(y)) \leq \sum_{j \in I} (\mathbf{L}_{\text{down}})_{j \to i} \cdot d_j(\phi_m(u), \phi_m(v)) = (\mathbf{L}_{\text{down}})_{i \to i} \cdot 0 + \sum_{j \neq i} 0 \cdot d_j(\phi_m(u), \phi_m(v)) = 0$$
故 $c_\phi$ 在分量 $d_i$ 上退归恒等或常值。$\square$

----
*[IDFS] ⊢ [GLENZLI] ⊢ [Part 01] ⊢ [02-component-analysis]*
