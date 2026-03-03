# IV. 注意力预算的结构性约束 (Attention Budget Structural Constraints)

**分类坐标**：表征层 × 概率性任务

注意力机制的有限预算在两个维度上产生约束：**位置维度**（哪些 token 被关注）和**特征维度**（哪些子空间被激活）。两者共享同一个父机制——有限注意力预算的分配失败——但作用维度不同，缓解策略也不同。

---

## IV-a. 位置注意力稀释 (Positional Attention Dilution)

### 形式化

Softmax 注意力的归一化特性决定了它是一个**零和博弈**：所有位置的注意力权重之和恒为 1。

设 $s_m = q_i \cdot k_m / \sqrt{d}$ 为位置 $m$ 的注意力 score。关键约束 token（位置 0）的注意力权重为：

$$
\alpha_{i,0} = \frac{e^{s_0}}{\displaystyle e^{s_0} + \sum_{m=1}^{N} e^{s_m}}
$$

#### 无条件成立的部分 ✅

**事实 1（Softmax 归一化）**：$\sum_{m=0}^{N} \alpha_{i,m} = 1$。这是定义，不是定理。

**事实 2（平均权重衰减）**：平均注意力权重 $\bar{\alpha} = 1/(N+1)$ 随 $N$ 单调递减。由鸽巢原理，至少存在一个位置的权重 $\leq 1/(N+1)$——但这不保证**特定位置**（如位置 0）的权重衰减。

#### 条件成立的部分 ⚠️

**命题（有界竞争者假设下的 $O(1/N)$ 衰减）**

若上下文中 $\Omega(N)$ 个 token 的 score 满足 $s_m \geq c$（某常数 $c > -\infty$），则：

$$
\alpha_{i,0} \leq \frac{e^{s_0}}{N \cdot e^c} = O\!\left(\frac{1}{N}\right) \xrightarrow{N \to \infty} 0
$$

*证明*：分母 $\geq N \cdot e^c$，分子固定为 $e^{s_0}$。$\square$

**反例（模型的防御机制）**

若注意力头学会了对无关 token 赋予极低 score（$s_m \to -\infty$），则 $e^{s_m} \approx 0$，分母几乎不增长：

$$
\alpha_{i,0} \approx \frac{e^{s_0}}{e^{s_0} + \epsilon} \approx 1 \quad \text{（即使 } N \text{ 很大）}
$$

这解释了为什么**有些模型能处理长上下文而有些不能**——区别在于注意力头是否学会了给无关 token 打极低分，抵抗稀释。

### 证明状态

| 声明 | 状态 |
|---|---|
| Softmax 权重求和 = 1 | ✅ 无条件（定义） |
| 平均权重 = $1/(N+1)$ | ✅ 无条件（算术） |
| 特定位置权重 $\alpha_{i,0} = O(1/N)$ | ⚠️ 需要"有界竞争者"假设 |
| $\alpha_{i,0} \to 0$ as $N \to \infty$ | ⚠️ 不一定成立（取决于 score 分布） |

> [!IMPORTANT]
> "有界竞争者"假设在实践中的成立条件：当上下文中充填了**与查询语义相关**的内容时（如长文档、多轮对话），新增 token 的 score 不会极低，假设成立，稀释发生。当上下文中充填了**与查询无关**的噪声时，训练良好的头会给噪声打极低分，假设不成立，稀释可抵抗。因此 IV-a 本质上是关于**相关但非关键信息对关键信息的竞争**。

### 缓解路径：PCP 的形式化分析

[Paged Context Protocol (PCP)](https://github.com/glenzli/paged-context-protocol) 将 LLM 上下文窗口视为**逻辑虚拟内存**的热缓存，通过独立 Router 模型管理页面调度，Worker 模型（主 LLM）只接收 Router 合成后的紧凑视图。

> **PCP 角色速查**：**Router** 负责维护所有历史页面的索引并决定哪些页面展开进入 Worker 视野；**Worker** 是执行主任务的 LLM，始终在受控规模的上下文下工作；**Consolidator** 定期将旧页面压缩为摘要写回持久 Memory，延缓信息老化。本节后续分析均以这三个角色为基础。

---

#### ✅ 严格推论

**定义（PCP 视图分解）**

设原始上下文含 $N_{\text{raw}}$ 个 token，分属 $P$ 个逻辑页面。PCP 将 Worker 所见的上下文重组为：

$$
N_{\text{eff}} = N_{\text{hot}} + P_{\text{cold}} \cdot \bar{s} + N_{\text{anchor}}
$$

其中 $N_{\text{hot}}$ 为展开页面的 token 数，$P_{\text{cold}} \cdot \bar{s}$ 为折叠摘要的 token 数（$\bar{s}$ 为平均摘要长度），$N_{\text{anchor}}$ 为意图锚点（系统指令 + 当前输入）。

**命题 A（有效竞争者数量减少）**：设压缩比 $r = \bar{s} / n_{\text{page}}$（摘要长度 / 原始页面长度）。则：

$$
N_{\text{eff}} = N_{\text{hot}} + r \cdot N_{\text{cold}} + N_{\text{anchor}} \leq N_{\text{hot}} + r \cdot N_{\text{raw}}
$$

当 $r < 1$ 且 $N_{\text{hot}} \ll N_{\text{raw}}$ 时，$N_{\text{eff}} < N_{\text{raw}}$。✅ *（算术恒等式，给定 $r$ 的定义严格成立）*

**命题 B（循环依赖被架构打破）**：IV-a 的潜在循环依赖是"Worker 需要正确路由注意力才能判断哪些页面需要展开，但注意力稀释降低了 Worker 的路由能力"。PCP 通过将路由判断**完全外包给独立 Router 模型**打破这个回路：

- Router 的输入是**页面索引**（关键词 + 摘要），而非原始 token 流
- Router 的有效上下文规模为 $P$（页面数），$P \ll N_{\text{raw}}$
- Worker 从不接触 $N_{\text{raw}}$ 规模的原始上下文，始终处于"预净化"状态

因此：**Worker 不依赖自身注意力来决定上下文组成**，循环依赖在架构层面消失。✅ *（前提：Router 与 Worker 的上下文是独立的，符合 PCP 的三处理器架构约定）*

**命题 C（Router 自身不遭遇严重 IV-a）**：Router 处理的有效 $N$ 为页面索引规模 $P$，与 IV-a 的触发条件（大量有界竞争者）的关系：

$$
\alpha^{\text{Router}}_{i,0} = O(1/P), \quad P \ll N_{\text{raw}}
$$

若 $P$ 被协议约束在合理范围内（如 PCP 的分级折叠机制限制视界大小），Router 的注意力稀释程度远低于无 PCP 时的 Worker。✅ *（在有界竞争者假设下，Softmax 公式的直接推论）*

---

#### ⚠️ 合理性推论（非定理）

**推论 D（注意力权重放大）**：在有界竞争者假设下，给定 $N_{\text{eff}} < N_{\text{raw}}$：

$$
\frac{\alpha_{\text{with PCP}}}{\alpha_{\text{without PCP}}} \approx \frac{N_{\text{raw}}}{N_{\text{eff}}}
$$

**但这依赖两个未证明的假设**：
1. 有界竞争者假设在压缩后的上下文中仍以相同的 $c$ 成立（压缩后的摘要 token 的 score 下界未变）
2. 热页面与冷摘要在 score 分布上的差异符合 Router 的路由意图（Router 正确识别了高/低相关页面）

**推论 E（score 分布偏移）**：PCP 将无差别的 $N_{\text{raw}}$ 个竞争者分为"热页面（高 score）"和"冷摘要（推测低 score）"。若路由质量高，冷摘要的 score $s_m$ 确实低于热页面，则 score 分布向长尾偏移，进一步放大 $\alpha_{\text{anchor}}$ 超过命题 C 预测的幅度。**但"冷摘要 score 较低"是对模型行为的推测，不是定理**——高质量语义摘要可能比原始内容更语义密集，score 未必更低。

---

#### ❌ 未解决的开放问题

1. **功能阈值存在性**：存在某个 $\alpha^*$ 使得 $\alpha_{i,0} > \alpha^*$ 时关键约束能影响输出分布。PCP 可以提升 $\alpha_{i,0}$，但无法保证提升后超过 $\alpha^*$——对 $\alpha^*$ 的值没有理论上界。

2. **Router 路由质量**：命题 A-C 的有效性依赖 Router 正确区分热/冷页面。若 Router 路由失误，错误的热页面进入 Worker 上下文，$N_{\text{eff}}$ 不减反增（错误的高 score 竞争者）。Router 路由质量是整个架构的**经验性**瓶颈。

3. **Consult 操作的局部复现**：每次 `Consult` 将一个冷页面展开为 Detail，局部 $N$ 增大，局部 IV-a 复现。这是 PCP 动态管理的代价，不被上述分析覆盖。

---

#### 总结

| 声明 | 状态 |
|---|---|
| $N_{\text{eff}} < N_{\text{raw}}$（给定压缩比 $r < 1$） | ✅ 严格（算术恒等式） |
| 循环依赖被 Router 架构打破 | ✅ 严格（架构约定） |
| Router 自身 IV-a 轻微（$O(1/P)$，$P \ll N_{\text{raw}}$） | ✅ 条件严格（有界竞争者假设） |
| 注意力权重放大 $N_{\text{raw}}/N_{\text{eff}}$ 倍 | ⚠️ 条件推论（依赖 score 下界不变） |
| 摘要 token 竞争力低于热页面 | ⚠️ 合理推测，取决于 Router 质量和模型行为 |
| PCP 最终解决 IV-a | ❌ 不可断言——功能阈值和路由质量均为未解开放问题 |

**最终结论**：PCP 通过 Router 隔离和分层压缩，在架构层面有效缓解了 IV-a 的触发条件。其缓解效果有严格的下界保证（$N_{\text{eff}} < N_{\text{raw}}$），但是否足以将 IV-a 消除到功能阈值以下，取决于 Router 路由质量和具体任务的注意力需求，目前无法从数学上给出无条件保证。

---

### 其他缓解方案：空间解法的数学分析

IV-a 的根因是"大量有界竞争者占据 Softmax 分母"。解法从两条路出发：

```
改变分母的"内容"      ← PCP（外部控制进入者）
改变分母的"结构"      ← 稀疏注意力（架构级重定义 Softmax 的覆盖范围）
```

#### 上下文压缩（Context Compression）

一类方案在将历史内容注入上下文前先进行语义摘要，本质是预处理版本的 PCP 分层压缩，但没有按需召回机制：

$$
N_{\text{compressed}} = N_{\text{raw}} \cdot r, \quad r < 1
$$

**效果**：$\alpha_{i,0} = O(1/N_{\text{compressed}}) = O(1/(r \cdot N_{\text{raw}}))$，线性改善。

**局限**：压缩是**静态一次性**的，不可逆。压缩时损失的信息无法在后续轮次中被召回。对于跨轮次追溯的场景（如"你之前第 3 轮提到的约束"），压缩后的摘要精度决定了是否保留该信息。

#### 滑动窗口注意力（Sliding Window Attention）

每个 token 只关注距离自身最近的 $w$ 个 token（如 Longformer, BigBird）。Softmax 分母被硬截断至 $w$：

$$
\alpha_{i,0} = \frac{e^{s_0}}{\displaystyle\sum_{|m-i| \leq w/2} e^{s_m}} = O\!\left(\frac{1}{w}\right)
$$

**效果**：IV-a 稀释上界固定为 $O(1/w)$，不随 $N$ 增大。✅ 严格（在窗口内）。

**代价**：

$$
|m - i| > w/2 \implies \alpha_{i,m} = 0 \text{（精确为零，不可恢复）}
$$

窗口外的 token 在该层完全不可达，且随时间流逝，早期对话内容永久脱离窗口。

#### 稀疏选择注意力（DeepSeek NSA 等）

NSA（Native Sparse Attention）将每个 token 的注意力划分为三个选择集的并集：**滑动窗口** $W_i$（近距离局部）、**动态选择的 top-$k$ 块** $T_i$（全局高相关）、**压缩的全局摘要块** $L_i$：

$$
\alpha_{i,j} = \begin{cases}
\text{Softmax}(s_j / \sqrt{d}) & j \in W_i \cup T_i \cup L_i \\
0 & \text{otherwise}
\end{cases}
$$

有效竞争者数量降至：

$$
|W_i| + k + |L_i| \ll N
$$

**效果**：IV-a 被架构级约束——分母规模与 $N$ 解耦，由超参数决定。✅ 严格（在架构约定内）。

**代价**：

- 未入选的 token 精确为零——"硬丢失"，比 PCP 的"软压缩"更激进
- top-$k$ 选择质量是关键：若选择错误，关键 token 被排除在外则完全不可达
- **架构层强约束**：NSA 需要在预训练时确定，无法应用于现有模型

---

#### 三类空间方案的统一数学对比

| 方案 | IV-a 下的 $\alpha_{i,0}$ | 未入选内容处理 | 模型改造需求 |
|---|---|---|---|
| 标准 Softmax（基线） | $O(1/N)$，随 $N$ 无界退化 | — | 无 |
| 上下文压缩 | $O(1/(r \cdot N))$ | 摘要中软保留 | 无（预处理） |
| 滑动窗口 | $O(1/w)$，$w$ 固定 | 窗口外精确为零 | 架构级（需重训练） |
| NSA（选择型稀疏） | $O(1/(w+k))$ | 未选 token 精确为零 | 架构级（需重训练） |
| PCP | $O(1/N_{\text{eff}})$，$N_{\text{eff}} \ll N_{\text{raw}}$ | Router 外置，软压缩 + 按需召回 | 协议级（任意模型可用） |

---

### 时间维度：空间方案的根本局限与 PCP 的结构性优势

以上所有空间方案——无论稀疏注意力、上下文压缩还是 PCP 的分层压缩——本质上都在优化**当前时刻**上下文窗口内的注意力分配。它们是**空间解法**，解决的是"同一时刻哪些 token 相互竞争"。

但 IV-a 在**持续多轮对话**中有一个空间方案无法触及的积累效应：

**命题 F（空间方案的时间退化）**——✅ 严格

设对话进行 $\tau$ 轮，每轮平均产生 $\bar{n}$ 个 token，上下文窗口为 $W$。无结构化管理时，第 $\tau$ 轮 Worker 所见的有效竞争者数量：

$$
N_{\text{raw}}(\tau) = \min(\tau \cdot \bar{n},\ W)
$$

随 $\tau$ 增大，$N_{\text{raw}}$ 先线性增长，后在窗口饱和时保持在 $W$。窗口饱和后，最早 $(\tau - W/\bar{n})$ 轮的所有信息被**永久驱逐**：

$$
\forall t < \tau - W/\bar{n}: \quad \alpha_{i, I_t} = 0
$$

稀疏注意力减小了当前窗口内的稀释上界，但**不改变时间截断**——窗口仍然是有限的，早期对话信息仍然被永久驱逐。上下文压缩延缓了截断点，但信息仍然在某个 $\tau^*$ 处退化为摘要，之后不可恢复。

**命题 G（PCP Memory 的时间不变性）**——✅ 严格（给定 Memory 持久化约定）

PCP 的 Memory 系统将每轮结构化逻辑写入持久存储。第 $t$ 轮的信息 $I_t$ 在任意未来轮次 $\tau > t$ 均可被 Router 以意图匹配方式召回：

$$
\text{Recall}(I_t, \tau) = \begin{cases}
1 & \text{Router 的意图匹配命中 } I_t \\
0 & \text{未命中}
\end{cases}
$$

当 $\text{Recall}(I_t, \tau) = 1$ 时，$I_t$ 以 Page 形式注入 Worker 当前的 $N_{\text{eff}}$ 上下文，其注意力权重：

$$
\alpha_{i, I_t} = O(1/N_{\text{eff}})
$$

**关键性质**：此式与时间距离 $\Delta = \tau - t$ 无关。第 1 轮和第 999 轮的信息，若被召回，在第 1000 轮中的注意力权重相同。

**命题 H（$N_{\text{eff}}$ 的时间不变性）**——⚠️ 条件严格

PCP 协议约束 Worker 的视界大小（通过级联折叠、Purge 等机制），使 $N_{\text{eff}}$ 受协议参数（热页面数、摘要长度）约束，而非随 $\tau$ 积累：

$$
N_{\text{eff}}(\tau) = N_{\text{hot}} + r \cdot N_{\text{cold}} + N_{\text{anchor}} = \text{const w.r.t. } \tau
$$

*条件*：协议被正确执行，Router 严格控制热页面数量不随对话轮数增长。

---

#### 两种范式的本质区分

| | 空间解法（稀疏注意力、上下文压缩） | PCP 时间解法（Memory 召回） |
|---|---|---|
| **优化维度** | 当前时刻：哪些 token 在场 | 时间轴：历史信息的可达性 |
| **$N_\text{eff}$ 随 $\tau$ 的行为** | 随对话增长，最终被窗口截断 | 协议约束下保持稳定 |
| **历史信息的可达性** | 时间距离 $> W/\bar{n}$ 轮后硬截断为零 | 任意 $\Delta$，以意图匹配决定的二值函数 |
| **信息丢失的性质** | "软稀释后硬丢失"（连续衰减到零） | "按需恢复或永不出现"（二值可达性） |
| **典型优势场景** | 短至中等长度的单次对话 | 长期持续对话（跨会话、跨天） |

> [!NOTE]
> 空间方案与 PCP 的时间机制是互补的，不是竞争关系。在每轮对话内部（$N_\text{eff}$ 规模的上下文中）仍然存在 IV-a 的空间竞争——稀疏注意力可以进一步优化这个局部问题。二者联合使用（稀疏注意力处理窗口内竞争 + PCP Memory 处理跨轮次可达性）在理论上构成互补的双层防御。


## IV-b. 特征注意力误路由 (Feature Attention Misrouting)

### 动机

Type III 的 Welch Bound 证明了在 **全空间** $\mathbb{R}^d$ 中，$N \gg d$ 时某些实体对的内积必然很高。但在多头注意力架构中，每个 head 在独立的 $d_k = d/H$ 维子空间中操作。两个实体可能在 head 3 的子空间中混叠，但在 head 7 的子空间中完全可分：

$$
\exists\, S_1: \|P_{S_1} \hat{v}_A - P_{S_1} \hat{v}_B\| < \tau \quad \text{但} \quad \exists\, S_2: \|P_{S_2} \hat{v}_A - P_{S_2} \hat{v}_B\| \gg \tau
$$

这种**子空间可分离但上下文依赖**的混淆，根因不是容量不足（Type III），而是注意力系统未能路由到正确的区分性子空间。

### 形式化

#### 步骤一：定义区分性信号

设 $e_A, e_B$ 是两个待区分实体，$x$ 是当前上下文 token 序列。对每个 attention head $h$，定义其在上下文 $x$ 下的**区分向量**：

$$
\delta_h(x) = \text{Attn}^{(h)}(e_A \mid x) - \text{Attn}^{(h)}(e_B \mid x) \in \mathbb{R}^{d_k}
$$

经由输出投影矩阵 $W_O^{(h)} \in \mathbb{R}^{d \times d_k}$，各 head 的区分向量线性叠加至残差流：

$$
\Delta_{\text{total}}(x) = \sum_{h=1}^{H} W_O^{(h)} \delta_h(x) \in \mathbb{R}^d
$$

设 $v_{\text{ans}} \in \mathbb{R}^d$ 为正确答案 token 的 unembedding 方向（即 $W_U$ 对应行）。模型输出对两个实体的 logit 差为：

$$
\Delta_{\text{logit}}(x) = v_{\text{ans}}^{\top} \Delta_{\text{total}}(x) = \sum_{h=1}^{H} \underbrace{v_{\text{ans}}^{\top} W_O^{(h)} \delta_h(x)}_{\displaystyle =:\, c_h(x)}
$$

#### 步骤二：误路由的精确几何条件——✅ 严格

**定理（IV-b 幻觉的必要且充分条件）**

在单层简化模型中，给定模型参数（$W_Q^h, W_K^h, W_V^h, W_O^{(h)}, W_U$ 固定），模型在上下文 $x$ 下将 $e_A$ 与 $e_B$ 混淆（输出错误答案）当且仅当：

$$
\Delta_{\text{logit}}(x) = \sum_{h=1}^{H} c_h(x) < 0
$$

*证明*：模型输出 $\hat{y} = \arg\max_{y} \text{logit}(y)$。当 $\Delta_{\text{logit}} > 0$ 时，$e_A$ 的 logit 高于 $e_B$，输出正确；当 $\Delta_{\text{logit}} < 0$ 时反转。$\square$

**定义（信号与噪声）**：令 $h^* = \arg\max_h |c_h(x)|$ 为主区分 head。定义：

$$
s(x) = c_{h^*}(x) \quad \text{（信号）}, \qquad n(x) = \sum_{h \neq h^*} c_h(x) \quad \text{（干扰噪声）}
$$

**推论（SNR 幻觉阈值）**：误路由发生当且仅当：

$$
\text{SNR}(x) := \frac{|s(x)|}{|n(x)|} < 1 \quad \text{且} \quad \text{sgn}(s(x)) \neq \text{sgn}(n(x))
$$

即：干扰噪声在幅度上压制信号，且方向相反。

> [!NOTE]
> 此定理给出 IV-b 的**精确触发条件**。它不依赖任何额外假设，是给定模型参数下的纯代数推论。但 SNR 的具体数值依赖学习到的参数 $W_O^{(h)}$，无法脱离具体模型进行一般性预测。

#### 步骤三：SNR 的上下文依赖性——✅ 严格

$c_h(x)$ 随上下文 $x$ 变化，因为 $\delta_h(x)$ 本身依赖 Softmax 注意力权重：

$$
\delta_h(x) = \sum_{j} \Bigl[\alpha^h_{A,j}(x) - \alpha^h_{B,j}(x)\Bigr] W_V^{(h)} x_j
$$

其中注意力权重：

$$
\alpha^h_{i,j}(x) = \frac{\exp\bigl(x_i W_Q^h (x_j W_K^h)^{\top} / \sqrt{d_k}\bigr)}{\displaystyle\sum_{j'} \exp\bigl(x_i W_Q^h (x_{j'} W_K^h)^{\top} / \sqrt{d_k}\bigr)}
$$

**上下文依赖的精确来源**：不同的上下文 $x$ 改变 $\alpha^h_{i,j}(x)$ 的分布——进而改变 $\delta_h(x)$ 的方向和幅度——进而改变每个 $c_h(x) = v_{\text{ans}}^{\top} W_O^{(h)} \delta_h(x)$ 的符号和大小——最终决定 $\text{SNR}(x)$ 是否跌破 1。这是 IV-b 在不同 prompt 下行为不稳定的**精确数学根因**：不同上下文触发不同的 head 激活模式，导致 SNR 在不同 prompt 间波动，时而高于阈值（正确）时而低于（幻觉）。

#### 证明强度汇总

| 声明 | 状态 |
|---|---|
| $\Delta_{\text{logit}} < 0 \Leftrightarrow$ 误路由（必要且充分条件） | ✅ 严格（给定模型参数） |
| SNR $< 1$ 为幻觉触发阈值 | ✅ 严格（$\Delta_{\text{logit}}$ 的代数推论） |
| $c_h(x)$ 对上下文 $x$ 敏感（来自 Softmax 权重的变化） | ✅ 严格（Softmax 对输入的连续依赖） |
| 对于任意模型，存在使 SNR $< 1$ 的上下文 $x^-$ | ⚠️ 需要关于权重结构的假设，不可一般性证明 |
| SNR $< 1$ 的出现频率 | ⚠️ 取决于数据分布和 head 的训练特化程度，无理论上界 |

### 与 Type III 的边界

| 判据 | Type III（全局坍缩） | Type IV-b（特征误路由） |
|---|---|---|
| **信息是否存在** | ❌ 不存在（参数中已丢失） | ✅ 存在（某个子空间中有区分信号） |
| **换 prompt 能否解决** | ❌ 不能 | ✅ 可能（激活正确子空间） |
| **Welch Bound 适用** | ✅ 全空间 $\mathbb{R}^d$ | ❌ 某些子空间不违反 |
| **Scaling 能否解决** | ✅ 增大 $d$ | 不一定需要 |
| **表现** | 系统性错误 | 偶发性混淆 |

> [!IMPORTANT]
> **快速判断法**：对同一个知识问题，用 5 种不同的 prompt 方式提问。如果**全部错误**，很可能是 Type III（信息已丢失）；如果**部分对部分错**，更可能是 Type IV-b（信息存在但路由不稳定）。

### 证明状态

⚠️/✅ **部分严格**。形式化步骤二和三给出了三个严格结论（误路由的精确几何条件、SNR 阈值、上下文依赖性），但无法在不依赖具体权重的情况下证明对任意模型都存在使 SNR < 1 的上下文，亦无法量化其频率。完整的证明强度分级见"证明强度汇总"表。

### 缓解路径：基于 SNR 框架的推论

以下将三条主要缓解策略与步骤二的 SNR 公式衔接，分析各自的作用机制和推论强度。

---

#### 策略一：精确 Prompting

**机制**：通过改变上下文 $x$ 影响注意力权重分布，间接放大主区分 head 的信号。

若上下文 $x^+$ 中包含实体 $e_A$ 的区分性信息（专有描述、唯一属性），则 head $h^*$ 在 $e_A$ 和 $e_B$ 之间的注意力权重差异扩大：

$$
\alpha^{h^*}_{A,j}(x^+) \gg \alpha^{h^*}_{B,j}(x^+) \implies |\delta_{h^*}(x^+)| > |\delta_{h^*}(x^-)|
$$

由此：

$$
|c_{h^*}(x^+)| = |v_{\text{ans}}^{\top} W_O^{(h^*)} \delta_{h^*}(x^+)| > |c_{h^*}(x^-)| \implies \text{SNR}(x^+) > \text{SNR}(x^-)
$$

**证明状态**：⚠️ 推论链本身是严格的（给定 $|\delta_{h^*}|$ 增大 → $|s|$ 增大 → SNR 提升），但"精确 prompt 能使 $|\delta_{h^*}|$ 增大"需要假设 head $h^*$ 对区分性特征有响应偏好（**head 特化假设**），这取决于训练。

**局限**：Prompting 仅在单次交互中有效——它改变 $x$，而 $x$ 的影响不持久。对话转移后 SNR 可能重新跌破阈值。

---

#### 策略二：Fine-tuning ✅

**机制**：直接修改模型权重，从根本上改变 SNR 公式中的结构项 $W_O^{(h)}$。

信号项和噪声项均线性依赖 $W_O^{(h)}$：

$$
s(x) = v_{\text{ans}}^{\top} W_O^{(h^*)} \delta_{h^*}(x), \qquad c_h(x) = v_{\text{ans}}^{\top} W_O^{(h)} \delta_h(x)
$$

Fine-tuning 可以定向实现以下任意组合：

1. **信号放大**：增大 $\|W_O^{(h^*)}\|$ 或令 $W_O^{(h^*)} \delta_{h^*}$ 与 $v_{\text{ans}}$ 更对齐（$\cos\theta^* \to 1$）
2. **噪声抑制**：减小噪声 head 的 $|v_{\text{ans}}^{\top} W_O^{(h)} \delta_h|$（降低干扰贡献）

两者均直接在 SNR 公式中体现为 $|s|$ 增大或 $|n|$ 减小，从而保证 SNR > 1。

**证明状态**：✅ **条件严格**。给定优化目标为"在区分任务上最大化 $\Delta_{\text{logit}}$"，则梯度方向指向增大 $v_{\text{ans}}^{\top} W_O^{(h^*)} \delta_{h^*}$ 的方向——这是 SNR 提升的充分条件，直接从 SNR 定义导出，无额外假设。"条件"是优化需要成功收敛。Fine-tuning 是三种策略中**唯一作用于权重**的，也是唯一能持久改变 SNR 的。

**局限**：需要高质量的区分性训练数据；过拟合可能在非目标实体对上引入新的误路由。

---

#### 策略三：RAG

**机制**：引入检索文档 $C_r$ 作为上下文扩充，机制与精确 prompting 相同，但信号来源更有保证。

设检索到文档 $C_r$ 包含 $e_A$ 的特异性 token $\{t_j\}$，则：

$$
\delta_{h^*}(x, C_r) = \sum_j \bigl[\alpha^{h^*}_{A,j}(x, C_r) - \alpha^{h^*}_{B,j}(x, C_r)\bigr] W_V^{(h^*)} [x, C_r]_j
$$

当 $C_r$ 包含 $e_A$ 专有信息时，$[\alpha^{h^*}_{A,j} - \alpha^{h^*}_{B,j}]$ 的差值系统性大于无 RAG 时——因为 $C_r$ 中的实体专有 token 为 head $h^*$ 提供了更强的注意力锚点，放大 $|\delta_{h^*}|$。

**与 Type III 中 RAG 效应的区别**：

| | RAG 对 Type III 的效应 | RAG 对 Type IV-b 的效应 |
|---|---|---|
| **机制** | 绕过参数化记忆，直接从上下文读取答案 | 为正确 head 提供更强的区分性注意力信号 |
| **作用层次** | 解码器层（上下文 vs. 参数权重竞争） | 注意力层（$\delta_{h^*}$ 的幅度放大） |
| **依赖条件** | 检索覆盖 + 上下文利用 | 检索覆盖 + head 特化 |

两种效应同时发生，但机制独立。RAG 对 IV-b 的有效性额外依赖 head 特化假设。

**证明状态**：⚠️ 与 prompting 相同——推论链严格，但依赖 head 特化假设。比 prompting 略强：检索到的专有文档比通用 prompt 更可靠地提供实体特异性信号。

---

#### 三条策略的 SNR 视角汇总

| 策略 | 作用于 SNR 的哪个因子 | 证明状态 | 持久性 |
|---|---|---|---|
| **Prompting** | $\delta_{h^*}(x)$（通过改变注意力权重） | ⚠️ 依赖 head 特化假设 | 单次有效 |
| **Fine-tuning** | $W_O^{(h^*)}$（直接修改权重） | ✅ 条件严格（给定优化成功） | 永久改变模型 |
| **RAG** | $\delta_{h^*}(x, C_r)$（检索内容提供锚点） | ⚠️ 与 prompting 相同 | 每次检索有效 |
| **CoT** | $\delta_{h^*}(x, \mathbf{t})$（自生成区分性中间 token） | ⚠️ 条件——依赖中间步骤 SNR > 1 | 单次有效 |
| **PCP** | $\delta_{h^*}(x, C_1, \ldots, C_M)$（Router 注入结构化 Memory 页面） | ⚠️ 双向加速——依赖 Router 路由质量 + Shelve/Purge 检测 | 每轮动态有效 |

---

#### 策略四：PCP（双向加速效应）

PCP 的 Router 主动注入语义相关的 Memory 页面 $\{C_1, \ldots, C_M\}$，这些页面**超出用户明确表述的范围**，对 IV-b 产生双向效应。

**正向注入（SNR 放大）**——机制与 RAG 相同但潜在更强：

$$
|\delta_{h^*}(x, C_1, \ldots, C_M)| > |\delta_{h^*}(x)| \implies \text{SNR 提升}
$$

PCP 注入的 Memory 页面是经过协议处理的**结构化内容**（包含 id、summary、keywords 的 Page），比 RAG 检索的原始文档更密集、比 CoT 自生成的推理更可靠——提供更集中的区分性信号，单位 token 的信号增益更高。

**负向注入（噪声放大，Router 误路由时）**：若 Router 注入错误页面 $C_{\text{wrong}}$，结构化的错误页面信息密度高，每 token 的噪声贡献 $|c_h|$ 可能远大于 CoT 的扩散性错误推理：

$$
|n(x, C_{\text{wrong}})| \gg |n(x)| \quad \text{（结构化错误比扩散性错误更集中）}
$$

即：正确路由时 SNR 增益比 RAG/CoT 更强，误路由时 SNR 损失也可能比 RAG/CoT 更大。

**Shelve/Purge 的发散抑制机制**：

PCP 不同于 CoT 的关键在于：错误内容可以通过协议指令**逆向撤除**。

- **Shelve**：Worker 将 $C_{\text{wrong}}$ 折叠回 Summary，噪声 token 数从 $|C_{\text{wrong}}|$ 压缩至 $\bar{s}$：$|n| \propto |C_{\text{wrong}}| \xrightarrow{\text{Shelve}} \bar{s} \ll |C_{\text{wrong}}|$

- **Purge**：完全移除 $C_{\text{wrong}}$ + 施加负反馈权重，防止 Router 重复召回同一错误页面——阻断误路由的**再入循环**（CoT 没有等价机制）

**但 Shelve/Purge 依赖同一自举条件**：Worker 需要正确识别 $C_{\text{wrong}}$ 为错误，这个识别任务本身受 IV-b 影响。若 SNR < 1，Worker 可能无法察觉注入内容有误，抑制机制失效。

设 $p_{\text{detect}}$ 为 Worker 正确检测错误页面的概率，有效噪声为：

$$
|n_{\text{eff}}| = |n_{C_{\text{wrong}}}| \cdot (1 - p_{\text{detect}}) + \bar{s} \cdot p_{\text{detect}}
$$

其中 $p_{\text{detect}}$ 本身是当前 SNR 状态的函数——SNR 越低，错误越难被察觉，$p_{\text{detect}}$ 越小，噪声越多，SNR 进一步下降。

**与 CoT 的根本区别**：

| | CoT | PCP |
|---|---|---|
| 额外上下文来源 | 模型自生成 token | Router 注入结构化 Memory 页面 |
| 信号质量（正确路由时）| 中（依赖模型当前 SNR） | 高（结构化、预处理内容） |
| 错误放大（误路由时）| 中（扩散性错误推理） | 高（密集结构化错误页面） |
| 错误回收机制 | ❌ 无（已生成 token 难以选择性移除） | ✅ Shelve/Purge 可逆（但依赖 Worker 的检测能力） |

**证明状态**：⚠️ 正向和负向的机制推导均严格（给定 $|\delta_{h^*}|$ 随注入内容变化是 Softmax 的直接推论）。$p_{\text{detect}}$ 的具体值和 Shelve/Purge 的实际抑制效果依赖 Worker 状态和 Router 质量，无法一般性量化。

---

#### 策略五：Chain-of-Thought (CoT)

**机制**：CoT 产生的中间推理 token $\mathbf{t} = (t_1, \ldots, t_k)$ 扩充了最终预测步的上下文 $x_{\text{final}} = (x, \mathbf{t})$。若推理过程正确显式了 $e_A$ 的区分性特征，这些 token 为 head $h^*$ 提供强锚点，机制与 RAG 相同：

$$
|\delta_{h^*}(x_{\text{final}})| = |\delta_{h^*}(x, \mathbf{t})| > |\delta_{h^*}(x)|
\implies \text{SNR}(x_{\text{final}}) > \text{SNR}(x)
$$

**自举问题（Bootstrapping Problem）**：中间 token $\mathbf{t}$ 本身由模型生成，受 IV-b 影响。这产生了条件依赖循环：

- **SNR 处于阈值附近**：CoT 生成正确推理 → 显式区分特征 → $|\delta_{h^*}|$ 增大 → SNR 进一步提升 → 最终正确 ✅
- **SNR $\ll 1$ 的深度失败场景**：CoT 在错误方向上生成中间 token → 累积误导性注意力信号 → $n(x_{\text{final}})$ 增大 → SNR 进一步恶化，误路由被放大 ❌

**与 Type I 中 CoT 效应的对比**：

| | CoT 对 Type I（深度不可计算） | CoT 对 Type IV-b（特征误路由） |
|---|---|---|
| **作用机制** | 机械地扩展计算深度（电路切片模拟） | 自生成区分性上下文（扩大 $\delta_{h^*}$） |
| **是否无条件有效** | ✅ 是——与模型当前推理方向无关 | ❌ 否——依赖中间步骤的 SNR > 1 |
| **深度失败场景** | CoT 仍然有效 | CoT 可能放大错误方向 |
| **证明状态** | ✅ 命题 4（严格） | ⚠️ 条件——依赖 head 特化 + 中间步骤正确性 |

**证明状态**：⚠️ 机制与 Prompting 相同（自生成上下文 ≈ 自生成 prompt），但多了"中间步骤本身也受 IV-b 影响"的附加风险。在边界场景中有效；在深度失败场景中不可靠，可能自我强化错误方向。

---


## IV-a 与 IV-b 的统一视角

两个子类型共享同一个**父机制**：

```
有限注意力预算的分配失败
├── IV-a: 位置维度 — 哪些 token 被关注？（Softmax 零和 → O(1/N) 衰减）
└── IV-b: 特征维度 — 哪些子空间被激活？（Multi-head 叠加 → 信号干扰）
```

**统一公式**：Transformer 的输出对关键信息 $s_0$ 的依赖可以分解为：

$$
\frac{\partial \text{output}}{\partial s_0} = \underbrace{\alpha_{i,0}}_{\text{IV-a: 位置权重}} \cdot \underbrace{W_O^{(h^*)} W_V^{(h^*)}}_{\text{IV-b: 特征路由}}
$$

两个因子中任何一个趋近零，信息都无法传递到输出。IV-a 通过增大 $N$ 使第一个因子趋零；IV-b 通过上下文激活模式使第二个因子的有效贡献趋零。

### 缓解策略的差异

| | IV-a（位置稀释） | IV-b（特征误路由） |
|---|---|---|
| PCP | ✅ 直接有效（减少竞争者 + 时间维度） | ⚠️ 双向加速（正确路由时 SNR↑，误路由时 SNR↓，Shelve/Purge 部分抑制）|
| 更精确的 prompting | ❌ 无效 | ⚠️ 有效（依赖 head 特化假设）|
| Fine-tuning | ❌ 无法改变 Softmax | ✅ 条件严格（直接修改 $W_O^{(h^*)}$）|
| RAG | ⚠️ 间接（减少参数化 $N_{\text{eff}}$，但使上下文增大引入 IV-a） | ⚠️ 有效（检索文档放大 $\|\delta_{h^*}\|$，依赖 head 特化）|
| CoT | ❌ 无效（不改变 Softmax 竞争者数量） | ⚠️ 条件有效（自生成中间 token 扩大 $\|\delta_{h^*}\|$，但有自举风险）|
| Scaling（增大 $d$） | ⚠️ 间接（head 尺寸增大 → 精度略升） | ⚠️ 间接（更多 head → 更多子空间 → 干扰减少）|
| NSA 稀疏注意力 | ✅ 架构级（限制竞争者至 $O(w+k)$） | ❌ 无关（与特征路由机制无直接关系）|
