# IDFC · Part 2a：数学建模与 CAC 定理证明

> **前置**：见 [Part 1 导论](part1-intro.md) 了解非正式动机与预测概览。
>
> **本文内容**：§1 形式定义（语义空间 $(\mathcal{X},d)$、原语集 $R$/完整变换空间 $\Omega$；**IDFS 泛化定义** $(F,\sigma)$——纯抽象理论，不预设神经网络）；§2 核心假说 CAC 的严格抽象陈述；§3 定理完整证明（Telescope 展开 + UAT 补充 + TSC 框架）。神经网络的具体代数实例化见 [**Part 2c**](part2c-nn-algebraic.md)。
>
> **后续**：[Part 3](part3-deductions.md) 从本文定理推导全部推论；[Part 4](part4-empirical.md) 以 Transformer/Mamba/MoE 等架构分析与多组实验场景（幻觉、ICL、量化、Reversal Curse、Sycophancy 等）验证并锚定本文理论预测。

---

## 第一部分：数学模型的构造

## 1. 基本设定

### 1.1 状态空间、变换空间与原语集

设 $(\mathcal{X}, d)$ 为度量空间，称为**状态空间**。

定义**变换空间**：

$$\Omega = \{ \phi : \mathcal{X} \to \mathcal{X} \}$$

$\Omega$ 在函数复合下构成**幺半群**：$\phi_2 \circ \phi_1 \in \Omega$，$\text{id}_{\mathcal{X}} \in \Omega$。

定义**原语集** $R$ 为 $\Omega$ 的一个有限子集：

$$R = \{r_1, r_2, \ldots, r_m\} \subset \Omega$$

$R^*$ 为 $R$ 在复合运算下的**自由幺半群**：

$$R^* = \{ r_{i_k} \circ \cdots \circ r_{i_1} \mid k \geq 0,\ r_{i_j} \in R \}$$


### 1.2 输入驱动函数系统（IDFS）与全局演化算子

**定义（输入驱动函数系统，Input-Driven Function System，IDFS）**：称有序对 $(F, \sigma)$ 为**输入驱动函数系统**，其中：

1. **函数集** $F = \{f_1, f_2, \ldots, f_M\}$：$\mathcal{X}$ 上有限个函数的集合。

2. **选择映射** $\sigma : \mathcal{X} \to F$：将当前状态映射到下一步函数的映射。

定义**全局演化算子** $\Phi: \mathcal{X} \to \mathcal{X}$ 为：

$$\Phi(x) \triangleq \sigma(x)(x)$$

单步递推由此唯一确定：$x_{l+1} = \Phi(x_l)$。

**假设（系统级 Lipschitz 约束）**：要求全局演化算子 $\Phi \in \mathrm{Lip}_L(\mathcal{X})$，即：

$$d\bigl(\Phi(x),\, \Phi(y)\bigr) \leq L \cdot d(x, y) \quad \forall\, x, y \in \mathcal{X}$$

### 1.3 单步拟合与 f-chain

**定义（单步拟合）**：设 $r_i \in R$。定义 IDFS 对 $r_i$ 的**拟合误差**为：

$$\varepsilon_i \;\triangleq\; \sup_{x \in \mathcal{X}} \bigl\|\Phi(x) - r_i(x)\bigr\|$$

记 $\varepsilon_{\max} = \max_i \varepsilon_i$。

**定义（f-chain）**：设 $r$-链 $q = r_{i_l} \circ \cdots \circ r_{i_1} \in R^*$。定义对应的 **f-chain** 为递推序列：

$$\hat{h}_0 = x, \qquad \hat{h}_j = \Phi(\hat{h}_{j-1}), \quad j = 1, \ldots, l$$

---

## 2. CAC 定理

**定理（组合近似封闭性，Compositional Approximation Closure，CAC）**：设 $(F, \sigma)$ 为 IDFS，全局演化算子 $\Phi \in \mathrm{Lip}_L(\mathcal{X})$（§1.2），对原语集 $R$ 的拟合误差上界为 $\varepsilon_{\max}$（§1.3）。

则对任意 $r$-链 $q = r_{i_l} \circ \cdots \circ r_{i_1} \in R^*$ 和初始状态 $x \in \mathcal{X}$，设真实 $r$-链轨迹 $h_j^* = r_{i_j}(h_{j-1}^*)$（$h_0^* = x$），f-chain 轨迹 $\hat{h}_j = \Phi(\hat{h}_{j-1})$（$\hat{h}_0 = x$），则：

$$\bigl\|\hat{h}_l - h_l^*\bigr\| \;\leq\; \varepsilon_{\max} \cdot \frac{L^l - 1}{L - 1}$$

（$L = 1$ 时右端取极限值 $l \cdot \varepsilon_{\max}$。）

**证明**：令 $e_j = \|\hat{h}_j - h_j^*\|$，$e_0 = 0$。第 $j$ 步：

$$e_j = \|\Phi(\hat{h}_{j-1}) - r_{i_j}(h_{j-1}^*)\|$$

插入虚拟中间量 $\Phi(h_{j-1}^*)$，三角不等式：

$$e_j \;\leq\; \underbrace{\|\Phi(\hat{h}_{j-1}) - \Phi(h_{j-1}^*)\|}_{\text{系统漂移项}} \;+\; \underbrace{\|\Phi(h_{j-1}^*) - r_{i_j}(h_{j-1}^*)\|}_{\text{单步拟合项}}$$

- **系统漂移项**：$\Phi \in \mathrm{Lip}_L$ 直接给出 $\leq L \cdot e_{j-1}$。
- **单步拟合项**：由 §1.3 定义，$\leq \varepsilon_{\max}$。

递推关系：$e_j \leq L\,e_{j-1} + \varepsilon_{\max}$，$e_0 = 0$。逐步展开：

$$e_1 \leq \varepsilon_{\max}$$
$$e_2 \leq \varepsilon_{\max} + L \cdot \varepsilon_{\max} = \varepsilon_{\max}(1 + L)$$
$$e_3 \leq \varepsilon_{\max} + L \cdot \varepsilon_{\max}(1+L) = \varepsilon_{\max}(1 + L + L^2)$$
$$\vdots$$
$$e_l \leq \varepsilon_{\max}(1 + L + L^2 + \cdots + L^{l-1}) = \varepsilon_{\max} \cdot \frac{L^l - 1}{L - 1}$$
$\square$

**推论 1（界的紧性）**：设 $\varepsilon_{\max} > 0$。则存在初始状态 $x \in \mathcal{X}$ 和 $r$-链 $q \in R^*$，使得对应 f-chain 满足：

$$e_l \;\geq\; \varepsilon_{\max} \cdot \frac{L^l - 1}{L - 1}$$

即上界在最坏情形下恰好可达。

**证明**：取 $r^* \in R$ 使 $\varepsilon_{r^*} = \varepsilon_{\max}$，构造常值链 $q = r^* \circ \cdots \circ r^*$（长度 $l$）。对第 $j$ 步，选取 $x$ 使 $\|\Phi(h_0^*) - r^*(h_0^*)\| = \varepsilon_{\max}$，并要求每步虚拟拟合误差向量 $\Phi(h_{j-1}^*) - r^*(h_{j-1}^*)$ 与漂移向量 $\Phi(\hat{h}_{j-1}) - \Phi(h_{j-1}^*)$ 方向一致（内积非负），则三角不等式无抵消，每步取等：

$$e_j = L \cdot e_{j-1} + \varepsilon_{\max}$$

归纳展开：$e_l = \varepsilon_{\max}(1 + L + \cdots + L^{l-1}) = \varepsilon_{\max} \cdot \dfrac{L^l - 1}{L - 1}$。$\square$

**结论**：定理与推论 1 合并，任意 IDFS 在组合 $l$ 步后的最坏情形误差**精确为**：

$$e_l^* = \varepsilon_{\max} \cdot \frac{L^l - 1}{L - 1}$$

降低链路误差有且仅有两条路径：压低单步拟合误差 $\varepsilon_{\max}$，或控制 Lipschitz 常数 $L$。

**推论 2（有效推理深度）**：设容忍误差为 $\delta > 0$。则使 $e_l \leq \delta$ 的最大链长为：

$$l^* = \left\lfloor \frac{\log\!\left(1 + \dfrac{\delta(L-1)}{\varepsilon_{\max}}\right)}{\log L} \right\rfloor \quad (L > 1), \qquad l^* = \left\lfloor \frac{\delta}{\varepsilon_{\max}} \right\rfloor \quad (L = 1)$$

**证明**：由 CAC 定理，$e_l \leq \delta$ 等价于：

$$\varepsilon_{\max} \cdot \frac{L^l - 1}{L - 1} \leq \delta$$

**$L > 1$**：解不等式 $L^l \leq 1 + \dfrac{\delta(L-1)}{\varepsilon_{\max}}$，两边取以 $L$ 为底的对数：

$$l \leq \frac{\log\!\left(1 + \dfrac{\delta(L-1)}{\varepsilon_{\max}}\right)}{\log L}$$

取下整即得 $l^*$。$l^*$ 关于 $L$ 单调递减：$L$ 增大时分子增速（对数）慢于分母增速，故 $L$ 越大 $l^*$ 越小；当 $L \to 1^+$ 时 $l^* \to \infty$，此为极限最优（即 $L = 1$ 的情形）。

**$L = 1$**：$\dfrac{L^l - 1}{L-1}$ 取极限为 $l$，不等式化为 $l \cdot \varepsilon_{\max} \leq \delta$，解得 $l^* = \left\lfloor \dfrac{\delta}{\varepsilon_{\max}} \right\rfloor$。$\square$

**推论 3（饱和体制，$L < 1$）**：设 $\Phi \in \mathrm{Lip}_L(\mathcal{X})$ 且 $L < 1$。则对任意 $r$-链 $q \in R^*$，无论链长 $l$ 多大，f-chain 误差满足：

$$e_l \;\leq\; \frac{\varepsilon_{\max}}{1 - L}$$

即误差有全局上界，不随链长增长。

**证明**：由 CAC 定理，$e_l \leq \varepsilon_{\max} \cdot \dfrac{L^l - 1}{L - 1} = \varepsilon_{\max} \cdot \dfrac{1 - L^l}{1 - L}$（$L < 1$ 时分母 $1-L > 0$）。由 $L^l \geq 0$ 得 $\dfrac{1 - L^l}{1 - L} \leq \dfrac{1}{1 - L}$。$\square$

**推论（Banach 不动点）**：若 $L < 1$ 且 $(\mathcal{X}, d)$ 完备，则 $\Phi$ 存在唯一不动点 $x^* = \Phi(x^*)$，f-chain 从任意初始状态收敛：$\hat{h}_l \to x^*$。

**推论 4（路径依赖精细化界）**：设 f-chain 轨迹经过的各步局部 Lipschitz 常数为 $L_j \triangleq \mathrm{Lip}(\Phi \!\restriction_{\hat{h}_{j-1}})$，各步拟合误差为 $\varepsilon_{i_j}$。则：

$$e_l \;\leq\; \sum_{j=1}^{l} \varepsilon_{i_j} \cdot \prod_{k=j+1}^{l} L_k$$

其中空积（$j = l$ 项）定义为 1。特别地，取 $\varepsilon_{i_j} \leq \varepsilon_{\max}$，即得：

$$e_l \;\leq\; \varepsilon_{\max} \cdot \sum_{j=1}^{l} \prod_{k=j+1}^{l} L_k$$

**证明**：对递推 $e_j \leq L_j \cdot e_{j-1} + \varepsilon_{i_j}$，$e_0 = 0$，逐步展开：

$$e_l \leq \varepsilon_{i_1} \!\cdot\! \prod_{k=2}^{l} L_k \;+\; \varepsilon_{i_2} \!\cdot\! \prod_{k=3}^{l} L_k \;+\; \cdots \;+\; \varepsilon_{i_{l-1}} \!\cdot\! L_l \;+\; \varepsilon_{i_l}$$

收项即得结论。当所有 $L_j = L$ 时，$\displaystyle\sum_{j=1}^{l} L^{l-j} = \frac{L^l - 1}{L-1}$，退化为 CAC 定理。$\square$

**定义（累积放大系数）**：

$$\Lambda_l \;\triangleq\; \sum_{j=1}^{l} \prod_{k=j+1}^{l} L_k$$

其中空积（$j = l$ 项）定义为 $1$。精细界化简为：

$$e_l \;\leq\; \varepsilon_{\max} \cdot \Lambda_l$$

**备注（$\Lambda_l$ 的渐近行为）**：$\Lambda_l$ 完全由路径上的 $\{L_j\}$ 决定，$L_j > 1$ 与 $L_j < 1$ 的效果自然在乘积中抵消：

| 条件 | $\Lambda_l$ 行为 |
|---|---|
| $\prod_{k=1}^l L_k \to \infty$（扩张主导） | $\Lambda_l$ 指数增长，退化为 CAC 全局界 |
| $\forall j: L_j \leq 1$（每步非扩张） | $\Lambda_l \leq l$，线性增长 |
| $\sum_{j=1}^{\infty} \prod_{k=j+1}^{\infty} L_k < C$（收缩步充分多） | $\Lambda_\infty \leq C$，全局有界 |

---

<!-- 以下为旧版 §2，保留供参考，待整理 -->

## 2. 核心假说：组合近似封闭性

#### 前提设定

设训练原语集为：

$$R_{\text{tr}} \;=\; \{r_1, r_2, \ldots, r_m\} \;\subset\; R \;\subset\; \Omega$$

**定义（单步拟合误差）**：对每个 $r_i \in R_{\text{tr}}$，训练后的网络 $F$ 对应的有效算子场 $E_{r_i}: \mathcal{X} \to \langle F \rangle_\cdot$ 的**实际逐点误差**定义为：

$$\varepsilon_i \;\triangleq\; \sup_{x \in \mathcal{X}} \|E_{r_i}(x)\cdot x - r_i(x)\|$$

$\varepsilon_i$ 是**定义量**，不是假设——对任意 $F$ 和任意 $r_i$，此上确界总是存在的。**万能逼近定理（UAT）** 保证：对 $\mathcal{X}$ 上的任意连续函数 $r_i$，当模型规模 $M$ 充分大时，$\varepsilon_i$ 可以被压制到任意小（存在性 + 精度控制，详见 §3.3）。

设 $\varepsilon_{\max} = \max_i \varepsilon_i$，$L = \max_i \|G_i\|_{\mathrm{Lip}}$（最大逐层 Lipschitz 常数，由 §1.6.D）。$L$ 同时是以下两类函数的 Lipschitz 上界：（1）$r_i$ 的 Lipschitz 常数（语义变换的固有属性）；（2）$x \mapsto E_{r_i}(x)\cdot x$ 的 Lipschitz 常数（§1.7 拟合定义的 Lipschitz 一致性条件）。两者相等是 Telescope 展开（§3.2）在 f-chain 复合下给出统一界 $L^l$ 的隐含前提——凡是 $L_c > L$ 的内容路径（如逐字记忆，见 §25.1 定理 25.1a），CAC 定理在该路径上不适用，不构成合法的 $r_i \in R_{\text{tr}}$。

**未见任务集**：由 $R_{\text{tr}}$ 的有限复合可以描述但未在训练分布中出现的任务：

$$Q_{\text{unseen}} \;=\; \bigl\{q = r_{i_l}\!\circ\!\cdots\!\circ\! r_{i_1} \;\big|\; \mathbf{r} \in R_{\text{tr}}^{\,l},\; l \geq 2,\; q \notin R_{\text{tr}}\bigr\} \;\subset\; R^* \setminus R_{\text{tr}}$$

#### 定理（CAC 误差界）——严格版本

> **定理（CAC）**：设 $\varepsilon_i$ 为训练后 $F$ 对 $r_i \in R_{\text{tr}}$ 的实际单步误差（如上定义），$L$ 为链路最大 Lipschitz 常数。则对任意长度为 $l$ 的未见任务 $q = r_{i_l}\!\circ\!\cdots\!\circ\! r_{i_1} \in Q_{\text{unseen}}$，以各层拟合算子场逐步复合的 $F$-链：
>
> $$\hat{h}_0 = x, \quad \hat{h}_j = E_{r_{i_j}}(\hat{h}_{j-1})\cdot\hat{h}_{j-1}$$
>
> 严格满足：
>
> $$\forall x \in \mathcal{X}: \quad \left\| \hat{h}_l \;-\; q(x) \right\| \;\leq\; \varepsilon_{\max} \cdot \frac{L^l - 1}{L - 1}$$
>
> 此界由 Lipschitz 望远镜展开严格推导（见 §3.2），不依赖任何额外假设——$\varepsilon_i$ 和 $L$ 均为训练后网络的**可测定义量**。
>
> **推论**：UAT（§3.3）保证 $\varepsilon_{\max} \to 0$ 当 $M \to \infty$，此时对固定链长 $l$ 和 $L$，误差界趋于零。

#### 代数含义

CAC 断言**逐点拟合关系在复合运算下近似传递**：映射

$$\rho: R_{\text{tr}} \to \mathrm{Map}\!\bigl(\mathcal{X},\, \langle F \rangle_\cdot\bigr), \quad r_i \mapsto E_{r_i}$$

> **注（$\rho$ 的纯数值语义）**：$\rho$ 是**数值配对映射**，将 $r_i \in R_{\text{tr}}$ 与满足逐点拟合约束 $\|E_{r_i}(x)\cdot x - r_i(x)\| \leq \varepsilon_i$（§1.7）的矩阵值函数 $E_{r_i}$ 配对。$\rho$ 不蕴含因果、语义等价或功能对应——$E_{r_i}(x)$ 是满足数值不等式的矩阵乘积，下标 $r_i$ 为分析者外加的命名约定（§1.3 语义防火墙）。

在复合意义下，$\rho$ 构成从自由幺半群 $R_{\text{tr}}^*$ 到 $\langle F \rangle_\cdot$-值函数链的**近似幺半群同态**：

$$\rho(r_l \circ \cdots \circ r_1) \;\approx\; \rho(r_l) \cdot_{\text{chain}} \cdots \cdot_{\text{chain}} \rho(r_1) \quad \text{（误差 }\leq \varepsilon_{\max}(L^l-1)/(L-1)\text{）}$$

精确叙述：对 $q = r_l \circ \cdots \circ r_1 \in Q_{\text{unseen}}$，存在矩阵乘积链 $E_{r_l}(\hat{h}_{l-1})\cdots E_{r_1}(x)$，使得其在 $x$ 上的作用结果与 $q(x)$ 的偏差 $\leq \varepsilon_{\max}(L^l-1)/(L-1)$——**组合是免费的，代价仅在误差随 $l$ 和 $L$ 增长**。对比原语的单步情形：对每个 $r_i \in R_{\text{tr}}$，训练后存在 $E_{r_i}: \mathcal{X} \to \langle F \rangle_\cdot$ 满足 $\|E_{r_i}(x)\cdot x - r_i(x)\| \leq \varepsilon_i$；训练的作用是使这些矩阵值函数的上确界误差 $\varepsilon_i$ 足够小，而非使 $F$ 中出现具有 $r_i$ 语义的功能单元。

> [!IMPORTANT]
> **CAC 误差界本身是严格定理**，无经验性前提——$\varepsilon_i$ 由定义给出，误差界是代数推论。§3.4 定理 3.3 证明训练过程将 $\bar{L}$ 锁定在 $1 + \epsilon$（Edge of Chaos），$\epsilon \leq \ln C_{\text{train}}/k$，有效推理链长上界 $l^* \approx k\ln(1/\varepsilon_{\max})/\ln C_{\text{train}}$。
>
> **开放问题**：**覆盖性**——目标任务是否真的在 $Q_{\text{unseen}}$（即可分解为 $R_{\text{tr}}$ 的有限复合），这取决于 $R_\text{tr}$ 对自然语言推理原语的覆盖度，目前无法形式化。



---

## 3. 误差分析：CAC 定理的完整证明

本节给出 §2 中 CAC 定理的严格证明。**CAC 定理的证明在 §3.2（Telescope 展开）处完整结束**——$\varepsilon_i$ 是定义量（见 §2），不需要 UAT 作为前提。§3.3 是独立的补充结果，分析模型规模 $M$ 对 $\varepsilon_{\max}$ 数值大小的渐近影响。§3.4 是关于神经网络（AdamW）满足 TSC 的具体推导，已移至 [Part 2c §8](part2c-nn-algebraic.md)；此处只保留 TSC 的抽象接口定义（定义与定理 3.3）。

### 3.1 符号统一与单步误差

**符号对齐**：§1.6 定义了逐点拟合：对 $r_i \in R_{\text{tr}}$，存在矩阵值函数 $E_{r_i}: \mathcal{X} \to \langle F \rangle_\cdot$ 使得：

$$\hat{f}_i(x) \triangleq E_{r_i}(x) \cdot x, \qquad \|\hat{f}_i(x) - r_i(x)\| \leq \varepsilon_i \quad \forall x \in \mathcal{X}$$

其中 $\varepsilon_i \triangleq \sup_{x \in \mathcal{X}} \|E_{r_i}(x) \cdot x - r_i(x)\|$（§2 的定义量）。$\hat{f}_i$ 是"用当前输入选出的矩阵作用于当前输入"，不是固定矩阵。

为简洁，以下记 $\hat{f}_j \equiv \hat{f}_{r_{i_j}}$（第 $j$ 步对应的近似函数），$\varepsilon_j \equiv \varepsilon_{i_j}$。

---

### 3.2 链路误差的 Telescope 展开（CAC 定理的完整证明）

**定理（CAC 误差界，完整证明）**：设 $q = r_{i_l} \circ \cdots \circ r_{i_1}$ 为长度 $l$ 的 $r$-链，$f$-链递推定义为：

$$\hat{h}_0 = x, \qquad \hat{h}_j = \hat{f}_j(\hat{h}_{j-1}) = E_{r_{i_j}}(\hat{h}_{j-1}) \cdot \hat{h}_{j-1}$$

设真实 $r$-链的中间状态为 $h_0^* = x$，$h_j^* = r_{i_j}(h_{j-1}^*)$。则：

$$\|\hat{h}_l - h_l^*\| \leq \varepsilon_{\max} \cdot \frac{L^l - 1}{L - 1}$$

**证明**：

定义第 $j$ 步的累积误差 $e_j = \|\hat{h}_j - h_j^*\|$。

**初始条件**：$e_0 = \|\hat{h}_0 - h_0^*\| = \|x - x\| = 0$。

**第 $j$ 步的递推不等式**：

$$e_j = \|\hat{h}_j - h_j^*\| = \|\hat{f}_j(\hat{h}_{j-1}) - r_{i_j}(h_{j-1}^*)\|$$

插入中间量 $r_{i_j}(\hat{h}_{j-1})$，应用三角不等式：

$$e_j \leq \underbrace{\|\hat{f}_j(\hat{h}_{j-1}) - r_{i_j}(\hat{h}_{j-1})\|}_{\text{（A）单步拟合误差}} + \underbrace{\|r_{i_j}(\hat{h}_{j-1}) - r_{i_j}(h_{j-1}^*)\|}_{\text{（B）$r_{i_j}$ 的 Lipschitz 传播}}$$

- **项（A）**：由逐点拟合定义，$\|\hat{f}_j(y) - r_{i_j}(y)\| \leq \varepsilon_{i_j} \leq \varepsilon_{\max}$，对任意 $y$ 成立，故取 $y = \hat{h}_{j-1}$ 得 $\text{(A)} \leq \varepsilon_{\max}$。

- **项（B）**：$r_{i_j}$ 是 $L$-Lipschitz 函数（$L$ 为全局最大逐层 Lipschitz 常数，由 §1.6.D 命题 1.1），故 $\text{(B)} \leq L \cdot \|\hat{h}_{j-1} - h_{j-1}^*\| = L \cdot e_{j-1}$。

得递推关系：

$$e_j \leq \varepsilon_{\max} + L \cdot e_{j-1}, \qquad e_0 = 0$$

**展开递推**（Telescope 展开）：

$$e_1 \leq \varepsilon_{\max}$$
$$e_2 \leq \varepsilon_{\max} + L\varepsilon_{\max} = \varepsilon_{\max}(1 + L)$$
$$e_3 \leq \varepsilon_{\max} + L \cdot \varepsilon_{\max}(1 + L) = \varepsilon_{\max}(1 + L + L^2)$$
$$\vdots$$
$$e_l \leq \varepsilon_{\max}(1 + L + L^2 + \cdots + L^{l-1}) = \varepsilon_{\max} \cdot \frac{L^l - 1}{L - 1}$$

（$L = 1$ 时几何级数退化为 $l$，即 $e_l \leq l \cdot \varepsilon_{\max}$。）$\square$

> **注（$L$ 的来源）**：项（B）使用 $r_{i_j}$ 是 $L$-Lipschitz。$r_{i_j} \in \Omega$ 是语义空间上的变换，其 Lipschitz 常数原则上由训练数据决定。在 IDFC 框架中，$L$ 取的是所有步骤中最大的 Lipschitz 常数，即 $L = \max_j \|G_{i_j}\|_{\text{Lip}}$（由 §1.6.D 命题 1.1 给出的累积 Lipschitz 常数的单步版本）。精确地，$L$ 应是 $r_{i_j}$ 的 Lipschitz 常数，此处以网络层的 Lipschitz 常数代理。

> **注（证明的保守性）**：Telescope 展开对 $j$ 步的误差均取上界 $\varepsilon_{\max}$（而非各步实际的 $\varepsilon_{i_j}$），并对 Lipschitz 传播取全局最大 $L$。当各步误差和 Lipschitz 常数差异显著时，实际误差远低于此界。

> **注（Telescope 界的紧性——存在性下界）**：上界在最坏情形下可达，与训练机制无关。构造：选取目标链 $q = r_{i_l} \circ \cdots \circ r_{i_1}$ 使每步近似误差向量 $\delta_j \triangleq \hat{f}_j(\hat{h}_{j-1}) - r_{i_j}(\hat{h}_{j-1})$ 与累积误差 $(\hat{h}_{j-1} - h_{j-1}^*)$ 方向一致（无抵消）。则 Telescope 递推中每个 $\leq$ 均取等，给出存在性下界：
>
> $$\exists\, x,\, q:\quad e_l \;\geq\; \varepsilon_{\min} \cdot \frac{L^l - 1}{L - 1}$$
>
> 此界仅依赖 $\varepsilon_{\min} > 0$（最小单步误差）和任意 $L > 0$，不涉及训练假设。TSC 对 $L$ 的约束（§3.4）决定了该下界的具体增长速率。

---

### 3.3 模型规模与 $\varepsilon_{\max}$ 的渐近关系（UAT 补充结果，非 CAC 前提）

> **本节的逻辑地位**：CAC 定理（§3.2）已完整证明，且对任意 $\varepsilon_{\max}$ 值无条件成立——$\varepsilon_{\max}$ 是训练后模型的**定义量**，不是需要被保证的假设。本节回答一个独立的问题：**当模型规模 $M$ 增大时，$\varepsilon_{\max}$ 的理论下界能被压多低？** 这不影响 CAC 定理的逻辑有效性，只影响 $l^*$ 的数值大小。

**命题 3.1（UAT 存在性：充分大的模型可实现任意精度）**：设 $r_i : \mathcal{X} \to \mathcal{X}$ 在有界域 $\mathcal{X} \subset \mathbb{R}^d$ 上是连续函数。则对任意 $\varepsilon > 0$，存在规模 $M_0(\varepsilon, r_i)$ 和某个权重配置，使得当 $M \geq M_0$ 时，**理论上存在** $E_{r_i}: \mathcal{X} \to \langle F \rangle_\cdot$ 满足：

$$\sup_{x \in \mathcal{X}} \|E_{r_i}(x) \cdot x - r_i(x)\| \leq \varepsilon$$

> **重要边界**：命题 3.1 是**纯存在性定理**。它保证某个权重配置理论上可以实现该精度，但**不保证**梯度下降训练实际找到这个配置。实际训练的 $\varepsilon_{\max}$ 由训练后模型的实际误差决定——它是 CAC 框架中的可观测输入量，可能大于 UAT 理论下界。CAC 定理用的是实际的 $\varepsilon_{\max}$，不是 UAT 意义下的最优值。

**证明思路（UAT 到逐点拟合的桥接）**：

UAT（Cybenko 1989; Hornik 1991）经典陈述为：对 $\mathcal{X}$ 上的任意连续函数 $g: \mathbb{R}^d \to \mathbb{R}^d$ 和 $\varepsilon > 0$，存在有限宽度的浅层 MLP 使得均匀逼近误差 $< \varepsilon$。桥接步骤：（1）$r_i$ 连续性满足 UAT 前提；（2）UAT 保证存在某个 MLP $\tilde{f}_i$ 使 $\|\tilde{f}_i(x) - r_i(x)\| \leq \varepsilon$；（3）由 §1.6.B 代数结构，$\tilde{f}_i(x) = E(x)\cdot x$ 对某个 $E(x) \in \langle F \rangle_\cdot$ 成立，满足逐点拟合定义。UAT 仅给出存在性，不给出 $M_0$ 的显式公式。$\square$

**推论 3.2（理论精度渐近收敛——模型容量上界）**：对固定链长 $l$ 和固定 $L_{\max}$，若训练能达到 UAT 意义下的最优精度，则当 $M \to \infty$：

$$\varepsilon_{\max}^{\text{opt}}(M) \cdot \frac{L_{\max}^l - 1}{L_{\max} - 1} \xrightarrow{M \to \infty} 0$$

即：对任意有限复合长度的未见任务，充分大模型的**理论精度上限**可将 CAC 误差压制到任意小的 $\delta > 0$。实际训练的 $\varepsilon_{\max}$ 可能大于 $\varepsilon_{\max}^{\text{opt}}$——差值是训练效率问题，不是 CAC 框架的假设。

> **神经网络实例**：AdamW 训练满足 TSC 的严格证明（含权重衰减稳态界和谱范数推导），见 [**Part 2c §8**](part2c-nn-algebraic.md)。

---

### 3.4 神经网络训练-推理对偶性（TSC/AdamW）

> **本节内容已移至 [Part 2c §8](part2c-nn-algebraic.md)**。
>
> §8 给出 AdamW 训练满足训练稳定性契约（TSC）的严格证明，推导有效链长上界 $l^*$ 和不可能性下界（定理 3.3，命题 3.4）。CAC 框架的抽象界（§3.2 Telescope 展开 + §3.3 UAT 补充）在任意满足 TSC 的训练方法下均成立；神经网络的具体实现细节见 Part 2c §8。

