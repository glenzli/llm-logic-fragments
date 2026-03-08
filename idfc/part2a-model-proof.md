# IDFC · Part 2a：数学建模与 CAC 定理证明

> **前置**：见 [Part 1 导论](part1-intro.md) 了解非正式动机与预测概览。
>
> **本文内容**：§1 形式定义（元组度量空间 $\mathcal{X} = V_1 \times \cdots \times V_N$、变换空间 $\Omega$、有限规则集 $R$；**IDFS 泛化定义** $(F,\sigma)$——纯抽象理论，不预设神经网络）；§2 核心假说 CAC 的严格抽象陈述；§3 定理完整证明（Telescope 展开 + UAT 补充 + TSC 框架）。神经网络的具体代数实例化见 [**Part 2c**](part2c-nn-algebraic.md)。
>
> **后续**：[Part 3](part3-deductions.md) 从本文定理推导全部推论；[Part 4](part4-empirical.md) 以 Transformer/Mamba/MoE 等架构分析与多组实验场景（幻觉、ICL、量化、Reversal Curse、Sycophancy 等）验证并锚定本文理论预测。

---

## 第一部分：数学模型的构造

## 1. 基本设定

### 1.1 元组度量空间与变换空间

设 $N \geq 1$ 为**维度数**。对每个维度 $k \in [N] \triangleq \{1, \ldots, N\}$，设 $(V_k, d_k)$ 为度量空间。在 $V_k$ 之外引入一个**缺失标记**（absent marker）$\bot_k \notin V_k$，令 $V_k^{\bot} \triangleq V_k \cup \{\bot_k\}$（$\bot_k$ 表示该维度位置"不存在"，与 $V_k$ 内部的任何代数零点无关）。

定义**元组空间**：

$$\mathcal{X} \;=\; V_1^{\bot} \times V_2^{\bot} \times \cdots \times V_N^{\bot}$$

其元素为 $N$ 维元组 $x = (v_1, v_2, \ldots, v_N)$，$v_k \in V_k^{\bot}$（$v_k = \bot_k$ 表示该维度位置"不存在"）。$\mathcal{X}$ 上配以**积度量**（仅对 $v_k \in V_k$ 的分量计算；含 $\bot_k$ 的分量视为不参与比较）：

$$d(x, y) \;=\; \Bigl(\sum_{k:\, v_k,w_k \in V_k} d_k(v_k, w_k)^p\Bigr)^{1/p}, \qquad 1 \leq p \leq \infty$$

（$p = \infty$ 时退化为 $d(x, y) = \max_{k:\, v_k,w_k \in V_k}\, d_k(v_k, w_k)$。）$(\mathcal{X}, d)$ 构成度量空间。



定义**变换空间**：

$$\Omega = \{ \phi : \mathcal{X} \to \mathcal{X} \}$$

对 $\phi \in \Omega$，定义其**定义域**为使 $\phi$ 产生非空输出的全部输入：

$$\mathrm{dom}(\phi) \;\triangleq\; \bigl\{\, x \in \mathcal{X} \;\big|\; \phi(x) \neq \bot \,\bigr\}$$

其中 $\bot = (\bot_1, \ldots, \bot_N)$ 为 $\mathcal{X}$ 的**全缺失元**（所有分量均为缺失标记）。$\phi(x) = \bot$ 表示 $\phi$ 在 $x$ 处无输出（"不适用"），$\mathrm{dom}(\phi)$ 即 $\phi$ 实际发生作用的输入集合。

$\Omega$ 在函数复合下构成**幺半群**：$\phi_2 \circ \phi_1 \in \Omega$，$\mathrm{id}_{\mathcal{X}} \in \Omega$。

设 $R = \{r_1, r_2, \ldots, r_m\} \subset \Omega$ 为 $\Omega$ 的一个有限子集。

$R^*$ 为 $R$ 在复合运算下的**自由幺半群**：

$$R^* = \{ r_{i_k} \circ \cdots \circ r_{i_1} \mid k \geq 0,\ r_{i_j} \in R \}$$

$R^*$ 中长度为 $l$ 的元素 $q = r_{i_l} \circ \cdots \circ r_{i_1}$ 称为 **$r$-链**（$r$-chain），$l$ 为其**长度**（$l = 0$ 对应幺元 $\mathrm{id}_{\mathcal{X}}$）。

设 $\mathcal{S}$ 为 $R$ 的一次**采样**（sampling of $R$）：对每条规则 $r \in R$，指定其**采样域** $\mathcal{X}(r) \subseteq \mathrm{dom}(r)$，即在 $r$ 的定义域中选取的一个子集（一般有 $\mathcal{X}(r) \subsetneq \mathrm{dom}(r)$）。形式上：

$$\mathcal{S} \;=\; \bigl\{\, (r,\, \mathcal{X}(r)) \;\big|\; r \in R,\; \mathcal{X}(r) \subseteq \mathrm{dom}(r) \,\bigr\}$$

设 $\mathcal{T}$ 为 $\mathcal{S}$ 生成的**有效链集**（Valid Chain Set）：

$$\mathcal{T} = \bigl\{\, q \in R^* \;\big|\; \mathrm{dom}(q) \neq \emptyset \,\bigr\}$$

$\mathcal{T}$ 即 $R^*$ 中所有**定义域非空**的 $r$-链：每个 $q \in \mathcal{T}$ 的输入域为 $\mathrm{dom}(q)$，由 $q$ 的映射行为完全决定。


### 1.2 输入驱动函数系统（IDFS）

**定义（输入驱动函数系统，Input-Driven Function System，IDFS）**：称有序对 $(F, \sigma)$ 为**输入驱动函数系统**，其中：

1. **函数集** $F = \{f_1, f_2, \ldots, f_M\}$：$\mathcal{X}$ 上有限个函数的集合，$M = |F|$ 为函数集的大小。

2. **选择映射** $\sigma : \mathcal{X} \to F^*$：将当前输入 $x$ 映射到 $F$ 上的一个可变长度复合 $\sigma(x) = f_{i_k} \circ \cdots \circ f_{i_1}$（$k \geq 1$），表示对该输入应执行的完整计算计划。

对初始点 $x \in \mathcal{X}$，$\sigma(x)$ 确定哪条链，执行该链即完成一次**计算步骤**，引入记号 $\Phi: \mathcal{X} \to \mathcal{X}$ 表达其结果：

$$\Phi(x) \;\triangleq\; \sigma(x)(x)$$

即 $\Phi(x) = \sigma(x)(x) = f_{i_k}(\cdots f_{i_1}(x) \cdots)$。

> **注**：对不同的 $x \in \mathcal{X}$，$\sigma(x)$ 可选择不同的链，链长 $k$ 也可不同。

**系统要求（单步 Lipschitz 约束）**：$(F, \sigma)$ 须满足 $\Phi \in \mathrm{Lip}_L(\mathcal{X})$，即：

$$d\bigl(\Phi(x),\, \Phi(y)\bigr) \leq L \cdot d(x, y) \quad \forall\, x, y \in \mathcal{X}$$



### 1.3 单步近似误差

**定义（单步近似误差）**：设 $(r_i, \mathcal{X}(r_i)) \in \mathcal{S}$。定义 $\Phi$ 在 $\mathcal{X}(r_i)$ 上对 $r_i$ 的**逐点近似误差**为：

$$\varepsilon_i \;\triangleq\; \sup_{x \in \mathcal{X}(r_i)} \bigl\|\Phi(x) - r_i(x)\bigr\|$$

记 $\varepsilon_{\max} = \max_{(r_i,\, \mathcal{X}(r_i)) \in \mathcal{S}}\, \varepsilon_i$。


---

## 2. CAC 定理

**定理（组合近似封闭性，Compositional Approximation Closure，CAC；亦称组合泛化定理，CGT）**：设 $(F, \sigma)$ 为 IDFS，$\Phi \in \mathrm{Lip}(\mathcal{X})$（§1.2）；设 $\mathcal{S}$ 为 $R$ 的一次采样（§1.1），各步单步近似误差为 $\varepsilon_{i_j}$（§1.3）。

对任意 $q \in \mathcal{T}$（其中 $q = r_{i_l} \circ \cdots \circ r_{i_1}$，长度为 $l$）和 $x \in \mathrm{dom}(q)$，定义**理想轨道**与**近似轨道**：

$$h^*_0 = x, \quad h^*_j = r_{i_j}(h^*_{j-1}) \qquad \text{（理想轨道，沿 }r\text{-链执行）}$$
$$h_0 = x, \quad h_j = \Phi(h_{j-1}) \qquad \text{（近似轨道，沿 }\Phi\text{ 执行）}$$

记 $e_j = \|h_j - h^*_j\|$（第 $j$ 步误差），$e_0 = 0$。记 $L_j \triangleq \mathrm{Lip}(\Phi\!\restriction_{(h_{j-1},\, h^*_{j-1})})$ 为第 $j$ 步的**路径局部 Lipschitz 常数**。记**尾部乘积**：

$$P_{j,l} \;\triangleq\; \prod_{k=j}^{l} L_k \qquad \text{（$j > l$ 时约定空积 $P_{j,l} = 1$）}$$

定义**误差累积放大系数**与**偏离累积放大系数**：

$$\Lambda_l \;\triangleq\; \sum_{j=1}^{l} P_{j+1,l}\,, \qquad \Gamma_l \;\triangleq\; \sum_{j=1}^{l} P_{j,l}$$

（关系：$\Gamma_l = \sum_{j=1}^l L_j P_{j+1,l}$；若 $\Phi \in \mathrm{Lip}_L$，则 $\Gamma_l \leq L\Lambda_l$。）

对每步 $j$，记 $\delta_j \triangleq d\!\bigl(h^*_{j-1},\, \mathcal{X}(r_{i_j})\bigr)$ 为理想轨道第 $j-1$ 步距采样域 $\mathcal{X}(r_{i_j})$ 的偏离距离。则 f-链终值误差满足：

$$\bigl\|h_l - q(x)\bigr\| \;\leq\; \sum_{j=1}^{l} \varepsilon_{i_j} \cdot P_{j+1,l} \;+\; \sum_{j=1}^{l} \delta_j \cdot P_{j,l}$$

**证明**：第 $j$ 步，取 $x'_j \in \mathcal{X}(r_{i_j})$ 为距 $h^*_{j-1}$ 最近的采样域点（$d(h^*_{j-1}, x'_j) = \delta_j$）。

由 $h_j = \Phi(h_{j-1})$，$h^*_j = r_{i_j}(h^*_{j-1})$，误差为：

$$e_j = \bigl\|\Phi(h_{j-1}) - r_{i_j}(h^*_{j-1})\bigr\|$$

插入两个中间点 $\Phi(h^*_{j-1})$ 和 $\Phi(x'_j)$，由三角不等式得：

$$e_j \;\leq\; \bigl\|\bigl(\Phi(h_{j-1}) - \Phi(h^*_{j-1})\bigr) + \bigl(\Phi(h^*_{j-1}) - \Phi(x'_j)\bigr) + \bigl(\Phi(x'_j) - r_{i_j}(x'_j)\bigr)\bigr\|$$

> **注（三项拆分的必要性）**
>
> **关于第三项**：$\varepsilon_{i_j}$ 的定义（§1.3）仅保证 $\Phi$ 在采样域 $\mathcal{X}(r_{i_j})$ 内对 $r_{i_j}$ 的误差受控。$x'_j \in \mathcal{X}(r_{i_j})$ 是采样域内最近点，故第三项 $\leq \varepsilon_{i_j}$；若直接用 $h^*_{j-1}$（可能在采样域外），无法套用 $\varepsilon_{i_j}$ 的界——这正是引入 $x'_j$ 并显式产生偏离代价 $\delta_j$ 的原因。
>
> **关于前两项为何不合并**：一个自然的替代是不引入 $h^*_{j-1}$ 作为中间点，而是直接对第一项和第二项合并，利用 $L$ 条件写：
>
> $$\bigl\|\Phi(h_{j-1}) - \Phi(x'_j)\bigr\| \;\leq\; L_j \cdot d(h_{j-1},\, x'_j)$$
>
> 然而 $d(h_{j-1}, x'_j)$ 等于 $e_{j-1} + \delta_j$（近似轨道到采样域最近点的距离），在 $e_{j-1}$ 已经积累较大时，这一距离可以极大，在某些定义域上甚至趋于无穷——导致上界过松以至无意义。若为了让上界有意义而强制要求 $L_j \to 0$（即极强的全局收缩），则由推论 3b，系统的长链会将一切状态差异——包括不同输入之间的区分——彻底压平，$\Phi$ 退化为常数映射，近似拟合能力丧失。因此，引入 $h^*_{j-1}$ 将路径拆分为**近似误差传播项**（第一项，权重 $e_{j-1}$）和**采样域偏离项**（第二项，权重 $\delta_j$）是必要的：两项分别被 $L_j$ 缩放，但乘的是各自有控制意义的距离，而非无界的 $d(h_{j-1}, x'_j)$。

分别定界：

$$e_j \;\leq\; \underbrace{\bigl\|\Phi(h_{j-1}) - \Phi(h^*_{j-1})\bigr\|}_{\leq\, L_j \cdot e_{j-1}} \;+\; \underbrace{\bigl\|\Phi(h^*_{j-1}) - \Phi(x'_j)\bigr\|}_{\leq\, L_j \cdot \delta_j} \;+\; \underbrace{\bigl\|\Phi(x'_j) - r_{i_j}(x'_j)\bigr\|}_{\leq\, \varepsilon_{i_j}}$$

递推关系：$e_j \leq L_j e_{j-1} + L_j\delta_j + \varepsilon_{i_j}$，$e_0 = 0$。逐步展开前三步：

$$e_1 \leq \varepsilon_{i_1} + L_1\delta_1$$
$$e_2 \leq L_2 e_1 + (\varepsilon_{i_2} + L_2\delta_2) \leq (\varepsilon_{i_1} + L_1\delta_1)\cdot L_2 + (\varepsilon_{i_2} + L_2\delta_2)$$
$$e_3 \leq L_3 e_2 + (\varepsilon_{i_3} + L_3\delta_3) \leq (\varepsilon_{i_1} + L_1\delta_1)\cdot L_3L_2 + (\varepsilon_{i_2} + L_2\delta_2)\cdot L_3 + (\varepsilon_{i_3} + L_3\delta_3)$$

第 $j$ 步新增项 $(\varepsilon_{i_j} + L_j\delta_j)$ 在后续各步中被乘以 $P_{j+1,l}$，归纳得：

$$e_l \;\leq\; \sum_{j=1}^{l}\Bigl(\varepsilon_{i_j} + L_j\delta_j\Bigr)\cdot P_{j+1,l}$$

分离两项，利用 $L_j \cdot P_{j+1,l} = P_{j,l}$：

$$e_l \;\leq\; \sum_{j=1}^{l}\varepsilon_{i_j}\cdot P_{j+1,l} \;+\; \sum_{j=1}^{l}\delta_j\cdot P_{j,l}$$

> **保守简化**：精细界可退化为以下三种等价可用的简化形式：
>
> **形式 A（均匀化各步误差）**：令 $\varepsilon_{\max} \triangleq \max_j \varepsilon_{i_j}$，$\delta_{\max} \triangleq \max_j \delta_j$：
>
> $$e_l \;\leq\; \varepsilon_{\max}\cdot\Lambda_l \;+\; \delta_{\max}\cdot\Gamma_l$$
>
> **形式 B（均匀化路径放大系数）**：以全局 $L$ 替换局部 $L_j$（$P_{j+1,l} \leq L^{l-j}$，$P_{j,l} \leq L^{l-j+1}$），各步 $\varepsilon_{i_j}$、$\delta_j$ 保持异质：
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

**推论 0（误差放大的三态分析，Three-Regime Analysis）**：CAC 精细界的两项共享 $P_{j,l}$ 结构，但步骤 $j$ 的权重有差异：ε-项权重为 $P_{j+1,l}$（不含本步 $L_j$），δ-项权重为 $P_{j,l} = L_j \cdot P_{j+1,l}$（含本步 $L_j$）。因此**同一步 $j$ 的采样域偏离代价比单步近似误差代价高 $L_j$ 倍**：$L_j > 1$（扩张步）时 δ 惩罚尤为严苛，$L_j < 1$（收缩步）时 δ 惩罚被折减。两项的主导步 $j^*$ 均不是绝对误差最大者——准确的主导步是使放大后贡献（$\varepsilon_{i_j} \cdot P_{j+1,l}$ 或 $\delta_j \cdot P_{j,l}$）最大的步骤，早期步骤往往占优。

按 $P_{j,l}$ 的渐近行为，对两项分三种情形分析：

| 情形 | 条件（$P_{j,l}$ 渐近） | ε-项 $\sum_j \varepsilon_{i_j} P_{j+1,l}$ | δ-项 $\sum_j \delta_j P_{j,l}$ | 对应推论 |
|---|---|---|---|---|
| **扩张** | $P_{1,l} \to \infty$ | 主导步 $j^* = \arg\max_j(\varepsilon_{i_j} P_{j+1,l})$，不一定是 $\varepsilon_{i_j}$ 最大者；只要存在 $\varepsilon_{i_j} > 0$，和式 $\to \infty$ | 权重 $P_{j,l} \geq P_{j+1,l}$，δ-项爆炸速度**不慢于** ε-项；只要存在 $\delta_j > 0$，和式 $\to \infty$ | — |
| **稳定** | $\sup_{j,l} P_{j+1,l} \leq \kappa < \infty$ | $\leq \kappa\sum_j \varepsilon_{i_j}$；有界当且仅当 $\sum_j \varepsilon_{i_j} < \infty$；每步上限 $\kappa\varepsilon_{i_j}$ | $\leq (\sup_j L_j)\cdot \kappa \sum_j \delta_j$；全局 $L$ 下 $\leq L\kappa\sum_j\delta_j$；有界条件为 $\sum_j\delta_j < \infty$ | **推论 2** |
| **饱和** | $\Lambda_\infty = \sum_{j\geq 1} P_{j+1,\infty} < C$ | $\leq \sup_j(\varepsilon_{i_j})\cdot\Lambda_\infty$；若 $\varepsilon_{i_j} \to 0$，可远紧于此 | $\leq \sup_j(\delta_j)\cdot\Gamma_\infty$，其中 $\Gamma_\infty = \sum_{j\geq 1} P_{j,\infty}$；全局 $L$ 下 $\Gamma_\infty \leq L\Lambda_\infty < LC$ | **推论 3** |

---

**推论 1（精细界的类级别紧性，Tightness of the Fine-Grained Bound）**：对任意给定序列 $\varepsilon_{i_j} \geq 0$、$\delta_j \geq 0$、路径 Lipschitz 序列 $\{L_j\}_{j=1}^l$（$L_j > 0$）以及 $l \geq 1$，**存在** IDFS $(F, \sigma)$ 和采样 $\mathcal{S}$，使得对某条 $q \in \mathcal{T}$（长度 $l$）和 $x \in \mathrm{dom}(q)$，f-链终值误差精确达到精细界：

$$e_l \;=\; \sum_{j=1}^{l} \varepsilon_{i_j} \cdot P_{j+1,l} \;+\; \sum_{j=1}^{l} \delta_j \cdot P_{j,l}$$

即全精细界对 IDFS 类而言**不可改善**。

**证明（存在性构造）**：取 $\mathcal{X} = \mathbb{R}$，配以绝对值度量 $d(x,y) = |x-y|$，设 $h_0 = h^*_0 = 0$。

**采样域的构造**：对第 $j$ 步，令 $r_{i_j}(y) \equiv 0$（零映射），采样域取单点 $\mathcal{X}(r_{i_j}) \triangleq \{-\delta_j\}$。理想轨道由此恒为零：$h^*_j = 0$。由定义：

$$d\!\bigl(h^*_{j-1},\, \mathcal{X}(r_{i_j})\bigr) = |0 - (-\delta_j)| = \delta_j$$

故偏离距离精确等于任意给定的 $\delta_j \geq 0$。

**近似算子的构造**：令 $\Phi$ 在第 $j$ 步的局部算子为：

$$\Phi_j(y) \;\triangleq\; L_j(y + \delta_j) + \varepsilon_{i_j}$$

则：$\mathrm{Lip}(\Phi_j) = L_j$（精确）；在采样点 $x'_j = -\delta_j$ 处：

$$\bigl\|\Phi_j(x'_j) - r_{i_j}(x'_j)\bigr\| = \bigl|L_j \cdot 0 + \varepsilon_{i_j} - 0\bigr| = \varepsilon_{i_j}$$

单步近似误差精确等于给定的 $\varepsilon_{i_j} \geq 0$。

**误差递推**：对第 $j$ 步套用主定理的三项拆分，取 $x'_j = -\delta_j$（采样域唯一点，$d(h^*_{j-1}, x'_j) = \delta_j$）：

$$e_j = \bigl\|\Phi_j(h_{j-1}) - r_{i_j}(h^*_{j-1})\bigr\| = \bigl|\Phi_j(h_{j-1}) - 0\bigr| = \Phi_j(h_{j-1})$$

其中第二个等号来自 $r_{i_j} \equiv 0$，第三个等号是因为 $\Phi_j(h_{j-1}) \geq 0$——这由以下各项的非负性保证：
- $h_0 = 0$，归纳假设 $h_{j-1} = e_{j-1} \geq 0$；
- $\Phi_j(y) = L_j(y + \delta_j) + \varepsilon_{i_j}$，其中 $L_j > 0$，$\delta_j \geq 0$，$\varepsilon_{i_j} \geq 0$；
- 归纳可知 $h_{j-1} + \delta_j \geq 0$（因 $h_{j-1} \geq 0$，$\delta_j \geq 0$），故 $\Phi_j(h_{j-1}) \geq 0$，即 $e_j = h_j \geq 0$。

由 $h^*_j = 0$，误差 $e_j = |h_j - 0| = h_j$，展开 $\Phi_j$ 得递推：

$$e_j = \Phi_j(h_{j-1}) = L_j(h_{j-1} + \delta_j) + \varepsilon_{i_j} = L_j e_{j-1} + L_j\delta_j + \varepsilon_{i_j}$$

对照三项拆分的各项界限，此处**三项均精确取等**（非不等式）：
- 第一项：$\|\Phi_j(h_{j-1}) - \Phi_j(h^*_{j-1})\| = L_j|h_{j-1} - 0| = L_j e_{j-1}$（$\Phi_j$ 的 Lipschitz 常数精确为 $L_j$）；
- 第二项：$\|\Phi_j(h^*_{j-1}) - \Phi_j(x'_j)\| = L_j|0 - (-\delta_j)| = L_j\delta_j$（同上）；
- 第三项：$\|\Phi_j(x'_j) - r_{i_j}(x'_j)\| = |L_j \cdot 0 + \varepsilon_{i_j} - 0| = \varepsilon_{i_j}$（精确）。

三项同号（均 $\geq 0$），无任何抵消，等号逐步成立。展开递推精确得：

$$e_l = \sum_{j=1}^{l} (\varepsilon_{i_j} + L_j\delta_j)\cdot P_{j+1,l} = \sum_{j=1}^{l} \varepsilon_{i_j} P_{j+1,l} + \sum_{j=1}^{l} \delta_j P_{j,l}$$

与精细界完全吻合。$\square$

**推论 2（有效链长，Effective Chain Length）**：设容忍误差为 $\delta > 0$。f-链误差 $e_l \leq \delta$ 的充要条件为：

$$\Lambda_l \;\leq\; \frac{\delta}{\varepsilon_{\max}}$$

即最大可靠链长是使 $\Lambda_l$ 不超过 $\delta/\varepsilon_{\max}$ 的最长路径：

$$l^{**} \;=\; \max\bigl\{\, l \;\big|\; \exists\, (q, \mathcal{X}_{i_1}) \in \mathcal{T},\; \Lambda_l \leq \delta/\varepsilon_{\max} \,\bigr\}$$

**证明**：直接由 CAC 定理：$e_l \leq \varepsilon_{\max} \cdot \Lambda_l \leq \delta$。$\square$

**保守特例（全局 $L$-Lipschitz）**：取 $\Phi \in \mathrm{Lip}_L$，则 $\Lambda_l \leq (L^l-1)/(L-1)$，条件变为可显式求解：

$$l^* = \left\lfloor \frac{\log\!\left(1 + \dfrac{\delta(L-1)}{\varepsilon_{\max}}\right)}{\log L} \right\rfloor \quad (L > 1), \qquad l^* = \left\lfloor \frac{\delta}{\varepsilon_{\max}} \right\rfloor \quad (L = 1)$$

此为全局 $L$ 下所有路径的统一下界；若具体路径的 $\Lambda_l$ 远小于 $(L^l-1)/(L-1)$，实际可靠深度 $l^{**} \gg l^*$。


**推论 3（收缩饱和，Contraction Saturation）**：若 $\Lambda_\infty \triangleq \sum_{j=1}^{\infty} \prod_{k=j+1}^{\infty} L_k < \infty$，则无论链长 $l$ 多大，f-链终值误差满足：

$$e_l \;\leq\; \varepsilon_{\max} \cdot \Lambda_\infty$$

即误差有全局上界，不随链长增长。

**证明**：由 CAC 定理，$e_l \leq \varepsilon_{\max} \cdot \Lambda_l$。由 $\Lambda_l \nearrow \Lambda_\infty$（级数单调递增趋向极限），故 $e_l \leq \varepsilon_{\max} \cdot \Lambda_\infty$。$\square$

> **注（允许局部扩张）**：推论 3 不要求 $L_j < 1$ 逐步成立——即使某些步存在 $L_j > 1$（局部扩张），只要后续有足够强的收缩步将乘积 $\prod_{k=j+1}^{\infty} L_k$ 压平，$\Lambda_\infty$ 仍然有限。这比全局 $L < 1$ 的条件更一般。

**保守特例（引用推论 0）**：若 $\Phi \in \mathrm{Lip}_L$ 且 $L < 1$，则 $L_j \leq L$，故
$$\Lambda_\infty \leq \sum_{j=0}^{\infty} L^j = \frac{1}{1-L}$$
退化为保守界 $e_l \leq \varepsilon_{\max}/(1-L)$，对应上表「饱和」行的均匀情形。

**推论 3a（不动点收敛，Fixed-Point Convergence）**：若 $\Phi \in \mathrm{Lip}_L(\mathcal{X})$（全局）且 $L < 1$，$(\mathcal{X}, d)$ 完备，则 $\Phi$ 存在唯一不动点 $x^* = \Phi(x^*)$，$\Phi$-轨道从任意初始点收敛：$\hat{h}_l \to x^*$。

**证明**：$L < 1$ 时 $\Phi$ 是完备度量空间 $(\mathcal{X}, d)$ 上的压缩映射，由 **Banach 压缩映射定理**直接得不动点存在唯一性及轨道收敛。$\square$

**推论 3b（扰动的长链衰减，Long-chain Decay of Perturbations）**：设 f-链步骤 $1, \ldots, l$ 的路径局部 Lipschitz 为 $L_j$。设第 $k-1$ 步存在任意来源的**状态扰动** $\delta_{k-1} \triangleq d(\hat{h}_{k-1}^{(A)}, \hat{h}_{k-1}^{(B)}) > 0$——无论其来自原始输入差异还是前 $k-1$ 步的近似误差积累——若**尾部乘积** $\prod_{j=k}^{l} L_j \to 0$（即 $\sum_{j=k}^{\infty} \log L_j = -\infty$，收缩步主导），则：

$$d\!\bigl(\hat{h}_l^{(A)},\, \hat{h}_l^{(B)}\bigr) \;\leq\; \prod_{j=k}^{l} L_j \;\cdot\; \delta_{k-1} \;\to\; 0$$

无论 $\delta_{k-1}$ 多大，f-chain 终态均收敛——IDFS **抹除第 $k-1$ 步之前的一切扰动**，无论扰动来自输入差异、近似误差还是任何其他来源，均被尾部收缩机制彻底压制至零。

**特例（输入差异）**：取 $k = 1$，$\delta_0 = d(x_A, x_B)$，则退化为对原始输入差异的衰减：$d(\hat{h}_l^{(A)}, \hat{h}_l^{(B)}) \leq \prod_{j=1}^{l} L_j \cdot d(x_A, x_B)$。

定义**有效区分深度** $l^\dagger = \max\{l \mid \prod_{j=k}^{l} L_j \geq \theta\}$（$\theta \in (0,1)$ 为可区分阈值），超过此深度后任意扰动均衰减至不可区分范围内。

**证明**：对局部 Lipschitz 条件连续应用，从第 $k$ 步截断：
$$d(\hat{h}_l^{(A)}, \hat{h}_l^{(B)}) \leq \prod_{j=k}^{l} L_j \cdot d(\hat{h}_{k-1}^{(A)}, \hat{h}_{k-1}^{(B)}) = \prod_{j=k}^{l} L_j \cdot \delta_{k-1}$$
$\delta_{k-1}$ 为有限正数，尾部乘积 $\to 0$ 时右端趋零。$\square$

> **注（对偶结构）**：$\Pi_l$（输入分离系数）与 $\Lambda_l$ 控制系统的两个方向：$\Lambda_l$ 衡量**误差的累积放大**（单步近似误差如何沿链传播），$\Pi_l$ 衡量**输入分离的保持程度**（不同输入的输出能否区分）。收缩机制（$L_j < 1$）同时压低 $\Pi_l$（输出坍缩，输入可区分性消失）和 $\Lambda_l$（抑制误差累积）；扩张机制（$L_j > 1$）则反之。两者的平衡决定了 IDFS 的长链稳定性。

**推论 3c（扰动的长链爆炸，Long-chain Explosion of Perturbations）**：设从第 $k$ 步（$k \geq 1$）起，f-链的每一步 $j = k, \ldots, l$ 均存在**扩张下界** $c_j \geq 1$，使得：

$$d\!\bigl(\hat{h}_j^{(A)},\, \hat{h}_j^{(B)}\bigr) \;\geq\; c_j \cdot d\!\bigl(\hat{h}_{j-1}^{(A)},\, \hat{h}_{j-1}^{(B)}\bigr)$$

定义**尾部扰动放大系数（下界）**：

$$\Pi_{k,l}^{-} \;\triangleq\; \prod_{j=k}^{l} c_j$$

设第 $k-1$ 步存在任意来源的**状态扰动** $\delta_{k-1} \triangleq d(\hat{h}_{k-1}^{(A)}, \hat{h}_{k-1}^{(B)}) > 0$——无论其来自原始输入差异还是前 $k-1$ 步的近似误差积累——则 f-chain 终态距离满足：

$$d\!\bigl(\hat{h}_l^{(A)},\, \hat{h}_l^{(B)}\bigr) \;\geq\; \Pi_{k,l}^{-} \cdot \delta_{k-1}$$

**进一步**：若 $\Pi_{k,l}^{-} \to \infty$（等价于 $\sum_{j=k}^{\infty} \log c_j = +\infty$），则终态距离趋无穷——无论 $\delta_{k-1}$ 多小，只要非零，尾部扩张机制将其**无限放大**。前 $k-1$ 步如何产生 $\delta_{k-1}$ 无关紧要，爆炸由第 $k$ 步之后的乘积驱动。

**特例（输入差异）**：取 $k = 1$，$\delta_0 = d(x_A, x_B)$，则退化为对原始输入差异的放大：$d(\hat{h}_l^{(A)}, \hat{h}_l^{(B)}) \geq \Pi_{1,l}^{-} \cdot d(x_A, x_B)$。

**证明**：对扩张下界条件从第 $k$ 步起连续应用，链式展开得 $d(\hat{h}_l^{(A)}, \hat{h}_l^{(B)}) \geq \Pi_{k,l}^{-} \cdot \delta_{k-1}$。$\delta_{k-1} > 0$ 为有限正数，$\Pi_{k,l}^{-} \to \infty$ 时右端趋无穷。$\square$

> **注（驱动条件是尾部乘积；扰动来源无关紧要）**：起始步 $k$ 任意，前 $k-1$ 步可扩张、可收缩、可无约束，不影响结论——关键只是 $\delta_{k-1} > 0$ 存在。尾部乘积 $\Pi_{k,l}^{-} \to \infty$ 是爆炸的充分条件，而非要求每步 $c_j > 1$（例如 $c_j = 1 + 1/j^2$ 时乘积收敛，不会爆炸）。与推论3b完全对称：3b中收缩尾部乘积将任意有限扰动压至零，3c中扩张尾部乘积将任意非零扰动放大至无穷——两者均与扰动的历史来源无关。推论7是推论3c在 IDFS $\sigma$-决策边界处的**结构性实例**——边界跨越时 $c_j \to \infty$，使 $\Pi_{k,l}^{-}$ 以极端速度发散。

---

**推论 4（生成基约简，Basis Reduction）**：设 $R_0 \subseteq R$ 为 $R$ 的**生成基**，$d_{\max} \triangleq \max_{r_i \in R \setminus R_0} d(r_i, R_0)$。设 $\Phi$ 以误差 $\varepsilon_0$ 局部拟合 $R_0$（即对所有 $(r, \mathcal{X}_r) \in \mathcal{S},\, r \in R_0$：$\sup_{x \in \mathcal{X}_r} \|\Phi(x) - r(x)\| \leq \varepsilon_0$）。

对任意 $r_i \in R \setminus R_0$ 的分解路径 $r_i = r_{i_{d_i}} \circ \cdots \circ r_{i_1}$，记该路径的累积放大系数为 $\Lambda_{d_i}^{\mathrm{path}}$，则：

$$\varepsilon_{\max}^R \;\leq\; \varepsilon_0 \cdot \max_{r_i \in R \setminus R_0} \Lambda_{d_i}^{\mathrm{path}}$$

**证明**：情形 1（$r \in R_0$）直接由假设满足。情形 2（$r_i \in R \setminus R_0$）：对分解路径应用 CAC 定理，e.g. $j$ 步插入 $\Phi(h^*_{j-1})$，得递推 $e_j \leq L_j e_{j-1} + \varepsilon_0$，展开得 $e_{d_i} \leq \varepsilon_0 \cdot \Lambda_{d_i}^{\mathrm{path}}$。对所有 $r_i \in R \setminus R_0$ 取上确界即得。$\square$

**保守特例（引用推论 0）**：若 $\Phi \in \mathrm{Lip}_L$，则 $\Lambda_{d_i}^{\mathrm{path}} \leq (L^{d_i}-1)/(L-1) \leq (L^{d_{\max}}-1)/(L-1)$，退化为：

$$\varepsilon_{\max}^R \;\leq\; \varepsilon_0 \cdot \frac{L^{d_{\max}} - 1}{L - 1}$$

**证明详展（情形 2）**：设 $r_i = r_{i_{d_i}} \circ \cdots \circ r_{i_1}$，$r_{i_j} \in R_0$，分解满足域链相容。对任意 $x \in \mathcal{X}_{i_1}$：

- **$r$-链轨道**：$h_0^* = x$，$h_j^* = r_{i_j}(h_{j-1}^*)$，$h_{d_i}^* = r_i(x)$
- **$\Phi$-轨道**：$\hat{h}_0 = x$，$\hat{h}_j = \Phi(\hat{h}_{j-1})$

$e_j = \|\hat{h}_j - h_j^*\|$，$e_0 = 0$。插入 $\Phi(h^*_{j-1})$：

$$e_j \leq \underbrace{\|\Phi(\hat{h}_{j-1}) - \Phi(h^*_{j-1})\|}_{\leq\, L_j e_{j-1}} + \underbrace{\|\Phi(h^*_{j-1}) - r_{i_j}(h^*_{j-1})\|}_{\leq\, \varepsilon_0,\; h^*_{j-1} \in \mathcal{X}_{i_j}}$$

展开得 $e_{d_i} \leq \varepsilon_0 \cdot \Lambda_{d_i}^{\mathrm{path}}$。对 $x$ 取上确界即得。$\square$

**含义（剖面策略）**：不同的生成基分解对应不同的 $\Lambda_{d_i}^{\mathrm{path}}$。选择分解使 $\Lambda_{d_i}^{\mathrm{path}}$ 最小化，能得到最紧的有效近似误差上界。宽度与深度的权衡由路径的 Lipschitz 结构决定，而非仅由分解深度 $d_{\max}$ 决定。

**定义（组合覆盖代价，Compositional Coverage Cost）**：给定生成基 $R_0$，定义 $R$ 在 $R_0$ 下的**组合覆盖代价**为：

$$\mathcal{C}(R, R_0) \;\triangleq\; |R_0| \;\times\; \max_{r_i \in R \setminus R_0} \Lambda_{d_i}^{\mathrm{path}}$$

其中 $|R_0|$ 是 $\Phi$ 需要直接近似的变换数，$\max \Lambda_{d_i}^{\mathrm{path}}$ 是最坏分解路径的误差放大系数。$\mathcal{C}(R, R_0)$ 刻画了用 $R_0$ 覆盖整个 $R$ 所需的总代价：直接近似负担与组合误差代价的乘积。

**推论 4a（最优可达精度，Optimal Coverage Achievability）**：设 Φ 对所有 $r_0 \in R_0$ 实现局部精度 $\varepsilon_0$（如推论 4 假设）。则通过选择最优生成基 $R_0$，Φ 对整个 $R$ 可达的最优覆盖精度为：

$$\delta^* \;=\; \varepsilon_0 \cdot \min_{R_0 \;\text{生成}\; R}\; \max_{r_i \in R \setminus R_0} \Lambda_{d_i}^{\mathrm{path}}(R_0)$$

**证明**：直接由推论 4，对所有可行的 $R_0$ 取最优（最小化误差放大因子）即得。$\square$

> **备注（最优基 $R_0^*$）**：最优基定义为
> $$R_0^* \;=\; \arg\min_{R_0 \;\text{生成}\; R}\; \max_{r_i \in R \setminus R_0} \Lambda_{d_i}^{\mathrm{path}}(R_0)$$
> 它使分解路径的误差放大最小，从而允许最宽松的基元素近似精度 $\varepsilon_0 \geq \delta/\Lambda_{d_{\max}}^{\mathrm{path}}$。$R_0^*$ 的闭合形式依赖 $R$ 的代数分解结构，一般情形下为 NP-hard 的最优覆盖问题。

---

**定义（映射的局部变分下界，Local Variation Lower Bound）**：设 $(\mathcal{X}, d)$ 为度量空间。称映射 $r \in \Omega$ 在子集 $\mathcal{X}_r \subseteq \mathcal{X}$ 上具有 **$(\delta, \Delta)$-变分**，若存在 $x, y \in \mathcal{X}_r$ 使得：

$$d(x, y) \;\leq\; \delta \quad \text{且} \quad d\bigl(r(x), r(y)\bigr) \;\geq\; \Delta$$

即 $r$ 在 $\delta$-邻域内存在幅度不小于 $\Delta$ 的剧烈跳变。

**推论 5（近似误差的变分下界，Variation Bound on Approximation Error）**：设 $\Phi \in \mathrm{Lip}_L(\mathcal{X})$。设 $(r, \mathcal{X}_r) \in \mathcal{S}$，$r$ 在 $\mathcal{X}_r$ 上具有 $(\delta, \Delta)$-变分，记 $\varepsilon_r = \sup_{z \in \mathcal{X}_r} d(\Phi(z), r(z))$。则必然成立：

$$2\varepsilon_r \;+\; L \cdot \delta \;\geq\; \Delta$$

**证明**：取满足 $(\delta, \Delta)$-变分条件的点对 $x, y \in \mathcal{X}_r$。对 $d(r(x), r(y))$ 两次插入 $\Phi$，由三角不等式：

$$d\bigl(r(x), r(y)\bigr) \;\leq\; \underbrace{d\bigl(r(x), \Phi(x)\bigr)}_{\leq\,\varepsilon_r} \;+\; \underbrace{d\bigl(\Phi(x), \Phi(y)\bigr)}_{\leq\,L\cdot d(x,y)\,\leq\,L\delta} \;+\; \underbrace{d\bigl(\Phi(y), r(y)\bigr)}_{\leq\,\varepsilon_r}$$

又 $d(r(x), r(y)) \geq \Delta$，代入即得 $\Delta \leq 2\varepsilon_r + L\delta$。$\square$

> **注（三方互斥律）**：式 $2\varepsilon_r + L\delta \geq \Delta$ 刻画了三个量的内在紧张：局部变分幅度 $\Delta/\delta$、全局光滑度 $L$、单步近似误差 $\varepsilon_r$ 三者不能同时任意小。若要近似具有高局部变分（$\Delta/\delta \gg L$）的 $r$，则**近似误差必然不小于** $\varepsilon_r \geq (\Delta - L\delta)/2$。

---

**推论 6（逆映射逼近的不对称性，Asymmetry of Inverse Approximation）**：设 $r \in R$ 为可逆映射，$(r, \mathcal{X}_r) \in \mathcal{S}$，且 $(r^{-1}, r(\mathcal{X}_r)) \notin \mathcal{S}$。设 IDFS $(F, \sigma)$ 满足 $\sup_{x \in \mathcal{X}_r} \|\Phi(x) - r(x)\| \leq \varepsilon_r$。

则 $\Phi$ 对 $r^{-1}$ 的逼近误差与 $\varepsilon_r$ **逻辑独立**：存在满足上述条件的 $\Phi \in \mathrm{Lip}_L(\mathcal{X})$，使得

$$\sup_{y \in r(\mathcal{X}_r)} \bigl\|\Phi(y) - r^{-1}(y)\bigr\|$$

可以任意大（与 $\varepsilon_r$ 无约束关系）。

**证明**：由 §1.3，$\varepsilon_r$ 是 $\Phi$ 在 $\mathcal{X}_r$ 上对 $r$ 的局部误差上界——该约束的成立来源是 $(r, \mathcal{X}_r) \in \mathcal{S}$。$r^{-1}$ 的作用域为 $r(\mathcal{X}_r)$；由于 $(r^{-1}, r(\mathcal{X}_r)) \notin \mathcal{S}$，§1.3 对 $\Phi$ 在 $r(\mathcal{X}_r)$ 上的行为不施加任何约束。

**构造**：取 $\mathcal{X} = \mathbb{R}$，$\mathcal{X}_r = [0, 1]$，$r(x) = x + D$（$D$ 足够大使两段不重叠），则 $r^{-1}(y) = y - D$，$r(\mathcal{X}_r) = [D, D+1]$。定义
$$\Phi(x) = \begin{cases} x + D + \delta & x \in [0, 1] \\ x + C & x \in [D, D+1] \end{cases}$$
之间光滑插值保持全局 Lipschitz。则 $\varepsilon_r = \delta$（任意小），而对 $y \in [D, D+1]$：$\|\Phi(y) - r^{-1}(y)\| = |y + C - (y - D)| = |C + D|$，可取任意大。$\square$

> **注**：推论 5 的本质是：在不引入互逆采样对的框架下，知识拟合关系在度量空间上是**有向的**——$\Phi$ 拟合 $r$ 与拟合 $r^{-1}$ 是两个独立的约束，前者不蕴含后者。

---

**推论 7（决策边界的局部曲率爆炸，Decision Boundary Curvature Explosion）**：设 IDFS $(F, \sigma)$ 如 §1.2 所定义。若 f-链第 $j$ 步中，近似状态 $\hat{h}_{j-1}$ 与理想状态 $h^*_{j-1}$ 被 $\sigma$ 选到了不同的函数——即 $\sigma(\hat{h}_{j-1}) = f_k \neq f_{k'} = \sigma(h^*_{j-1})$——且两函数在 $\hat{h}_{j-1}$ 处的输出差有宏观下界：

$$\Delta \;\triangleq\; \bigl\|f_k(\hat{h}_{j-1}) - f_{k'}(\hat{h}_{j-1})\bigr\| \;>\; 0, \qquad k \neq k'$$

则路径局部 Lipschitz 常数满足：

$$L_j \;=\; \frac{\|\Phi(\hat{h}_{j-1}) - \Phi(h^*_{j-1})\|}{d(\hat{h}_{j-1},\, h^*_{j-1})} \;\geq\; \frac{\Delta - L_{f_{k'}} \cdot d(\hat{h}_{j-1},\, h^*_{j-1})}{d(\hat{h}_{j-1},\, h^*_{j-1})}$$

当误差 $e_{j-1} = d(\hat{h}_{j-1}, h^*_{j-1}) \to 0$ 而两点仍跨越边界时，$L_j \to \infty$。

**证明**：设 $a = \hat{h}_{j-1}$，$b = h^*_{j-1}$，$\sigma(a) = f_k$，$\sigma(b) = f_{k'}$（$k \neq k'$）。则：

$$\|\Phi(a) - \Phi(b)\| = \|f_k(a) - f_{k'}(b)\|$$

由三角不等式：

$$\|f_k(a) - f_{k'}(b)\| \;\geq\; \|f_k(a) - f_{k'}(a)\| - \|f_{k'}(a) - f_{k'}(b)\| \;\geq\; \Delta - L_{f_{k'}} \cdot d(a, b)$$

其中 $L_{f_{k'}}$ 是函数 $f_{k'}$ 的 Lipschitz 常数（有界量）。两边除以 $d(a,b)$：

$$L_j \;\geq\; \frac{\Delta}{d(a,b)} - L_{f_{k'}} \;\xrightarrow{d(a,b) \to 0}\; +\infty \qquad \square$$

> **注（与推论3c的关系）**：推论7是**推论3c在 IDFS $\sigma$-边界处的结构性实例**。推论3c要求以 co-Lipschitz 下界 $c_j > 1$ 作为前提条件；而推论7表明，当两点跨越 $\sigma$-决策边界时，该条件由 IDFS 结构**自动满足**，且下界以 $c_j \geq \Delta/d(a,b) - L_{f_{k'}} \to +\infty$ 的速度发散——即 IDFS 在边界附近天然具备极端扩张性。这是 $\sigma$ 将连续状态空间映射到离散函数集的内在代价：**边界处的不连续性产生无界局部扩张，是推论3c最极端的退化情形**。
