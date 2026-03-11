## 逼近误差的上界

### 3.1 组合近似封闭定理（CAC）

**定理（组合近似封闭性，Compositional Approximation Closure，CAC；亦称组合泛化定理，Combinatorial Generalization Theorem，CGT）**：设 IDFS $\mathcal{F} = (F, \sigma)$，$\Phi \in \mathrm{Lip}(\mathcal{X})$（§1.2）。若该基础 IDFS 以容差集 $\mathcal{E}$ 拟合了微观采样集 $\mathcal{S}$（§1.3），则由其诱导出的 $l$-步宏观系统 $\mathcal{F}_l = (F, \sigma_l)$，必将以宏观容差集 $\mathcal{E}^*$ 拟合由 $\mathcal{S}$ 生成的、深度限定为 $l$ 的宏观有效链集 $\mathcal{T}_l$（§1.1）。

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
> 然而 $d(h_{j-1}, x'_j)$ 等于 $e_{j-1} + \delta_j$（近似轨道到采样域最近点的距离），在 $e_{j-1}$ 已经积累较大时，这一距离可以极大，在某些定义域上甚至趋于无穷——导致上界过松以至无意义。若为了让上界有意义而强制要求 $L_j \to 0$（即极强的全局收缩），则由§5 命题 2，系统的长链会将一切状态差异——包括不同输入之间的区分——彻底压平，$\Phi$ 退化为常数映射，近似拟合能力丧失。因此，引入 $h^*_{j-1}$ 将路径拆分为**近似误差传播项**（第一项，权重 $e_{j-1}$）和**采样域偏离项**（第二项，权重 $\delta_j$）是必要的：两项分别被 $L_j$ 缩放，但乘的是各自有控制意义的距离，而非无界的 $d(h_{j-1}, x'_j)$。

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


**推论 1（计算折叠等效，Computational Folding Equivalence）**：设在 $\mathcal{X}_{sub}$ 上存在第 $l$ 阶路由混叠，即存在 $x_1, x_2 \in \mathcal{X}_{sub}$ 使得 $\sigma(x_2) = \sigma_l(x_1)$。则单步系统 $\mathcal{F}$ 在 $x_2$ 处**执行与 $l$ 步宏观系统相同的计算程序**，而该程序的宏观容差由 CAC 定理的 $\mathcal{E}^*$ 控制。由§2 命题 1 推论，组合耗尽保证了路由混叠的必然存在。
> **注（路由混叠与计算时空重叠）**：这是路由混叠的反直觉结构后果。路由映射 $\sigma$ 将空间的不同位置（$x_2$ vs $x_1$）和不同演化深度（单步 vs $l$ 步）映射到**同一条微观计算链**，赋予了 $\Phi$ 一种**计算时空折叠**特征：单步映射在某些输入上的行为，与系统经 $l$ 步迭代后的行为，在计算程序层面完全重合。两者因共享同一条链而共享同一套 CAC 容差界。

**推论 2（宏观容差界 $\mathcal{E}^*$ 的两态行为，Two-Regime Behavior of the Macroscopic Tolerance Bound）**：宏观容差界 $\varepsilon^*_q$ 的两项共享 $\Theta_{j,l}$ 结构，但步骤 $j$ 的权重有差异：$\varepsilon$-项权重为 $\Theta_{j+1,l}$（不含本步 $L_j$），$\delta$-项权重为 $\Theta_{j,l} = L_j \cdot \Theta_{j+1,l}$（含本步 $L_j$）。因此**同一步 $j$ 的微观采样域偏离代价比拟合误差代价高 $L_j$ 倍**：$L_j > 1$（扩张步）时 $\delta$ 惩罚尤为严苛，$L_j < 1$（收缩步）时 $\delta$ 惩罚被折减。两项的主导步 $j^*$ 均不是微观误差绝对值最大者——准确的主导步是使放大后贡献（$\varepsilon_{i_j} \cdot \Theta_{j+1,l}$ 或 $\delta_j \cdot \Theta_{j,l}$）最大的步骤，早期步骤往往占优。

由于 IDFS 是有限系统（有限步长 $l$、有限全局常数 $L$、有限单步误差 $\varepsilon_{max}$、有限偏离 $\delta_{max}$），且 $\Phi^l$ 自身仍然是满足 $L^l$ 约束的 IDFS（§1.2 代数自相似性），宏观容差上界 $\varepsilon^*_q$ **恒为有限数**。更重要的是，由于 §2 命题 5（路由分辨率极限）的绝对物理约束，当误差积累使轨线间距被压缩到 $\sigma$ 的分辨率死锁以下时，系统必然发生**路径合并**——无论 $\bar{L}$ 多大，持续扩张的链路在物理上无法维持，误差增长被系统的有限容量自动截断。因此，从微观容差 $\mathcal{E}$ 跃迁至宏观容差 $\mathcal{E}^*$ 呈现两种物理情形：

**稳定有界（Stable Bounded，$\varepsilon^*_q < D$）**：当路径中扩张与收缩因子相互交织时，误差沿深度 $l$ 逐步积累但始终有限。记 $D \triangleq \mathrm{diam}(\Phi^l(\mathcal{X}))$ 为系统像空间固有直径。由形式 C 保守界：

$$\varepsilon^*_q \;\leq\; (\varepsilon_{max} + \bar{L}\,\delta_{max}) \cdot \frac{\bar{L}^l - 1}{\bar{L} - 1} \;\leq\; D$$

受全局 $L$ 约束和路径合并效应的共同制衡，宏观容差 $\varepsilon^*_q$ 始终被锁定在 $D$ 以内。积累速率取决于路径 Lipschitz 序列 $\{L_j\}$ 的具体结构。该态是 IDFS 在一般混合路径下的**默认运行模式**。

**收敛饱和（Saturated，$\Lambda_\infty < \infty$）**：若路径具备充分强的收缩势能，使得截断尾积级数收敛（见推论 5），宏观容差界被一个**与深度 $l$ 完全无关的有限常数**绝对封顶：

$$\varepsilon^*_q \;\leq\; \varepsilon_{max} \cdot \Lambda_\infty \;+\; \delta_{max} \cdot \Gamma_\infty \;\triangleq\; B_{sat} \;<\; \infty$$

此时系统呈现出"任意深度逻辑链免疫力"，微观组件被安全地镶嵌在大尺度吸引域内。

> **注（上界有限 $\neq$ 拟合质量好）**：$\varepsilon^*_q \leq B_{sat}$ 是关于误差**不发散**的保证，而非关于拟合精度的承诺。$B_{sat}$ 刻画的是系统的**最差情形天花板**——对于任何在此范围内的目标，系统都不会崩溃。但这并不排除误差在 $B_{sat}$ 附近甚至恰好等于 $B_{sat}$ 的情形大面积出现。换言之，饱和是一种**稳定性声明**（系统不爆炸），而非**拟合性声明**（系统拟合得好）。事实上，§4 的 CAB 下界将证明：在收缩主导的饱和体制下，系统对**高变分目标**的拟合误差存在不可消去的正下界，且 §6 将进一步揭示，饱和所必需的收缩步恰恰是拟合代价最高的步骤。饱和态系统的精确图景是**稳定但平庸**——以主动放弃高频变分追踪为代价换取端到端有界性。

> **注（物理直径封顶，Diameter Capping）**：CAC 定理给出的 $\varepsilon^*_q$ 是代数上界，而 IDFS 像集的全有界性（§1.2）提供了一个独立于 CAC 的**绝对物理天花板**：端到端误差不可能超越系统像空间的固有直径 $D = \mathrm{diam}(\Phi^l(\mathcal{X}))$。两个独立上界取交，给出系统的**有效误差界**：
> $$e_l \;\leq\; \min\!\bigl(\varepsilon^*_q,\; D\bigr)$$
> 当 CAC 代数上界超过 $D$ 时（扩张路径），物理直径接管约束权；当 CAC 代数上界远低于 $D$ 时（收缩路径），CAC 界提供实质更紧的保证。

> **注（路径跨度 $\kappa_\Phi$ 与 CAC 界松紧度）**：CAC 的保守简化形式（形式 C）以全局 $L$ 替换所有局部 $L_j$，其松弛程度直接受 §1.2 定义的路径 Lipschitz 跨度 $\kappa_\Phi = \sup L_j / \inf L_j$ 调控。当 $\kappa_\Phi \to 1$（均匀路径），形式 C 与精细界几乎吻合——保守简化几乎无损。当 $\kappa_\Phi \gg 1$（高度异质路径，典型的大规模 IDFS 如大语言模型），$L_{max}$ 远超大多数步的实际 $L_j$，保守界严重高估误差。此时系统的**实际泛化能力远优于理论悲观预测**，精细界（形式 A）或几何均值 $\bar{L}$ 估计（见推论 4a）方能揭示真实表现。

---

CAC 定理给出了链误差的代数上界。一个自然的问题是：这个上界是否可能过于松弛？以下推论以存在性构造证明**上界中的每一项都可以被精确取等**——CAC 界在整个 IDFS 函数类上是不可改善的。

**推论 3（宏观容差集的类紧性，Class-Level Tightness of the Macroscopic Tolerance Set）**：对任意给定的微观采样集 $\mathcal{S}$ 及其容差集 $\mathcal{E}$（由任意给定序列 $\varepsilon_{i_j} \geq 0$ 决定），以及任意给定的偏离序列 $\delta_j \geq 0$ 和 Lipschitz 序列 $\{L_j\}_{j=1}^l$，**一定存在**某个以 $\mathcal{E}$ 拟合了 $\mathcal{S}$ 的具体 IDFS 构造 $(F, \sigma)$，使得在由 $\mathcal{S}$ 生成的某段宏观链 $q \in \mathcal{T}_l$ 上，其端到端逼近误差精确填满了宏观容差上界 $\varepsilon^*_q \in \mathcal{E}^*$：

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

确立了 CAC 界的紧性后，接下来从中提取几个关键的操作性推论——将代数上界转化为对链深、收敛性等工程参数的显式约束。

**推论 4（保底可靠链深，Guaranteed Safe Chain Depth）**：若要求系统在生成的宏观链上不发生泛化崩溃，即要求宏观容差集 $\mathcal{E}^*$ 中的元素被严格界定在安全阈值 $\tau > 0$ 内（$\varepsilon^*_q \leq \tau$），则相应的宏观有效链集 $\mathcal{T}_l$ 必须在逻辑深度上实施截断（即限制最大推导步数 $l$）。

记 $L_{max} \triangleq \sup_j L_j$（即 §1.2 路径 Lipschitz 常数的上确界，由系统要求 $L_j \leq L$，恒有 $L_{max} \leq L$）。利用 $\Gamma_l \leq L_{max}\,\Lambda_l$，确保 $\varepsilon^*_q \leq \tau$ 的充分条件合并为：

$$(\varepsilon_{\max} + L_{max}\,\delta_{\max})\cdot\Lambda_l \;\leq\; \tau$$

再利用 $\Lambda_l \leq \dfrac{L_{max}^l - 1}{L_{max} - 1}$，对 $L_{max} > 1$ 显式求解，给出**保底可靠链深**：

$$l^* \;=\; \left\lfloor \frac{\log\!\left(1 + \dfrac{\tau(L_{max}-1)}{\varepsilon_{\max} + L_{max}\,\delta_{\max}}\right)}{\log L_{max}} \right\rfloor$$

即：任意长度 $\leq l^*$ 的链均保证 $e_l \leq \tau$。

$L_{max} = 1$ 时退化为线性：$l^* = \lfloor \tau/(\varepsilon_{\max}+\delta_{\max}) \rfloor$。

**证明**：

**第一步（合并两项）**：由 $L_{max} = \sup_j L_j$，对每项有 $L_j \Theta_{j+1,l} \leq L_{max}\,\Theta_{j+1,l}$，故：

$$\Gamma_l = \sum_{j=1}^l L_j \Theta_{j+1,l} \;\leq\; L_{max} \sum_{j=1}^l \Theta_{j+1,l} = L_{max}\,\Lambda_l$$

代入充分条件：

$$\varepsilon_{\max}\,\Lambda_l + \delta_{\max}\,\Gamma_l \;\leq\; \varepsilon_{\max}\,\Lambda_l + \delta_{\max}\cdot L_{max}\,\Lambda_l = (\varepsilon_{\max} + L_{max}\,\delta_{\max})\,\Lambda_l \;\leq\; \tau$$

**第二步（约束 $\Lambda_l$）**：上式等价于：

$$\Lambda_l \;\leq\; \frac{\tau}{\varepsilon_{\max} + L_{max}\,\delta_{\max}}$$

**第三步（对 $l$ 求解显式下界）**：由 $\Theta_{j+1,l} \leq L_{max}^{l-j}$，故：

$$\Lambda_l = \sum_{j=1}^l \Theta_{j+1,l} \;\leq\; \sum_{j=1}^l L_{max}^{l-j} = \frac{L_{max}^l - 1}{L_{max} - 1} \qquad (L_{max} > 1)$$

要使 $(L_{max}^l-1)/(L_{max}-1) \leq \tau/(\varepsilon_{\max}+L_{max}\delta_{\max})$，即 $L_{max}^l \leq 1 + \tau(L_{max}-1)/(\varepsilon_{\max}+L_{max}\delta_{\max})$，取对数解 $l$ 的最大整数：

$$l^* = \left\lfloor \frac{\log\!\left(1 + \dfrac{\tau(L_{max}-1)}{\varepsilon_{\max} + L_{max}\,\delta_{\max}}\right)}{\log L_{max}} \right\rfloor$$

由构造，任意长度 $\leq l^*$ 的链均满足 $(\varepsilon_{\max}+L_{max}\delta_{\max})\Lambda_l \leq \tau$，进而由 CAC 定理保证 $e_l \leq \tau$。$\square$

> **注**：$l^*$ 仅依赖三个标量 $\varepsilon_{\max}$、$\delta_{\max}$、$L_{max}$，先验可计算。分母 $\varepsilon_{\max} + L_{max}\,\delta_{\max}$ 即**有效单步误差**（近似误差与放大一次的采样域偏离代价之和，呼应 CAC 主定理形式B）。$L_{max}$ 取路径局部最大而非全局 $L$，结合保守的 $\Lambda_l$ 上界，$l^*$ 通常是悲观估计。

**推论 4a（路径感知安全深度，Path-Aware Safe Depth）**：若已知具体路径的几何均值 $\bar{L}$（§1.2），则对 $\bar{L} > 1$，安全深度可收紧为：

$$l^*_{\bar{L}} \;=\; \left\lfloor \frac{\log\!\left(1 + \dfrac{\tau(\bar{L}-1)}{\varepsilon_{\max} + \bar{L}\,\delta_{\max}}\right)}{\log \bar{L}} \right\rfloor$$

由 $\bar{L} \leq L_{max}$（均值 $\leq$ 极值），恒有 $l^*_{\bar{L}} \geq l^*$。当路径中大量收缩步将几何均值拉低到远小于 $L_{max}$ 时（即 $\kappa_\Phi \gg 1$ 的高异质路径），$l^*_{\bar{L}} \gg l^*$——系统实际可安全走的深度远超保守估计。$\bar{L} < 1$ 时安全深度不受限（对应推论 5 的饱和态）。


**推论 5（宏观容差集的收缩有界性，Boundedness of $\mathcal{E}^*$ under Contraction）**：记 $\Theta_{j,\infty} \triangleq \lim_{l\to\infty} \Theta_{j,l} = \prod_{k=j}^{\infty} L_k$（当极限存在时）。若局部收缩足够强导致累积系数收敛：

$$\Lambda_\infty \;\triangleq\; \sum_{j=1}^{\infty} \Theta_{j+1,\infty} \;<\; \infty \qquad \text{且} \qquad \Gamma_\infty \;\triangleq\; \sum_{j=1}^{\infty} \Theta_{j,\infty} \;<\; \infty$$

则不论微观集 $\mathcal{S}$ 生成的有效链集 $\mathcal{T}_\infty$ 有多庞大（甚至包含无限长链极限），其诱导的整个**宏观容差集 $\mathcal{E}^*$ 必然是一致有界的**（Uniformly Bounded）：对任意长链 $q \in \mathcal{T}_\infty$，

$$\varepsilon^*_q \;\leq\; \varepsilon_{\max} \cdot \Lambda_\infty \;+\; \delta_{\max} \cdot \Gamma_\infty \;<\; \infty$$

即：在强收缩下，由有限微观容差（$\mathcal{E}$）爆发出的无限组合宏观误差（$\mathcal{E}^*$）被强制封顶。系统展现出对任意长逻辑组合的"无限泛化免疫力"。

> **注（$l \to \infty$ 极限的合法性）**：虽然 IDFS 是有限系统，但此处取 $l \to \infty$ 在物理上是合法的。推论 5 的前提条件要求收缩步主导（$\Theta_{j,l} \to 0$），而收缩路径不触发任何物理截断机制——系统只是将轨线越拉越近，不涉及 §2 命题 5 的分辨率死锁或路径合并（后者仅约束扩张行为）。因此，无限长收缩链的极限分析在 IDFS 框架内是完全自洽的。

**证明**：由 CAC 定理精细界（形式 A）：

$$e_l \;\leq\; \varepsilon_{\max}\cdot\Lambda_l \;+\; \delta_{\max}\cdot\Gamma_l$$

由 $\Lambda_l \nearrow \Lambda_\infty$ 和 $\Gamma_l \nearrow \Gamma_\infty$（两个级数均单调递增趋向各自极限），故 $e_l \leq \varepsilon_{\max}\cdot\Lambda_\infty + \delta_{\max}\cdot\Gamma_\infty$。$\square$

> **注（允许局部扩张；$\Gamma_\infty$ 与 $\Lambda_\infty$ 同阶）**：推论 5 不要求 $L_j < 1$ 逐步成立——即使某些步存在 $L_j > 1$（局部扩张），只要后续有足够强的收缩步将尾部乘积压平，$\Lambda_\infty$ 仍然有限。此外，由 $\Gamma_\infty = \sum_j L_j \Theta_{j+1,\infty} \leq L_{max} \cdot \Lambda_\infty$，而 §1.2 系统要求保证 $L_j \leq L < \infty$ 恒成立（即 $L_{max} \leq L$ 自动有界），故 $\Lambda_\infty < \infty$ 自动蕴含 $\Gamma_\infty < \infty$，条件可合并为单一的 $\Lambda_\infty < \infty$。

**路径均值特例（$\bar{L} < 1$）**：收缩饱和**不要求**全局 $L < 1$——即使系统在某些步具有 $L_j > 1$（局部扩张），只要路径的几何均值 $\bar{L} < 1$（§1.2），尾积便以指数速率衰减，保证 $\Lambda_\infty < \infty$。此时饱和界为：

$$e_l \;\leq\; \frac{\varepsilon_{\max} + \bar{L}\,\delta_{\max}}{1 - \bar{L}}$$

这比全局 $L < 1$ 的要求宽松得多——系统允许存在局部的剧烈拉伸，只要在整条路径的统计平均意义上呈现净收缩即可。

**保守特例（全局 $L < 1$）**：若 $\Phi \in \mathrm{Lip}_L$ 且 $L < 1$，则 $L_j \leq L$，$\bar{L} \leq L$，故：

$$\Lambda_\infty \leq \frac{1}{1-L}, \qquad \Gamma_\infty \leq \frac{L}{1-L}$$

退化为保守界：

$$e_l \;\leq\; \frac{\varepsilon_{\max} + L\,\delta_{\max}}{1-L}$$

分子即**有效单步误差**（呼应形式B），分母为收缩余量 $(1-L)$。注意路径均值特例严格弱于此条件：$\bar{L} < 1$ 允许存在 $L > 1$ 的系统，只要路径平均收缩即可饱和。

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


### 3.2 统计精化界与漂移-扩散定律

在 3.1 节的组合近似封闭定理（CAC）中，我们得出了宏观误差随链长的级联增长上界。由推论 2（两态行为），该上界在 IDFS 的有限系统约束下始终有限，呈现**稳定有界**或**收敛饱和**两种物理情形——前者误差沿深度积累但被系统直径封顶，后者误差收敛至与深度无关的常数。

> **注（$\mathcal{O}$ 记号）**：本文中 $\mathcal{O}$ 采用分析学标准定义：$f = \mathcal{O}(g)$ 表示存在常数 $C > 0$ 使得 $|f| \leq C|g|$，用以描述函数的渐近增长阶或衰减阶。
CAC 界是纯确定性的——它对 $\mathcal{X}$ 的几何结构和误差序列的统计性质不做任何假设，因此代价是最保守的。本节将逐步引入空间几何与时间相关性两个维度的假设，**层层收紧** CAC 界，最终抵达理论极限。

#### 前提：空间几何参数与时间相关性参数

**定义（type-$p$ 空间参数）**：设 $\mathcal{X}$ 的局部切空间具有 Banach 空间结构，其 **type 指数** $p \in [1, 2]$ 刻画了空间对独立随机向量叠加的对消能力。type-$p$ 不等式保证：对零均值独立随机向量 $\{v_j\}$，

$$\mathbb{E}\!\left[\left\|\sum_j v_j\right\|^p\right] \;\leq\; T_p^p \cdot \sum_j \mathbb{E}\!\left[\|v_j\|^p\right]$$

其中 $T_p$ 为空间的 type 常数。$p = 1$ 对应一般度量空间（无对消），$p = 2$ 对应希尔伯特空间（完全正交对消）。

**定义（有效相关长度 $\tau_c$）**：设系统在第 $j$ 步的微观逼近误差（在切空间局部展开）为随机向量 $\epsilon_j$，$\mathbb{F}_{j-1}$ 为系统前 $j-1$ 步演化生成的历史完备信息（$\sigma$-代数）。定义**有效相关长度** $\tau_c \geq 1$ 为使得 $|i - j| > \tau$ 时 $\epsilon_i$ 与 $\epsilon_j$ 近似独立的最小间隔。$\tau_c = 1$ 对应完全独立（鞅差序列），$\tau_c = l$ 对应完全相关。

> **注**：$\tau_c = 1$ 且 $\mathbb{E}[\epsilon_j \mid \mathbb{F}_{j-1}] = 0$ 即满足鞅差序列假设（Martingale Difference Sequence，MDS）。在一般工程现实中，有限容量的拟合系统通常无法严格满足 MDS；但在纯粹的理论极限下，满足 MDS 的系统等价于在**无偏先验（Unbiased Prior）**下的**最优贝叶斯估计器（Optimal Bayesian Estimator）**，其每次外推仅受内禀信息熵的不确定性限制。

#### 定理（统计精化界，The Statistical Refinement Bound，SRB）

**定理**：设 IDFS $\mathcal{F} = (F, \sigma)$ 的度量空间 $\mathcal{X}$ 的局部切空间为 type-$p$ Banach 空间（$1 \leq p \leq 2$），系统演化误差序列 $\{\epsilon_j\}$ 的有效相关长度为 $\tau_c$，局部线性化算子 $T_{j,l} = \prod_{k=j+1}^l D\Phi(h_{k-1})$ 的算子范数受限于 $\Theta_{j,l}$。则宏观演化 $l$ 步后的总误差满足：

$$\|E_l\| \;\sim\; \mathcal{O}\!\left(\tau_c^{1-1/p} \cdot l^{1/p}\right)$$

**证明精要**：将 $l$ 步误差序列分为 $\lfloor l/\tau_c \rfloor$ 个长度为 $\tau_c$ 的块。块内误差可相干叠加（最坏情况），每块误差 $\sim \mathcal{O}(\tau_c)$。块间近似独立，在 type-$p$ 空间中对 $\lfloor l/\tau_c \rfloor$ 个独立块应用 type-$p$ 不等式，得块间叠加 $\sim \mathcal{O}((l/\tau_c)^{1/p})$。两者合成：$\mathcal{O}(\tau_c \cdot (l/\tau_c)^{1/p}) = \mathcal{O}(\tau_c^{1-1/p} \cdot l^{1/p})$。$\square$

> **注（退化验证）**：
> - $(p = 2,\, \tau_c = 1)$：$\mathcal{O}(1^{1/2} \cdot l^{1/2}) = \mathcal{O}(\sqrt{l})$，退化为理想统计界（下方推论）。
> - $(p = 1,\, \tau_c = l)$：$\mathcal{O}(l^{0} \cdot l) = \mathcal{O}(l)$，退化为 CAC 界。
> - $(p = 1,\, \tau_c = 1)$：$\mathcal{O}(1^{0} \cdot l) = \mathcal{O}(l)$，一般空间即使独立也无正交对消。
> - $(p = 2,\, \tau_c = l)$：$\mathcal{O}(l^{1/2} \cdot l^{1/2}) = \mathcal{O}(l)$，希尔伯特空间但完全相关也无对消。

#### 推论（理想统计界，The Statistical Ideal Bound，SIB）

**推论**：若 $\mathcal{X}$ 局部同胚于希尔伯特空间（$p = 2$）且误差满足鞅差序列假设（$\tau_c = 1$），则统计精化界退化为：

$$\sqrt{\mathbb{E}[\|E_l\|^2]} \;\leq\; \sqrt{ \sum_{j=1}^l \left( \Theta_{j,l} \cdot \sqrt{\mathbb{E}[\|\epsilon_j\|^2]} \right)^2 }$$

**证明**：在 $p = 2$（希尔伯特空间）下，$\epsilon_j$ 零均值且 $\tau_c = 1$（逐步独立），经确定性线性算子映射后的误差序列 $\{T_{j,l}(\epsilon_j)\}$ 在切空间中保持正交，即 $\mathbb{E}[\langle T_{i,l}(\epsilon_i), T_{j,l}(\epsilon_j) \rangle] = 0 \quad (\forall i \neq j)$。根据 Bienaymé 等式，总误差的平方期望等于各部分误差平方期望之和。取算子范数放缩 $\|T_{j,l}\| \leq \Theta_{j,l}$，两边开均方根，得证。$\square$

> **注**：SIB 是统计精化界在 $(p, \tau_c)$ 参数空间中的**极端理想点**——它同时要求空间具备最强的正交对消能力（Hilbert）和误差具备最弱的时间相关性（完全独立），因此给出了最紧的渐近阶 $\mathcal{O}(\sqrt{l})$。这是动力学系统在多步迭代下泛化误差的**绝对涨落底线**。

#### 推论（漂移-扩散定律，Drift-Diffusion Law）

**推论**：在一般系统中，受限于微观基函数集 $F$ 的局部结构偏置以及有效采样覆盖的有限性，系统的单步误差演化通常无法自发满足严格的 MDS 假设。单步误差向量必定包含一个系统性的方向偏置（Drift）。将真实误差 $\epsilon_j$ 进行正交分解：

$$\epsilon_j \;=\; \mu_j \;+\; \eta_j$$

其中：
- $\mu_j \triangleq \mathbb{E}[\epsilon_j \mid \mathbb{F}_{j-1}]$ 为系统性偏置向量（Drift）；
- $\eta_j$ 为零均值的纯随机噪声向量（Diffusion）。

代入线性化演化积分，宏观总误差被分解为两项：

$$\mathbb{E}[\|E_l\|^2] \;\approx\; \underbrace{ \left\| \sum_{j=1}^l T_{j,l}(\mu_j) \right\|^2 }_{\text{系统漂移项：} \mathcal{O}(l^2)} \;+\; \underbrace{ \sum_{j=1}^l \mathbb{E}\left[ \|T_{j,l}(\eta_j)\|^2 \right] }_{\text{随机扩散项：} \mathcal{O}(\tau_c^{2-2/p} \cdot l^{2/p})}$$

开方后，系统的泛化总误差呈现为漂移-扩散动力学形式：

$$Error_{total} \;\sim\; \underbrace{\mathcal{O}(l) \cdot \|\mu_{bias}\|}_{\text{漂移（不可压缩）}} \;+\; \underbrace{\mathcal{O}\!\left(\tau_c^{1-1/p} \cdot l^{1/p}\right) \cdot \|\eta_{noise}\|}_{\text{扩散（空间几何 × 时间相关性）}}$$

> **注（漂移-扩散的不对称性）**：漂移项始终以 $\mathcal{O}(l)$ 线性增长——这是确定性相干叠加的必然结果，与空间几何和时间相关性均无关。因此，包含强系统性漂移（$\mu_{bias} \neq 0$）的系统必然坠入 CAC 灾难界。空间几何参数 $p$ 和时间相关长度 $\tau_c$ **仅能改善噪声项的涨落底线**，而无法触及漂移项——后者的消除必须依赖外部的对抗或校验机制。

