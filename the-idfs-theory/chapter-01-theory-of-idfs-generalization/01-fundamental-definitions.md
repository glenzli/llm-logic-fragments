## 基本定义

### 1.1 度量空间与变换空间

设 $(\mathcal{X}, d)$ 为**度量空间**。指定一个**空元素** $\bot \in \mathcal{X}$，表示"无输出"或"不适用"。

定义**变换空间**：

$$\Omega = \{\, \phi : \mathcal{X} \to \mathcal{X} \;\big|\; \phi(\bot) = \bot \,\}$$

即 $\Omega$ 由所有**保 $\bot$ 映射**（$\bot$-preserving maps）构成。$\phi(x) = \bot$ 表示 $\phi$ 在 $x$ 处无输出。对 $\phi \in \Omega$，定义其**定义域**为使 $\phi$ 产生非空输出的全部输入：

$$\mathrm{dom}(\phi) \;\triangleq\; \bigl\{\, x \in \mathcal{X} \;\big|\; \phi(x) \neq \bot \,\bigr\}$$

$\mathrm{dom}(\phi)$ 即 $\phi$ 实际发生作用的输入集合。由 $\phi(\bot) = \bot$，复合链的定义域自然严格递缩：$\mathrm{dom}(\phi_2 \circ \phi_1) = \{x \in \mathrm{dom}(\phi_1) \mid \phi_1(x) \in \mathrm{dom}(\phi_2)\}$。

$\Omega$ 在函数复合下构成**幺半群**：$\phi_2 \circ \phi_1 \in \Omega$，$\mathrm{id}_{\mathcal{X}} \in \Omega$。

设 $R = \{r_1, r_2, \ldots, r_m\} \subset \Omega$ 为 $\Omega$ 的一个有限子集。

$R^*$ 为 $R$ 在复合运算下的**自由幺半群**：

$$R^* = \{ r_{i_k} \circ \cdots \circ r_{i_1} \mid k \geq 0,\ r_{i_j} \in R \}$$

$R^*$ 中长度为 $l$ 的元素 $q = r_{i_l} \circ \cdots \circ r_{i_1}$ 称为 **$r$-链**（$r$-chain），$l$ 为其**长度**（$l = 0$ 对应幺元 $\mathrm{id}_{\mathcal{X}}$）。

设 $\mathcal{S}$ 为 $R$ 的一次**采样**（sampling of $R$）：对每条规则 $r \in R$，指定其**采样域** $\mathcal{X}(r) \subseteq \mathrm{dom}(r)$，即在 $r$ 的定义域中选取的一个子集（一般有 $\mathcal{X}(r) \subsetneq \mathrm{dom}(r)$）。形式上：

$$\mathcal{S} \;=\; \bigl\{\, (r,\, \mathcal{X}(r)) \;\big|\; r \in R,\; \mathcal{X}(r) \subseteq \mathrm{dom}(r) \,\bigr\}$$

设 $\mathcal{T}_l$ 为 $\mathcal{S}$ 生成的、长度不超过 $l$ 的**有效链集**（Valid Chain Set up to length $l$）：

$$\mathcal{T}_l = \bigl\{\, q \in R^* \;\big|\; |q| \leq l \text{ 且 } \mathrm{dom}(q) \neq \emptyset \,\bigr\}$$

$\mathcal{T}_l$ 即 $R^*$ 中所有长度有界且**定义域非空**的 $r$-链，每个 $q \in \mathcal{T}_l$ 的输入域 $\mathrm{dom}(q)$ 由 $q$ 的级联映射行为完全决定。

在数学结构上，由于长链 $q$ 本身亦是变换空间 $\Omega$ 中的映射，将 $q$ 与其非空输入域结合而成的二元组 $(q, \mathrm{dom}(q))$，与微观采样集 $\mathcal{S}$ 中的基规则元素 $(r_i, \mathcal{X}(r_i))$ **结构上完全对应**（structurally analogous）。因此，有效链集 $\mathcal{T}_l$ 及附带的定义域集合，本质上构成了建立在自由幺半群 $R^*$ 上的**宏观采样集**（Macroscopic Sampling Set）。

> **定义（微观采样集的拓扑信息量，Topological Information of Sample Set）**：
> 微观采样集 $\mathcal{S}$ 在拓扑空间中并非无结构的散点，它定义了一个庞大的**目标集（Target Set）** $\mathcal{M}_\mathcal{S} \triangleq \{ (r, x) \mid (r, \mathcal{X}(r)) \in \mathcal{S},\, x \in \mathcal{X}(r) \} \subset \Omega \times \mathcal{X}$。为赋予其度量结构，我们在 $\Omega$ 上引入自然的上确界度量 $d_\Omega(r_i, r_j) \triangleq \sup_{x \in \mathrm{dom}(r_i) \cap \mathrm{dom}(r_j)} d(r_i(x), r_j(x))$（$\mathrm{dom}(r_i) \cap \mathrm{dom}(r_j) = \emptyset$ 时约定 $d_\Omega(r_i, r_j) = 0$），从而在积空间 $\Omega \times \mathcal{X}$ 上诱导积度量。对于给定的观测精度 $\epsilon > 0$，为度量该目标集所蕴含的空间信息量，我们定义采样集的**度量熵（Sample-Induced Metric Entropy）** 为覆盖该目标集所需的最小 $\epsilon$-球数量的对数：
> $$I_\epsilon(\mathcal{S}) \;\triangleq\; \log \mathcal{N}\bigl(\epsilon, \mathcal{M}_\mathcal{S}\bigr)$$
> 
> **注（组合爆炸的数学本源）**：当度量空间 $\mathcal{X}$ 承载离散序列生成（如自然语言处理）或复杂逻辑推理任务时，$\mathcal{X}$ 可被具体实例化为**有限维积空间**。设词汇表（或符号集）为 $(V, d_V)$，序列长度为 $N$，则空间具体化为 $\mathcal{X} = V^N$（或含缺失标记的 $(V \cup \{\bot_0\})^N$，其中 $\bot = (\bot_0, \ldots, \bot_0)$）。在此实例化下，若不同词元或逻辑分支在目标集 $\mathcal{M}_\mathcal{S}$ 上具有**高正交性**——即局部微小改变导致语义目标发生剧烈跳跃，使得不同序列需要独立的 $\epsilon$-球覆盖——则目标集呈现指数级碎裂的崎岖结构。其 $\epsilon$-覆盖数随序列长度呈指数级增长：$\mathcal{N}(\epsilon, \mathcal{M}_\mathcal{S}) \sim \mathcal{O}\bigl(|V|^N\bigr)$。因此，度量熵呈现线性发散下界：
> $$I_\epsilon(\mathcal{S}) \;=\; \Omega\bigl(N \cdot \log |V|\bigr)$$
> 随着逻辑链推导步数（上下文长度）$N$ 的不断增长，目标世界所需记忆的信息量趋向于无穷大（$I_\epsilon(\mathcal{S}) \to \infty$）。这构成了后续所有组合近似与误差分析的极限背景板。



### 1.2 输入驱动函数系统（IDFS）

**定义（输入驱动函数系统，Input-Driven Function System，IDFS）**：定义系统底座拓扑与其对信号的动态响应共同构成的一个复合结构体系为**输入驱动函数系统**，记作宏观系统映射 $\mathcal{F} = (F, \sigma)$，其中：

1. **函数集与基础拓扑约束** $F = \{f_1, f_2, \ldots, f_M\} \subset \Omega$：$\mathcal{X}$ 上有限个保 $\bot$ 映射的集合，$M = |F|$ 为函数集的大小。为保证系统宏观近似的可计算性与泛化能力，基础算子 $f \in F$ 需满足以下拓扑约束：
   - **像集全有界性（Total Boundedness）**：任意算子 $f \in F$ 的像集 $f(\mathcal{X})$ 为**全有界集**（对任意 $\epsilon > 0$，$f(\mathcal{X})$ 可被有限个 $\epsilon$-球覆盖）。
   - 此宽松拓扑约束（结合有限集合大小 $M < \infty$）自然推导出**度量熵一致有界（Uniformly Bounded Metric Entropy）**：对于任意分辨精度 $\epsilon > 0$，函数库中算子像集的柯尔莫哥洛夫 $\epsilon$-熵必然存在全局有限上界 $C_\epsilon < \infty$，使得：
     $$\sup_{f \in F} \log \mathcal{N}\left(\epsilon, \, f(\mathcal{X})\right) \;\le\; C_\epsilon$$

2. **选择映射与系统微观深度** $\sigma : \mathcal{X} \to F^*$：将当前输入 $x$ 映射到 $F$ 上的一个可变长度复合链 $\sigma(x) = f_{i_k} \circ f_{i_{k-1}} \circ \cdots \circ f_{i_1}$（$k \geq 1$），表示对该输入应执行的微观计算计划。定义系统的**微观计算深度（Micro-Depth）** $\mathcal{D}$ 为选择映射可能产生的最长计算链长度：
   $$\mathcal{D} \;\triangleq\; \sup_{x \in \mathcal{X}} \big|\sigma(x)\big| \;<\; \infty$$
   （其中 $|\sigma(x)|$ 表示链中底层函数的个数 $k$，有限性反映物理系统的有限计算资源约束），它表征了单步宏观引力下系统所能调用的最大微观操作上限。

**定义（IDFS 拓扑容量，Topological Capacity）**：IDFS 的系统容量可从两个互补维度刻画：

1. **像集容量（Image Capacity）**——系统能产生多少可分辨的输出值：
   $$\mathcal{C}_{\mathrm{img}}(F, \epsilon) \;\triangleq\; \log \mathcal{N}\Bigl(\epsilon,\, \bigcup_{x \in \mathcal{X}} \sigma(x)(x)\Bigr)$$
2. **路由容量（Routing Capacity）**——系统能提供多少可分辨的计算路径：
   $$\mathcal{C}_{\mathrm{route}}(F, \sigma, \epsilon) \;\triangleq\; \log\bigl(|\mathrm{Im}(\sigma)| \cdot e^{C_\epsilon}\bigr)$$

容量的上界由 §2 引理给出。

对初始点 $x \in \mathcal{X}$，$\sigma(x)$ 确定哪条链，执行该链即完成一次**计算步骤**，引入记号 $\Phi \in \Omega$ 代表系统在整个度量空间上诱导出的全局单步映射：

$$\Phi(x) \;\triangleq\; \sigma(x)(x)$$

即 $\Phi(x) = \sigma(x)(x) = (f_{i_k} \circ f_{i_{k-1}} \circ \cdots \circ f_{i_1})(x)$。

> **注（组合合法性与 IDFS 复合封闭性）**：由 $F \subset \Omega$ 且 $\Omega$ 在复合下构成幺半群，可直接验证：
> 1. **$\Phi \in \Omega$**：$\sigma(x) \in F^* \subseteq \Omega$，且 $\Phi(\bot) = \sigma(\bot)(\bot) = \bot$（因每个 $f_i(\bot) = \bot$）。
> 2. **$\Phi^l \in \Omega$**：幺半群的复合封闭性。
> 3. **$l$-步宏观同构系统**：对任意 $l \geq 1$，$\Phi^l$ 自身构成新的 IDFS $\mathcal{F}_l = (F, \sigma_l)$，其中 $\sigma_l(x) = \sigma(\Phi^{l-1}(x)) \circ \cdots \circ \sigma(\Phi(x)) \circ \sigma(x)$。IDFS 在宏观复合下呈现**代数自相似性**。

**系统要求（Lipschitz 约束与级联扩张定律）**：IDFS $\mathcal{F} = (F, \sigma)$ 须满足在全空间上具有全局单步 Lipschitz 连续性，即存在常数 $L \geq 0$ 使得 $\Phi \in \mathrm{Lip}_L(\mathcal{X})$：

$$d\bigl(\Phi(x),\, \Phi(y)\bigr) \leq L \cdot d(x, y) \quad \forall\, x, y \in \mathcal{X}$$

> **注（宏观系统 $\Phi$ 与微观算子 $f$ 的 Lipschitz 解耦）**：系统要求宏观迭代映射 $\Phi$ 满足全局 Lipschitz 常数 $L$，但这**不要求**微观基函数 $f \in F$ 在全空间上一致有界或全局 Lipschitz 连续。例如，$F$ 中可包含具有无界导数或局部极点的非线性算子 $f_{\text{unbounded}}$，以及保距算子 $f_{\text{id}}$。只要选择映射 $\sigma$ 保证在 $f_{\text{unbounded}}$ 发散的子空间内不被激活，而在其具有有限局部 Lipschitz 常数的区域内调度，并在算子切换边界保持适度的输出连续性，组合映射 $\Phi$ 依然可以构成具有有限稳定度 $L$ 的全局 Lipschitz 映射。换言之，全局 $L$ 是结构张量 $\sigma$ 对底层算子集 $F$ 进行分段定义域截断后的**宏观代数闭包性质**。IDFS 理论的自洽性完全独立于基算子 $f$ 在非激活区域的内蕴解析性质。

**定义（路径 Lipschitz 常数，Path Lipschitz Constant）**：在系统的实际动态转移中，局部的形变拉伸率完全由路由中心 $\sigma$ 为特定状态选定的映射路径决定。定义映射 $\Phi$ 沿任意合法路径的**有效局部 Lipschitz 常数**为 $L_q$（或在链式迭代中简记为第 $j$ 步的 $L_j$）。由于系统受全局稳态约束，必有上界：
$$L_q \;\leq\; L$$

**定义（路径 Lipschitz 跨度，Path Lipschitz Span）**：系统能力的非均匀性并非取决于静态孤立的基函数库 $F$（因某些 $f$ 在极端区域根本不会被激活），而是由 $\sigma$ 实际拼缀出的所有可能路径的动态曲率范围决定。定义系统 $\Phi$ 的 **路径 Lipschitz 跨度** $\kappa_\Phi \geq 1$ 为系统在全域内展现出的最强与最弱路径 Lipschitz 常数之比（约定下界非零）：
$$\kappa_\Phi \;\triangleq\; \frac{\sup L_q}{\inf L_q}$$
$\kappa_\Phi$ 精确地刻画了动态路由系统的有效内在异质分布。$\kappa_\Phi = 1$ 当且仅当系统在任意路径折点处表现出的空间变形率均完全等同。其决定泛化张力的深刻结构性意义见 §2.5。

**定义（路径等效 Lipschitz 常数 / 几何均值，Path Equivalent Lipschitz Constant / Geometric Mean）**：针对长度为 $l$ 的连续演化路径（涉及局部拉伸率 $L_1, L_2, \dots, L_l$），定义该路径的**等效宏观形变率（几何均值）**为主导端到端拉伸效果的平均倍率：
$$\bar{L} \;\triangleq\; \left(\prod_{j=1}^{l} L_j\right)^{1/l}$$
由于均值属性，恒有 $\inf L_q \leq \bar{L} \leq \sup L_q$。$\bar{L}$ 在度量系统深度演化的误差界限（见 §3 CAC 定理）与泛化张力（见 §2.5）中起核心收束作用。

---

针对 $l$-步连续复合映射 $\Phi^l$，依据考察尺度的不同，存在两重维度的**级联系统扩张律（Cascaded System Expansion Laws）**：

1. **全局理论上界（Global Theoretical Bound）**：由单步系统常数 $L$ 的指数累积，强制确立全局极限定界 $\Phi^l \in \mathrm{Lip}_{L^l}(\mathcal{X})$：
   $$d\bigl(\Phi^l(x),\, \Phi^l(y)\bigr) \leq L^l \cdot d(x, y)$$

2. **确切扩张尾积（Exact Expansion Tail Product）**：记第 $j$ 步的实际路径 Lipschitz 常数为 $L_j$。连续迭代映射的真实空间拉伸由路径张量的**尾部乘积（Tail Product）**决定。定义自第 $j$ 步至第 $l$ 步的累积截断乘积为：
   $$\Theta_{j,l} \;\triangleq\; \prod_{k=j}^{l} L_k \qquad \text{（约定 } j > l \text{ 时，空积 } \Theta_{j,l} = 1\text{）}$$
   此时，具体的局部端到端物理扩张存在一个更为紧致逼近的确切演化上界（其中由于每步 $L_k \leq L$，因而 $\Theta_{1,l} \leq L^l$ 恒成立）：
   $$d\bigl(\Phi^l(x),\, \Phi^l(y)\bigr) \leq \Theta_{1,l} \cdot d(x, y)$$



### 1.3 单步近似误差与容差集

**定义（单步近似误差与容差集，Single-Step Error & Tolerance Set）**：给定被诱导的全局系统映射 $\Phi$ 与采样集 $\mathcal{S} = \{(r_i, \mathcal{X}(r_i))\}_{i=1}^m$。定义 $\Phi$ 在 $\mathcal{X}(r_i)$ 上对 $r_i$ 的**单步近似误差**（Single-Step Approximation Error）为：

$$\varepsilon_i \;\triangleq\; \sup_{x \in \mathcal{X}(r_i)} d\bigl(\Phi(x),\, r_i(x)\bigr)$$

由此，定义 $\Phi$ 在 $\mathcal{S}$ 上的**容差集** $\mathcal{E}$ 为所有单步近似误差的集合：

$$\mathcal{E} \;\triangleq\; \bigl\{\, \varepsilon_i \;\big|\; (r_i, \mathcal{X}(r_i)) \in \mathcal{S} \,\bigr\}$$

记 $\varepsilon_{\max} = \max\, \varepsilon_i$。此时称 IDFS $\mathcal{F} = (F, \sigma)$ **以容差集 $\mathcal{E}$ 拟合了采样集 $\mathcal{S}$**。


### 1.4 $\Delta$-不可完美拟合集

**定义（规则的 $\Delta$-不可完美拟合集，$\Delta$-Imperfect Fitting Set of a Rule）**：设 $(r_i, \mathcal{X}(r_i)) \in \mathcal{S}$，给定容差阈值 $\Delta > 0$。定义系统 $\Phi$ 在该采样规则上的**不可完美拟合集**为误差超出阈值的输入子空间：

$$U_\Delta(r_i) \;\triangleq\; \bigl\{\, x \in \mathcal{X}(r_i) \;\big|\; d\bigl(\Phi(x),\, r_i(x)\bigr) \geq \Delta \,\bigr\}$$

**定义（系统的 $\Delta$-全局不可拟合集，Global $\Delta$-Unfittable Zone of IDFS）**：定义系统 $\Phi$ 在整个采样集 $\mathcal{S}$ 上的**全局不可拟合集**，为所有规则的不可拟合集的并集：

$$U_\Delta(\mathcal{S}) \;\triangleq\; \bigcup_{(r_i, \mathcal{X}(r_i)) \in \mathcal{S}} U_\Delta(r_i)$$

> **注（完美拟合集，Perfect Fitting Set）**：为考察极致精度的逼近区域，定义不可完美拟合集 $U_\Delta(r_i)$ 的补集，即系统的**$\Delta$-拟合集** $P_\Delta(r_i) = \{ x \in \mathcal{X}(r_i) \mid d(\Phi(x), r_i(x)) < \Delta \}$。考察极限情形 $\Delta \to 0^+$，该拟合集将严格收缩至极小值论域 $P_{0^+}(r_i) = \{ x \mid d(\Phi(x), r_i(x)) = 0 \}$，此即为系统在采样点上的**完美拟合集（Perfect Fitting Set）**。完美拟合集代表了模型对样本能实现“零误差绝对记忆”的极端点簇。

