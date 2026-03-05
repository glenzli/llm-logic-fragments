## 第三部分：CAC 扩展推论

> **导言**：本部分从 §2 的严格 CAC 误差界出发，逐步推导出能力边界、误差结构、链路设计约束、能力涌现机制和对齐脆弱性的形式结论。每个命题明确标注证明状态：
> - **严格推论**（从现有定义直接可证）
> - **需额外假设的命题**（标注所需假设）
> - **开放猜想**（目前无证明路径）

---

## 7. 能力边界：从 CAC 到推理深度上界

### 7.1 可靠推理深度上界（严格推论）

**命题 7.1（推理深度硬上界）**：给定模型参数确定的 $(\varepsilon_{\max}, L)$，以及精度要求 $\delta > 0$，无 CoT 辅助时满足精度要求的最大推理链长度为：

$$l_{\max}(\delta) = \left\lfloor \frac{\log\!\left(1 + \dfrac{\delta(L-1)}{\varepsilon_{\max}}\right)}{\log L} \right\rfloor \qquad (L > 1)$$

$L = 1$ 时退化为 $l_{\max}(\delta) = \lfloor \delta / \varepsilon_{\max} \rfloor$。

**证明**：由 CAC 误差界（§2）：

$$\varepsilon_{\max} \cdot \frac{L^l - 1}{L - 1} \leq \delta$$

解不等式：

$$L^l \leq 1 + \frac{\delta(L-1)}{\varepsilon_{\max}}$$

两边取对数并除以 $\log L > 0$：

$$l \leq \frac{\log\!\left(1 + \frac{\delta(L-1)}{\varepsilon_{\max}}\right)}{\log L}$$

取整数部分即得 $l_{\max}$。$\square$

**推论 7.1a（双参数敏感性）**：

$$\frac{\partial l_{\max}}{\partial \varepsilon_{\max}} < 0, \qquad \frac{\partial l_{\max}}{\partial L} < 0$$

即单步误差越大或 Lipschitz 常数越大，可靠推理深度越浅。两者对 $l_{\max}$ 的影响量纲不同：$\varepsilon_{\max}$ 影响的是误差的起始量级，$L$ 影响的是误差的增长速率；当 $L > 1$ 时，$L$ 的作用以指数速率主导 $\varepsilon_{\max}$ 的影响。

**推论 7.1b（模型规模的间接作用）**：命题 3.1（§3.3）保证 $\varepsilon_{\max} \xrightarrow{M \to \infty} 0$。代入命题 7.1：

$$l_{\max} \xrightarrow{\varepsilon_{\max} \to 0} +\infty$$

因此，**模型规模的扩展在固定 $L$ 下可以将可靠推理深度推向无限**——但 $L$ 本身是由架构而非规模决定的，是更根本的瓶颈。（这是§2 IMPORTANT 注释中"$L$ 的控制"问题的精确化。）

---

### 7.2 误差传播的非对称结构（严格推论）

**命题 7.2（误差权重的指数非对称性）**：对长度为 $l$ 的 $r$-链 $q = r_{i_l} \circ \cdots \circ r_{i_1}$，望远镜展开后，步骤 $j$ 的单步误差 $\varepsilon_{i_j}$ 对最终误差的贡献权重为：

$$w_j = L^{l - j}, \qquad j = 1, 2, \ldots, l$$

**证明**：设 $h_j^*$ 为真实 $r$-链在第 $j$ 步的理想状态，$\hat{h}_j$ 为 $f$-链的实际状态。定义 $e_j = \|\hat{h}_j - h_j^*\|$，则：

$$e_j \leq \|\hat{h}_j - h_j^*\|$$

对第 $j$ 步展开：

$$e_j = \|E_{r_{i_j}}(\hat{h}_{j-1})\cdot\hat{h}_{j-1} - r_{i_j}(h_{j-1}^*)\|$$

$$\leq \underbrace{\|E_{r_{i_j}}(\hat{h}_{j-1})\cdot\hat{h}_{j-1} - r_{i_j}(\hat{h}_{j-1})\|}_{\leq \varepsilon_{i_j}} + \underbrace{\|r_{i_j}(\hat{h}_{j-1}) - r_{i_j}(h_{j-1}^*)\|}_{\leq L \cdot e_{j-1}}$$

递推展开，$e_0 = 0$：

$$e_l \leq \varepsilon_{i_l} + L\varepsilon_{i_{l-1}} + L^2\varepsilon_{i_{l-2}} + \cdots + L^{l-1}\varepsilon_{i_1} = \sum_{j=1}^{l} L^{l-j}\varepsilon_{i_j}$$

故步骤 $j$ 的权重为 $w_j = L^{l-j}$。$\square$

**结构性推论**：

| 步骤位置 $j$ | 误差放大倍数 $w_j$ | 含义 |
|---|---|---|
| $j = 1$（首步） | $L^{l-1}$ | **最大**——首步误差被全链放大 |
| $j = l$（末步） | $L^0 = 1$ | **最小**——末步误差不被放大 |

**含义 1（Prompt 精度的超线性收益）**：改善首步原语 $r_{i_1}$ 的拟合精度 $\varepsilon_{i_1}$ 带来的误差削减为 $L^{l-1} \cdot \Delta\varepsilon_{i_1}$，远超改善末步带来的 $\Delta\varepsilon_{i_l}$。精度改善的收益在推理链中呈现**指数权重**。

**含义 2（推理错误的雪崩模式）**：若首步产生偏差 $\delta_1$，则最终误差至少为 $L^{l-1}\delta_1$——对于 $L > 1$ 的链，早期偏差不可收回，只会被放大。这是 LLM 推理错误呈现"幻觉在推理链中雪崩式传播"模式的机制解释。

**含义 3（验证器的非对称价值）**：在推理链中插入验证步骤，在位置 $j$ 插入的价值正比于 $L^{l-j}$。因此，**在推理链头部验证的价值比尾部高出 $L^{l-1}$ 倍**——这给出了验证器放置策略的理论最优解。

---

### 7.3 CoT 的精确误差分析（严格推论，含中间 token 成本）

命题 4.2（§4.4）给出了 CoT 的定性描述，此处给出含中间 token 生成误差的精确版本。

**命题 7.3（CoT 完整误差界）**：设 CoT 将 $l$ 步 $r$-链分为 $k$ 段，每段长度 $s = l/k$（整除情形），中间 token 的生成误差为 $\varepsilon_{\text{tok}}$（物化到上下文后被读取时引入的误差），则 CoT 推理的总误差界为：

$$\text{Err}_{\text{CoT}}(k) \leq k \cdot \varepsilon_{\max} \cdot \frac{L^s - 1}{L - 1} + (k-1) \cdot \varepsilon_{\text{tok}} \cdot \frac{L^s - 1}{L - 1}$$

化简（令 $A_s = \varepsilon_{\max}(L^s-1)/(L-1)$ 为单段误差上界）：

$$\text{Err}_{\text{CoT}}(k) \leq k \cdot A_s + (k-1) \cdot \varepsilon_{\text{tok}} \cdot \frac{L^s - 1}{L-1}$$

**证明**：每段内误差由 CAC 界得 $A_s$。段间中间 token 被读取时，相当于以误差 $\varepsilon_{\text{tok}}$ 重置初始状态，此误差再经过后续 $k - j$ 段（各带 Lipschitz 放大）传播。精确求和：

$$\text{Err}_{\text{CoT}} \leq \sum_{j=1}^{k} A_s + \sum_{j=1}^{k-1} \varepsilon_{\text{tok}} \cdot \frac{L^s-1}{L-1}$$

前项为 $kA_s$，后项为 $(k-1)\varepsilon_{\text{tok}}\frac{L^s-1}{L-1}$，相加即得。$\square$

> **注**：上式保守地对每段误差线性叠加，忽略了段间误差的进一步 Lipschitz 传播。若考虑段间传播，误差会更大，但结构性结论不变。

**推论 7.3a（CoT 最优步数）**：求 $\partial \text{Err}_{\text{CoT}} / \partial k = 0$（将 $k$ 视为连续变量，$s = l/k$），得到**最优分段数** $k^*$——存在一个有限的最优 $k^*$，在 $\varepsilon_{\text{tok}}$ 较大时 $k^* < l$（不应无限细分）。

**推论 7.3b（CoT 失效条件）**：当以下条件成立时，CoT 反而比直接推理引入更多误差：

$$\varepsilon_{\text{tok}} > \varepsilon_{\max}$$

即**中间 token 的物化误差超过单步推理误差时**，引入更多 CoT 步骤适得其反。这给出了 CoT 在某些任务上失效的机制性解释：若中间步骤难以用自然语言精确表达（如空间关系、抽象代数操作、高维几何推理），$\varepsilon_{\text{tok}}$ 会很大，CoT 不稳定乃至有害。

---

### 7.4 顿悟触发的定量化（严格推论）

**命题 7.4（顿悟的 CAC 定量触发条件）**：设测试集 $T$，测试任务 $q \in T$ 依赖原语集 $R(q) \subset R_{\text{tr}}$，单步可靠概率 $p(r_i, t)$（训练步数 $t$ 的连续函数）。定义：

$$P_{\text{correct}}(q, t) = \prod_{r_i \in R(q)} p(r_i, t)$$

设可观测顿悟阈值为 $\Delta_{\text{acc}}$（测试准确率在 $\Delta t$ 内的跳变量），则顿悟在时刻 $t^*$ 对原语 $r^*$ 触发的条件为：

$$r^* = \arg\max_{r} \left|\mathcal{C}(r)\right|, \quad p(r^*, t^*) = p_{\text{thr}}$$

其中 $p_{\text{thr}}$ 满足：

$$\frac{d}{dt}\!\left[\sum_{q \in T: r^* \in R(q)} P_{\text{correct}}(q, t)\right]\!\Bigg|_{t^*} \geq \Delta_{\text{acc}} / \Delta t$$

**关键推论 7.4a（规模增大时顿悟趋于平滑）**：随模型规模 $M$ 增大，$K(M)$ 增大（已覆盖的原语数增加），剩余原语的平均能力块大小 $\langle|\mathcal{C}(r)|\rangle$ 下降（核心高价值原语优先被覆盖）。因此：

$$M \uparrow \implies \max_r |\mathcal{C}(r)|_{\text{剩余}} \downarrow \implies \Delta_{\text{acc}}|_{\text{顿悟}} \downarrow$$

**即大模型的新能力涌现幅度趋于平滑、连续化**——这与实验观测（大模型的 Scaling 更平滑，小模型顿悟更剧烈）定量吻合。

---

## 8. 计算不可约性与能力的结构性下界

### 8.1 推理链的不可约性（需额外假设）

**额外假设（R-不可约性）**：称任务 $q \in Q_{\text{unseen}}$ 在 $R_{\text{tr}}$ 上**不可约**，若其最短 $R_{\text{tr}}$-链分解长度 $l^*(q)$ 满足：不存在更短的 $R_{\text{tr}}^*$ 中等价元素，即：

$$l^*(q) = \min\!\left\{l : \exists r_{i_1},\ldots,r_{i_l} \in R_{\text{tr}},\; r_{i_l}\circ\cdots\circ r_{i_1} = q \text{ on } \mathcal{X}\right\}$$

**命题 8.1（计算不可约性——能力深度下界）**：对 $R_{\text{tr}}$ 上不可约的任务 $q$，在精度要求 $\delta$ 下，任何 $F$-链的推理都必须至少使用 $l^*(q)$ 步，即：

$$\forall \text{ $f$-chain of length } l < l^*(q): \quad \sup_{x \in \mathcal{X}} \|\text{f-chain}(x) - q(x)\| \geq \delta_{\min}(q) > 0$$

**直觉**：若 $q$ 的 $R$-分解不能被压缩，则执行 $q$ 的 $F$-链也不能被压缩——这是推理深度的**绝对下界**，与模型规模无关。规模只能降低每步的 $\varepsilon$，不能绕过不可约性。

**推论 8.1a（CoT 步数的必要下界）**：对不可约任务 $q$，CoT 的分段数 $k$ 满足：

$$k \geq \left\lceil \frac{l^*(q)}{l_{\max}(\delta)} \right\rceil$$

即存在**不可规避的 CoT 步数下界**——某些任务无论提示如何设计，都需要至少若干步显式中间推理。

> [!NOTE]
> 判断具体任务是否 $R_{\text{tr}}$-不可约，当前无形式化方法（$R$ 不可枚举）。但此命题的预测性后果可实验验证：对特定任务，系统性地测试不同 CoT 步数，观察是否存在性能陡降的步数下界。

---

### 8.2 幂律 Scaling 的 CAC 机制推导（需额外假设）

**额外假设（能力块幂律分布）**：设 $R_{\text{tr}}$ 上，能力块大小 $|\mathcal{C}(r)|$ 服从幂律分布：

$$P(|\mathcal{C}(r)| \geq c) \propto c^{-(\alpha-1)}, \qquad \alpha > 2$$

此假设与自然语言中词频的 Zipf 定律（$\alpha \approx 2$）及知识依赖图的幂律性质一致，但尚属经验推断。

**命题 8.2（Scaling Law 指数的 CAC 推导）**：设规模 $M$ 的模型能可靠覆盖的原语数为：

$$K(M) \propto M^\beta \qquad (\beta > 0)$$

则模型的总能力集大小满足：

$$|Q(M)| = \sum_{k=1}^{K(M)} |\mathcal{C}(r_k)| \sim K(M)^{2-\alpha+1} \propto M^{\beta(3-\alpha)}$$

**证明思路**：对幂律分布，前 $K$ 个最大的能力块求和（等价于 $K$ 阶统计量之和）：

$$\sum_{k=1}^{K} |\mathcal{C}(r_k)| \sim K \cdot \mathbb{E}\!\left[|\mathcal{C}|^{1}\right] \propto K^{2-\alpha+1} = K^{3-\alpha}$$

其中使用了幂律截断矩的标准结果。$\square$

**含义**：Scaling Law 中"模型能力随规模增长"的幂律指数为 $\beta(3-\alpha)$，由两个可独立测量的量决定：
- $\beta$：规模-覆盖率指数（神经正切核理论等可给出估计）
- $\alpha$：任务依赖图的幂律指数（原则上可由任务依赖分析测量）

**这将 Scaling Law 的幂律从纯经验规律提升为结构性推导。**

---

## 9. 对齐的结构性脆弱性

### 9.1 多步对齐的指数衰减定理（严格推论，结合 §5）

将 CAC 的误差结构与行为吸引子理论（§5）结合，可以得到对齐问题的最强形式结论。

**命题 9.1（对齐稳定性的指数衰减）**：设对齐目标行为 $y^*(x) = q_{\text{align}}(x)$，其对应的 $R_{\text{tr}}$-链长度为 $l_{\text{align}}$，链路 Lipschitz 常数为 $L$。对齐训练将关键原语误差压至 $\varepsilon_{\text{align}}$，对齐失败的输出偏差阈值为 $\delta_{\text{fail}}$，则对齐行为对 Prompt 扰动的稳定半径满足：

$$\rho_{\text{align}} \leq \frac{\delta_{\text{fail}} - \varepsilon_{\text{align}} \cdot \frac{L^{l_{\text{align}}}-1}{L-1}}{\left\|J_{\text{output}}\right\|} \sim \frac{\delta_{\text{fail}}}{L^{l_{\text{align}}}}$$

其中 $J_{\text{output}}$ 为整条链的 Jacobian（见 §1.5.D），分母中的 $L^{l_{\text{align}}}$ 来自 Jacobian 逐层乘积。

**核心推论（对齐脆弱性随推理深度指数衰减）**：

$$\rho_{\text{align}} \propto L^{-l_{\text{align}}}$$

**这是最深刻的结构性结论**：对齐行为所需推理链越长，其对 Prompt 扰动的稳定半径越小，以 $L$ 的指数速率衰减。具体含义：

1. **简单对齐任务（$l_{\text{align}}$ 小）**：如"拒绝有害内容"这种单步判别，稳定半径较大，RLHF 对齐效果持久；

2. **复杂对齐行为（$l_{\text{align}}$ 大）**：如"多步推理中保持价值一致性"、"在长对话中维持角色对齐"，稳定半径以 $L^{-l_{\text{align}}}$ 衰减至极小——对齐会随推理深度退化，Adversarial Prompt 可以利用极小扰动撬动对齐失败；

3. **能力-对齐权衡的 CAC 根源**：若提升能力需要更深的链（更大的 $l_{\text{align}}$），则对齐稳定性必然衰减——这不是 RLHF 的工程缺陷，而是 CAC 误差结构的**不可绕过的数学约束**。

---

### 9.2 能力提升与对齐退化的不相容性（严格推论）

**命题 9.2（能力-对齐不相容性）**：设模型能力由 $l_{\max}(\delta)$ 刻画（命题 7.1），对齐稳定性由 $\rho_{\text{align}}$（命题 9.1）刻画，则在 $L$ 和 $\delta_{\text{fail}}$ 固定的前提下：

$$l_{\max} \uparrow \iff \varepsilon_{\max} \downarrow \iff \rho_{\text{align}} \uparrow / \text{unchanged}$$

$$l_{\text{align}} \uparrow \implies \rho_{\text{align}} \downarrow \text{（指数）}$$

两个箭头说明：
- **提升能力（降低 $\varepsilon_{\max}$ 或增大 $l_{\max}$）**：对对齐稳定性无必然负面影响（$\varepsilon_{\text{align}}$ 可同步下降）；
- **要求对齐行为跨越更长推理链（增大 $l_{\text{align}}$）**：稳定性指数衰减，**不可通过提升规模绕过**。

**结论**：对齐问题的关键不在于模型是否"足够大"，而在于对齐目标行为是否需要长推理链。将对齐约束嵌入短链（单步判别）比要求长链中的价值一致性，在 CAC 框架下有**量级上的稳定性优势**。

---

## 10. CAC 的认识论极限与可证伪性

### 10.1 框架的三个固有边界

**边界 1（$R$ 的不可枚举性）**：CAC 的所有推论均以"$q$ 在 $R_{\text{tr}}^*$ 中可分解"为前提。但 $R_{\text{tr}}$ 本身不可枚举（§1.1 注）——它由训练数据的推理结构隐式决定。因此，CAC 是**条件性框架**：它说明了"如果目标任务可被原语复合描述，则……"，但无法验证这个前提。

**边界 2（$L$ 的无条件控制缺失）**：命题 7.1 依赖 $L$，但 $L$ 没有无条件的架构上界。Layer Norm 和残差连接经验性地抑制 $L$，但对具体模型的具体任务，$L$ 可能大于 1，使误差界随 $l$ 指数增长，在实践中失去意义。

**边界 3（语义合法性的外在性）**：$Q_{\text{unseen}}$ 的组合爆炸（$|R_{\text{tr}}|^l$ 量级）中，绝大多数组合不对应有意义的推理任务。CAC 框架内没有区分"有意义组合"与"随机组合"的结构——意义判断依赖 $\mathcal{X}$ 的语义，而 $\mathcal{X}$ 在 §1.1 中刻意保持为抽象集合，不携带语义结构。

### 10.2 CAC 逆定理（开放猜想）

**猜想（CAC 逆定理）**：若模型在足够大规模和充分训练后仍对任务 $q$ 系统性失败，则 $q$ 不可被 $R_{\text{tr}}^*$ 的有限复合表示：

$$\lim_{M \to \infty} \lim_{t \to \infty} \text{Acc}(M, t, q) < 1 \implies q \notin R_{\text{tr}}^*$$

**意义**：若成立，CAC 体系变为**实验可证伪的**：系统性失败 = $R$-覆盖缺口的证据，而非承载能力不足。这将指导数据策略（增加覆盖 $R$ 的训练样本）而非规模策略（扩张 $M$）。

**目前状态：开放猜想**。逆定理的证明需要 $R_{\text{tr}}$ 的可操作化定义，以及"系统性失败"排除 $L > l_{\max}$ 导致的误差爆炸的条件隔离。

> [!IMPORTANT]
> **§7–10 的推论层次总结**：
>
> | 层次 | 命题 | 状态 | 核心内容 |
> |---|---|---|---|
> | 严格推论 | 7.1 | 已证 | 推理深度硬上界 $l_{\max}$ |
> | 严格推论 | 7.2 | 已证 | 误差权重指数非对称 $w_j = L^{l-j}$ |
> | 严格推论 | 7.3 | 已证 | CoT 完整误差界，含 $\varepsilon_{\text{tok}}$ 成本 |
> | 严格推论 | 7.4 | 已证 | 顿悟定量触发；大模型顿悟趋于平滑 |
> | 需假设 | 8.1 | 条件性 | 推理链不可约性 → CoT 步数下界 |
> | 需假设 | 8.2 | 条件性 | 幂律分布假设 → Scaling Law 指数推导 |
> | 严格推论 | 9.1 | 已证 | 对齐稳定性 $\propto L^{-l_{\text{align}}}$ |
> | 严格推论 | 9.2 | 已证 | 能力-对齐不相容性的结构根因 |
> | 开放猜想 | 10.2 | 待证 | CAC 逆定理 → 失败 = $R$-覆盖缺口 |
