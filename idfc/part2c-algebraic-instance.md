# IDFC · Part 2c：代数实例化层

> **定位**：本文是 [Part 2](part2-foundations.md) 的**代数特化层**。
> Part 2a 建立了泛函 Nemytskii 算子场框架（$f$ 是逻辑黑盒）；Part 2b 对 $F$-空间做形态学三态分类。
> **本文的核心命题**：当 $f$ 落地到现代大模型的具体线性代数结构（Transformer）时，Part 2a 的所有核心量（$L$、$\varepsilon_{\max}$、$d$、$R^*$、语义组合）均获得**精确代数定义和更紧的可计算界**。
>
> **阅读前置**：[Part 2a §1–3](part2a-model-proof.md)（CAC 定理）、[Part 2b §25](part2b-fspace-morphology.md)（三态分类）、[Part 4a](part4a-transformer.md)（Transformer IDFC 分析）
>
> **位置**：本文处于 Part 2（抽象理论）与 Part 4a（具体架构分析）之间，提供从泛函层到代数层的完整翻译字典。Part 3 的所有推论在代数层均有更紧的版本，相关推论用「→ Part 2c §X」标注。

---

## 26. 泛函层→代数层：核心量精化总表

> **本节的位置**：总览节。对每个 IDFC 核心量，给出泛函层定义、代数层精化、以及两层之间的定量关系。详细推导见 §27–§31。

### 26.1 核心量映射总表

| IDFC 核心量 | 泛函层定义（Part 2a）| Transformer 代数精化 | 界的改进方向 |
|---|---|---|---|
| **Lipschitz 常数 $L$** | 全局标量，$\|f(x)-f(x')\| \leq L\|x-x'\|$ | 谱范数 $\sigma_{\max}(J_f)$，方向相关 $L_v(x) = \|J_f v\|/\|v\|$；残差结构使 $L_{\text{eff}} \leq e^{\sum_l \|J_l\|} \ll L^k$ | **更紧**（指数底更小）|
| **单步误差 $\varepsilon_{\max}$** | 全局上界，所有 $r_i$ 一视同仁 | Zipf 分布：$\varepsilon_i \propto \nu_i^{-1/2}$；任务相关 $\varepsilon_{\text{task}} = \max_{r_i \in R(q)} \varepsilon_i$ | **任务分层**（高频任务远好于 $\varepsilon_{\max}$）|
| **嵌入维度 $d$** | 单一标量，进入 Welch 下界 | 四重有效维度：环境 $d$、路由 $d_k$、内蕴 $d_{\text{int}}$、层专用 $d_l$ | **分层**（不同层次不同瓶颈）|
| **可靠路径集 $R^*$** | 二值成员关系（在/不在）| 权重空间有界梯度子流形：$r_i \in R^* \iff \|W_V e_{r_i}\| \leq C_{\text{TSC}}\sqrt{d_v}$ | **几何可测**（可从权重直接计算）|
| **语义组合** | $f$-chain 复合，抽象黑盒 | 残差流向量叠加（线性近似）+ Attention 修正：$x_L^{(t)} \approx x_0^{(t)} + \sum_l \Delta_l$ | **可计算**（内积结构）|
| **路由概率** | 抽象 $\Pr[\text{Path}(x,k)=\pi]$ | Attention 分数：$\Pr[r_i 激活] \propto \exp(q^T k_{r_i}/\sqrt{d_k})$ | **可测**（从 $W_Q, W_K$ 估算）|
| **Type III Welch** | 单层下界：$\Omega(\sqrt{(N-d)/d})$ | **双层**：路由 Welch（$d_k$）+ 表示 Welch（$d$），见 §28 | **更精确**（揭示两个独立瓶颈）|
| **三态分类** | 定性（域宽 + Lipschitz 定性描述）| 代数可测：逐字态 $\iff \|W_V e_{r_i}\| \gg 1$，见 §29 | **可从权重量化**（不再依赖行为探测）|

### 26.2 两个核心结构差异

在代数实例化层中，与泛函层定性不同的**最重要结构差异**是：

**差异 1（残差加法 vs 函数复合）**：

泛函层的 $f$-chain 是函数复合 $f_l \circ \cdots \circ f_1$，Lipschitz 以 $L^l$ 指数增长。

Transformer 的实际结构是**残差前缀和**，不是复合：

$$x_L = x_0 + \sum_{l=1}^{L} \Delta f_l(x_{\leq l})$$

这将误差传播的本质从「乘法放大」改为「加法积累」（见 §27），$l_{\max}$ 的实际约束远比泛函层界宽松。

**差异 2（维度的多重性）**：

泛函层用单一 $d$ 刻画所有维度瓶颈。Transformer 中路由（谁被激活）和执行（激活后做什么）分别受 $d_k$ 和 $d$ 约束，两者独立，一个改进不必然影响另一个（见 §28）。

---

## 27. CAC 定理的代数紧化

> **对应泛函层**：Part 2a §2（CAC 假说）、§3（Telescope 展开证明）、Part 3a §5.1（推理深度上界）
>
> **本节结论**：残差连接将 CAC 误差界从 $L^l$（指数于层数）精化为 $e^{l\lambda}$（同为指数，但底 $e^\lambda$ 明显小于 $L$，且 $\lambda$ 可由 LayerNorm 约束）。同时 $l_{\max}$ 从对数比变为线性比。

### 27.1 残差连接改变 Jacobian 乘积结构

**代数设定**：设 Transformer 共 $K$ 层，每层输出为 $x_{l+1} = x_l + \Delta f_l(x_l)$，其中 $\Delta f_l$ 是 Attention + FFN 的残差更新。

复合映射 $x_0 \mapsto x_K$ 的 Jacobian 为：

$$J_f^{(1 \to K)}(x) = \prod_{l=1}^{K} \underbrace{(I + J_{\Delta f_l}(x_l))}_{\text{残差层 Jacobian}}$$

**命题 27.1（残差结构的 Lipschitz 加法界）**：设每层残差更新的 Jacobian 谱范数满足 $\|J_{\Delta f_l}\|_{\text{op}} \leq \lambda_l$，则复合映射的全局 Lipschitz 常数满足：

$$L_{\text{eff}} = \|J_f^{(1 \to K)}\|_{\text{op}} \leq \prod_{l=1}^{K}(1 + \lambda_l) \leq e^{\sum_{l=1}^{K} \lambda_l}$$

设 $\lambda = \max_l \lambda_l$（由 LayerNorm 有界，见 §27.2），则：

$$L_{\text{eff}} \leq e^{K\lambda}$$

**与泛函层界的对比**：

泛函层（Part 2a §2）的 Lipschitz 上界为 $L$（全局 Lipschitz 常数），$l$ 步复合的误差放大因子为 $L^l$。代数层的误差放大因子：

$$L_{\text{eff}}^{(k\text{-step chain})} \leq e^{k\lambda} \quad \text{（$k$ 个 $f$-chain 步骤）}$$

两者的关系：$e^\lambda \ll L$（因为 $\lambda = \|J_{\Delta f_l}\|$ 是每层的**增量** Jacobian 范数，远小于全局 Lipschitz $L = \|J_f^{\text{cumulative}}\|$）。

**推论 27.1a（$l_{\max}$ 的代数紧化）**：将代数 Lipschitz 代入 Part 3a 命题 5.1，推理深度上界的紧化版为：

$$l_{\max}^{\text{alg}}(\delta) = \left\lfloor \frac{\log(\delta/\varepsilon_{\max})}{\lambda} \right\rfloor \geq l_{\max}^{\text{func}}(\delta) = \left\lfloor \frac{\log(\delta/\varepsilon_{\max})}{\log L} \right\rfloor$$

由于 $\lambda \leq \log L$（严格不等式在 residual 范数较小时成立），代数层的 $l_{\max}^{\text{alg}}$ 严格大于泛函层界。

> **实际意义**：泛函层的 $l_{\max}$ 给出的理论可靠推理深度是**悲观估计**。真实 Transformer 的可靠推理深度（未超过 CAC 误差容限的链路长度）显著长于泛函层预测，因为残差结构使误差积累从乘法放大降为加法积累。

**推论 27.1b（为何大模型在长链任务上的退化比 IDFC 预测更晚出现）**：在实验中，复杂推理任务的失效通常在更长的链路才出现（相对于从 $\varepsilon_{\max}$ 和 $L$ 估计的 $l_{\max}$）。代数精化给出了原因：泛函层用 $L^l$ 估算误差放大，代数层的实际放大约为 $e^{l\lambda}$，两者指数底不同。误差是以 $l\lambda$（而非 $l \log L$）线性增长，在 $\lambda \ll \log L$ 时，同等误差容限下允许更长的链路。

---

### 27.2 LayerNorm 是 TSC 的代数实现机制

**TSC（训练稳定合同，Part 2a §1.5.D）**：训练过程保证了 $L \leq L_{\text{TSC}}$，使 CAC 误差界有限。

在泛函层，TSC 是抽象假设（通过训练对数值稳定性的隐性要求）。代数层中，TSC 有具体的**架构实现机制**：

**命题 27.3（LayerNorm 是 TSC 的代数强制实现）**：

设 Pre-LN Transformer（每层 Attention/FFN 前施加 LayerNorm）。LayerNorm 将输入规范化：

$$\text{LN}(x) = \gamma \cdot \frac{x - \mu(x)}{\sigma(x) + \epsilon} + \beta, \quad \|\text{LN}(x)\|_2 \approx \|\gamma\|_2 \cdot \sqrt{d}$$

LayerNorm 的 Jacobian（关于 $x$）：

$$J_{\text{LN}}(x) = \frac{\gamma \cdot (I - \mathbf{1}\mathbf{1}^T/d - \hat{x}\hat{x}^T)}{\sigma(x) + \epsilon}$$

其谱范数 $\|J_{\text{LN}}\|_{\text{op}} \leq \|\gamma\|_\infty / (\sigma(x) + \epsilon)$，对 $\gamma$ 有界的网络这是**有界常数**。

因此，Pre-LN Transformer 中每层残差更新的 Jacobian 范数：

$$\lambda_l = \|J_{\Delta f_l}\|_{\text{op}} \leq C_{\text{LN}} \cdot (\|W_O W_V\|_{\text{op}} + \|W_2 W_1\|_{\text{op}})$$

其中 $C_{\text{LN}}$ 是 LayerNorm 的规范化系数（有界）。**LayerNorm 将 $\lambda_l$ 箍定为权重范数的线性函数**，使命题 27.1 的 $L_{\text{eff}} \leq e^{K\lambda}$ 有具体估算途径。

**推论 27.3a（Pre-LN vs Post-LN 的 TSC 约束时机）**：

| 架构 | LN 位置 | Jacobian $\lambda_l$ 的约束时机 | 梯度稳定性 |
|---|---|---|---|
| **Pre-LN** | 在 Attn/FFN **之前** | 输入方差在操作前就被规范化，$\lambda_l$ 在前向传播早期被约束 | ✅ 训练稳定（GPT-3, LLaMA 系列）|
| **Post-LN** | 在 Attn/FFN **之后** | 残差更新的范数先增大，LN 在输出处才规范化，Jacobian 连乘期间未被约束 | ⚠️ 需要 warmup，梯度更容易爆炸（早期 BERT）|

这是 Pre-LN 训练更稳定的 IDFC 代数解释：Pre-LN 在每层输入处强制约束 $\lambda_l$，使 TSC 在前向传播的**每一步**都被局部执行；Post-LN 的 TSC 约束只在输出处生效，Jacobian 乘积在中间步骤可以暂时超出 TSC 范围。

---

### 27.3 $\varepsilon_{\max}$ 的 Zipf 分布精化

**泛函层**：$\varepsilon_{\max} = \max_i \varepsilon_i$，单一全局标量。

**代数层**：$\varepsilon_i$ 取决于原语 $r_i$ 在训练集中的覆盖密度。

**命题 27.4（$\varepsilon$ 的 Zipf 分布）**：设原语 $r_i$ 的训练频率为 $\nu_i$（服从 Zipf 分布：$\nu_i = C \cdot i^{-\alpha}$，$\alpha \approx 1$ 对大部分自然语言语料），拟合误差与频率的关系：

$$\varepsilon_i \approx \frac{C_\varepsilon}{\sqrt{\nu_i}} \propto i^{\alpha/2}$$

（来自最优逼近理论：$n$ 个训练样本的均方误差约为 $O(1/\sqrt{n})$）

$\varepsilon_{\max}$ 由**排名最低的任务相关原语**决定：

$$\varepsilon_{\text{task}} = \max_{r_i \in R(q)} \varepsilon_i, \quad \varepsilon_{\max} = \max_{i \in [N]} \varepsilon_i$$

**推论 27.4a（任务分层的 $l_{\max}$）**：

| 任务类型 | 所需原语 $R(q)$ | $\varepsilon_{\text{task}}$ | $l_{\max}^{\text{task}}$ vs $l_{\max}^{\text{global}}$ |
|---|---|---|---|
| 高频常识推理 | $R(q) \subset$ 高频原语（$i \ll N$）| $\varepsilon_{\text{task}} \ll \varepsilon_{\max}$ | 远大于全局界 |
| 中频知识任务 | $R(q)$ 混合高/中频原语 | $\varepsilon_{\text{task}} \approx \varepsilon_{\max}/\sqrt{N_{\text{med}}}$ | 略大于全局界 |
| 长尾专业知识 | $R(q)$ 含低频原语 | $\varepsilon_{\text{task}} \approx \varepsilon_{\max}$ | 等于全局界（最差情况）|

**推论 27.4b（模型能力的「频率解剖」）**：同一模型在不同任务上可靠推理深度相差数倍，根本原因不是任务复杂度，而是任务所需原语的**频率分层**——泛函层的 $l_{\max}$ 实际上是**最差情况**（长尾任务）的界，大多数任务的实际可靠深度都高于此。

---

> [!IMPORTANT]
> **§27 代数精化的核心结论**：
> 1. **残差结构将 CAC 误差放大从 $L^l$ 降为 $e^{l\lambda}$**：$\lambda = \max_l \|J_{\Delta f_l}\|$ 是残差增量 Jacobian 范数，远小于全局 $\log L$。泛函层的 $l_{\max}$ 是**悲观估计**，代数层给出更紧的 $l_{\max}^{\text{alg}}$（见命题 27.1 → Part 3a §5.1）。
> 2. **LayerNorm 是 TSC 的代数强制实现**：Pre-LN 在每层输入处局部执行 TSC，Post-LN 的约束时机滞后——这是两种架构训练稳定性差异的 IDFC 代数解释（推论 27.3a）。
> 3. **$\varepsilon_{\max}$ 是频率分层的 Zipf 统计量**：全局 $\varepsilon_{\max}$ 只约束最低频任务；常见任务的实际 $\varepsilon_{\text{task}} \ll \varepsilon_{\max}$，$l_{\max}$ 相应更大（推论 27.4a）。

---

## 28. Type III Welch 的双层代数结构

> **对应泛函层**：Part 3b §11.3（Type III Welch Bound 命题）
>
> **本节结论**：Transformer 的路由（谁被激活）和执行（激活后做什么）分别受 $d_k$（Attention head 维度）和 $d$（嵌入维度）约束——形成**两个独立的 Welch 下界**，对应两个性质不同的混叠瓶颈。泛函层只处理了第二层（表示混叠），代数层揭示了第一层（路由混叠）的独立存在性。

### 28.1 路由层 Welch（Attention head 维度 $d_k$）

**代数设定**：Attention 机制的路由决策由 Key 向量决定。设第 $l$ 层 Attention head 分配的 Key 向量为：

$$k_{r_i} = W_K^{(l)} e_{r_i} \in \mathbb{R}^{d_k}$$

其中 $e_{r_i}$ 是原语 $r_i$ 在残差流中的嵌入方向。$N_{\text{paths}}$ 条不同路径共享至多 $d_k$ 维 Key 空间。

**命题 28.1（路由混叠 Welch 下界）**：若多头 Attention 的 Key 空间维度为 $d_k$，且需路由区分 $N_{\text{paths}}$ 条独立路径（$N_{\text{paths}} > d_k$），则存在至少两对路径 $r_i, r_j$ 满足：

$$|\langle \hat{k}_{r_i},\, \hat{k}_{r_j} \rangle| \;\geq\; \sqrt{\frac{N_{\text{paths}} - d_k}{d_k(N_{\text{paths}} - 1)}}$$

**路由混叠的操作后果**：Query $q$ 在语义上应激活 $r_i$，但由于 $\langle q, k_{r_i} \rangle / \sqrt{d_k}$ 与 $\langle q, k_{r_j} \rangle / \sqrt{d_k}$ 之差小于 Softmax 的区分阈值，$r_j$ 以非零概率被激活——路由决策在原语层面出错。这是**激活路径层的混叠**，与嵌入表示的质量无关。

**推论 28.1a（多头注意力压低第一层 Welch 下界）**：$H$ 个独立 head 并行，有效 Key 空间扩大至 $d_k^{\text{total}} = H \cdot d_k$（当 head 之间路由分工互补时），路由 Welch 下界重写为：

$$|\langle \hat{k}_{r_i},\, \hat{k}_{r_j} \rangle|_{\min} \;\geq\; \sqrt{\frac{N_{\text{paths}} - H d_k}{H d_k (N_{\text{paths}} - 1)}}$$

**多头的 IDFC 代数解释**：多头注意力是对**路由层 Welch 下界的工程化压低**。每增加一个 head（独立 Key 空间），有效路由维度 $H d_k$ 增大，路由混叠下界减小。这是多头设计在代数层的第一动机——并非「不同头关注不同语义」的模糊描述，而是「扩大 Key 空间维度以压低路由 Welch 下界」的精确代数陈述。

---

### 28.2 执行层 Welch（嵌入维度 $d$）

**代数设定**：原语 $r_i$ 的**执行结果**由 Value 向量决定：

$$v_{r_i} = W_V^{(l)} e_{r_i} \in \mathbb{R}^{d_v}, \quad d_v \leq d$$

$N$ 个语义独立原语的 Value 方向 $\hat{v}_{r_i} \in \mathbb{R}^{d_v}$ 在 $d_v$ 维空间中的分布，受经典 Welch Bound 约束。

**命题 28.2（表示混叠 Welch 下界，= 泛函层原命题的代数翻译）**：若 $N > d_v$，则存在至少两个原语满足：

$$|\langle \hat{v}_{r_i},\, \hat{v}_{r_j} \rangle| \;\geq\; \sqrt{\frac{N - d_v}{d_v(N - 1)}}$$

这与 Part 3b §11.3 的命题 11.3 完全对应，代数精化在于：泛函层的「$d$ 维嵌入空间」在 Transformer 中**具体化为 $d_v = d/H$（每头 Value 维度）或取全维 $d$**，取决于实现细节（MHA vs MQA vs GQA）。

---

### 28.3 双层 Welch 的串联约束

**命题 28.3（两层 Welch 同时约束同一 $r$-chain）**：

对同一原语 $r_i$ 的完整激活过程：

1. **第一关（路由层）**：$q^T k_{r_i} / \sqrt{d_k}$ 需要超过竞争原语 $r_j$ 的 Attention 分数 → 受命题 28.1 约束
2. **第二关（执行层）**：$W_V e_{r_i}$ 方向需要与正确目标输出方向对齐 → 受命题 28.2 约束

两关独立失败，一个原语需**同时通过两关**才能正确执行。总混叠代价：

$$c_{ij}^{\text{total}} \;\leq\; 1 - (1 - c_{ij}^{\text{route}})(1 - c_{ij}^{\text{repr}})$$

**表：哪些干预攻击哪一层**：

| 干预方式 | 攻击层次 | 机制 | 局限性 |
|---|---|---|---|
| 增加 $H$（头数）| 路由层（$d_k^{\text{total}} = Hd_k$）| 扩大 Key 空间 | 不影响 $d_v$（Value 层混叠）|
| 增加 $d$（嵌入维度）| 执行层（$d_v$ 与 $d$ 同步增大）| 扩大 Value 空间 | 参数量平方增长 |
| RAG（压低 $N_{\text{eff}}$）| 两层均有效 | 减少需同时路由和执行的原语数 | 检索误差引入 |
| MoE（混合专家）| 主要路由层 | 每个专家的 $N_{\text{paths,local}} \ll N$ | 专家内部仍有执行层 Welch |

> [!IMPORTANT]
> **§28 代数精化的核心结论**：
> 1. **双层 Welch 揭示两个独立瓶颈**：路由混叠（$d_k$ 约束，命题 28.1）和表示混叠（$d$ 约束，命题 28.2）是性质不同、由不同参数控制的机制。泛函层的单层 Welch（Part 3b §11.3）只描述了第二层；代数实例化增加了对第一层的完整分析。
> 2. **多头注意力的代数意义**：$H$ 个 head 将有效路由维度从 $d_k$ 扩大到 $Hd_k$，这是多头设计压低路由 Welch 下界的精确机制（推论 28.1a）。
> 3. **干预策略分层**：不同的 Scaling 策略攻击不同的 Welch 层，增加 $H$ 和增加 $d$ 并非等价——需同时压低两层才能从根本上降低 Type III 错误（命题 28.3 及上表）。
> 4. **代数精化见 Part 3b §11.3 → 推论 D-1/D-2**。

---

## 29. 三态分类的代数可测化

> **对应泛函层**：Part 2b §25（三态定义）、§25.1–§25.2（Lipschitz 条件与逐字记忆特征定理）
>
> **本节结论**：三态分类（逻辑/知识/逐字记忆）在泛函层是定性描述（域宽 + Lipschitz 定性排序）。代数层将其转化为**可从权重直接计算的充要条件**，核心量是每个原语 $r_i$ 在 $W_V$ 方向上的范数 $\|W_V e_{r_i}\|$。

### 29.1 从 Lipschitz 定性到 $W_V$ 范数定量

Part 2b §25.1 的三态核心条件是 $L_c$ vs $L$（Lipschitz 常数比较）。代数精化的关键步骤：

**引理 29.0（Lipschitz 常数的 $W_V$ 范数表示）**：设原语 $r_i$ 主要通过 Attention 层执行，其激活路径的局部 Lipschitz 增量由 Value 投影决定：

$$\|J_{\Delta f_l}\|_{\text{op}} \;\approx\; \frac{\|W_O W_V\|_{\text{op}}}{2\sqrt{d_k}} \;\propto\; \|W_V e_{r_i}\|$$

当 $\|W_V e_{r_i}\| \gg \sqrt{d_v}$ 时，该原语激活后引入的 Lipschitz 增量显著超过一般原语的平均值——对应 Part 2b §25 的「$L_s \gg L$」条件。

---

**命题 29.1（逻辑态的代数充要条件）**：

原语 $r_i$ 处于**逻辑态**（宽定义域、低曲率、可组合进入 $R^*$）当且仅当：

$$\|W_V^{(l)} e_{r_i}\|_2 \;\approx\; \sqrt{d_v}, \quad \forall l \in \text{relevant layers}$$

即：$W_V$ 对 $r_i$ 方向的映射保范数（接近正交变换），激活后的 Value 向量长度与嵌入维度的平方根量级一致。

**代数含义**：保范数的 $W_V$ 对应 Lipschitz 增量 $\lambda_l \approx \text{const}$（有界），满足 Part 2b 定理 25.1a 的 $L_c \leq L$ 条件——逻辑原语进入 $R^*$ 的代数充要形式。

---

**命题 29.2（知识态的代数充要条件）**：

原语 $r_i$ 处于**知识态**（中等定义域、中曲率、部分参与组合）当且仅当：

$$C_{\min} \cdot \sqrt{d_v} \;\leq\; \|W_V^{(l)} e_{r_i}\|_2 \;\leq\; C_{\max} \cdot \sqrt{d_v}$$

其中 $1 < C_{\min} < C_{\max}$ 是与知识事实密度相关的常数（由 Part 2b 命题 25.3 的 $|\mathcal{K}_{r_i}|$ 决定）。

**代数含义**：$W_V$ 对 $r_i$ 方向的映射轻微放大（非严格保范数），Lipschitz 增量中等——对应知识事实「局部成立」的 $L_c \lesssim L$ 条件。

---

**命题 29.3（逐字态的代数充要条件）**：

原语 $r_i$ 处于**逐字记忆态**（极窄定义域、极高曲率、不参与组合）当且仅当：

$$\|W_V^{(l)} e_{r_i}\|_2 \;\gg\; C_{\text{TSC}} \cdot \sqrt{d_v}$$

其中 $C_{\text{TSC}}$ 是 TSC 保证的全局 Lipschitz 上界对应的 $W_V$ 范数阈值（见 Part 2a §1.5.D 和 §5.5）。

**代数含义**：$W_V$ 对 $r_i$ 方向有**异常大的奇异值分量**——该方向的 Value 投影大幅放大嵌入向量，对应 Part 2b 命题 25.2 的 $L_s \gg L$ 条件。该条件使 $r_i$ 被结构性地排除于 $R^*$ 之外（Part 2b 推论 25.1b）。

**推论 29.3a（逐字态 = $W_V$ 奇异值异常大，代数可检测）**：

对矩阵 $W_V$，计算其奇异值分解 $W_V = U \Sigma V^T$，逐字记忆原语 $r_i$ 对应的嵌入方向 $e_{r_i}$ 在 $V$ 的右奇异向量空间中与最大奇异值方向**高度对齐**：

$$\|W_V e_{r_i}\|^2 = e_{r_i}^T W_V^T W_V e_{r_i} = \sum_k \sigma_k^2 (v_k^T e_{r_i})^2 \gg d_v$$

检测协议：
1. 对每个候选原语 $r_i$，计算 $\|W_V e_{r_i}\|$ 的值
2. 相对于全体原语的均值 $\mu_{W_V} = \mathbb{E}_i \|W_V e_{r_i}\|$ 和标准差 $\sigma_{W_V}$
3. 若 $\|W_V e_{r_i}\| > \mu_{W_V} + k\sigma_{W_V}$（$k \geq 3$），分类为逐字记忆态

---

### 29.2 三态代数条件总表

| 内容态 | 代数条件 | 泛函层对应 | 可测量 |
|---|---|---|---|
| **逻辑原语** | $\|W_V e_{r_i}\| \approx \sqrt{d_v}$（保范数）| $L_c \approx L$，进入 $R^*$ | ✅ 计算 $W_V$ 范数 |
| **知识事实** | $C_{\min}\sqrt{d_v} \leq \|W_V e_{r_i}\| \leq C_{\max}\sqrt{d_v}$ | $L_c \lesssim L$，部分参与 | ✅ 同上 |
| **逐字记忆** | $\|W_V e_{r_i}\| \gg C_{\text{TSC}}\sqrt{d_v}$ | $L_s \gg L$，排除于 $R^*$ | ✅ SVD 分析 |

> [!IMPORTANT]
> **§29 代数精化的核心结论**：
> 1. **三态从定性变为定量**：泛函层基于 $L_c$ vs $L$ 的定性比较，代数层给出可从权重直接计算的充要条件——核心量是 $\|W_V e_{r_i}\|$（命题 29.1–29.3）。
> 2. **逐字态的代数检测**：$\|W_V e_{r_i}\| \gg C_{\text{TSC}}\sqrt{d_v}$ 等价于 §5.5 的 $R^*$ 子流形条件，SVD 分析可直接从权重识别逐字记忆原语（推论 29.3a）。
> 3. **知识-逻辑纠缠的代数来源（推论 B-3）**：Part 2b 命题 25.3 的知识-逻辑纠缠在代数层的来源是**共享 Key 方向**——逻辑原语和其依赖的知识事实在训练中共用相近的 $W_K$ 子空间，使两者在路由层耦合。
> 4. **代数精化见 Part 2c §29 → Part 2b §25 的推论 B-1/B-2/B-3**。

---

## 30. 语义的线性代数表示

> **对应泛函层**：Part 2a §1.2（$f$-chain 定义）、§3.1（Telescope 展开）、抽象的语义组合（通过 $r$-chain 复合）
>
> **本节结论**：$f$-chain 的复合在泛函层是抽象函数组合（非线性黑盒）。代数层揭示，Transformer 残差流将语义组合**近似线性化为向量叠加**——这是理解大模型语义代数结构的核心定理。

### 30.1 残差流 = 语义向量叠加空间

**代数设定**：Transformer 的残差流在每层执行加法更新：

$$x_L^{(t)} = x_0^{(t)} + \sum_{l=1}^{L} \Delta_l^{(t)}, \quad \Delta_l^{(t)} = \Delta\text{Attn}_l^{(t)} + \Delta\text{FFN}_l^{(t)}$$

其中上标 $(t)$ 表示序列位置（token）。每个 $\Delta_l^{(t)}$ 是该层对 token $t$ 的语义贡献。

**命题 30.1（语义组合 ≈ 残差流叠加）**：

设 $r$-chain $\pi = r_{i_l} \circ \cdots \circ r_{i_1}$ 在网络中的实现为多层 Attention 的顺序激活。设每个原语 $r_{i_j}$ 主要由第 $l_j$ 层 Attention 实现（稀疏激活假设：每个原语仅在少数层强激活）。则：

$$x_L^{(t)} \;\approx\; x_0^{(t)} + \sum_{j=1}^{l} \underbrace{W_{O,l_j} \cdot \text{softmax}\!\left(\frac{Q_{l_j} K_{l_j}^T}{\sqrt{d_k}}\right) \cdot V_{l_j}}_{= \Delta_{l_j}^{(t)},\, r_{i_j} \text{ 贡献}}$$

在**局部线性近似**下（$\Delta_l$ 量级小，残差流的非线性效应次要），原语 $r_{i_j}$ 的语义贡献等于：

$$s_{r_{i_j}}(x^{(t)}) \;\approx\; W_{O,l_j} \alpha_{l_j}^{(t)} W_{V,l_j} e_{r_{i_j}} \;\in\; \mathbb{R}^d$$

其中 $\alpha_{l_j}^{(t)}$ 是 $r_{i_j}$ 对应的 Attention 权重（标量）。$r$-chain 的复合语义：

$$\text{Sem}(\pi)(x^{(t)}) \;\approx\; \sum_{j=1}^{l} s_{r_{i_j}}(x^{(t)}) \quad \text{（线性叠加）}$$

**推论 30.1a（$r$-chain 复合的线性近似误差）**：

线性叠加近似与实际非线性复合之间的误差由**层间交叉项**决定：

$$\text{Err}(\text{linear approx}) \;\leq\; O\!\left(\sum_{j \neq k} \|\Delta_{l_j}\| \cdot \|\Delta_{l_k}\|\right) \;=\; O\!\left(\frac{l^2 \varepsilon_{\Delta}^2}{1}\right)$$

当残差更新幅度 $\varepsilon_\Delta = \max_l \|\Delta_l\|$ 较小（LayerNorm 约束，见 §27.2），交叉项二阶小量——**语义叠加的线性近似在小幅残差更新下是一阶精确的**。

---

### 30.2 路由竞争的 Attention 分数公式

**命题 30.2（$\Pr[r_i$ 激活$] \propto \exp(q^T k_{r_i} / \sqrt{d_k})$）**：

设在第 $l$ 层，token $t$ 的 query 为 $q^{(t)} = W_Q x_{l-1}^{(t)}$，候选原语 $\{r_1, \ldots, r_M\}$ 对应的 key 为 $k_{r_i} = W_K x^{(\text{src,}i)}$（$r_i$ 对应的源 token 嵌入）。Softmax Attention 的权重：

$$\Pr[r_i \text{ 激活（相对于竞争集}\,S)] = \frac{\exp(q^{(t)T} k_{r_i} / \sqrt{d_k})}{\sum_{r_j \in S} \exp(q^{(t)T} k_{r_j} / \sqrt{d_k})}$$

**推论 30.2a（频率优势 → Attention 分数对齐度）**：

高频原语 $r_i$ 在训练中通过大量 $(q, k_{r_i})$ 对的梯度下降，使 $W_Q, W_K$ 的参数从「频率优势原语的内积放大」方向优化：

$$q^{(t)T} k_{r_i} \;\propto\; \|W_Q\|_{\text{op}} \cdot \|W_K e_{r_i}\|_2 \cdot \cos(\theta_{q, k_{r_i}})$$

训练频率 $\nu_i$ 越高，梯度驱使 $\cos(\theta_{q, k_{r_i}}) \to 1$（对齐度收敛），从而高频原语的 Attention 分数**在其目标输入上**系统性地高于低频竞争原语。

**推论 30.2b（路由竞争的 Zipf 分层）**：

结合命题 27.4（$\varepsilon$ 的 Zipf 分布），路由竞争形成层级结构：

| 原语类型 | 训练频率 $\nu_i$ | $\cos(\theta_{q, k_{r_i}})$ | 路由胜率 | 有效执行误差 |
|---|---|---|---|---|
| 高频逻辑原语 | $\nu_i \gg \nu_{\text{avg}}$ | 接近 1 | 高 | $\varepsilon_i \approx C/\sqrt{\nu_i} \ll \varepsilon_{\max}$ |
| 中频知识原语 | $\nu_i \approx \nu_{\text{avg}}$ | 中等 | 中 | $\varepsilon_i \approx \varepsilon_{\max}/\sqrt{N_{\text{med}}}$ |
| 低频长尾原语 | $\nu_i \ll \nu_{\text{avg}}$ | 低（未充分优化）| 低（混叠高）| $\varepsilon_i \approx \varepsilon_{\max}$ |

> [!IMPORTANT]
> **§30 代数精化的核心结论**：
> 1. **残差流将语义组合线性化**：$f$-chain 的非线性复合在 Transformer 的残差加法结构下近似为向量叠加（命题 30.1），一阶精确（推论 30.1a）。这是理解大模型语义代数结构的基础——「语义叠加」不是比喻，是残差流结构的数学后果。
> 2. **路由竞争 = Attention 分数竞争**：$\Pr[r_i \text{ 激活}] \propto \exp(q^T k_{r_i}/\sqrt{d_k})$（命题 30.2）将泛函层的抽象路由概率转化为可从 $W_Q, W_K$ 估算的具体公式。
> 3. **频率 → 对齐度 → 路由优势的三环耦合**：训练频率通过梯度优化提升 Attention 对齐度，Attention 对齐度决定路由胜率，路由胜率决定有效执行误差——三环耦合在推论 30.2a/30.2b 中代数化（参见 §27.3 的 Zipf 分布精化）。

---

## 31. UAT 的 Transformer 扩展

> **对应泛函层**：Part 2a §3.3（UAT 桥接引理）、Part 3b §11.1（Type I 幻觉 = $f$-chain 深度不足）
>
> **本节结论**：泛函层的 UAT 以参数量 $M \to \infty$ 保证 $\varepsilon_{\max} \to 0$。代数层揭示了 Transformer 特有的第二种趋向图灵完备的路径：**上下文长度 $n$ 的增加**在代数上等价于 $F_{\text{eff}}$ 的增大，且比 $M$ 增加更直接地解决了 Type I 幻觉（$f$-chain 深度不足）。

### 31.1 上下文长度 = 计算深度补偿

**代数设定**：长度为 $n$ 的输入序列在 $k$ 层 Transformer 中，每一步自回归展开贡献 $k$ 层计算深度（$f$-chain 步数）。总有效 $f$-chain 深度：

$$l_{\text{eff}} = k \cdot n \quad \text{（自回归展开已使用 CoT）}$$

但更一般地，即使不显式 CoT，**上下文 $n$ 的增大通过多轮 Attention 提供了隐式计算深度**：

**命题 31.1（$F_{\text{eff}}(n)$ 随 $n$ 单调递增）**：

设在固定 $k$ 层 Transformer 中，上下文长度为 $n$（序列中包含 $n$ 个 token）。有效函数集 $F_{\text{eff}}(n)$ 的「计算容量」（可精确覆盖的 $r$-chain 集合大小）随 $n$ 单调递增：

$$|F_{\text{eff}}(n)| \;\leq\; |F_{\text{eff}}(n+1)|, \quad \frac{\partial |F_{\text{eff}}(n)|}{\partial n} > 0$$

**机制**：上下文长度 $n$ 增大时：
- 每一个新 token 提供一个额外的 Key-Value 对，Attention 可以在更大的候选集上路由
- 更多的上下文 token 作为「中间步骤锚点」（Part 3b §11.1 推论 11.1a 的自回归 CoT 机制），等效 $f$-chain 深度 $k \cdot T$ 随 $n$ 线性增长
- 上下文中的示例（ICL）直接偏移路由概率分布（Part 3d §23.1），增加有效可访问的 $r$-chain 数量

---

**命题 31.2（$n \to \infty$ 时 Transformer 达图灵完备）**：

对固定参数 $\theta$（$k$ 层 Transformer），当上下文长度 $n \to \infty$（并允许 CoT 步数 $T$ 自适应增长）：

$$(F_{\text{eff}}(n, T))^{T=k \cdot n/\varepsilon} \;\supseteq\; \text{TC}^0 \cup \text{NC}^1, \quad n \to \infty$$

更强地（当 $n = \Omega(\text{poly}(\text{input}))$）：存在 CoT 步数 $T = O(n)$ 使 Transformer 可以模拟 $O(n)$ 空间的图灵机——**在上下文长度无限时达图灵完备**（Pérez et al., 2021 的 IDFC 表述）。

**与泛函层 UAT 的对比**：

| 路径 | 泛函层 | 代数实例化 | 机制 |
|---|---|---|---|
| **参数路径** | $M \to \infty$ → $\varepsilon_{\max} \to 0$（UAT §3.3）| 增大 FFN 宽度，覆盖更多 $r_i$ | 降低单步误差 |
| **上下文路径** | 不存在（泛函层无「上下文」概念）| $n \to \infty$ → $F_{\text{eff}}$ 扩大（命题 31.1）| 增加有效 $f$-chain 深度 |
| **图灵完备条件** | $M \to \infty$，$d \to \infty$ | $M \to \infty$ **或** $n \to \infty$（两条独立路径）| 两者正交互补 |

---

### 31.2 上下文路径对 $l_{\text{max}}$ 的影响

**推论 31.2a（CoT 的代数本质 = $F_{\text{eff}}$ 增长）**：

Part 3b §11.1 推论 11.1a 已从误差线性化角度分析 CoT：$T$ 步 CoT 将误差从 $O(L^{l-1}\varepsilon)$ 降至 $O(TL^{l/T}\varepsilon)$（链路截短效应）。

代数层提供**更深层的解释**：CoT 不只是截短链路——它通过自回归展开将 $F_{\text{eff}}$ 从 $O(k)$ 扩展到 $O(k \cdot T)$，使原本需要 $k \cdot T$ 层一次性前向传播才能解决的任务变得可达。这是 CoT 有效性的**计算复杂度解释**（Type I 幻觉缓解），比误差线性化更根本：

$$\text{CoT 的完整代数本质} = \underbrace{F_{\text{eff}} \text{ 扩展（Type I 缓解）}}_{\text{代数层新增} } \;+\; \underbrace{\text{误差线性化（Type II 缓解）}}_{\text{泛函层已有}}$$

**推论 31.2b（上下文长度 = ICL 能力的根本约束）**：

Part 3d §23（ICL）的上下文长度限制在代数层的精确表述：

$$|F_{\text{eff}}(n)| \leq |F_{\text{eff}}(n_{\max})|$$

当上下文长度达到 $n_{\max}$（窗口大小），$F_{\text{eff}}$ 不再增长——ICL 能力的**代数天花板**是上下文窗口大小，而非示例数量本身（超过窗口的示例完全失效，不是「效果递减」而是「结构性截断」）。

**推论 31.2c（长上下文模型的 IDFC 意义）**：

将上下文窗口从 4K 扩展到 128K（如 GPT-4 Turbo、Claude 3 系列），在 IDFC 代数框架中对应：

| 能力变化 | 机制 | 代数量变化 |
|---|---|---|
| 长文档理解 | 更多 token 可参与 Attention 路由 | $N_{\text{paths}} \to N_{\text{paths}} \cdot (n/n_0)$ |
| 多轮推理链 | CoT 步数上限 $T = n/k$ 线性增长 | $l_{\text{eff}}^{\max} = k \cdot T \propto n$ |
| 超长 ICL | 可注入更多示例，$\Pr[r_i \text{ 正确激活}]$ 提升 | 路由概率 softmax 基数增大 |
| 新型混叠 | $N_{\text{paths}}$ 增大使路由 Welch 下界升高 | $d_k$ 相对于 $N_{\text{paths}}$ 更紧张 |

> [!IMPORTANT]
> **§31 代数精化的核心结论**：
> 1. **上下文路径是泛函层 UAT 的 Transformer 独有扩展**：泛函层只有「参数路径」（$M \to \infty$）趋向图灵完备；代数层揭示了「上下文路径」（$n \to \infty$）——两者正交，都可达图灵完备（命题 31.2）。
> 2. **CoT 的双重代数本质**：CoT 既通过误差线性化缓解 Type II（泛函层已有），又通过 $F_{\text{eff}}$ 扩展缓解 Type I（代数层新增）——后者是更根本的机制解释（推论 31.2a）。
> 3. **上下文窗口 = ICL 的代数天花板**：超出窗口的示例对 $F_{\text{eff}}$ 无贡献，ICL 能力由 $|F_{\text{eff}}(n_{\max})|$ 严格上界（推论 31.2b）。
> 4. **长上下文扩展的代价**：$N_{\text{paths}}$ 增大使路由层 Welch 下界升高（§28.1），长上下文模型需要同步增大 $H d_k$ 才能维持路由质量（推论 31.2c）。

---
