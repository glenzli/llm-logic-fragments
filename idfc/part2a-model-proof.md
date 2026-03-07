# IDFC · Part 2a：数学建模与 CAC 定理证明

> **前置**：见 [Part 1 导论](part1-intro.md) 了解非正式动机与预测概览。
>
> **本文内容**：§1 形式定义（度量空间 $(\mathcal{X},d)$、有限子集 $R \subset \Omega$/完整变换空间 $\Omega$；**IDFS 泛化定义** $(F,\sigma)$——纯抽象理论，不预设神经网络）；§2 核心假说 CAC 的严格抽象陈述；§3 定理完整证明（Telescope 展开 + UAT 补充 + TSC 框架）。神经网络的具体代数实例化见 [**Part 2c**](part2c-nn-algebraic.md)。
>
> **后续**：[Part 3](part3-deductions.md) 从本文定理推导全部推论；[Part 4](part4-empirical.md) 以 Transformer/Mamba/MoE 等架构分析与多组实验场景（幻觉、ICL、量化、Reversal Curse、Sycophancy 等）验证并锚定本文理论预测。

---

## 第一部分：数学模型的构造

## 1. 基本设定

### 1.1 度量空间与变换空间

设 $(\mathcal{X}, d)$ 为度量空间。

定义**变换空间**：

$$\Omega = \{ \phi : \mathcal{X} \to \mathcal{X} \}$$

$\Omega$ 在函数复合下构成**幺半群**：$\phi_2 \circ \phi_1 \in \Omega$，$\text{id}_{\mathcal{X}} \in \Omega$。

设 $R$ 为 $\Omega$ 的一个有限子集：

$$R = \{r_1, r_2, \ldots, r_m\} \subset \Omega$$

$R^*$ 为 $R$ 在复合运算下的**自由幺半群**：

$$R^* = \{ r_{i_k} \circ \cdots \circ r_{i_1} \mid k \geq 0,\ r_{i_j} \in R \}$$

$R^*$ 中长度为 $l$ 的元素 $q = r_{i_l} \circ \cdots \circ r_{i_1}$ 称为 **$r$-链**（$r$-chain），$l$ 为其**长度**（$l = 0$ 对应幺元 $\mathrm{id}_{\mathcal{X}}$）。

设 $\mathcal{S} = \{(r_i, \mathcal{X}_i)\}_{i=1}^{m}$ 为有限个**采样对**的集合，其中 $r_i \in R$，$\mathcal{X}_i \subseteq \mathcal{X}$ 为 $r_i$ 的限定输入域。

设 $\mathcal{T}$ 为 $\mathcal{S}$ 在 $R^*$ 上的**相容扩展集**：

$$\mathcal{T} = \bigl\{\, (q,\, \mathcal{X}_{i_1}) \mid q = r_{i_l} \circ \cdots \circ r_{i_1} \in R^*,\; (r_{i_j}, \mathcal{X}_{i_j}) \in \mathcal{S},\; r_{i_j}(\mathcal{X}_{i_j}) \subseteq \mathcal{X}_{i_{j+1}}\ (\forall\, j < l) \,\bigr\}$$

$\mathcal{T}$ 中的 $q$ 必须满足**域链相容条件**：每个分量 $r_{i_j}$ 属于 $\mathcal{S}$，且前一分量的输出落入后一分量的限定域。$(q, \mathcal{X}_{i_1}) \in \mathcal{T}$ 即表明 $q$ 从 $\mathcal{X}_{i_1}$ 出发是合法的。

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

**定义（单步近似误差）**：设 $(r_i, \mathcal{X}_i) \in \mathcal{S}$。定义 $\Phi$ 在 $\mathcal{X}_i$ 上对 $r_i$ 的**逐点近似误差**为：

$$\varepsilon_i \;\triangleq\; \sup_{x \in \mathcal{X}_i} \bigl\|\Phi(x) - r_i(x)\bigr\|$$

记 $\varepsilon_{\max} = \max_{(r_i,\, \mathcal{X}_i) \in \mathcal{S}}\, \varepsilon_i$。


---

## 2. CAC 定理

**定理（组合近似封闭性，Compositional Approximation Closure，CAC；亦称组合泛化定理，CGT）**：设 $(F, \sigma)$ 为 IDFS，$\Phi \in \mathrm{Lip}(\mathcal{X})$（§1.2）；设 $\mathcal{S} = \{(r_i, \mathcal{X}_i)\}$（§1.1）上各步单步近似误差为 $\varepsilon_{i_j}$（§1.3），记 $\varepsilon_{\max} = \max_j \varepsilon_{i_j}$。

对任意 $(q, \mathcal{X}_{i_1}) \in \mathcal{T}$（其中 $q = r_{i_l} \circ \cdots \circ r_{i_1}$，长度为 $l$）和 $x \in \mathcal{X}_{i_1}$，记 $L_j \triangleq \mathrm{Lip}(\Phi\!\restriction_{(\hat{h}_{j-1},\, h^*_{j-1})})$ 为第 $j$ 步的**路径局部 Lipschitz 常数**，定义**累积放大系数**：

$$\Lambda_l \;\triangleq\; \sum_{j=1}^{l} \prod_{k=j+1}^{l} L_k \qquad \text{（空积：}j=l\text{ 时定义为 }1\text{）}$$

则 f-链终值误差满足：

$$\bigl\|\hat{h}_l - q(x)\bigr\| \;\leq\; \varepsilon_{\max} \cdot \Lambda_l$$

**证明**：令 $h_j^* = r_{i_j}(h_{j-1}^*)$（$h_0^* = x$），$e_j = \|\hat{h}_j - h_j^*\|$，$e_0 = 0$。第 $j$ 步插入 $\Phi(h^*_{j-1})$，三角不等式：

$$e_j \;\leq\; \underbrace{\|\Phi(\hat{h}_{j-1}) - \Phi(h^*_{j-1})\|}_{\leq\, L_j \cdot e_{j-1}} \;+\; \underbrace{\|\Phi(h^*_{j-1}) - r_{i_j}(h^*_{j-1})\|}_{\leq\, \varepsilon_{i_j} \,\leq\, \varepsilon_{\max}}$$

递推关系：$e_j \leq L_j\,e_{j-1} + \varepsilon_{\max}$，$e_0 = 0$。逐步展开：

$$e_l \leq \varepsilon_{i_1}\!\cdot\!\prod_{k=2}^{l}L_k \;+\; \varepsilon_{i_2}\!\cdot\!\prod_{k=3}^{l}L_k \;+\; \cdots \;+\; \varepsilon_{i_l} \;\leq\; \varepsilon_{\max}\!\cdot\!\sum_{j=1}^{l}\prod_{k=j+1}^{l}L_k \;=\; \varepsilon_{\max}\cdot\Lambda_l$$

$\square$

> **注**：$L_j$ 是 $\Phi$ 在二点对 $(\hat{h}_{j-1}, h^*_{j-1})$ 上的局部 Lipschitz，由路径决定，无需提前知道。$\Lambda_l$ 随 $\{L_j\}$ 的分布不同而呈现截然不同的渐近行为，下表给出三种典型分类：

| 情形 | 条件 | $\Lambda_l$ 行为 | 对应推论 |
|---|---|---|---|
| **扩张** | $\prod_{k=1}^{l} L_k \to \infty$（扩张步主导） | $\Lambda_l$ 指数增长，$\Lambda_\infty = \infty$ | **推论 0**（全局 Lipschitz 保守界）仍有约束力 |
| **线性/稳定** | $\sup_{l \geq j}\prod_{k=j+1}^{l} L_k \leq M < \infty$（尾部乘积一致有界） | $\Lambda_l \leq M \cdot l$，线性增长，$\Lambda_\infty = \infty$ | **推论 2**（有效链长）给出可靠深度 |
| **饱和** | $\sum_{j=1}^{\infty} \prod_{k=j+1}^{\infty} L_k < C$ | $\Lambda_\infty \leq C$，全局有界 | **推论 3**（收缩饱和）适用 |

---

**推论 0（全局 Lipschitz 保守上界，先验可计算）**：若 $\Phi \in \mathrm{Lip}_L(\mathcal{X})$（全局 $L$-Lipschitz），则 $L_j \leq L$ 对所有步成立，故：

$$\Lambda_l \;\leq\; \sum_{j=1}^{l} L^{l-j} \;=\; \frac{L^l - 1}{L - 1} \qquad (L > 1)$$

从而：

$$\bigl\|\hat{h}_l - q(x)\bigr\| \;\leq\; \varepsilon_{\max} \cdot \frac{L^l - 1}{L - 1}$$

（$L = 1$ 时右端取极限 $l \cdot \varepsilon_{\max}$。）此界**先验可计算**（只需知道全局 Lipschitz $L$，无需运行路径），但一般严格大于精细界 $\varepsilon_{\max} \cdot \Lambda_l$。

**结论**：降低链路误差有且仅有两条路径：压低单步拟合误差 $\varepsilon_{\max}$，或控制路径局部 Lipschitz（进而控制 $\Lambda_l$）。

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

**推论 3b（不动点收敛，Fixed-Point Convergence）**：若 $\Phi \in \mathrm{Lip}_L(\mathcal{X})$（全局）且 $L < 1$，$(\mathcal{X}, d)$ 完备，则 $\Phi$ 存在唯一不动点 $x^* = \Phi(x^*)$，$\Phi$-轨道从任意初始点收敛：$\hat{h}_l \to x^*$。

**证明**：$L < 1$ 时 $\Phi$ 是完备度量空间 $(\mathcal{X}, d)$ 上的压缩映射，由 **Banach 压缩映射定理**直接得不动点存在唯一性及轨道收敛。$\square$

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

**推论 5（逆映射逼近的不对称性，Asymmetry of Inverse Approximation）**：设 $r \in R$ 为可逆映射，$(r, \mathcal{X}_r) \in \mathcal{S}$，且 $(r^{-1}, r(\mathcal{X}_r)) \notin \mathcal{S}$。设 IDFS $(F, \sigma)$ 满足 $\sup_{x \in \mathcal{X}_r} \|\Phi(x) - r(x)\| \leq \varepsilon_r$。

则 $\Phi$ 对 $r^{-1}$ 的逼近误差与 $\varepsilon_r$ **逻辑独立**：存在满足上述条件的 $\Phi \in \mathrm{Lip}_L(\mathcal{X})$，使得

$$\sup_{y \in r(\mathcal{X}_r)} \bigl\|\Phi(y) - r^{-1}(y)\bigr\|$$

可以任意大（与 $\varepsilon_r$ 无约束关系）。

**证明**：由 §1.3，$\varepsilon_r$ 是 $\Phi$ 在 $\mathcal{X}_r$ 上对 $r$ 的局部误差上界——该约束的成立来源是 $(r, \mathcal{X}_r) \in \mathcal{S}$。$r^{-1}$ 的作用域为 $r(\mathcal{X}_r)$；由于 $(r^{-1}, r(\mathcal{X}_r)) \notin \mathcal{S}$，§1.3 对 $\Phi$ 在 $r(\mathcal{X}_r)$ 上的行为不施加任何约束。

**构造**：取 $\mathcal{X} = \mathbb{R}$，$\mathcal{X}_r = [0, 1]$，$r(x) = x + D$（$D$ 足够大使两段不重叠），则 $r^{-1}(y) = y - D$，$r(\mathcal{X}_r) = [D, D+1]$。定义
$$\Phi(x) = \begin{cases} x + D + \delta & x \in [0, 1] \\ x + C & x \in [D, D+1] \end{cases}$$
之间光滑插值保持全局 Lipschitz。则 $\varepsilon_r = \delta$（任意小），而对 $y \in [D, D+1]$：$\|\Phi(y) - r^{-1}(y)\| = |y + C - (y - D)| = |C + D|$，可取任意大。$\square$

> **注**：推论 5 的本质是：在不引入互逆采样对的框架下，知识拟合关系在度量空间上是**有向的**——$\Phi$ 拟合 $r$ 与拟合 $r^{-1}$ 是两个独立的约束，前者不蕴含后者。

---

**推论 6（决策边界的局部曲率爆炸，Decision Boundary Curvature Explosion）**：设 IDFS $(F, \sigma)$ 如 §1.2 所定义。若 f-链第 $j$ 步中，近似状态 $\hat{h}_{j-1}$ 与理想状态 $h^*_{j-1}$ 被 $\sigma$ 选到了不同的函数——即 $\sigma(\hat{h}_{j-1}) = f_k \neq f_{k'} = \sigma(h^*_{j-1})$——且两函数在 $\hat{h}_{j-1}$ 处的输出差有宏观下界：

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

> **注（结构性含义）**：推论 6 刻画了 IDFS 的一类结构性脆弱点——当轨道漂移导致 $\hat{h}_{j-1}$ 与 $h^*_{j-1}$ 跨越 $\sigma$-决策边界时，路径局部 Lipschitz $L_j$ 急剧放大，$\Lambda_l$ 爆炸，CAC 误差界退化为无效约束。这是 IDFS 定义本身的代价：$\sigma$ 将连续状态空间映射到离散函数集，**边界天然是不连续的**。推论 6 为分析此类不稳定路径提供了量化机制。
