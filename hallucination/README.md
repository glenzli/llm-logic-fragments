# LLM 幻觉的结构性分类

> A structural taxonomy of LLM hallucinations, classified by failure mechanism rather than surface phenomenon.

## 动机

行业对 LLM 幻觉的主流分类方式——基于现象（事实性错误、逻辑不一致、指令偏离等）——描述了**症状**，但没有定位**病因**。

本文提出一种基于 Transformer 数学结构和计算机制的分类框架。目标是：将每类幻觉归因到一个可形式化的结构性瓶颈，使得缓解策略可以对症下药。

## 分类框架

我们沿两个正交维度展开分类：

| | **确定性任务**（刚性） | **概率性任务**（柔性） |
|---|---|---|
| **计算图约束**（架构层） | [I. 深度不可计算](type-i-depth-bounded-uncomputability.md) | [II. 连续-离散阻抗失配](type-ii-continuous-discrete-impedance.md) |
| **参数化约束**（表征层） | [III. 隐空间混叠](type-iii-latent-space-aliasing.md) | [IV. 注意力预算约束](type-iv-attention-dilution.md) |

- **纵轴**：失败发生在架构的计算图层面（与模型参数无关），还是在学习到的参数化表征层面。
- **横轴**：任务本身要求确定性（精确计算、状态追踪），还是概率性推理（知识关联、上下文理解）。

---

## I. 深度受限的不可计算性

**核心公式**：固定层数 $L$ 的 Transformer $\in \text{TC}^0$，而刚性任务 $\in \text{NC}^1$。在标准假设 $\text{TC}^0 \subsetneq \text{NC}^1$ 下：

$$
\forall L \in \mathbb{Z}^+,\ \forall \theta,\quad \exists\, x \in \{0,1\}^n,\quad \mathcal{T}_{L,\theta}(x) \neq f(x)
$$

**结论**：架构上界，不可能性定理。不依赖训练数据或参数规模。

**缓解**：CoT（用序列长度换递归深度，$T = O(\log n)$ 步可突破至 $\text{NC}^1$）/ Tool Use

**证明状态**：✅ 严格（模标准复杂度假设 $\text{TC}^0 \subsetneq \text{NC}^1$）

→ [完整证明](type-i-depth-bounded-uncomputability.md)

---

## II. 连续-离散阻抗失配

**核心公式**：$k$ 步离散逻辑链在连续空间中的累积误差：

$$
\|\text{err}_k\| \leq \sum_{i=1}^{k} \mathcal{L}^{k-i} \cdot \delta_i
$$

当 $\mathcal{L} > 1$ 时误差指数增长，存在临界步数 $k^*$ 使输出翻转。

**结论**：条件稳定性。短链推理可工作，长链推理必然崩溃。

**缓解**：Tool Use（外包离散运算给确定性执行器）

**证明状态**：⚠️ 定理 1-3 严格；推论 4（$\delta_i > 0$ 不可消除）为 plausibility argument

→ [完整证明](type-ii-continuous-discrete-impedance.md)

---

## III. 隐空间表征混叠

**核心公式**（Welch Bound）：$N$ 个单位向量在 $\mathbb{R}^d$ 中的最大成对相关性：

$$
\max_{i \neq j} |\langle \hat{v}_i, \hat{v}_j \rangle| \geq \sqrt{\frac{N - d}{d(N - 1)}} \xrightarrow{N \to \infty} \frac{1}{\sqrt{d}}
$$

**结论**：容量瓶颈。$N > N^*(d, \epsilon)$ 时混叠不可避免，且集中在长尾知识区域。

**注意**：Type III 仅指**全局坍缩**（信息在所有子空间中均已丢失，不可恢复）。若信息在某些子空间中仍可区分但因上下文未能激活正确子空间而失败，属于 Type IV-b（特征误路由）。快速判断法：同一问题用 5 种不同 prompt 提问，全部错误 → Type III；部分对部分错 → Type IV-b。

**缓解**：Scaling（$d \uparrow \implies$ 容量 $\uparrow$，严格证明）/ RAG（$N_{\text{eff}} \downarrow$，严格证明）

**证明状态**：✅ 无条件严格（Welch Bound 无需任何假设）

→ [完整证明](type-iii-latent-space-aliasing.md)

---

## IV. 注意力预算的结构性约束

注意力机制的有限预算在两个维度上产生约束。统一公式：

$$
\frac{\partial \text{output}}{\partial s_0} = \underbrace{\alpha_{i,0}}_{\text{IV-a: 位置权重}} \cdot \underbrace{W_O^{(h^*)} W_V^{(h^*)}}_{\text{IV-b: 特征路由}}
$$

**IV-a. 位置注意力稀释**：Softmax 归一化使 $\alpha_{i,0} = O(1/N)$（需“有界竞争者”假设）。缓解：PCP / 上下文压缩。⚠️ 条件严格。

**IV-b. 特征注意力误路由**：幻觉触发的精确几何条件为 SNR $= |s|/|n| < 1$（信号被噪声 head 反向压制）。上下文依赖：不同 prompt 改变 Softmax 权重 → 改变 SNR。缓解：精确 prompting / Fine-tuning（✅ 条件严格）/ RAG / CoT（⚠️ 自举依赖）/ PCP（⚠️ 双向加速，含 Shelve/Purge 抑制机制）。⚠️/✅ 部分严格。

→ [完整分析](type-iv-attention-dilution.md)

---

## 缓解策略映射

| 幻觉类型 | 结构性根因 | 缓解策略 | 作用机制 | 证明状态 |
|---|---|---|---|---|
| I. 深度不可计算 | $\text{TC}^0$ 上界 | CoT / Tool Use | CoT 用序列长度换递归深度；Tool Use 外包精确计算 | ✅ 模标准假设 |
| II. 连续-离散失配 | 浮点累积误差 | Tool Use | 将离散运算交给确定性执行器，绕开连续近似 | ⚠️ 部分严格 |
| III. 隐空间混叠 | 参数空间有损压缩（全局坍缩） | Scaling / RAG | 扩展表征维度 $d$ / 外置知识检索降低 $N_\text{eff}$ | ✅ 无条件严格 |
| IV-a. 位置注意力稀释 | Softmax 竞争者过多 | PCP（空间）/ 稀疏注意力 NSA（架构）| PCP：减少有竞争力 token；NSA：架构级限制竞争者数至 $O(w+k)$；PCP Memory：时间维度，$N_\text{eff}$ 与对话轮数解耦 | ⚠️ PCP 条件严格；NSA 在架构约定下严格 |
| IV-b. 特征注意力误路由 | 多头 SNR $< 1$（信号被噪声 head 压制） | Fine-tuning ✅ / Prompting ⚠️ / RAG ⚠️ / CoT ⚠️ / PCP ⚠️ | Fine-tuning：直接修改 $W_O^{(h^*)}$；其余：注入区分性上下文扩大 $\|\delta_{h^*}\|$；PCP 额外具有 Shelve/Purge 发散抑制（条件有效） | ⚠️/✅ 部分严格 |

## 类型间交互

| 交互 | 机制 | 形式化状态 |
|---|---|---|
| **Type I ↔ II 对偶** | CoT 突破 Type I 但加剧 Type II（推理链变长 → 累积误差增大） | ✅ 命题 4 |
| **Type III ↔ IV-a 制约** | RAG 缓解 Type III 但受 IV-a 制约（上下文变长 → 注意力稀释） | ✅ 命题 6 + IV-a 公式 |
| **Type III ↔ IV-b 边界** | 两者易被混淆但根因不同：Type III 是容量失败（Welch Bound，不可恢复），IV-b 是路由失败（SNR < 1，可通过 prompt 部分恢复）。判断方法：5 种 prompt 全部错误 → Type III；部分错误 → IV-b | 定性分析 |

## 开放问题

1. **类型 I 与 II 的边界**：CoT 将递归展开到序列维度，但 CoT 自身仍然在连续空间中执行——即 CoT 解决了深度问题，但可能加剧了类型 II 的累积误差。两种机制的交互动力学尚待形式化。
2. **类型 III 的量化度量**：如何度量一个特定模型在特定知识域上的"表征拥挤度"？是否可以通过隐空间的局部曲率或信息瓶颈理论给出可操作的指标？
3. **类型 IV 的非线性效应**：实际 Transformer 中的多头注意力和层间残差连接可能使稀释行为偏离简单的 $O(1/N)$ 模型，实证分析需要更细粒度的建模。
