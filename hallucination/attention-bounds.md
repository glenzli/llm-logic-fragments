# Attention 的泛函界：从 IDFC 框架的第一性原理推导

> **前置**：本文在 `compositional-closure/theory.md`（IDFC 框架）定义的泛函空间中，从第一性原理推导 Attention 的两个核心结果：
> 1. **Lost in the Middle（LiM）的公式化定义**——在 $A(x)$ 算子框架下的精确刻画
> 2. **Attention 信息提取的最优界**——给定 Softmax 约束下信息提取的绝对上界
>
> 本文是 `type-iv-attention-dilution.md` 的理论基础层，将其现象级分析提升到算子层面的第一性原理推导。

---

## 1. 基础设定（继承 IDFC 框架）

从 `theory.md` §1.2 中，对序列位置 $i$，单头注意力的有效算子为：

$$E_i(x) = A_i(x) \cdot W_V W_O \in \mathcal{M}_d(\mathbb{R})$$

其中 **注意力权重向量** $A_i(x) = [\alpha_{i1}(x), \ldots, \alpha_{in}(x)]$ 是：

$$\alpha_{ij}(x) = \frac{\exp(s_{ij}/\sqrt{d_k})}{\sum_{j'=1}^{n} \exp(s_{ij'}/\sqrt{d_k})}, \qquad s_{ij} = (h_i W_Q)(h_j W_K)^\top$$

位置 $i$ 的输出：

$$o_i = \sum_{j=1}^{n} \alpha_{ij}(x) \cdot h_j W_V W_O = E_i(x) \cdot \bar{h}$$

其中 $\bar{h}$ 是将所有位置的 $h_j W_V W_O$ 堆叠后的有效状态矩阵。

**关键量**：对特定**关键信息位置** $j^*$，位置 $i$ 对其的**检索权重**（Retrieval Weight）为：

$$\mathcal{R}(i \leftarrow j^*) \triangleq \alpha_{i,j^*}(x) \in [0, 1]$$

这是 $A_i(x)$ 向量在 $j^*$ 分量上的值，是信息从 $j^*$ 流入 $i$ 的唯一通道的宽度。

---

## 2. Lost in the Middle：公式化定义

### 2.1 检索权重的位置剖面

**定义（检索剖面）**：对查询位置 $i$，其关于所有先前位置的检索权重构成**检索剖面**（Retrieval Profile）：

$$\mathcal{P}_i : \{1, \ldots, i-1\} \to [0, 1], \quad j \mapsto \alpha_{ij}(x)$$

$\mathcal{P}_i$ 是 Softmax 归一化的概率分布：$\sum_{j=1}^{i-1} \alpha_{ij} = 1$（加上自注意力项）。

**定义（边界区域与中间区域）**：设序列长度为 $n$，边界宽度参数 $b \in \mathbb{N}$，定义：

$$\text{Primacy}(b) = \{1, 2, \ldots, b\}, \quad \text{Recency}(b) = \{n-b, \ldots, n-1\}, \quad \text{Mid}(b) = \{b+1, \ldots, n-b-1\}$$

（Primacy = 开头区，Recency = 结尾区，Mid = 中间区）

### 2.2 Lost in the Middle 的精确定义

**定义（LiM——Lost in the Middle，严格版本）**：称序列在位置 $j^*$ 处对查询 $i$ 表现出 **Lost in the Middle**，若：

$$j^* \in \text{Mid}(b) \quad \text{且} \quad \mathcal{R}(i \leftarrow j^*) < \min\!\left(\min_{j \in \text{Primacy}(b)} \mathcal{R}(i \leftarrow j),\; \min_{j \in \text{Recency}(b)} \mathcal{R}(i \leftarrow j)\right)$$

即：中间区域关键位置的检索权重，严格低于开头区和结尾区内**所有位置**的检索权重。

**统计版本**（适用于实验验证）：

$$\mathbb{E}_x[\mathcal{R}(i \leftarrow j^*)] < \min\!\left(\mathbb{E}_x\!\left[\overline{\mathcal{R}}_{\text{Primacy}}\right],\, \mathbb{E}_x\!\left[\overline{\mathcal{R}}_{\text{Recency}}\right]\right)$$

其中 $\overline{\mathcal{R}}_{\text{Primacy}} = \frac{1}{b}\sum_{j \in \text{Primacy}(b)} \mathcal{R}(i \leftarrow j)$ 是边界区的平均检索权重。

### 2.3 LiM 的算子解释

在 IDFC 框架下，LiM 的本质是 **$f$-链路组装的局部失效**：

位置 $i$ 的有效算子 $E_i(x)$ 是所有位置有效算子的加权叠加：

$$E_i(x) = \sum_{j=1}^{n} \alpha_{ij}(x) \cdot \Phi_j \in \mathcal{M}_d(\mathbb{R})$$

其中 $\Phi_j = W_V^{(j)} W_O$ 是位置 $j$ 的单位算子贡献。**LiM 意味着中间位置的算子贡献权重系统性偏低**：关键信息 $\Phi_{j^*}$ 对 $E_i(x)$ 的贡献被稀释，等价于 $F$-链路在组装时"遗漏"了某条中间的 $r_{j^*}$ 算子。

**CAC 连接**：若 $j^*$ 的信息对应某个关键原语 $r_{j^*} \in R_{\text{tr}}$，则 LiM 导致 $E_{r_{j^*}}$ 的拟合误差增大至：

$$\varepsilon_{j^*}^{\text{LiM}} \geq (1 - \alpha_{i,j^*}) \cdot \|h_{j^*} W_V\|_2 \cdot \|W_O\|_2$$

这是 CAC 误差界中 $\varepsilon_{\max}$ 的一个**结构性下界**——LiM 现象直接给出了单步拟合误差的可测下确界。

### 2.4 LiM 的充分条件（严格推论）

**命题 2.4（LiM 的 Score 充分条件）**：若关键位置 $j^*$ 的注意力 score $s_{i,j^*}$ 满足：

$$s_{i,j^*} < \frac{1}{n} \sum_{j=1}^{n} s_{ij} \triangleq \bar{s}_i$$

即 $j^*$ 的 score 低于均值，则在均匀 score 基线下：

$$\alpha_{i,j^*} < \frac{1}{n}$$

此时若任意边界位置 $j_0 \in \text{Primacy}(b) \cup \text{Recency}(b)$ 满足 $s_{i,j_0} > \bar{s}_i$，则 $\alpha_{i,j_0} > \alpha_{i,j^*}$，LiM 成立。

**证明**：Softmax 单调性——$s_{ij} > s_{ij'} \iff \alpha_{ij} > \alpha_{ij'}$。$\square$

**推论 2.4a（LiM 的位置偏置根因）**：LiM 的结构性来源是**注意力 score 的位置偏置**。若模型在训练中因自回归预测的局部性而对近期 token（Recency）赋予系统性更高的 score，对早期显著 token（Primacy，如系统指令）通过特殊位置编码或 sink-token 机制赋予高 score，则中间位置在 score 上系统性偏低——LiM 成为训练诱导的**结构性必然**，而非偶发现象。

---

## 3. Attention 的最优信息提取界

### 3.1 信息提取问题的形式化

**问题设置**：设关键位置 $j^*$ 携带信息 $h_{j^*} \in \mathbb{R}^d$，目标是通过注意力机制将其准确提取到位置 $i$ 的输出中。提取的"完美目标"为：

$$o_i^* = h_{j^*} W_V W_O \triangleq v^* \in \mathbb{R}^d$$

实际输出为：

$$o_i = \sum_{j=1}^{n} \alpha_{ij} \cdot h_j W_V W_O = \alpha_{i,j^*} v^* + \sum_{j \neq j^*} \alpha_{ij} \cdot v_j$$

检索误差：

$$\|o_i - o_i^*\| = \left\|(1 - \alpha_{i,j^*}) v^* - \sum_{j \neq j^*} \alpha_{ij} v_j \right\| \cdot $$

等价地，用**检索保真度**（Retrieval Fidelity）刻画：

$$\mathcal{F}(i, j^*) = \alpha_{i,j^*} \in [0, 1]$$

$\mathcal{F} = 1$ 时完美提取（但物理上不可能，除非所有竞争者 score 为 $-\infty$）；$\mathcal{F} = 1/n$ 时均匀稀释。

### 3.2 Softmax 的最优集中界（严格推论）

**命题 3.2（Softmax 最优集中界）**：在 $n$ 个竞争位置中，通过调整 query $q_i$ 和 key $k_{j^*}$（即调整 $W_Q, W_K$），注意力权重 $\alpha_{i,j^*}$ 的理论最大值为：

$$\mathcal{F}^{\max}(i, j^*) = \frac{1}{1 + \displaystyle\sum_{j \neq j^*} \exp\!\left(\frac{s_{ij} - s_{ij^*}}{\sqrt{d_k}}\right)}$$

**证明**：Softmax 公式的直接代数变形，令 $s_{ij^*}$ 为参考值。$\square$

当所有竞争者的 score 远低于 $j^*$（$s_{ij} - s_{ij^*} \to -\infty$ for $j \neq j^*$）时，$\mathcal{F}^{\max} \to 1$。

**推论 3.2a（有限 Score 差下的最优界）**：设最大 score 差 $\Delta = \max_{j \neq j^*}(s_{ij} - s_{ij^*})$，则：

$$\mathcal{F}^{\max}(i, j^*) \leq \frac{1}{1 + (n-1) \exp(\Delta / \sqrt{d_k})}$$

- 当 $\Delta > 0$（竞争者 score 更高）：$\mathcal{F}^{\max} < 1/n$，提取能力**弱于均匀**
- 当 $\Delta = 0$（均匀竞争）：$\mathcal{F}^{\max} = 1/n$
- 当 $\Delta < 0$（$j^*$ score 最高）：$\mathcal{F}^{\max} > 1/n$，但仍受 $n-1$ 竞争者限制

### 3.3 Score 边界与维度的关系（严格推论）

注意力 score $s_{ij} = (h_i W_Q)(h_j W_K)^\top / \sqrt{d_k}$ 的绝对值受表示范数约束。

**命题 3.3（Score 的 Cauchy-Schwarz 上界）**：

$$|s_{ij}| \leq \frac{\|h_i W_Q\|_2 \cdot \|h_j W_K\|_2}{{\sqrt{d_k}}}$$

设 $\|h_i W_Q\|_2 \leq B_Q$，$\|h_j W_K\|_2 \leq B_K$，则：

$$s_{ij} \in \left[-\frac{B_Q B_K}{\sqrt{d_k}},\ \frac{B_Q B_K}{\sqrt{d_k}}\right]$$

最大可能 score 差为 $\Delta_{\max} = \frac{2 B_Q B_K}{\sqrt{d_k}}$（目标位置满分，竞争者最低分）。

**命题 3.4（绝对最优检索保真度）**：在 $\|h_i W_Q\|_2 \leq B_Q$，$\|h_j W_K\|_2 \leq B_K$ 的约束下，注意力机制对 $j^*$ 的最优检索保真度为：

$$\mathcal{F}^* = \frac{1}{1 + (n-1) \exp\!\left(-\dfrac{2 B_Q B_K}{\sqrt{d_k}}\right)}$$

**证明**：将命题 3.3 的 $\Delta_{\max}$ 代入命题 3.2 的公式，取 $\Delta = -\Delta_{\max}$（竞争者最低分，$j^*$ 最高分）。$\square$

**推论——维度 $d_k$ 的作用**：$\mathcal{F}^*$ 关于 $d_k$ 的单调性：

$$\frac{\partial \mathcal{F}^*}{\partial d_k} < 0$$

**增大 $d_k$ 会降低最优检索保真度！** 这是一个反直觉的结论：更宽的注意力头（更大的 $d_k$）使 score 的绝对值被 $1/\sqrt{d_k}$ 压缩，score 差等比缩小，Softmax 的区分能力下降，$\mathcal{F}^*$ 降低。

这给出了多头注意力（Multi-Head Attention）的理论动机：
- **单大头**（$d_k = d$）：$\mathcal{F}^*$ 最低（score 被最强压缩，区分能力最弱）
- **多小头**（$d_k = d/H$，$H$ 个头）：每个头的 $d_k$ 更小，$\mathcal{F}^*$ 更高，但每个头只覆盖 $d/H$ 维子空间

这揭示了多头注意力的根本权衡：**头数 $H$ ↑ → 每头区分能力 ↑（$\mathcal{F}^*$ ↑），但每头子空间维度 ↓（覆盖范围 ↓）**。

### 3.4 完整信息提取误差的下界（严格推论）

**命题 3.5（信息提取误差的结构下界）**：在 $n$ 个竞争位置、表示范数有界 $\|v_j\| \leq V$ 的条件下，注意力机制对 $j^*$ 的提取误差满足：

$$\|o_i - v^*\| \geq (1 - \mathcal{F}^*) \cdot \|v^*\| - \mathcal{F}^* \cdot 0$$

在最坏情形下（竞争者 $v_j$ 的方向与 $v^*$ 相反时）：

$$\|o_i - v^*\|_{\text{worst}} \geq (1 - \mathcal{F}^*) \|v^*\| + (1 - \mathcal{F}^*) V \cdot (n-1) \cdot \frac{1}{n}$$

**简化下界**：

$$\|o_i - v^*\| \geq (1 - \mathcal{F}^*) \cdot \|v^*\|$$

由于 $\mathcal{F}^* < 1$，这个下界**恒正**：注意力机制在 $n > 1$ 时**不可能完美提取单个位置的信息**。

**推论 3.5a（长序列的提取误差下界）**：当 $n \to \infty$ 且 $B_Q, B_K$ 固定时：

$$\mathcal{F}^* \xrightarrow{n \to \infty} 0, \qquad \|o_i - v^*\| \geq (1 - o(1)) \cdot \|v^*\|$$

即：**提取误差以 $\|v^*\|$ 为下界趋于完全失败**——长序列下单次注意力对任意单个位置的精确提取在信息论上是不可能的。这是 LiM 和注意力稀释现象的终极信息论基础，而非工程缺陷。

---

## 4. 统一定理：Attention 的信息提取-误差权衡

将以上结果整合为一个统一定理：

**定理 4.1（Attention 信息提取与 CAC 误差的统一界）**：

设序列长度 $n$，每个注意力头的键/值维度 $d_k = d/H$，表示范数上界 $B$（$\|h_i W_Q\|, \|h_j W_K\| \leq B$），则：

1. **最优检索保真度**（几何上界）：

$$\mathcal{F}^*(n, d_k, B) = \frac{1}{1 + (n-1) \exp\!\left(-\dfrac{2B^2}{\sqrt{d_k}}\right)}$$

2. **单步 CAC 误差的 Attention 下界**：

$$\varepsilon_{\text{att}} \geq (1 - \mathcal{F}^*) \cdot \|v^*\|_2$$

3. **LiM 的算子条件**：位置 $j^*$ 发生 Lost in the Middle 当且仅当：

$$\mathcal{R}(i \leftarrow j^*) = \alpha_{i,j^*} < \frac{1}{1 + \sum_{j \notin \text{Mid}(b)} \exp\!\left(\frac{s_{ij} - s_{ij^*}}{\sqrt{d_k}}\right)}$$

（即 $j^*$ 的检索保真度低于仅由边界区竞争者决定的 Softmax 值。）

### 4.2 对 $d_k$、$n$ 和 $H$ 的联合优化

由定理 4.1，对于固定总维度 $d = H \cdot d_k$，可以联合优化 $H$ 和 $d_k$：

$$H^* = \arg\max_{H} \sum_{h=1}^{H} \mathcal{F}^*\!\left(n, d/H, B\right)$$

对单头的 $\mathcal{F}^*$ 关于 $H$ 展开（$d_k = d/H$）：

$$\mathcal{F}^*(H) = \frac{1}{1 + (n-1)\exp\!\left(-\dfrac{2B^2\sqrt{H}}{\sqrt{d}}\right)}$$

$H$ 越大 → $\mathcal{F}^*(H)$ 越大（每头保真度更高），但每头只覆盖 $d/H$ 维子空间。**总体信息提取能力**（跨头求和）：

$$\mathcal{F}_{\text{total}}(H) = H \cdot \mathcal{F}^*(H) = \frac{H}{1 + (n-1)\exp\!\left(-\dfrac{2B^2\sqrt{H}}{\sqrt{d}}\right)}$$

**命题 4.2（最优头数存在性）**：$\mathcal{F}_{\text{total}}(H)$ 存在有限最优值 $H^*$，满足：

$$\frac{d\mathcal{F}_{\text{total}}}{dH}\bigg|_{H^*} = 0$$

**证明**：$\mathcal{F}_{\text{total}}$ 在 $H=1$ 时以普通 Softmax 开始，随 $H$ 增大单调增（分子线性，分母超线性下降），但当 $d/H$ 太小时每个头失去表达能力（$d_k \to 0$ 时 $d_k$ 维子空间退化），全局存在最优点。精确值由 $n, d, B$ 决定。$\square$

---

## 5. 与 type-iv-attention-dilution.md 的连接

本文的第一性原理推导提供了 IV-a/IV-b 分析的理论基础层：

| type-iv 分析 | 本文对应结论 |
|---|---|
| IV-a：$\alpha_{i,0} = O(1/n)$（有界竞争者假设） | §3.2 命题 3.2：精确值是 $\mathcal{F}^{\max}$，$O(1/n)$ 是 $\Delta \to 0$ 时的特例 |
| IV-a：模型防御机制（极低 score） | §3.2：等价于增大 $|\Delta|$，使 $\mathcal{F}^{\max} \to 1$——防御 = 在 Q/K 空间中扩大 score 差 |
| IV-b：$\text{SNR} = \|s(x)\| / \|n(x)\|$ | §4 定理 4.1：$\text{SNR} \propto \mathcal{F}^* / (1 - \mathcal{F}^*)$，两者等价 |
| 多头注意力 = 并行多维 $f$-链路组装 | §4.2：$\mathcal{F}_{\text{total}}(H)$ 给出了最优头数的存在性和方向 |
| 功能阈值 $\alpha^*$（IV-a 开放问题 1） | §5.1：$\alpha^* = 1 - \delta_{\text{fail}} / \|v^*\|_2$，由任务精度要求决定 |

### 5.1 功能阈值的封闭形式（解决 IV-a 开放问题 1）

IV-a 的开放问题 1 提问：\"存在某个 $\\alpha^*$ 使得 $\\alpha_{i,0} > \\alpha^*$ 时关键约束能影响输出分布——无法保证提升后超过 $\\alpha^*$\"。

现在可以给出封闭形式：

**命题 5.1（功能阈值的 CAC 推导）**：设关键信息位置 $j^*$ 对应 CAC 的原语 $r_{j^*}$，其 f-链 误差要求为 $\delta$，则功能阈值为：

$$\alpha^* = 1 - \frac{\delta}{\|v^*\|_2}$$

**证明**：由命题 3.5，提取误差 $\geq (1 - \alpha_{i,j^*}) \|v^*\|_2$，要求此误差 $\leq \delta$，得：

$$\alpha_{i,j^*} \geq 1 - \frac{\delta}{\|v^*\|_2} = \alpha^*$$

$\square$

**意义**：$\alpha^*$ 不是任意常数，而是由**任务精度要求** $\delta$ 和**关键信息的表示范数** $\|v^*\|_2$ 共同决定的**可计算量**。这将 IV-a 的"功能阈值是否可达"从开放问题转化为可计算不等式：

$$\mathcal{F}^*(n, d_k, B) \geq \alpha^* = 1 - \frac{\delta}{\|v^*\|_2}$$

整理得 **Attention 可行条件**：

$$n \leq \frac{e^{2B^2/\sqrt{d_k}} - 1}{\delta / (\|v^*\|_2 - \delta)} + 1$$

即：给定精度要求 $\delta$，存在**最大可靠序列长度** $n_{\max}$，超过此长度后注意力机制**在信息论上无法**达到所需精度，无论如何调整 $W_Q, W_K$。

**最大可靠序列长度**：

$$\boxed{n_{\max}(d_k, B, \delta, \|v^*\|) = \frac{e^{2B^2/\sqrt{d_k}} - 1}{\delta / (\|v^*\|_2 - \delta)} + 1}$$
