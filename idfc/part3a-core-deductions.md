# IDFC · Part 3a：核心推论

> **本文内容**：§4–§10，包含行为推论、CAC 扩展严格推论、对齐脆弱性、条件性命题、框架边界与开放问题，以及与行为吸引子理论的连接。
> 其余内容见：[Part 3b 幻觉分类](part3b-hallucination.md) · [Part 3c 训练方法分析](part3c-training-methods.md) · [Part 3d 技术专题分析](part3d-techniques.md)

---

## 4. 行为推论

### 4.1 训练集覆盖与涌现集

设训练集 $\{t_1, \ldots, t_n\}$ 各自对应的拟合覆盖为 $\{s_1, \ldots, s_n\}$（直接训练所能覆盖的输出集合）。

**涌现集 $Q$**：

$$Q = \{ q \notin \bigcup_i s_i \mid q \text{ 的输入-输出关系可以被某条 } R\text{-链路描述} \}$$

**定理 4.1（广义可达性）**：若 CAC 成立，则对任意 $q \in Q$，模型的某条 $F$-链路能近似完成 $q$ 对应的映射。

这正是"涌现能力"的形式化定义：当 $F$ 从训练中积累了足够多的 $r$ 近似者，原本不在训练集覆盖中的 $Q$ 忽然变得可达。这个跨越在测试度量上为何看起来是"突变"而非渐变，见 §4.3。

### 4.2 为什么涌现不可预测

涌现集 $Q$ 不可预测，因为：
1. 我们不知道 $R$ 的完整集合（未知的原始逻辑原语）
2. 我们不知道 $F$ 已经覆盖了哪些 $r$
3. 我们不知道哪些 $R$-链路对应了高价值的 $Q$ 元素

因此，即使知道模型规模 $M$，也无法事先枚举 $Q$。

### 4.3 顿悟：组合阈值效应

**拟合过程始终是连续的**。权重空间里不存在跳跃——梯度下降是持续震荡逼近，损失曲线平滑（带振荡）地下降。顿悟在**测试准确率**上看起来突变，原因来自两个相互叠加的效应：

**效应一（CAC 组合可达性）**：设 $p(r_i, t)$ 为训练第 $t$ 步时模型对 $r_i$ 的近似可靠概率——这是关于 $t$ 的连续函数。对需要 $r_{i_1}, \ldots, r_{i_k}$ 全部可靠才能正确的测试用例 $q$：

$$P(q \text{ 正确}, t) \approx \prod_{j=1}^{k} p(r_{i_j}, t)$$

这仍是连续函数。但注意：乘积在各因子均接近阈值时，对任意单因子的变化极度敏感——具有**锐利相变**的统计性质。

**效应二（测试集非正交性）**：测试集中的用例并非独立。设 $N(r_i)$ 为测试集中依赖 $r_i$ 的用例数量。当 $p(r_i, t)$ 跨越可靠阈值，$N(r_i)$ 个用例**同时**从错变对——这是组合爆炸，不是拟合跳跃。测试集的高度非正交性放大了这个效应。

> **命题 4.2（顿悟的 CAC 解释）**：顿悟是**组合结构在测试度量上的相变**，而非权重空间中的非连续事件。训练连续地逼近各 $r_i$；当足够多的 $r_i$ 的近似精度同时超过组合可用阈值时，CAC 保证的 $Q$ 集合中大量元素同时变得可达，而测试集的非正交性将这一批量翻转放大为测试准确率上的"突变"。

---

### 4.4 思维链（CoT）：误差线性化机制

**同构性基础**（**定理 1.7**，[Part 2 §1.7C](part2a-model-proof.md)）：在计算机理层面，自回归展开与 CoT 是**同一数学结构的两种描述**——区别仅在于中间 token 对目标 $r$-chain 步骤的**对齐质量** $\varepsilon_{\text{tok}}^{(t)}$（$\varepsilon_{\text{tok}}$ 的正式定义见 [Part 2 §1.7A](part2a-model-proof.md)）：

$$\text{自回归展开} \equiv \text{CoT} \quad \iff \quad \varepsilon_{\text{tok}}^{(t)} \to 0 \quad \forall t$$

即：「Chain-of-Thought 提示」是对这种对齐质量从低到高的工程描述，不是独立的计算机制。

**问题根源**：对长度为 $l$ 的 $r$-链，误差在 $L$-Lipschitz 条件下以 $O(L^{l-1}\varepsilon)$ 累积（CAC 定理，Part 2 §2）。模型存在一个**可靠链路长度上限** $l_{\max}$——对需要深度 $l > l_{\max}$ 的 $r$-链问题，直接推理会失败。

**CoT 的介入机制**：将 $r$-链分解为 $k$ 段，每段长度 $l/k \leq l_{\max}$，并将每段终态 $t_i$ 显式生成为输出 token：

$$x \xrightarrow{r_1} t_1 \xrightarrow{r_2} t_2 \xrightarrow{\;\cdots\;} t_{k-1} \xrightarrow{r_k} y$$

**误差从指数降至线性**：

| 模式 | 误差上界 |
|---|---|
| 无 CoT（直接推理） | $O(L^{l-1}\varepsilon)$（指数） |
| 理想 CoT（每步 1 个 $r$，$\varepsilon_{\text{tok}}^{(t)} \to 0$） | $k\varepsilon$（线性） |

**中间 token 作为状态锚点**：生成的 $t_i$ 进入上下文后，后续位置通过注意力直接 attend 到它（即定理 1.7 的自回归展开中 $x^{(t+1)} = (x^{(t)}, e_{\hat{w}^{(t+1)}})$）。这将隐式 $f$-链路的中间状态「物化」为显式向量，等价于将每段 $r$-链的初始条件重置为已知精确状态——消除了跨段误差传递。

> **命题 4.3（CoT 能力扩展）**：对可靠链路长度上限为 $l_{\max}$ 的模型，$k$ 步 CoT 将可解问题的有效 $r$-链深度从 $l_{\max}$ 扩展至 $k \cdot l_{\max}$，且误差保持可控。（含 $\varepsilon_{\text{tok}}$ 成本的精确版本见 §5.3）

**推论**：更长的 CoT 不只是给模型更多「思考时间」，而是在 $f$-链路误差约束下合法地延伸了可达的 $Q$ 集合范围。

---

### 4.5 $r$-依赖图与能力聚簇

**定义（$r$-依赖图）**：构建有向图 $G_R = (V, E)$，其中顶点为 $R$，若学习 $r_i$ 以 $r_j$ 为先决条件则有边 $r_j \to r_i$。

**定义（能力块）**：对 $r_k \in R$，其能力块为：

$$\mathcal{C}(r_k) = \{ q \in Q \mid r_k \text{ 出现在 } q \text{ 的某条 } R\text{-链分解中} \}$$

当 $p(r_k, t)$ 过可靠阈值时，$|\mathcal{C}(r_k)|$ 个能力同时涌现——$|\mathcal{C}(r_k)|$ 越大，"突变"越剧烈。

**能力共现矩阵**：

$$\Phi_{ij} = |R\text{-chain}(q_i) \cap R\text{-chain}(q_j)|$$

$\Phi_{ij}$ 越大，$q_i$ 与 $q_j$ 同时涌现的概率越高。这是测试集"非正交性"的形式化。

**涌现偏序**：$G_R$ 的拓扑排序给出能力涌现的顺序：若 $r_j \to r_i$，则 $\mathcal{C}(r_j)$ 中的能力必然早于 $\mathcal{C}(r_i)$ 涌现。

> **命题 4.4（涌现偏序）**：能力集合的涌现顺序与 $G_R$ 的拓扑排序一致。

**Scaling Law 的 CAC 解释**：设 $K(M)$ 为规模 $M$ 的模型能可靠覆盖的 $r$ 数量，则：

$$|Q(M)| \approx \sum_{r_k : k \leq K(M)} |\mathcal{C}(r_k)|$$

若能力块大小服从幂律分布（少数核心 $r$ 支撑大量 $q$），则 $|Q(M)|$ 随 $M$ 呈阶梯式增长——这正是观测到的 Scaling Law"涌现能力"现象的 CAC 机制解释。

---

## 5. CAC 扩展严格推论

### 5.1 推理深度硬上界（严格推论）

**命题 5.1（推理深度硬上界）**：给定模型参数确定的 $(\varepsilon_{\max}, L)$，以及精度要求 $\delta > 0$，无 CoT 辅助时满足精度要求的最大推理链长度为：

$$l_{\max}(\delta) = \left\lfloor \frac{\log\!\left(1 + \dfrac{\delta(L-1)}{\varepsilon_{\max}}\right)}{\log L} \right\rfloor \qquad (L > 1)$$

$L = 1$ 时退化为 $l_{\max}(\delta) = \lfloor \delta / \varepsilon_{\max} \rfloor$。

**证明**：由 CAC 误差界（Part 2 §2）：$\varepsilon_{\max} \cdot \frac{L^l - 1}{L - 1} \leq \delta$，解不等式取整即得。$\square$

**推论 5.1a（双参数敏感性）**：

$$\frac{\partial l_{\max}}{\partial \varepsilon_{\max}} < 0, \qquad \frac{\partial l_{\max}}{\partial L} < 0$$

即单步误差越大或 Lipschitz 常数越大，可靠推理深度越浅。当 $L > 1$ 时，$L$ 的作用以指数速率主导 $\varepsilon_{\max}$ 的影响。

**推论 5.1b（模型规模的间接作用）**：Part 2 §3.3 保证 $\varepsilon_{\max} \xrightarrow{M \to \infty} 0$，代入得 $l_{\max} \xrightarrow{\varepsilon_{\max} \to 0} +\infty$。模型规模的扩展在固定 $L$ 下可以将可靠推理深度推向无限——但 $L$ 本身是由架构而非规模决定的，是更根本的瓶颈。

---

### 5.2 误差传播的非对称结构（严格推论）

**命题 5.2（误差权重的指数非对称性）**：对长度为 $l$ 的 $r$-链 $q = r_{i_l} \circ \cdots \circ r_{i_1}$，望远镜展开后，步骤 $j$ 的单步误差 $\varepsilon_{i_j}$ 对最终误差的贡献权重为：

$$w_j = L^{l - j}, \qquad j = 1, 2, \ldots, l$$

**证明**：递推展开 $e_l \leq \sum_{j=1}^{l} L^{l-j}\varepsilon_{i_j}$（见 Part 2 §3.2），即得步骤 $j$ 的权重 $w_j = L^{l-j}$。$\square$

**结构性推论**：

| 步骤位置 $j$ | 误差放大倍数 $w_j$ | 含义 |
|---|---|---|
| $j = 1$（首步） | $L^{l-1}$ | **最大**——首步误差被全链放大 |
| $j = l$（末步） | $L^0 = 1$ | **最小**——末步误差不被放大 |

**含义 1（Prompt 精度的超线性收益）**：改善首步原语 $r_{i_1}$ 的拟合精度 $\varepsilon_{i_1}$ 带来的误差削减为 $L^{l-1} \cdot \Delta\varepsilon_{i_1}$，远超改善末步带来的 $\Delta\varepsilon_{i_l}$。精度改善的收益在推理链中呈现**指数权重**。

**含义 2（推理错误的雪崩模式）**：若首步产生偏差 $\delta_1$，则最终误差至少为 $L^{l-1}\delta_1$——对于 $L > 1$ 的链，早期偏差不可收回，只会被放大。这是 LLM 推理错误呈现"幻觉在推理链中雪崩式传播"模式的机制解释。

**含义 3（验证器的非对称价值）**：在推理链中插入验证步骤，在位置 $j$ 插入的价值正比于 $L^{l-j}$。因此，**在推理链头部验证的价值比尾部高出 $L^{l-1}$ 倍**——这给出了验证器放置策略的理论最优解。

---

### 5.3 CoT 的精确误差分析（严格推论，含中间 token 成本）

命题 4.3（§4.4）给出了 CoT 的定性描述。$\varepsilon_{\text{tok}}$ 的正式定义见 [Part 2 §1.7A](part2a-model-proof.md)（「连续 $f$-chain 输出物化为离散 token 时的信息损失」，即 $\varepsilon_{\text{tok}} \triangleq \mathbb{E}_{\hat{w} \sim p_T}\!\left[\|e_{\hat{w}} - h^*\|\right]$），此处给出含 $\varepsilon_{\text{tok}}$ 的精确版本。

**命题 5.3（CoT 完整误差界）**：设 CoT 将 $l$ 步 $r$-链分为 $k$ 段，每段长度 $s = l/k$（整除情形），中间 token 的生成误差为 $\varepsilon_{\text{tok}}$，则 CoT 推理的总误差界为：

$$\text{Err}_{\text{CoT}}(k) \leq k \cdot \varepsilon_{\max} \cdot \frac{L^s - 1}{L - 1} + (k-1) \cdot \varepsilon_{\text{tok}} \cdot \frac{L^s - 1}{L-1}$$

化简（令 $A_s = \varepsilon_{\max}(L^s-1)/(L-1)$ 为单段误差上界）：

$$\text{Err}_{\text{CoT}}(k) \leq (k \cdot \varepsilon_{\max} + (k-1) \cdot \varepsilon_{\text{tok}}) \cdot \frac{L^s - 1}{L-1}$$

**推论 5.3a（CoT 最优步数）**：存在有限最优 $k^*$，在 $\varepsilon_{\text{tok}}$ 较大时 $k^* < l$（不应无限细分）。

**推论 5.3b（CoT 失效条件）**：当 $\varepsilon_{\text{tok}} > \varepsilon_{\max}$ 时，CoT 反而比直接推理引入更多误差。即**中间 token 的物化误差超过单步推理误差时**，引入更多 CoT 步骤适得其反。这给出了 CoT 在某些任务上失效的机制性解释：若中间步骤难以用自然语言精确表达（如空间关系、抽象代数操作、高维几何推理），$\varepsilon_{\text{tok}}$ 会很大，CoT 不稳定乃至有害。

---

### 5.4 顿悟触发的定量化（严格推论）

**命题 5.4（顿悟的 CAC 定量触发条件）**：设测试集 $T$，测试任务 $q \in T$ 依赖原语集 $R(q) \subset R_{\text{tr}}$，单步可靠概率 $p(r_i, t)$（训练步数 $t$ 的连续函数）。定义：

$$P_{\text{correct}}(q, t) = \prod_{r_i \in R(q)} p(r_i, t)$$

设可观测顿悟阈值为 $\Delta_{\text{acc}}$，则顿悟在时刻 $t^*$ 对原语 $r^*$ 触发的条件为：

$$r^* = \arg\max_{r} \left|\mathcal{C}(r)\right|, \quad p(r^*, t^*) = p_{\text{thr}}$$

其中 $p_{\text{thr}}$ 满足：

$$\frac{d}{dt}\!\left[\sum_{q \in T: r^* \in R(q)} P_{\text{correct}}(q, t)\right]\!\Bigg|_{t^*} \geq \Delta_{\text{acc}} / \Delta t$$

**关键推论 5.4a（规模增大时顿悟趋于平滑）**：随模型规模 $M$ 增大，$K(M)$ 增大，剩余原语的平均能力块大小下降（核心高价值原语优先被覆盖）：

$$M \uparrow \implies \max_r |\mathcal{C}(r)|_{\text{剩余}} \downarrow \implies \Delta_{\text{acc}}|_{\text{顿悟}} \downarrow$$

**即大模型的新能力涌现幅度趋于平滑、连续化**——与实验观测（大模型 Scaling 更平滑，小模型顿悟更剧烈）定量吻合。

---

## 6. 对齐的结构性脆性（严格推论，结合行为吸引子）

### 6.1 多步对齐的指数衰减定理

将 CAC 的误差结构与行为吸引子理论（见 §9）结合，可以得到对齐问题的最强形式结论。

**命题 6.1（对齐稳定性的指数衰减）**：设对齐目标行为 $y^*(x) = q_{\text{align}}(x)$，其对应的 $R_{\text{tr}}$-链长度为 $l_{\text{align}}$，链路 Lipschitz 常数为 $L$。对齐训练将关键原语误差压至 $\varepsilon_{\text{align}}$，对齐失败的输出偏差阈值为 $\delta_{\text{fail}}$，则对齐行为对 Prompt 扰动的稳定半径满足：

$$\rho_{\text{align}} \leq \frac{\delta_{\text{fail}} - \varepsilon_{\text{align}} \cdot \frac{L^{l_{\text{align}}}-1}{L-1}}{\left\|J_{\text{output}}\right\|} \sim \frac{\delta_{\text{fail}}}{L^{l_{\text{align}}}}$$

**核心推论（对齐脆弱性随推理深度指数衰减）**：

$$\rho_{\text{align}} \propto L^{-l_{\text{align}}}$$

**这是最深刻的结构性结论**：对齐行为所需推理链越长，其对 Prompt 扰动的稳定半径越小，以 $L$ 的指数速率衰减。具体含义：

1. **简单对齐任务（$l_{\text{align}}$ 小）**：如"拒绝有害内容"这种单步判别，稳定半径较大，RLHF 对齐效果持久；

2. **复杂对齐行为（$l_{\text{align}}$ 大）**：如"多步推理中保持价值一致性"、"在长对话中维持角色对齐"，稳定半径以 $L^{-l_{\text{align}}}$ 衰减至极小——对齐会随推理深度退化，Adversarial Prompt 可以利用极小扰动撬动对齐失败；

3. **能力-对齐权衡的 CAC 根源**：若提升能力需要更深的链（更大的 $l_{\text{align}}$），则对齐稳定性必然衰减——这不是 RLHF 的工程缺陷，而是 CAC 误差结构的**不可绕过的数学约束**。

---

### 6.2 能力提升与对齐退化的不相容性（严格推论）

**命题 6.2（能力-对齐不相容性）**：设模型能力由 $l_{\max}(\delta)$ 刻画（命题 5.1），对齐稳定性由 $\rho_{\text{align}}$（命题 6.1）刻画，则在 $L$ 和 $\delta_{\text{fail}}$ 固定的前提下：

$$l_{\max} \uparrow \iff \varepsilon_{\max} \downarrow \iff \rho_{\text{align}} \uparrow / \text{unchanged}$$

$$l_{\text{align}} \uparrow \implies \rho_{\text{align}} \downarrow \text{（指数）}$$

两个箭头说明：
- **提升能力（降低 $\varepsilon_{\max}$ 或增大 $l_{\max}$）**：对对齐稳定性无必然负面影响（$\varepsilon_{\text{align}}$ 可同步下降）；
- **要求对齐行为跨越更长推理链（增大 $l_{\text{align}}$）**：稳定性指数衰减，**不可通过提升规模绕过**。

**结论**：对齐问题的关键不在于模型是否"足够大"，而在于对齐目标行为是否需要长推理链。将对齐约束嵌入短链（单步判别）比要求长链中的价值一致性，在 CAC 框架下有**量级上的稳定性优势**。

---

# 第二类推论：条件性命题

> 以下命题需要额外假设。假设已明确标注，且其预测性后果原则上可实验验证。

---

## 7. 条件性命题

### 7.1 计算不可约性（需：$R$ 的稀疏性假设）

**额外假设（$R$-不可约性）**：称任务 $q \in Q_{\text{unseen}}$ 在 $R_{\text{tr}}$ 上**不可约**，若其最短 $R_{\text{tr}}$-链分解长度 $l^*(q)$ 满足：不存在更短的 $R_{\text{tr}}^*$ 中等价元素，即：

$$l^*(q) = \min\!\left\{l : \exists r_{i_1},\ldots,r_{i_l} \in R_{\text{tr}},\; r_{i_l}\circ\cdots\circ r_{i_1} = q \text{ on } \mathcal{X}\right\}$$

**命题 7.1（计算不可约性——能力深度下界）**：对 $R_{\text{tr}}$ 上不可约的任务 $q$，在精度要求 $\delta$ 下，任何 $F$-链的推理都必须至少使用 $l^*(q)$ 步：

$$\forall \text{ $f$-chain of length } l < l^*(q): \quad \sup_{x \in \mathcal{X}} \|\text{f-chain}(x) - q(x)\| \geq \delta_{\min}(q) > 0$$

**直觉**：若 $q$ 的 $R$-分解不能被压缩，则执行 $q$ 的 $F$-链也不能被压缩——这是推理深度的**绝对下界**，与模型规模无关。规模只能降低每步的 $\varepsilon$，不能绕过不可约性。

**推论 7.1a（CoT 步数的必要下界）**：对不可约任务 $q$，CoT 的分段数 $k$ 满足：

$$k \geq \left\lceil \frac{l^*(q)}{l_{\max}(\delta)} \right\rceil$$

即存在**不可规避的 CoT 步数下界**——某些任务无论提示如何设计，都需要至少若干步显式中间推理。

> [!NOTE]
> 判断具体任务是否 $R_{\text{tr}}$-不可约，当前无形式化方法（$R$ 不可枚举）。但此命题的预测性后果可实验验证：对特定任务，系统性地测试不同 CoT 步数，观察是否存在性能陡降的步数下界。

---

### 7.2 幂律 Scaling 的 CAC 机制推导（需：能力块幂律分布假设）

**额外假设（能力块幂律分布）**：设 $R_{\text{tr}}$ 上，能力块大小 $|\mathcal{C}(r)|$ 服从幂律分布：

$$P(|\mathcal{C}(r)| \geq c) \propto c^{-(\alpha-1)}, \qquad \alpha > 2$$

此假设与自然语言中词频的 Zipf 定律（$\alpha \approx 2$）及知识依赖图的幂律性质一致，但尚属经验推断。

**命题 7.2（Scaling Law 指数的 CAC 推导）**：设规模 $M$ 的模型能可靠覆盖的原语数为 $K(M) \propto M^\beta$，则模型的总能力集大小满足：

$$|Q(M)| = \sum_{k=1}^{K(M)} |\mathcal{C}(r_k)| \sim K(M)^{2-\alpha+1} \propto M^{\beta(3-\alpha)}$$

**证明思路**：对幂律分布，前 $K$ 个最大的能力块求和（等价于 $K$ 阶统计量之和）：$\sum_{k=1}^{K} |\mathcal{C}(r_k)| \propto K^{3-\alpha}$。代入 $K(M) \propto M^\beta$ 即得。$\square$

**含义**：Scaling Law 中"模型能力随规模增长"的幂律指数为 $\beta(3-\alpha)$，由两个可独立测量的量决定：
- $\beta$：规模-覆盖率指数（神经正切核理论等可给出估计）
- $\alpha$：任务依赖图的幂律指数（原则上可由任务依赖分析测量）

**这将 Scaling Law 的幂律从纯经验规律提升为结构性推导。**

---

# 第三类：认识论极限与开放猜想

---

## 8. 框架边界与可证伪性

### 8.1 CAC 框架的三个固有边界

CAC 定理体系在逻辑上遭遇三个**固有极限**，这些不是技术空缺，而是框架边界：

**边界 1（$R$ 的不可枚举性）**：CAC 的所有推论均以"$q$ 在 $R_{\text{tr}}^*$ 中可分解"为前提。但 $R_{\text{tr}}$ 本身不可枚举——它由训练数据的推理结构隐式决定。因此，CAC 是**条件性框架**：它说明了"如果目标任务可被原语复合描述，则……"，但无法验证这个前提。

**边界 2（$L$ 的无条件控制缺失）**：命题 5.1 依赖 $L$，但 $L$ 没有无条件的架构上界。Layer Norm 和残差连接经验性地抑制 $L$，但对具体模型的具体任务，$L$ 可能大于 1，使误差界随 $l$ 指数增长，在实践中失去意义。

**边界 3（语义合法性的外在性）**：$Q_{\text{unseen}}$ 的组合爆炸（$|R_{\text{tr}}|^l$ 量级）中，绝大多数组合不对应有意义的推理任务。CAC 框架内没有区分"有意义组合"与"随机组合"的结构——意义判断依赖 $\mathcal{X}$ 的语义，而 $\mathcal{X}$ 在 Part 2 §1 中刻意保持为抽象集合，不携带语义结构。

### 8.2 CAC 逆定理（开放猜想）

**猜想（CAC 逆定理）**：若模型在足够大规模和充分训练后仍对任务 $q$ 系统性失败，则 $q$ 不可被 $R_{\text{tr}}^*$ 的有限复合表示：

$$\lim_{M \to \infty} \lim_{t \to \infty} \text{Acc}(M, t, q) < 1 \implies q \notin R_{\text{tr}}^*$$

**意义**：若成立，CAC 体系变为**实验可证伪的**：系统性失败 = $R$-覆盖缺口的证据，而非承载能力不足。这将指导数据策略（增加覆盖 $R$ 的训练样本）而非规模策略（扩张 $M$）。

**目前状态：开放猜想**。逆定理的证明需要 $R_{\text{tr}}$ 的可操作化定义，以及"系统性失败"排除 $L > l_{\max}$ 导致的误差爆炸的条件隔离。

> [!IMPORTANT]
> 此逆定理目前是猜想状态，证明需要建立 $R_{\text{tr}}$ 生成能力与模型成功率之间的充要条件——目前框架中 $R$ 尚不可枚举。

---

## 9. 与行为吸引子理论的关系

> 见 [`behavioral-attractors/theory.md`](../behavioral-attractors/theory.md)

**连接命题**：行为吸引子盆地是特定 $F$-链路构型的稳定态。

具体地：
- 每个**吸引子盆地** $B_k$ 对应一种**特征性的 $f$-链路激活模式**
- Prompt / adapter 激活吸引子 = 引导模型进入某个特定 $F$-链路构型
- **CAC 解释了吸引子为什么存在**：每个吸引子盆地代表一个稳定的 $R$-链路近似，而该近似在 $F$-链路空间中形成了一个局部极小

因此，**CAC（本文）包含了行为吸引子理论的存在性基础**：
- 行为吸引子理论：描述了这些稳定态的拓扑结构（多少个、多深、如何导航）
- CAC：解释了这些稳定态为什么存在（因为 $F$ 在近似 $R$ 的过程中，形成了与 $R$-链路对应的稳定 $F$-链路构型）

---

## 10. 开放问题

1. **$R$ 的可发现性**：能否通过分析 $F$ 的组合行为，反向推断模型实际学到了哪些 $r$ 近似？

2. **相变条件**：顿悟发生的精确阈值——$M$ 需要多大、训练数据需要覆盖多少 $R$——能否形式化？

3. **链路选择机制**：给定输入 $x$，模型如何在指数级大的 $F$-链路空间中"找到"正确的链路？（这可能是注意力机制和 in-context learning 的计算层解释，见 [Part 4](part4-empirical.md)）

4. **$L$ 的架构控制**：是否存在可证明的架构约束，使 $L$ 保持有界或小于 1？

---

