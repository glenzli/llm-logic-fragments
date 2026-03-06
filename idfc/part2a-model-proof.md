# IDFC · Part 2a：数学建模与 CAC 定理证明

> **前置**：见 [Part 1 导论](part1-intro.md) 了解非正式动机与预测概览。
>
> **本文内容**：§1 形式定义（语义空间 $(\mathcal{X},d)$、原语集 $R$/完整变换空间 $\Omega$；**IDFS 泛化定义** $(F,\sigma)$——纯抽象理论，不预设神经网络）；§2 核心假说 CAC 的严格抽象陈述；§3 定理完整证明（Telescope 展开 + UAT 补充 + TSC 框架）。神经网络的具体代数实例化见 [**Part 2c**](part2c-nn-algebraic.md)。
>
> **后续**：[Part 3](part3-deductions.md) 从本文定理推导全部推论；[Part 4](part4-empirical.md) 以 Transformer/Mamba/MoE 等架构分析与多组实验场景（幻觉、ICL、量化、Reversal Curse、Sycophancy 等）验证并锚定本文理论预测。

---

## 第一部分：数学模型的构造

## 1. 基本设定

### 1.1 逻辑空间与原始逻辑原语

#### 第一层：语义状态空间 $\mathcal{X}$

设 $(\mathcal{X}, d)$ 为**语义状态空间**——赋予了度量 $d$ 的集合，元素代表所有可能的语义表示（token 序列、中间推理状态、知识断言等）。$\mathcal{X}$ 满足：

- 元素 $x \in \mathcal{X}$ 代表一个完整的语义状态（输入、中间步骤、输出均可）
- 度量 $d: \mathcal{X} \times \mathcal{X} \to \mathbb{R}_{\geq 0}$ 由具体任务赋予，无需是 Euclidean 范数，亦无需向量空间结构
- 度量的唯一作用：支持 Lipschitz 函数的定义 $\bigl(d(f(x), f(y)) \leq L \cdot d(x,y)\bigr)$ 和单步近似误差 $\varepsilon_i$ 的测量——这是 CAC Telescope 展开所需的全部度量性质（见 §3.2）

#### 第二层：完整变换空间 $\Omega$

定义 $\mathcal{X}$ 上所有可能的变换构成的**完整变换空间**：

$$\Omega = \{ \phi : \mathcal{X} \to \mathcal{X} \}$$

$\Omega$ 包含了**一切可能的语义状态变换**——事实检索、语法变换、数学推导、类比映射、因果推理、字面复现、格式转换……凡是能将一个语义状态映射到另一个语义状态的规则，不论是否具有"逻辑"结构，都是 $\Omega$ 的元素。

$\Omega$ 在函数复合下构成一个**幺半群**（monoid）：

$$\phi_2 \circ \phi_1 \in \Omega, \quad \text{id}_{\mathcal{X}} \in \Omega$$

即两个语义变换的串联仍是语义变换，且存在平凡的"什么都不做"操作。

#### 第三层：原始生成元集 $R$ 与封闭包 $R^*$

**定义（原始逻辑原语）**：设

$$R = \{r_1, r_2, \ldots, r_m\} \subset \Omega$$

为从 $\Omega$ 中选出的有限**生成元子集**，代表语言中已知或未知的基础推理规则。$R^*$ 为 $R$ 在复合运算下的**自由幺半群**（即所有有限长度复合的集合）：

$$R^* = \{ r_{i_k} \circ \cdots \circ r_{i_1} \mid k \geq 0,\ r_{i_j} \in R \}$$

$R^*$ 是"$R$ 能够描述的一切推理过程"的完整边界。本文的核心假说 **CAC（Compositional Approximation Closure，组合近似封闭性，见 §2）** 主张：任意满足**输入驱动函数系统**（Input-Driven Function System，**IDFS**；形式定义见 §1.2）条件的 $(F, \sigma)$，均能在误差范围内近似覆盖 $R^*$——即只要 $R$ 能组合到达的推理结论，$F$ 也能通过输入驱动的组合近似地到达。神经网络（矩阵 + 激活函数）是 IDFS 的一个代数实例，在 §1.3 严格推导；CAC 作为抽象定理对任意 IDFS 成立，不预设具体实现机制。

**注意**：
- $R$ 不要求是干净的、正交的或可解释的；$\Omega$ 中有大量元素不属于 $R$，也不影响模型行为
- $R$ 可以包含人类尚未命名的隐式规则——$R$ 的边界由训练数据所能描述的推理结构决定，而非人为枚举
- $m$ 可以很大，但 $R$ 对 $\Omega$ 而言是稀疏的：实际语言使用中反复出现的推理模式远少于全集

### 1.2 输入驱动函数系统（IDFS）：泛化定义

IDFC 框架适用于任意满足以下三条的 $(F, \sigma)$——神经网络是其中一个实例，在 §1.3 专门推导。

**定义（$(F, \sigma)$ 结构）**：称一个**输入驱动函数系统**为有序对 $(F, \sigma)$，其中：

1. **函数集** $F = \{f_1, f_2, \ldots, f_M\} \subset \mathrm{Lip}_L(\mathcal{X})$：$F$ 是 $\mathcal{X}$ 上有限个 $L$-Lipschitz 函数的集合，$M$ 为系统规模。

2. **选择映射** $\sigma : \mathcal{X} \to F$：一个将当前状态映射到下一步函数的映射。$\sigma(x)$ 给出当状态为 $x$ 时被激活的函数。

由此，单步递推**唯一确定**为：

$$x_{l+1} = \sigma(x_l)\bigl(x_l\bigr)$$

即：当前状态 $x_l$ 先通过 $\sigma$ 选出函数，再被该函数作用于自身。**$f_j$ 的选择由 $f_i(x)$ 决定，而非自由选取**——这是 IDFS 区别于自由函数复合（$\Omega^*$ 的自由幺半群）的核心约束。

**注（Voronoi 划分）**：选择映射 $\sigma$ 自然诱导 $\mathcal{X}$ 的一个划分：

$$\mathcal{X}_j \;\triangleq\; \sigma^{-1}(f_j) \;=\; \{x \in \mathcal{X} : \sigma(x) = f_j\}$$

$\{\mathcal{X}_j\}_{j=1}^M$ 构成 $\mathcal{X}$ 的**状态区域划分**（Voronoi 剖分）。单步递推等价地写为：

$$x_{l+1} = \sum_{j=1}^M \mathbb{I}(x_l \in \mathcal{X}_j) \cdot f_j(x_l)$$

对 MLP-ReLU，$\mathcal{X}_j$ 是仿射超平面划分出的分段线性区域（$\sigma$ 分段常数）；对 softmax Transformer，$\sigma$ 是软性加权，$\mathcal{X}_j$ 退化为软边界区域。两种情形均在此框架内。

**CAC 对 $(F, \sigma)$ 的最小要求**（恰好是上述三条，不多也不少）：

| 要求 | 形式 | CAC 中的作用 |
|---|---|---|
| 输入驱动可复合 | $\sigma: \mathcal{X} \to F$ 存在 | 定义 $f$-链的单步递推 |
| 逐点近似 | $\|\sigma(x)(x) - r_i(x)\| \leq \varepsilon_i$ | Telescope 展开项（A） |
| Lipschitz 一致性 | $x \mapsto \sigma(x)(x)$ 是 $L$-Lipschitz | Telescope 展开项（B） |

矩阵代数结构（$F \subset \mathcal{M}_d(\mathbb{R})$）不是 CAC 的逻辑前提，而是神经网络这个具体实例满足上述三条的**实现方式**，在 §1.3 作为定理推导。

> **逻辑进路**：本节给出 $(F, \sigma)$ 的泛化定义及 CAC 所需的最小约束。§1.3 证明标准神经网络（矩阵 + 激活函数结构）诱导的 $(F, \sigma)$ 满足 $F \subset \mathcal{M}_d(\mathbb{R})$，将"$F$ 是矩阵族"从直觉升级为可证明的定理。§1.4 在此推导的基础上给出 $F$ 的完整形式定义。


> **神经网络代数化**：标准神经网络（矩阵 + 激活函数结构）诱导的 $(F, \sigma)$ 满足上述 IDFS 定义的全部三个条件，并额外具有 $F \subset \mathcal{M}_d(\mathbb{R})$ 的矩阵代数结构。完整推导（Nemytskii 算子场、Theorem 1.3、激活路径、$f$-chain、拟合关系、生成过程、OC、TSC/AdamW）见 [**Part 2c §1–§8**](part2c-nn-algebraic.md)。

---

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

