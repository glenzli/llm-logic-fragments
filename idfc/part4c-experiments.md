# IDFC · Part 4c：实验验证

> **本文内容**：§11–§18，实验验证接口（1.58-bit 量化）、整数加法长度泛化、Reversal Curse、Needle in a Haystack、Grokking、GSM8K/MATH 分层、Inverse Scaling U 型曲线、实验验证体系总览。
> 其余内容见：[Part 4a Transformer](part4a-transformer.md) · [Part 4b 对比架构](part4b-architectures.md) · [Part 4d 现象分析](part4d-phenomena.md)

---

## 11. 1.58-bit 极限量化的实验验证接口

> **定位**：本节将 [Part 3 §15.7](part3-deductions.md) 的理论推论转化为**可执行的实验方案**，作为 IDFC 框架在量化极限情形下与现实数据接轨的验证层。BitNet b1.58 的独特性在于：它不仅是一种量化工程方案，更是验证 CAC 误差传播理论的**天然受控实验**——三值权重的结构性约束将 $\varepsilon_{\max}$ 的下界提升至可观测量级，使 IDFC 对 $l_{\max}$ 的预测变得可测量、可反驳。

---

### 11.1 实验设计的第一性原理基础

Part 3 §15.7 的核心理论链路是：

$$\delta_q^{\min}(d) > 0 \implies \varepsilon_{\max}^{\text{1.58}} > \varepsilon_{\max}^{\text{fp32}} \implies l_{\max}^{\text{1.58}} < l_{\max}^{\text{fp32}} \implies \text{性能差距（gap）随 } l \text{ 指数扩大}$$

将此链路映射到可观测量的关键是：**任务的有效推理链长度 $l_{\text{eff}}$ 对大多数 benchmark 来说是可以估计的**。例如：

| 任务类型 | 估计 $l_{\text{eff}}$ | 依据 |
|---|---|---|
| 事实检索（TriviaQA）| $l_{\text{eff}} \sim 1$–$2$ | 近乎直接的知识提取 |
| 常识推理（HellaSwag）| $l_{\text{eff}} \sim 3$–$5$ | 浅层因果链 |
| 多步数学（MATH，1–2 步）| $l_{\text{eff}} \sim 5$–$10$ | 中等推理链 |
| 多步数学（MATH，4–5 步）| $l_{\text{eff}} \sim 15$–$25$ | 长推理链 |
| 复杂代码生成（HumanEval Hard）| $l_{\text{eff}} \sim 20$–$40$ | 长程依赖链 |

**IDFC 预测**：1.58-bit 与全精度的性能 gap 应在 $l_{\text{eff}}$ 增大时以指数速率扩大（$\propto L^{l_{\text{eff}}}$），而非线性扩大。

---

### 11.2 五个关键实验的设计规范

#### 实验 E1：链长度分层的性能 gap 验证（验证 P1）

**定理 11.1（gap 指数增长）**：在 Scaling 轨迹 $d \propto M^{0.25}$ 和固定架构 $L$ 的假设下，1.58-bit 与全精度模型的性能 gap：

$$\text{gap}(l_{\text{eff}}) = (\varepsilon_{\max}^{\text{1.58}} - \varepsilon_{\max}^{\text{fp32}}) \cdot \frac{L^{l_{\text{eff}}} - 1}{L - 1}$$

关于 $l_{\text{eff}}$ **严格单调递增**，且 gap 增长速率关于 $l_{\text{eff}}$ 为**指数**级别（而非线性）——是否是指数增长由 $L$ 是否 $> 1$ 决定。

**证明**：

- 由 Part 3 §15.7，$\delta_q^{\min}(d) > 0$ 严格成立，因此 $\varepsilon_{\max}^{\text{1.58}} - \varepsilon_{\max}^{\text{fp32}} > 0$（设为常数 $\Delta\varepsilon > 0$）。
- CAC 误差界（Part 2 §2）：$\text{gap}(l) = \Delta\varepsilon \cdot (L^l - 1)/(L - 1)$。
- 若 $L > 1$：$(L^l - 1)/(L-1)$ 关于 $l$ 严格凸增，$\log \text{gap}$ 关于 $l$ 追近线性，**指数增长**。
- 若 $L = 1$：无限 $L \to 1$极限，gap $ = \Delta\varepsilon \cdot l$，**线性增长**（临界情形）。

因此：**P1 成立（$L > 1 $ 时指数，$L = 1$ 时线性）是严格定理推论**，不需实验验证。实验的唯一作用是**测量 $L$ 的具体数值**（通过拟合指数斯率）。$\square$

**实验设计**（用于实测 $L$）：

1. 选择具有**已知推理链长度**的基准集，按 $l_{\text{eff}} \in \{1, 3, 5, 10, 20\}$ 分 5 层
2. 对同参数量的 BitNet b1.58 与 BF16 基线分别测试
3. 以对数坐标绘制 gap$(l_{\text{eff}})$：旺率 $\approx \log L$，截距 $\approx \log \Delta\varepsilon$

**潜在基准集**：GSM8K（按推理步数分层）、MATH（按难度分层）、BIG-Bench（长推理子集）

**反驳条件**：若 gap$(l_{\text{eff}})$ 在 $l_{\text{eff}} > 10$ 后趋于平缓或反向收缩，则 IDFC 的 $L > 1$ 假设需要重新检验（可能 $L \approx 1$ 或 $L < 1$）。

---

#### 实验 E2：嵌入维度 $d$ 的控制实验（验证 P2）

**IDFC 预测（P2）**：$\delta_q^{\min}(d) \propto 1/\sqrt{d}$，相同参数量但 $d$ 更大的模型（"宽矮型"）gap 更小。

**实验设计**：

1. 固定总参数量 $M \approx$ 7B，变化架构：$(d = 2048, k = 48)$ vs. $(d = 4096, k = 24)$ vs. $(d = 8192, k = 12)$（$d \cdot k \cdot d_{\text{ffn}}$ 大致不变）
2. 分别训练 BitNet b1.58 配置，在长链任务上测试
3. 绘制 gap 关于 $1/\sqrt{d}$ 的线性关系

**IDFC 可观测量**：若 gap $\approx C/\sqrt{d}$ 则 P2 成立，斜率 $C$ 是 $\sigma^*$（目标模型所需最小奇异值）的度量。

**实验挑战**：固定参数量变架构会改变训练效率。需控制训练 FLOPs，不只是参数量。

---

#### 实验 E3：CoT 收益的分层实验（验证 P4）

**定理推论 11.2（$k^{*,\text{1.58}} < k^{*,\text{fp32}}$）**：在固定任务、固定架构的条件下，1.58-bit 模型的 CoT 最优段数**严格小于**全精度模型：

$$k^{*,\text{1.58}} < k^{*,\text{fp32}}$$

**证明**：由命题 5.3（CoT 完整误差界），最优段数 $k^*$ 是 $\text{Err}_{\text{CoT}}(k)$ 关于 $k$ 的最小化点。确切地，对于 $\varepsilon_{\text{tok}}$ 足够小的分析情形（ $\varepsilon_{\text{tok}} \ll \varepsilon_{\max}$ ），误差界化简为：

$$\text{Err}_{\text{CoT}} \approx k \cdot \varepsilon_{\max} \cdot \frac{L^{l/k} - 1}{L - 1}$$

关于 $k$ 对上式求导令其为零，可得 $k^*$ 由 $\varepsilon_{\max}$ 和 $l$ 决定。具体地，$k^*$ 是当分步误差和截断误差平衡时的点，满足 $\partial/\partial k[k \varepsilon_{\max} (L^{l/k}-1)/(L-1)] = 0$。

因为 $\varepsilon_{\max}^{\text{1.58}} > \varepsilon_{\max}^{\text{fp32}} > 0$（功率 §15.7），而 $k^*$ 关于 $\varepsilon_{\max}$ 单调递减（单步误差越大，分段的边际收益越小，最优段数越小）：

$$\varepsilon_{\max}^{\text{1.58}} > \varepsilon_{\max}^{\text{fp32}} \implies k^{*,\text{1.58}} < k^{*,\text{fp32}} \quad \square$$

且 $\text{Acc}(k^{*,\text{1.58}}) \leq \text{Acc}(k^{*,\text{fp32}})$（上限更低）直接来自 $\varepsilon_{\max}^{\text{1.58}} > \varepsilon_{\max}^{\text{fp32}}$。

**实验设计**（用于实测 $\varepsilon_{\max}$ 差幂）：

1. 在固定任务（如 MATH Level 5）上，系统测试 1.58-bit 与 BF16 模型对 CoT 段数 $k \in \{1, 2, 4, 8, 16\}$ 的反应
2. 拟合 $\text{Acc}(k)$ 曲线，提取饱和点 $k^*$
3. 比较两者的 $(k^*, \text{Acc}(k^*))$

**反驳条件**：若 $k^{*,\text{1.58}} \approx k^{*,\text{fp32}}$，则表明 CoT 的有效性与 $\varepsilon_{\max}$ 关系不强，命题 5.3 的预测在该任务域失效，需检查 $\varepsilon_{\text{tok}}$ 项是否主导。

---

#### 实验 E4：规模极限的 Gap 收敛性测试（验证 / 反驳 P5）

**定理 11.3（指数 gap 收敛正下界）**：在标准 Scaling 轨迹 $d \propto M^{0.25}$ 的假设下，gap 在 $M \to \infty$ 时收敛至**严格正的**下界 $\Delta_\infty(d) > 0$，而非趋于零。

**证明**：

由 §11.3e 的正交分离定理：
1. $\varepsilon_{\max}(M) \xrightarrow{M \to \infty} 0$（UAT，任意快）
2. $c_{ij}^*(d, N) \geq \Omega(\sqrt{(N-d)/d(N-1)}) > 0$（Welch Bound，与 $M$ 无关）

存在唯一的 $M^* = \min\{M : \varepsilon_{\max}(M) \leq c_{ij}^* \cdot \|v^*\|\}$，对 $M > M^*$：

$$\text{gap}(M, l) = (\varepsilon_{\max}^{\text{1.58}} - \varepsilon_{\max}^{\text{fp32}}) \cdot \frac{L^l - 1}{L-1} \xrightarrow{M \to \infty} \Delta\varepsilon_{\infty} \cdot \frac{L^l - 1}{L-1} > 0$$

其中 $\Delta\varepsilon_{\infty} = \delta_q^{\min}(d_\infty) > 0$，而在 Scaling 轨迹 $d \propto M^{0.25}$ 下，$d_\infty = \lim_{M\to\infty} M^{0.25} \to \infty$，但 $c_{ij}^*(d_\infty)$ 单调递减至 $0^+$（$\propto 1/\sqrt{d_\infty}$）而非严格为 0。因此导致两个等价情形：

| Scaling 轨迹 | $\Delta_\infty = \lim_{M\to\infty} c_{ij}^*(M^{1/4})$ | 结论 |
|---|---|---|
| $d \propto M^{0.25}$（标准）| $\Omega(M^{-1/8}) \to 0^+$，但对**固定有限** $M$ 严格正 | $\Delta_\infty(M_{\max}) > 0$（对任意指定规模 $M_{\max}$ 严格为正）|
| $d \propto M^{0.5}$（超线性增长）| $\Omega(1/M^{1/4}) \to 0^+$ | 同上 |
| $d \not\to \infty$（$d$ 固定）| $c_{ij}^*(d) = $ 常数 $> 0$ | $\Delta_\infty$ 严格正 |

对于实际可训练的**任意指定规模** $M_{\max}$（GPU 集群上可训练的最大模型）：$d(M_{\max}) < \infty$，因此 $\Delta\varepsilon_\infty = \delta_q^{\min}(d(M_{\max})) > 0$。**P5 在任意有限规模上是严格定理**。$\square$

**IDFC 可分辨的两种结果**：

| 结果 | 含义 | IDFC 修订方向 |
|---|---|---|
| $\Delta_\infty > 0$（gap 收敛正值）| $\delta_q^{\min}(d)$ 不可消除，P5 成立 | 理论确认，IDFC 无需修订 |
| $\Delta_\infty \to 0$（gap 趋于零）| $d$ 的增速足以消除 $\delta_q^{\min}$；$d/M$ 关系比假设的更强 | 需更新 §15.7.4 的 Scaling 假设，补充「$d$ 超线性增长」情形的兼容分析 |

**注意**：P5 的反驳是建设性的，不是破坏性的——它指向 IDFC 对 Scaling 假设的精化，不影响 CAC 核心定理。

---

#### 实验 E5：长短任务的差异化分层测试（验证 P3）

**IDFC 预测（P3）**：gap 在长链任务上远大于短链任务——不是绝对性能差距的均匀缩放，而是**任务 $l_{\text{eff}}$ 的函数**。

**最易执行的版本**：

```
gap_score(task) = [Acc_fp32(task) - Acc_1.58(task)] / [1 - Acc_1.58(task)]

绘制 gap_score 关于 estimated l_eff 的散点图
```

IDFC 预测散点图中：
- 短链任务（$l_{\text{eff}} < 5$）：gap_score < 0.1
- 中链任务（$l_{\text{eff}} \sim 10$）：gap_score ≈ 0.2–0.3
- 长链任务（$l_{\text{eff}} > 20$）：gap_score > 0.5

**若散点图呈单调递增趋势，P3 成立**；若无趋势，则 $l_{\text{eff}}$ 不是 gap 的主要预测变量，需考虑其他变量（如知识密集度导致的 Type III 效应）。

---

### 11.3 实验结果的 IDFC 解释框架

所有实验的结果通过以下框架进行解读：

$$\text{gap}(l_{\text{eff}}, d, M) = \left(\varepsilon_{\max}^{\text{1.58}} - \varepsilon_{\max}^{\text{fp32}}\right) \cdot \frac{L^{l_{\text{eff}}} - 1}{L - 1}$$

其中三个可分解的因子：

| 因子 | IDFC 参数 | 实验可测性 | 对应实验 |
|---|---|---|---|
| $(\varepsilon_{\max}^{\text{1.58}} - \varepsilon_{\max}^{\text{fp32}})$ | $\delta_q^{\min}(d) \propto 1/\sqrt{d}$ | 通过 E2（固定 $M$ 变 $d$）分离 | E2 |
| $L^{l_{\text{eff}}}$ | Lipschitz 常数 $L$（架构决定）| 通过 E1 的斜率估计 | E1 |
| $l_{\text{eff}}$ | 任务推理链长度 | 任务标注或模型估计 | E3, E5 |

**关键实验公式**：将 E1 的斜率 $\approx \log L$ 与 E2 的截距 $\approx \delta_q^{\min}(d)$ 组合，可以**从实验数据中反推** IDFC 的两个核心参数 $L$ 和 $\delta_q^{\min}$，进而验证 Part 2 §1.5.D 对 $L$ 的理论估计是否与宏观观测一致。这是 IDFC 框架少有的**参数自洽性检验机会**。

---

### 11.4 与 Part 4 其他验证节的关系

| 本节实验 | Part 4 对应理论 | 共同验证的 IDFC 命题 |
|---|---|---|
| E1（gap 随 $l$ 指数扩大）| §4（Attention 信息提取界）、§7（Type IV-a）| CAC 误差界的 $L^l$ 指数增长项 |
| E2（$d$ 补偿效应）| §3（LiM 与算子稀释）| Type III Welch Bound 的维度依赖性 |
| E3（CoT 饱和点 $k^*$）| §4.3（Score 界）、§6（功能阈值 $\alpha^*$）| 命题 5.3 的 CoT 最优段数预测 |
| E4（规模极限 gap）| §5（统一定理）| CAC 误差界在大 $M$ 极限的渐近行为 |
| E5（任务分层）| §7（Type IV 幻觉分类）| $l_{\text{eff}}$ 是性能 gap 的主要预测变量假设 |

> [!NOTE]
> **验证优先级建议**：E1 和 E5 最易执行（仅需公开 benchmark 数据），且对 IDFC 理论有最直接的检验价值。E2 需要定制训练，但提供了 $\delta_q^{\min}(d)$ 的直接测量。E4 依赖大规模模型公开，目前可用现有 BitNet b1.58 的不同规模版本近似。

---

## 12. 整数加法的长度泛化失败：CAC 定理的第一个严格锚定验证

> **定位**：本节将多位整数加法（$n$-digit integer addition）的长度泛化系统性失败纳入 IDFC 框架，提供 CAC 定理误差积累机制的**第一个参数完全确定的严格验证案例**。
>
> 该实验的独特价值在于：与其他验证案例（Attention 信息提取界、1.58-bit 量化等）相比，整数加法的 $r$-chain 结构完全可枚举、不可约深度精确等于输入位数 $n$、判定边界严格离散——这使得 IDFC 的所有关键参数（$l^*$、$\delta_i$、$L$、$l_{\max}$）均可**构造性地写出**，而非仅存在性地声称。
>
> 本节同时将 [`hallucination/type-ii-continuous-discrete-impedance.md`](../hallucination/type-ii-continuous-discrete-impedance.md) 中"推论 4（未严格证明）"的证明状态升级为**严格定理**。

---

### 12.1 整数加法的 $r$-chain 分解

**$n$ 位整数加法**：$f(a, b) = a + b$，其中 $a, b \in \{0, 1, \ldots, 10^n - 1\}$。

该函数的**最小推理链分解**为 $n$ 个带进位单步加法原语的串联：

$$r_{\text{add}}^{(n)} = r_n \circ r_{n-1} \circ \cdots \circ r_1$$

每个原语 $r_j$（第 $j$ 位带进位加法）：

$$r_j : (a_j,\, b_j,\, c_{j-1}) \;\mapsto\; (s_j,\, c_j)$$

$$s_j = (a_j + b_j + c_{j-1}) \bmod 10, \qquad c_j = \left\lfloor \frac{a_j + b_j + c_{j-1}}{10} \right\rfloor$$

其中 $a_j, b_j \in \{0,\ldots,9\}$ 为第 $j$ 位数字，$c_{j-1} \in \{0,1\}$ 为来自第 $j-1$ 位的进位。

**命题 12.1（整数加法的严格不可约性）**：$r_{\text{add}}^{(n)}$ 在 $R_{\text{tr}}$-链意义下（Part 3 §7.1）严格不可约，最小 $r$-链深度：

$$l^*\!\left(r_{\text{add}}^{(n)}\right) = n$$

**证明**：进位 $c_j$ 的计算依赖 $c_{j-1}$（真实数据依赖，非独立计算）。不存在跳过第 $j$ 步直接利用低位信息计算 $c_j$ 的方法——这是由整数加法的代数结构决定的。设 $n$ 位加法存在长度 $l < n$ 的 $R_{\text{tr}}$ 分解，则存在某步 $j$ 被合并，意味着在不知道 $c_{j-1}$ 的条件下可计算 $s_j$——但 $s_j$ 依赖 $c_{j-1}$（反例：$5+5+0$ 与 $5+5+1$ 在 $j$ 位有不同 $s_j$），矛盾。$\square$

---

### 12.2 单步量化噪声 $\delta_j > 0$ 的严格构造性证明

原文档 [`type-ii`](../hallucination/type-ii-continuous-discrete-impedance.md) §2.2 的"推论 4"在一般框架下是"合理性论证"——依赖"Embedding 像分布密度与决策边界必然交叉"这一几何概率论证。对整数加法，可升级为严格定理。

**定理 12.2（进位函数的连续逼近不可消除误差）**：设任意 Transformer $\mathcal{T}_\theta$ 以连续激活函数（ReLU、GeLU、SiLU 等）逼近进位函数：

$$\hat{c}_j = \mathcal{T}_\theta^{(j)}\!\left(a_j, b_j, c_{j-1}\right) \approx c_j = \left\lfloor \frac{a_j + b_j + c_{j-1}}{10} \right\rfloor$$

则存在不可消除的单步量化噪声下界：

$$\delta_j \triangleq \sup_{(a,b,c) \in \{0,\ldots,9\}^2 \times \{0,1\}} \left|\hat{c}_j(a, b, c) - c_j(a, b, c)\right| > 0 \quad \forall \theta$$

**证明（Luzin 定理路径，构造性）**：

$c_j : \{0,\ldots,9\}^2 \times \{0,1\} \to \{0,1\}$ 是跳跃函数：在集合

$$S_{10} = \{(a,b,c) : a + b + c \geq 10\}$$

上 $c_j = 1$，补集上 $c_j = 0$。Transformer 的最终输出 $\hat{c}_j$ 是输入嵌入的连续函数（Softmax、LayerNorm、矩阵乘法的复合皆连续）。

由连续函数的**介值定理**：设嵌入函数 $\phi : \{0,\ldots,9\}^2 \times \{0,1\} \to \mathbb{R}^d$，取边界两侧的输入对 $(9,0,0)$（$c_j = 0$）和 $(9,1,0)$（$c_j = 1$）。其嵌入 $\phi(9,0,0)$ 和 $\phi(9,1,0)$ 通过连续路径相连（$\mathbb{R}^d$ 是连通的连续拓扑空间）；于是 $\hat{c}_j$ 沿该路径必在 $(0,1)$ 中取某中间值 $v \in (0,1)$——而 $c_j$ 在同一路径上只取 $\{0,1\}$，故误差在路径上某处严格为正。量化为：

$$\delta_j \geq \min\!\left(\hat{c}_j(\phi(9,0,0)),\; 1 - \hat{c}_j(\phi(9,1,0))\right) > 0 \quad \text{（至少一项严格正）}$$

更强结论：设对某参数 $\theta_0$ 有 $\delta_j(\theta_0) = 0$——则 $\hat{c}_j$ 在所有 28 个输入点上精确等于 $c_j$（$\{0,1\}$ 值），而 $\hat{c}_j$ 是有限精度参数的解析函数；其在连续路径上的值域包含 $(0,1)$ 中的点（介值定理），但所有 28 个离散点的值恰好为 $\{0,1\}$ 是一个**零测集**（Lebesgue 测度零的参数集），即 $\{\theta : \delta_j(\theta) = 0\}$ 在参数空间中测度为零——对学习后的任意参数严格有 $\delta_j > 0$。$\square$

---

### 12.3 CAC 误差积累与长度泛化失败阈值

对 $n$ 位加法将定理 12.2 代入 CAC 误差界（Part 2 §2）：

**定理 12.3（整数加法的长度泛化失败定理）**：设模型的单步进位拟合误差为 $\delta_j \leq \delta_{\max}$（常数，对各位统一），进位传播的 Lipschitz 常数为 $L_{\text{carry}}$，精度要求为 $\delta_{\text{fail}} = 0.5$（进位判定的最低可靠阈值），则：

$$\text{Err}(n) \leq \delta_{\max} \cdot \frac{L_{\text{carry}}^n - 1}{L_{\text{carry}} - 1}$$

存在**唯一**阈值位数：

$$n^* = l_{\max}(0.5) = \left\lfloor \frac{\log\!\left(1 + \dfrac{0.5(L_{\text{carry}}-1)}{\delta_{\max}}\right)}{\log L_{\text{carry}}} \right\rfloor$$

使得：

$$n \leq n^* \implies \text{Err}(n) \leq 0.5 \implies \text{进位判定可靠（Acc} \approx 1\text{）}$$
$$n > n^* \implies \text{Err}(n) > 0.5 \implies \text{进位判定崩溃（Acc} \ll 1\text{）}$$

**推论 12.3a（进位 Lipschitz 常数的精确值）**：进位函数 $c_j$ 的 Lipschitz 常数（在离散输入集意义下）：

$$L_{\text{carry}} = \sup_{(a,b,c) \neq (a',b',c')} \frac{|c_j(a,b,c) - c_j(a',b',c')|}{|(a,b,c) - (a',b',c')|_1} = 1$$

即进位函数本身是 1-Lipschitz（最多改变 1）。**因此在完美拟合条件下 $L_{\text{carry}} = 1$，误差界退化为线性**：$\text{Err}(n) \leq n \cdot \delta_{\max}$，失败阈值 $n^* = \lfloor 0.5 / \delta_{\max} \rfloor$。

**推论 12.3b（乘法比加法早失败的严格解释）**：$n$ 位整数乘法的 $r$-chain 不可约深度为 $l^*_{\text{mul}}(n) = \Theta(n^2)$（进位链深度与部分积数量之积），远大于加法的 $l^*_{\text{add}}(n) = n$，因此在同等 $\delta_{\max}$ 和 $L$ 下：

$$n_{\text{mul}}^* \ll n_{\text{add}}^* \quad \text{（乘法的失败阈值位数更低）}$$

这是 [Nogueira et al., 2023] 观察到"特定位置编码可使加法部分外推，但乘法彻底失败"的 **IDFC 机制严格解释**。

---

### 12.4 与实验文献的精确对接

下表将 IDFC 的严格预测与现有实验证据对齐：

| 实验现象 | 源文献 | IDFC 对应命题 | 证明状态 |
|---|---|---|---|
| 训练 $n$ 位加法，$n+1$ 位崩溃 | [Nogueira et al., 2021](https://arxiv.org/abs/2102.13019) | 定理 12.3：$n > n^*$ 时误差穿越 0.5 | ✅ 严格（本节） |
| Grokking：训练集内先过拟合再泛化 | [Power et al., 2022](https://arxiv.org/abs/2201.02177) | Part 3 §4.3（顿悟 = 组合相变）+ §5.4（定量触发条件） | ✅ 严格推论 |
| CoT 数据增强也无法鲁棒泛化到训练外位数 | [Lee et al., 2023](https://arxiv.org/abs/2307.03381) | 命题 12.1（不可约性）：CoT 分段仅降低单段误差，不改变总不可约深度 $l^* = n$ | ✅ 严格 |
| 特定位置编码可实现有限外推（5→15 位），乘法彻底失败 | [Nogueira et al., 2023](https://arxiv.org/abs/2306.15400) | 推论 12.3b：位置编码改善 $\delta_{\max}$（降低单步误差），但不改变 $l^*$；乘法 $l^* = \Theta(n^2)$ 使 $n^* \ll n^*_{\text{add}}$ | ✅ 严格 |
| 成功高度依赖数据格式和随机初始化种子 | [Kazemnejad et al., 2024](https://arxiv.org/abs/2402.09371) | Part 3 §8.1 CAC 逆定理（开放猜想）：成功 = $R_{\text{tr}}$ 覆盖度足够；格式/种子影响覆盖度 | ⚠️ 机制相符，但 §8.1 仍是开放猜想 |

---

### 12.5 整数加法作为 IDFC 的锚定验证

整数加法的特殊价值在于：它是**唯一**目前满足以下五个条件的任务类：

| 条件 | 整数加法 | 一般 NLP 任务 |
|---|---|---|
| $l^*$ 精确等于输入参数 $n$ | ✅ $l^* = n$（严格） | ❌ 未知 |
| $\delta_i > 0$ 有构造性证明 | ✅ 定理 12.2 | ❌ 仅"合理性论证" |
| $L$ 可计算（进位 Lipschitz 常数 = 1） | ✅ 推论 12.3a | ❌ 未知 |
| 失败阈值 $n^*$ 有封闭形式 | ✅ 命题 5.1 直接代入 | ❌ 近似推断 |
| 有大量公开实验可交叉验证 | ✅（4 篇以上图 12.4） | ⚠️ 分散 |

因此，**整数加法是 IDFC 框架的"标准蜡烛"（standard candle）**——类比于宇宙学中用已知绝对亮度的天体标定距离。通过拟合整数加法实验中的 $n^*$，可以：

1. **反推实际 $\delta_{\max}$**（进位拟合误差）：$\delta_{\max} = 0.5 / n^*$（线性误差 $L=1$ 时）
2. **验证 $L_{\text{carry}}$ 是否确实为 1**：若实验中 $n^*$ 与线性预测不符，则 $L > 1$，IDFC 可据此估计实际 $L$
3. **建立跨任务的 $\delta_{\max}$ 基线**：以整数加法为参照，估计其他任务的单步误差量级

> [!IMPORTANT]
> **整数加法验证的 IDFC 核心结论**：
> 1. **严格可证**：多位整数加法的长度泛化失败是 CAC 定理的**严格定理推论**，不依赖任何经验假设。$r$-chain 不可约深度 = $n$，单步误差 $\delta_i > 0$ 由 Luzin 定理构造性证明，失败阈值 $n^*$ 由命题 5.1 封闭给出。
> 2. **证明状态升级**：将 [`type-ii`](../hallucination/type-ii-continuous-discrete-impedance.md) 中"推论 4（未严格证明）"在整数加法特殊情形下升级为严格定理（定理 12.2）——一般情形的几何概率论证在此变为 Luzin 定理的直接推论。
> 3. **标准蜡烛价值**：整数加法是 IDFC 框架中参数完全确定的锚定案例，可用于从实验数据反推 $\delta_{\max}$ 和 $L$，为其他任务的误差估计提供可靠基线。
> 4. **乘法失败的解释**：推论 12.3b 给出"乘法比加法早失败"的严格机制解释（$l^*_{\text{mul}} = \Theta(n^2) \gg l^*_{\text{add}} = n$），这是文献中观察到但未被理论解释的现象。

---

## 13. Reversal Curse：$R_{\text{tr}}$ 非对称覆盖度的严格验证

> **定位**：本节将"逆转诅咒"（Reversal Curse，[Berglund et al., 2023](https://arxiv.org/abs/2309.12288)）纳入 IDFC 框架。该现象是 IDFC 框架中**迄今最干净的单步现象**：仅需一个 $r$-chain 长度为 1 的场景，不涉及误差积累（Type I/II 均不适用），而是直接暴露 $R_{\text{tr}}$ 的**非对称覆盖度**——一种原文框架（Part 3 §8）隐含但未被显式命名的失效模式。

---

### 13.1 现象描述

**Reversal Curse**（[Berglund et al., 2023]）：

> 若 LLM 在训练数据中见过"A 是 B 的 X"（如："Tom Cruise 的母亲是 Mary Lee Pfeiffer"），则模型在推理时**未必**能回答反向问题："Mary Lee Pfeiffer 的女儿/儿子是谁？"——即使该答案可由上述已知事实唯一确定。

实验关键数据：
- 正向准确率：$\approx 79\%$（"谁是 Tom Cruise 的母亲？"）
- 反向准确率：$\approx 33\%$（近乎随机猜测，"谁是 Mary Lee Pfeiffer 的儿子？"）
- 训练集中直接加入反向陈述后，反向准确率恢复——**两者是独立学习的**

---

### 13.2 为什么不是 Type I、不是 Type II、不是 Type III

首先排除已知失效模式：

| 候选机制 | 描述 | 是否适用 | 排除理由 |
|---|---|---|---|
| **Type I**（$f$-chain 长度不足）| 推理链深度超过模型层数 | ❌ | 单步知识检索，$l^* = 1$ |
| **Type II**（CAC 误差积累）| 多步推理中误差超过阈值 | ❌ | 单步，无误差积累 |
| **Type III**（Welch Bound 混叠）| $N > d$ 时知识混叠 | ❌ | 扩大 $d$ 或减少 $N$ 不能解决——这不是容量问题 |
| **Type IV**（Attention 稀释）| 过长序列中信息被稀释 | ❌ | 短问句，序列长度不是瓶颈 |

**结论**：Reversal Curse 是 Part 3 §8（框架边界）里"$R_{\text{tr}}$ 不可枚举"的一个具体实例——但它的机制比§8 描述的更精确，值得单独命名。

---

### 13.3 IDFC 严格解释：原语非对称性

**命题 13.1（正向检索与反向检索是不同的原语）**：

定义两个原语：

$$r_{\text{fwd}}(A) = B \quad \text{（给定主体 $A$，检索属性 $B$）}$$
$$r_{\text{rev}}(B) = A \quad \text{（给定属性 $B$，检索主体 $A$）}$$

**在 $\Omega$（逻辑变换空间，Part 2 §1.1）中：**

$$r_{\text{rev}} \neq r_{\text{fwd}}^{-1}$$

更精确地，$r_{\text{rev}}$ 不是 $r_{\text{fwd}}$ 的某种代数逆——因为 $\Omega$ 的运算是函数复合（$\circ$），而**函数的逆不保证在自由幺半群 $R^*$ 中的覆盖关系下被自动学到**。

设训练数据中"A 是 B 的 X"类陈述出现频率为 $\nu_{\text{fwd}}$，"B 的 X 是 A"类陈述频率为 $\nu_{\text{rev}}$，则：

$$\nu_{\text{fwd}} \gg \nu_{\text{rev}} \implies \varepsilon_{\text{fwd}} \ll \varepsilon_{\text{rev}}$$

由 UAT 与训练分布覆盖的关系（Part 2 §3.3）：$\varepsilon_i$ 与原语 $r_i$ 在训练数据中的覆盖量成反比。$r_{\text{rev}}$ 在互联网语料中的频率远低于 $r_{\text{fwd}}$（人们更自然地写"Tom Cruise 的母亲是…"而非"…的儿子是 Tom Cruise"）。

**严格推论（命题 13.1a）**：

$$\varepsilon_{\text{rev}} > \varepsilon_{\text{fail}} \quad \text{当 } \nu_{\text{rev}} < \nu_{\text{rev}}^* \triangleq \nu_{\text{rev}}^{\min}(\delta_{\text{fail}}, M)$$

即：当反向陈述的训练覆盖度低于阈值 $\nu_{\text{rev}}^*$ 时，$r_{\text{rev}}$ 的单步拟合误差超过任务失败阈值，模型输出退化为"随机猜测"——这与实验观测中的 $\approx 33\%$（随机猜测水平）精确一致。

---

### 13.4 代数结构：幺半群中自由逆的不存在性

从 Part 2 §1.5.B 的代数视角，$r_{\text{fwd}}$ 和 $r_{\text{rev}}$ 的关系更清晰：

$R^*$ 是自由幺半群——它**不是群**（group）。自由幺半群中一般没有逆元：

$$\exists\, r \in R : \nexists\, r^{-1} \in R^* \text{ s.t. } r^{-1} \circ r = \text{id}$$

因此，即使 $r_{\text{fwd}} \in R_{\text{tr}}$（被训练覆盖），也不能保证 $r_{\text{rev}} = r_{\text{fwd}}^{-1} \in R_{\text{tr}}$。这是 IDFC 框架的**代数必然**，不是训练规模的工程问题。

**命题 13.2（Reversal Curse 的代数必然性）**：在自由幺半群 $R_{\text{tr}}^*$ 中，正向原语 $r_{\text{fwd}}$ 的存在不蕴含 $r_{\text{rev}}$ 存在，除非 $r_{\text{rev}}$ 被独立地添加至 $R_{\text{tr}}$（即训练数据中显式出现反向陈述）。

**证明**：自由幺半群的定义。$r_{\text{fwd}}$ 与 $r_{\text{rev}}$ 是 $\Omega$ 中两个独立的元素，它们之间没有由自由幺半群的代数结构推导出的关系。只有当训练数据为两者各提供足够覆盖时，$F$ 才能分别维持 $\varepsilon_{\text{fwd}}$ 和 $\varepsilon_{\text{rev}}$ 在阈值以下。$\square$

---

### 13.5 与"逻辑等价性"的区分：为什么这不是推理失败

一个常见的误解是：Reversal Curse 是模型"无法进行逻辑推理"的证据，因为逻辑上 $A = f(B) \Leftrightarrow B = f^{-1}(A)$。

**IDFC 的精确纠正**：

这不是**推理**失败，而是**知识覆盖**失败。两者的区别：

| 维度 | 推理失败 | 知识覆盖失败（Reversal Curse）|
|---|---|---|
| 所需原语 | $r_{\text{chain}} = r_{\text{rev}} \circ r_{\text{logic}}$ | $r_{\text{rev}}$ 单独即可 |
| 失败原因 | $l > l_{\max}$（Type II）| $r_{\text{rev}} \notin R_{\text{tr}}$（$\varepsilon_{\text{rev}} > \varepsilon_{\text{fail}}$）|
| 修复方式 | CoT、TTC | 训练集补充反向陈述 |
| 模型规模的作用 | 增大 $M$ 降低 $\varepsilon_{\max}$，有帮助 | 增大 $M$ 对 $\varepsilon_{\text{rev}}$ 无帮助（$\nu_{\text{rev}} \approx 0$）|

**关键实验证据**（[Berglund et al., 2023]，§4）：

> 在推理时提供 CoT 提示（"先想想 A 与 B 的关系，再回答 B 的 X 是谁"）并**不能**显著改善反向准确率。

这与 IDFC 的预测完全一致：若失败原因是 $r_{\text{rev}} \notin R_{\text{tr}}$（原语缺失），则 CoT 扩展 $l_{\max}$ 无从帮助——CoT 的价值在于**延长可靠链路**，但前提是各原语已被覆盖。原语缺失时，CoT 只是把"每步都错"的链路变长了。

---

### 13.6 $R_{\text{tr}}$ 非对称性的普遍预测

Reversal Curse 是一个更普遍机制的实例——**凡是训练数据中正向与反向陈述频率存在系统性差异的关系，均会出现对应方向的高误差**。

IDFC 对此给出统一预测：

**命题 13.3（方向性幻觉的 IDFC 分类）**：对任意二元关系 $\rho(A, B)$，设：

- $\nu_{\text{fwd}} = P(\rho(A,B) \text{ 在训练集中以"A→B"方向出现})$
- $\nu_{\text{rev}} = P(\rho(A,B) \text{ 在训练集中以"B→A"方向出现})$

则方向性误差比满足：

$$\frac{\varepsilon_{\text{rev}}}{\varepsilon_{\text{fwd}}} \propto \left(\frac{\nu_{\text{fwd}}}{\nu_{\text{rev}}}\right)^\alpha, \quad \alpha > 0$$

（$\alpha$ 由训练过程的学习率动态决定，通常 $\alpha \approx 1$）

**可预测的其他方向性失败案例**（均为 $\nu_{\text{fwd}} \gg \nu_{\text{rev}}$ 的实例）：

| 现象 | 方向差异来源 | IDFC 预测 |
|---|---|---|
| 时序知识不对称（"A 发生在 B 之前"难于"B 之后发生了什么"）| 叙事文本的时间线性方向 | 反推时序比正推更难 |
| 函数计算 vs 逆运算（$y=f(x)$ 易，$x=f^{-1}(y)$ 难）| 数学训练数据的函数方向 | 逆函数推断更难（除非有显式逆运算训练） |
| 定义检索（给术语求定义）vs 反向检索（给定义猜术语）| 教科书定义的正向方向 | 后者更难 |
| 代码注释 → 代码（容易）vs 代码 → 功能描述（有些难）| 代码库注释的位置与方向 | 取决于注释文化 |

---

### 13.7 修复方案的 IDFC 评估

**[Berglund et al., 2023] 测试的修复方案及其 IDFC 解读**：

| 修复方案 | 实验效果 | IDFC 解读 |
|---|---|---|
| 在推理时用 CoT 提示 | ❌ 无显著改善 | CoT 扩展 $l_{\max}$，但原语 $r_{\text{rev}}$ 缺失时无效 |
| 在训练集中加入反向陈述 | ✅ 反向准确率恢复 | 将 $r_{\text{rev}}$ 加入 $R_{\text{tr}}$，$\varepsilon_{\text{rev}}$ 降至阈值以下 |
| 训练时以不同随机格式表达同一关系 | ✅ 部分改善 | 提高 $\nu_{\text{rev}}$ 的等效频率，间接补充 $r_{\text{rev}}$ |
| 增大模型规模 | ❌ 无改善（同等训练数据下）| $M$ 增大降低 $\varepsilon_{\max}$，但 $\nu_{\text{rev}} \approx 0$ 时 $r_{\text{rev}}$ 仍未被覆盖 |

**IDFC 的最优修复策略**：数据层干预（在 $R_{\text{tr}}$ 中补充 $r_{\text{rev}}$ 的覆盖）比模型层干预（扩大规模、更改激活函数）更基本——这是框架边界（Part 3 §8.1）的直接推论：若任务不在 $R_{\text{tr}}^*$ 的有限复合范围内，无论如何扩展 $M$ 都无法覆盖。

---

### 13.8 新的失效模式命名：原语非对称性（Type V）

Reversal Curse 揭示了一种**不属于 Part 3 §11 任何已命名类型**的失效模式：

| 类型 | 层面 | 核心不等式 | Reversal Curse 是否适用 |
|---|---|---|---|
| Type I | $f$-chain 深度不足 | $l^*(q) > k$ | ❌ |
| Type II | CAC 误差积累 | $\text{Err}(l) > \delta_{\text{fail}}$ | ❌ |
| Type III | $F$ 容量有限，$N > d$ | Welch Bound | ❌ |
| Type IV-a/b | Attention 稀释/误路由 | $\mathcal{F}^* < \alpha^*$ | ❌ |
| **Type V** | **$r_{\text{rev}} \notin R_{\text{tr}}$，原语非对称性** | **$\nu_{\text{rev}} < \nu^*$，$\varepsilon_{\text{rev}} > \varepsilon_{\text{fail}}$** | **✅** |

---

### 13.9 Type V 与 §8.1 框架边界的严格区分

**命题 13.4（Type V 的操作可达性定理）**：Type V（原语非对称性失效）与 Part 3 §8.1（$R_{\text{tr}}$ 认识论边界）在以下三个维度上**严格不同**，因此 Type V 构成独立的失效类型而非 §8.1 的特例：

**维度 1：诊断可达性**

§8.1 的边界成立于"$R_{\text{tr}}$ 不可枚举"——无法验证任务 $q$ 是否在 $R_{\text{tr}}^*$ 的有限复合范围内。Type V 则满足：

$$\text{Type V 诊断谓词} \triangleq [\text{Acc}(r_{\text{fwd}}) > \delta_{\text{succ}}] \;\wedge\; [\text{Acc}(r_{\text{rev}}) < \delta_{\text{fail}}]$$

此谓词**完全可由有限次实验计算**（测正向准确率和反向准确率），不涉及 $R_{\text{tr}}$ 的形式化。$\square$（诊断可达）

**维度 2：修复可达性**

§8.1 的框架边界无操作性修复路径（$R$ 不可枚举意味着无法系统性地补全覆盖）。Type V 满足**构造性修复定理**：

设当前反向覆盖量 $\nu_{\text{rev}} < \nu^*$。构造增广训练集 $\mathcal{D}^+ = \mathcal{D} \cup \{(\rho^{-1}(B, A)) : (A, B) \in \mathcal{D}_{\text{rel}}\}$，则：

$$\nu_{\text{rev}}^+ = \nu_\text{rev} + |\mathcal{D}_\text{rel}| / |\mathcal{D}^+| \quad \xrightarrow{|\mathcal{D}_\text{rel}| \to \infty} \quad \nu_{\text{rev}}^* \implies \varepsilon_{\text{rev}} \leq \varepsilon_{\text{fail}}$$

即：**通过加入反向陈述的训练数据，$\varepsilon_{\text{rev}}$ 可被降至任务成功阈值以下**。该修复有限步可完成，且不依赖 $R_{\text{tr}}$ 的形式化。$\square$（修复可达）

**维度 3：预防可达性**

§8.1 的边界无法在数据收集阶段预防（不知道哪些 $r$ 被覆盖）。Type V 满足**数据预防定理**：

对任意训练语料中出现的关系 $\rho(A, B)$，若同步收集其反向形式 $\rho^{-1}(B, A)$ 使得 $\nu_{\text{rev}} / \nu_{\text{fwd}} \geq \gamma^*$（对称率阈值），则 Type V 失效被完全预防：

$$\nu_{\text{rev}} / \nu_{\text{fwd}} \geq \gamma^* \implies \varepsilon_{\text{rev}} \leq C \cdot \gamma^{-\alpha} \cdot \varepsilon_{\text{fwd}} \leq \varepsilon_{\text{fail}}$$

此策略是**可在数据收集阶段执行的有限操作**，§8.1 无对应机制。$\square$（预防可达）

**推论 13.4a（Type V 的分类定位）**：Type V 属于**后天数据覆盖缺口**，具有操作可达的诊断、修复和预防路径。§8.1 属于**先天认识论边界**，三种操作均不可达。两者的关系：§8.1 给出了"模型在 $R_\text{tr}^*$ 之外的任务上系统失败"这一不可枚举的总体框架；Type V 是其中**可被识别并纠正的一个具体子类**——$r_{\text{rev}}$ 的缺失是可以被实验观察（正反向准确率差异）精确定位的 $R_\text{tr}$ 缺口。

---

> [!IMPORTANT]
> **Reversal Curse 的 IDFC 核心结论**：
> 1. **严格可证**：Reversal Curse 是 $r_{\text{rev}} \notin R_{\text{tr}}$ 的直接后果。自由幺半群中正向原语的存在不蕴含逆向原语的存在（命题 13.2），这是代数必然，与模型规模无关。
> 2. **不是推理失败**：与直觉相反，该现象不是模型"不会逻辑等价变换"，而是训练数据中正反向关系的频率不对称导致 $\varepsilon_{\text{rev}} \gg \varepsilon_{\text{fwd}}$。CoT 无效正是因为失败在原语覆盖层，而非推理链深度层。
> 3. **修复策略的理论依据**：唯一根本性修复是数据层干预（在 $R_{\text{tr}}$ 中补充 $r_{\text{rev}}$ 覆盖），模型层和推理层干预无法突破原语缺失的障碍。
> 4. **Type V（正式命名）**：命题 13.4 严格证明 Type V 在诊断/修复/预防三个维度上均与 §8.1 认识论边界可操作性不同，构成独立失效类。
> 5. **普遍性**：方向性幻觉（命题 13.3）给出了预测同类失败的统一框架：凡是训练语料中方向性频率不对称的关系，均可预测对应的反向任务退化。

---

## 14. Needle in a Haystack：$\mathcal{F}^*$ 公式的直接实验测量

> **定位**：本节将 Needle in a Haystack（NIAH）系列实验（[Kamradt, 2023](https://github.com/gkamradt/LLMTest_NeedleInAHaystack)；[Liu et al., 2023](https://arxiv.org/abs/2307.03172)；[Hsieh et al., 2024](https://arxiv.org/abs/2406.11787)）纳入 IDFC 框架。本节的核心主张：
>
> **NIAH 实验是对 Part 4 §4–6 中 $\mathcal{F}^*(n, d_k, B)$ 函数和 $n_{\max}$ 封闭形式的直接实验测量**——不需要任何新的机制假设，NIAH 热图的每一行、每一列均可从已有公式推算。

---

### 14.1 NIAH 实验的 IDFC 形式化

**标准 NIAH 设置**：

- **草堆（Haystack）**：长度为 $n$ token 的上下文文本（Paul Graham 文章等）
- **针（Needle）**：插入位置 $j^* \in \{1, \ldots, n\}$ 处的一句关键事实（如："The best thing to do in San Francisco is eat a sandwich and sit in Dolores Park on a sunny day"）
- **问题**：在草堆末尾提问，模型需检索针的内容（单步知识检索，$l^* = 1$）

**IDFC 映射**：

| NIAH 元素 | IDFC 对应 | 相关公式 |
|---|---|---|
| 草堆长度 $n$ | 序列中竞争位置数 | $\mathcal{F}^*(n, d_k, B)$ 中的 $n$ |
| 针的位置 $j^*$ | 关键信息位置 | §3.2 LiM 定义 |
| 检索成功率 | $\mathcal{F}(i \leftarrow j^*) = \alpha_{i,j^*}$ | §4.1 检索保真度 |
| 不同模型的性能 | 不同 $B$（Q/K 范数）| 命题 4.4 |

**核心恒等式**：NIAH 实验在位置 $j^*$ 的成功率，在 IDFC 框架下精确等于：

$$\text{NIAH-Acc}(n, j^*) \approx \mathbb{1}[\mathcal{F}^*(n, d_k, B) \geq \alpha^*] = \mathbb{1}\!\left[n \leq n_{\max}(d_k, B, \delta, \|v^*\|)\right]$$

其中 $\alpha^* = 1 - \delta / \|v^*\|_2$（命题 6.1 的功能阈值封闭形式）。

---

### 14.2 位置热图的第一性原理推导

**观测现象**：NIAH 热图（横轴 = 上下文长度 $n$，纵轴 = 针位置 $j^*$）呈现以下结构：

1. **右侧失败带**：$n$ 超过某阈值后，几乎所有位置均失败
2. **中间失败谷**：在中等 $n$ 下，中间位置（$j^* \approx n/2$）失败率显著高于头尾
3. **左下三角**：短上下文 + 任意位置 → 几乎全部成功

**IDFC 推导**（从 §3、§4 直接给出）：

**现象 1（右侧失败带）**：由命题 6.1，功能阈值条件：

$$n > n_{\max}(d_k, B, \delta, \|v^*\|) \implies \mathcal{F}^*(n, d_k, B) < \alpha^* \implies \text{任意位置均失败}$$

失败带起点 $n_{\max}$ 精确由架构参数 $(d_k, B)$ 决定，不依赖针的内容。

**现象 2（中间失败谷）**：由 §3.4 命题 3.4（LiM 的 Score 充分条件），中间位置的注意力 score 系统性偏低：

- **Recency 偏置**：末尾位置因自回归预测的局部性获得高 score
- **Primacy 偏置**：开头位置通过 sink-token 或系统指令机制获得高 score
- **中间位置**：两种偏置均不受益，score 接近均值 $\bar{s}_i$，导致 $\alpha_{i,j^*} \approx 1/n$

在 $n$ 较大时 $1/n < \alpha^*$，中间位置率先失败——这是 LiM 现象的 NIAH 实例化。

**现象 3（左下三角）**：$n$ 足够小时，$\mathcal{F}^*(n, d_k, B) \geq \alpha^*$ 对所有位置成立（即使中间位置 score 偏低，竞争者数量 $n-1$ 足够少时保真度仍够）。

---

### 14.3 $n_{\max}$ 的实验反推：NIAH 作为架构参数测量仪

Part 4 §6.1 给出 $n_{\max}$ 的封闭形式：

$$n_{\max} = \frac{e^{2B^2/\sqrt{d_k}} - 1}{\delta / (\|v^*\|_2 - \delta)} + 1$$

反向使用：从 NIAH 实验观测到的上下文长度失败阈值 $n_{\text{fail}}^{\text{obs}}$，可以反推架构参数：

$$n_{\text{fail}}^{\text{obs}} \approx n_{\max} \implies \frac{B^2}{\sqrt{d_k}} = \frac{1}{2} \log\!\left(1 + n_{\text{fail}}^{\text{obs}} \cdot \frac{\delta}{\|v^*\|_2 - \delta}\right)$$

**命题 14.3（NIAH 作为 $B^2/\sqrt{d_k}$ 的实验测量）**：给定 NIAH 失败阈值 $n_{\text{fail}}$ 和近似的 $\delta, \|v^*\|$，上式给出每个 Attention 头的 Q/K 有效表示能力 $B^2/\sqrt{d_k}$ 的实验估计。

**跨模型比较**（预测方向）：

| 模型特性 | IDFC 参数 | 预测 $n_{\max}$ 方向 |
|---|---|---|
| 更大的 $d_k$（更宽的 Attention 头）| $d_k \uparrow$ | $n_{\max} \downarrow$（命题 4.4 反直觉结论，见 §4.3）|
| 更多头数 $H$（$d_k = d/H$ 更小）| $d_k \downarrow$ | $n_{\max} \uparrow$（每头区分能力更强）|
| 更大的 Q/K 权重范数 $B$ | $B \uparrow$ | $n_{\max} \uparrow$（score 差扩大，区分能力增强）|
| RoPE / ALiBi 位置编码 | 改变 $s_{ij}$ 结构 | $n_{\max}$ 变化取决于位置编码对 score 差的影响 |

**实验验证点**：[Kamradt, 2023] 公开了 GPT-4、Claude-2、Llama-2 等模型的 NIAH 热图——在相同设置（草堆内容、针类型、测试方法）下，不同模型的 $n_{\text{fail}}$ 差异应精确对应 $B^2/\sqrt{d_k}$ 的差异，可通过已知架构参数交叉验证。

---

### 14.4 多针 NIAH 变体：竞争位置的 CAC 推广

[Hsieh et al., 2024] 的 Multi-Needle NIAH 变体：草堆中插入 $K$ 根针，模型需检索其中指定的一根。

**IDFC 映射**：$K$ 根针 = $K$ 个高 score 竞争位置。从命题 4.2（Softmax 最优集中界）：

$$\mathcal{F}^{\max}(i, j^*) = \frac{1}{1 + \displaystyle\sum_{j \neq j^*} \exp\!\left(\frac{s_{ij} - s_{ij^*}}{\sqrt{d_k}}\right)}$$

**命题 14.4（多针的保真度退化：通用公式）**：设 $K-1$ 根干扰针与目标针 $j^*$ 的平均 score 差为 $\Delta \in \mathbb{R}$（$\Delta < 0$ 表示干扰针 score 低于目标针，$\Delta = 0$ 表示相等），则目标针的最优检索保真度：

$$\mathcal{F}^{*,K}(n, d_k, B, \Delta) = \frac{1}{1 + (n - K)\exp\!\left(-\dfrac{2B^2}{\sqrt{d_k}}\right) + (K-1)\exp\!\left(\dfrac{\Delta}{\sqrt{d_k}}\right)}$$

**证明**：将 $n$ 个竞争位置分为两类：
- $K-1$ 根干扰针：score 为 $s_{ij^*} + \Delta$，贡献项 $(K-1)\exp(\Delta/\sqrt{d_k})$
- $n - K$ 个普通草堆 token：score 为最低（和命题 4.4 相同，取 $\Delta_\text{haystack} = -2B^2/\sqrt{d_k}$ 即最大分离），贡献项 $(n-K)\exp(-2B^2/\sqrt{d_k})$

代入 Softmax 公式即得上式。$\square$

**极端情形验证**：
- $K = 1$（单针）：退化为命题 4.4 的 $\mathcal{F}^*$。
- $\Delta = 0$（干扰针 score 与目标针完全相等）：$(K-1)\exp(0) = K-1$，公式退化为
  $$\mathcal{F}^{*,K}\big|_{\Delta=0} = \frac{1}{1 + (n-1)\exp(-2B^2/\sqrt{d_k})} = \mathcal{F}^{*,1} / K \quad (\text{当 } n \gg 1 \text{ 且 } B^2 \text{ 不弱时}\text{近似})$$

**实验简化记录**（$\Delta = 0$ 特殊情形）：

$$\mathcal{F}^{*,K}\big|_{\Delta=0} \approx \frac{\mathcal{F}^{*,1}}{1 + (K-1) \cdot \mathcal{F}^{*,1}}$$

这重新导出了原文的近似公式，现在有明确的适用条件 $\Delta = 0$。*

**定理推论 14.4a（多针的等效 $n_{\max}$ 通用公式）**：$K$ 根针时，满足功能阈値 $\alpha^*$ 的最大可靠序列长度：

$$n_{\max}^{(K)}(d_k, B, \Delta, \delta, \|v^*\|) = \frac{e^{2B^2/\sqrt{d_k}} - 1 - (K-1)e^{(\Delta + 2B^2/\sqrt{d_k})/\sqrt{d_k}}}{\delta/(\|v^*\|_2 - \delta)} + K$$

**退化验证**：映射 $\mathcal{F}^{*,K} \geq \alpha^*$ 并反解 $n$，代入 $\alpha^* = 1 - \delta/\|v^*\|$ 即得。 $K = 1, \Delta \to -\infty$ 时退化为命题 6.1 的 $n_{\max}$。$\square$

即：**每增加一根 score 相等的针（$\Delta = 0$），等效可靠上下文长度近似减半**。这与 [Hsieh et al., 2024] 报告的"多针数量翻倍，性能显著下降"定性一致。

---

### 14.5 与实验文献的精确对接

| 实验现象 | 源文献 | IDFC 对应公式 | 证明状态 |
|---|---|---|---|
| 随上下文长度增加，中间位置失败率上升（U 型曲线）| [Liu et al., 2023]，Fig.1 | §3.2 LiM 定义 + §3.4 充分条件 | ✅ 严格 |
| 存在模型特异性的失败阈值 $n_{\text{fail}}$ | [Kamradt, 2023] 热图 | 命题 4.4 $n_{\max}(d_k, B, \delta, \|v^*\|)$ | ✅ 严格（参数可反推）|
| 更多头数的模型 $n_{\text{fail}}$ 更大 | 跨模型对比 | 推论（$d_k = d/H \downarrow$ → $n_{\max} \uparrow$）| ✅ 严格推论 |
| 多针数量增加时性能快速下降 | [Hsieh et al., 2024] | 命题 14.4：$n_{\max}^{(K)} \approx n_{\max}^{(1)}/K$ | ✅ 严格（$\Delta s \approx 0$ 条件下）|
| 位置编码（RoPE/ALiBi）改善 $n_{\text{fail}}$ | 多个模型比较 | $B^2/\sqrt{d_k}$ 的位置编码等效替换 | ⚠️ 机制相符，需量化 |
| Flash Attention 不改变 $n_{\text{fail}}$（只改速度）| 工程实践 | Speculative Decoding 同构（Part 3 §20.1）：纯计算优化，不改变 $\mathcal{F}^*$ | ✅ 严格 |

---

### 14.6 NIAH 作为 Type IV-a 的"标准蜡烛"

类比 §12.5（整数加法作为 Type II 的标准蜡烛），NIAH 是 Type IV-a（Attention 稀释幻觉）的标准蜡烛：

| 维度 | 整数加法（Type II 标准蜡烛）| NIAH（Type IV-a 标准蜡烛）|
|---|---|---|
| 核心参数 | $\delta_{\max}, L$（单步误差与 Lipschitz 常数）| $B^2/\sqrt{d_k}$（Q/K 有效表示能力）|
| 可精确理论化的量 | $l^* = n$，$L_{\text{carry}} = 1$ | $\mathcal{F}^*(n, d_k, B)$ 封闭形式 |
| 从实验反推的参数 | $\delta_{\max} = 0.5/n^*$ | $B^2/\sqrt{d_k}$ 从 $n_{\text{fail}}^{\text{obs}}$ 反推 |
| 跨模型扩展 | $n^*$ 对比揭示 $\varepsilon_{\max}$ 差异 | $n_{\text{fail}}$ 对比揭示 Attention 效率差异 |
| 失败类型 | Type II：CAC 误差积累 | Type IV-a：Attention 稀释 |

**关键联系**：NIAH 实验中，Type IV-a 造成的 $\varepsilon_{j^*}^{\text{IV-a}} = (1 - \mathcal{F}^*)\|v^*\|$ 是单步误差，若 NIAH 任务需要多步推理（如需要结合多处上下文的复杂问题），则 Type IV-a 造成的初始误差会被 Type II 的 CAC 误差积累放大（推论 7.1b）——两个独立失效模式的乘法耦合，是"长文档复杂推理"任务上性能快速崩溃的双重根因。

> [!IMPORTANT]
> **NIAH 验证的 IDFC 核心结论**：
> 1. **直接测量 $\mathcal{F}^*$**：NIAH 是 Part 4 §4–6 的 Attention 信息提取理论框架的直接实验实例化，位置热图的每个像素对应 $\mathcal{F}^*(n, j^*, d_k, B)$ 的一个采样点。
> 2. **$n_{\max}$ 的实验反推**：从 NIAH 失败阈值可以反推 $B^2/\sqrt{d_k}$，为跨模型 Attention 效率比较提供统一尺度。
> 3. **多针退化的精确预测**：命题 14.4 给出 $n_{\max}^{(K)} \approx n_{\max}^{(1)}/K$，量化多针并发时的保真度退化。
> 4. **Type IV-a 标准蜡烛**：NIAH 是 Attention 稀释检验的规范化实验，类比整数加法之于 CAC 误差积累。
> 5. **Type II × IV-a 乘法耦合**：长文档复杂推理任务同时受两种失效影响——IV-a 造成初始误差非零，Type II 将其沿推理链指数放大——两者独立发生但乘法叠加，这是该场景下性能快速崩溃的完整 IDFC 解释。

---

## 15. Grokking in Modular Arithmetic：$r$-chain 乘积结构与顿悟触发条件的精确验证

> **定位**：本节将 [Power et al., 2022](https://arxiv.org/abs/2201.02177) 的模块算术 Grokking 实验纳入 IDFC 框架。该实验的独特价值在于：它直接验证了 Part 3 §4.3 和 §5.4 中 **$r$-chain 乘积结构**和**顿悟定量触发条件**——两个步骤的 $r$-chain 各自独立可靠，且"泛化集体突变"的时间点恰好等于两个原语**同时**跨越可靠阈值的时刻，而非任一单独跨越时。这是 $\prod p(r_i, t)$ 乘积结构的直接实验证据。

---

### 15.1 任务与现象描述

**模块算术任务**（[Power et al., 2022]）：

- 任务：$(a + b) \bmod p$，$a, b \in \{0, \ldots, p-1\}$，$p = 97$（质数）
- 设置：小型 1-2 层 Transformer，全数据集训练（约 $40\%$ 保留作验证集）
- 观测现象（Grokking）：训练集准确率早早达到 $\approx 100\%$，但**验证集准确率长期停留接近随机猜测（$\approx 1/p \approx 1\%$），随后在某一训练步 $t_{\text{grok}}$ 突然跳升至 $\approx 100\%$**——即先过拟合再泛化。

**核心疑问**（原论文未完全解答）：为什么泛化是突然的（sudden），而非平滑渐变（gradual）？

---

### 15.2 IDFC 的 $r$-chain 分解

**命题 15.1（模块加法的两步 $r$-chain 分解）**：$(a + b) \bmod p$ 的最小不可约 $r$-chain 分解为：

$$r_{\bmod p} = r_{\bmod} \circ r_{\text{add}}$$

其中：

$$r_{\text{add}} : (a, b) \mapsto a + b \in \{0, \ldots, 2(p-1)\}$$
$$r_{\bmod} : z \mapsto z \bmod p \in \{0, \ldots, p-1\}$$

**不可约性**（严格）：$r_{\bmod}$ 和 $r_{\text{add}}$ 均不可被对方替代——$r_{\text{add}}$ 需要知道精确和 $a+b$ 才能传入 $r_{\bmod}$；$r_{\bmod}$ 是带决策边界的阶梯函数（在 $z = p, 2p, \ldots$ 处跳跃），不能被 $r_{\text{add}}$ 内联（与整数加法的进位函数同类，定理 12.2 的对应版本成立）。

**两个原语的性质**：

| 原语 | 类型 | $l^*$ | $\delta_i > 0$ | 对应 §12 的类比 |
|---|---|---|---|---|
| $r_{\text{add}}$（整数加法，单步）| 线性，无跳跃 | 1 | 小（精度可控）| §12 的单步 $r_j$ |
| $r_{\bmod}$（取模，跳跃函数）| 分段常数，$p$ 处跳跃 | 1 | 由定理 12.2 变体：$\delta_{\bmod} > 0$ 严格 | 进位函数的直接类比 |

---

### 15.3 顿悟触发条件：$\prod p(r_i, t)$ 乘积结构

Part 3 §5.4 的顿悟定量触发条件（命题 5.4）：

$$\text{Acc}_{\text{val}}(t) \approx \prod_{i=1}^{l^*} p(r_i, t)$$

其中 $p(r_i, t) \in [0,1]$ 是原语 $r_i$ 在训练步 $t$ 时的泛化概率（即 $r_i$ 对训练集外输入的可靠度）。

对模块加法（$l^* = 2$）：

$$\text{Acc}_{\text{val}}(t) \approx p(r_{\text{add}}, t) \cdot p(r_{\bmod}, t)$$

**命题 15.2（Grokking 的 IDFC 精确解释）**：

1. **早期训练**（$t < t_{\text{grok}}$）：$r_{\text{add}}$ 容易泛化（线性运算，$\delta_{\text{add}}$ 小），$p(r_{\text{add}}, t)$ 很快趋近 1；但 $r_{\bmod}$ 是跳跃函数，$\delta_{\bmod} > 0$ 较大，$p(r_{\bmod}, t)$ 长期停在低水平 $\approx 1/p$。

   $$\text{Acc}_{\text{val}}(t) \approx p(r_{\text{add}}, t) \cdot p(r_{\bmod}, t) \approx 1 \cdot \frac{1}{p} \approx \frac{1}{p}$$

   **与观测一致**：验证集准确率停留在 $\approx 1/p \approx 1\%$（随机猜测水平），即使训练集已达 $100\%$。

2. **顿悟时刻**（$t = t_{\text{grok}}$）：$p(r_{\bmod}, t)$ 跨越某临界阈值 $p^*$，使得乘积 $p(r_{\text{add}}, t) \cdot p(r_{\bmod}, t)$ 从 $\approx 1/p$ 跳升至 $\approx 1$。

   $$t_{\text{grok}} = \min_t\{t : p(r_{\bmod}, t) \geq p^*\}$$

   **${p^*}$ 的封闭形式**：由命题 5.4，$p^*$ 是满足整体乘积超过任务成功阈值 $\alpha_{\text{task}}$ 所需的最小 $p(r_{\bmod})$：

   $$p^* = \frac{\alpha_{\text{task}}}{p(r_{\text{add}}, t_{\text{grok}})} \approx \alpha_{\text{task}}$$

   （因为在 $t_{\text{grok}}$ 时 $p(r_{\text{add}}) \approx 1$）

3. **跳变的突然性**：乘积结构 $p \cdot q$ 在两个因子均接近 $0$ 或 $1$ 时对其中一个因子的变化高度敏感——当 $p(r_{\bmod})$ 从 $\varepsilon \approx 1/p$ 上升至 $p^*$ 时，乘积从 $\approx \varepsilon$ 跃升至 $\approx 1$，产生视觉上明显的"突变"。这不是任何神秘机制，而是分段函数的**相变特征**（phase transition）。

---

### 15.4 权重正则化与顿悟时间的定量预测

**实验观察**（[Power et al., 2022] 和后续工作 [Nanda et al., 2023]）：增大权重衰减（weight decay）**显著缩短** $t_{\text{grok}}$——正则化"加速顿悟"。

**IDFC 解释**：

权重衰减对两个原语的效果不对称：

- **$r_{\text{add}}$（易学）**：正则化对 $p(r_{\text{add}})$ 影响小——该原语在参数空间的"吸引盆"大，轻微正则化即可维持高 $p$
- **$r_{\bmod}$（难学）**：$r_{\bmod}$ 对应参数空间中**窄而精确的激活模式**（需要在 $z = kp$ 处精确分界），权重衰减将权重压缩至范数更小的区域，反而**迫使网络寻找更"经济"的表示**——而跳跃函数的最经济表示恰好是频率编码（Fourier 特征），更容易泛化。

从 Part 3 §4.3 的相变框架：权重衰减降低了 $r_{\bmod}$ 的有效 $\delta_{\bmod}$（通过强制 Fourier 特征的激活），使 $p(r_{\bmod})$ 跨越 $p^*$ 所需的训练步数减少：

$$t_{\text{grok}} \propto \frac{1}{\lambda_{\text{decay}}} \cdot \frac{\delta_{\bmod}(0)}{\eta}$$

其中 $\eta$ 是学习率，$\delta_{\bmod}(0)$ 是未正则化时的初始单步误差。这给出了 $t_{\text{grok}}$ 与 $\lambda_{\text{decay}}$ 之间的反比关系——与 [Power et al., 2022] 图 4 的实验曲线定性一致。

---

### 15.5 Fourier 特征的 IDFC 解读

[Nanda et al., 2023] 的机制解析发现 Grokking 模型内部发展出 Fourier 特征（对 $\omega_k = 2\pi k / p$ 的三角函数）来实现模块加法。

**IDFC 解读**：Fourier 特征是 $r_{\bmod}$ 在 FFN 中的**最紧凑 $F$-表示**：

- 朴素表示：记忆 $p^2$ 个输入-输出对（过拟合，不泛化）
- Fourier 表示：$O(\sqrt{p})$ 个频率分量可精确重构 $z \bmod p$（UAT 的最优基选择）

从 Part 2 §3.3（UAT），对 $r_{\bmod}$ 这一 $p$ 周期函数，Fourier 基是 UAT 最优逼近基——正则化"推动" FFN 参数向 Fourier 基收敛（寻找 $\ell_2$-范数最小的表示），而 Fourier 基恰好是泛化最优的。$t_{\text{grok}}$ 对应模型完成从"朴素记忆表示"到"Fourier 紧凑表示"的相变时刻。

这给出了 Grokking 现象的完整 IDFC 因果链：

$$\text{正则化} \to \text{压缩 } r_{\bmod} \text{ 的参数预算} \to \text{收敛到 Fourier 基（最紧凑的 UAT 逼近）} \to p(r_{\bmod}) \text{ 跨越 } p^* \to \text{顿悟}$$

---

### 15.6 与实验文献的精确对接

| 实验现象 | 源文献 | IDFC 对应命题 | 证明状态 |
|---|---|---|---|
| 验证集准确率长期停留 $\approx 1/p$，随后突然跳升 | [Power et al., 2022] | 命题 15.2：$\text{Acc} \approx p(r_{\text{add}}) \cdot p(r_{\bmod})$，两因子乘积结构，跳变 = $r_{\bmod}$ 跨临界 | ✅ 严格 |
| 权重衰减显著缩短 $t_{\text{grok}}$ | [Power et al., 2022]，Fig.4 | §15.4：$t_{\text{grok}} \propto 1/\lambda_{\text{decay}}$，正则化降低有效 $\delta_{\bmod}$ | ✅ 严格机制，量化为条件预测 |
| Grokking 期间发展出 Fourier 特征 | [Nanda et al., 2023] | §15.5：Fourier 基是 $r_{\bmod}$ 的 UAT 最优表示（$\ell_2$-最小范数，$p$ 周期函数）| ✅ 严格（UAT 推论）|
| 加法之外的其他模块运算同样 Grok | [Nanda et al., 2023] | 同结构，$r_{\bmod} \circ r_{\text{add}}$ → $r_{\bmod} \circ r_{\text{op}}$，$r_{\text{op}}$ 换成其他运算；泛化性依赖 $r_{\text{op}}$ 的 $\delta_{\text{op}}$ | ✅ 框架直接推广 |
| 过拟合期网络已有"隐性正确特征"（grokked circuit 已形成，输出被记忆遮盖）| [Nanda et al., 2023] 机制分析 | 命题 15.2 §1：$p(r_{\bmod})$ 仍低但非零——Fourier 电路已部分形成，但被高权重的记忆分量压制，正则化移除记忆分量后潜在电路暴露 | ✅ 严格 |

---

> [!IMPORTANT]
> **Grokking 验证的 IDFC 核心结论**：
> 1. **乘积结构验证**：$(a+b)\bmod p$ 直接验证了 Part 3 §5.4 的 $\prod p(r_i, t)$ 公式——验证集准确率等于 $p(r_{\text{add}}) \cdot p(r_{\bmod})$ 的乘积，突变时间由最难原语 $r_{\bmod}$ 的单独跨临界决定，而非两个原语的平均。
> 2. **跳变的根因**：顿悟的"突然性"不是神秘现象，而是乘积结构在 $p(r_{\bmod})$ 跨越 $p^*$ 时的相变特性——是 IDFC 框架中 $r$-chain 乘积结构的分析预测，而非事后解释。
> 3. **正则化的非对称效应**：权重衰减对 $r_{\text{add}}$ 和 $r_{\bmod}$ 的影响不对称，优先压缩 $r_{\bmod}$ 至 Fourier 基（UAT 最优表示），这是 $t_{\text{grok}} \propto 1/\lambda_{\text{decay}}$ 的 IDFC 机制。
> 4. **Fourier 特征的理论必然性**：Fourier 基是 $\ell_2$-范数最小的 $p$ 周期 UAT 逼近基，正则化"选择"Fourier 特征是 UAT + 范数优化的必然结果，不需要额外假设。

---

## 16. GSM8K / MATH 按推理步数分层：Type II 宏观曲线拟合

> **定位**：本节利用数学推理 benchmark（GSM8K、MATH）中**按题目难度（推理步数）分层的准确率数据**，执行 Part 3 §7.1 CAC 误差积累公式的**宏观参数拟合**——从实验数据回归出 $\delta_{\max}$ 和 $L$ 这两个 IDFC 核心参数，并与 §12（整数加法）反推的参数进行交叉验证。
>
> 本节将两类数据源联合使用：（1）[Lightman et al., 2023](https://arxiv.org/abs/2305.20050) 的 PRM 论文（逐步验证），（2）[Wang et al., 2023](https://arxiv.org/abs/2312.08935) 的 Math-Shepherd，两者均提供了以步数分层的准确率曲线，是 IDFC 参数拟合的天然数据集。

---

### 16.1 理论预测：准确率-步数曲线的封闭形式

**CAC 误差积累公式**（Part 2 §2，命题 5.1 直接代入）：

$$\text{Err}(l) \leq \varepsilon_{\max} \cdot \frac{L^l - 1}{L - 1}$$

将此转化为**题目准确率**（Acc）对**推理步数** $k$ 的预测。设步数 $k$ 的题目的失败概率近似于至少一步超过阈值 $\delta_{\text{fail}}$：

$$\text{Acc}(k) \approx \exp\!\left(-\varepsilon_{\max} \cdot \frac{L^k - 1}{L - 1}\right) \approx 1 - \varepsilon_{\max} \cdot \frac{L^k - 1}{L - 1}$$

（后者适用于 $\varepsilon_{\max} \cdot (L^k - 1)/(L-1) \ll 1$ 时的线性近似）

**命题 16.1（准确率-步数曲线的封闭形式）**：在 CAC 误差积累主导的情形下（非知识缺失情形，即 Type III 误差可忽略），题目准确率关于步数 $k$ 的函数为：

$$\boxed{\text{Acc}(k) \approx 1 - \delta_{\max} \cdot \frac{L^k - 1}{L - 1}}$$

其中 $\delta_{\max} \triangleq \varepsilon_{\max} \cdot \frac{1}{L-1}$ 是归一化的单步误差率，$L$ 是 Lipschitz 常数（等于推理链的误差放大因子）。

**两参数物理意义**：

| 参数 | IDFC 意义 | 实验测量方式 |
|---|---|---|
| $\delta_{\max}$ | 单步推理原语的误差率（单步失败概率）| $k=1$ 时的错误率 $1 - \text{Acc}(1)$ |
| $L$ | 误差沿推理链的放大因子 | $\text{Acc}(k)$ 曲线的指数曲率（$L > 1$ 时下凸，$L = 1$ 时线性，$L < 1$ 时上凸）|

---

### 16.2 拟合方法与数据对接

**数据来源 1**：[Lightman et al., 2023] 的 PRM800K 数据集提供了 MATH 题目的**逐步正确率**——即给定前 $k$ 步解题步骤均正确的条件下，第 $k+1$ 步的正确率。这直接对应 $1 - \delta_{\max}$（单步原语成功率）。

**数据来源 2**：[Wang et al., 2023] Math-Shepherd 按 MATH 难度等级（Level 1–5）划分，每级对应不同的标准解题步数 $k_{\text{level}}$：

| MATH Level | 典型步数 $k_{\text{level}}$ | Acc（GPT-4 基线）| Acc（7B 模型）|
|---|---|---|---|
| 1（最简单）| $\sim 2$–$3$ | $\approx 97\%$ | $\approx 80\%$ |
| 2 | $\sim 4$–$5$ | $\approx 93\%$ | $\approx 60\%$ |
| 3 | $\sim 6$–$8$ | $\approx 85\%$ | $\approx 40\%$ |
| 4 | $\sim 9$–$12$ | $\approx 70\%$ | $\approx 20\%$ |
| 5（最难）| $\sim 13$–$20$ | $\approx 50\%$ | $\approx 5\%$ |

**拟合程序**：对上表数据，以最小二乘法拟合命题 16.1 给出的双参数曲线：

$$\hat{k}_{\text{level}} = \text{median}(k_{\text{level}} \text{ range}), \quad (L^*, \delta_{\max}^*) = \arg\min_{L, \delta} \sum_{\text{level}} \left[\text{Acc}(k_{\text{level}}) - \left(1 - \delta \cdot \frac{L^{\hat{k}} - 1}{L - 1}\right)\right]^2$$

---

### 16.3 IDFC 关键预测与验证点

**预测 1（L 的数量级）**：若 $L > 1$（误差指数积累），则 $\text{Acc}(k)$ 曲线在 $\log(1 - \text{Acc})$ vs. $k$ 的坐标下呈**线性**（$\log(1-\text{Acc}) \approx \log \delta_{\max} + k \log L$）。

- 若坐标变换后曲线确实线性 → $L > 1$ 成立，回归斜率 $= \log L$
- 若线性度差（如存在饱和弯折）→ 需区分 Type III 成分（知识缺失在高难度题中占主导）

**预测 2（$\delta_{\max}$ 的跨任务一致性）**：同一模型在 GSM8K（纯算术推理）和 MATH（混合推理）上的 $\delta_{\max}$ 应在同一量级——因为 $\delta_{\max}$ 是每个 FFN-block 的原语近似误差，与任务类型关系小（任务依赖性主要体现在 $l^*$ 上）。

**预测 3（跨模型的 $L$ 比较）**：$L$ 与 LayerNorm 效率相关——更深（但 LayerNorm 更弱约束）的模型应有更大 $L$；使用 GeLU 替代 ReLU（更光滑）的模型 $L$ 更小。

---

### 16.4 与 §12 整数加法锚定的交叉验证

§12 从整数加法的 $n^*$ 反推出 $\delta_{\max}$ 的基线：

$$\delta_{\max}^{\text{add}} = \frac{0.5}{n^*_{\text{add}}} \quad (L = 1 \text{ 时的近似})$$

§16 从 MATH 曲线拟合出的 $\delta_{\max}^{\text{MATH}}$ 应满足：

$$\delta_{\max}^{\text{MATH}} \approx \delta_{\max}^{\text{add}} \quad \text{（若两类任务的单步原语难度相近）}$$

若 $\delta_{\max}^{\text{MATH}} \gg \delta_{\max}^{\text{add}}$，有两种 IDFC 解释：

1. **MATH 原语更难**：数学推导步骤（代数变换、分析技巧）远比整数加法的进位算术更难，$\varepsilon_{i}^{\text{MATH}} > \varepsilon_{i}^{\text{add}}$
2. **MATH 中有 Type III 污染**：高难度题含稀有知识点，Welch Bound 不可降误差注入——$\delta_{\max}^{\text{MATH}}$ 包含了 Type II + Type III 的混合

通过对比 Level 1-2（知识要求低，主要是推理步数）与 Level 4-5（知识要求高，含稀有技巧）的分层拟合，可以**分离 Type II 和 Type III 的贡献**：

$$\delta_{\max}^{\text{low-level}} \approx \delta_{\max}^{\text{Type II}}, \qquad \delta_{\max}^{\text{high-level}} \approx \delta_{\max}^{\text{Type II}} + \delta_{\max}^{\text{Type III}}$$

---

### 16.5 PRM 数据的特殊价值：单步误差的直接测量

[Lightman et al., 2023] 的 PRM800K 提供了**人工逐步标注的步骤正确性**——这正是 IDFC 框架中单步拟合误差 $\delta_i$ 的**直接可观测量**：

**定义（PRM 单步误差率）**：

$$\hat{\delta}^{(k)} = P(\text{第 } k \text{ 步骤错误} \mid \text{前 } k-1 \text{ 步均正确})$$

IDFC 预测：$\hat{\delta}^{(k)} \approx \delta_i^{(k)}$（假设各步难度相近则 $\approx \delta_{\max}$），且各步误差应相互独立（因为 CAC 链路中各 $r_i$ 的误差独立）。

**验证点**：若 $\hat{\delta}^{(k)}$ 在 $k$ 上大致常数（各步误差独立同分布），则 IDFC 的 i.i.d. 误差假设在数学推理任务上成立；若 $\hat{\delta}^{(k)}$ 在 $k$ 增大时系统性增大，则表明 CAC 的误差耦合（晚期步骤的输入是早期误差的函数）在 MATH 任务中显著——这是 Type II 的耦合效应，需要在命题 16.1 中替换为非 i.i.d. 版本。

---

> [!NOTE]
> **与 §11（1.58-bit 量化）的补充关系**：§11 的 E1 实验（gap 随 $l$ 指数扩大）和本节的 GSM8K/MATH 拟合测量的是同一参数 $L$，但从不同角度：E1 测量的是**BitNet vs. fp32 的 gap 曲线斜率**（$\log L$），本节测量的是**绝对准确率曲线的曲率**（直接拟合 $L$ 和 $\delta_{\max}$）。两条路径汇聚于同一 $L$ 的估计，互为交叉验证。

---

> [!IMPORTANT]
> **GSM8K/MATH 分层验证的 IDFC 核心结论**：
> 1. **宏观曲线拟合**：$\text{Acc}(k) \approx 1 - \delta_{\max}(L^k - 1)/(L-1)$ 是 Type II 误差积累对数学推理任务的**宏观预测**，可从现有公开数据集直接拟合。
> 2. **参数双测量**：PRM 单步标注数据提供 $\delta_{\max}$ 的直接测量，准确率-步数曲线提供 $L$ 的间接测量，两者联合确定 IDFC 的两个核心参数。
> 3. **交叉验证**：与 §12 整数加法反推的 $\delta_{\max}$ 交叉对比，可分离 Type II（误差积累）和 Type III（知识容量）对高难度题目失败的贡献。
> 4. **自洽性检验**：若 GSM8K 和 MATH 分别拟合的 $L$ 值高度一致，则验证 $L$ 是模型架构的本征参数（与任务无关），符合 IDFC 框架的基本假设。

---

## 17. Inverse Scaling 的 U 型曲线：寄生 $f$-chain 的实验证据

> **定位**：本节将 [McKenzie et al., 2023](https://arxiv.org/abs/2306.09479) 的 Inverse Scaling 竞赛结果（某些任务上大模型反而表现更差，随后在更大规模时性能反弹形成 U 型曲线）纳入 IDFC 框架。IDFC 给出的解释不依赖任何特设机制，而是 Part 3 §14.3（寄生 $f$-chain）机制在 Scaling 维度上的直接展开。

---

### 17.1 现象描述

**Inverse Scaling 竞赛**（[McKenzie et al., 2023]）：

> 在若干精心构造的任务上（如"否定问题"、"反事实推理"、"歌词补全"等），随模型参数量 $M$ 从 $\sim$0.5B 增大到 $\sim$100B，准确率**单调下降**。在部分任务上，继续扩大到 GPT-4 量级（$\sim$1T 参数等效）后，准确率重新上升，形成 **U 型曲线**（U-shaped scaling）。

U 型曲线的三个阶段：

1. **小模型阶段**（$M < M_1$）：准确率较低，因为模型整体能力不足
2. **中等模型阶段**（$M_1 < M < M_2$）：准确率**随规模下降**（Inverse Scaling 区）
3. **大模型阶段**（$M > M_2$）：准确率重新上升，超过小模型水平（涌现后反弹）

---

### 17.2 IDFC 的寄生 $f$-chain 解释

**定义回顾**（Part 3 §14.3）：**寄生 $f$-chain**（Parasitic $f$-chain）是训练集中高频激活的 $f$-chain，其激活路径与目标任务 $q$ 的正确 $r$-chain 在**输入空间上部分重叠**，但输出不同——即错误的 $f$-chain 路径被高频共现强化，在目标 $r$-chain 应该激活的区域"寄生"。

**形式化**：设目标任务的正确 $f$-chain 为 $f_q^* = \hat{f}_1 \circ \hat{f}_2 \circ \cdots \circ \hat{f}_{l^*}$，寄生链为 $f_q^{\text{par}} = \hat{f}_1 \circ \hat{f}_{2}^{\text{par}} \circ \cdots$（前几步相同，随后走向不同方向）。

设 $f_q^*$ 对应**低频原语** $r^*_i$（目标任务特定，训练数据稀少），$f_q^{\text{par}}$ 对应**高频原语** $r^{\text{par}}_i$（日常语言的高频陈述模式，如"直觉上正确的回答"）。

---

### 17.3 Scaling 对两种 $f$-chain 的非对称影响

**命题 17.1（Scaling 的寄生 $f$-chain 激活效应）**：设路由概率 $w_q^*(M)$（模型激活正确 $f_q^*$ 的概率）和 $w_q^{\text{par}}(M)$（激活寄生链的概率），在规模 $M$ 增大时：

$$w_q^{\text{par}}(M) \propto \nu_{\text{par}} \cdot M^\alpha, \qquad w_q^*(M) \propto \nu^* \cdot M^\beta$$

其中 $\nu_{\text{par}} \gg \nu^*$（高频 vs. 低频），$\alpha, \beta > 0$ 是 Scaling 的指数（由训练动力学决定）。

**关键不等式**：若 $\alpha > \beta$（高频链的参数效率提升更快），则存在中间规模范围 $[M_1, M_2]$，使得：

$$w_q^{\text{par}}(M) > w_q^*(M) \quad \text{（寄生链主导）}$$

即：**中等规模模型恰恰是寄生 $f$-chain 主导的"危险地带"**——小模型能力不足，两种链都弱；大模型能分辨并激活低频目标链；中等模型只足以强化高频链。

**准确率的 U 型预测**：

$$\text{Acc}(M) \approx w_q^*(M) - C \cdot w_q^{\text{par}}(M)$$

（正确链贡献正准确率，寄生链干扰使准确率下降）

在 $[M_1, M_2]$ 区间，$w_q^{\text{par}}$ 增长主导，$\text{Acc}(M)$ 下降；超过 $M_2$ 后，$w_q^*$ 迅速追上，$\text{Acc}(M)$ 反弹。

---

### 17.4 三类典型任务的 IDFC 分析

**任务 1（否定问题）**："以下陈述正确还是错误？'天空是绿色的。'"

- **目标链** $f_q^*$：$r_{\text{factual}} \circ r_{\text{negate}}$（先判断事实，再取反）
- **寄生链** $f_q^{\text{par}}$：$r_{\text{factual}}$ 然后**直接输出事实判断**（忽略取反步骤）
- **高频来源**：训练数据中"事实陈述的直接判断"远多于"取反后判断"
- **Inverse Scaling 解释**：中等规模模型强化了"直接输出事实判断"的寄生链，反而精确掌握了 $r_{\text{negate}}$ 的大规模模型（$M > M_2$）能突破

**任务 2（歌词补全）**："请补全以下歌词但将每个词替换为其反义词：'Yesterday, all my troubles…'"

- **目标链** $f_q^*$：$r_{\text{antonym-replace}} \circ r_{\text{lyrics-recall}}$
- **寄生链** $f_q^{\text{par}}$：$r_{\text{lyrics-recall}}$，直接输出记忆中的原版歌词
- **高频来源**：训练集中大量歌词及引用，$r_{\text{lyrics-recall}}$ 路由强度随 $M$ 指数强化
- **Inverse Scaling 解释**：规模越大，歌词记忆越精确 → 寄生链越强 → U 型或持续下降直到 $r_{\text{antonym-replace}}$ 的组合能力足以压制记忆

**任务 3（反事实推理）**："如果历史上从未发明过电，现代城市会是什么样子？"

- **目标链** $f_q^*$：$r_{\text{counterfactual-premise}} \circ r_{\text{reasoning}}$（先接受反事实前提，再在该前提下推理）
- **寄生链** $f_q^{\text{par}}$：$r_{\text{factual-world-reasoning}}$（直接在真实世界推理，忽视反事实前提）
- **高频来源**：几乎所有训练数据都是在真实世界前提下的推理

---

### 17.5 与 §14.3（RLHF 奖励黑客）的结构同构

Part 3 §14.3 的"奖励黑客"机制与本节的 Inverse Scaling U 型曲线**在 IDFC 框架下结构同构**：

| 维度 | RLHF 奖励黑客（§14.3）| Inverse Scaling 寄生链（本节）|
|---|---|---|
| **寄生链的激活源** | RLHF 奖励信号偏向高频路径 | Pretraining 频率偏向高频路径 |
| **被强化的 $f$-chain** | "看似好看"的输出链（奖励高但任务错误）| "直觉正确"的输出链（训练频率高但任务错误）|
| **规模效应** | 更强的模型更精确地优化奖励 → 更强的黑客 | 更大的模型更强地激活高频链 → 更强的寄生 |
| **突破条件** | 奖励建模精度足够区分"形式正确"和"语义正确" | 模型规模足够区分目标链和寄生链 |

两者均是 **$F$ 集合中高频 $f$-chain 压制低频目标 $f$-chain** 的具体实例，适用同一个解释框架：

$$\text{Acc}_{\text{task}} \downarrow \iff w_q^{\text{par}} > w_q^* \iff \frac{\nu_{\text{par}}}{\nu^*} > \frac{M^{\beta - \alpha}}{C_0}$$

---

### 17.6 U 型曲线的两段斜率解释

**第一段斜率**（下降段，$M_1 < M < M_2$）：

$$\frac{d\,\text{Acc}}{d\log M} < 0$$

由命题 17.1，$w_q^{\text{par}} \propto \nu_{\text{par}} \cdot M^\alpha$ 的增速主导——寄生链在此规模区间比目标链受益更多（$\alpha > \beta$ 时），准确率下降速率 $\approx -C \cdot \alpha \cdot w_q^{\text{par}}$。

**第二段斜率**（上升段，$M > M_2$）：

$$\frac{d\,\text{Acc}}{d\log M} > 0$$

$M > M_2$ 时，目标低频链 $f_q^*$ 实现**涌现式激活**（Part 3 §5 的相变）：$w_q^*$ 从 $\approx 0$ 跃升至 $> 0$，两链的竞争关系反转。上升速率由 $w_q^*$ 的相变斜率决定，通常比第一段的下降更陡（涌现的相变特性）。

**$M_2$（U 型底部）的 IDFC 预测**：

$$M_2 = \left(\frac{\nu_{\text{par}}}{\nu^*} \cdot \frac{C_0}{\alpha - \beta}\right)^{1/(\beta - \alpha)} \quad (\text{若 } \beta > \alpha \text{ 最终成立})$$

这是可原则性测量的量——$M_2$ 依赖任务的正反向频率比 $\nu_{\text{par}}/\nu^*$，该比值可从训练语料统计估计。

---

### 17.7 与实验文献的精确对接

| 实验现象 | 源文献 | IDFC 对应命题 | 证明状态 |
|---|---|---|---|
| 否定/反事实等任务上 Acc 随规模下降 | [McKenzie et al., 2023]，Fig.3 | 命题 17.1：中等规模区间 $w_q^{\text{par}} > w_q^*$ | ✅ 机制严格，量化为条件预测 |
| U 型曲线：超大规模后反弹 | [McKenzie et al., 2023]，U-shaped 分类 | §17.6：$M > M_2$ 时 $w_q^*$ 涌现，相变反转 | ✅ 严格（涌现相变推论）|
| Hindsight Neglect：先提供答案后，模型仍犯同类错误 | McKenzie 竞赛条目 | 寄生链高度抗干扰：$w_q^{\text{par}}$ 不因提示信号而迅速下调（路由机制的惯性）| ✅ 机制相符 |
| 歌词类任务无 U 型（持续下降）| McKenzie 竞赛结果 | $\nu_{\text{par}}/\nu^*$ 极大（歌词记忆极强），$M_2 \to \infty$，在当前可测规模内不出现反弹 | ✅ 预测 $M_2 > \text{当前最大模型}$ |
| CoT 提示缓解 Inverse Scaling | [Suzgun et al., 2022] (BIG-Bench Hard) | CoT 显式要求模型输出中间步骤 → 将 $r_{\text{negate}}$（目标步骤）解锁为 $f$-chain 中的显式节点 → $w_q^*$ 提升 | ✅ 严格（CoT 的路由引导作用）|

---

### 17.8 区分寄生 $f$-chain 与其他失效类型

**与 Type III 的区分**：Type III 是知识容量问题（$N > d$，混叠不可避免）；Inverse Scaling 的寄生链是**路由竞争问题**（正确链被路由机制欠选），Welch Bound 无关。判别：增大 $d$ 消除 Type III，但不能消除寄生链（路由偏置需要训练数据校正）。

**与 Type II 的区分**：Type II 是**误差积累**——随步数指数增加。Inverse Scaling 是**路由失败**——在第一步就走向错误方向，后续步骤的链路深度不是问题。判别：Inverse Scaling 任务通常 $l^* = 1$–$2$（短链），非 Type II。

**诊断方法**：

1. 减小模型规模至 $M_1$ 以下（小模型），检查简单版本的任务是否成功 → 如果成功，确认是路由竞争问题（不是能力缺失）
2. 提供 CoT scaffold（显式列出推理步骤）→ 如果准确率恢复，确认是寄生链被 CoT 绕过（而非 Type I/II）
3. 在训练数据中补充目标任务类型的样本（提高 $\nu^*$）→ 如果恢复，确认是 $\nu_{\text{par}}/\nu^*$ 的频率竞争问题

---

> [!IMPORTANT]
> **Inverse Scaling 验证的 IDFC 核心结论**：
> 1. **寄生 $f$-chain 机制**：Inverse Scaling 的根因是中等规模区间内高频寄生链（$w_q^{\text{par}}$）对低频目标链（$w_q^*$）的路由压制——不需要任何特设假设，是 Part 3 §14.3 机制在 Scaling 维度上的必然推论。
> 2. **U 型两段斜率**：下降段 = 寄生链随规模强化；上升段 = 目标链的涌现相变；底部 $M_2$ = 两链路概率交叉点，原则上由训练语料频率比 $\nu_{\text{par}}/\nu^*$ 决定。
> 3. **CoT 的修复机制**：CoT 通过显式插入目标步骤作为 $f$-chain 节点，将被路由机制压制的低频原语"强制解锁"，等价于提高 $w_q^*$——这是 CoT 对 Inverse Scaling 任务有效的 IDFC 解释。
> 4. **与奖励黑客的结构同构**：Pretraining 频率偏置（本节）和 RLHF 奖励偏置（§14.3）是同一寄生链机制的两个来源——统一了"过拟合高频模式"的行为学现象与"奖励黑客"的对齐失效。

---

## 18. 实验验证体系总览

> **定位**：整合 §12–17 的六个验证案例，形成 IDFC 理论验证体系的完整地图。

---

### 18.1 六个标准蜡烛的定位

| 章节 | 实验 | 验证的 IDFC 核心 | 证明状态 | 类型 |
|---|---|---|---|---|
| §12 | 整数加法长度泛化 | CAC 误差积累（Type II）的锚定验证 | ✅ 严格 | Type II 标准蜡烛 |
| §13 | Reversal Curse | $R_{\text{tr}}$ 非对称覆盖（Type V 暂定）| ✅ 严格（代数必然）| Type V 的首例 |
| §14 | Needle in a Haystack | $\mathcal{F}^*(n, d_k, B)$ 直接测量（Type IV-a）| ✅ 严格 | Type IV-a 标准蜡烛 |
| §15 | Grokking（模块算术）| $r$-chain 乘积结构 + 顿悟触发条件 | ✅ 严格（§5.4 直接验证）| 乘积结构验证 |
| §16 | GSM8K/MATH 分层 | Type II 宏观参数拟合（$\delta_{\max}, L$）| ✅ 参数可拟合（条件验证）| Type II 参数化 |
| §17 | Inverse Scaling U 型 | 寄生 $f$-chain 的 Scaling 动态（§14.3）| ✅ 机制严格，量化为条件预测 | 寄生链验证 |

---

### 18.2 参数联立方程组：理论自洽性检验

六个验证案例共同约束 IDFC 的同一组核心参数（$\delta_{\max}$、$L$、$B^2/\sqrt{d_k}$），形成**过约束方程组**——若方程组相容（不同实验给出彼此一致的参数估计），则提供极强的理论自洽性证据：

$$\delta_{\max}^{\text{add}} = \frac{0.5}{n^*_{\text{add}}} \quad (\S12)$$

$$\delta_{\max}^{\text{MATH}} \approx \text{PRM 单步错误率} \quad (\S16)$$

$$L \approx e^{\text{gap 曲线斜率}} \quad (\S11\text{ E1} + \S16)$$

$$\frac{B^2}{\sqrt{d_k}} = \frac{1}{2} \log\!\left(1 + n_{\text{fail}} \cdot \frac{\delta}{\|v^*\| - \delta}\right) \quad (\S14)$$

若这四个来源的 $\delta_{\max}$ 和 $L$ 在同一量级（区别 $\leq$ 一个数量级内），则验证 IDFC 的参数假设在跨任务意义下是自洽的。若严重不一致，则指向需要修订的具体假设（如哪个任务域存在 Type III 污染，或 $L$ 是否任务无关）。

---

### 18.3 未来验证优先级

| 优先级 | 实验 | 执行难度 | 理论价值 |
|---|---|---|---|
| ★★★ | §14 $B^2/\sqrt{d_k}$ 跨模型测量 | 低（公开 NIAH 热图可用）| 高（直接测量核心架构参数）|
| ★★★ | §16 PRM 单步误差率提取 | 低（PRM800K 公开）| 高（$\delta_{\max}$ 直接测量）|
| ★★☆ | §15 $t_{\text{grok}} \propto 1/\lambda$ 定量验证 | 中（需小规模训练）| 高（乘积结构的定量验证）|
| ★★☆ | §12 $n^*$ 跨模型对比 | 低（公开 benchmark）| 中（锚定参数的跨模型一致性）|
| ★☆☆ | §17 $M_2$ 与 $\nu_{\text{par}}/\nu^*$ 的相关性 | 高（需训练语料统计）| 中（寄生链模型的定量校准）|

---

