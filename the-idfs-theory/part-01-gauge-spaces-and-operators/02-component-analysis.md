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

> **注（常值分量的跨界属性与代数等价性）**：设 $\mathbf{L} \in \mathscr{L}(\phi)$ 为合法 Lip 矩阵。如果 $i \in I_{\mathrm{const}}(\phi)$，意味着算子在目标分量 $d_i$ 上的测度差恒为 $0$。因 Lip 不等式自动退化为 $0 \leq \sum_{k \in I} L_{k \to i} \cdot d_k(x, y)$，所有指向该分量的接收端上限约束 $L_{k \to i}$ 不受系统限制。为捕捉最紧致属性，通常将该分量的输入项 $L_{k \to i}$ 置零。
> 对于局部受限矩阵 $\mathbf{K} \in \mathscr{K}(\phi)\big|_U$：若评估子集 $U$ 内存在具备非零正输入的变差对 $d_k > 0$，由于输出恒定 $d_i = 0$，下界约束严格要求 $0 \geq \sum_k K_{k \to i} \cdot d_k$。非负半环 $\bar{\mathbb{R}}_+$ 中此不等式迫使所有对应通路的接收系数积 $\mathbf{K}_{k \to i} = 0$。常值分量通过代数途径否决了具备正传递因子的保距接入口。

### 2.2 分量正交与通道保距性

**定义（分量正交与保距传递，Component Orthogonality & Transmission）**：对算子 $\phi$ 指定验证集：
- **正交性**：若存在 $\mathbf{L} \in \mathscr{L}(\phi)$ 使 $L_{i \to j} = 0$，称 $\phi$ 在分量对 $(d_i, d_j)$ 上**正交**。在此矩阵下 $d_i$-输入的差异不传至 $d_j$-输出。特别地，当 $\mathbf{L}$ 为对角矩阵时（即所有非对角项均为 0），称 $\phi$ 在该 Lip 矩阵下**分量完全解耦**——各分量独立演化，无跨分量耦合。
- **传递性**：若存在特定通路支撑域 $U \in \mathcal{U}_{i \to j}(\phi)$ 与合集受限矩阵 $\mathbf{K} \in \mathscr{K}(\phi)\big|_U$，满足系数 $K_{i \to j} > 0$，称 $\phi$ 在子集 $U$ 内保持 $d_i$ 至 $d_j$ 的**保距传递**。测距差异将呈非平庸态严格映射于输出内。

**命题 2.1（单向隔离与保距传递）**：

**(i) 单向隔离**：设 $L_{i \to j} = 0$。对任意仅在 $d_i$ 分量变差的输入 $x, y \in \mathrm{dom}(\phi)$ （即 $k \neq i$ 时 $d_k(x, y) = 0$），变换后其输出在 $d_j$ 分区退化归零。

**(ii) 单向传递**：对由约束条件确立的集 $U \in \mathcal{U}_{i \to j}(\phi)$ 及位向元素 $K_{i \to j} > 0$。若对于域内选定的变差点对满足 $d_i(x,y) > 0$，变换输出必然保持 $d_j(\phi(x), \phi(y)) > 0$。

**证明**：

**(i)** 对前置 $x, y \in \mathrm{dom}(\phi)$，由矩阵约束展开：
$$d_j(\phi(x), \phi(y)) \leq \sum_{k \in I} L_{k \to j} \cdot d_k(x, y) = L_{i \to j} \cdot d_i(x, y) + \sum_{k \in I \setminus \{i\}} L_{k \to j} \cdot 0$$
依约定 $0 \cdot (+\infty) = 0$ 且矩阵非负直接获取最终上界：$d_j(\phi(x), \phi(y)) \leq 0 + 0 = 0$。

**(ii)** 取 $x, y \in U$，代入合法的受限 co-Lip 下界 $\mathbf{K}$ 不等式系并化约：
$$d_j(\phi(x), \phi(y)) \geq \sum_{k \in I} K_{k \to j} \cdot d_k(x, y) \geq K_{i \to j} \cdot d_i(x, y) > 0$$
由于该下界严格大于零确证对应子分量的输出测度实现了正分离定理。$\square$

**命题 2.2（完全解耦等价性）**：$\phi \in \Omega$ 存在非负对角的合法 Lip 矩阵 $\mathbf{L}$（系统完全解耦），当且仅当对于任意分量 $i \in I$ 存在常数 $C_i \in \bar{\mathbb{R}}_+$，使得对任意输入 $x, y \in \mathrm{dom}(\phi)$，均满足独立分量隔离约束：
$$d_i(\phi(x), \phi(y)) \leq C_i \cdot d_i(x, y)$$

**证明**：此结论分两个方向证明。

**必要性（$\Rightarrow$）**：若存在合法的非负对角矩阵 $\mathbf{L} \in \mathscr{L}(\phi)$，则对所有 $k \in I \setminus \{i\}$ 有 $L_{k \to i} = 0$。根据合法 Lip 矩阵的定义公式展开：
$$d_i(\phi(x), \phi(y)) \leq \sum_{k \in I} L_{k \to i} \cdot d_k(x, y) = L_{i \to i} \cdot d_i(x, y)$$
令 $C_i = L_{i \to i} \in \bar{\mathbb{R}}_+$ 即可满足独立约束。

**充分性（$\Leftarrow$）**：若对于受检 $\phi$，各个分量对应的解耦约束均成立。直接构造矩阵 $\mathbf{L} = (L_{u \to v})_{u,v \in I}$，指定对角元 $L_{i \to i} = C_i$，非对角元 $L_{k \to i} = 0$（$k \in I \setminus \{i\}$）。则对于任意 $x, y \in \mathrm{dom}(\phi)$ 和 $i \in I$：
$$d_i(\phi(x), \phi(y)) \leq C_i \cdot d_i(x,y) = \sum_{k \in I} L_{k \to i} \cdot d_k(x, y)$$
放缩成立，故构造的非负对角矩阵 $\mathbf{L} \in \mathscr{L}(\phi)$，其代表着一个严格数学意义下的解耦结构。$\square$

**命题 2.3（链式阻断与保距传递定理）**：对于算子复合 $\phi_2 \circ \phi_1$：

**(i) 链式阻断**：复合算子对于全域矩阵积 $\mathbf{L}_2 \cdot \mathbf{L}_1 \in \mathscr{L}(\phi_2 \circ \phi_1)$ 在通路 $(d_i, d_j)$ 上达成绝对正交隔离（即 $(\mathbf{L}_2 \cdot \mathbf{L}_1)_{i \to j} = 0$），当且仅当对于任意的中间连接分量 $k \in I$，方程成立：
$$L^{(1)}_{i \to k} = 0 \quad \text{或} \quad L^{(2)}_{k \to j} = 0$$

**(ii) 链式贯穿**：基于局部受限空间的联乘下界矩阵 $\mathbf{K}_2 \cdot \mathbf{K}_1 \in \mathscr{K}(\phi_2 \circ \phi_1)\big|_{U_1}$，系统在分量轨道 $(i, j)$ 内拥有非零的传递属性（即 $(\mathbf{K}_2 \cdot \mathbf{K}_1)_{i \to j} > 0$），当且仅当其至少含有一个满足代数极性的桥接分量 $k \in I$，使得：
$$K^{(1)}_{i \to k} > 0 \quad \text{且} \quad K^{(2)}_{k \to j} > 0$$

**证明**：**(i)** 取算子积项并推导归总：
$$(\mathbf{L}_2 \cdot \mathbf{L}_1)_{i \to j} = \sum_{k \in I} L^{(2)}_{k \to j} \cdot L^{(1)}_{i \to k} = 0$$
由半环 $\bar{\mathbb{R}}_+$ 所有加和常系非负的性质，等式总和归零必然推导出每一内部子项的乘积严格为零。排除了无穷级发散界后，等价于至少有一侧乘因子为零。
**(ii)** 同步导出累加代数矩阵项：
$$(\mathbf{K}_2 \cdot \mathbf{K}_1)_{i \to j} = \sum_{k \in I} K^{(2)}_{k \to j} \cdot K^{(1)}_{i \to k} > 0$$
因所有参数均为半环内正态子元，总和严格大于零等价于存在至少一条各向接联层级均大于零的路径基底项。得证。$\square$

> **注（DAG 的二元代数结构）**：命题 2.3 指出算子复合在界限传导上属于非负有向无环图（DAG）模式。要实现两节点间的绝对正交隔离，必须切断它们之间所有的有向通路（即任一组合路径中至少存在一条零权边）；而确立保距传递下界，仅需该拓扑图上存在至少一条权重皆严格为正的有向路径。

### 2.3 算子空间的复合几何

在算子空间 $(\Omega, d_{\Omega, d_i})$（§1.2）上，函数复合作用于算子间距离的性质。左复合与右复合具有根本不同的几何行为。

#### 左复合

**命题 2.4（左复合放缩与单通道下界放缩）**：设内外级交互子集 $U_{12} = (\mathrm{Im}(\phi_1) \cup \mathrm{Im}(\phi_2)) \cap \mathrm{dom}(\psi)$。算子空间度量界限代数机制如下：

**(i) 受限 Lip 矩阵上界放缩**：若外层算子具有受限组合 $\mathbf{L} \in \mathscr{L}(\psi)\big|_{U_{12}}$：
$$d_{\Omega, d_j}(\psi \circ \phi_1,\; \psi \circ \phi_2) \;\leq\; \sum_{i \in I} L_{i \to j} \cdot d_{\Omega, d_i}(\phi_1, \phi_2)$$
左复合操作基于上确界次可加性（$\sup \sum \leq \sum \sup$），引入了允许多通路叠加包络的宏观度量上限。

**(ii) 左复合上界退耦**：在 (i) 的前提下，当特定通道正交（$L_{i \to j} = 0$）时，分量 $i$ 的测度不影响向分量 $j$ 的传递。若 $\mathbf{L}$ 为对角矩阵（系统完全解耦），全系统边界退化为单极分量线性放缩：
$$d_{\Omega, d_i}(\psi \circ \phi_1,\; \psi \circ \phi_2) \;\leq\; L_{i \to i} \cdot d_{\Omega, d_i}(\phi_1, \phi_2)$$

**(iii) 局部 co-Lip 单通道下界放缩**：对于任意满足保距传递特征的子集 $S \subseteq U_{12}$（即 $S \in \mathcal{U}_{i \to j}(\psi)$）及对应的受限下界矩阵 $\mathbf{K} \in \mathscr{K}(\psi)\big|_S$，算子距离可经由单一下界通道被独立提取：
$$d_{\Omega, d_j}(\psi \circ \phi_1,\; \psi \circ \phi_2) \;\geq\; K_{i \to j} \cdot d_{\Omega, d_i}(\phi_1, \phi_2)\Big|_{\{x \mid \phi_{1}(x), \phi_{2}(x) \in S\}}$$
这规避了下界全加和无法直接在上确界操作中等价翻转（$\sup \sum \ngeq \sum \sup$）的盲套困境。依据半环非负实数项特征应用单向截断律（$\sup \sum F_k \geq \sup F_i$，各 $F \geq 0$），在算子间建立出不可破除的级联界限。

> **注（上确界不对称性构造型）**：由 (i) 中的次可加操作推求泛函距离将强制性包含交叉上限。而对偶的底层构造 (iii) 依托单通道极值化与保距子集核算，确保跨维极差即使在复杂的混合传递中仍保持衰变底线。

**证明**：

**(i)** 提取重叠投射点 $x \in \mathrm{dom}(\psi \circ \phi_1) \cap \mathrm{dom}(\psi \circ \phi_2)$，像态满足 $\phi_1(x), \phi_2(x) \in U_{12}$ 。合规域展开：
$$d_j(\psi(\phi_1(x)), \psi(\phi_2(x))) \leq \sum_{i \in I} L_{i \to j} \cdot d_i(\phi_1(x), \phi_2(x))$$
等式对左边界集施加 $\sup_x$，于具有完备性的全范空间中分配次可加极限界：
$$\begin{aligned}
d_{\Omega, d_j}(\psi \circ \phi_1, \psi \circ \phi_2) &\leq \sup_x \sum_{i \in I} L_{i \to j} \cdot d_i(\phi_1(x), \phi_2(x)) \\
&\leq \sum_{i \in I} L_{i \to j} \cdot \sup_x d_i(\phi_1(x), \phi_2(x)) = \sum_{i \in I} L_{i \to j} \cdot d_{\Omega, d_i}(\phi_1, \phi_2)
\end{aligned}$$

**(ii)** 直接将 $L_{i \to j} = 0 \; (i \neq j)$ 代入全路方程，总共轭项的加和项均归为零点态消去，从而得出严格独立的自反系数 $L_{i \to i}$ 的界限判定法则。

**(iii)** 对任意 $x \in S$，由于 $\bar{\mathbb{R}}_+$ 中各项非负，可在不等式中独立保留单一条项得出：
$$d_j(\psi(\phi_1(x)), \psi(\phi_2(x))) \geq \sum_{k \in I} K_{k \to j} \cdot d_k(\phi_1(x), \phi_2(x)) \geq K_{i \to j} \cdot d_i(\phi_1(x), \phi_2(x))$$
对此逐点点态不等式的两边分别取上确界操作。由上确界 $\sup$ 在非负函数上的保序性（单调性），且受限子集 $S$ 上的常态确界不会超过全集确界，该泛函级的下界放缩必然在算子空间中天然成立。$\square$

**推论 2.5（左复合链拉伸）**：设外部存在长度为 $k$ 的算子链 $c_\psi = \psi_k \circ \cdots \circ \psi_1$。对内部待映射算子 $\phi_1, \phi_2 \in \Omega$，设定逐层中间子集 $U_p = (\mathrm{Im}(\psi_{p-1} \circ \cdots \circ \phi_1) \cup \mathrm{Im}(\psi_{p-1} \circ \cdots \circ \phi_2)) \cap \mathrm{dom}(\psi_p)$。若存在受限 Lip 矩阵阵列 $\mathbf{L}^{(p)} \in \mathscr{L}(\psi_p)\big|_{U_p}$，则全链复合的距离放缩天然满足多级连乘：
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
**(ii)** 利用集合依序嵌套 $\mathrm{Im}(c_\psi) \subseteq \mathrm{Im}(\psi_1)$ 代入即得。随着前置处理链路越发深长，评估上界极值所在的像集范围不断缩小，目标上确界 $\sup$ 理应呈现逐级单调非增的退缩趋势。$\square$

> **注（探测域截断）**：右乘复合 $r_\psi$ 等价于对目标算子族施加了**前置输入域截断**。既然内层映射将状态点压缩至 $\mathrm{Im}(\psi)$，那么外层算子 $\phi_1, \phi_2$ 仅在该子集上的映射行为会被系统触及。它们在补集 $\mathcal{X} \setminus \mathrm{Im}(\psi)$（即那些永远无法被 $\psi$ 抵达的孤立输入区域）上无论存在何种极端的映射规则分裂，这些差异都将对复合系统的评估绝对隔离（不可见）。

#### 左右复合的结构性对比

综合命题 2.4–2.6，左右复合在 $(\Omega, \mathcal{G}_\Omega)$ 上的度量行为具有根本性非对称：

- **左乘** $\ell_\psi: \phi \mapsto \psi \circ \phi$：以受限 Lip 矩阵 $\mathbf{L}\big|_U$ 为系数的广义 Lipschitz 映射（命题 2.4）。非对角元 $L_{i \to j} > 0$ 引入跨分量耦合放大。
- **右乘** $r_\psi: \phi \mapsto \phi \circ \psi$：在每个分量 $d_{\Omega, d_i}$ 上均为 $1$-Lipschitz 映射（命题 2.6），等价于将距离评估域限制至 $\mathrm{Im}(\psi) \subseteq \mathcal{X}$，无跨分量项。

> **注（链内算子的对偶角色）**：在链 $c_\phi = \phi_k \circ \cdots \circ \phi_1$ 中，$\phi_m$（$1 < m < k$）同时扮演两个角色：作为上游 $\phi_{m-1} \circ \cdots \circ \phi_1$ 的**左乘因子**，其 Lip 矩阵决定上游差异的乘性放大上界；作为下游 $\phi_{m+1}$ 的**右乘因子**，其累积像集 $\mathrm{Im}(\phi_m \circ \cdots \circ \phi_1)$ 限定下游的距离评估域。

> **注（首发算子的像集约束与跨分量再激活）**：$\phi_1$ 直接作用于全域 $\mathcal{X}$，其像集 $\mathrm{Im}(\phi_1)$ 构成后续全部下游评估域的初始上界。若 $\phi_1$ 在某分量 $d_i$ 上产生常值坍缩（$d_i(\phi_1(x), \phi_1(y)) = 0$，$\forall x, y \in \mathrm{dom}(\phi_1)$），则 $d_i^{(1)} = 0$。然而此归零**不必然持续**：若下游受限 Lip 矩阵存在非对角元 $L_{l \to i}^{(p)}\big|_{U_p} > 0$（$l \neq i$），其他未坍缩分量的残余测距可通过跨分量耦合重新注入分量 $i$（命题 2.12(i)）。$d_i$ 归零的不可逆性仅在以下条件下成立：后续连积矩阵 $\mathbf{L}_{\mathrm{down}}$ 的第 $i$ 列满足 $(\mathbf{L}_{\mathrm{down}})_{l \to i} = 0$（$\forall l \neq i$），即下游不存在向分量 $i$ 的跨分量耦合（命题 2.12(iii)）。

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


**推论 2.8（交换子界，Commutator Bound）**：对任意 $\phi, \psi \in \Omega$，设 $U = (\mathrm{Im}(\phi) \cup \mathrm{Im}(\psi)) \cap \mathrm{dom}(\psi)$。复合的非交换偏差在各分量 $j \in I$ 上严格界定为：
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

该不等式在以下 (ii)-(iii) 中作为从泛函界限向逐点界限的直接下降通道。

**推论 2.9（算子空间界限的点态退化）**：

**(i)（点对级联极距双限定理，对应推论 2.5）**：设 $c_k = \phi_k \circ \cdots \circ \phi_1$，代入确定的常量点约束映射 $\phi_{x_0}, \phi_{y_0}$。此逐层复合像集精确退化为只包含该双点的离散集 $U_m = \{\phi_{m-1} \dots \phi_1(x_0),\; \phi_{m-1} \dots \phi_1(y_0)\} \cap \mathrm{dom}(\phi_m)$。因脱离泛函状态无受上确界不对等分布阻滞干扰，代数上下级双重距范同阶闭合：

$$ \sum_{i \in I} \left( \prod_{m=k}^1 \mathbf{K}^{(m)}\big|_{U_m} \right)_{i \to j} d_i(x_0, y_0) \;\leq\; d_j(c_k(x_0), c_k(y_0)) \;\leq\; \sum_{i \in I} \left( \prod_{m=k}^1 \mathbf{L}^{(m)}\big|_{U_m} \right)_{i \to j} d_i(x_0, y_0)$$

**(ii)（单步替换的轨线定域界限，对应命题 2.7）**：设算子链 $c_\phi = \phi_k \circ \cdots \circ \phi_1$，在第 $m$ 步替换 $\phi_m \to \psi_m$，得新链 $c_{\phi'}$。对任意固定输入 $x_0 \in \mathcal{X}$，由逐点值不超过上确界，直接从命题 2.7 的结论下降：

$$d_j(c_\phi(x_0), c_{\phi'}(x_0)) \;\leq\; d_{\Omega, d_j}(c_\phi, c_{\phi'}) \;\leq\; \sum_{i \in I} (\mathbf{L}_{\text{down}})_{i \to j} \cdot d_{\Omega, d_i}(\phi_m, \psi_m)\Big|_{\mathrm{Im}(R_{\text{up}})}$$

其中 $R_{\text{up}} = \phi_{m-1} \circ \cdots \circ \phi_1$，$\mathbf{L}_{\text{down}} = \prod_{p=m+1}^{k} \mathbf{L}^{(p)}\big|_{U_p}$。进一步地，右端受限算子距离项同样可做逐点下降：令 $u_m = R_{\text{up}}(x_0)$，则

$$d_{\Omega, d_i}(\phi_m, \psi_m)\Big|_{\mathrm{Im}(R_{\text{up}})} \;\geq\; d_i(\phi_m(u_m), \psi_m(u_m))$$

需注意此逐点下降产生的是上界的进一步松弛而非收紧：$u_m$ 处的映射一致性仅保证该点位贡献为零，泛函界限仍可能由 $\mathrm{Im}(R_{\text{up}})$ 中其他点的偏差主导。

**(iii)（交换子偏差的单点位移界限，对应推论 2.8）**：对任意 $\phi, \psi \in \Omega$ 和固定点 $x_0 \in \mathcal{X}$，由逐点下降直接从推论 2.8 得：

$$d_j(\psi(\phi(x_0)),\; \phi(\psi(x_0))) \;\leq\; \sum_{i \in I} L^{(\psi)}_{i \to j}\big|_U \cdot d_{\Omega, d_i}(\phi, \psi) \;+\; d_{\Omega, d_j}(\phi, \psi)\Big|_{\mathrm{Im}(\psi)}$$

其中 $U = (\mathrm{Im}(\phi) \cup \mathrm{Im}(\psi)) \cap \mathrm{dom}(\psi)$。
> **注（(i) 与 (ii)-(iii) 的退化机制差异）**：(i) 通过将常值算子 $\phi_{x_0}, \phi_{y_0}$ 代入推论 2.5 的内侧位置实现严格代数退化——这是唯一需要常值算子构造的子项，因为推论 2.5 要求对两个不同的内侧算子求取泛函距离。(ii)-(iii) 的退化则更为直接：泛函上确界天然地逐点支配，故对于固定的 $x_0$，逐点值直接不超过已有的泛函界限，无需引入额外的代数构造。

### 2.5 复合系统中的分量传递律

本节分析分量分划 $(I_{\mathrm{id}}, I_{\mathrm{const}}, I_{\mathrm{act}})$ 在算子复合下的传递规律。


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
故 $i \notin I_{\mathrm{act}}(\phi_2 \circ \phi_1)$。

**(c)** $i \in I_{\mathrm{const}}(\phi_1)$ 且 $i \in I_{\mathrm{id}}(\phi_2)$：
两次应用三角不等式得：
$$d_i(\phi_2(\phi_1(x)), \phi_2(\phi_1(y))) \leq d_i(\phi_2(\phi_1(x)), \phi_1(x)) + d_i(\phi_1(x), \phi_1(y)) + d_i(\phi_1(y), \phi_2(\phi_1(y)))$$
其中：$d_i(\phi_2(\phi_1(x)), \phi_1(x)) = 0$（由 $i \in I_{\mathrm{id}}(\phi_2)$，令 $z = \phi_1(x)$）；$d_i(\phi_1(x), \phi_1(y)) = 0$（由 $i \in I_{\mathrm{const}}(\phi_1)$）；$d_i(\phi_1(y), \phi_2(\phi_1(y))) = d_i(\phi_2(\phi_1(y)), \phi_1(y)) = 0$（由伪度量对称性与 $i \in I_{\mathrm{id}}(\phi_2)$）。
故 $i \notin I_{\mathrm{act}}(\phi_2 \circ \phi_1)$。

**(d)** $i \in I_{\mathrm{const}}(\phi_1)$ 且 $i \in I_{\mathrm{const}}(\phi_2)$：
$$d_i(\phi_2(\phi_1(x)), \phi_2(\phi_1(y))) = 0$$
故 $i \notin I_{\mathrm{act}}(\phi_2 \circ \phi_1)$。

**(ii)** 对 (i) 施加链长 $k$ 的数学归纳即得。$\square$

> **注（包含可能严格）**：即使 $i \in I_{\mathrm{act}}(\phi_1) \cap I_{\mathrm{act}}(\phi_2)$，复合后 $\phi_2 \circ \phi_1$ 在 $d_i$ 上也可能退化为恒等或常值——两步活跃变换可能互相抵消。

**命题 2.11（恒等分量保留律）**：$I_{\mathrm{id}}(\phi_1) \cap I_{\mathrm{id}}(\phi_2) \subseteq I_{\mathrm{id}}(\phi_2 \circ \phi_1)$。

**证明**：设 $i$ 包含于交集，即 $\phi_1, \phi_2$ 均在 $d_i$ 分量上为恒等映射。对所有可复合输入 $x \in \mathrm{dom}(\phi_2 \circ \phi_1)$，由三角不等式公设：
$$d_i(\phi_2(\phi_1(x)), x) \leq d_i(\phi_2(\phi_1(x)), \phi_1(x)) + d_i(\phi_1(x), x) = 0 + 0 = 0$$
故 $d_i((\phi_2 \circ \phi_1)(x), x) = 0$，即推得 $i \in I_{\mathrm{id}}(\phi_2 \circ \phi_1)$。$\square$

> **注（恒等分量非严格单调）**：互为逆元的操作可复合出新的恒等分量。若 $\phi_2 = \phi_1^{-1}$ 且二者能够发生定义域接驳，即便各自在 $d_i$ 上皆非透明操作，其复合算子链 $\phi_2 \circ \phi_1 = \mathrm{id}$ 亦必定在 $d_i$ 上触发透明特征。这印证了 $I_{\mathrm{id}}$ 随操作链路深化**不强制**保持单向缩减。

**命题 2.12（状态分划的代数级联特性）**：
考虑算子链 $c_k = \phi_k \circ \cdots \circ \phi_1$：

**(i) 活跃分量的严格延拓**
设 $i_0 \in I_{\mathrm{act}}(\phi_1)$。若存在分量序列 $(i_0, i_1, \dots, i_k)$，满足各级像集 $U_m = \mathrm{Im}(\phi_{m-1} \dots \phi_1)$ 完全包含于对应步的保距通路支撑集 $U_m \in \mathcal{U}_{i_{m-1} \to i_m}(\phi_m)$ 中。
由 co-Lip 矩阵连乘法则，全链通路下界值为 $\prod_{m=1}^{k} K_{i_{m-1} \to i_m} > 0$。该大于零的系数使得初始测度极差不会在末端输出归零，即确保持续成立 $i_k \notin I_{\mathrm{const}}(c_k)$。

**(ii) 常值分量的跨分量再激活**
设在某复合节点 $i \in I_{\mathrm{const}}(\phi_m)$，算子输出差异局部归零。当且仅当存在下游受限 Lip 连积矩阵含有非对角元 $L_{l \to i}^{(p)} > 0$（$l \neq i$），且平行演化分量 $l$ 上同时传递非零伪度量，则经由跨分量线性组合，分量 $i$ 的测差可重新恢复非零响应，即满足 $i \in I_{\mathrm{act}}(c_k)$。

**(iii) 常值分量的绝对解耦退化**
令下游连积矩阵为 $\mathbf{L}_{\text{down}} = \prod_{p=m+1}^{k} \mathbf{L}^{(p)}\big|_{U_p}$。在 $i \in I_{\mathrm{const}}(\phi_m)$ 条件下，若 $\mathbf{L}_{\text{down}}$ 第 $i$ 列的非对角元均置零：$(\mathbf{L}_{\text{down}})_{l \to i} = 0 \; (\forall l \neq i)$，则所有跨分量并行路径均被等价切断。算子在此条件下的最终差分界限恒等收敛于 $0$，退化为 $i \in I_{\mathrm{const}}(c_k) \cup I_{\mathrm{id}}(c_k)$。

**证明**：
**(i)** 取满足输入 $d_{i_0} > 0$ 的测度对，因每层映射完全兼容其局部 co-Lip 通路，基于半环算术的链式传递要求输出必须严守 $d_{i_k} \ge (\prod_{m=1}^{k} K_{m}) \cdot d_{i_0} > 0$，验证其必未归向常值。
**(ii)** 利用 $\bar{\mathbb{R}}_+$ 实数半环方程的单向性构建不等式 $d_i \le \sum_{u} L_{u \to i} \cdot d_u$ 。即便某源节点处产生内部 $d_i=0$ 的退化态，一旦存在跨侧非负乘积 $L_{l \to i} \cdot d_l > 0$，输出实际度量即能在相应输入点对上被撑为正数。
**(iii)** 代入极值方程执行等价代数收缩展开。受限局部绝对归零强制约束 $d_i(\phi_m(u), \phi_m(v)) = 0$：
$$d_i(c_k(x), c_k(y)) \leq \sum_{l \in I} (\mathbf{L}_{\text{down}})_{l \to i} \cdot d_l(\phi_m(u), \phi_m(v)) = (\mathbf{L}_{\text{down}})_{i \to i} \cdot 0 + \sum_{l \neq i} 0 \cdot d_l(\phi_m(u), \phi_m(v)) = 0$$
因所有参数均为半环内正体常数元且矩阵等和归零方程在 $\bar{\mathbb{R}}_+$ 有且仅有恒等零解，截断判定结束。$\square$

----
*[IDFS] ⊢ [GLENZLI] ⊢ [Part 01] ⊢ [02-component-analysis] ⊢ [811f9a105cf11e6c]*
