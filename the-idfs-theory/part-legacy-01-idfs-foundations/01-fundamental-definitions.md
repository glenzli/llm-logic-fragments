## 基本定义

### 1.1 空间与算子基础

设 $(\mathcal{X}, d)$ 为**度量空间**。指定一个**吸收元（absorbing element）** $\bot \in \mathcal{X}$ 作为空间基点，用于将偏函数全函数化：$\phi(x) = \bot$ 意味着 $\phi$ 在 $x$ 处未定义。

定义**变换空间**：

$$\Omega = \{\, \phi : \mathcal{X} \to \mathcal{X} \;\big|\; \phi(\bot) = \bot \,\}$$

即 $\Omega$ 由所有**基点保持映射**（pointed maps）构成。$\phi \in \Omega$ 称为 $\mathcal{X}$ 上的一个**算子**（operator）。对 $\phi \in \Omega$，定义其**定义域**为 $\phi$ 产生非 $\bot$ 值的全部输入：

$$\mathrm{dom}(\phi) \;\triangleq\; \bigl\{\, x \in \mathcal{X} \;\big|\; \phi(x) \neq \bot \,\bigr\}$$

$\mathrm{dom}(\phi)$ 即 $\phi$ 实际发生作用的输入集合。由 $\phi(\bot) = \bot$，复合链的定义域单调不增：$\mathrm{dom}(\phi_2 \circ \phi_1) = \{x \in \mathrm{dom}(\phi_1) \mid \phi_1(x) \in \mathrm{dom}(\phi_2)\} \subseteq \mathrm{dom}(\phi_1)$。

$\Omega$ 在函数复合下构成**幺半群**：$\phi_2 \circ \phi_1 \in \Omega$，$\mathrm{id}_{\mathcal{X}} \in \Omega$。


#### 1.1.1 采样与宏观采样集

设 $R = \{r_1, r_2, \ldots, r_m\} \subset \Omega$ 为 $\Omega$ 的一个有限子集。

$R^*$ 为 $R$ 在复合运算下的**自由幺半群**：

$$R^* = \{ r_{i_k} \circ \cdots \circ r_{i_1} \mid k \geq 0,\ r_{i_j} \in R \}$$

$R^*$ 中长度为 $l$ 的元素 $q = r_{i_l} \circ \cdots \circ r_{i_1}$ 称为 **$r$-链**（$r$-chain），$l$ 为其**长度**（$l = 0$ 对应幺元 $\mathrm{id}_{\mathcal{X}}$）。

设 $\mathcal{S}$ 为 $R$ 的一次**采样**（sampling of $R$）：对每条规则 $r \in R$，指定其**采样域** $\mathcal{X}(r) \subseteq \mathrm{dom}(r)$。形式上：

$$\mathcal{S} \;=\; \bigl\{\, (r,\, \mathcal{X}(r)) \;\big|\; r \in R,\; \mathcal{X}(r) \subseteq \mathrm{dom}(r) \,\bigr\}$$

设 $\mathcal{T}_l$ 为 $\mathcal{S}$ 生成的、长度不超过 $l$ 的**有效链集**（Valid Chain Set up to length $l$）：

$$\mathcal{T}_l = \bigl\{\, q \in R^* \;\big|\; |q| \leq l \text{ 且 } \mathrm{dom}(q) \neq \emptyset \,\bigr\}$$

$\mathcal{T}_l$ 即 $R^*$ 中所有长度有界且**定义域非空**的 $r$-链，每个 $q \in \mathcal{T}_l$ 的输入域 $\mathrm{dom}(q)$ 由 $q$ 的级联映射行为完全决定。

$q \in \Omega$ 且 $(q, \mathrm{dom}(q))$ 与 $(r_i, \mathcal{X}(r_i)) \in \mathcal{S}$ 具有相同的代数结构（算子-定义域二元组）。因此 $\{(q, \mathrm{dom}(q)) \mid q \in \mathcal{T}_l\}$ 构成建立在 $R^*$ 上的**宏观采样集**（Macroscopic Sampling Set）。

#### 1.1.2 规范结构

**定义（规范结构，Gauge Structure）**：$(\mathcal{X}, d)$ 上的一个**规范结构** $\mathcal{G} = \{d_i\}_{i \in I}$ 是一族**伪度量**（pseudometric），满足：

1. 每个 $d_i: \mathcal{X} \times \mathcal{X} \to [0, \infty)$ 满足 $d_i(x, x) = 0$、$d_i(x, y) = d_i(y, x)$、$d_i(x, z) \leq d_i(x, y) + d_i(y, z)$，但允许 $d_i(x, y) = 0$ 而 $x \neq y$。
2. **度量相容性**：$\mathcal{G}$ 生成的拓扑不弱于 $d$ 生成的拓扑——即 $d$ 中的每个开球包含某个由有限个 $d_i$-球交集构成的开集。

称 $(\mathcal{X}, d, \mathcal{G})$ 为**规范度量空间**（gauged metric space）。每个 $d_i$ 称为 $\mathcal{G}$ 的一个**分量伪度量**。

**定义（族分离性，Family Separation）**：

- **分离规范**（separating gauge）：$\forall x, y \in \mathcal{X}$，$(\forall i \in I:\; d_i(x, y) = 0) \;\Rightarrow\; x = y$。
- **非分离规范**（non-separating gauge）：$\exists\, x \neq y$ 使得 $\forall i \in I:\; d_i(x, y) = 0$。此时 $\mathcal{G}$ 在 $\mathcal{X}$ 上诱导等价关系 $x \sim_\mathcal{G} y \;\Leftrightarrow\; \forall i:\; d_i(x, y) = 0$，$\mathcal{G}$ 在商空间 $\mathcal{X}/{\sim_\mathcal{G}}$ 上成为分离规范。

规范结构是 $(\mathcal{X}, d)$ 上的一种**可选结构**。不指定时，等价于退化规范 $\mathcal{G} = \{d\}$（$|I| = 1$，分离）。后续定义与命题均以 $d$ 为默认；凡涉及逐分量分析的场合，显式引入 $\mathcal{G}$。

#### 1.1.3 度量熵

**定义（度量熵，Metric Entropy）**：采样集 $\mathcal{S}$ 在 $\mathcal{X}$ 中诱导的**目标输出值集**为 $\mathcal{V}(\mathcal{S}) \triangleq \{r(x) \mid (r, \mathcal{X}(r)) \in \mathcal{S},\, x \in \mathcal{X}(r)\} \subseteq \mathcal{X}$。对给定精度 $\epsilon > 0$ 与 $\mathcal{X}$ 上的伪度量 $d'$，定义采样集在 $d'$ 下的**度量熵**为：

$$I_{\epsilon, d'}(\mathcal{S}) \;\triangleq\; \log \mathcal{N}_{d'}\bigl(\epsilon,\, \mathcal{V}(\mathcal{S})\bigr)$$

其中 $\mathcal{N}_{d'}(\epsilon, A)$ 为在伪度量 $d'$ 下覆盖 $A$ 所需的最小 $\epsilon$-球数量。取 $d' = d$ 时简记 $I_\epsilon(\mathcal{S}) \triangleq I_{\epsilon, d}(\mathcal{S})$。设 $\mathcal{G} = \{d_i\}_{i \in I}$ 为规范结构，则 $I_{\epsilon, d_i}(\mathcal{S})$ 为 $\mathcal{V}(\mathcal{S})$ 在分量 $d_i$ 下的 $\epsilon$-覆盖数对数。

#### 1.1.4 算子的分量分划

**定义（分量分划，Component Decomposition）**：设 $\phi \in \Omega$，$\mathcal{G} = \{d_i\}_{i \in I}$ 为 $(\mathcal{X}, d)$ 上的规范结构。定义：

- **恒等分量** $I_{\mathrm{id}}(\phi) = \{i \in I : \forall x \in \mathrm{dom}(\phi),\; d_i(\phi(x), x) = 0\}$。
- **常值分量** $I_{\mathrm{const}}(\phi) = \{i \in I \setminus I_{\mathrm{id}}(\phi) : \forall x, y \in \mathrm{dom}(\phi),\; d_i(\phi(x), \phi(y)) = 0\}$。
- **活跃分量** $I_{\mathrm{act}}(\phi) = I \setminus (I_{\mathrm{id}}(\phi) \cup I_{\mathrm{const}}(\phi))$。

三者互斥且穷尽：$I = I_{\mathrm{id}} \sqcup I_{\mathrm{const}} \sqcup I_{\mathrm{act}}$。若 $i$ 同时满足恒等与常值条件（$\mathrm{dom}(\phi)$ 中所有点在 $d_i$ 下不可区分且 $\phi$ 在 $d_i$ 上为恒等），优先归入 $I_{\mathrm{id}}$。$\mathcal{G} = \{d\}$ 时，分划退化为 $I_{\mathrm{act}} = \{d\}$（除非 $\phi = \mathrm{id}$ 或 $\phi$ 为常值映射）。

### 1.2 输入驱动函数系统（IDFS）

**定义（输入驱动函数系统，Input-Driven Function System，IDFS）**：一个**输入驱动函数系统** $\mathcal{F} = (F, \sigma)$ 由以下要素构成：

1. **函数集** $F = \{f_1, f_2, \ldots, f_M\} \subset \Omega$：$\mathcal{X}$ 上有限个基点保持映射的集合，$M = |F|$ 为函数集的大小。

2. **选择映射** $\sigma : \mathcal{X} \to F^*$：将输入 $x$ 映射到 $F$ 上的一个可变长度复合链 $\sigma(x) = f_{i_k} \circ f_{i_{k-1}} \circ \cdots \circ f_{i_1}$（$k \geq 1$）。

3. **系统映射** $\Phi : \mathcal{X} \to \mathcal{X}$：由 $F$ 与 $\sigma$ 共同确定的全局单步映射，定义为
   $$\Phi(x) \;\triangleq\; \sigma(x)(x)$$
   即对输入 $x$，先由 $\sigma$ 选定计算链，再将该链作用于 $x$ 本身。

4. **广义 Lipschitz 常数**：对 $\mathcal{X}$ 上的伪度量 $d'$，定义系统映射 $\Phi$ 在 $d'$ 下的**广义 Lipschitz 常数**为
   $$L_{d'} \;\triangleq\; \sup_{\substack{x, y \in \mathcal{X} \\ d'(x,y) > 0}} \frac{d'(\Phi(x),\, \Phi(y))}{d'(x, y)} \;\in\; \bar{\mathbb{R}}_+ \;=\; [0, +\infty]$$
   取 $d' = d$ 时简记 $L \triangleq L_d$。$L < \infty$ 时 $\Phi$ 满足标准 Lipschitz 连续性；$L = +\infty$ 亦为合法 IDFS——此时系统映射不保证全局度量正则性，但 IDFS 的代数结构（路由、链复合、采样约束）仍完全有效。后续定理中凡需要 $L < \infty$ 的场合均显式标注为前提条件。设 $\mathcal{G} = \{d_i\}_{i \in I}$ 为规范结构，则 $L_{d_i}$ 度量 $\Phi$ 沿分量 $d_i$ 的拉伸率。

定义系统的**微观计算深度（Micro-Depth）** $\mathcal{D}$ 为选择映射可能产生的最长计算链长度：

$$\mathcal{D} \;\triangleq\; \sup_{x \in \mathcal{X}} \big|\sigma(x)\big| \;\lt\; \infty$$

（其中 $|\sigma(x)|$ 表示链中底层函数的个数 $k$，有限性反映物理系统的有限计算资源约束），它表征了单步宏观映射下系统所能调用的最大微观操作上限。

设 $\sigma(x) = f_{i_k} \circ \cdots \circ f_{i_1}$，则 $\Phi(x)$ 的计算沿**序贯管道**逐层传递：令 $h_0 = x$，逐步求值 $h_j = f_{i_j}(h_{j-1})$（$j = 1, \ldots, k$），最终 $\Phi(x) = h_k$。每个 $f_{i_j}$ 接收前一步的输出作为输入，链的终态即为系统的单步宏观输出。

> **定义（激活链，Activated Chain）**：$\sigma(x) \in F^*$ 作为 $\Omega$ 中的映射对象，称为 $x$ 处的**激活链（Activated Chain）**。IDFS 的定义对 $\sigma$ 与 $f$ 的关系不施加任何约束——$\sigma$ 仅决定映射的选取与排列，其输出 $\sigma(x)$ 本身是 $\mathcal{X} \to \mathcal{X}$ 的完整映射，因此可施加于任意 $y \in \mathcal{X}$：
> $$\sigma(x)(y) = (f_{i_k} \circ \cdots \circ f_{i_1})(y)$$
> 此处 $x$ 决定**路由**（选取哪条链），$y$ 为**被变换对象**（链作用于谁）。$\Phi(x) = \sigma(x)(x)$ 即 $x$ 同时充当路由点与计算点的情形。

> **注（广义 Lip 常数与基函数的关系）**：广义 Lip 常数 $L \in \bar{\mathbb{R}}_+$ 是 $\sigma$ 对 $F$ 进行分段组合后的**宏观闭包性质**——它由所有激活链的组合行为决定，而非单个基函数的性质。$F$ 中可包含 $\mathrm{Lip}(f) = \infty$ 的非线性算子，只要 $\sigma$ 的调度使得实际被激活的链路在所途经区域上具有有限的局部 Lip 常数，系统在该区域上的误差传播即可被定量分析。IDFS 的自洽性独立于基算子在非激活区域的解析行为。

#### 1.2.1 级联系统 $\mathcal{F}^l$

由 $F \subset \Omega$ 且 $\Omega$ 在复合下构成幺半群，可直接验证：

1. **$\Phi \in \Omega$**：$\sigma(x) \in F^* \subseteq \Omega$，且 $\Phi(\bot) = \sigma(\bot)(\bot) = \bot$（因每个 $f_i(\bot) = \bot$）。
2. **$\Phi^l \in \Omega$**：幺半群的复合封闭性。
3. **$l$-步宏观同构系统**：对任意 $l \geq 1$，$\Phi^l$ 自身构成新的 IDFS $\mathcal{F}_l = (F, \sigma_l)$，其中 $\sigma_l(x) = \sigma(\Phi^{l-1}(x)) \circ \cdots \circ \sigma(\Phi(x)) \circ \sigma(x)$。IDFS 在宏观复合下呈现**代数自相似性**。

> **注（$\mathcal{F}_\infty$ 的 IDFS 合法性）**：$\mathcal{F}_l$ 对每个有限 $l$ 构成合法 IDFS。但当 $l \to \infty$ 时，$\mathcal{F}_\infty$ **不保证**是 IDFS：级联选择映射 $\sigma_\infty$ 的链长度趋于无穷（$|\sigma_\infty(x)| \leq l \cdot \mathcal{D} \to \infty$，违反微观深度有限性）。因此，本章后续对 $l \to \infty$ 的分析（§2 及后续章节），其含义均为：研究有限 IDFS 映射序列 $\{\Phi^l\}_{l \geq 1}$ 的渐近行为，而非假设极限对象 $\mathcal{F}_\infty$ 本身满足 IDFS 公理。

**定义（路径广义 Lipschitz 常数，Path Generalized Lipschitz Constant）**：设 $p = \sigma(x) \in F^*$ 为 $x$ 处的激活链。定义 $p$ 在伪度量 $d'$ 下的**路径广义 Lipschitz 常数**为：
$$L_{p,d'} \;\triangleq\; \sup_{\substack{x', y' \in \mathrm{dom}(p) \\ d'(x',y') > 0}} \frac{d'(p(x'),\, p(y'))}{d'(x', y')} \;\in\; \bar{\mathbb{R}}_+$$
取 $d' = d$ 时简记 $L_p \triangleq L_{p,d}$。$L_{p,d'}$ 由该路径上激活链的局部行为决定，与其他路由区域无关。当 $L_{d'} < \infty$ 时，$L_{p,d'} \leq L_{d'}$。

**定义（路径广义 Lipschitz 跨度，Path Generalized Lipschitz Span）**：定义系统 $\Phi$ 在伪度量 $d'$ 下的**路径广义 Lipschitz 跨度**为：
$$\kappa_{\Phi,d'} \;\triangleq\; \frac{\sup_p L_{p,d'}}{\inf_p L_{p,d'}} \;\in\; [1, +\infty]  \qquad \text{（约定 } \inf_p L_{p,d'} > 0\text{）}$$
取 $d' = d$ 时简记 $\kappa_\Phi \triangleq \kappa_{\Phi,d}$。$\kappa_{\Phi,d'} = 1$ 当且仅当所有路径在 $d'$ 下的拉伸率相同。当 $\inf_p L_{p,d'} = +\infty$ 时，比值未定义，$\kappa_{\Phi,d'}$ 失去意义。$\kappa_\Phi$ 决定泛化张力的结构性意义见 §2.4。

针对 $l$-步连续复合映射 $\Phi^l$，设 $\sigma(x) = f_{i_k} \circ \cdots \circ f_{i_1}$，记第 $j$ 步基函数 $f_{i_j}$ 在伪度量 $d'$ 下的 Lipschitz 常数为 $L_{j, d'} \in \bar{\mathbb{R}}_+$（取 $d' = d$ 时简记 $L_j \triangleq L_{j,d}$）。

**定义（尾部乘积，Tail Product）**：定义自第 $j$ 步至第 $l$ 步在伪度量 $d'$ 下的累积截断乘积为：
$$\Theta_{j,l,d'} \;\triangleq\; \prod_{k=j}^{l} L_{k,d'} \;\in\; \bar{\mathbb{R}}_+ \qquad \text{（约定 } j > l \text{ 时，空积 } \Theta_{j,l,d'} = 1\text{）}$$
取 $d' = d$ 时简记 $\Theta_{j,l} \triangleq \Theta_{j,l,d}$。乘积在扩展实数 $\bar{\mathbb{R}}_+$ 上按标准算术运算：含 $+\infty$ 因子时 $\Theta_{j,l,d'} = +\infty$（除非存在零因子）。由 $L_{k,d'}$ 的定义逐步链式展开，当所有 $L_{k,d'} < \infty$ 时：
$$d'\bigl(\Phi^l(x),\, \Phi^l(y)\bigr) \leq \Theta_{1,l,d'} \cdot d'(x, y)$$

当 $L_{d'} < \infty$ 时，由 $L_{j,d'} \leq L_{d'}$ 可得 $\Theta_{1,l,d'} \leq L_{d'}^l$。

**定义（路径等效广义 Lipschitz 常数 / 几何均值，Path Equivalent Generalized Lipschitz Constant / Geometric Mean）**：定义长度 $l$ 路径在伪度量 $d'$ 下的等效宏观形变率为：
$$\bar{L}_{d'} \;\triangleq\; \Theta_{1,l,d'}^{1/l}$$
取 $d' = d$ 时简记 $\bar{L} \triangleq \bar{L}_d$。$\bar{L}$ 在度量系统深度演化的误差界限（见 §3 CAC 定理）与泛化张力（见 §2.4）中起核心收束作用。

#### 1.2.2 拓扑容量

**定义（IDFS 拓扑容量，Topological Capacity）**：IDFS 的系统容量可从两个互补维度刻画：

1. **像集容量（Image Capacity）**——在伪度量 $d'$ 与精度 $\epsilon > 0$ 下，系统能产生多少 $d'$-可分辨的输出值：
   $$\mathcal{C}_{\mathrm{img}, d'}(\Phi, \epsilon) \;\triangleq\; \log \mathcal{N}_{d'}\bigl(\epsilon,\, \Phi(\mathcal{X})\bigr)$$
   取 $d' = d$ 时简记 $\mathcal{C}_{\mathrm{img}}(\Phi, \epsilon) \triangleq \mathcal{C}_{\mathrm{img}, d}(\Phi, \epsilon)$。
2. **路由容量（Routing Capacity）**——系统能提供多少可分辨的计算路径：
   $$\mathcal{C}_{\mathrm{route}}(\sigma) \;\triangleq\; \log |\mathrm{Im}(\sigma)|$$

### 1.3 单步近似误差与容差集

**定义（单步近似误差与容差集，Single-Step Error & Tolerance Set）**：给定被诱导的全局系统映射 $\Phi$ 与采样集 $\mathcal{S} = \{(r_i, \mathcal{X}(r_i))\}_{i=1}^m$。对 $\mathcal{X}$ 上的伪度量 $d'$，定义 $\Phi$ 在 $d'$ 下对 $r_i$ 的**单步近似误差**（Single-Step Approximation Error）为：

$$\varepsilon_{i, d'} \;\triangleq\; \sup_{x \in \mathcal{X}(r_i)} d'\bigl(\Phi(x),\, r_i(x)\bigr)$$

取 $d' = d$ 时简记 $\varepsilon_i \triangleq \varepsilon_{i, d}$。定义 $\Phi$ 在 $\mathcal{S}$ 上的**容差集** $\mathcal{E}$ 为所有全局单步近似误差的集合：

$$\mathcal{E} \;\triangleq\; \bigl\{\, \varepsilon_i \;\big|\; (r_i, \mathcal{X}(r_i)) \in \mathcal{S} \,\bigr\}$$

记 $\varepsilon_{\max} = \max\, \varepsilon_i$。此时称 IDFS $\mathcal{F} = (F, \sigma)$ **以容差集 $\mathcal{E}$ 拟合了采样集 $\mathcal{S}$**。$\varepsilon_{i, d'}$ 用于后续逐分量误差分析。


### 1.4 $\tau$-不可完美拟合集

**定义（规则的 $\tau$-不可完美拟合集，$\tau$-Imperfect Fitting Set of a Rule）**：设 $(r_i, \mathcal{X}(r_i)) \in \mathcal{S}$，给定容差阈值 $\tau > 0$。定义系统 $\Phi$ 在该采样规则上的**不可完美拟合集**为误差超出阈值的输入子空间：

$$U_\tau(r_i) \;\triangleq\; \bigl\{\, x \in \mathcal{X}(r_i) \;\big|\; d\bigl(\Phi(x),\, r_i(x)\bigr) \geq \tau \,\bigr\}$$

**定义（系统的 $\tau$-全局不可拟合集，Global $\tau$-Unfittable Zone of IDFS）**：定义系统 $\Phi$ 在整个采样集 $\mathcal{S}$ 上的**全局不可拟合集**，为所有规则的不可拟合集的并集：

$$U_\tau(\mathcal{S}) \;\triangleq\; \bigcup_{(r_i, \mathcal{X}(r_i)) \in \mathcal{S}} U_\tau(r_i)$$

> **注（完美拟合集，Perfect Fitting Set）**：为考察极致精度的逼近区域，定义不可完美拟合集 $U_\tau(r_i)$ 的补集，即系统的**$\tau$-拟合集** $P_\tau(r_i) = \{ x \in \mathcal{X}(r_i) \mid d(\Phi(x), r_i(x)) < \tau \}$。考察极限情形 $\tau \to 0^+$，该拟合集将严格收缩至极小值论域 $P_{0^+}(r_i) = \{ x \mid d(\Phi(x), r_i(x)) = 0 \}$，此即为系统在采样点上的**完美拟合集（Perfect Fitting Set）**。完美拟合集代表了模型对样本能实现"零误差绝对记忆"的极端点簇。


### 1.5 计算有界性与非图灵完备性

上述定义直接决定了 IDFS 的**计算论定位**——它在计算能力层级中处于何处。

**定理 1.5（IDFS 的非图灵完备性）**：IDFS 不具备图灵完备性。

**证明**：IDFS $\mathcal{F} = (F, \sigma)$ 的单步执行 $\Phi(x) = \sigma(x)(x)$ 中，$\sigma(x)$ 是 $F^*$ 中的一条有限长链 $p = f_{i_k} \circ \cdots \circ f_{i_1}$（$k \le \mathcal{D}$）。因此 $\Phi$ 的每次求值在至多 $\mathcal{D}$ 步内终止。级联系统 $\mathcal{F}^l$ 的总有效链深 $l \cdot \mathcal{D}$ 仍然有限。

图灵完备系统能够表达**不终止计算**（停机问题的不可判定性即依赖于此）。由于 IDFS 的一切计算在有限步内终止，它无法表达不终止计算，因此不具备图灵完备性。$\square$

> **注（非图灵完备性的根源）**：非图灵完备性源于两条基本约束的联合：(1) $F$ 有限（$|F| = M$），限制了单步计算的多样性；(2) $f$-链深度有界（$k \le \mathcal{D}$），限制了计算的时间展开。二者共同将 IDFS 的计算能力封死在有限自动机与图灵机之间——系统能执行的不同计算总数上界为 $\sum_{k=0}^{\mathcal{D}} M^k$，这是一个有限数。

----
*[IDFS] ⊢ [GLENZLI] ⊢ [Part XX] ⊢ [01-fundamental-definitions] ⊢ [8bb379316504b2bd]*
