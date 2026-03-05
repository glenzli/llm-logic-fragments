# IDFC · Part 4：理论验证——Attention 泛函界

> **定位**：本文是 IDFC 理论的**验证层**。[Part 2](part2-model-proof.md) 建立了 CAC 定理，[Part 3](part3-deductions.md) 推导了全部推论。本文以 Attention 机制为验证对象，从第一性原理推导两个核心结果，将理论预测落地为可实验验证的可观测量：
> 1. **Lost in the Middle（LiM）的公式化定义**——在 $A(x)$ 算子框架下的精确刻画，验证 Part 3 §4-§5 的 f-chain 组装失效预测
> 2. **Attention 信息提取的最优界**——给定 Softmax 约束下信息提取的绝对上界，验证 $n_{\max}$ 的存在性
>
> **可观测接口**：本文的结论（$\mathcal{F}^*$、$n_{\max}$、功能阈値 $\alpha^*$）均可通过实验直接验证——是 IDFC 理论与现实接轨的关键节点。本文也是 [`../hallucination/type-iv-attention-dilution.md`](../hallucination/type-iv-attention-dilution.md) 现象级分析的第一性原理基础层。

---

## 1. Transformer 作为 IDFC 的具体实现

> **本节定位**：[Part 2 §1.2](part2-model-proof.md) 给出了架构无关的 Nemytskii 算子场定义 $G_l(h) = \Phi_l(h) \cdot h$。本节将 Transformer 的每一个子模块实例化为该框架下的具体 $\Phi_l$，并分析各部件在 IDFC 理论中承担的精确角色。

### 1.1 一个 Transformer Block 的函数分解

一个 Transformer Block（第 $l$ 层）是四个子函数的串联复合：

$$G_l = \text{FFN}_l \circ \text{AddNorm}_l^{(2)} \circ \text{Attn}_l \circ \text{AddNorm}_l^{(1)}$$

各子函数在 IDFC 框架中的角色如下：

| 子函数 | IDFC 角色 | $\Phi_l(h)$ 的形式 | 正则性 |
|---|---|---|---|
| **Self-Attention** | 软性 $f$-链路路由器 | $A(h) \cdot W_V W_O$（$A$ 由 $h$ 决定） | $C^\infty$（softmax 光滑） |
| **FFN（MLP）** | 原语执行者（$\hat{f}_i$ 存储库） | $D(h) \cdot W$（ReLU 激活掩码） | 分段常数（激活边界跳跃） |
| **LayerNorm** | Lipschitz 常数 $L$ 的控制器 | 仿射归一化（范数约束） | $C^\infty$（除零点外） |
| **残差连接** | 增量近似降阶器 | $(I + \Phi_l(h)) \cdot h$ | 与 $\Phi_l$ 相同 |

---

### 1.2 Self-Attention：$\Omega$ 的上下文感知路由器

$$o_i = \sum_j \alpha_{ij}(h) \cdot h_j W_V, \qquad A(h) = [\alpha_{ij}(h)]_{n \times n}$$

对位置 $i$ 的有效算子：

$$\Phi_l^{\text{Attn}}(h) = A(h) \cdot W_V W_O \in \mathcal{M}_d(\mathbb{R})$$

**IDFC 角色**：Attention 是 $R^*$ 空间里的**寻址机制**，决定当前步骤的计算"引用"哪些历史状态。它不直接实现任何 $r_i$，而是决定 **$r_i$ 的输入从哪里取**——即动态混合上下文，为 FFN 提供正确的输入向量。

**序列级 $f$-链路组装**（自回归生成）：

$$h_1 \xrightarrow{f_1(h_1)} h_2 \xrightarrow{f_2(h_1, h_2)} h_3 \xrightarrow{f_3(h_1,h_2,h_3)} \cdots$$

每步有效变换由当前位置能"看到"的全部前序状态决定——这是**由上下文在线决定的 $f$-链路**，正是 CAC 所需的动态组装机制。

**In-Context Learning 的 $f$-链路解释**：prompt 中的示例作为先前 token 存在于上下文中，对示例 token 的注意力权重 $\alpha_{ij}$ 将示例对应的 $r$-chain 特征"混入"当前有效变换，引导模型沿与示例相同的 $f$-链路方向计算。示例不提供新权重，而是**通过注意力寻址引导 $f$-链路的组装方向**。

**多头注意力：并行多维 $f$-组装**：

$$o_i = W_O \cdot \text{concat}_{h=1}^{H}\!\left[\sum_j \alpha^{(h)}_{ij} h_j W_V^{(h)}\right]$$

$H$ 个头各自维护独立的聚合矩阵 $A^{(h)}(h)$，等价于从 $H$ 条并行独立 $f$-链路组合出当前位置的有效变换。$F$ 的实际丰富度由所有头的笛卡尔积决定。

---

### 1.3 FFN（前馈层）：$F$ 集合的原语存储库

$$\text{FFN}(h) = W_2 \cdot \text{ReLU}(W_1 h + b_1) + b_2$$

对第 $l$ 层，ReLU 激活掩码 $D_l(h) = \text{diag}(\mathbf{1}[W_1 h > 0])$ 决定有效算子：

$$\Phi_l^{\text{FFN}}(h) = D_l(h) \cdot W_l$$

**IDFC 角色**：FFN 是 $f$-chain 的**执行者**，从 $F$ 中取出对应的原语近似 $\hat{f}_i$ 并作用于状态。$W_1$ 的行充当"键"（匹配输入模式），$W_2$ 的列充当"值"（对应的语义变换）——FFN **存储的是 $r_i$ 的分段线性近似 $E_{r_i}(x)$**。

**对 CAC 的贡献**：UAT（§3.3, Part 2）保证当 FFN 规模 $M \to \infty$ 时，$\varepsilon_i \to 0$。**FFN 的规模直接控制 CAC 误差界的 $\varepsilon_{\max}$。**

---

### 1.4 LayerNorm：Lipschitz 常数的控制器

$$\text{LN}(h) = \frac{h - \mathbb{E}[h]}{\sqrt{\text{Var}[h] + \epsilon}} \odot \gamma + \beta$$

**IDFC 角色**：LayerNorm 将 $h$ 的范数归一化，使得 $\|h_{\text{LN}}\| \approx \sqrt{d} \cdot |\gamma|$，**与输入范数无关**。

这直接压制 CAC 误差界中的 Lipschitz 常数 $L$（Part 2 §1.5.D 命题 1.1）：

$$\|G_l\|_{\text{Lip}} \leq B_l + L_{\Phi_l} \cdot \sup_h \|h\|$$

LayerNorm 将 $\sup_h \|h\|$ 约束在 $O(\sqrt{d})$ 量级，使 $L$ 被软性限制。没有 LayerNorm，$L > 1$ 时 CAC 误差随链长 $l$ 指数爆炸；有了 LayerNorm，$L$ 被约束在有界范围，**使 CAC 误差界对长推理链维持可控。**

---

### 1.5 残差连接：增量近似降阶器

$$h_l = h_{l-1} + \Delta_l(h_{l-1}), \qquad \Delta_l = \text{Attn}_l \text{ 或 } \text{FFN}_l$$

有效算子变为：

$$E(x) = \prod_{l=1}^{k} (I + \Phi_l^{\Delta}(h_{l-1}))$$

**IDFC 角色**：残差连接把每层的近似任务**从"拟合完整 $r_i$"降格为"拟合增量 $r_i - \text{id}$"**。若 $r_i$ 接近恒等变换（小幅度语义修改），每层 FFN 只需学习小范数的 $\Delta$，大幅降低单步误差 $\varepsilon_i$，从而降低 CAC 误差界整体。

此形式是**矩阵指数的离散近似**：$\prod(I + \Delta_l) \approx e^{\sum \Delta_l}$，使深层网络的信息传播接近连续流。

---

### 1.6 IDFC 角色总览

| 组件 | IDFC 精确角色 | 控制 CAC 误差的哪个量 |
|---|---|---|
| **Attention** | 上下文寻址——决定 $r_i$ 的输入来自哪里 | 间接（输入质量影响 $\varepsilon_i$） |
| **FFN** | 原语执行——实现 $\hat{f}_i \approx r_i$ | **直接控制 $\varepsilon_{\max}$**（规模 $M$） |
| **LayerNorm** | 状态归一化——约束 $\|h\|$ 范围 | **直接控制 $L$** |
| **残差连接** | 增量降阶——每层任务退化为近似 $\Delta r_i$ | **间接降低 $\varepsilon_i$** |

**一句话**：Transformer 是一台两级 $f$-chain 构造机——Attention 负责**寻址**，FFN 负责**执行**，LayerNorm 和残差分别保证 CAC 的两个关键条件：$L$ 有界（LayerNorm）和 $\varepsilon_i$ 可控（残差 + 规模）。

---

## 2. 基础设定（Attention 泛函分析）

从 [Part 2 §1.2](part2-model-proof.md) 的 Nemytskii 框架，在 Transformer 的 Self-Attention 层中，对序列位置 $i$，单头注意力的有效算子为：

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

## 3. Lost in the Middle：公式化定义

### 3.1 检索权重的位置剖面

**定义（检索剖面）**：对查询位置 $i$，其关于所有先前位置的检索权重构成**检索剖面**（Retrieval Profile）：

$$\mathcal{P}_i : \{1, \ldots, i-1\} \to [0, 1], \quad j \mapsto \alpha_{ij}(x)$$

$\mathcal{P}_i$ 是 Softmax 归一化的概率分布：$\sum_{j=1}^{i-1} \alpha_{ij} = 1$（加上自注意力项）。

**定义（边界区域与中间区域）**：设序列长度为 $n$，边界宽度参数 $b \in \mathbb{N}$，定义：

$$\text{Primacy}(b) = \{1, 2, \ldots, b\}, \quad \text{Recency}(b) = \{n-b, \ldots, n-1\}, \quad \text{Mid}(b) = \{b+1, \ldots, n-b-1\}$$

（Primacy = 开头区，Recency = 结尾区，Mid = 中间区）

### 3.2 Lost in the Middle 的精确定义

**定义（LiM——Lost in the Middle，严格版本）**：称序列在位置 $j^*$ 处对查询 $i$ 表现出 **Lost in the Middle**，若：

$$j^* \in \text{Mid}(b) \quad \text{且} \quad \mathcal{R}(i \leftarrow j^*) < \min\!\left(\min_{j \in \text{Primacy}(b)} \mathcal{R}(i \leftarrow j),\; \min_{j \in \text{Recency}(b)} \mathcal{R}(i \leftarrow j)\right)$$

即：中间区域关键位置的检索权重，严格低于开头区和结尾区内**所有位置**的检索权重。

**统计版本**（适用于实验验证）：

$$\mathbb{E}_x[\mathcal{R}(i \leftarrow j^*)] < \min\!\left(\mathbb{E}_x\!\left[\overline{\mathcal{R}}_{\text{Primacy}}\right],\, \mathbb{E}_x\!\left[\overline{\mathcal{R}}_{\text{Recency}}\right]\right)$$

其中 $\overline{\mathcal{R}}_{\text{Primacy}} = \frac{1}{b}\sum_{j \in \text{Primacy}(b)} \mathcal{R}(i \leftarrow j)$ 是边界区的平均检索权重。

### 3.3 LiM 的算子解释

在 IDFC 框架下，LiM 的本质是 **$f$-链路组装的局部失效**：

位置 $i$ 的有效算子 $E_i(x)$ 是所有位置有效算子的加权叠加：

$$E_i(x) = \sum_{j=1}^{n} \alpha_{ij}(x) \cdot \Phi_j \in \mathcal{M}_d(\mathbb{R})$$

其中 $\Phi_j = W_V^{(j)} W_O$ 是位置 $j$ 的单位算子贡献。**LiM 意味着中间位置的算子贡献权重系统性偏低**：关键信息 $\Phi_{j^*}$ 对 $E_i(x)$ 的贡献被稀释，等价于 $F$-链路在组装时"遗漏"了某条中间的 $r_{j^*}$ 算子。

**CAC 连接**：若 $j^*$ 的信息对应某个关键原语 $r_{j^*} \in R_{\text{tr}}$，则 LiM 导致 $E_{r_{j^*}}$ 的拟合误差增大至：

$$\varepsilon_{j^*}^{\text{LiM}} \geq (1 - \alpha_{i,j^*}) \cdot \|h_{j^*} W_V\|_2 \cdot \|W_O\|_2$$

这是 CAC 误差界中 $\varepsilon_{\max}$ 的一个**结构性下界**——LiM 现象直接给出了单步拟合误差的可测下确界。

### 3.4 LiM 的充分条件（严格推论）

**命题 3.4（LiM 的 Score 充分条件）**：若关键位置 $j^*$ 的注意力 score $s_{i,j^*}$ 满足：

$$s_{i,j^*} < \frac{1}{n} \sum_{j=1}^{n} s_{ij} \triangleq \bar{s}_i$$

即 $j^*$ 的 score 低于均值，则在均匀 score 基线下：

$$\alpha_{i,j^*} < \frac{1}{n}$$

此时若任意边界位置 $j_0 \in \text{Primacy}(b) \cup \text{Recency}(b)$ 满足 $s_{i,j_0} > \bar{s}_i$，则 $\alpha_{i,j_0} > \alpha_{i,j^*}$，LiM 成立。

**证明**：Softmax 单调性——$s_{ij} > s_{ij'} \iff \alpha_{ij} > \alpha_{ij'}$。$\square$

**推论 3.4a（LiM 的位置偏置根因）**：LiM 的结构性来源是**注意力 score 的位置偏置**。若模型在训练中因自回归预测的局部性而对近期 token（Recency）赋予系统性更高的 score，对早期显著 token（Primacy，如系统指令）通过特殊位置编码或 sink-token 机制赋予高 score，则中间位置在 score 上系统性偏低——LiM 成为训练诱导的**结构性必然**，而非偶发现象。

---

## 4. Attention 的最优信息提取界

### 4.1 信息提取问题的形式化

**问题设置**：设关键位置 $j^*$ 携带信息 $h_{j^*} \in \mathbb{R}^d$，目标是通过注意力机制将其准确提取到位置 $i$ 的输出中。提取的"完美目标"为：

$$o_i^* = h_{j^*} W_V W_O \triangleq v^* \in \mathbb{R}^d$$

实际输出为：

$$o_i = \sum_{j=1}^{n} \alpha_{ij} \cdot h_j W_V W_O = \alpha_{i,j^*} v^* + \sum_{j \neq j^*} \alpha_{ij} \cdot v_j$$

检索误差：

$$\|o_i - o_i^*\| = \left\|(1 - \alpha_{i,j^*}) v^* - \sum_{j \neq j^*} \alpha_{ij} v_j \right\| \cdot $$

等价地，用**检索保真度**（Retrieval Fidelity）刻画：

$$\mathcal{F}(i, j^*) = \alpha_{i,j^*} \in [0, 1]$$

$\mathcal{F} = 1$ 时完美提取（但物理上不可能，除非所有竞争者 score 为 $-\infty$）；$\mathcal{F} = 1/n$ 时均匀稀释。

### 4.2 Softmax 的最优集中界（严格推论）

**命题 4.2（Softmax 最优集中界）**：在 $n$ 个竞争位置中，通过调整 query $q_i$ 和 key $k_{j^*}$（即调整 $W_Q, W_K$），注意力权重 $\alpha_{i,j^*}$ 的理论最大值为：

$$\mathcal{F}^{\max}(i, j^*) = \frac{1}{1 + \displaystyle\sum_{j \neq j^*} \exp\!\left(\frac{s_{ij} - s_{ij^*}}{\sqrt{d_k}}\right)}$$

**证明**：Softmax 公式的直接代数变形，令 $s_{ij^*}$ 为参考值。$\square$

当所有竞争者的 score 远低于 $j^*$（$s_{ij} - s_{ij^*} \to -\infty$ for $j \neq j^*$）时，$\mathcal{F}^{\max} \to 1$。

**推论 4.2a（有限 Score 差下的最优界）**：设最大 score 差 $\Delta = \max_{j \neq j^*}(s_{ij} - s_{ij^*})$，则：

$$\mathcal{F}^{\max}(i, j^*) \leq \frac{1}{1 + (n-1) \exp(\Delta / \sqrt{d_k})}$$

- 当 $\Delta > 0$（竞争者 score 更高）：$\mathcal{F}^{\max} < 1/n$，提取能力**弱于均匀**
- 当 $\Delta = 0$（均匀竞争）：$\mathcal{F}^{\max} = 1/n$
- 当 $\Delta < 0$（$j^*$ score 最高）：$\mathcal{F}^{\max} > 1/n$，但仍受 $n-1$ 竞争者限制

### 4.3 Score 边界与维度的关系（严格推论）

注意力 score $s_{ij} = (h_i W_Q)(h_j W_K)^\top / \sqrt{d_k}$ 的绝对值受表示范数约束。

**命题 4.3（Score 的 Cauchy-Schwarz 上界）**：

$$|s_{ij}| \leq \frac{\|h_i W_Q\|_2 \cdot \|h_j W_K\|_2}{{\sqrt{d_k}}}$$

设 $\|h_i W_Q\|_2 \leq B_Q$，$\|h_j W_K\|_2 \leq B_K$，则：

$$s_{ij} \in \left[-\frac{B_Q B_K}{\sqrt{d_k}},\ \frac{B_Q B_K}{\sqrt{d_k}}\right]$$

最大可能 score 差为 $\Delta_{\max} = \frac{2 B_Q B_K}{\sqrt{d_k}}$（目标位置满分，竞争者最低分）。

**命题 4.4（绝对最优检索保真度）**：在 $\|h_i W_Q\|_2 \leq B_Q$，$\|h_j W_K\|_2 \leq B_K$ 的约束下，注意力机制对 $j^*$ 的最优检索保真度为：

$$\mathcal{F}^* = \frac{1}{1 + (n-1) \exp\!\left(-\dfrac{2 B_Q B_K}{\sqrt{d_k}}\right)}$$

**证明**：将命题 4.3 的 $\Delta_{\max}$ 代入命题 4.2 的公式，取 $\Delta = -\Delta_{\max}$（竞争者最低分，$j^*$ 最高分）。$\square$

**推论——维度 $d_k$ 的作用**：$\mathcal{F}^*$ 关于 $d_k$ 的单调性：

$$\frac{\partial \mathcal{F}^*}{\partial d_k} < 0$$

**增大 $d_k$ 会降低最优检索保真度！** 这是一个反直觉的结论：更宽的注意力头（更大的 $d_k$）使 score 的绝对值被 $1/\sqrt{d_k}$ 压缩，score 差等比缩小，Softmax 的区分能力下降，$\mathcal{F}^*$ 降低。

这给出了多头注意力（Multi-Head Attention）的理论动机：
- **单大头**（$d_k = d$）：$\mathcal{F}^*$ 最低（score 被最强压缩，区分能力最弱）
- **多小头**（$d_k = d/H$，$H$ 个头）：每个头的 $d_k$ 更小，$\mathcal{F}^*$ 更高，但每个头只覆盖 $d/H$ 维子空间

这揭示了多头注意力的根本权衡：**头数 $H$ ↑ → 每头区分能力 ↑（$\mathcal{F}^*$ ↑），但每头子空间维度 ↓（覆盖范围 ↓）**。

### 4.4 完整信息提取误差的下界（严格推论）

**命题 4.5（信息提取误差的结构下界）**：在 $n$ 个竞争位置、表示范数有界 $\|v_j\| \leq V$ 的条件下，注意力机制对 $j^*$ 的提取误差满足：

$$\|o_i - v^*\| \geq (1 - \mathcal{F}^*) \cdot \|v^*\| - \mathcal{F}^* \cdot 0$$

在最坏情形下（竞争者 $v_j$ 的方向与 $v^*$ 相反时）：

$$\|o_i - v^*\|_{\text{worst}} \geq (1 - \mathcal{F}^*) \|v^*\| + (1 - \mathcal{F}^*) V \cdot (n-1) \cdot \frac{1}{n}$$

**简化下界**：

$$\|o_i - v^*\| \geq (1 - \mathcal{F}^*) \cdot \|v^*\|$$

由于 $\mathcal{F}^* < 1$，这个下界**恒正**：注意力机制在 $n > 1$ 时**不可能完美提取单个位置的信息**。

**推论 4.5a（长序列的提取误差下界）**：当 $n \to \infty$ 且 $B_Q, B_K$ 固定时：

$$\mathcal{F}^* \xrightarrow{n \to \infty} 0, \qquad \|o_i - v^*\| \geq (1 - o(1)) \cdot \|v^*\|$$

即：**提取误差以 $\|v^*\|$ 为下界趋于完全失败**——长序列下单次注意力对任意单个位置的精确提取在信息论上是不可能的。这是 LiM 和注意力稀释现象的终极信息论基础，而非工程缺陷。

---

## 5. 统一定理：Attention 的信息提取-误差权衡

将以上结果整合为一个统一定理：

**定理 5.1（Attention 信息提取与 CAC 误差的统一界）**：

设序列长度 $n$，每个注意力头的键/值维度 $d_k = d/H$，表示范数上界 $B$（$\|h_i W_Q\|, \|h_j W_K\| \leq B$），则：

1. **最优检索保真度**（几何上界）：

$$\mathcal{F}^*(n, d_k, B) = \frac{1}{1 + (n-1) \exp\!\left(-\dfrac{2B^2}{\sqrt{d_k}}\right)}$$

2. **单步 CAC 误差的 Attention 下界**：

$$\varepsilon_{\text{att}} \geq (1 - \mathcal{F}^*) \cdot \|v^*\|_2$$

3. **LiM 的算子条件**：位置 $j^*$ 发生 Lost in the Middle 当且仅当：

$$\mathcal{R}(i \leftarrow j^*) = \alpha_{i,j^*} < \frac{1}{1 + \sum_{j \notin \text{Mid}(b)} \exp\!\left(\frac{s_{ij} - s_{ij^*}}{\sqrt{d_k}}\right)}$$

（即 $j^*$ 的检索保真度低于仅由边界区竞争者决定的 Softmax 值。）

### 5.2 对 $d_k$、$n$ 和 $H$ 的联合优化

由定理 5.1，对于固定总维度 $d = H \cdot d_k$，可以联合优化 $H$ 和 $d_k$：

$$H^* = \arg\max_{H} \sum_{h=1}^{H} \mathcal{F}^*\!\left(n, d/H, B\right)$$

对单头的 $\mathcal{F}^*$ 关于 $H$ 展开（$d_k = d/H$）：

$$\mathcal{F}^*(H) = \frac{1}{1 + (n-1)\exp\!\left(-\dfrac{2B^2\sqrt{H}}{\sqrt{d}}\right)}$$

$H$ 越大 → $\mathcal{F}^*(H)$ 越大（每头保真度更高），但每头只覆盖 $d/H$ 维子空间。**总体信息提取能力**（跨头求和）：

$$\mathcal{F}_{\text{total}}(H) = H \cdot \mathcal{F}^*(H) = \frac{H}{1 + (n-1)\exp\!\left(-\dfrac{2B^2\sqrt{H}}{\sqrt{d}}\right)}$$

**命题 5.2（最优头数存在性）**：$\mathcal{F}_{\text{total}}(H)$ 存在有限最优值 $H^*$，满足：

$$\frac{d\mathcal{F}_{\text{total}}}{dH}\bigg|_{H^*} = 0$$

**证明**：$\mathcal{F}_{\text{total}}$ 在 $H=1$ 时以普通 Softmax 开始，随 $H$ 增大单调增（分子线性，分母超线性下降），但当 $d/H$ 太小时每个头失去表达能力（$d_k \to 0$ 时 $d_k$ 维子空间退化），全局存在最优点。精确值由 $n, d, B$ 决定。$\square$

---

## 6. 与 type-iv-attention-dilution.md 的连接

本文的第一性原理推导提供了 IV-a/IV-b 分析的理论基础层：

| type-iv 分析 | 本文对应结论 |
|---|---|
| IV-a：$\alpha_{i,0} = O(1/n)$（有界竞争者假设） | §4.2 命题 4.2：精确值是 $\mathcal{F}^{\max}$，$O(1/n)$ 是 $\Delta \to 0$ 时的特例 |
| IV-a：模型防御机制（极低 score） | §4.2：等价于增大 $|\Delta|$，使 $\mathcal{F}^{\max} \to 1$——防御 = 在 Q/K 空间中扩大 score 差 |
| IV-b：$\text{SNR} = \|s(x)\| / \|n(x)\|$ | §5 定理 5.1：$\text{SNR} \propto \mathcal{F}^* / (1 - \mathcal{F}^*)$，两者等价 |
| 多头注意力 = 并行多维 $f$-链路组装 | §5.2：$\mathcal{F}_{\text{total}}(H)$ 给出了最优头数的存在性和方向 |
| 功能阈值 $\alpha^*$（IV-a 开放问题 1） | §6.1：$\alpha^* = 1 - \delta_{\text{fail}} / \|v^*\|_2$，由任务精度要求决定 |

### 6.1 功能阈值的封闭形式（解决 IV-a 开放问题 1）

IV-a 的开放问题 1 提问：\"存在某个 $\\alpha^*$ 使得 $\\alpha_{i,0} > \\alpha^*$ 时关键约束能影响输出分布——无法保证提升后超过 $\\alpha^*$\"。

现在可以给出封闭形式：

**命题 6.1（功能阈值的 CAC 推导）**：设关键信息位置 $j^*$ 对应 CAC 的原语 $r_{j^*}$，其 f-链 误差要求为 $\delta$，则功能阈值为：

$$\alpha^* = 1 - \frac{\delta}{\|v^*\|_2}$$

**证明**：由命题 4.5，提取误差 $\geq (1 - \alpha_{i,j^*}) \|v^*\|_2$，要求此误差 $\leq \delta$，得：

$$\alpha_{i,j^*} \geq 1 - \frac{\delta}{\|v^*\|_2} = \alpha^*$$

$\square$

**意义**：$\alpha^*$ 不是任意常数，而是由**任务精度要求** $\delta$ 和**关键信息的表示范数** $\|v^*\|_2$ 共同决定的**可计算量**。这将 IV-a 的"功能阈值是否可达"从开放问题转化为可计算不等式：

$$\mathcal{F}^*(n, d_k, B) \geq \alpha^* = 1 - \frac{\delta}{\|v^*\|_2}$$

整理得 **Attention 可行条件**：

$$n \leq \frac{e^{2B^2/\sqrt{d_k}} - 1}{\delta / (\|v^*\|_2 - \delta)} + 1$$

即：给定精度要求 $\delta$，存在**最大可靠序列长度** $n_{\max}$，超过此长度后注意力机制**在信息论上无法**达到所需精度，无论如何调整 $W_Q, W_K$。

$$\boxed{n_{\max}(d_k, B, \delta, \|v^*\|) = \frac{e^{2B^2/\sqrt{d_k}} - 1}{\delta / (\|v^*\|_2 - \delta)} + 1}$$

---

## 7. 幻觉 Type IV 的形式化（Transformer 架构专有）

> **定位**：以下命题是 [Part 3 §11](part3-deductions.md) 架构无关分类的 Transformer 实例化。Type IV 幻觉依赖 Attention 机制的 softmax 归一化特性，在不使用 softmax 路由的架构中不以相同方式出现。

---

### 7.1 Type IV-a：注意力稀释幻觉（严格定理）

**语言**：随序列长度增加，对关键位置信息的检索质量系统性下降，最终导致输出与关键上下文解耦。

**命题 7.1（注意力稀释幻觉的充要条件）**：在 $n$ 个竞争位置、Q/K 范数界 $B$ 的条件下，关键位置 $j^*$ 的有效检索保真度满足（由 §4.4 命题 4.4）：

$$\mathcal{F}^*(n, d_k, B) = \frac{1}{1 + (n-1)\exp\!\left(-\frac{2B^2}{\sqrt{d_k}}\right)}$$

Type IV-a 幻觉（检索精度低于任务阈值 $\alpha^*$）**当且仅当**序列长度超过最大可靠序列长度：

$$\text{Type IV-a 幻觉} \iff n > n_{\max}(d_k, B, \delta, \|v^*\|)$$

其中 $n_{\max}$ 由命题 6.1 给出封闭形式。

**推论 7.1a（Type IV-a 的 CAC 表述）**：Type IV-a 等价于关键原语 $r_{j^*}$ 的逐点拟合误差产生结构性下界（§3.3 公式）：

$$\varepsilon_{j^*}^{\text{IV-a}} \geq (1 - \mathcal{F}^*) \cdot \|v^*\|_2 \xrightarrow{n \to \infty} \|v^*\|_2$$

即：**随序列长度趋于无穷，$r_{j^*}$ 的拟合误差趋于其表示范数上界**——关键原语在 CAC 链路中实质上被跳过，等价于 Type I 幻觉的"局部发作"：链路并非全部不可达，而是部分环节被稀释至无效。

**推论 7.1b（Type IV-a 与 Type II 的耦合）**：Type IV-a 产生的 $\varepsilon_{j^*}^{\text{IV-a}}$ 注入 CAC 误差积累公式（命题 11.2）：

$$\text{Err}(l) \geq \varepsilon_{j^*}^{\text{IV-a}} \cdot L^{l - j^*} \geq (1 - \mathcal{F}^*)\|v^*\| \cdot L^{l - j^*}$$

当 $j^*$ 靠近链路早期（§5.2，$j^*$ 小时放大倍数 $L^{l-j^*}$ 最大），Type IV-a 导致的初始寻址失败被后续链路指数放大——这是"上下文遗忘 + 推理崩溃"同时发生的结构性根因。

---

### 7.2 Type IV-b：特征误路由幻觉（条件性命题）

**语言**：模型对同一语义查询在不同 prompt 下给出截然不同的答案，因为不同 prompt 改变了多头注意力的路由权重。

**设定**：多输出对位置 $i$ 的有效贡献由各头叠加：

$$o_i = W_O \cdot \text{concat}_{h=1}^{H}\!\left[\sum_j \alpha^{(h)}_{ij} h_j W_V^{(h)}\right] = \sum_{h=1}^{H} \Phi_h(x) \cdot h$$

将各头分为**信号头**（$h \in \mathcal{H}_s$，对应正确原语 $r_{j^*}$）和**噪声头**（$h \in \mathcal{H}_n$，关注无关位置），则有效输出分解为：

$$o_i = \underbrace{\sum_{h \in \mathcal{H}_s} \Phi_h(x) \cdot h}_{\text{信号项 } s(x)} + \underbrace{\sum_{h \in \mathcal{H}_n} \Phi_h(x) \cdot h}_{\text{噪声项 } n(x)}$$

**定义（多头 SNR）**：

$$\text{SNR}(x) = \frac{\|s(x)\|}{\|n(x)\|}$$

**命题 7.2（Type IV-b 幻觉的 SNR 条件，条件性）**：额外假设信号项与噪声项在 $\ell^2$ 意义下可分离，则：

$$\text{SNR}(x) < 1 \implies \|o_i - v^*\| > \|o_i\| / 2$$

即输出由噪声主导，对关键原语 $r_{j^*}$ 的有效拟合误差 $\varepsilon_{j^*}^{\text{IV-b}} \geq \|n(x)\| - \|s(x)\| > 0$。

**与 CAC 的连接**：令有效算子 $E_{r_{j^*}}(x) = \sum_h \Phi_h(x)$，若 $\text{SNR} < 1$，则无论 $W_V, W_O$ 如何参数化，$E_{r_{j^*}}(x) \cdot x$ 被噪声分量主导，CAC 单步拟合误差 $\varepsilon_{j^*}$ 产生正下界：

$$\varepsilon_{j^*}^{\text{IV-b}} \geq \|n(x)\| - \|s(x)\|$$

**Context 可修复性**：由于 $\alpha^{(h)}_{ij}(x)$ 连续依赖输入（softmax 光滑），不同 prompt 改变 $x$ → 改变每头的注意力权重分布 → 改变 $\mathcal{H}_s / \mathcal{H}_n$ 的划分 → 改变 SNR。

- SNR $> 1$（prompt 精准）：路由成功，无 Type IV-b 幻觉
- SNR $< 1$（prompt 模糊或有干扰）：路由失败，Type IV-b 幻觉触发

**与 Type III 的区分**：Type III（Welch Bound）是 $\varepsilon_{j^*}$ 的全局不可消除下界（所有 prompt 均失败）；Type IV-b 的 $\varepsilon_{j^*}^{\text{IV-b}}$ 依赖 $x$（某些 prompt 可成功）。判别方法：5 种不同 prompt 全部错误 → Type III；部分可成功 → Type IV-b。

---

### 7.3 四类幻觉的 IDFC 统一对比

| 类型 | IDFC 失效层面 | 核心不等式 | 架构相关性 | 不可消除性 |
|---|---|---|---|---|
| **Type I** | $f$-chain 长度 $k < l^*(q)$ | $\mathcal{T}_{k,\theta}(x) \neq q(x)$（$\forall \theta$） | ❌ 任何固定深度架构 | ✅ 不可消除（只能用 CoT 延伸） |
| **Type II** | CAC 误差积累：$l > l_{\max}(\delta_{\text{fail}})$ | $\text{Err}(l) \leq \varepsilon_{\max}(L^l-1)/(L-1)$ | ❌ 任何 $\varepsilon > 0$ 的 $f$-chain | ✅ 不可消除（可延迟：降 $\varepsilon_{\max}$ 或 $L$） |
| **Type III** | $F$ 容量：$N > d$，Welch 混叠 | $\varepsilon_{\max}^* \geq \Omega(\sqrt{(N-d)/dN})$ | ❌ 任何有限维嵌入架构 | ✅ $N > d$ 时不可消除（需 $d\uparrow$ 或 RAG） |
| **Type IV-a** | Attention 稀释：$n > n_{\max}$ | $\varepsilon_{j^*}^{\text{IV-a}} \geq (1-\mathcal{F}^*)\|v^*\|$ | ✅ **softmax Attention 专有** | ⚑ 在固定架构下不可消除；换架构（稀疏/线性Attention）可缓解 |
| **Type IV-b** | 多头 SNR $< 1$，噪声头主导 | $\varepsilon_{j^*}^{\text{IV-b}} \geq \|n(x)\| - \|s(x)\|$ | ✅ **多头 softmax Attention 专有** | ❌ 可消除（fine-tuning 调整 $W_O$；精准 prompt 调整 SNR） |

**汇总一句话**：
- **Type I–III** 是 $f$-chain 框架的结构性极限，与 Transformer 无关；
- **Type IV** 是 Attention 的 softmax 路由的专有病理，换掉路由机制就换掉了 Type IV——但同时也失去了 Attention 带来的上下文动态路由能力。
