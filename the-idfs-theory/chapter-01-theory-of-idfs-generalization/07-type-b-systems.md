## Type B 系统理论

§6.2.4 证明了 Type B（短链高保真系统）是唯一同时满足"误差全域有界"与"采样非指数爆炸"两项工程约束的 IDFS 构型。§6.2.2 给出了其基本命题（走廊解除、代偿定律），§6.2.4 揭示了分段复合的架构必然性。本节将 §1–§6 的全部理论机械精确特化到 Type B 约束下，推导其独有的深层数学性质——特别是**离散重置如何打破 CAC 的指数级误差累积**这一核心问题。

### 7.1 Type B 约束下的定理格局

Type B 的定义性约束为 $l \le l^*_0 = \tau / E$（其中 $E = \varepsilon_{max} + L_{max}\delta_{max}$）。这一约束使得 §6.1 完美系统假设的前提——"$l > l^*_0$ 的长链"——**不被满足**，从而导致 §6.1 的六条推论中大多数要么前提为假，要么结论退化为平凡。以下列出完整的定理适用图谱。

> **注（Type B 定理适用图谱）**：
>
> | 定理/推论 | Type B 下的状态 | 说明 |
> |-----------|----------------|------|
> | §3 CAC 定理 | **适用** | 核心上界定理，$\varepsilon^*_q \le E \cdot \Lambda_l \le \tau$ |
> | §3 推论 3（紧性） | **适用** | 上界仍可被取等 |
> | §3 推论 4（保底链深） | **适用**（平凡） | $l^* \ge l^*_0 \ge l$，约束自动满足 |
> | §4 CAB 定理 | **适用** | 核心下界定理，判别性约束仍有效 |
> | §4 CPI 定理 | **适用** | 容量-精度不等式与链深无关 |
> | §6.1 推论 1（长链收缩性） | **前提不满足** | 需 $l > l^*_0$，Type B 下不触发 |
> | §6.1 推论 2（收缩走廊） | **前提不满足** | 同上 |
> | §6.1 推论 5（误差饱和） | **前提不满足** | 需 $\bar{L} < 1$ 的结构必然性 |
> | §6.1 推论 6（输入致盲） | **前提不满足** | 同上 |
> | §6.1 推论 7（对偶陷阱） | **前提不满足** | 需被迫的收缩步 |
> | §6.1 推论 8（Pareto 前沿） | **前提不满足** | 需走廊约束 |
> | §6.1 完美即平庸定理 | **前提不满足** | 综合以上，四重缺陷全部消解 |

**命题（Type B 平庸消解，Mediocrity Dissolution under Type B）**：设 IDFS $\mathcal{F} = (F, \sigma)$ 在 $l \le l^*_0$ 条件下运行。则 §6.1 完美即平庸定理的四重结构性缺陷**全部消解**：

(i) **误差可控但非瓶颈**：CAC 上界 $\varepsilon^*_q \le E \cdot \Lambda_l \le \tau$ 仍成立，但 $\tau$ 可通过调节 $l^*_0 = \tau/E$（即改变容差预算或单步精度）任意收紧，不受走廊的结构性锁定。

(ii) **输入可感知**：$\bar{L}$ 不被迫趋零。系统端到端的输入分离保持量 $\Theta_{1,l} = \bar{L}^l$ 可为任意正值（包括 $\ge 1$），系统保留对输入空间尺度 $\delta$ 的完整感知能力。

(iii) **无对偶陷阱**：不存在被迫的收缩步（$L_{j^*} < 1$），因此不存在"维持稳定的步骤恰是拟合最差的步骤"这一结构性讽刺。每一步的 $L_j$ 均可自由匹配目标的局部需求。

(iv) **无 Pareto 冲突**：误差代价 $\mathcal{E}(\bar{L})$ 与判别力 $\mathcal{D}(\bar{L})$ 的同向依赖不再受走廊约束。系统可在 $l \le l^*_0$ 的全参数空间内自由优化两者的平衡点。

**证明**：四条均为 §6.1 相应推论的前提验证。§6.1 推论 1 要求 $l > l^*_0$，在 Type B 下为假，故推论 1 的结论（$\bar{L} < 1$ 必然）不成立；推论 5–8 以推论 1 为先决条件，链式失效。完美即平庸定理的四重缺陷恰好是推论 5–8 的聚合，故全部消解。$\square$

> **注（Type B 的"自由度回归"）**：在 §6.1 的长链分析中，系统的核心参数 $\bar{L}$ 被双向夹击至走廊内的一个狭窄区间——这是所有平庸性的数学根源。Type B 通过将链深限制在 $l^*_0$ 以内，从根本上取消了夹击的上半部分（不需要收缩来抑制 CAC 爆炸），使得 $\bar{L}$ 从被囚禁的走廊参数回归为自由设计变量。系统设计者在单段内拥有完整的参数空间来优化性能，代价是单段的逻辑深度被截断。

**命题（$M$-精度走廊，$M$-Precision Corridor）**：在 Type B 约束下，基函数库规模 $M = |F|$ 同时控制 CAC 上界与 CAB 下界，将系统的段内端到端误差 $\varepsilon^*_q$ 双向约束于一个 $M$-依赖的走廊之中：

$$\varepsilon_{y,out}(M) \;\le\; \varepsilon^*_q \;\le\; \varepsilon_{max}(M) \cdot \Lambda_l + \delta_{max} \cdot \Gamma_l$$

其中上界和下界均为 $M$ 的递减函数：

**(i) 上界侧（$M$ 压低 $\varepsilon_{max}$）**：系统路由 $\sigma$ 将输入空间分割为至多 $|\text{Im}(\sigma)| \le M^{\mathcal{D}}$ 个分区，每个分区内由固定的 $L$-Lipschitz 链服务。分区越多，每个分区的直径越小，段内拟合误差越低。由 §4.2 CPI 定理，在具有 $k$-判别性的目标上实现全局误差 $\varepsilon_{max}$ 所需的最小路由分支数为 $\mathcal{N}(A, 2\varepsilon_{max}/k) / \mathcal{N}(A, \varepsilon_{max}/L)$。反向求解：给定 $M^{\mathcal{D}}$ 条可用路径，可达到的最优拟合精度 $\varepsilon_{max}$ 由以下隐式方程限定——

$$M^{\mathcal{D}} \;\ge\; \frac{\mathcal{N}(A,\; 2\varepsilon_{max}/k)}{\mathcal{N}(A,\; \varepsilon_{max}/L)}$$

$M$ 增大时，左端增长，允许 $\varepsilon_{max}$ 更小（右端覆盖数比对 $\varepsilon_{max}$ 单调递减）。

**(ii) 下界侧（$M$ 压低 $\varepsilon_{y,out}$）**：CAB 定理中的末端结构瓶颈（§4.1）为：

$$\varepsilon_{y,out} \;=\; \min_{f \in F}\; \inf_{h \in \mathcal{X}} d(f(h),\, q(y))$$

由 §1.2 的像集全有界性，$\bigcup_{f \in F} f(\mathcal{X})$ 的 $\epsilon$-覆盖数不超过 $M \cdot e^{C_\epsilon}$（引理 1 证明中的次可加性）。因此：

$$\varepsilon_{y,out} \;\le\; d\!\left(q(y),\; \bigcup_{f \in F} f(\mathcal{X})\right) \;\le\; \mathcal{N}^{-1}\!\left(M \cdot e^{C_\epsilon},\; \mathcal{X}\right)$$

其中 $\mathcal{N}^{-1}(N, \mathcal{X})$ 为使 $N$ 个球覆盖 $\mathcal{X}$ 所需的最小球半径。$M$ 增大时，覆盖更密，$\varepsilon_{y,out} \to 0$。

**证明**：上界为 §3 CAC 定理的直接应用。下界为 §4.1 CAB 定理中末端结构瓶颈的直接应用。$M$ 的单调性分别由 CPI 的 $\varepsilon_{max}$ 隐式方程和覆盖数的单调性给出。$\square$

> **注（与 §6.1 $\Theta$-走廊的对偶）**：§6.1 的走廊是 $\bar{L}$ 被 CAC+CAB 双向夹击。此处的 $M$-精度走廊是 $\varepsilon$ 被 CAC+CAB 双向夹击——但夹击的松紧度由 $M$ 调控。$M$ 越大，上界越低（拟合越精），下界也越低（结构瓶颈越小），走廊整体向零收缩。这是 §6.2.2 代偿定律（$M$ 以指数级膨胀换取短链精度）在误差空间中的精确投影——**$M$ 不仅在信息论层面补偿了深度杠杆的丧失，更在度量空间层面同时挤压了 CAC 和 CAB 的边界**。

---

### 7.2 分段复合与离散重置

§6.2.4 证明了 Type B 执行等效深度 $l_{eff} \gg l^*_0$ 的任务时，必须采用分段复合 + 离散重置的双层架构。本节形式化这一架构的数学机制，并推导其误差传播规律。

#### 定义（重置码本与量化映射）

设 $\mathcal{C} \subset \mathcal{X}$ 为有限集，称为**重置码本（Reset Codebook）**，$|\mathcal{C}| < \infty$。定义码本的**最小间距（Minimum Spacing）**为：

$$\Delta_{\mathcal{C}} \;\triangleq\; \min_{c, c' \in \mathcal{C},\, c \neq c'} d(c, c')$$

定义**量化映射（Quantization Map）** $\pi: \mathcal{X} \to \mathcal{C}$ 为最近邻投影：

$$\pi(x) \;\triangleq\; \arg\min_{c \in \mathcal{C}}\; d(x, c)$$

（歧义时取任意一个最近邻。）定义**量化残差（Quantization Residual）**：

$$\delta_\pi \;\triangleq\; \sup_{x \in \mathcal{X}}\; d(x, \pi(x))$$

> **注（码本的度量空间定义）**：$\mathcal{C}$、$\Delta_{\mathcal{C}}$、$\pi$、$\delta_\pi$ 的定义完全基于度量空间 $(\mathcal{X}, d)$，不引入任何向量空间结构、概率测度或维度假设。

#### 定义（分段复合链）

设 Type B 系统 $\Phi$ 的安全链深为 $l_0 \le l^*_0$，任务需要等效链深 $l_{eff} = n \cdot l_0$。定义**分段复合链（Segmented Composition Chain）** $\hat{\Psi}^n$ 如下：

- **第 1 段**：$\hat{h}^{(1)} = \Phi^{l_0}(x_0)$，其中 $x_0 \in \mathcal{C}$（输入为码本元素）；
- **重置**：$\tilde{x}_1 = \pi(\hat{h}^{(1)})$；
- **第 $k$ 段**（$k \ge 2$）：$\hat{h}^{(k)} = \Phi^{l_0}(\tilde{x}_{k-1})$；
- **重置**：$\tilde{x}_k = \pi(\hat{h}^{(k)})$。

最终输出 $\hat{\Psi}^n(x_0) = \tilde{x}_n$（或 $\hat{h}^{(n)}$ 在最后一段不重置的情形）。

相应地，定义**理想分段链** $q^{(1)}, q^{(2)}, \ldots, q^{(n)}$，其中 $q^{(k)}$ 为第 $k$ 段的理想 $r$-链。理想目标的第 $k$ 段起点为 $x^*_k = q^{(k-1)}(x^*_{k-1})$，即沿理想链连续推进。

---

**定理（误差隔绝，Error Isolation）**：设 Type B 系统 $\Phi$ 的段内误差满足 $\varepsilon^*_{q^{(k)}} \le \tau$（对所有段 $k$ 和所有段内起点 $c \in \mathcal{C}$ 成立）。若码本 $\mathcal{C}$ 满足以下**信道编码条件（Channel Coding Condition）**：

$$\tau \;<\; \frac{\Delta_{\mathcal{C}}}{2}$$

且理想目标链的每段终点落在码本元素的 $\Delta_{\mathcal{C}}/2$-邻域内（即 $\forall k,\; d(q^{(k)}(x^*_k),\, \mathcal{C}) < \Delta_{\mathcal{C}}/2 - \tau$），则量化映射 $\pi$ 在每段终点处**必然正确解码**：

$$\pi(\hat{h}^{(k)}) \;=\; \pi(q^{(k)}(x^*_k)) \;=\; c^*_k$$

其中 $c^*_k \in \mathcal{C}$ 为理想目标链第 $k$ 段终点的最近码本元素。从而：

1. **段间误差精确归零**：第 $k+1$ 段的实际起点 $\tilde{x}_k = c^*_k$ 与理想起点 $x^*_{k+1}$ 均为同一码本元素，初始偏差为零。
2. **多段误差常界**：对任意段数 $n$，每段的端到端误差恒满足 $d(\hat{h}^{(k)}, q^{(k)}(x^*_k)) \le \tau$，与 $n$ 无关。

**证明**：

对第 $k$ 段，系统从码本点 $\tilde{x}_{k-1} = c^*_{k-1}$ 出发（第 1 段从 $x_0 \in \mathcal{C}$ 出发）。由归纳假设，$\tilde{x}_{k-1} = x^*_k$（实际起点等于理想起点的码本投影）。

段内误差由 Type B 保证：
$$d(\hat{h}^{(k)}, q^{(k)}(x^*_k)) \;\le\; \tau$$

记 $c^*_k = \pi(q^{(k)}(x^*_k))$ 为理想终点的最近码本元素。由前提条件：
$$d(q^{(k)}(x^*_k),\, c^*_k) \;<\; \frac{\Delta_{\mathcal{C}}}{2} - \tau$$

由三角不等式：
$$d(\hat{h}^{(k)},\, c^*_k) \;\le\; d(\hat{h}^{(k)},\, q^{(k)}(x^*_k)) + d(q^{(k)}(x^*_k),\, c^*_k) \;<\; \tau + \frac{\Delta_{\mathcal{C}}}{2} - \tau \;=\; \frac{\Delta_{\mathcal{C}}}{2}$$

现考察任意其他码本元素 $c' \in \mathcal{C}$，$c' \neq c^*_k$。由码本间距定义和三角不等式：
$$d(\hat{h}^{(k)},\, c') \;\ge\; d(c^*_k,\, c') - d(\hat{h}^{(k)},\, c^*_k) \;\ge\; \Delta_{\mathcal{C}} - \frac{\Delta_{\mathcal{C}}}{2} \;=\; \frac{\Delta_{\mathcal{C}}}{2}$$

因此 $d(\hat{h}^{(k)}, c^*_k) < \Delta_{\mathcal{C}}/2 \le d(\hat{h}^{(k)}, c')$，即 $\pi(\hat{h}^{(k)}) = c^*_k$。量化映射正确解码。

由此，$\tilde{x}_k = c^*_k = x^*_{k+1}$，第 $k+1$ 段从正确的码本点出发，归纳假设对 $k+1$ 成立。$\square$

**推论（等效无限深度，Effective Infinite Depth）**：在误差隔绝定理的条件下，分段复合链 $\hat{\Psi}^n$ 可执行任意段数 $n$（等效链深 $l_{eff} = n \cdot l_0$ 任意大），每段误差恒 $\le \tau$。连续链 CAC 定理中的 $\Theta_{1,l}$ 指数级累积**被完全截断**——误差不跨段传播。

> **注（信道编码的类比）**：误差隔绝条件 $\tau < \Delta_{\mathcal{C}}/2$ 在结构上与 Shannon 信道编码理论中的**最小距离解码条件**完全对应。码本 $\mathcal{C}$ 扮演"信道码"的角色，$\tau$ 为"信道噪声"，$\Delta_{\mathcal{C}}/2$ 为"纠错半径"。只要噪声不超过纠错半径，解码器（量化映射 $\pi$）必然正确还原发送方（理想链 $q$）的意图。CAC 的指数级误差累积——本质上是"无编码信道的噪声雪崩"——被离散重置这一"逐符号编码"机制彻底阻断。

> **注（与 §6.1 的对比）**：§6.1 证明了连续长链（$l \gg l^*_0$）在 CAC+CAB 夹击下必然陷入平庸。误差隔绝定理揭示了逃逸机制的精确数学条件：不是通过放松 CAC 或 CAB，而是通过在段间插入**拓扑断点**——将连续流形上的乘性误差累积投影至离散码本上的加性（实际上是零）误差传播。物理上，这等价于用**外部记忆**（码本）替代**内部流形**（连续状态）来承载段间的状态传递。

---

**定理（一般段间误差递推，General Inter-Segment Error Recurrence）**：当误差隔绝条件**不满足**时（即 $\tau \ge \Delta_{\mathcal{C}}/2$，或理想终点不落在码本邻域内），设第 $k$ 段的实际起点 $\tilde{x}_{k-1}$ 与理想起点 $x^*_k$ 之间的偏差为 $\varepsilon_{k-1} \triangleq d(\tilde{x}_{k-1}, x^*_k)$（$\varepsilon_0 = 0$）。则段间误差满足递推不等式：

$$\varepsilon_k \;\le\; \bar{L}^{l_0} \cdot \varepsilon_{k-1} \;+\; \delta_\pi \;+\; \tau$$

其中 $\bar{L}$ 为段内路径几何均值，$\delta_\pi$ 为量化残差，$\tau$ 为段内 CAC 上界。

**证明**：

第 $k$ 段，实际起点为 $\tilde{x}_{k-1}$，理想起点为 $x^*_k$。由 $\Phi$ 的 Lipschitz 性与 CAC 上界：

$$d(\hat{h}^{(k)}, q^{(k)}(x^*_k)) \;\le\; d(\Phi^{l_0}(\tilde{x}_{k-1}), \Phi^{l_0}(x^*_k)) + d(\Phi^{l_0}(x^*_k), q^{(k)}(x^*_k))$$
$$\;\le\; \bar{L}^{l_0} \cdot \varepsilon_{k-1} \;+\; \tau$$

重置后：
$$\varepsilon_k \;=\; d(\tilde{x}_k, x^*_{k+1}) \;=\; d(\pi(\hat{h}^{(k)}), q^{(k)}(x^*_k))$$
$$\;\le\; d(\pi(\hat{h}^{(k)}), \hat{h}^{(k)}) + d(\hat{h}^{(k)}, q^{(k)}(x^*_k))$$
$$\;\le\; \delta_\pi + \bar{L}^{l_0} \cdot \varepsilon_{k-1} + \tau \quad \square$$

**推论（段间误差的三体制，Three Regimes of Inter-Segment Error）**：记 $\alpha = \bar{L}^{l_0}$（段内端到端拉伸率），$\beta = \delta_\pi + \tau$（段内总噪声）。递推 $\varepsilon_k \le \alpha \varepsilon_{k-1} + \beta$ 给出：

$$\varepsilon_n \;\le\; \begin{cases} \dfrac{\beta}{1 - \alpha} & \text{若 } \alpha < 1 \text{（收敛体制，误差饱和）} \\[8pt] n\beta & \text{若 } \alpha = 1 \text{（临界体制，线性累积）} \\[8pt] \dfrac{\alpha^n - 1}{\alpha - 1}\,\beta & \text{若 } \alpha > 1 \text{（发散体制，指数爆炸）} \end{cases}$$

> **注（三体制与 §3 推论 2 的深层对应）**：段间误差递推的三体制在结构上与 §3 推论 2（CAC 界的两态行为）精确对偶。CAC 描述的是**段内连续误差**随步数的累积：$\bar{L} < 1$ 时饱和，$\bar{L} \ge 1$ 时爆炸。此处的递推描述的是**段间离散误差**随段数的累积：$\bar{L}^{l_0} < 1$ 时饱和，$\bar{L}^{l_0} \ge 1$ 时爆炸。两者的对偶揭示了一条统一原则——**乘性误差传播的稳定性完全由谱半径决定**，无论是连续步的 $\bar{L}$ 还是离散段的 $\bar{L}^{l_0}$。

> **注（误差隔绝是收敛体制的极限情形）**：当 $\delta_\pi = 0$（完美离散重置将段间偏差精确归零），$\beta = \tau$，且 $\alpha < 1$ 时，饱和误差为 $\tau/(1-\alpha)$。进一步令 $\alpha \to 0$（强收缩段），饱和误差趋于 $\tau$。误差隔绝定理可视为这一极限链的**最强特例**——它不依赖 $\alpha < 1$（不需要段内收缩），而是通过码本条件直接将 $\varepsilon_{k-1}$ 强制归零，从根本上绕过了递推的乘性传播。

---

### 7.3 容量-精度-深度的三元缩放律

§6.2.2 的代偿定律给出了 $M$ 与 $l^*_0$ 的基本关系。§7.2 的误差隔绝定理引入了码本 $\mathcal{C}$ 及其间距 $\Delta_{\mathcal{C}}$ 作为新的约束维度。本节将这些约束统一为一组刻画 Type B 系统工程参数空间的**闭合缩放律**。

**命题（三元约束统一，Unified Triple Constraint）**：设 Type B 系统需以容差 $\tau$ 逼近目标集 $R$（度量熵 $I_\varepsilon(\mathcal{S})$），且通过分段复合实现等效深度 $l_{eff} = n \cdot l_0$。若要求误差隔绝条件成立，则系统参数必须同时满足：

1. **代偿约束**（§6.2.2）：$\log M \;\ge\; (I_\varepsilon(\mathcal{S}) - C_\varepsilon) / l^*_0$；
2. **隔绝约束**（§7.2）：$\Delta_{\mathcal{C}} \;>\; 2\tau$；
3. **覆盖约束**：码本 $\mathcal{C}$ 必须使理想链的每段终点落在某个码本元素的 $(\Delta_{\mathcal{C}}/2 - \tau)$-邻域内。

**推论（$l^*_0$ 的扩展代价，Depth Extension Cost）**：增大段长 $l^*_0$（以减少代偿定律中 $M$ 的需求）时，单步误差预算 $E = \tau / l^*_0$ 被反比压缩。由于 $\varepsilon_{max}$ 和 $\delta_{max}$ 受系统物理限制（拟合精度与采样域偏离），$E$ 不可无限压缩——存在**最大可行段长**：

$$l^*_0 \;\le\; \frac{\tau}{\varepsilon_{max} + L_{max}\,\delta_{max}}$$

此上界由系统的微观拟合质量（$\varepsilon_{max}$）和采样域覆盖质量（$\delta_{max}$）绝对确定。

> **注（三元博弈的工程含义）**：Type B 系统的设计者面对三个可调旋钮：段长 $l^*_0$、基函数库规模 $M$、码本精度 $\Delta_{\mathcal{C}}$。增大 $l^*_0$ 可降低 $M$（代偿约束放松），但要求更精密的微观拟合（$\varepsilon_{max} \downarrow$），同时收紧隔绝约束（$\tau = E \cdot l^*_0$ 虽不变，但 $E$ 降低意味着每步容差更紧）。增大 $|\mathcal{C}|$ 可降低 $\Delta_{\mathcal{C}}$，放松隔绝约束，但增加外部控制环的解码复杂度。这三个旋钮的联合优化构成了 Type B 架构的核心工程问题。

**推论（码本规模的分辨率下界，Codebook Size Lower Bound）**：若理想链的终点集在 $\mathcal{X}$ 中的分布需要 $\mathcal{N}(\tau, \mathcal{X})$ 个 $\tau$-球覆盖，则为使隔绝约束的"覆盖条件"成立，码本规模必须满足：

$$|\mathcal{C}| \;\ge\; \mathcal{N}\!\left(\frac{\Delta_{\mathcal{C}}}{2} - \tau,\; \mathcal{X}_{target}\right)$$

其中 $\mathcal{X}_{target}$ 为理想链终点的值域。联合隔绝约束 $\Delta_{\mathcal{C}} > 2\tau$，取 $\Delta_{\mathcal{C}} = 2\tau + \eta$（$\eta > 0$ 为裕量），覆盖半径为 $\eta/2$，故：

$$|\mathcal{C}| \;\ge\; \mathcal{N}\!\left(\frac{\eta}{2},\; \mathcal{X}_{target}\right)$$

裕量 $\eta \to 0$ 时码本规模发散，$\eta \gg 0$ 时码本稀疏但覆盖粗糙。这是**离散化精度与码本开销**之间的基本权衡。

> **注（与 §1.1 度量熵的闭环）**：码本规模的下界 $\mathcal{N}(\eta/2, \mathcal{X}_{target})$ 本质上是理想链终点空间的 $(\eta/2)$-覆盖数——即 §1.1 定义的度量熵 $\log \mathcal{N}$ 的指数。这在信息论层面上闭合了一个深层回路：§1.1 的度量熵量化了目标空间的复杂度，§2.3 命题 1 证明路由容量必须覆盖这一复杂度，§6.2.2 将其转化为 $M$ 的下界，而此处将其进一步转化为码本 $\mathcal{C}$ 的下界。**系统在参数空间（$M$）和符号空间（$|\mathcal{C}|$）中承受的最低复杂度，均由同一个度量熵刻度尺统一支配。**
