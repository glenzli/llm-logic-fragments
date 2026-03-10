# IDFC · Part 2a：数学建模与 CAC 定理证明

> **前置**：见 [Part 1 导论](part1-intro.md) 了解非正式动机与预测概览。
>
> **本文内容**：§1 形式定义（元组度量空间 $\mathcal{X} = V_1 \times \cdots \times V_N$、变换空间 $\Omega$、有限规则集 $R$；**IDFS 泛化定义** $(F,\sigma)$——纯抽象理论，不预设神经网络）；§2 核心假说 CAC 的严格抽象陈述；§3 定理完整证明（Telescope 展开 + UAT 补充 + TSC 框架）。神经网络的具体代数实例化见 [**Part 2c**](part2c-nn-algebraic.md)。
>
> **后续**：[Part 3](part3-deductions.md) 从本文定理推导全部推论；[Part 4](part4-empirical.md) 以 Transformer/Mamba/MoE 等架构分析与多组实验场景（幻觉、ICL、量化、Reversal Curse、Sycophancy 等）验证并锚定本文理论预测。

---

## 第一部分：数学模型的构造

## 1. 基本设定

### 1.1 状态空间与变换空间

设 $(\mathcal{X}, d)$ 为**度量空间**（状态空间）。指定一个**空元素** $\bot \in \mathcal{X}$，表示"无输出"或"不适用"。

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
> **注（组合爆炸的数学本源）**：当状态空间 $\mathcal{X}$ 承载离散序列生成（如自然语言处理）或复杂逻辑推理任务时，$\mathcal{X}$ 可被具体实例化为**有限维积空间**。设词汇表（或符号集）为 $(V, d_V)$，序列长度为 $N$，则状态空间具体化为 $\mathcal{X} = V^N$（或含缺失标记的 $(V \cup \{\bot_0\})^N$，其中 $\bot = (\bot_0, \ldots, \bot_0)$）。在此实例化下，若不同词元或逻辑分支在目标集 $\mathcal{M}_\mathcal{S}$ 上具有**高正交性**——即局部微小改变导致语义目标发生剧烈跳跃，使得不同序列需要独立的 $\epsilon$-球覆盖——则目标集呈现指数级碎裂的崎岖结构。其 $\epsilon$-覆盖数随序列长度呈指数级增长：$\mathcal{N}(\epsilon, \mathcal{M}_\mathcal{S}) \sim \mathcal{O}\bigl(|V|^N\bigr)$。因此，度量熵呈现线性发散下界：
> $$I_\epsilon(\mathcal{S}) \;=\; \Omega\bigl(N \cdot \log |V|\bigr)$$
> 随着逻辑链推导步数（上下文长度）$N$ 的不断增长，目标世界所需记忆的信息量趋向于无穷大（$I_\epsilon(\mathcal{S}) \to \infty$）。这构成了后续所有组合近似与误差分析的极限背景板。



### 1.2 输入驱动函数系统（IDFS）

**定义（输入驱动函数系统，Input-Driven Function System，IDFS）**：定义系统底座拓扑与其对信号的动态响应共同构成的一个复合结构体系为**输入驱动函数系统**，记作宏观系统映射 $\mathcal{F} \triangleq (F, \sigma)$，其中：

1. **函数集与基础拓扑约束** $F = \{f_1, f_2, \ldots, f_M\} \subset \Omega$：$\mathcal{X}$ 上有限个保 $\bot$ 映射的集合，$M = |F|$ 为函数集的大小。为保证系统宏观近似的可计算性与泛化能力，基础算子 $f \in F$ 需满足以下拓扑约束：
   - **像集全有界性（Total Boundedness）**：任意算子 $f \in F$ 的像集 $f(\mathcal{X})$ 为**全有界集**（对任意 $\epsilon > 0$，$f(\mathcal{X})$ 可被有限个 $\epsilon$-球覆盖）。
   - 此宽松拓扑约束（结合有限集合大小 $M < \infty$）自然推导出**度量熵一致有界（Uniformly Bounded Metric Entropy）**：对于任意分辨精度 $\epsilon > 0$，函数库中算子像集的柯尔莫哥洛夫 $\epsilon$-熵必然存在全局有限上界 $C_\epsilon < \infty$，使得：
     $$\sup_{f \in F} \log \mathcal{N}\left(\epsilon, \, f(\mathcal{X})\right) \;\le\; C_\epsilon$$

2. **选择映射与系统微观深度** $\sigma : \mathcal{X} \to F^*$：将当前输入 $x$ 映射到 $F$ 上的一个可变长度复合链 $\sigma(x) = f_{i_k} \circ f_{i_{k-1}} \circ \cdots \circ f_{i_1}$（$k \geq 1$），表示对该输入应执行的微观计算计划。定义系统的**微观计算深度（Micro-Depth）** $\mathcal{D}$ 为选择映射可能产生的最长计算链长度：
   $$\mathcal{D} \;\triangleq\; \sup_{x \in \mathcal{X}} \big|\sigma(x)\big| \;<\; \infty$$
   （其中 $|\sigma(x)|$ 表示链中底层函数的个数 $k$，有限性反映物理系统的有限计算资源约束），它表征了单步宏观引力下系统所能调用的最大微观操作上限。

> **引理（IDFS 拓扑容量分解，Topological Capacity Decomposition）**：
> IDFS 的系统容量可从两个互补维度刻画：
> 
> 1. **像集容量（Image Capacity）**——系统能产生多少**可分辨的输出值**：
>    $$\mathcal{C}_{\mathrm{img}}(F, \epsilon) \;\triangleq\; \log \mathcal{N}\Bigl(\epsilon,\, \bigcup_{x \in \mathcal{X}} \sigma(x)(x)\Bigr) \;\leq\; \log M + C_\epsilon$$
> 2. **路由容量（Routing Capacity）**——系统能提供多少**可分辨的计算路径**：
>    $$\mathcal{C}_{\mathrm{route}}(F, \sigma, \epsilon) \;\triangleq\; \log\bigl(|\mathrm{Im}(\sigma)| \cdot e^{C_\epsilon}\bigr) \;\leq\; \mathcal{D} \log M + C_\epsilon$$
> 
> **证明**：
> (1) 对任意输入 $x$，$\sigma(x) = f_{i_k} \circ \cdots \circ f_{i_1}$ 的输出必然落在末端算子 $f_{i_k}$ 的像集之内：$\sigma(x)(x) \in f_{i_k}(\mathcal{X})$。因此 $\bigcup_x \sigma(x)(x) \subseteq \bigcup_{i=1}^{M} f_i(\mathcal{X})$。由覆盖数的次可加性：$\mathcal{N} \leq \sum_{i=1}^{M} \mathcal{N}(\epsilon,\, f_i(\mathcal{X})) \leq M \cdot e^{C_\epsilon}$。取对数即得。
> (2) 系统可选择的不同微观计算链总数受限于 $|\mathrm{Im}(\sigma)| \leq \sum_{k=1}^{\mathcal{D}} M^k \leq M^{\mathcal{D}}$（当 $M \geq 2$ 时）。每条路径的像集覆盖数不超过 $e^{C_\epsilon}$。取对数即得。$\square$
> 
> **注（双容量的各自用途）**：像集容量 $\mathcal{C}_{\mathrm{img}}$ 是系统输出值域复杂度的**紧上界**，与链深 $\mathcal{D}$ 无关——更深的路由不扩展输出范围。路由容量 $\mathcal{C}_{\mathrm{route}}$ 则刻画了系统对不同输入做出差异化响应的能力，呈现 **离散路由熵（$\mathcal{D}\log M$） + 连续算子熵（$C_\epsilon$）** 的信息论双生结构。

对初始点 $x \in \mathcal{X}$，$\sigma(x)$ 确定哪条链，执行该链即完成一次**计算步骤**，引入记号 $\Phi \in \Omega$ 代表系统在整个状态空间上诱导出的全局单步映射：

$$\Phi(x) \;\triangleq\; \sigma(x)(x)$$

即 $\Phi(x) = \sigma(x)(x) = (f_{i_k} \circ f_{i_{k-1}} \circ \cdots \circ f_{i_1})(x)$。

> **命题（组合合法性与 IDFS 复合封闭性，Compositional Validity & IDFS Closure）**：
> 对任意满足 $(F, \sigma)$ 的 IDFS 体系，其全局单步映射 $\Phi$ 及任意 $l$ 步复合 $\Phi^l$ 具备以下代数与系统封闭性：
> 
> **证明**：
> 1. **单步变换闭包（$\Phi \in \Omega$）**：由 $F \subset \Omega$，$\forall f_i \in F$ 均满足 $f_i(\bot) = \bot$。根据 $\Omega$ 的复合封闭性，选择映射产生的任意微观链 $\sigma(x) \in F^* \subseteq \Omega$。特别地，$\Phi(\bot) = \sigma(\bot)(\bot)$；由于 $\sigma(\bot)$ 为某条微观链 $f_{i_k} \circ \cdots \circ f_{i_1}$，而每个 $f_i(\bot) = \bot$，故 $\Phi(\bot) = \bot$。因此 $\Phi \in \Omega$。
> 2. **群胚的长链组合闭包（$\Phi^l \in \Omega$）**：因 $\Omega$ 构成复合运算下的幺半群，系统执行 $l$ 步相继推理的宏观组合映射 $\Phi^l \triangleq \Phi \circ \dots \circ \Phi$ 亦必然合法。
> 3. **宏观体系的同构闭包（$l$-步宏观系统 $\mathcal{F}_l$）**：对于任意步数 $l \geq 1$，宏观映射 $\Phi^l$ 自身亦严格构成一个新的 IDFS。定义此由 $l$ 步演化诱导出的高阶复合架构为 **$l$-步宏观同构系统**（$l$-step Macro-Isomorphic System），记为 $\mathcal{F}_l \triangleq (F, \sigma_l)$。
>    其底座物理算子集 $F$ 不变，而依据系统中间态的动态演化，其宏观轨迹选择映射 $\sigma_l : \mathcal{X} \to F^*$ 可被显式构造为 $l$ 次微观选择的级联展开：
>    $$\sigma_l(x) \;\triangleq\; \sigma\bigl(\Phi^{l-1}(x)\bigr) \circ \cdots \circ \sigma\bigl(\Phi(x)\bigr) \circ \sigma(x)$$
>    这具有极其深刻的物理与结构意义：复杂动力系统的任意多步长链演化（乃至宏观的复合推理链 $\Phi^l$），在底层的数学架构上**完全等价于单次极致膨胀的 IDFS 运算** $\mathcal{F}_l$。IDFS 模型不仅统摄了微观层面的算子拼接，还在宏观生成尺度上呈现出完美的**数学分形与代数系统自相似性（Fractal Self-Similarity）**。$\square$

**系统要求（Lipschitz 约束与级联扩张定律）**：$(F, \sigma)$ 须满足在全空间上具有全局单步 Lipschitz 连续性，即存在常数 $L \geq 0$ 使得 $\Phi \in \mathrm{Lip}_L(\mathcal{X})$：

$$d\bigl(\Phi(x),\, \Phi(y)\bigr) \leq L \cdot d(x, y) \quad \forall\, x, y \in \mathcal{X}$$

针对 $l$-步连续复合映射 $\Phi^l$，依据考察尺度的不同，存在两重维度的**级联系统扩张律（Cascaded System Expansion Laws）**：

1. **全局理论上界（Global Theoretical Bound）**：由单步系统常数 $L$ 的指数累积，强制确立全局极限定界 $\Phi^l \in \mathrm{Lip}_{L^l}(\mathcal{X})$：
   $$d\bigl(\Phi^l(x),\, \Phi^l(y)\bigr) \leq L^l \cdot d(x, y)$$
2. **路径确切扩张积（Path-Exact Expansion Product）**：由于每次迭代的局部空间特性不同，记第 $j$ 步的**局部有效 Lipschitz 常数** $L_j$（$L_j \leq L$ 恒成立；确切定义依具体路径而定，见 §3 CAC 定理）。复合映射的真实空间拉伸由**尾部乘积（Tail Product）**决定。定义自第 $j$ 步至第 $l$ 步的累积截断乘积为：
   $$\Theta_{j,l} \;\triangleq\; \prod_{k=j}^{l} L_k \qquad \text{（约定 } j > l \text{ 时，空积 } \Theta_{j,l} = 1\text{）}$$
   此时，具体的局部端到端物理扩张存在一个更为紧致的确切演化上界（其中 $\Theta_{1,l} \leq L^l$ 恒成立）：
   $$d\bigl(\Phi^l(x),\, \Phi^l(y)\bigr) \leq \Theta_{1,l} \cdot d(x, y)$$



### 1.3 单步近似误差与容差集

**定义（单步近似误差与容差集，Single-Step Error & Tolerance Set）**：给定被诱导的全局系统映射 $\Phi$ 与采样集 $\mathcal{S} = \{(r_i, \mathcal{X}(r_i))\}_{i=1}^m$。定义 $\Phi$ 在 $\mathcal{X}(r_i)$ 上对 $r_i$ 的**单步近似误差**（Single-Step Approximation Error）为：

$$\varepsilon_i \;\triangleq\; \sup_{x \in \mathcal{X}(r_i)} d\bigl(\Phi(x),\, r_i(x)\bigr)$$

由此，定义 $\Phi$ 在 $\mathcal{S}$ 上的**容差集** $\mathcal{E}$ 为所有单步近似误差的集合：

$$\mathcal{E} \;\triangleq\; \bigl\{\, \varepsilon_i \;\big|\; (r_i, \mathcal{X}(r_i)) \in \mathcal{S} \,\bigr\}$$

记 $\varepsilon_{\max} = \max\, \varepsilon_i$。此时称 IDFS $(F, \sigma)$ **以容差集 $\mathcal{E}$ 拟合了采样集 $\mathcal{S}$**。


### 1.4 $\Delta$-不可完美拟合集

**定义（规则的 $\Delta$-不可完美拟合集，$\Delta$-Imperfect Fitting Set of a Rule）**：设 $(r_i, \mathcal{X}(r_i)) \in \mathcal{S}$，给定容差阈值 $\Delta > 0$。定义系统 $\Phi$ 在该采样规则上的**不可完美拟合集**为误差超出阈值的输入子空间：

$$U_\Delta(r_i) \;\triangleq\; \bigl\{\, x \in \mathcal{X}(r_i) \;\big|\; d\bigl(\Phi(x),\, r_i(x)\bigr) \geq \Delta \,\bigr\}$$

**定义（系统的 $\Delta$-全局不可拟合集，Global $\Delta$-Unfittable Zone of IDFS）**：定义系统 $\Phi$ 在整个采样集 $\mathcal{S}$ 上的**全局不可拟合集**，为所有规则的不可拟合集的并集：

$$U_\Delta(\mathcal{S}) \;\triangleq\; \bigcup_{(r_i, \mathcal{X}(r_i)) \in \mathcal{S}} U_\Delta(r_i)$$

> **注（完美拟合集，Perfect Fitting Set）**：为考察极致精度的逼近区域，定义不可完美拟合集 $U_\Delta(r_i)$ 的补集，即系统的**$\Delta$-拟合集** $P_\Delta(r_i) = \{ x \in \mathcal{X}(r_i) \mid d(\Phi(x), r_i(x)) < \Delta \}$。考察极限情形 $\Delta \to 0^+$，该拟合集将严格收缩至极小值论域 $P_{0^+}(r_i) = \{ x \mid d(\Phi(x), r_i(x)) = 0 \}$，此即为系统在采样点上的**完美拟合集（Perfect Fitting Set）**。完美拟合集代表了模型对样本能实现“零误差绝对记忆”的极端点簇。


---

## 2. IDFS 容量极限与结构简并

**引理 1（组合耗尽与路由满射，Combinatorial Exhaustion and Routing Surjection）**：
设 IDFS $(F, \sigma)$ 在 $\mathcal{X}$ 的某子集 $\mathcal{X}_{sub}$ 上以容差 $\epsilon$ 近似了由微观采样集 $\mathcal{S}$ 定义的目标集 $\mathcal{M}_\mathcal{S}$。若目标集的度量熵远超底层基算子的连续变形熵，即产生巨大的**信息阻抗（Information Impedance）**：
$$I_\epsilon(\mathcal{S}) \;\gg\; C_\epsilon$$

则依据鸽笼原理（Pigeonhole Principle），系统在 $\mathcal{X}_{sub}$ 上被激活的离散独立路径总数 $|\text{Im}(\sigma)|$ 必须具备指数级下界：
$$|\text{Im}(\sigma)| \;\ge\; e^{I_\epsilon(\mathcal{S}) - C_\epsilon} \;\to\; \infty$$

当目标集的复杂度逼近系统的**路由容量**天花板（即 $I_\epsilon(\mathcal{S}) \to \mathcal{C}_{\mathrm{route}} = \mathcal{D} \log M + C_\epsilon$）时，路由映射 $\sigma$ 将在 $\mathcal{X}_{sub}$ 上**退化为满射（Surjection）**：即 $\sigma(\mathcal{X}_{sub}) \approx F^{\le \mathcal{D}}$。

**证明**：
系统全局映射 $\Phi \triangleq \sigma(\cdot)(\cdot)$ 在 $\mathcal{X}_{sub}$ 上的像集可按激活路径分解。对每条被激活的路径 $q \in \text{Im}(\sigma)$，其像集 $q(\mathcal{X}_{sub})$ 的 $\epsilon$-覆盖数不超过 $e^{C_\epsilon}$（因 $q$ 的输出落在某末端算子 $f_i$ 的全有界像集内）。由覆盖数的次可加性：
$$\mathcal{N}\bigl(\epsilon, \Phi(\mathcal{X}_{sub})\bigr) \;\le\; \sum_{q \in \text{Im}(\sigma)} \mathcal{N}\bigl(\epsilon, q(\mathcal{X}_{sub})\bigr) \;\le\; |\text{Im}(\sigma)| \cdot e^{C_\epsilon}$$
若系统在 $\mathcal{X}_{sub}$ 上实现了对目标集的 $\epsilon$-近似，则 $\Phi(\mathcal{X}_{sub})$ 的覆盖数不低于目标集所需的 $e^{I_\epsilon(\mathcal{S})}$，故：
$$e^{I_\epsilon(\mathcal{S})} \;\le\; |\text{Im}(\sigma)| \cdot e^{C_\epsilon} \quad \Longrightarrow \quad |\text{Im}(\sigma)| \;\ge\; e^{I_\epsilon(\mathcal{S}) - C_\epsilon}$$
当 $I_\epsilon(\mathcal{S}) \to \mathcal{D} \log M + C_\epsilon$ 时，$|\text{Im}(\sigma)| \to M^\mathcal{D} = |F^{\le \mathcal{D}}|$，路由映射被迫耗尽所有可能的离散路径组合，构成满射。$\square$



**定义（路由混叠，Routing Aliasing）**：设 IDFS $(F, \sigma)$ 在子集 $\mathcal{X}_{sub} \subseteq \mathcal{X}$ 上运作。称在 $\mathcal{X}_{sub}$ 上存在第 $l$ 阶**路由混叠**，若存在 $x_1, x_2 \in \mathcal{X}_{sub}$ 使得模型在 $x_2$ 处的**单步微观路由决策**与从 $x_1$ 出发的 **$l$ 步宏观计算程序**完全等同：

$$\sigma(x_2) \;=\; \sigma_l(x_1) \;\triangleq\; \sigma\bigl(\Phi^{l-1}(x_1)\bigr) \circ \cdots \circ \sigma(x_1)$$

即系统用**同一条微观链**同时服务了一次单步任务（在 $x_2$ 处）和一次多步推理任务（从 $x_1$ 出发），形成计算程序层面的不可区分简并。路由混叠可由多种机制引起：组合耗尽（见引理 2）、$\sigma$ 的参数化约束、正则化、或有限精度表示等。

**引理 2（组合耗尽关下的路由混叠必然性，Necessity of Routing Aliasing under Combinatorial Exhaustion）**：
在存在组合耗尽（$\sigma$ 退化为对 $F^{\le \mathcal{D}}$ 的满射）的复杂区域 $\mathcal{X}_{sub}$ 中，路由混叠**必然发生**。具体而言，对于任意一点 $x_1 \in \mathcal{X}_{sub}$，若其 $l$ 步宏观前向轨道保持在满射区域内（即 $\Phi^j(x_1) \in \mathcal{X}_{sub}$，$j = 0, \ldots, l-1$），且所诱导的复合微观链 $\sigma_l(x_1)$ 的总长度未超出微观深度上限（$|\sigma_l(x_1)| \le \mathcal{D}$），则必然存在 $x_2 \in \mathcal{X}_{sub}$ 使得 $\sigma(x_2) = \sigma_l(x_1)$。

**证明**：
由假设，$\Phi^j(x_1) \in \mathcal{X}_{sub}$ 保证了级联展开 $\sigma_l(x_1)$ 中的每一步 $\sigma(\Phi^j(x_1))$ 均处于满射区域内。$\sigma_l(x_1)$ 作为 $F$ 中底层算子首尾相接构成的链，其总长度 $|\sigma_l(x_1)| \leq \mathcal{D}$，故 $\sigma_l(x_1) \in F^{\le \mathcal{D}}$。由 $\sigma$ 在 $\mathcal{X}_{sub}$ 上对 $F^{\le \mathcal{D}}$ 的满射性，原像空间中必存在 $x_2 \in \mathcal{X}_{sub}$ 使得 $\sigma(x_2) = \sigma_l(x_1)$。$\square$




---

## 3. CAC 定理

**定理（组合近似封闭性，Compositional Approximation Closure，CAC；亦称组合泛化定理，Combinatorial Generalization Theorem，CGT）**：设 $\mathcal{F} \triangleq (F, \sigma)$ 为 IDFS，$\Phi \in \mathrm{Lip}(\mathcal{X})$（§1.2）。若该基础 IDFS 以容差集 $\mathcal{E}$ 拟合了微观采样集 $\mathcal{S}$（§1.3），则由其诱导出的 $l$-步宏观系统 $\mathcal{F}_l \triangleq (F, \sigma_l)$，必将以宏观容差集 $\mathcal{E}^*$ 拟合由 $\mathcal{S}$ 生成的、深度限定为 $l$ 的宏观有效链集 $\mathcal{T}_l$（§1.1）。

具体而言，对任意宏观链 $q \in \mathcal{T}_l$（其中 $q = r_{i_l} \circ \cdots \circ r_{i_1}$，确切长度为 $l$），其所对应的宏观容差 $\varepsilon^*_q \in \mathcal{E}^*$ 由下式定界：对于任意初始输入 $x \in \mathrm{dom}(q)$，定义**理想轨道**与**近似轨道**：

$$h^*_0 = x, \quad h^*_j = r_{i_j}(h^*_{j-1}) \qquad \text{（理想轨道，沿 }r\text{-链执行）}$$
$$h_0 = x, \quad h_j = \Phi(h_{j-1}) \qquad \text{（近似轨道，沿 }\Phi\text{ 执行）}$$

记 $e_j = d(h_j,\, h^*_j)$（第 $j$ 步误差），$e_0 = 0$。记 $L_j \triangleq \mathrm{Lip}(\Phi\!\restriction_{(h_{j-1},\, h^*_{j-1})})$ 为第 $j$ 步的**路径局部 Lipschitz 常数**。记**尾部乘积**：

$$\Theta_{j,l} \;\triangleq\; \prod_{k=j}^{l} L_k \qquad \text{（$j > l$ 时约定空积 $\Theta_{j,l} = 1$）}$$

定义**误差累积放大系数**与**偏离累积放大系数**：

$$\Lambda_l \;\triangleq\; \sum_{j=1}^{l} \Theta_{j+1,l}\,, \qquad \Gamma_l \;\triangleq\; \sum_{j=1}^{l} \Theta_{j,l}$$

（关系：$\Gamma_l = \sum_{j=1}^l L_j \Theta_{j+1,l}$；若 $\Phi \in \mathrm{Lip}_L$，则 $\Gamma_l \leq L\Lambda_l$。）

对每步 $j$，记 $\delta_j \triangleq d\!\bigl(h^*_{j-1},\, \mathcal{X}(r_{i_j})\bigr)$ 为理想轨道第 $j-1$ 步距微观采样域 $\mathcal{X}(r_{i_j})$ 的偏离距离。则系统在整个链 $q$ 上的宏观容差界满足：

$$\varepsilon^*_q \;\triangleq\; \sup_{x \in \mathrm{dom}(q)} d\bigl(h_l,\, q(x)\bigr) \;\leq\; \sum_{j=1}^{l} \varepsilon_{i_j} \cdot \Theta_{j+1,l} \;+\; \sum_{j=1}^{l} \delta_j \cdot \Theta_{j,l}$$

**证明**：第 $j$ 步，取 $x'_j \in \mathcal{X}(r_{i_j})$ 为距 $h^*_{j-1}$ 最近的采样域点（$d(h^*_{j-1}, x'_j) = \delta_j$）。

由 $h_j = \Phi(h_{j-1})$，$h^*_j = r_{i_j}(h^*_{j-1})$，误差为：

$$e_j = d\bigl(\Phi(h_{j-1}),\, r_{i_j}(h^*_{j-1})\bigr)$$

插入两个中间点 $\Phi(h^*_{j-1})$ 和 $\Phi(x'_j)$，由三角不等式得：

$$e_j \;\leq\; d\bigl(\Phi(h_{j-1}),\, \Phi(h^*_{j-1})\bigr) + d\bigl(\Phi(h^*_{j-1}),\, \Phi(x'_j)\bigr) + d\bigl(\Phi(x'_j),\, r_{i_j}(x'_j)\bigr)$$

> **注（三项拆分的必要性）**
>
> **关于第三项**：$\varepsilon_{i_j}$ 的定义（§1.3）仅保证 $\Phi$ 在采样域 $\mathcal{X}(r_{i_j})$ 内对 $r_{i_j}$ 的误差受控。$x'_j \in \mathcal{X}(r_{i_j})$ 是采样域内最近点，故第三项 $\leq \varepsilon_{i_j}$；若直接用 $h^*_{j-1}$（可能在采样域外），无法套用 $\varepsilon_{i_j}$ 的界——这正是引入 $x'_j$ 并显式产生偏离代价 $\delta_j$ 的原因。
>
> **关于前两项为何不合并**：一个自然的替代是不引入 $h^*_{j-1}$ 作为中间点，而是直接对第一项和第二项合并，利用 $L$ 条件写：
>
> $$d\bigl(\Phi(h_{j-1}),\, \Phi(x'_j)\bigr) \;\leq\; L_j \cdot d(h_{j-1},\, x'_j)$$
>
> 然而 $d(h_{j-1}, x'_j)$ 等于 $e_{j-1} + \delta_j$（近似轨道到采样域最近点的距离），在 $e_{j-1}$ 已经积累较大时，这一距离可以极大，在某些定义域上甚至趋于无穷——导致上界过松以至无意义。若为了让上界有意义而强制要求 $L_j \to 0$（即极强的全局收缩），则由§6 命题 2，系统的长链会将一切状态差异——包括不同输入之间的区分——彻底压平，$\Phi$ 退化为常数映射，近似拟合能力丧失。因此，引入 $h^*_{j-1}$ 将路径拆分为**近似误差传播项**（第一项，权重 $e_{j-1}$）和**采样域偏离项**（第二项，权重 $\delta_j$）是必要的：两项分别被 $L_j$ 缩放，但乘的是各自有控制意义的距离，而非无界的 $d(h_{j-1}, x'_j)$。

分别定界：

$$e_j \;\leq\; \underbrace{d\bigl(\Phi(h_{j-1}),\, \Phi(h^*_{j-1})\bigr)}_{\leq\, L_j \cdot e_{j-1}} \;+\; \underbrace{d\bigl(\Phi(h^*_{j-1}),\, \Phi(x'_j)\bigr)}_{\leq\, L_j \cdot \delta_j} \;+\; \underbrace{d\bigl(\Phi(x'_j),\, r_{i_j}(x'_j)\bigr)}_{\leq\, \varepsilon_{i_j}}$$

递推关系：$e_j \leq L_j e_{j-1} + L_j\delta_j + \varepsilon_{i_j}$，$e_0 = 0$。逐步展开前三步：

$$e_1 \leq \varepsilon_{i_1} + L_1\delta_1$$
$$e_2 \leq L_2 e_1 + (\varepsilon_{i_2} + L_2\delta_2) \leq (\varepsilon_{i_1} + L_1\delta_1)\cdot L_2 + (\varepsilon_{i_2} + L_2\delta_2)$$
$$e_3 \leq L_3 e_2 + (\varepsilon_{i_3} + L_3\delta_3) \leq (\varepsilon_{i_1} + L_1\delta_1)\cdot L_3L_2 + (\varepsilon_{i_2} + L_2\delta_2)\cdot L_3 + (\varepsilon_{i_3} + L_3\delta_3)$$

第 $j$ 步新增项 $(\varepsilon_{i_j} + L_j\delta_j)$ 在后续各步中被乘以 $\Theta_{j+1,l}$，归纳得：

$$e_l \;\leq\; \sum_{j=1}^{l}\Bigl(\varepsilon_{i_j} + L_j\delta_j\Bigr)\cdot \Theta_{j+1,l}$$

分离两项，利用 $L_j \cdot \Theta_{j+1,l} = \Theta_{j,l}$：

$$e_l \;\leq\; \sum_{j=1}^{l}\varepsilon_{i_j}\cdot \Theta_{j+1,l} \;+\; \sum_{j=1}^{l}\delta_j\cdot \Theta_{j,l}$$

> **保守简化**：精细界可退化为以下三种等价可用的简化形式：
>
> **形式 A（均匀化各步误差）**：令 $\varepsilon_{\max} \triangleq \max_j \varepsilon_{i_j}$，$\delta_{\max} \triangleq \max_j \delta_j$：
>
> $$e_l \;\leq\; \varepsilon_{\max}\cdot\Lambda_l \;+\; \delta_{\max}\cdot\Gamma_l$$
>
> **形式 B（均匀化路径放大系数）**：以全局 $L$ 替换局部 $L_j$（$\Theta_{j+1,l} \leq L^{l-j}$，$\Theta_{j,l} \leq L^{l-j+1}$），各步 $\varepsilon_{i_j}$、$\delta_j$ 保持异质：
>
> $$e_l \;\leq\; \sum_{j=1}^{l}\bigl(\varepsilon_{i_j} + L\delta_j\bigr)\cdot L^{l-j}$$
>
> 其中 $\varepsilon_{i_j} + L\delta_j$ 为第 $j$ 步的**有效单步误差**（近似误差与放大一次的偏离代价之和），被后续 $L^{l-j}$ 放大。
>
> **形式 C（两者均均匀化）**：在形式 A 基础上再利用 $\Gamma_l \leq L\Lambda_l \leq L\cdot\dfrac{L^l-1}{L-1}$：
>
> $$e_l \;\leq\; (\varepsilon_{\max} + L\delta_{\max})\cdot\frac{L^l-1}{L-1}$$
>
> （$L=1$ 时极限为 $(\varepsilon_{\max}+\delta_{\max})\cdot l$。）形式 C **先验可计算**（只需三个标量 $L$、$\varepsilon_{\max}$、$\delta_{\max}$），代价是最松。形式 A 与形式 B 的松紧依具体路径和误差分布而定，不作一般比较。**降低误差的三条路径**：压低 $\varepsilon_{\max}$，控制 $\delta_{\max}$，控制局部 Lipschitz（进而控制 $\Lambda_l$）。

$\square$


**推论 1（计算折叠等效，Computational Folding Equivalence）**：设在 $\mathcal{X}_{sub}$ 上存在第 $l$ 阶路由混叠，即存在 $x_1, x_2 \in \mathcal{X}_{sub}$ 使得 $\sigma(x_2) = \sigma_l(x_1)$。则单步系统 $\mathcal{F}$ 在 $x_2$ 处**执行与 $l$ 步宏观系统相同的计算程序**，而该程序的宏观容差由 CAC 定理的 $\mathcal{E}^*$ 控制。由引理 2，组合耗尽保证了路由混叠的必然存在。
> **注（路由混叠与计算时空重叠）**：这是路由混叠的反直觉结构后果。路由映射 $\sigma$ 将状态空间的不同位置（$x_2$ vs $x_1$）和不同演化深度（单步 vs $l$ 步）映射到**同一条微观计算链**，赋予了 $\Phi$ 一种**计算时空折叠**特征：单步映射在某些输入上的行为，与系统经 $l$ 步迭代后的行为，在计算程序层面完全重合。两者因共享同一条链而共享同一套 CAC 容差界。

**推论 2（宏观容差界 $\mathcal{E}^*$ 的三态行为，Three-Regime Behavior of the Macroscopic Tolerance Bound）**：宏观容差界 $\varepsilon^*_q$ 的两项共享 $\Theta_{j,l}$ 结构，但步骤 $j$ 的权重有差异：$\varepsilon$-项权重为 $\Theta_{j+1,l}$（不含本步 $L_j$），$\delta$-项权重为 $\Theta_{j,l} = L_j \cdot \Theta_{j+1,l}$（含本步 $L_j$）。因此**同一步 $j$ 的微观采样域偏离代价比拟合误差代价高 $L_j$ 倍**：$L_j > 1$（扩张步）时 $\delta$ 惩罚尤为严苛，$L_j < 1$（收缩步）时 $\delta$ 惩罚被折减。两项的主导步 $j^*$ 均不是微观误差绝对值最大者——准确的主导步是使放大后贡献（$\varepsilon_{i_j} \cdot \Theta_{j+1,l}$ 或 $\delta_j \cdot \Theta_{j,l}$）最大的步骤，早期步骤往往占优。

按 $\Theta_{j,l}$ 的渐近行为，从微观容差 $\mathcal{E}$ 跃迁至宏观容差 $\mathcal{E}^*$ 呈现三种数学情形：

**扩张（$\Theta_{1,l} \to \infty$）**：$\varepsilon$-项上界 $\sum_j \varepsilon_{i_j} \Theta_{j+1,l} \to \infty$，$\delta$-项上界 $\sum_j \delta_j \Theta_{j,l} \to \infty$（只要存在非零项）；权重不等式 $\Theta_{j,l} \geq \Theta_{j+1,l}$ 保证 $\delta$ 上界爆炸速度不慢于 $\varepsilon$ 上界。此时 **CAC 上界失效**，宏观容差 $\varepsilon^*_q$ 对实际系统误差不再提供有效约束。注意：理论上界趋于无穷**不能**直接推断系统具体轨道的误差 $e_l$ 也必然发散——具体系统的 $e_l$ 视其自身结构可能仍有界，只是组合泛化定理无法在此框架下给出保证。但援引推论 3（紧性）：存在使等号精确成立的 IDFS，即必定存在端到端实际崩溃的系统，这说明此处定理“上界失效”的程度是紧确的。

**稳定（$\sup_{j,l} \Theta_{j+1,l} \leq \kappa < \infty$）**：$\mathcal{E}^*$ 中的元素 $\varepsilon^*_q$ 存在可量化的有效上界。$\varepsilon$-项上限被 $\kappa \sum_j \varepsilon_{i_j}$ 控制，有界当且仅当 $\sum_j \varepsilon_{i_j} < \infty$，单步对宏观总误差的贡献上限被截断为 $\kappa \varepsilon_{i_j}$。$\delta$-项上限为 $(\sup_j L_j) \cdot \kappa \sum_j \delta_j$。

**饱和（$\Lambda_\infty = \sum_{j \geq 1} \Theta_{j+1,\infty} < C$）**：见推论 5。宏观容差界全局有限，不再随微观长链的堆叠而增长。$\varepsilon$-项上限为 $\sup_j(\varepsilon_{i_j}) \cdot \Lambda_\infty$；$\delta$-项上限为 $\sup_j(\delta_j) \cdot \Gamma_\infty$。无论生成的宏观有效链 $q \in \mathcal{T}_l$ 多深，其对应的容差 $\varepsilon^*_q \in \mathcal{E}^*$ 均被有限常数绝对控制。

---

**推论 3（宏观容差集的类紧性，Class-Level Tightness of the Macroscopic Tolerance Set）**：对任意给定的微观采样集 $\mathcal{S}$ 及其容差集 $\mathcal{E}$（由任意给定序列 $\varepsilon_{i_j} \geq 0$ 决定），以及任意给定的偏离序列 $\delta_j \geq 0$ 和 Lipschitz 序列 $\{L_j\}_{j=1}^l$，**一定存在**某个以 $\mathcal{E}$ 拟合了 $\mathcal{S}$ 的具体 IDFS $(F, \sigma)$，使得在由 $\mathcal{S}$ 生成的某段宏观链 $q \in \mathcal{T}_l$ 上，其端到端逼近误差精确填满了宏观容差上界 $\varepsilon^*_q \in \mathcal{E}^*$：

$$e_l \;=\; \varepsilon^*_q \;=\; \sum_{j=1}^{l} \varepsilon_{i_j} \cdot \Theta_{j+1,l} \;+\; \sum_{j=1}^{l} \delta_j \cdot \Theta_{j,l}$$

即：由微观容差集 $\mathcal{E}$ 跃迁生成宏观容差集 $\mathcal{E}^*$ 的映射定理边界，在整个 IDFS 函数类意义下是**不可改善的**（不存在更紧的普适代数界）。

**证明（存在性构造）**：取 $\mathcal{X} = \mathbb{R}$，配以绝对值度量 $d(x,y) = |x-y|$，设 $h_0 = h^*_0 = 0$。

**采样域的构造**：对第 $j$ 步，令 $r_{i_j}(y) \equiv 0$（零映射），采样域取单点 $\mathcal{X}(r_{i_j}) \triangleq \{-\delta_j\}$。理想轨道由此恒为零：$h^*_j = 0$。由定义：

$$d\!\bigl(h^*_{j-1},\, \mathcal{X}(r_{i_j})\bigr) = |0 - (-\delta_j)| = \delta_j$$

故偏离距离精确等于任意给定的 $\delta_j \geq 0$。

**近似算子的构造**：令 $\Phi$ 在第 $j$ 步的局部算子为：

$$\Phi_j(y) \;\triangleq\; L_j(y + \delta_j) + \varepsilon_{i_j}$$

则：$\mathrm{Lip}(\Phi_j) = L_j$（精确）；在采样点 $x'_j = -\delta_j$ 处：

$$d\bigl(\Phi_j(x'_j),\, r_{i_j}(x'_j)\bigr) = |L_j \cdot 0 + \varepsilon_{i_j} - 0| = \varepsilon_{i_j}$$

单步近似误差精确等于给定的 $\varepsilon_{i_j} \geq 0$。

**误差递推**：对第 $j$ 步套用主定理的三项拆分，取 $x'_j = -\delta_j$（采样域唯一点，$d(h^*_{j-1}, x'_j) = \delta_j$）：

$$e_j = d\bigl(\Phi_j(h_{j-1}),\, r_{i_j}(h^*_{j-1})\bigr) = \bigl|\Phi_j(h_{j-1}) - 0\bigr| = \Phi_j(h_{j-1})$$

其中第二个等号来自 $r_{i_j} \equiv 0$，第三个等号是因为 $\Phi_j(h_{j-1}) \geq 0$——这由以下各项的非负性保证：
- $h_0 = 0$，归纳假设 $h_{j-1} = e_{j-1} \geq 0$；
- $\Phi_j(y) = L_j(y + \delta_j) + \varepsilon_{i_j}$，其中 $L_j > 0$，$\delta_j \geq 0$，$\varepsilon_{i_j} \geq 0$；
- 归纳可知 $h_{j-1} + \delta_j \geq 0$（因 $h_{j-1} \geq 0$，$\delta_j \geq 0$），故 $\Phi_j(h_{j-1}) \geq 0$，即 $e_j = h_j \geq 0$。

由 $h^*_j = 0$，误差 $e_j = |h_j - 0| = h_j$，展开 $\Phi_j$ 得递推：

$$e_j = \Phi_j(h_{j-1}) = L_j(h_{j-1} + \delta_j) + \varepsilon_{i_j} = L_j e_{j-1} + L_j\delta_j + \varepsilon_{i_j}$$

对照三项拆分的各项界限，此处**三项均精确取等**（非不等式）：
- 第一项：$d(\Phi_j(h_{j-1}),\, \Phi_j(h^*_{j-1})) = L_j|h_{j-1} - 0| = L_j e_{j-1}$（$\Phi_j$ 的 Lipschitz 常数精确为 $L_j$）；
- 第二项：$d(\Phi_j(h^*_{j-1}),\, \Phi_j(x'_j)) = L_j|0 - (-\delta_j)| = L_j\delta_j$（同上）；
- 第三项：$d(\Phi_j(x'_j),\, r_{i_j}(x'_j)) = |L_j \cdot 0 + \varepsilon_{i_j} - 0| = \varepsilon_{i_j}$（精确）。

三项同号（均 $\geq 0$），无任何抵消，等号逐步成立。展开递推精确得：

$$e_l = \sum_{j=1}^{l} (\varepsilon_{i_j} + L_j\delta_j)\cdot \Theta_{j+1,l} = \sum_{j=1}^{l} \varepsilon_{i_j} \Theta_{j+1,l} + \sum_{j=1}^{l} \delta_j \Theta_{j,l}$$

与精细界完全吻合。$\square$

**推论 4（保底可靠链深，Guaranteed Safe Chain Depth）**：若要求系统在生成的宏观链上不发生泛化崩溃，即要求宏观容差集 $\mathcal{E}^*$ 中的元素被严格界定在安全阈值 $\tau > 0$ 内（$\varepsilon^*_q \leq \tau$），则相应的宏观有效链集 $\mathcal{T}_l$ 必须在逻辑深度上实施截断（即限制最大推导步数 $l$）。

设 $\bar{L} \triangleq \max_j L_j$ 为路径局部 Lipschitz 最大值。利用 $\Gamma_l \leq \bar{L}\,\Lambda_l$，确保 $\varepsilon^*_q \leq \tau$ 的充分条件合并为：

$$(\varepsilon_{\max} + \bar{L}\,\delta_{\max})\cdot\Lambda_l \;\leq\; \tau$$

再利用 $\Lambda_l \leq \dfrac{\bar{L}^l - 1}{\bar{L} - 1}$，对 $\bar{L} > 1$ 显式求解，给出**保底可靠链深**：

$$l^* \;=\; \left\lfloor \frac{\log\!\left(1 + \dfrac{\tau(\bar{L}-1)}{\varepsilon_{\max} + \bar{L}\,\delta_{\max}}\right)}{\log \bar{L}} \right\rfloor$$

即：任意长度 $\leq l^*$ 的链均保证 $e_l \leq \tau$。

$\bar{L} = 1$ 时退化为线性：$l^* = \lfloor \tau/(\varepsilon_{\max}+\delta_{\max}) \rfloor$。

**证明**：

**第一步（合并两项）**：由 $\bar{L} = \max_j L_j$，对每项有 $L_j \Theta_{j+1,l} \leq \bar{L}\,\Theta_{j+1,l}$，故：

$$\Gamma_l = \sum_{j=1}^l L_j \Theta_{j+1,l} \;\leq\; \bar{L} \sum_{j=1}^l \Theta_{j+1,l} = \bar{L}\,\Lambda_l$$

代入充分条件：

$$\varepsilon_{\max}\,\Lambda_l + \delta_{\max}\,\Gamma_l \;\leq\; \varepsilon_{\max}\,\Lambda_l + \delta_{\max}\cdot\bar{L}\,\Lambda_l = (\varepsilon_{\max} + \bar{L}\,\delta_{\max})\,\Lambda_l \;\leq\; \tau$$

**第二步（约束 $\Lambda_l$）**：上式等价于：

$$\Lambda_l \;\leq\; \frac{\tau}{\varepsilon_{\max} + \bar{L}\,\delta_{\max}}$$

**第三步（对 $l$ 求解显式下界）**：由 $\Theta_{j+1,l} \leq \bar{L}^{l-j}$，故：

$$\Lambda_l = \sum_{j=1}^l \Theta_{j+1,l} \;\leq\; \sum_{j=1}^l \bar{L}^{l-j} = \frac{\bar{L}^l - 1}{\bar{L} - 1} \qquad (\bar{L} > 1)$$

要使 $(\bar{L}^l-1)/(\bar{L}-1) \leq \tau/(\varepsilon_{\max}+\bar{L}\delta_{\max})$，即 $\bar{L}^l \leq 1 + \tau(\bar{L}-1)/(\varepsilon_{\max}+\bar{L}\delta_{\max})$，取对数解 $l$ 的最大整数：

$$l^* = \left\lfloor \frac{\log\!\left(1 + \dfrac{\tau(\bar{L}-1)}{\varepsilon_{\max} + \bar{L}\,\delta_{\max}}\right)}{\log \bar{L}} \right\rfloor$$

由构造，任意长度 $\leq l^*$ 的链均满足 $(\varepsilon_{\max}+\bar{L}\delta_{\max})\Lambda_l \leq \tau$，进而由 CAC 定理保证 $e_l \leq \tau$。$\square$

> **注**：$l^*$ 仅依赖三个标量 $\varepsilon_{\max}$、$\delta_{\max}$、$\bar{L}$，先验可计算。分母 $\varepsilon_{\max} + \bar{L}\,\delta_{\max}$ 即**有效单步误差**（近似误差与放大一次的采样域偏离代价之和，呼应 CAC 主定理形式B）。$\bar{L}$ 取路径局部最大而非全局 $L$，结合保守的 $\Lambda_l$ 上界，$l^*$ 通常是悲观估计——若路径中大多数步的 $L_j \ll \bar{L}$，实际可安全走的深度往往远大于 $l^*$。






**推论 5（宏观容差集的收缩有界性，Boundedness of $\mathcal{E}^*$ under Contraction）**：记 $\Theta_{j,\infty} \triangleq \lim_{l\to\infty} \Theta_{j,l} = \prod_{k=j}^{\infty} L_k$（当极限存在时）。若局部收缩足够强导致累积系数收敛：

$$\Lambda_\infty \;\triangleq\; \sum_{j=1}^{\infty} \Theta_{j+1,\infty} \;<\; \infty \qquad \text{且} \qquad \Gamma_\infty \;\triangleq\; \sum_{j=1}^{\infty} \Theta_{j,\infty} \;<\; \infty$$

则不论微观集 $\mathcal{S}$ 生成的有效链集 $\mathcal{T}_\infty$ 有多庞大（甚至包含无限长链极限），其诱导的整个**宏观容差集 $\mathcal{E}^*$ 必然是一致有界的**（Uniformly Bounded）：对任意长链 $q \in \mathcal{T}_\infty$，

$$\varepsilon^*_q \;\leq\; \varepsilon_{\max} \cdot \Lambda_\infty \;+\; \delta_{\max} \cdot \Gamma_\infty \;<\; \infty$$

即：在强收缩下，由有限微观容差（$\mathcal{E}$）爆发出的无限组合宏观误差（$\mathcal{E}^*$）被强制封顶。系统展现出对任意长逻辑组合的“无限泛化免疫力”。

**证明**：由 CAC 定理精细界（形式 A）：

$$e_l \;\leq\; \varepsilon_{\max}\cdot\Lambda_l \;+\; \delta_{\max}\cdot\Gamma_l$$

由 $\Lambda_l \nearrow \Lambda_\infty$ 和 $\Gamma_l \nearrow \Gamma_\infty$（两个级数均单调递增趋向各自极限），故 $e_l \leq \varepsilon_{\max}\cdot\Lambda_\infty + \delta_{\max}\cdot\Gamma_\infty$。$\square$

> **注（允许局部扩张；$\Gamma_\infty$ 与 $\Lambda_\infty$ 同阶）**：推论 5 不要求 $L_j < 1$ 逐步成立——即使某些步存在 $L_j > 1$（局部扩张），只要后续有足够强的收缩步将尾部乘积压平，$\Lambda_\infty$ 仍然有限。此外，由 $\Gamma_\infty = \sum_j L_j \Theta_{j+1,\infty} \leq (\sup_j L_j)\cdot\Lambda_\infty$，若路径局部 Lipschitz 有界（$\sup_j L_j < \infty$），则 $\Lambda_\infty < \infty$ 自动蒴含 $\Gamma_\infty < \infty$，条件可合并为单一的 $\Lambda_\infty < \infty$（加局部 Lipschitz 有界）。

**保守特例（全局 $L < 1$）**：若 $\Phi \in \mathrm{Lip}_L$ 且 $L < 1$，则 $L_j \leq L$，故：

$$\Lambda_\infty \leq \frac{1}{1-L}, \qquad \Gamma_\infty \leq \frac{L}{1-L}$$

退化为保守界：

$$e_l \;\leq\; \frac{\varepsilon_{\max} + L\,\delta_{\max}}{1-L}$$

分子即**有效单步误差**（呼应形式B），分母为收缩余量 $(1-L)$，对应上表「饱和」行的均匀情形。

---

**推论 6（生成基约简与零样本泛化，Generative Basis Reduction and Zero-Shot Generalization）**：取原目标真实法则全集 $R$ 的一个**生成基** $R_0 \subseteq R$，及其对应的微观采样集 $\mathcal{S}_0 \subset \mathcal{S}$。若系统 $\Phi$ 以均匀微观容差集 $\mathcal{E}_0 = \{\varepsilon_0\}$ 局部拟合了该生成基 $\mathcal{S}_0$。

对于任意我们没有显式训练并测试的“未见规则” $r_i \in R \setminus R_0$，只要它能够沿 $R_0$ 逻辑展开为一条分解路径 $r_i = r_{i_{d_i}} \circ \cdots \circ r_{i_1}$，那么由同构物理意义可知：未见规则 $r_i$ 在数学上彻底等价于由微观基集 $\mathcal{S}_0$ 诱导生成的宏观链集 $\mathcal{T}_{d_i}$ 中的某个**宏观链元素** $q_i$。

因此，根据 CAC 定理，系统必定能以由 $\mathcal{E}_0$ 跃迁出的**宏观容差** $\varepsilon^*_{q_i} \in \mathcal{E}^*_0$ 覆盖拟合这个未曾见过的复杂规则 $r_i$。即 $r_i$ 的泛化误差边界被严格锚定为：

$$\sup_{x \in \mathcal{X}(r_{i_1})} d\bigl(\Phi^{d_i}(x),\, r_i(x)\bigr) \;\leq\; \varepsilon^*_{q_i} \;=\; \varepsilon_0 \cdot \Lambda_{d_i}^{\mathrm{path}} \;+\; \delta_{\max}^{\mathrm{path}} \cdot \Gamma_{d_i}^{\mathrm{path}}$$

取所有 $r_i \in R \setminus R_0$ 的上确界：

$$\varepsilon_{\max}^R \;\leq\; \max_{r_i \in R \setminus R_0} \Bigl(\varepsilon_0 \cdot \Lambda_{d_i}^{\mathrm{path}} + \delta_{\max}^{\mathrm{path}} \cdot \Gamma_{d_i}^{\mathrm{path}}\Bigr)$$

**证明**：情形 1（$r \in R_0$）直接由假设满足。情形 2（$r_i \in R \setminus R_0$）见下方证明详展。$\square$

**证明详展（情形 2）**：设分解路径 $r_i = r_{i_{d_i}} \circ \cdots \circ r_{i_1}$，对任意 $x \in \mathcal{X}(r_{i_1})$：

- **$r$-链轨道**：$h_0^* = x$，$h_j^* = r_{i_j}(h_{j-1}^*)$，$h_{d_i}^* = r_i(x)$
- **$\Phi$-轨道**：$\hat{h}_0 = x$，$\hat{h}_j = \Phi(\hat{h}_{j-1})$

$e_j = d(\hat{h}_j,\, h_j^*)$，$e_0 = 0$。对第 $j$ 步，取 $x'_j \in \mathcal{X}(r_{i_j})$ 为距 $h^*_{j-1}$ 最近的采样域点（$d(h^*_{j-1}, x'_j) = \delta_j^{\mathrm{path}}$），套用 CAC 主定理的三项拆分：

$$e_j \;\leq\; \underbrace{d\bigl(\Phi(\hat{h}_{j-1}),\, \Phi(h^*_{j-1})\bigr)}_{\leq\, L_j e_{j-1}} + \underbrace{d\bigl(\Phi(h^*_{j-1}),\, \Phi(x'_j)\bigr)}_{\leq\, L_j \delta_j^{\mathrm{path}}} + \underbrace{d\bigl(\Phi(x'_j),\, r_{i_j}(x'_j)\bigr)}_{\leq\, \varepsilon_0}$$

递推展开得 $e_{d_i} \leq \varepsilon_0 \cdot \Lambda_{d_i}^{\mathrm{path}} + \delta_{\max}^{\mathrm{path}} \cdot \Gamma_{d_i}^{\mathrm{path}}$。对 $x$ 取上确界即得。$\square$

**含义（剖面策略）**：分解路径同时影响两个正交方向：$\Lambda_{d_i}^{\mathrm{path}}$ 由路径 Lipschitz 结构决定（近似误差放大），$\delta_{\max,i}^{\mathrm{path}} \cdot \Gamma_{d_i}^{\mathrm{path}}$ 由路径的域覆盖质量决定（采样域偏离代价）。两者之间通常存在取舍：路径越长，中间态被更细粒度的规则覆盖，$\delta$ 可能越小，但 $\Lambda$ 和 $\Gamma$ 往往同步增大。选择分解时须在两个方向上联合优化。

**定义（组合覆盖代价，Compositional Coverage Cost）**：给定生成基 $R_0$，定义 $R$ 在 $R_0$ 下的 **（一般）组合覆盖代价**为：

$$\mathcal{C}^{\mathrm{gen}}(R, R_0) \;\triangleq\; |R_0| \;\times\; \max_{r_i \in R \setminus R_0} \Bigl(\varepsilon_0 \cdot \Lambda_{d_i}^{\mathrm{path}} \;+\; \delta_{\max,i}^{\mathrm{path}} \cdot \Gamma_{d_i}^{\mathrm{path}}\Bigr)$$

其中两个因子各有明确含义：

- $|R_0|$：**直接拟合宽度**，即 $\Phi$ 须直接近似的基规则数量，决定采样对构造的规模代价；
- $\max_{r_i}(\cdots)$：**最坏派生误差**，即在所有非基规则中，通过分解路径传播后误差最大的那条——同时含近似误差放大项（$\varepsilon_0 \cdot \Lambda$）和采样域偏离代价项（$\delta_{\max,i} \cdot \Gamma$）。

两者的乘积刻画了一种**覆盖效率的权衡**：$|R_0|$ 越大，直接近似的规则越多，采样对构造代价越高，但每条分解路径可以更短（$d_i$ 更小），从而 $\Lambda$、$\Gamma$ 更小、$\delta$ 更容易控制；$|R_0|$ 越小则反之，派生路径更长，误差传播放大与中间态偏离均趋于增大。$\mathcal{C}^{\mathrm{gen}}$ 的最小化即在这两者间寻找最优的生成基大小与路径质量的平衡点。

> **理论基准（域链相容，$\delta = 0$）**：若所有分解路径满足**域链相容**（每步 $h^*_{j-1} \in \mathcal{X}(r_{i_j})$），则 $\delta_{\max,i}^{\mathrm{path}} = 0$，$\Gamma$ 项消失，代价退化为：
>
> $$\mathcal{C}(R, R_0) \;\triangleq\; |R_0| \;\times\; \max_{r_i \in R \setminus R_0} \Lambda_{d_i}^{\mathrm{path}}$$
>
> 此时 $\varepsilon_0$ 可提出，代价仅由误差放大系数 $\Lambda$ 决定，先验可计算。域链相容在现实中极难精确满足——训练采样域通常不覆盖链式组合的所有中间态——但作为**理论下界**（$\delta$ 可压缩至零时的最优情形），提供一个可量化的乐观基准。在域链相容下进一步取 $\Phi \in \mathrm{Lip}_L$，记 $d_{\max} = \max_i d_i$，保守界退化为：
>
> $$\varepsilon_{\max}^R \;\leq\; \varepsilon_0 \cdot \frac{L^{d_{\max}} - 1}{L - 1}$$

**推论 6a（精度理论下界，Theoretical Precision Floor）**：设 $\Phi$ 对所有 $r_0 \in R_0$ 实现局部精度 $\varepsilon_0$，且分解路径满足域链相容（$\delta=0$，即理论基准条件）。则任意生成基 $R_0$ 对应的覆盖精度不优于：

$$\varepsilon^* \;=\; \varepsilon_0 \cdot \min_{R_0 \;\text{生成}\; R}\; \max_{r_i \in R \setminus R_0} \Lambda_{d_i}^{\mathrm{path}}(R_0)$$

即 $\varepsilon^*$ 是在域链相容理想化条件下，遍历所有生成基选择后的**最优精度下界**。在现实场景（$\delta > 0$）中，实际覆盖精度总满足 $\varepsilon_{\mathrm{actual}} \geq \varepsilon^*$，$\varepsilon^*$ 一般不可达，仅作为理论参照。

**证明**：直接由推论 6 的域链相容特例，对所有可行的 $R_0$ 取最优（最小化误差放大因子）即得。$\square$

---

## 4. 逼近误差的结构性下界（Structural Lower Bounds of Approximation）

> **注**：本节从下界视角约束逼近误差。主定理（CAB）建立端到端复合系统的逼近误差绝对下界；推论 2 是 CAB 在 $l = 1$（单步）且两点同属采样域时的特化，为 CAC 中逐步近似误差 $\varepsilon_{i_j}$ 提供结构性下界。

**定理（组合近似瓶颈定理，Compositional Approximation Bottleneck，CAB）**：
设系统以容差集 $\mathcal{E}$ 拟合了微观采样集 $\mathcal{S}$。对任意长度为 $l$ 的宏观有效链 $q \in \mathcal{T}_l$，设其对应的端到端物理系统映射为 $l$ 次迭代的复合 $\Phi_q = \Phi \circ \dots \circ \Phi$。

设某输入对 $x, y \in \mathrm{dom}(q)$ 满足以下空间相态（$x, y \in \mathrm{dom}(q)$ 保证理想链 $q$ 在两点处可执行，即 $q(x), q(y) \neq \bot$；近似轨道 $\Phi_q(x), \Phi_q(y)$ 由 IDFS 闭合性保证为 $\mathcal{X}$ 中的良定义元素）：
1. **输入分离与目标跃迁**：起点的初始距离为 $d(x, y) = \delta > 0$，但在理想长链 $q$ 下的映射距离跃迁为 $d(q(x), q(y)) = \Delta > 0$。
2. **拟合参数**：系统在参考点 $x$ 处的端到端逼近误差（拟合残差）记为 $\varepsilon_x \triangleq d(\Phi_q(x), q(x)) \geq 0$。
3. **系统扩张极限**：系统宏观映射下的最大拉伸距离受到 $l$-链累积扩张律的限制，即 $d(\Phi_q(x), \Phi_q(y)) \leq \Theta_{1,l} \cdot \delta$（其中 $\Theta_{1,l}$ 为宏观全链 $l$ 步的路径局部 Lipschitz 乘积上界；若不知具体路径，可保守地取先验可计算的全局界 $L^l$）。

定义**末端结构瓶颈（Intrinsic Structural Bottleneck）**为：
$$\varepsilon_{y,\text{out}} = \min_{f \in F}\; \inf_{h \in \mathcal{X}} d(f(h),\, q(y))$$
即遍历所有可能的末端算子 $f \in F$ 和所有可能的中间态 $h$，系统能够达到的与目标像点 $q(y)$ 的最小距离。无论 $\sigma$ 在最后一步如何选择算子，该下界均成立。

**定理结论**：系统在点 $y$ 处的端到端宏观泛化误差 $\varepsilon^*_y \triangleq d(\Phi_q(y), q(y))$（作为容差集 $\mathcal{E}^*$ 的具体表现），存在不可压缩的绝对数学下界：
$$\varepsilon^*_y \;\geq\; \max \Big( |\Delta - \varepsilon_x| - \Theta_{1,l} \cdot \delta, \;\; \varepsilon_{y,\text{out}} \Big)$$

**证明**：
先推导**拓扑死锁（Topological Deadlock）**：
考察系统在点 $y$ 处的逼近误差：$\varepsilon^*_y = d(\Phi_q(y), q(y))$。
步骤 1（正向三角不等式）：以目标变分 $\Delta$ 为基准展开四边形度量链：
$$d(q(x), q(y)) \;\leq\; d(q(x), \Phi_q(x)) \;+\; d(\Phi_q(x), \Phi_q(y)) \;+\; d(\Phi_q(y), q(y))$$
代入已知条件与参量：
$$\Delta \;\leq\; \varepsilon_x \;+\; \Theta_{1,l} \cdot \delta \;+\; \varepsilon^*_y$$
移项得出 $\varepsilon^*_y$ 的第一重下界 (I)：
$$\varepsilon^*_y \;\geq\; \Delta - \varepsilon_x - \Theta_{1,l} \cdot \delta$$
步骤 2（反向三角不等式）：以参考点残差 $\varepsilon_x$ 为基准逆向展开：
$$d(q(x), \Phi_q(x)) \;\leq\; d(q(x), q(y)) \;+\; d(q(y), \Phi_q(y)) \;+\; d(\Phi_q(y), \Phi_q(x))$$
代入已知条件与参量：
$$\varepsilon_x \;\leq\; \Delta \;+\; \varepsilon^*_y \;+\; \Theta_{1,l} \cdot \delta$$
移项得出 $\varepsilon^*_y$ 的第二重下界 (II)：
$$\varepsilon^*_y \;\geq\; \varepsilon_x - \Delta - \Theta_{1,l} \cdot \delta$$
由于 $\varepsilon^*_y$ 必须同时满足 (I) 与 (II)，得出绝对值下界：
$$\varepsilon^*_y \;\geq\; |\Delta - \varepsilon_x| - \Theta_{1,l} \cdot \delta$$

再推导**末端拓扑结构瓶颈（Terminal Topological Bottleneck）**：
设系统在最后一步对 $y$ 实际选择的末端算子为 $f^{(y)} \in F$（由 $\sigma$ 在近似轨道的最后一步决定，不需先验知道）。设前置映射产生中间态 $h_y$，则：
$$\varepsilon^*_y = d(f^{(y)}(h_y),\, q(y)) \;\geq\; \inf_{h \in \mathcal{X}} d(f^{(y)}(h),\, q(y)) \;\geq\; \min_{f \in F}\; \inf_{h \in \mathcal{X}} d(f(h),\, q(y)) \;=\; \varepsilon_{y,\text{out}}$$

综上所述，逼近误差 $\varepsilon^*_y$ 必须同时满足上述两大独立限制：
$$\varepsilon^*_y \;\geq\; \max \Big( |\Delta - \varepsilon_x| - \Theta_{1,l} \cdot \delta, \;\; \varepsilon_{y,\text{out}} \Big)$$
$\square$

> **注（拟合跗跗板效应，The Fitting Seesaw Effect）**：项 $|\Delta - \varepsilon_x| - \Theta_{1,l} \cdot \delta$ 揭示了一个非对称的“跗跗板效应”。当系统的全局扩张率受限（$\Theta_{1,l}$ 较小）而目标链 $q$ 在 $(x, y)$ 间呈现剧烈变分（$\Delta$ 极大）时：若在参考点 $x$ 处达到完美拟合（$\varepsilon_x \to 0$），则 $y$ 处的宏观容差被刚性托底至 $\varepsilon^*_y \geq \Delta - \Theta_{1,l}\delta$。即系统**不可能同时在相邻两点上实现任意低误差**——局部的极高精度必然引爆邻近的泛化误差。

> **注（末端结构瓶颈 $\varepsilon_{y,\text{out}}$ 的含义）**：项 $\varepsilon_{y,\text{out}}$ 剖离出了 IDFS 末端算子层的结构刚性。无论前置映射 $\Phi'_q$ 将中间态流形扭曲得多么复杂，IDFS 的端到端最终输出必须经过某个底层算子 $f \in F$ 映射回输出空间。若目标像点 $q(y)$ 不在任何 $f \in F$ 的可达集 $\bigcup_{f \in F} f(\mathcal{X})$ 中，则 $\varepsilon_{y,\text{out}} > 0$ 成为不可消除的常数瓶颈：此时前置计算中的一切精妙运算皆无用武之地，端到端误差被末端算子的结构底盖死死卡定。

**推论 1（CAB 界的类紧性，Class-Level Tightness of the CAB Bound）**：对任意给定的标量 $\varepsilon_x \geq 0$、$\Delta > 0$、$\delta > 0$、$L > 0$ 和正整数 $l$，只要 $\Delta > \varepsilon_x + L^l\delta$（即拓扑死锁界为正），**一定存在**具体 IDFS $(F, \sigma)$ 使得 CAB 拓扑死锁界精确取等：

$$\varepsilon^*_y \;=\; \Delta \;-\; \varepsilon_x \;-\; \Theta_{1,l} \cdot \delta$$

即：CAB 的拓扑死锁下界在 IDFS 函数类意义下是**不可改善的**。

**证明（存在性构造）**：取 $\mathcal{X} = \mathbb{R}$，$d(x,y) = |x-y|$，设 $x = 0$，$y = \delta$。

**目标链的构造**：令 $q(z) = \alpha z$（$\alpha = \Delta/\delta$），则 $q(0) = 0$，$q(\delta) = \Delta$，目标变分精确等于 $\Delta$。

**系统的构造**：令 $\Phi(z) = Lz + a$（线性映射，$\mathrm{Lip}(\Phi) = L$ 精确），其中 $a = \varepsilon_x \cdot \frac{L-1}{L^l - 1}$（$L \neq 1$ 时；$L = 1$ 时取 $a = \varepsilon_x / l$）。则 $l$ 步复合：

$$\Phi^l(z) \;=\; L^l z \;+\; a \cdot \frac{L^l - 1}{L - 1} \;=\; L^l z \;+\; \varepsilon_x$$

**验证各量**：
- 路径乘积：$\Theta_{1,l} = L^l$（每步 $L_j = L$，精确）。
- 参考点残差：$\varepsilon_x = d(\Phi^l(0), q(0)) = |\varepsilon_x - 0| = \varepsilon_x$（精确）。
- 系统输出距离：$d(\Phi^l(0), \Phi^l(\delta)) = L^l\delta = \Theta_{1,l}\delta$（**线性映射精确取等 Lipschitz 界**）。
- 目标点误差：$\varepsilon^*_y = d(\Phi^l(\delta), q(\delta)) = |L^l\delta + \varepsilon_x - \Delta|$。由假设 $\Delta > \varepsilon_x + L^l\delta$，故 $\varepsilon^*_y = \Delta - \varepsilon_x - L^l\delta$。

**等号成立的机制**：在 $\mathbb{R}$ 上，四点 $q(x) = 0$, $\Phi^l(x) = \varepsilon_x$, $\Phi^l(y) = \varepsilon_x + L^l\delta$, $q(y) = \Delta$ 沿实数轴**同向有序排列**，三角不等式精确退化为等式——中间两点完全"夹在"两个目标点之间，无任何几何抵消。$\square$

> **注（末端瓶颈界的紧性）**：$\varepsilon_{y,\text{out}} = \inf_h d(f_\text{out}(h), q(y))$ 的取等同样可构造实现：令前置映射 $\Phi'_q$ 恰好将 $y$ 映射到最优中间态 $h^* = \arg\min_h d(f_\text{out}(h), q(y))$，则 $\varepsilon^*_y = d(f_\text{out}(h^*), q(y)) = \varepsilon_{y,\text{out}}$。因此 CAB 界的两项均可独立取等，整个 $\max$ 在函数类意义下紧确。

**定义（映射的局部变分下界，Local Variation Lower Bound）**：设 $(\mathcal{X}, d)$ 为度量空间。称映射 $r \in \Omega$ 在子集 $\mathcal{X}_r \subseteq \mathcal{X}$ 上具有 **$(\rho, \Delta)$-变分**，若存在 $x, y \in \mathcal{X}_r$ 使得：

$$d(x, y) \;\leq\; \rho \quad \text{且} \quad d\bigl(r(x), r(y)\bigr) \;\geq\; \Delta$$

即 $r$ 在 $\rho$-邻域内存在幅度不小于 $\Delta$ 的剧烈跳变。（注：此处 $\rho$ 为变分尺度，与 CAC 定理中的采样域偏离 $\delta_j$ 含义不同。）

**推论 2（近似误差的变分下界，Variation Bound on Approximation Error）**：设 $\Phi \in \mathrm{Lip}_L(\mathcal{X})$。设 $(r, \mathcal{X}_r) \in \mathcal{S}$，$r$ 在 $\mathcal{X}_r$ 上具有 $(\rho, \Delta)$-变分，记 $\varepsilon_r = \sup_{z \in \mathcal{X}_r} d(\Phi(z), r(z))$。则必然成立：

$$2\varepsilon_r \;+\; L \cdot \rho \;\geq\; \Delta$$

**证明（由 CAB 特化）**：取满足 $(\rho, \Delta)$-变分条件的点对 $x, y \in \mathcal{X}_r$。将 CAB 拓扑死锁界特化至 $l = 1$（单步，$\Theta_{1,1} = L$），以 $q = r$、$\delta = d(x,y) \leq \rho$、$\Delta_{q} = d(r(x), r(y)) \geq \Delta$：

$$\varepsilon^*_y \;\geq\; \Delta_q - \varepsilon_x - L\delta \;\geq\; \Delta - \varepsilon_x - L\rho$$

由 $x, y \in \mathcal{X}_r$，两点的误差均受同一 sup 约束：$\varepsilon_x \leq \varepsilon_r$，$\varepsilon^*_y \leq \varepsilon_r$。代入上式：$\varepsilon_r \geq \Delta - \varepsilon_r - L\rho$，即 $2\varepsilon_r + L\rho \geq \Delta$。$\square$

> **注（三方互斥律）**：式 $2\varepsilon_r + L\rho \geq \Delta$ 刻画了三个量的内在紧张：局部变分幅度 $\Delta/\rho$、全局光滑度 $L$、单步近似误差 $\varepsilon_r$ 三者不能同时任意小。若要近似具有高局部变分（$\Delta/\rho \gg L$）的 $r$，则**近似误差必然不小于** $\varepsilon_r \geq (\Delta - L\rho)/2$。

> **注（与 CAC 的联系）**：推论 2 中的 $\varepsilon_r$ 即 CAC 主定理中第 $j$ 步的单步近似误差 $\varepsilon_{i_j} = \sup_{x \in \mathcal{X}(r_{i_j})} d(\Phi(x), r_{i_j}(x))$（§1.3）。推论 2 给出 $\varepsilon_{i_j}$ 的**结构性下界**：只要 $r_{i_j}$ 在采样域内具有 $(\rho, \Delta)$-变分，就有 $\varepsilon_{i_j} \geq (\Delta - L\rho)/2$。将此下界代入 CAC 精细界，第 $j$ 步的近似误差贡献至少为 $\frac{\Delta - L\rho}{2} \cdot \Theta_{j+1,l}$——这是 $r_{i_j}$ 的局部变分结构对链式误差传播的**不可规避的底部贡献**。

> **注（扩展到 $\mathrm{dom}(r)$ 时的三元纠缠）**：推论 2 的分析严格限于采样域 $\mathcal{X}(r)$，其中 $\sigma$ 隐含于 $\Phi$ 的构造而不显式出现，两元张力 $(\varepsilon_r, L)$ 足以刻画。若将分析扩展至整个 $\mathrm{dom}(r) \supseteq \mathcal{X}(r)$，则在 $\mathrm{dom}(r) \setminus \mathcal{X}(r)$ 的区域内，$\Phi(z) = \sigma(z)(z)$ 不受采样约束，$\sigma$ 的决策边界可能在 $\partial\mathcal{X}(r)$ 处被激活：由§6 命题 4，跨越边界时路径局部 Lipschitz $L_j \to \infty$，全局常数 $L$ 不再能刻画 $\Phi$ 在 $\mathcal{X}(r)$ 外的光滑度。此时变分约束涉及**三元纠缠** $(\varepsilon_r,\, L,\, \sigma)$——三者无法分别独立优化，对 $\mathrm{dom}(r)$ 的分析须同时约束 $\sigma$ 在 $\partial\mathcal{X}(r)$ 处的边界曲率。因此推论 2 的主体保持在 $\mathcal{X}(r)$ 上以确保形式严格性；三元纠缠的正式处理见§6 命题 4。

**命题 1（逼近可行性条件，Approximation Feasibility Condition）**：由 CAC 定理（§3，上界）与 CAB 定理（下界）联合推得。设 IDFS $(F, \sigma)$ 以微观容差 $\varepsilon_{max}$ 和微观偏离 $\delta_{max}$ 拟合了采样集 $\mathcal{S}$。对任意有效链 $q \in \mathcal{T}_l$ 和任意 $x, y \in \mathrm{dom}(q)$（$d(x,y) = \delta$），记目标变分 $\Delta = d(q(x), q(y))$。

定义**逼近阈值（Approximation Threshold）**：

$$\mathcal{A}_l(\delta) \;\triangleq\; \underbrace{\Theta_{1,l} \cdot \delta}_{\text{拉伸预算}} \;+\; \underbrace{\varepsilon_{max} \cdot \Lambda_l}_{\text{拟合预算}} \;+\; \underbrace{\delta_{max} \cdot \Gamma_l}_{\text{偏离预算}}$$

则系统在点 $y$ 处的宏观逼近误差满足：

$$\varepsilon^*_y \;\geq\; \Delta \;-\; \mathcal{A}_l(\delta)$$

**含义**：若目标变分 $\Delta > \mathcal{A}_l(\delta)$，则即使系统对参考点 $x$ 的拟合达到 CAC 所允许的最优水平，$y$ 处的误差仍存在不可压缩的正下界 $\varepsilon^*_y \geq \Delta - \mathcal{A}_l(\delta) > 0$，对任何 IDFS 的设计方式均成立。

**证明**：由 CAB 拓扑死锁界：$\varepsilon^*_y \geq \Delta - \varepsilon_x - \Theta_{1,l}\delta$。由 CAC 定理（形式 A 均匀化）：$\varepsilon_x \leq \varepsilon_{max}\Lambda_l + \delta_{max}\Gamma_l$。代入消去 $\varepsilon_x$ 即得。$\square$

> **注（三项预算的正交含义）**：逼近阈值 $\mathcal{A}_l(\delta)$ 分解为三个彼此独立、可分别归因的预算项，分别界定了系统在三个正交方向上的逼近资源：
> - **拉伸预算** $\Theta_{1,l}\delta$：系统的动力学扩张能力——由 Lipschitz 尾部乘积 $\Theta_{1,l}$ 和输入距离 $\delta$ 共同决定，衡量系统能从给定的输入间距中"放大"出多少输出间距；
> - **拟合预算** $\varepsilon_{max}\Lambda_l$：微观近似误差的累积放大——每步的最坏拟合误差 $\varepsilon_{max}$ 经尾部扩张系数 $\Lambda_l$ 累积传播后的总容差空间；
> - **偏离预算** $\delta_{max}\Gamma_l$：采样域偏离的累积放大代价——理想轨道偏离采样域引入的额外误差，经 $\Gamma_l$ 累积传播。
>
> 三项之和即为系统所能承受的**目标变分天花板**：低于此天花板，系统有足够的资源逼近目标变分；高于此天花板，逼近必然失败。

> **注（饱和体制下的变分封顶）**：在§3 推论 5 的饱和条件下（$\Lambda_\infty < \infty$，$\Gamma_\infty < \infty$，$\Theta_{1,\infty} \to 0$），逼近阈值收敛至与输入距离 $\delta$ 无关的常数：$\mathcal{A}_\infty = \varepsilon_{max}\Lambda_\infty + \delta_{max}\Gamma_\infty$。此时目标变分天花板为有限常数——无论两个输入相距多远，系统所能逼近的目标变分不超过 $\mathcal{A}_\infty$。这从下界方向印证了推论 5 的上界结论：在强收缩下，系统对任意长逻辑组合具有"无限泛化免疫力"，但代价是丧失了逼近高变分目标的能力。

**命题 2（不可完美拟合集的正测度性，Positive Measure of Imperfect Fitting Sets）**：设 $(\mathcal{X}, d, \mu)$ 为度量概率空间，$\mu$ 完全支撑。设 $\Phi \in \mathrm{Lip}_L(\mathcal{X})$，$(r, \mathcal{X}_r) \in \mathcal{S}$，$\mathcal{X}_r$ 紧致且 $\mathrm{int}(\mathcal{X}_r) \neq \emptyset$。若 $r$ 具有 $(\rho, \Delta)$-变分且 $\Delta > L\rho$，则对任意 $\tau < (\Delta - L\rho)/2$：

$$\mu\bigl(U_\tau(r)\bigr) \;>\; 0$$

即误差超过 $\tau$ 的输入集合具有严格正测度。

**证明**（由推论 2 + 误差函数连续性）：先证 $r$ 在 $\mathcal{X}_r$ 上连续的情形（一般情形见后注）：

1. 由推论 2，$\varepsilon_r = \sup_{z \in \mathcal{X}_r} d(\Phi(z), r(z)) \geq (\Delta - L\rho)/2 > \tau$。
2. 定义误差函数 $g(x) = d(\Phi(x), r(x))$。由 $\Phi$ Lipschitz 与 $r$ 连续，$g$ 在 $\mathcal{X}_r$ 上连续。
3. 由 $\mathcal{X}_r$ 紧致与 $g$ 连续，sup 可达：存在 $x_0 \in \mathcal{X}_r$ 使得 $g(x_0) = \varepsilon_r > \tau$。
4. 由 $g$ 在 $x_0$ 处的连续性，存在 $\delta > 0$ 使得 $B_\delta(x_0) \cap \mathcal{X}_r \subseteq \{x : g(x) > \tau\} \subseteq U_\tau(r)$（$U_\tau$ 以 $\geq$ 定义，包含严格超水平集）。
5. 由 $\mathrm{int}(\mathcal{X}_r) \neq \emptyset$ 且 $x_0 \in \mathcal{X}_r$，取 $\delta$ 足够小使 $B_\delta(x_0) \cap \mathrm{int}(\mathcal{X}_r) \neq \emptyset$。此非空开集由 $\mu$ 的完全支撑性具有正测度，故 $\mu(B_\delta(x_0) \cap \mathcal{X}_r) > 0$。

因此 $\mu(U_\tau(r)) \geq \mu(B_\delta(x_0) \cap \mathcal{X}_r) > 0$。$\square$

> **注（定量下界）**：证明中的 $\delta$ 可被显式量化。由 $g$ 的 Lipschitz 常数 $\mathrm{Lip}(g) \leq L + \mathrm{Lip}(r)$，令 $\delta_\tau = \frac{\varepsilon_r - \tau}{L + \mathrm{Lip}(r)}$，则 $B_{\delta_\tau}(x_0) \cap \mathcal{X}_r \subseteq U_\tau(r)$。若 $\mu$ 为 Ahlfors $D$-正则（即存在常数 $c_D^-, c_D^+ > 0$ 使得 $c_D^- \cdot s^D \leq \mu(B_s(x)) \leq c_D^+ \cdot s^D$，其中 $D$ 为 $\mathcal{X}$ 的 Ahlfors 维数——度量测度空间的内在维度，对 $\mathcal{X} \subseteq \mathbb{R}^n$ 配 Lebesgue 测度即 $D = n$），则 $\mu(U_\tau(r)) \geq c_D^- \cdot \delta_\tau^D$。此量化反映了"$r$ 的变分越剧烈（$\Delta/\rho$ 越大）、系统的光滑度越高（$L$ 越小），不可拟合集越大"的直觉。

> **注（$r$ 不连续时的一般情形）**：上述证明利用了 $r$ 的连续性来保证 $g$ 连续。若 $r$ 在某点 $x_0 \in \mathrm{int}(\mathcal{X}_r)$ **不连续**（存在 $z_n \to x_0$ 使 $r(z_n) \to a \neq r(x_0)$），则由 $\Phi$ 的连续性 $\Phi(z_n) \to \Phi(x_0)$，故 $g(z_n) \to d(\Phi(x_0), a)$。由三角不等式 $d(a, r(x_0)) \leq d(\Phi(x_0), a) + d(\Phi(x_0), r(x_0))$，故 $\max(d(\Phi(x_0), a),\, g(x_0)) \geq d(a, r(x_0))/2 > 0$。若 $d(\Phi(x_0), a) > 0$，则由 $z \mapsto d(\Phi(z), a)$ 的连续性，存在 $z_n$ 的开邻域使 $g > 0$。因此**连续函数 $\Phi$ 无法跟踪 $r$ 的跳跃，不连续只会扩大 $U_\tau(r)$**——定理结论在一般情形下仍然成立。

**定义（局部判别性，Partial Discriminativity）**：称连续映射 $r$ 在 $\mathcal{X}_r$ 上具有 **$(\beta, k)$-局部判别性**，若存在子集 $A \subseteq \mathcal{X}_r$，$\mu(A) \geq \beta \cdot \mu(\mathcal{X}_r)$（$\beta \in (0,1]$），使得 $r|_A$ 满足 co-Lipschitz 条件：

$$d(r(x), r(y)) \geq k \cdot d(x,y) \quad \forall\, x, y \in A$$

即 $r$ 在其定义域的至少 $\beta$ 比例区域上能严格区分不同输入。参数 $\beta$ 量化了判别性的**覆盖度**，$k$ 量化了判别性的**强度**。

> **注（自然性）**：局部判别性远弱于全局 co-Lipschitz（后者要求 $\beta = 1$）。几乎所有具有实际意义的知识映射都满足此条件：数学运算在几乎全域上严格单调（$\beta \approx 1$）；语言理解将不同输入映射至不同语义表征；逻辑推理由不同前提导出不同结论。仅"常函数型"知识（在正测度集上完全平坦）不满足此条件——但此类知识本身不产生非平凡的拟合需求。

**定理（判别性拟合缺口定理，Discriminative Fitting Gap，DFG）**：设 $(\mathcal{X}, d, \mu)$ 为度量概率空间，$\mu$ 为 Ahlfors $D$-正则测度（即 $c_D^- \cdot s^D \leq \mu(B_s(x)) \leq c_D^+ \cdot s^D$；注意 Ahlfors 正则蕴含完全支撑）。设 $\Phi \in \mathrm{Lip}_L(\mathcal{X})$，$(r, \mathcal{X}_r) \in \mathcal{S}$，$r$ 具有 $(\beta, k)$-局部判别性且 $k > L$（即目标的判别扩张率超过系统的最大扩张率——co-Lipschitz 形式的推论 2 条件 $\Delta > L\rho$；此条件同时蕴含 $r$ 具有 $(\rho, k\rho)$-变分，故无需单独假设变分条件）。则对任意 $\tau > 0$：

$$\mu\bigl(U_\tau(r)\bigr) \;\geq\; \beta \cdot \mu(\mathcal{X}_r) \;-\; |\mathrm{Im}(\sigma)| \cdot c_D^+ \cdot \left(\frac{2\tau}{k - L}\right)^D$$

**证明**（路由分区 + co-Lipschitz 直径约束）：

1. **路由分区**：$\sigma$ 将 $\mathcal{X}_r$ 分为至多 $|\mathrm{Im}(\sigma)|$ 个分区单元 $\{C_i\}$，每个单元内 $\Phi|_{C_i}$ 为固定 $L$-Lipschitz 函数。
2. **直径约束**：设 $A$ 为 $r$ 的判别性子集。对每个路由单元 $C_i$，取 $x, y \in S_\tau \cap C_i \cap A$（其中 $S_\tau = \{z : d(\Phi(z), r(z)) < \tau\}$ 为成功集）。由三角不等式：
$$k \cdot d(x,y) \leq d(r(x), r(y)) \leq d(r(x), \Phi(x)) + d(\Phi(x), \Phi(y)) + d(\Phi(y), r(y)) < \tau + L \cdot d(x,y) + \tau$$
故 $(k - L) \cdot d(x,y) < 2\tau$，即 $\mathrm{diam}(S_\tau \cap C_i \cap A) < \frac{2\tau}{k - L}$。

3. **体积估计**：$S_\tau \cap C_i \cap A$ 被包含在某直径为 $\frac{2\tau}{k-L}$ 的球内，由 Ahlfors 正则性：$\mu(S_\tau \cap C_i \cap A) \leq c_D^+ \cdot \left(\frac{2\tau}{k-L}\right)^D$。
4. **Union bound**：$\mu(S_\tau \cap A) \leq |\mathrm{Im}(\sigma)| \cdot c_D^+ \cdot \left(\frac{2\tau}{k-L}\right)^D$。
5. **测度差**：$\mu(U_\tau \cap A) = \mu(A) - \mu(S_\tau \cap A) \geq \beta \cdot \mu(\mathcal{X}_r) - |\mathrm{Im}(\sigma)| \cdot c_D^+ \cdot \left(\frac{2\tau}{k-L}\right)^D$。

由 $U_\tau(r) \supseteq U_\tau \cap A$，结论成立。$\square$

> **注（可解读性）**：界中的两项有清晰的对抗结构。第一项 $\beta \cdot \mu(\mathcal{X}_r)$ 是"目标的判别性区域总量"——$r$ 在其定义域中有多大比例需要被精确区分。第二项 $|\mathrm{Im}(\sigma)| \cdot c_D^+ \cdot \left(\frac{2\tau}{k-L}\right)^D$ 是"系统通过路由分支所能覆盖的量"——路由多样性 $|\mathrm{Im}(\sigma)|$ 乘以每条路径在 co-Lipschitz 约束下的最大成功集体积。当精度要求 $\tau$ 足够小、目标变分强度 $k$ 足够大、或路由分支数不足以覆盖判别性区域时，不可拟合集占据显著甚至绝大比例。特别地，下界为正的充分条件为：
> $$\tau \;<\; \frac{k - L}{2}\left(\frac{\beta \cdot \mu(\mathcal{X}_r)}{|\mathrm{Im}(\sigma)| \cdot c_D^+}\right)^{1/D}$$

**推论（宏观容错界的不可突破定理，Unbreakable Bound on Macroscopic Error Tolerance）**：设 DFG 定理的假设成立。若要求不可拟合集的测度占比不超过容忍度 $\alpha$（$0 \leq \alpha < \beta$），即 $\mu(U_\tau(r)) \leq \alpha \cdot \mu(\mathcal{X}_r)$，则误差容差 $\tau$ 必须满足：

$$\tau \;\geq\; \frac{k - L}{2} \cdot \left( \frac{(\beta - \alpha) \cdot \mu(\mathcal{X}_r)}{|\mathrm{Im}(\sigma)| \cdot c_D^+} \right)^{1/D}$$

**证明**：将系统要求 $\mu(U_\tau(r)) \leq \alpha \cdot \mu(\mathcal{X}_r)$ 代入 DFG 定理的测度下界结论中得：
$$ \alpha \cdot \mu(\mathcal{X}_r) \;\geq\; \mu(U_\tau(r)) \;\geq\; \beta \cdot \mu(\mathcal{X}_r) \;-\; |\mathrm{Im}(\sigma)| \cdot c_D^+ \cdot \left(\frac{2\tau}{k - L}\right)^D $$
移项并隔离参数 $\tau$ 项：
$$ |\mathrm{Im}(\sigma)| \cdot c_D^+ \cdot \left(\frac{2\tau}{k - L}\right)^D \;\geq\; (\beta - \alpha) \cdot \mu(\mathcal{X}_r) $$
由于 $k > L$，两边同取 $1/D$ 次方并移去系数 $\frac{2}{k-L}$，即立刻解出 $\tau$ 必须满足如下不等式：
$$ \tau \;\geq\; \frac{k - L}{2} \cdot \left( \frac{(\beta - \alpha) \cdot \mu(\mathcal{X}_r)}{|\mathrm{Im}(\sigma)| \cdot c_D^+} \right)^{1/D} $$
$\square$

> **注（物理实质解读与维度诅咒）**：此推论揭示了此下界的极其重要的物理意义：
> 1. **有效复杂度阻力 $(\beta - \alpha)$**：当目标函数的判别性覆盖率 $\beta$ 超过系统业务层面允许的失败率 $\alpha$ 时，此数学法则即被直接触发。若期望完全拟合（$\alpha \to 0$），分子取到极限 $\beta$。
> 2. **拓扑拉扯惩罚 $(k - L)/2$**：误差基底严格正比于目标的相对拉扯强度：目标自带的内部扩张率与系统提供的基础平滑性收敛度的极差。
> 3. **宏观维度诅咒（Dimensionality Curse 的终极形式）**：括号外侧的 $1/D$ 次方揭示了核心的维度效应。设系统的路由分支数 $|\mathrm{Im}(\sigma)|$ 随维度 $D$ 的增长率为 $M(D)$。若 $M(D)$ 至多为 $D$ 的亚指数函数（即 $\log M(D) = o(D)$，对应于多项式或亚指数级的系统容量增长——这对绝大多数实际可实现的系统而言是合理的假设），则：
> $$\left(\frac{(\beta - \alpha)\mu(\mathcal{X}_r)}{M(D) \cdot c_D^+}\right)^{1/D} \;\to\; 1 \quad (D \to \infty)$$
> 此时容错极限收敛至：$\tau_{min} \to \frac{k - L}{2}$。该定论表明，在亚指数容量增长体制下，纯粹依靠"暴力扩大网络容量"来抗击高维复杂知识特征的逼近误差，注定会在维度面前丧失边际效益——误差被焊死在由目标与系统的拓扑拉扯差 $(k-L)/2$ 决定的硬底上。唯有路由分支数以 $2^{\Omega(D)}$ 速率指数增长（即系统容量与输入维度呈指数对抗），方能突破此维度封锁——但这在工程上等价于对输入空间的逐点穷举，本身即意味着泛化能力的完全丧失。

---

## 5. 采样度量的方向不对称性（Directional Asymmetry of Sampling Metrics）

> **注**：以下命题刻画 IDFS 采样框架 $\mathcal{S}$ 的方向性：在没有互逆采样对的前提下，知识约束 $\varepsilon$（命题 1）和采样域偏离 $\delta$（命题 2）在正逆两个方向均存在结构性不对称，彼此独立互不蕴含。

**命题 1（逆映射逼近的不对称性，Asymmetry of Inverse Approximation）**：设 $r \in R$ 为可逆映射，$(r, \mathcal{X}_r) \in \mathcal{S}$，且 $(r^{-1}, r(\mathcal{X}_r)) \notin \mathcal{S}$。设 IDFS $(F, \sigma)$ 满足 $\sup_{x \in \mathcal{X}_r} d(\Phi(x), r(x)) \leq \varepsilon_r$。

则 $\Phi$ 对 $r^{-1}$ 的逼近误差与 $\varepsilon_r$ **逻辑独立**：存在满足上述条件的 $\Phi \in \mathrm{Lip}_L(\mathcal{X})$，使得

$$\sup_{y \in r(\mathcal{X}_r)} d\bigl(\Phi(y),\, r^{-1}(y)\bigr)$$

可以任意大（与 $\varepsilon_r$ 无约束关系）。

**证明**：由 §1.3，$\varepsilon_r$ 是 $\Phi$ 在 $\mathcal{X}_r$ 上对 $r$ 的局部误差上界——该约束的成立来源是 $(r, \mathcal{X}_r) \in \mathcal{S}$。$r^{-1}$ 的作用域为 $r(\mathcal{X}_r)$；由于 $(r^{-1}, r(\mathcal{X}_r)) \notin \mathcal{S}$，§1.3 对 $\Phi$ 在 $r(\mathcal{X}_r)$ 上的行为不施加任何约束。

**构造**：取 $\mathcal{X} = \mathbb{R}$，$\mathcal{X}_r = [0, 1]$，$r(x) = x + D$（$D$ 足够大使两段不重叠），则 $r^{-1}(y) = y - D$，$r(\mathcal{X}_r) = [D, D+1]$。定义
$$\Phi(x) = \begin{cases} x + D + \eta & x \in [0, 1] \\ x + C & x \in [D, D+1] \end{cases}$$
之间光滑插值保持全局 Lipschitz。则 $\varepsilon_r = \eta$（$\eta$ 任意小），而对 $y \in [D, D+1]$：$d(\Phi(y), r^{-1}(y)) = |y + C - (y - D)| = |C + D|$，可取任意大。$\square$

> **注（有向性）**：命题 1 的本质是：在不引入互逆采样对的框架下，知识拟合关系在度量空间上是**有向的**——$\Phi$ 拟合 $r$ 与拟合 $r^{-1}$ 是两个独立的约束，前者不蕴含后者。



**命题 2（采样域偏离的逆向不对称性，Asymmetry of Domain Deviation under Inversion）**：设 $r \in R$ 为可逆映射，$(r, \mathcal{X}(r)) \in \mathcal{S}$ 且 $(r^{-1}, r(\mathcal{X}(r))) \in \mathcal{S}$（两个方向均已建立采样约束，$\varepsilon$ 层面的约束对正逆两向均成立）。

记正向链各步采样域偏离为 $\delta_j^{\mathrm{fwd}} \triangleq d(h^*_{j-1},\, \mathcal{X}(r_{i_j}))$，逆向链各步采样域偏离为 $\delta_j^{\mathrm{inv}} \triangleq d(\tilde{h}^*_{j-1},\, r(\mathcal{X}(r_{i_j})))$（$\tilde{h}^*$ 为逆向链的理想轨道）。

则**两个方向的 $\delta$ 代价逻辑独立**：存在满足上述条件的 IDFS $(F,\sigma)$ 和 $r$，以及**同一初始输入** $x_0$，使得

$$\delta_1^{\mathrm{fwd}}(x_0) \;=\; 0 \qquad \text{而} \qquad \delta_1^{\mathrm{inv}}(r(x_0))$$

可以任意大——即使两个方向的单步近似误差均受控，$\delta$ 层面的不对称性不可消除。

**证明（构造）**：取 $\mathcal{X} = \mathbb{R}$，$\mathcal{X}(r) = [0,1]$，$r(x) = 2x+1$（扩张平移），则 $\mathcal{X}(r^{-1}) = r([0,1]) = [1,3]$，$r^{-1}(y) = (y-1)/2$。两个采样对均加入 $\mathcal{S}$，$\varepsilon$ 约束对两向均成立。

取初始输入 $x_0 = 0.5 \in [0,1] = \mathcal{X}(r)$。

**正向链**（以 $r$ 为目标）：$h^*_0 = x_0 = 0.5 \in [0,1]$，故 $\delta_1^{\mathrm{fwd}} = d(0.5,\,[0,1]) = 0$。

**逆向链**（以 $r^{-1}$ 为目标，从 $r(x_0) = 2$ 出发）：理想轨道为 $\tilde{h}^*_0 = r(x_0) = 2 \in [1,3]$，则 $\delta_1^{\mathrm{inv}} = d(2,\,[1,3]) = 0$。

此时两向均为零——但现在考察**第二步**。正向链第二步的理想中间态 $h^*_1 = r(0.5) = 2$，若第二步仍用 $r$ 则 $h^*_1 = 2 \in [0,1]$？不——$h^*_1 = 2 \notin [0,1]$，所以 $\delta_2^{\mathrm{fwd}} = d(2, [0,1]) = 1$。逆向链第二步的理想中间态 $\tilde{h}^*_1 = r^{-1}(2) = 0.5$，若第二步仍用 $r^{-1}$ 则 $\tilde{h}^*_1 = 0.5 \in [1,3]$？不——$0.5 \notin [1,3]$，所以 $\delta_2^{\mathrm{inv}} = d(0.5, [1,3]) = 0.5$。

两向均有偏离，但幅度不同（$1$ vs $0.5$）。更极端的不对称来自 $r$ 的**扩张率**：$r$ 将 $[0,1]$ 拉伸为 $[1,3]$（长度加倍），而 $r^{-1}$ 将 $[1,3]$ 压缩为 $[0,1]$。因此正向链的理想轨道“逃出”采样域的速度（$\delta_j^{\mathrm{fwd}}$ 的增长率）与逆向链“逃出”采样域的速度（$\delta_j^{\mathrm{inv}}$ 的增长率）由 $r$ 的局部 Lipschitz 常数决定，而 $\mathrm{Lip}(r) \neq \mathrm{Lip}(r^{-1})$（除非 $r$ 为等距映射）。

特别地，若取 $r(x) = Kx + b$（$K > 1$），则经 $n$ 步正向迭代后 $\delta_n^{\mathrm{fwd}} \sim K^n$（指数增长），而逆向迭代 $\delta_n^{\mathrm{inv}} \sim K^{-n}$（指数衰减）。两向的 $\delta$ 累积代价的比值 $\sim K^{2n} \to \infty$，不对称性随链长指数放大。$\square$

> **注**：命题 2 表明：命题 1 的有向性来自 $\varepsilon$ 约束的有向性（采样对存在与否），命题 2 的有向性来自 $\delta$ 结构的有向性（理想轨道与采样域的几何关系）——两者独立，互不蕴含。即使通过引入互逆采样对完全消除 $\varepsilon$ 层面的不对称，$\delta$ 层面的不对称仍然存在，其根源是 $r$ 的扩张/压缩率 $\mathrm{Lip}(r)/\mathrm{Lip}(r^{-1})$ 的不对称性——这是 CAC 精细界中 $\delta \cdot \Gamma$ 项引入的不可规避的新自由度。

---

## 6. IDFS 动力系统与决策流形（IDFS Dynamical Systems and Decision Manifolds）

> **注**：以下命题刻画 IDFS 迭代映射 $\Phi$ 本身的动力学稳定性，不直接依赖 CAC 误差上界中的 $\varepsilon_{i_j}$、$\delta_j$ 结构；而是关于 Lipschitz 算子在长链迭代下的扰动传播行为及 $\sigma$-决策边界的不连续性质。

**命题 1（不动点收敛，Fixed-Point Convergence）**：若 $\Phi \in \mathrm{Lip}_L(\mathcal{X})$（全局）且 $L < 1$，$(\mathcal{X}, d)$ 完备，则 $\Phi$ 存在唯一不动点 $x^* = \Phi(x^*)$，$\Phi$-轨道从任意初始点收敛：$\hat{h}_l \to x^*$。

**证明**：$L < 1$ 时 $\Phi$ 是完备度量空间 $(\mathcal{X}, d)$ 上的压缩映射，由 **Banach 压缩映射定理**直接得不动点存在唯一性及轨道收敛。$\square$

**命题 2（扰动的长链衰减，Long-chain Decay of Perturbations）**：设 f-链步骤 $1, \ldots, l$ 的路径局部 Lipschitz 为 $L_j$。设第 $k-1$ 步存在任意来源的**状态扰动** $\Delta_{k-1} \triangleq d(\hat{h}_{k-1}^{(A)}, \hat{h}_{k-1}^{(B)}) > 0$（注：$\Delta_{k-1}$ 为两条轨道之间的状态差，区别于 CAC 主定理中的采样域偏离 $\delta_j$）——无论其来自原始输入差异还是前 $k-1$ 步的近似误差积累——若**尾部乘积** $\Theta_{k,l} \to 0$（$l \to \infty$，即 $\sum_{j=k}^{\infty} \log L_j = -\infty$，收缩步主导），则：

$$d\!\bigl(\hat{h}_l^{(A)},\, \hat{h}_l^{(B)}\bigr) \;\leq\; \Theta_{k,l} \;\cdot\; \Delta_{k-1} \;\to\; 0$$

无论 $\Delta_{k-1}$ 多大，f-chain 终态均收敛——IDFS **抹除第 $k-1$ 步之前的一切扰动**，无论扰动来自输入差异、近似误差还是任何其他来源，均被尾部收缩机制彻底压制至零。

**特例（输入差异）**：取 $k = 1$，$\Delta_0 = d(x_A, x_B)$，则退化为对原始输入差异的衰减：$d(\hat{h}_l^{(A)}, \hat{h}_l^{(B)}) \leq \Theta_{1,l} \cdot d(x_A, x_B)$。

定义**有效区分深度** $l^\dagger = \max\{l \mid \Theta_{k,l} \geq \theta\}$（$\theta \in (0,1)$ 为可区分阈值），超过此深度后任意扰动均衰减至不可区分范围内。

**证明**：对局部 Lipschitz 条件连续应用，从第 $k$ 步截断：
$$d(\hat{h}_l^{(A)}, \hat{h}_l^{(B)}) \leq \Theta_{k,l} \cdot d(\hat{h}_{k-1}^{(A)}, \hat{h}_{k-1}^{(B)}) = \Theta_{k,l} \cdot \Delta_{k-1}$$
$\Delta_{k-1}$ 为有限正数，尾部乘积 $\Theta_{k,l} \to 0$ 时右端趋零。$\square$

> **注（对偶结构）**：$\Theta_{1,l}$（整条链的路径乘积，即 $\prod_{j=1}^l L_j$）与 $\Lambda_l$ 控制系统的两个方向：$\Lambda_l$ 衡量**误差的累积放大**（单步近似误差如何沿链传播），$\Theta_{1,l}$ 衡量**输入分离的保持程度**（不同输入的输出能否区分）。收缩机制（$L_j < 1$）同时压低 $\Theta_{1,l}$（输出坍缩，输入可区分性消失）和 $\Lambda_l$（抑制误差累积）；扩张机制（$L_j > 1$）则反之。两者的平衡决定了 IDFS 的长链稳定性。

**命题 3（扰动的长链爆炸，Long-chain Explosion of Perturbations）**：设从第 $k$ 步（$k \geq 1$）起，f-链的每一步 $j = k, \ldots, l$ 均存在**扩张下界** $c_j \geq 1$，使得：

$$d\!\bigl(\hat{h}_j^{(A)},\, \hat{h}_j^{(B)}\bigr) \;\geq\; c_j \cdot d\!\bigl(\hat{h}_{j-1}^{(A)},\, \hat{h}_{j-1}^{(B)}\bigr)$$

定义**尾部扰动放大系数（下界）**：

$$\Pi_{k,l}^{-} \;\triangleq\; \prod_{j=k}^{l} c_j$$

设第 $k-1$ 步存在任意来源的**状态扰动** $\Delta_{k-1} \triangleq d(\hat{h}_{k-1}^{(A)}, \hat{h}_{k-1}^{(B)}) > 0$——无论其来自原始输入差异还是前 $k-1$ 步的近似误差积累——则 f-chain 终态距离满足：

$$d\!\bigl(\hat{h}_l^{(A)},\, \hat{h}_l^{(B)}\bigr) \;\geq\; \Pi_{k,l}^{-} \cdot \Delta_{k-1}$$

**进一步**：若 $\Pi_{k,l}^{-} \to \infty$（等价于 $\sum_{j=k}^{\infty} \log c_j = +\infty$），则终态距离趋无穷——无论 $\Delta_{k-1}$ 多小，只要非零，尾部扩张机制将其**无限放大**。前 $k-1$ 步如何产生 $\Delta_{k-1}$ 无关紧要，爆炸由第 $k$ 步之后的乘积驱动。

**特例（输入差异）**：取 $k = 1$，$\Delta_0 = d(x_A, x_B)$，则退化为对原始输入差异的放大：$d(\hat{h}_l^{(A)}, \hat{h}_l^{(B)}) \geq \Pi_{1,l}^{-} \cdot d(x_A, x_B)$。

**证明**：对扩张下界条件从第 $k$ 步起连续应用，链式展开得 $d(\hat{h}_l^{(A)}, \hat{h}_l^{(B)}) \geq \Pi_{k,l}^{-} \cdot \Delta_{k-1}$。$\Delta_{k-1} > 0$ 为有限正数，$\Pi_{k,l}^{-} \to \infty$ 时右端趋无穷。$\square$

> **注（驱动条件是尾部乘积；扰动来源无关紧要）**：起始步 $k$ 任意，前 $k-1$ 步可扩张、可收缩、可无约束，不影响结论——关键只是 $\Delta_{k-1} > 0$ 存在。尾部乘积 $\Pi_{k,l}^{-} \to \infty$ 是爆炸的充分条件，而非要求每步 $c_j > 1$（例如 $c_j = 1 + 1/j^2$ 时乘积收敛，不会爆炸）。与命题4完全对称：命题4中收缩尾部乘积将任意有限扰动压至零，命题5中扩张尾部乘积将任意非零扰动放大至无穷——两者均与扰动的历史来源无关。命题6是命题5在 IDFS $\sigma$-决策边界处的**结构性实例**——边界跨越时 $c_j \to \infty$，使 $\Pi_{k,l}^{-}$ 以极端速度发散。

---

**命题 4（决策边界的局部曲率爆炸，Decision Boundary Curvature Explosion）**：设 IDFS $(F, \sigma)$ 如 §1.2 所定义。若 f-链第 $j$ 步中，近似状态 $\hat{h}_{j-1}$ 与理想状态 $h^*_{j-1}$ 被 $\sigma$ 选到了不同的函数——即 $\sigma(\hat{h}_{j-1}) = f_k \neq f_{k'} = \sigma(h^*_{j-1})$——且两函数在 $\hat{h}_{j-1}$ 处的输出差有宏观下界：


$$\Delta \;\triangleq\; d\bigl(f_k(\hat{h}_{j-1}),\, f_{k'}(\hat{h}_{j-1})\bigr) \;>\; 0, \qquad k \neq k'$$

则路径局部 Lipschitz 常数满足：

$$L_j \;=\; \frac{d\bigl(\Phi(\hat{h}_{j-1}),\, \Phi(h^*_{j-1})\bigr)}{d(\hat{h}_{j-1},\, h^*_{j-1})} \;\geq\; \frac{\Delta - L_{f_{k'}} \cdot d(\hat{h}_{j-1},\, h^*_{j-1})}{d(\hat{h}_{j-1},\, h^*_{j-1})}$$

当误差 $e_{j-1} = d(\hat{h}_{j-1}, h^*_{j-1}) \to 0$ 而两点仍跨越边界时，$L_j \to \infty$。

**证明**：设 $a = \hat{h}_{j-1}$，$b = h^*_{j-1}$，$\sigma(a) = f_k$，$\sigma(b) = f_{k'}$（$k \neq k'$）。则：

$$d\bigl(\Phi(a),\, \Phi(b)\bigr) = d\bigl(f_k(a),\, f_{k'}(b)\bigr)$$

由三角不等式：

$$d\bigl(f_k(a),\, f_{k'}(b)\bigr) \;\geq\; d\bigl(f_k(a),\, f_{k'}(a)\bigr) - d\bigl(f_{k'}(a),\, f_{k'}(b)\bigr) \;\geq\; \Delta - L_{f_{k'}} \cdot d(a, b)$$

其中 $L_{f_{k'}}$ 是函数 $f_{k'}$ 的 Lipschitz 常数（有界量）。两边除以 $d(a,b)$：

$$L_j \;\geq\; \frac{\Delta}{d(a,b)} - L_{f_{k'}} \;\xrightarrow{d(a,b) \to 0}\; +\infty \qquad \square$$

> **注（与命题5的关系）**：命题6是**命题5在 IDFS $\sigma$-边界处的结构性实例**。命题5要求以 co-Lipschitz 下界 $c_j > 1$ 作为前提条件；而命题6表明，当两点跨越 $\sigma$-决策边界时，该条件由 IDFS 结构**自动满足**，且下界以 $c_j \geq \Delta/d(a,b) - L_{f_{k'}} \to +\infty$ 的速度发散——即 IDFS 在边界附近天然具备极端扩张性。这是 $\sigma$ 将连续状态空间映射到离散函数集的内在代价：**边界处的不连续性产生无界局部扩张，是命题5最极端的退化情形**。

> **注（与§4 推论 2 的三元纠缠的关系）**：§4 推论 2 的注指出，将分析从采样域 $\mathcal{X}(r)$ 扩展至 $\mathrm{dom}(r)$ 时，$\sigma$ 的决策边界使全局 Lipschitz 常数 $L$ 无法刻画 $\Phi$ 在 $\mathcal{X}(r)$ 外的光滑度，由此产生 $(\varepsilon_r, L, \sigma)$ 三元纠缠。命题6给出了这一现象的精确机制：$\sigma$ 在 $\partial\mathcal{X}(r)$ 处选择不同函数，等价于跨越决策边界，此时路径局部 Lipschitz $L_j \to \infty$——这正是单一标量 $L$ 失效、$\sigma$ 必须显式出现的数学来源。换言之，**命题6是三元纠缠的形式基础**：正是 $\sigma$-边界处的 $L_j$ 无界性，使得 $\mathrm{dom}(r)$ 上的变分分析无法仅依赖 $(\varepsilon_r, L)$ 二元完成。此外，$L_j \to \infty$ 在 CAC 精细界中产生**双重不对称爆炸**：ε-项权重为 $\Theta_{j+1,l}$（不含本步 $L_j$），而 δ-项权重为 $\Theta_{j,l} = L_j \cdot \Theta_{j+1,l}$——因此同一次边界跨越中，δ 代价的爆炸速度比 ε 代价**额外快一个 $L_j$ 因子**，采样域偏离在边界附近会被优先且更剧烈地放大。

