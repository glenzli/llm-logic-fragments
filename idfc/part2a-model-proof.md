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

设 $N \geq 1$ 为**维度数**。对每个维度 $k \in [N] \triangleq \{1, \ldots, N\}$，设 $(V_k, d_k)$ 为度量空间，并包含一个特殊的**零元素** $\mathbf{0}_k \in V_k$（表示该维度位置"不存在"）。

定义**元组空间**：

$$\mathcal{X} \;=\; V_1 \times V_2 \times \cdots \times V_N$$

其元素为 $N$ 维元组 $x = (v_1, v_2, \ldots, v_N)$，$v_k \in V_k$（$v_k = \mathbf{0}_k$ 表示该维度位置"不存在"）。$\mathcal{X}$ 上配以**积度量**：

$$d(x, y) \;=\; \Bigl(\sum_{k=1}^{N} d_k(v_k, w_k)^p\Bigr)^{1/p}, \qquad 1 \leq p \leq \infty$$

（$p = \infty$ 时退化为 $d(x, y) = \max_k\, d_k(v_k, w_k)$。）$(\mathcal{X}, d)$ 构成度量空间。



定义**变换空间**：

$$\Omega = \{ \phi : \mathcal{X} \to \mathcal{X} \}$$

对 $\phi \in \Omega$，定义其**定义域**为使 $\phi$ 产生非空输出的全部输入：

$$\mathrm{dom}(\phi) \;\triangleq\; \bigl\{\, x \in \mathcal{X} \;\big|\; \phi(x) \neq \mathbf{0} \,\bigr\}$$

其中 $\mathbf{0} = (\mathbf{0}_1, \ldots, \mathbf{0}_N)$ 为 $\mathcal{X}$ 的全零元（所有分量均为零元）。$\phi(x) = \mathbf{0}$ 表示 $\phi$ 在 $x$ 处无输出（"不适用"），$\mathrm{dom}(\phi)$ 即 $\phi$ 实际发生作用的输入集合。

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

**证明**：第 $j$ 步，取 $x'_j \in \mathcal{X}(r_{i_j})$ 为距 $h^*_{j-1}$ 最近的采样域点（$d(h^*_{j-1}, x'_j) = \delta_j$）。插入 $\Phi(h^*_{j-1})$ 并展开：

$$e_j \;\leq\; \underbrace{\|\Phi(h_{j-1}) - \Phi(h^*_{j-1})\|}_{\leq\, L_j \cdot e_{j-1}} \;+\; \underbrace{\|\Phi(h^*_{j-1}) - \Phi(x'_j)\|}_{\leq\, L_j \cdot \delta_j} \;+\; \underbrace{\|\Phi(x'_j) - r_{i_j}(x'_j)\|}_{\leq\, \varepsilon_{i_j}}$$

递推关系：$e_j \leq L_j e_{j-1} + L_j\delta_j + \varepsilon_{i_j}$，$e_0 = 0$。逐步展开前三步：

$$e_1 \leq \varepsilon_{i_1} + L_1\delta_1$$
$$e_2 \leq L_2 e_1 + (\varepsilon_{i_2} + L_2\delta_2) \leq (\varepsilon_{i_1} + L_1\delta_1)\cdot L_2 + (\varepsilon_{i_2} + L_2\delta_2)$$
$$e_3 \leq L_3 e_2 + (\varepsilon_{i_3} + L_3\delta_3) \leq (\varepsilon_{i_1} + L_1\delta_1)\cdot L_3L_2 + (\varepsilon_{i_2} + L_2\delta_2)\cdot L_3 + (\varepsilon_{i_3} + L_3\delta_3)$$

第 $j$ 步新增项 $(\varepsilon_{i_j} + L_j\delta_j)$ 在后续各步中被乘以 $P_{j+1,l}$，归纳得：

$$e_l \;\leq\; \sum_{j=1}^{l}\Bigl(\varepsilon_{i_j} + L_j\delta_j\Bigr)\cdot P_{j+1,l}$$

分离两项，利用 $L_j \cdot P_{j+1,l} = P_{j,l}$：

$$e_l \;\leq\; \sum_{j=1}^{l}\varepsilon_{i_j}\cdot P_{j+1,l} \;+\; \sum_{j=1}^{l}\delta_j\cdot P_{j,l}$$

> **保守简化（均匀缩放）**：令 $\varepsilon_{\max} \triangleq \max_j \varepsilon_{i_j}$，$\delta_{\max} \triangleq \max_j \delta_j$，则界退化为：
>
> $$e_l \;\leq\; \varepsilon_{\max}\cdot\Lambda_l \;+\; \delta_{\max}\cdot\Gamma_l$$
>
> 若进一步 $\Phi \in \mathrm{Lip}_L$（全局），则 $\Gamma_l \leq L\Lambda_l$，界收缩为**单项**：
>
> $$e_l \;\leq\; (\varepsilon_{\max} + L\delta_{\max})\cdot\Lambda_l$$

$\square$

> **注**：两项共享 $P_{j,l}$ 结构，但步骤 $j$ 的权重有细微差异：ε-项权重为 $P_{j+1,l}$（不含本步 $L_j$），δ-项权重为 $P_{j,l} = L_j \cdot P_{j+1,l}$（含本步 $L_j$）。因此**同一步 $j$ 的采样域偏离代价比单步近似误差代价高 $L_j$ 倍**：$L_j > 1$（扩张步）时 δ 惩罚尤为严苛，$L_j < 1$（收缩步）时 δ 惩罚被折减。两项的"主导步"均不一定是绝对值最大者——精确的主导步 $j^*$ 是使放大后贡献（$\varepsilon_{i_j} \cdot P_{j+1,l}$ 或 $\delta_j \cdot P_{j,l}$）最大的步骤，早期步骤往往占优。下表对三种典型情形分别分析：

| 情形 | 条件（$P_{j,l}$ 渐近） | ε-项 $\sum_j \varepsilon_{i_j} P_{j+1,l}$ | δ-项 $\sum_j \delta_j P_{j,l}$ | 对应推论 |
|---|---|---|---|---|
| **扩张** | $P_{1,l} \to \infty$ | 主导步 $j^* = \arg\max_j(\varepsilon_{i_j} P_{j+1,l})$，不一定是 $\varepsilon_{i_j}$ 最大者；只要存在 $\varepsilon_{i_j} > 0$，和式 $\to \infty$ | 权重 $P_{j,l} \geq P_{j+1,l}$，δ-项爆炸速度**不慢于** ε-项；只要存在 $\delta_j > 0$，和式 $\to \infty$ | **推论 0** |
| **稳定** | $\sup_{j,l} P_{j+1,l} \leq \kappa < \infty$ | $\leq \kappa\sum_j \varepsilon_{i_j}$；有界当且仅当 $\sum_j \varepsilon_{i_j} < \infty$；每步上限 $\kappa\varepsilon_{i_j}$ | $\leq (\sup_j L_j)\cdot \kappa \sum_j \delta_j$；全局 $L$ 下 $\leq L\kappa\sum_j\delta_j$；有界条件为 $\sum_j\delta_j < \infty$ | **推论 2** |
| **饱和** | $\Lambda_\infty = \sum_{j\geq 1} P_{j+1,\infty} < C$ | $\leq \sup_j(\varepsilon_{i_j})\cdot\Lambda_\infty$；若 $\varepsilon_{i_j} \to 0$，可远紧于此 | $\leq \sup_j(\delta_j)\cdot\Gamma_\infty$，其中 $\Gamma_\infty = \sum_{j\geq 1} P_{j,\infty}$；全局 $L$ 下 $\Gamma_\infty \leq L\Lambda_\infty < LC$ | **推论 3** |

---

**推论 0（均匀粗界，先验可计算）**：设 $\Phi \in \mathrm{Lip}_L(\mathcal{X})$（全局 $L$-Lipschitz），$\varepsilon_{\max} = \max_j \varepsilon_{i_j}$，$\delta_{\max} = \max_j \delta_j$。则 $L_j \leq L$ 对所有步成立，故：

$$\Lambda_l \;\leq\; \sum_{j=1}^{l} L^{l-j} \;=\; \frac{L^l - 1}{L - 1}, \qquad \Gamma_l \leq L\Lambda_l \leq L \cdot \frac{L^l - 1}{L - 1}$$

得单项粗界：

$$\bigl\|h_l - q(x)\bigr\| \;\leq\; (\varepsilon_{\max} + L\delta_{\max})\cdot\frac{L^l - 1}{L - 1}$$

（$L = 1$ 时取极限 $(\varepsilon_{\max} + \delta_{\max})\cdot l$。）此界**先验可计算**（只需全局 Lipschitz $L$、$\varepsilon_{\max}$、$\delta_{\max}$，无需运行路径），但一般严格大于精细界 $\sum_j\varepsilon_{i_j}P_{j+1,l}+\sum_j\delta_j P_{j,l}$。

**结论**：降低链路误差有且仅有三条路径：压低单步拟合误差 $\varepsilon_{\max}$，或控制采样域偏离 $\delta_{\max}$，或控制路径局部 Lipschitz（进而控制 $\Lambda_l$）。

**推论 1（CAC 界的类级别紧性，Tightness of the CAC Bound）**：对任意参数组合 $\varepsilon_{\max} > 0$、$\Lambda_l > 0$、$l \geq 1$，**存在** IDFS $(F, \sigma)$、相应的 $\mathcal{S}$ 和 $(q, \mathcal{X}_{i_1}) \in \mathcal{T}$ 及 $x \in \mathcal{X}_{i_1}$，使 f-链误差精确达到：

$$e_l \;=\; \varepsilon_{\max} \cdot \Lambda_l$$

即 CAC 精细界对 IDFS 类而言**不可改善**。

**证明（代数构造）**：为展示任意可实现的局部 Lipschitz 序列 $\{L_j\}_{j=1}^l$ 均可达，选取 $\mathcal{X} = \mathbb{R}$（一维，全空间），常值映射条件自然满足。
设计目标链为线性放缩序列 $r_j(x) = L_j x$。设计系统 $\Phi$ 在输入状态要求执行 $r_j$ 时，其实际生效的局部计算子为带常数平移的放缩：$\Phi_j(x) = L_j x + \varepsilon_{\max}$。
在此构造下：
1. $\Phi_j$ 的 Lipschitz 常数精确为 $L_j$。
2. 对任意 $x$，单步近似误差 $\|\Phi_j(x) - r_j(x)\| = \varepsilon_{\max}$ 恒成立。
以 $x = 0$ 为起点，真实轨道 $h^*_j = 0$（恒为零）。
近似轨道递推式为 $\hat{h}_j = \Phi_j(\hat{h}_{j-1}) = L_j \hat{h}_{j-1} + \varepsilon_{\max}$，初始 $\hat{h}_0 = 0$。展开递推：
$$\hat{h}_1 = \varepsilon_{\max}$$
$$\hat{h}_2 = L_2 \varepsilon_{\max} + \varepsilon_{\max}$$
$$\hat{h}_l = \sum_{j=1}^{l} \varepsilon_{\max} \prod_{k=j+1}^{l} L_k = \varepsilon_{\max} \cdot \Lambda_l$$
故 $e_l = \|\hat{h}_l - 0\| = \varepsilon_{\max} \cdot \Lambda_l$。在多维空间 $\mathbb{R}^d$ 中，只需将上述构造沿着单一特定特征向量 $c$ 展开即可。此构造证明了 CAC 精细界不可改善。$\square$

**推论 2（有效链长，Effective Chain Length）**：设容忍误差为 $\delta > 0$。f-链误差 $e_l \leq \delta$ 的充要条件为：

$$\Lambda_l \;\leq\; \frac{\delta}{\varepsilon_{\max}}$$

即最大可靠链长是使 $\Lambda_l$ 不超过 $\delta/\varepsilon_{\max}$ 的最长路径：

$$l^{**} \;=\; \max\bigl\{\, l \;\big|\; \exists\, (q, \mathcal{X}_{i_1}) \in \mathcal{T},\; \Lambda_l \leq \delta/\varepsilon_{\max} \,\bigr\}$$

**证明**：直接由 CAC 定理：$e_l \leq \varepsilon_{\max} \cdot \Lambda_l \leq \delta$。$\square$

**保守特例（引用推论 0）**：取 $\Phi \in \mathrm{Lip}_L$，则 $\Lambda_l \leq (L^l-1)/(L-1)$，条件变为可显式求解：

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
