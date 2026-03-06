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

**推论 4.1a（$Q$ 的三态过滤）**：能参与组合涌现、构成 $Q$ 的来源，只限于**逻辑原语**（Logic 态，Part 2b §25.1，宽域/低曲率/可组合）。另外两态在结构上不贡献 $Q$：

- **逐字记忆态**（$L_s \gg L$）：被结构性排除于 $R^*$ 之外（Part 2b 推论 25.4a），$E_{\text{verbatim}} \notin \bigcup_{r_i \in R_{\text{tr}}} \{E_{r_i}(x)\}$，无法成为任何 $Q$-任务的构成原语。
- **知识事实态**：通过为逻辑原语提供定义域宽度基底（$|\mathcal{X}_{r_i}| \geq \Omega(|\mathcal{K}_{r_i}|^{1/d})$，Part 2b 命题 25.3）间接支撑 $Q$，但其自身不产生组合爆炸。

因此，$Q$ 的 $|R^*|^l$ 量级组合大小来自且仅来自逻辑原语集合的大小，与模型存储了多少逐字记忆内容无关。

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

**推论 4.2a（Zipf 瓶颈原语决定顿悟时刻）**：乘积 $P(q, t) = \prod_j p(r_{i_j}, t)$ 中，增长最慢的因子是**训练频率最低的原语**。由代数层 Part 2c §27.4 的 Zipf 分布：

$$\varepsilon_{i} \propto \nu_i^{-1/2} \implies p(r_i, t) \text{ 的增速与 } \nu_i^{1/2} \text{ 成正比}$$

顿悟时刻 $t^*$ 由**瓶颈原语** $i^* = \arg\min_j \nu_{i_j}$（链路中训练频率最低的原语）的阈值交叉时刻决定：

$$t^* \approx \inf\{t : p(r_{i^*}, t) \geq p_{\text{thr}}\}$$

**含义**：顿悟不由链路平均频率决定，而由"最短板原语"的 Zipf 排名决定。包含一个长尾低频原语的链路，无论其他原语多早可靠，都需等到 $r_{i^*}$ 本身跨越阈值。这也解释了为什么某些"看起来简单"的任务（链路短但含低频原语）比"看起来复杂"的任务（链路长但全为高频原语）更晚涌现。

**推论 4.2b（知识覆盖约束逻辑阈值速率）**：$p(r_i, t)$ 的增长速率不只取决于 $r_i$ 本身的训练频率，还受其**知识基底**大小的约束。由 Part 2b 命题 25.3：

$$|\mathcal{X}_{r_i}| \;\geq\; \Omega\!\left(|\mathcal{K}_{r_i}|^{1/d}\right)$$

有效定义域宽度 $|\mathcal{X}_{r_i}|$ 越小，组合可用阈值 $p_{\text{thr}}$ 越难在典型输入分布上达到。若知识事实覆盖 $|\mathcal{K}_{r_i}|$ 增长缓慢（训练数据中例示 $r_i$ 的知识样本稀少或单一），则无论逻辑规则本身被训练了多少次，$\mathcal{X}_{r_i}$ 域宽不足，$r_i$ 永远无法达到组合可用阈值。

**含义（数据质量 vs 数据量的 IDFC 机制）**：逻辑原语的涌现有两个独立的速率瓶颈——逻辑规则本身的学习速率（受 $\nu_{r_i}$ 控制）和知识基底的积累速率（受 $|\mathcal{K}_{r_i}|$ 控制）。堆砌更多重复性数据（高 $\nu_{r_i}$ 但 $|\mathcal{K}_{r_i}|$ 不增加）不能解锁逻辑原语的涌现；只有增加**知识多样性**（新的知识事实例示，扩大 $\mathcal{K}_{r_i}$）才能拓宽逻辑原语定义域，使其越过组合可用阈值。

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

**CoT 的双重机制**：上文着重刻画了 Type II 视角（误差线性化）。代数层（Part 2c §31.2a）揭示了更根本的 Type I 视角：CoT 通过自回归展开将有效函数集 $F_{\text{eff}}$ 从 $O(k)$ 扩展至 $O(k \cdot T)$，使原本需要 $k \cdot T$ 层一次性前向传播才能解决的任务（Type I 幻觉域）变得可达——这是计算复杂度层面的机制，独立于误差线性化：

$$\text{CoT 完整本质} = \underbrace{F_{\text{eff}} \text{ 扩展（Type I 缓解）}}_{\text{可计算类扩张}} \;+\; \underbrace{\text{误差线性化（Type II 缓解）}}_{\text{单步误差控制}}$$

**推论**：更长的 CoT 不只是给模型更多「思考时间」，而是在两个独立维度上同时扩展了可达的 $Q$ 集合：一是绕过了 $f$-chain 深度天花板（Type I），二是在误差约束下延伸了可靠推理长度（Type II）。

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

**推论 4.4a（涌现偏序的 $F$-空间几何根因）**：命题 4.4 的拓扑排序不只是抽象图论约束，而是 $F$-空间几何的必然结果。Part 2b §25.3c 证明，$F$-空间中内容的形成顺序有层级结构：

$$\text{逐字记忆（窄槽首先刻入）} \xrightarrow{\text{多种表述拓宽}} \text{知识事实} \xrightarrow{\text{覆盖足够多样}} \text{逻辑原语（可组合）}$$

由 $|\mathcal{X}_{r_i}| \geq \Omega(|\mathcal{K}_{r_i}|^{1/d})$，**知识事实的积累是逻辑原语域宽的必要前提**。因此在 $G_R$ 中，为逻辑原语 $r_i$ 提供知识基底的内容必然在 $r_i$ 涌现之前先达到可靠覆盖——这是可证明的几何必然，而非人为约定的课程学习顺序。

**实践含义**：若某领域的知识事实稀疏（$|\mathcal{K}_{r_i}|$ 小），则该领域的逻辑原语 $r_i$ 即便逻辑规则被覆盖也无法进入 $\mathcal{C}(r_i)$ 触发涌现——必须先补充知识事实的**多样性**才能打开这个缺口。这对数据飞轮设计有直接指导价值：优先增加知识覆盖的多样性，而非重复已有知识的数量。

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

**推论 C-1（Transformer 实例化的 $l_{\max}$ 紧化版，= Part 2c §27 推论 27.1a）**：

当 $f$ 落地到 Transformer（残差连接结构），泛函层用 $\log L$ 为分母的 $l_{\max}$ 公式（命题 5.1）获得代数紧化版：

$$l_{\max}^{\text{alg}}(\delta) = \left\lfloor \frac{\log(\delta/\varepsilon_{\max})}{\lambda} \right\rfloor \geq l_{\max}^{\text{func}}(\delta)$$

其中 $\lambda = \max_l \|J_{\Delta f_l}\|_{\text{op}}$ 是**残差增量 Jacobian 的谱范数**（远小于全局 $\log L$，因为 $\lambda$ 是每层的增量范数而非复合后的全局 Lipschitz）。由 LayerNorm 将 $\lambda_l$ 约束为权重范数的线性函数（$\lambda_l \leq C_{\text{LN}} \cdot (\|W_O W_V\| + \|W_2 W_1\|)$），$\lambda$ 是可从权重估算的具体量。

**代数精化的量化含义**：$l_{\max}^{\text{alg}} / l_{\max}^{\text{func}} = (\log L) / \lambda \geq 1$，严格大于 1（在残差范数较小时）。泛函层对可靠推理深度**悲观估计**——真实 Transformer 的实际容限链长比命题 5.1 的预测更长，差异量级由 $\log L / \lambda$ 决定。

---



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

**推论 C-2（Transformer 中误差权重的代数分解，= Part 2c §27 命题 27.1）**：

泛函层的误差权重 $w_j = L^{l-j}$（命题 5.2）在 Transformer 代数层分解为：

$$w_j = L^{l-j} = \prod_{j' = j}^{l-1} (1 + \lambda_{j'}) \leq e^{(l-j) \cdot \lambda}$$

其中 $\lambda_{j'} = \|J_{\Delta f_{j'}}\|_{\text{op}}$（每层残差的 Jacobian 谱范数）可由 LayerNorm 估算：

$$\lambda_{j'} \leq C_{\text{LN}} \cdot (\|W_O^{(j')}\|_{\text{op}} \cdot \|W_V^{(j')}\|_{\text{op}} + \|W_2^{(j')}\|_{\text{op}} \cdot \|W_1^{(j')}\|_{\text{op}})$$

**实用含义**：误差权重的非对称结构（首步权重远大于末步）在代数层可量化——通过计算各层 $\lambda_{j'}$ 的乘积，可以估算实际权重而无需用全局 $L^{l-j}$ 作保守上界。这对验证器放置策略的精确优化有直接意义。

---



### 5.3 CoT 的精确误差分析（严格推论，含中间 token 成本）

命题 4.3（§4.4）给出了 CoT 的定性描述。$\varepsilon_{\text{tok}}$ 的正式定义见 [Part 2 §1.7A](part2a-model-proof.md)（「连续 $f$-chain 输出物化为离散 token 时的信息损失」，即 $\varepsilon_{\text{tok}} \triangleq \mathbb{E}_{\hat{w} \sim p_T}\!\left[\|e_{\hat{w}} - h^*\|\right]$），此处给出含 $\varepsilon_{\text{tok}}$ 的精确版本。

**命题 5.3（CoT 完整误差界）**：设 CoT 将 $l$ 步 $r$-链分为 $k$ 段，每段长度 $s = l/k$（整除情形），中间 token 的生成误差为 $\varepsilon_{\text{tok}}$，则 CoT 推理的总误差界为：

$$\text{Err}_{\text{CoT}}(k) \leq k \cdot \varepsilon_{\max} \cdot \frac{L^s - 1}{L - 1} + (k-1) \cdot \varepsilon_{\text{tok}} \cdot \frac{L^s - 1}{L-1}$$

化简（令 $A_s = \varepsilon_{\max}(L^s-1)/(L-1)$ 为单段误差上界）：

$$\text{Err}_{\text{CoT}}(k) \leq (k \cdot \varepsilon_{\max} + (k-1) \cdot \varepsilon_{\text{tok}}) \cdot \frac{L^s - 1}{L-1}$$

**推论 5.3a（CoT 最优步数）**：存在有限最优 $k^*$，在 $\varepsilon_{\text{tok}}$ 较大时 $k^* < l$（不应无限细分）。

**推论 5.3b（CoT 失效条件）**：当 $\varepsilon_{\text{tok}} > \varepsilon_{\max}$ 时，CoT 反而比直接推理引入更多误差。即**中间 token 的物化误差超过单步推理误差时**，引入更多 CoT 步骤适得其反。

$\varepsilon_{\text{tok}}$ 升高的结构根因（Part 2b §25，三态分类）：中间步骤所对应内容的内容态决定了其物化代价——

| 中间步骤内容态 | $L_c$ 性质 | $\varepsilon_{\text{tok}}$ 大小 | CoT 是否稳定 |
|---|---|---|---|
| **逻辑原语**（宽域、低曲率）| $L_c \approx L$（有界）| 接近 0（稳定 token 化）| ✅ 稳定 |
| **知识事实**（中等域）| $L_c \lesssim L$ | 中等 | ⚠️ 依任务 |
| **逐字/高维内容**（极窄域、极高曲率）| $L_s \gg L$ | **极大**（$\mathcal{X}$ 极小，微小 token 误差即脱槽） | ❌ 不稳定 |

空间关系、抽象代数操作、高维几何推理等任务的中间步骤本质上对应高 Lipschitz 内容——物化时 $L_s \gg L$，任意 token 近似误差都被高度放大，这是「自然语言难以精确表达」的 IDFC 结构解释，而非主观描述。

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
> 此处 $l_{\max}(\delta)$ 使用全局最坏情形界（命题 5.1），对应任务所需原语中频率最低的一个（见 Part 2c §27.4a：$\varepsilon_{\text{task}} = \max_{r_i \in R(q)} \varepsilon_i$）。实际上 $l_{\max}$ 是任务相关的：高频常识推理任务的 $\varepsilon_{\text{task}} \ll \varepsilon_{\max}$，其 $l_{\max}^{\text{task}} \gg l_{\max}^{\text{global}}$，CoT 步数下界相应更松；长尾专业知识任务才真正受全局界约束。判断具体任务是否 $R_{\text{tr}}$-不可约，当前无形式化方法（$R$ 不可枚举）——此命题的预测性后果可实验验证：系统性测试不同 CoT 步数，观察是否存在性能陡降的步数下界。

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

**推论 C-3（$\varepsilon_i$ Zipf 分布为幂律 Scaling 提供代数来源，= Part 2c §27 命题 27.4）**：

命题 7.2 的能力块幂律假设（$|\mathcal{C}(r)|$ 幂律）与代数层的 $\varepsilon$ Zipf 分布（命题 27.4）相互印证：

- 训练频率 $\nu_i \propto i^{-\alpha}$（Zipf，$\alpha \approx 1$）→ 拟合误差 $\varepsilon_i \propto \nu_i^{-1/2} \propto i^{\alpha/2}$
- 高频原语（小 $i$）误差小、覆盖深、能力块大（$|\mathcal{C}(r_i)|$ 大）
- 低频原语（大 $i$）误差大、覆盖浅、能力块小（$|\mathcal{C}(r_i)|$ 小）

两者共同说明的结构：**频率驱动的 Zipf 分布同时决定了 $\varepsilon_i$ 的层级和 $|\mathcal{C}(r_i)|$ 的分布**——泛函层的能力块幂律假设（命题 7.2）在代数层获得了来自训练统计的自然来源，不再是独立的经验假设。

**可验证预测**：若 $\varepsilon_i$ 确实服从 Zipf 分布（可从权重分析估算），则 Scaling Law 指数 $\beta(3-\alpha)$ 中的 $\alpha$ 应与语料的词频 Zipf 指数成正比——这是两个来自不同层面的独立测量值，若实验吻合则对 IDFC 代数实例化层提供强验证。

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

