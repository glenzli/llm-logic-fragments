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

---

## 8. Diffusion 作为对比生成范式

> **定位**：本节以 [Part 2 §1.7](part2-model-proof.md) 的自回归形式化框架为基准，将 Diffusion 模型（得分匹配 / DDPM 家族）纳入 IDFC 框架，解析其与自回归生成的**结构性差异**，并给出 guidance scale 在 IDFC 中的精确类比。

---

### 8.1 Diffusion 的 IDFC 解读：连续去噪轨迹

**自回归范式的 $\varepsilon_{\text{tok}}$ 结构（回顾）**：在 Part 2 §1.7A，每一步自回归采样引入离散化误差：

$$\varepsilon_{\text{tok}}^{(t)} = \mathbb{E}_{\hat{w} \sim p_{T}}\!\left[\|e_{\hat{w}} - h^*_t\|\right]$$

其中 $h^*_t \in \mathbb{R}^d$ 是第 $t$ 步的「理想连续状态」，$e_{\hat{w}}$ 是被选中 token 的嵌入向量。$T$ 步自回归展开在 IDFC 中产生 $T$ 次离散化误差的累积（Part 2 §1.7B、命题 5.3）。

**Diffusion 的结构性对比**：设去噪过程共 $S$ 步，第 $s$ 步的状态为 $\mathbf{x}_s \in \mathbb{R}^{d_{\text{out}}}$（例如像素空间、潜在空间），去噪器 $\epsilon_\theta$ 给出分数估计：

$$\mathbf{x}_{s-1} = \frac{1}{\sqrt{\alpha_s}}\!\left(\mathbf{x}_s - \frac{1 - \alpha_s}{\sqrt{1-\bar{\alpha}_s}} \epsilon_\theta(\mathbf{x}_s, s)\right) + \sigma_s \mathbf{z}, \quad \mathbf{z} \sim \mathcal{N}(0, I)$$

**关键结构差异**：去噪轨迹 $\mathbf{x}_S \to \mathbf{x}_{S-1} \to \cdots \to \mathbf{x}_0$ 全程在**连续空间**中推进，**不经过离散化采样**。因此：

> **命题 8.1（Diffusion 的 $\varepsilon_{\text{tok}}$ 结构）**：在 IDFC 框架下，Diffusion 模型的去噪轨迹产生的**逐步离散化误差为零**（$\varepsilon_{\text{tok}}^{(s)} = 0$，$s = 1, \ldots, S-1$）。$\varepsilon_{\text{tok}}$ **仅在最终投影步骤一次性产生**：
>
> $$\varepsilon_{\text{tok}}^{\text{Diff}} = \| \text{Decode}(\mathbf{x}_0) - y^* \|$$
>
> 其中 $\text{Decode}$ 是从连续潜在空间到离散输出（像素 quantization、token 投影等）的一次性转换。

**IDFC 含义**：Diffusion 以「推迟离散化」换取了全程无 $\varepsilon_{\text{tok}}$ 的连续 $f$-chain 轨迹——中间状态不被量化，不损失信息，命题 5.3 中 $k-1$ 个 $\varepsilon_{\text{tok}}$ 项消失：

$$\text{Err}_{\text{Diff}}(S) \leq S \cdot \varepsilon_{\text{score}} \cdot \frac{L^S - 1}{L - 1}$$

其中 $\varepsilon_{\text{score}}$ 是每步得分估计误差，替代了自回归的 $\varepsilon_{\max}$。

---

### 8.2 Guidance Scale = Temperature 的精确等价

**自回归温度回顾**（Part 2 §1.7A/D）：输出 logit 向量 $z \in \mathbb{R}^V$，采样分布为 $p_T(w) \propto \exp(z_w / T)$：

- $T \to 0$：argmax（greedy），$\varepsilon_{\text{tok}}$ 最小化，但可能陷入局部最优路径
- $T \to \infty$：均匀随机，$\varepsilon_{\text{tok}}$ 最大化，多样性但无意义

**Classifier-Free Guidance（CFG）的分数修正**：设条件得分 $\epsilon_\theta(\mathbf{x}_s, s, c)$（条件 $c$）和无条件得分 $\epsilon_\theta(\mathbf{x}_s, s, \varnothing)$，CFG 的修正得分为：

$$\tilde{\epsilon}(\mathbf{x}_s, s, c) = \epsilon_\theta(\mathbf{x}_s, s, \varnothing) + \gamma \cdot \left[\epsilon_\theta(\mathbf{x}_s, s, c) - \epsilon_\theta(\mathbf{x}_s, s, \varnothing)\right]$$

其中 $\gamma > 0$ 为 **guidance scale**（引导强度）。

> **命题 8.2（Guidance Scale = Temperature 等价）**：在 IDFC 框架下，guidance scale $\gamma$ 与自回归温度 $T$ 在控制「路径选择锐利度」上扮演**精确类比的角色**：
>
> | 参数 | 控制的 softmax 位置 | 效果方向 | $\varepsilon_{\text{tok}}$ 等价物 |
> |---|---|---|---|
> | 自回归温度 $T$ ↓ | LM head 输出（f-chain 出口） | 更锐利 → 靠近 argmax | $\varepsilon_{\text{tok}}$ ↓（但 greedy 路径固化） |
> | Guidance scale $\gamma$ ↑ | 得分场（f-chain 内部梯度方向） | 更强条件约束 → 靠近条件极值 | $\varepsilon_{\text{score}}$ 等价物 ↓（但多样性 ↓） |
>
> 两者均是各自框架中控制「生成路径集中程度」的**锐利度参数**，过大则过拟合条件（模式崩溃），过小则扩散至高熵区（无意义输出）。

**精确类比的限制**：两者并不完全等价——温度 $T$ 在离散词表上的 softmax 锐利度控制，而 $\gamma$ 在连续得分场的梯度方向上操作。温度的作用是**选取哪个 token**，$\gamma$ 的作用是**朝哪个方向去噪**——前者在离散集上选择，后者在连续流形上导航。

---

### 8.3 自回归 vs. Diffusion 的 IDFC 结构对比

| 维度 | 自回归（AR） | Diffusion |
|---|---|---|
| **生成轨迹空间** | 离散 token 序列（$\mathcal{V}^T$） | 连续状态空间（$\mathbb{R}^{d_{\text{out}}}$） |
| **$f$-chain 结构** | $T$ 步，每步一次 $k$-层前向 + 离散化 | $S$ 步，每步一次 $k$-层去噪前向，全程连续 |
| **$\varepsilon_{\text{tok}}$ 发生时机** | **每步**（$T$ 次离散化误差累积） | **仅最终一次**（连续→离散的最终投影） |
| **CAC 误差源** | $\varepsilon_{\text{tok}}$ + $\varepsilon_{\max}$（双重） | $\varepsilon_{\text{score}}$（单一：得分估计误差） |
| **锐利度控制参数** | 温度 $T$（LM head softmax） | Guidance scale $\gamma$（得分场放大） |
| **CoT 可组合性** | ✅ 天然：中间 token 是可读 $r$-chain 步骤 | ❌ 困难：中间状态在连续潜空间无语义 |
| **Type I 幻觉上限** | 可通过 CoT 扩展（$l_{\text{eff}} = k \cdot T$） | COT 不适用；$S$ 步去噪等价于固定深度 $k \cdot S$ 的 $f$-chain |
| **Type II 幻觉** | 误差在 $T$ 个 $\varepsilon_{\text{tok}}$ 步累积 | 误差在 $S$ 个 $\varepsilon_{\text{score}}$ 步累积（但无额外离散化项） |
| **典型应用** | 序列任务、推理链、代码生成 | 图像/音频生成、分子设计、连续结构输出 |

> **核心结论（命题 8.3）**：Diffusion 模型在 IDFC 框架下的结构优势在于**消除逐步 $\varepsilon_{\text{tok}}$**，代价是放弃了自回归的**中间 token 可读性**（即 CoT 的可锚定性）。两种范式对应 CAC 误差结构的两种不同取舍：
> - **自回归**：多次离散化（每步 $\varepsilon_{\text{tok}}$），但每步均可作为语义锚点（CoT 可行）
> - **Diffusion**：单次最终离散化（$\varepsilon_{\text{tok}}$ 集中于末步），但中间状态无语义可锚（CoT 不适用）
>
> 对需要可解释推理链（多步逻辑、CoT 必要）的任务，自回归的中间锚点价值超过其额外的 $\varepsilon_{\text{tok}}$ 成本；对连续结构输出（图像、蛋白质骨架），Diffusion 的单次离散化优势显著。

> [!NOTE]
> **文本 Diffusion 模型的特殊性**：对在 token 空间上运行的 Diffusion（如 MDLM、SEDD 等离散扩散），每步仍操作离散 token，$\varepsilon_{\text{tok}}$ 的结构与自回归类似，但噪声过程不同。本节的命题 8.1 适用于**连续潜空间**的 Diffusion（如 Stable Diffusion、AudioLDM 等标准实现）；离散文本 Diffusion 需单独分析，见开放问题 §10.4。

---

## 9. Mamba 作为对比架构：SSM 路由的 IDFC 解读

> **定位**：本节以 [Part 2 §1.2](part2-model-proof.md) 的架构无关 Nemytskii 算子场为基准，将 Mamba（Selective State Space Model，S6）纳入 IDFC 框架，解析其与 Transformer 的**结构性差异**，并形式化 SSM 压缩损失这一 Transformer-free 架构下的新失效模式。

---

### 9.1 Selective SSM = 仿射 Nemytskii 算子（局部路由）

**Mamba 的离散化 SSM 递推**：设序列位置 $t$，隐状态 $h_t \in \mathbb{R}^{d_{\text{state}}}$，输入 $x_t \in \mathbb{R}^d$：

$$h_t = \bar{A}(x_t) \cdot h_{t-1} + \bar{B}(x_t) \cdot x_t, \qquad y_t = C(x_t) \cdot h_t$$

其中 $\bar{A}(x_t) = \exp(\Delta(x_t) \cdot A)$，$\bar{B}(x_t) = \Delta(x_t) \cdot B(x_t)$，步长 $\Delta(x_t) = \text{softplus}(W_\Delta x_t + b_\Delta)$，均为 $x_t$ 的函数。

**IDFC 映射**：对比 Part 2 §1.2 的标准 Nemytskii 算子 $G_l(h) = \Phi_l(h) \cdot h$，Mamba 每步是一个**仿射**变体：

$$G_t^{\text{Mamba}}(h) = \bar{A}(x_t) \cdot h + \bar{B}(x_t) \cdot x_t$$

通过扩充状态 $h_{\text{aug}} = [h_{t-1};\, x_t] \in \mathbb{R}^{d_{\text{state}} + d}$，可写成标准形式：

$$G_t^{\text{Mamba}}(h_{\text{aug}}) = \underbrace{[\bar{A}(x_t) \;\big|\; \bar{B}(x_t)]}_{\Phi_t^{\text{Mamba}}(x_t) \;\in\; \mathcal{M}_{d_{\text{state}},\, d_{\text{state}}+d}} \cdot h_{\text{aug}}$$

> **命题 9.1（Mamba 的 IDFC 实例化）**：Mamba 的 Selective SSM 是 IDFC Nemytskii 算子场的**仿射实例**，有效算子 $\Phi_t^{\text{Mamba}}$ 由**当前 token $x_t$** 单独决定。

**与 Transformer 的根本差异**：

| 算子来源 | Transformer | Mamba |
|---|---|---|
| $\Phi_l(h)$ 的决定因素 | 全序列 softmax Attention（$O(n)$ 信息） | 仅当前 $x_t$（$O(1)$ 局部信息）|
| 路由类型 | **全局软路由**（attend 任意历史位置）| **局部硬路由**（$\Delta(x_t)$ 决定遗忘/记忆比）|
| f-chain 的上下文感知 | 精确内容寻址（可靠找到远处 $j^*$） | 隐状态压缩后的摘要（近处权重 > 远处）|

---

### 9.2 $L < 1$ 的结构性保证——Mamba 的误差收缩特性

**HiPPO 初始化的 Lipschitz 含义**：Mamba 的矩阵 $A$ 由 HiPPO 初始化，其特征值满足 $\text{Re}(\lambda_i) < 0$。离散化后：

$$\|\bar{A}(x_t)\| = \|\exp(\Delta(x_t) \cdot A)\| \leq \exp(\Delta(x_t) \cdot \max_i \text{Re}(\lambda_i)) < 1$$

即 $\|\bar{A}(x_t)\| < 1$ **对所有输入 $x_t$ 严格成立**——这是一个**无条件的架构级保证**，不依赖 LayerNorm 或训练细节。

**命题 9.2（Mamba 的 CAC 误差界：$L < 1$ 版本）**：设 $\rho \triangleq \sup_t \|\bar{A}(x_t)\| < 1$，则 Mamba 的 $f$-chain 误差界退化为**收敛级数**：

$$\text{Err}^{\text{Mamba}}(l) \leq \varepsilon_{\max} \cdot \frac{1 - \rho^l}{1 - \rho} \xrightarrow{l \to \infty} \frac{\varepsilon_{\max}}{1 - \rho} < \infty$$

**对比命题 5.1（Transformer，$L > 1$ 时）**：误差以 $O(L^l)$ 指数爆炸。

$$\boxed{\text{Mamba: } L < 1 \implies \text{CAC 误差有界（不随链长爆炸）}}$$
$$\boxed{\text{Transformer: } L \gtrless 1 \text{（LayerNorm 软约束）} \implies \text{CAC 误差可能指数增长}}$$

**推论 9.2a（Mamba 无 Type II 幻觉的无穷深版本）**：在 $\rho < 1$ 的保证下，对**任意有限链长 $l$**，Mamba 的 CAC 误差均有界于 $\varepsilon_{\max}/(1-\rho)$——不存在 Transformer 中「超过 $l_{\max}$ 后误差爆炸」的 Type II 临界点。代价是隐状态的信息容量被固定尺寸 $d_{\text{state}}$ 限制。

> [!IMPORTANT]
> Mamba 用「$L < 1$ 保证的误差收敛」换取了「精确历史寻址能力」。这不是优劣判断，而是 CAC 误差结构的不同取舍：Transformer 的 $L$ 不保证 $< 1$ 但可精确寻址；Mamba 的 $L < 1$ 有保证但历史信息被指数压缩。

---

### 9.3 SSM 压缩损失：Mamba 架构的专有失效模式

**定义（历史信息衰减权重）**：在时刻 $n$ 生成时，位置 $k < n$ 的信息对当前隐状态的贡献权重为：

$$w(k \leftarrow n) = \prod_{s=k+1}^{n} \bar{A}(x_s) \cdot \bar{B}(x_k)$$

在 $\|\bar{A}\| \leq \rho < 1$ 的条件下，此权重以 $\rho^{n-k}$ 指数衰减——远处位置 $k$ 处的信息**系统性被压缩至接近零**。

**命题 9.3（SSM 压缩损失：新的幻觉类型）**：设任务 $q$ 需要精确回指位置 $k^*$（$|n - k^*| \gg 1$）处的原语 $r_{k^*}$，Mamba 模型的该原语拟合误差满足：

$$\varepsilon_{k^*}^{\text{SSM}} \geq (1 - \rho^{n - k^*}) \cdot \|v^*_{k^*}\|$$

其中 $v^*_{k^*} = \bar{B}(x_{k^*}) \cdot x_{k^*}$ 是 $k^*$ 位置的初始贡献向量。

**与 Type IV-a（Attention 稀释）的对比**：

| 特性 | Type IV-a（Transformer） | SSM 压缩损失（Mamba） |
|---|---|---|
| **根因** | Softmax 归一化将权重分散至 $n$ 个竞争位置 | 矩阵乘积 $\prod \bar{A}_s$ 的指数衰减 |
| **衰减速率** | $O(1/n)$（多项式，均匀竞争时） | $O(\rho^{n-k})$（指数，与距离成正比）|
| **可修复性** | 可通过 Q/K 调优提高 score 差 $\|\Delta s\|$ | 不可通过参数调整绕过（$\rho < 1$ 是架构硬性质）|
| **架构依赖性** | softmax Attention 专有 | 压缩状态 SSM 专有 |
| **距离效应** | 非单调（Primacy + Recency 偏置） | 严格单调衰减（距离越远越差）|
| **上限（信息论）** | $n > n_{\max}$ 时不可达（§6.1） | 任意长距离均有正误差下界 |

**推论 9.3a（SSM 压缩损失与 Type II 的耦合）**：SSM 压缩损失给对应原语的 $\varepsilon_{k^*}$ 一个正下界，该下界被 CAC 误差积累（命题 11.2, Part 3）以 $L^{l-k^*}$ 放大——但 Mamba 下 $L < 1$，放大系数 $< 1$，故耦合效应**不比 Transformer 严重**（对 Mamba：压缩损失不会被放大，而会被后续步骤进一步压缩）。

---

### 9.4 Mamba 的 $f$-chain 组装：局部路由的 CAC 含义

**核心对比**：Transformer 的 $f$-chain 在每步通过注意力矩阵 $A(x)$ **全局决定**哪个 $r_i$ 的信息被引入；Mamba 的 $f$-chain 在每步通过步长 $\Delta(x_t)$（选择性门控）**局部决定**当前 token 有多少映射贡献、历史状态保留多少。

**定义（Mamba 的路由锐利度）**：步长 $\Delta(x_t) \in \mathbb{R}_{>0}$ 是 Mamba 的路由锐利度控制参数：

- $\Delta(x_t) \to 0$：$\bar{A} \to I$（全保留历史），$\bar{B} \to 0$（忽略当前输入）→ **纯记忆模式**
- $\Delta(x_t) \to \infty$：$\bar{A} \to 0$（完全遗忘历史），$\bar{B} \cdot x_t$ 主导 → **纯当前输入模式**

这与自回归温度 $T$ 和 Guidance scale $\gamma$ 构成 IDFC 框架下的三参数类比：

| 参数 | 架构 | 控制的锐利度 | 极端行为 |
|---|---|---|---|
| 温度 $T$ ↓ | 自回归 | LM head softmax（输出选择） | greedy → 固化路径 |
| Guidance $\gamma$ ↑ | Diffusion | 得分场梯度方向（去噪导引） | 模式崩溃 |
| 步长 $\Delta$ ↑ | Mamba | SSM 遗忘/记忆比（历史压缩） | 切断历史 → 只看当前 |

**CAC 在 Mamba 下的工作方式**：CAC 定理（Part 2 §2）的代数结构对 Mamba 仍然成立——若 Mamba 在隐状态 $h_t$ 中能可靠地维持 $r_i$ 的近似，则链路误差仍以 Telescope 展开传播。區別在于：

- Transformer 的 $r_i$ 近似是通过**内容寻址**（Attention score）「选出」过去哪个状态来执行 $r_i$
- Mamba 的 $r_i$ 近似是通过**状态压缩**（SSM 递推）在隐状态中「累积」$r_i$ 所需的历史信息

因此，**Mamba 更擅长局部依赖的 $r_i$（$r_i$ 的计算只需近处几步历史）**，而**对长程依赖的 $r_i$（需精确访问遥远位置）存在结构性劣势**——这正是 Mamba 在 Needle-in-a-Haystack 类任务上弱于 Transformer 的 IDFC 机制解释。

---

### 9.5 混合架构（Mamba + Attention）的 IDFC 分工

实践中出现的混合架构（如 Jamba、Zamba、MambaFormer）将 SSM 层与 Attention 层交替堆叠。在 IDFC 框架下，这是**两种 $f$-chain 路由机制的分工组合**：

| 层类型 | IDFC 角色 | 处理的 $r_i$ 类型 |
|---|---|---|
| **SSM 层（Mamba）** | 局部路由 + 历史压缩摘要 | 局部依赖的原语（近程语法、短程推理）|
| **Attention 层（Transformer）** | 全局寻址 + 精确回指 | 长程依赖的原语（事实引用、跨章节逻辑）|

**命题 9.5（混合架构的 CAC 最优分工原则）**：给定任务 $q$ 的 $r$-chain 分解，最优混合架构应满足：

- 对 $r$-chain 中依赖距离 $\Delta t < \Delta^*$ 的原语步骤：使用 SSM 层（$L < 1$，误差有界）
- 对依赖距离 $\Delta t \geq \Delta^*$ 的原语步骤：使用 Attention 层（精确寻址，避免 SSM 压缩损失）

其中临界距离 $\Delta^*$ 满足 $\rho^{\Delta^*} \cdot \|v^*\| = \delta_{j^*}$（SSM 压缩损失等于任务容忍误差 $\delta_{j^*}$）：

$$\Delta^* = \left\lfloor \frac{\log(\delta_{j^*} / \|v^*\|)}{\log \rho} \right\rfloor$$

这将混合架构的层比例（SSM:Attention）从经验调参转化为**由任务的 $r$-chain 依赖距离分布决定的原则性设计问题**。

---

### 9.6 三架构 IDFC 结构总览

| 维度 | Transformer | Mamba | Diffusion |
|---|---|---|---|
| **算子 $\Phi_l$ 来源** | 全局 softmax Attention | 局部 $x_t$ 决定的 SSM 门控 | 得分网络（连续梯度场）|
| **Lipschitz $L$** | LayerNorm 软约束（不保证 $< 1$）| HiPPO 保证 $< 1$（无条件）| 依赖去噪网络设计 |
| **CAC 误差趋势** | 可能指数爆炸（$L > 1$ 时）| 级数收敛（$L < 1$）| $S$ 步得分误差累积 |
| **历史访问方式** | 精确内容寻址（KV Cache）| 指数衰减的隐状态压缩 | 无历史（单步生成）|
| **$\varepsilon_{\text{tok}}$ 结构** | 每步采样（$T$ 次）| 每步采样（$T$ 次）| 仅最终解码一次 |
| **CoT 可锚定性** | ✅（softmax 精确 attend 中间 token）| ⚠️（中间 token 被压缩进隐状态，精度随距离衰减）| ❌（连续潜空间无语义锚点）|
| **专有失效模式** | Type IV（softmax 稀释）| SSM 压缩损失（§9.3）| 最终 Decode 误差集中 |
| **最适任务** | 长程精确依赖（RAG、推理链）| 局部依赖序列（语言建模基础层）| 连续结构生成（图像、音频）|

> **一句话**：Transformer、Mamba、Diffusion 是同一 IDFC $f$-chain 框架下，对「路由机制 $\Phi_l$」和「离散化时机 $\varepsilon_{\text{tok}}$」的三种不同取舍——没有绝对优劣，只有任务结构与架构 CAC 特性的匹配程度。

---
