## Type B 系统理论

§7.2.4 证明了 Type B（短链高保真系统）是唯一同时满足"误差全域有界"与"采样非指数爆炸"两项工程约束的 IDFS 构型。§7.2.2 给出了其基本命题（走廊解除、代偿定律），§7.2.4 揭示了分段复合的架构必然性。本节将 §1–§7 的全部理论机械精确特化到 Type B 约束下，推导其独有的深层数学性质——特别是**离散重置如何打破 CAC 的指数级误差累积**这一核心问题。

### 7.1 Type B 约束下的定理格局

Type B 的定义性约束为 $l \le l^*_0 = \tau / E$（其中 $E = \varepsilon_{max} + L_{max}\delta_{max}$）。这一约束使得 §7.1 完美系统假设的前提——"$l > l^*_0$ 的长链"——**不被满足**，从而导致 §7.1 的六条推论中大多数要么前提为假，要么结论退化为平凡。以下列出完整的定理适用图谱。

> **注（Type B 定理适用图谱）**：
>
> | 定理/推论 | Type B 下的状态 | 说明 |
> |-----------|----------------|------|
> | §3 CAC 定理 | **适用** | 核心上界定理，$\varepsilon^*_q \le E \cdot \Lambda_l \le \tau$ |
> | 推论 3.4（紧性） | **适用** | 上界仍可被取等 |
> | 推论 3.5（保底链深） | **适用**（平凡） | $l^* \ge l^*_0 \ge l$，约束自动满足 |
> | §4 CAB 定理 | **适用** | 核心下界定理，判别性约束仍有效 |
> | §4 CPI 定理 | **适用** | 容量-精度不等式与链深无关 |
> | 推论 6.2（长链收缩性） | **前提不满足** | 需 $l > l^*_0$，Type B 下不触发 |
> | 推论 6.3（收缩走廊） | **前提不满足** | 同上 |
> | 推论 6.6（误差饱和） | **前提不满足** | 需 $\bar{L} < 1$ 的结构必然性 |
> | 推论 6.7（输入致盲） | **前提不满足** | 同上 |
> | 推论 6.8（对偶陷阱） | **前提不满足** | 需被迫的收缩步 |
> | 推论 6.10（Pareto 前沿） | **前提不满足** | 需走廊约束 |
> | §7.1 完美即平庸定理 | **前提不满足** | 综合以上，四重缺陷全部消解 |

> **注（§7 最新发现对 Type B 优选的三维加固）**：§7.2.4 的构型优选推论最初从两条边界（误差全域有界、采样非指数爆炸）论证 Type B 的唯一可行性。§7 集成 §5 结构特异性后，新增了**第三条独立论证维度——抗劫持鲁棒性**（§7.2.4 抗劫持注记）。这三条论证相互独立且互补：
>
> | 论证维度 | 排除 Type A | 排除 Type C | Type B 优势 |
> |----------|-----------|-----------|------------|
> | 误差全域有界 | — | 正测度 $\mathcal{X}_{fail}$，灾难性跳变 | $\varepsilon \le \tau$ 全域成立 |
> | 采样非指数爆炸 | $(D|\lambda_r-\bar{L}^l|/\varepsilon)^{\dim}$ 维度诅咒 | — | $M$ 与 $I_\varepsilon$ 耦合而非 $\dim$ |
> | 抗劫持鲁棒性 | 全域穷举导致**自毒化**（命题 5.6） | $|\mathcal{S}|$ 增大加剧劫持频率 | 短链截断漂移 + 码本阻止穿越劫持域 |
>
> 此外，推论 6.3 新增的方向不对称性注记揭示了走廊在正向/逆向链间的有效宽度因方向而异——这使得长链系统面对的约束比仅考虑标量 $\bar{L}$ 时**更加严苛**。Type B 通过 $l \le l^*_0$ 回避的不仅是走廊夹击本身，还包括走廊的方向惩罚。下方命题 7.1 的四条消解因此获得了更强的对比背景。

**命题 7.1（Type B 平庸消解，Mediocrity Dissolution under Type B）**：设 IDFS $\mathcal{F} = (F, \sigma)$ 在 $l \le l^*_0$ 条件下运行。则 §7.1 完美即平庸定理的四重结构性缺陷**全部消解**：

(i) **误差可控但非瓶颈**：CAC 上界 $\varepsilon^*_q \le E \cdot \Lambda_l \le \tau$ 仍成立，但 $\tau$ 可通过调节 $l^*_0 = \tau/E$（即改变容差预算或单步精度）任意收紧，不受走廊的结构性锁定。

(ii) **输入可感知**：$\bar{L}$ 不被迫趋零。系统端到端的输入分离保持量 $\Theta_{1,l} = \bar{L}^l$ 可为任意正值（包括 $\ge 1$），系统保留对输入空间尺度 $\delta$ 的完整感知能力。

(iii) **无对偶陷阱**：不存在被迫的收缩步（$L_{j^*} < 1$），因此不存在"维持稳定的步骤恰是拟合最差的步骤"这一结构性讽刺。每一步的 $L_j$ 均可自由匹配目标的局部需求。

(iv) **无 Pareto 冲突**：误差代价 $\mathcal{E}(\bar{L})$ 与判别力 $\mathcal{D}(\bar{L})$ 的同向依赖不再受走廊约束。系统可在 $l \le l^*_0$ 的全参数空间内自由优化两者的平衡点。

**证明**：四条均为 §7.1 相应推论的前提验证。推论 6.2 要求 $l > l^*_0$，在 Type B 下为假，故推论 6.2 的结论（$\bar{L} < 1$ 必然）不成立；推论 6.6–6.10 以推论 6.2 为先决条件，链式失效。完美即平庸定理的四重缺陷恰好是推论 6.6–6.10 的聚合，故全部消解。$\square$

> **注（Type B 的"自由度回归"）**：在 §7.1 的长链分析中，系统的核心参数 $\bar{L}$ 被双向夹击至走廊内的一个狭窄区间——这是所有平庸性的数学根源。Type B 通过将链深限制在 $l^*_0$ 以内，从根本上取消了夹击的上半部分（不需要收缩来抑制 CAC 爆炸），使得 $\bar{L}$ 从被囚禁的走廊参数回归为自由设计变量。系统设计者在单段内拥有完整的参数空间来优化性能，代价是单段的逻辑深度被截断。

> **注（方向惩罚的同步消解）**：推论 6.3 的方向不对称性注记揭示，长链走廊实际上是**方向依赖的**——对扩张映射 $r$（$\mathrm{Lip}(r) > 1$），正向链的 $\delta^{fwd}$ 以 $\mathrm{Lip}(r)^n$ 指数增长，CAC 中 $\delta \cdot \Gamma$ 项主导误差累积，使正向走廊比逆向走廊**更窄**。推论 6.8 的对偶陷阱也因此获得方向结构：同一收缩步在正向链中是生存机制，在逆向链中可能成为崩溃触发器。Type B 的 $l \le l^*_0$ 约束不仅消解了走廊本身（命题 7.1 (i)–(iv)），也同步消解了这一方向惩罚——因为方向不对称性是通过 $\delta$ 的**指数级**长链累积发挥作用的，短链中 $\delta$ 的累积被截断在 $\tau$ 以内，方向差异无法发展为指数级的走廊扭曲。

**命题 7.2（CAC 域外项的短链免疫与路由碎裂解放，Short-Chain Immunity of OOD Terms and Routing Liberation）**：设 IDFS $\mathcal{F} = (F, \sigma)$ 在 $l \le l^*_0$ 条件下运行。则 CAC 五项精细界中的两个域外项——目标域外变分 $\rho_j$ 与路由失准惩罚 $\Delta_{\sigma,j}$——相对于长链系统具有质的结构优势：

(i) **$\rho$ 截断免疫**：在 Type B 段内，理想轨道 $h^*_{j-1}$ 偏离采样域 $\mathcal{X}(r_{i_j})$ 的累积漂移被链深截断。由 CAC 递推，中间态偏离的上界满足 $d(h^*_{j-1}, x_0) \leq \sum_{k=1}^{j-1} \|r_{i_k}\|_{lip} \cdot \mathrm{diam}(\mathcal{X}(r_{i_k}))$（理想轨道的总位移），在 $j \le l \le l^*_0$ 步内，该总位移被截断为有限常数。因此每步偏离 $\delta_j = d(h^*_{j-1}, \mathcal{X}(r_{i_j}))$ 不因链深无限增长而发散，采样域偏离的加权总和 $\delta_{max}\Gamma_l \leq \delta_{max} L_{max} \Lambda_l \leq \delta_{max} L_{max} l^*_0$ 恒有限，从而 $\rho_j = d(r_{i_j}(x'_j), r_{i_j}(h^*_{j-1}))$ 受限于目标 $r_{i_j}$ 在有限 $\delta_j$-邻域内的局部振荡模。长链系统中 $\delta_j$ 因指数漂移趋于无穷导致 $\rho_j$ 不可控的灾难性链路，在 Type B 中**不可能发生**。

(ii) **$\Delta_\sigma$ 纯正面解放**：由 §7.2 路由碎裂博弈命题，在长链系统中 $\Delta_\sigma$ 受零和博弈约束——增大 $\Delta_\sigma$ 释放 CAB 应变力的同时，等额消耗 CAC 误差预算 $B_\sigma$。在 Type B 中，由于 $\Lambda_l \leq l \leq l^*_0$（有限常数），CAC 中 $\Delta_{max}\Lambda_l$ 的代价被截断为 $\Delta_{max} \cdot l^*_0$——这是一个**有界常数代价**。因此：

- 增大 $\Delta_\sigma$ 的 CAC 代价仅为 $\Delta_{max} \cdot l^*_0$（不爆炸），而非长链中的 $\Delta_{max} \cdot \bar{L}^l/({\bar{L}-1})$（指数级）；
- 增大 $\Delta_\sigma$ 在 CAB 侧仍全额扩展 $\Omega_1(\rho) = L_{local}\rho + \Delta_{\sigma,\text{max}}$，放宽变分四元张力律 $2\varepsilon_r + L_{local}\rho + \Delta_{\sigma,\text{max}} \geq \Delta$ 对单步拟合残差 $\varepsilon_r$ 的下界约束。

因此 Type B 中 $\Delta_\sigma$ 的**成本-收益比**远优于长链系统：每单位路由碎裂引入的 CAC 误差代价为 $O(l^*_0)$，换取的 CAB 拟合约束放宽为 $\Delta_{\sigma,\text{max}}/2$（推论 4.3 变分下界减半）。

**证明**：

(i) 在 CAC 精细界中，$\delta_j \leq d(h^*_{j-1}, \mathcal{X}(r_{i_j}))$。链深 $l \leq l^*_0$ 限制了理想轨道的总步数。由于每步位移受 $r_{i_j}$ 的局部形变率约束，$\sum_j \delta_j$ 有标准的有限上界。$\rho_j = d(r_{i_j}(x'_j), r_{i_j}(h^*_{j-1}))$ 是 $r_{i_j}$ 在距离不超过 $\delta_j$ 的两点间的输出差异——当 $\delta_j$ 有限（短链截断保证）时，$\rho_j$ 受限于 $r_{i_j}$ 在 $\delta_j$-邻域内的局部振荡特征，不因链深发散。

(ii) CAC 形式 A 中 $\Delta_{max}\Lambda_l$ 项，在 $l \leq l^*_0$ 下 $\Lambda_l \leq \sum_{j=1}^{l^*_0} L_{max}^{l^*_0-j} \leq l^*_0 L_{max}^{l^*_0}$（上界）。当 Type B 选择 $\bar{L} \geq 1$ 时，该上界仍为有限数（因 $l^*_0$ 有限），不随链深趋于无穷。而在 推论 4.3 的单步变分下界 $2\varepsilon_r + L_{local}\rho + \Delta_{\sigma,\text{max}} \geq \Delta$ 中，$\Delta_{\sigma,\text{max}}$ 直接减小 $\varepsilon_r$ 的下界——每增加一单位 $\Delta_{\sigma,\text{max}}$，$\varepsilon_r$ 的最低保证可降低 $1/2$ 单位。$\square$

> **注（Type B 的 $\Delta_\sigma$ 优势与 §7.2 博弈命题的对接）**：§7.2 的路由碎裂博弈命题证明了长链系统中 $\Delta_\sigma$ 是严格的零和资源——为 CAB 释放的应变力等额消耗 CAC 误差预算。Type B 打破了这个零和结构：CAC 侧的代价被 $l^*_0$ 截断为常数，而 CAB 侧的收益（变分下界的松弛）保持不变。$\Delta_\sigma$ 在 Type B 中从"零和博弈的筹码"变为"正和博弈的工具"——这是短链架构相对于长链架构的第五条独立优势（继误差全域有界、采样非指数爆炸、抗劫持鲁棒性、方向惩罚消解之后）。


**命题 7.3（$M$-精度走廊，$M$-Precision Corridor）**：在 Type B 约束下，基函数库规模 $M = |F|$ 同时控制 CAC 上界与 CAB 下界，将系统的段内端到端误差 $\varepsilon^*_q$ 双向约束于一个 $M$-依赖的走廊之中：

$$\varepsilon_{y,out}(M) \;\le\; \varepsilon^*_q \;\le\; \varepsilon_{max}(M) \cdot \Lambda_l + \delta_{max} \cdot \Gamma_l$$

其中上界和下界均为 $M$ 的递减函数：

**(i) 上界侧（$M$ 压低 $\varepsilon_{max}$）**：系统路由 $\sigma$ 将输入空间分割为至多 $|\text{Im}(\sigma)| \le M^{\mathcal{D}}$ 个分区，每个分区内由固定的 $L$-Lipschitz 链服务。分区越多，每个分区的直径越小，段内拟合误差越低。由 §4.2 CPI 定理，在具有 $k$-判别性的目标上实现全局误差 $\varepsilon_{max}$ 所需的最小路由分支数为 $\mathcal{N}(A, 2\varepsilon_{max}/k) / \mathcal{N}(A, \varepsilon_{max}/L)$。反向求解：给定 $M^{\mathcal{D}}$ 条可用路径，可达到的最优拟合精度 $\varepsilon_{max}$ 由以下隐式方程限定——

$$M^{\mathcal{D}} \;\ge\; \frac{\mathcal{N}(A,\; 2\varepsilon_{max}/k)}{\mathcal{N}(A,\; \varepsilon_{max}/L)}$$

$M$ 增大时，左端增长，允许 $\varepsilon_{max}$ 更小（右端覆盖数比对 $\varepsilon_{max}$ 单调递减）。

**(ii) 下界侧（$M$ 压低 $\varepsilon_{y,out}$）**：CAB 定理中的末端结构瓶颈（§4.1）为：

$$\varepsilon_{y,out} \;=\; \min_{f \in F}\; \inf_{h \in \mathcal{X}} d(f(h),\, q(y))$$

由 $\Phi \in \mathrm{Lip}_L$，$\Phi(\mathcal{X})$ 的 $\epsilon$-覆盖数不超过 $\mathcal{N}(\epsilon/L, \mathcal{X})$（命题 2.1）。由于目标像点 $q(y) \in \mathcal{X}$ 与 $\Phi(\mathcal{X}) \subset \mathcal{X}$ 位于同一度量空间中，若以 $N = \mathcal{N}(\rho, \Phi(\mathcal{X}))$ 个半径为 $\rho$ 的球覆盖 $\Phi(\mathcal{X})$，则：

$$\varepsilon_{y,out} \;\le\; d\!\left(q(y),\; \Phi(\mathcal{X})\right) \;\le\; \mathcal{N}^{-1}\!\left(\mathcal{N}(\rho/L, \mathcal{X}),\; \mathcal{X}\right)$$

其中 $\mathcal{N}^{-1}(N, \mathcal{X})$ 为使 $N$ 个球覆盖 $\mathcal{X}$ 所需的最小球半径（即 $\mathcal{N}(\rho, \mathcal{X}) \le N$ 的最小 $\rho$）。$M$ 增大时，可用覆盖球数增多，覆盖半径更小，$\varepsilon_{y,out} \to 0$。

**证明**：上界为 §3 CAC 定理的直接应用。下界为 §4.1 CAB 定理中末端结构瓶颈的直接应用。$M$ 的单调性分别由 CPI 的 $\varepsilon_{max}$ 隐式方程和覆盖数的单调性给出。$\square$

> **注（与 §7.1 $\Theta$-走廊的对偶）**：§7.1 的走廊是 $\bar{L}$ 被 CAC+CAB 双向夹击。此处的 $M$-精度走廊是 $\varepsilon$ 被 CAC+CAB 双向夹击——但夹击的松紧度由 $M$ 调控。$M$ 越大，上界越低（拟合越精），下界也越低（结构瓶颈越小），走廊整体向零收缩。这是 §7.2.2 代偿定律（$M$ 以指数级膨胀换取短链精度）在误差空间中的精确投影——**$M$ 不仅在信息论层面补偿了深度杠杆的丧失，更在度量空间层面同时挤压了 CAC 和 CAB 的边界**。

---

### 7.2 分段复合与离散重置

§7.2.4 证明了 Type B 执行等效深度 $l_{eff} \gg l^*_0$ 的任务时，必须采用分段复合 + 离散重置的双层架构。本节形式化这一架构的数学机制，并推导其误差传播规律。

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

相应地，定义**理想分段链** $q^{(1)}, q^{(2)}, \ldots, q^{(n)}$，其中 $q^{(k)}$ 为第 $k$ 段的理想 $r$-链。理想目标的第 $k$ 段起点为 $x^*_k = q^{(k-1)}(x^*_{k-1})$，即沿理想链**连续推进而不经量化**——理想链的段间传递直接使用上一段的精确终点，不经过码本投影 $\pi$。这一约定确保了 $x^*_{k+1} = q^{(k)}(x^*_k)$ 恒成立，使得段间偏差 $\varepsilon_k = d(\tilde{x}_k, x^*_{k+1})$ 恰好度量了量化重置引入的离散化误差与段内拟合误差的叠加效应。

---

**定理 7.4（误差隔绝，Error Isolation）**：设 Type B 系统 $\Phi$ 的段内误差满足 $\varepsilon^*_{q^{(k)}} \le \tau$（对所有段 $k$ 和所有段内起点 $c \in \mathcal{C}$ 成立）。若码本 $\mathcal{C}$ 满足以下**信道编码条件（Channel Coding Condition）**：

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

**推论 7.5（等效无限深度，Effective Infinite Depth）**：在误差隔绝定理的条件下，分段复合链 $\hat{\Psi}^n$ 可执行任意段数 $n$（等效链深 $l_{eff} = n \cdot l_0$ 任意大），每段误差恒 $\le \tau$。连续链中 CAC 定理所刻画的**跨段乘性误差累积被完全截断**——段内 $\Theta_{1,l_0}$ 的拉伸效应被每次离散重置阻断在段边界处，不向后续段传播。

> **注（信道编码的类比）**：误差隔绝条件 $\tau < \Delta_{\mathcal{C}}/2$ 在结构上与 Shannon 信道编码理论中的**最小距离解码条件**完全对应。码本 $\mathcal{C}$ 扮演"信道码"的角色，$\tau$ 为"信道噪声"，$\Delta_{\mathcal{C}}/2$ 为"纠错半径"。只要噪声不超过纠错半径，解码器（量化映射 $\pi$）必然正确还原发送方（理想链 $q$）的意图。CAC 的指数级误差累积——本质上是"无编码信道的噪声雪崩"——被离散重置这一"逐符号编码"机制彻底阻断。

> **注（与 §7.1 的对比）**：§7.1 证明了连续长链（$l \gg l^*_0$）在 CAC+CAB 夹击下必然陷入平庸。误差隔绝定理揭示了逃逸机制的精确数学条件：不是通过放松 CAC 或 CAB，而是通过在段间插入**拓扑断点**——将连续流形上的乘性误差累积投影至离散码本上的加性（实际上是零）误差传播。物理上，这等价于用**外部记忆**（码本）替代**内部流形**（连续状态）来承载段间的状态传递。

> **注（码本的双重正当性：代数截断与反劫持锚点，与 §7.2.4 的闭环）**：上述两条注记从代数层面和信道编码层面分别解释了码本 $\mathcal{C}$ 为何能截断乘性误差累积。§7.2.4 的反劫持注记揭示了码本的**第三重、也是最深层的功能**——它是一个**反劫持锚点集**。在无重置的连续长链中，中间态 $h_j$ 的累积漂移使其逐步远离初始采样域，不可避免地进入由其他采样对锁定的"他方领地"（命题 5.3 的劫持域）。一旦中间态被劫持，$\Phi$ 在该区域的行为已被另一条规则强制绑定，当前链路的误差发生**离散跳变型崩溃**（§7.2.3 劫持注记的 $\Omega(D)$ 下界），而非连续退化。码本 $\mathcal{C}$ 通过在每段终点将中间态投影回码本元素来**强制阻止链路穿越劫持域的边界**。因此，误差隔绝定理在度量空间层面保证了"误差被截断"，在 $\Phi$ 的行为空间层面保证了"轨线被拉回安全领地"——前者是定量的（误差界），后者是定性的（行为安全性）。两个解释互补而非重复，共同构成了分段复合架构相对于连续长链的**完整优势论证**。

> **注（码本覆盖缺口与隔绝失效，Codebook Coverage Gap and Isolation Failure）**：误差隔绝定理的信道编码条件 $\tau < \Delta_{\mathcal{C}}/2$ 虽引人注目，但其证明中还隐含了一个同等致命的**覆盖条件**——理想终点 $q^{(k)}(x^*_k)$ 到最近码本元素 $c^*_k$ 的距离必须严格满足 $d(q^{(k)}(x^*_k), c^*_k) < \Delta_{\mathcal{C}}/2 - \tau$。此条件要求码本 $\mathcal{C}$ 在目标流形 $\mathcal{X}_{target}$ 上**无覆盖缺口**——即不存在任何目标链终点所落入的区域，使得该区域到最近码本锚点的距离超出 $\Delta_{\mathcal{C}}/2 - \tau$。
>
> 一旦目标流形上出现**覆盖缺口（Coverage Gap）**——某个区域内不存在任何足够接近的码本元素——则该区域内的理想终点 $q^{(k)}(x^*_k)$ 到最近码本锚点的距离 $d(q^{(k)}(x^*_k), c^*_k) \ge \Delta_{\mathcal{C}}/2 - \tau$，三角不等式中的关键严格小于号被击穿：$d(\hat{h}^{(k)}, c^*_k)$ 不再保证小于 $\Delta_{\mathcal{C}}/2$，量化映射 $\pi$ 可能将 $\hat{h}^{(k)}$ 投射至**错误的码本元素** $c' \neq c^*_k$——系统从正确的吸引盆被弹射至完全无关的吸引盆，段间误差从精确归零跳变为 $\Omega(\Delta_{\mathcal{C}})$ 量级的灾难性错位。这不是连续退化，而是**离散跳崖**——与 §7.2.3 的失控域误差发散在机制上完全同构。
>
> 此条件与 推论 7.10 的码本规模下界 $|\mathcal{C}| \ge \mathcal{N}(\eta/2, \mathcal{X}_{target})$ 形成闭环：覆盖缺口的存在等价于 $\mathcal{X}_{target}$ 中存在需要极小 $\eta$ 覆盖的子流形，而码本的实际粒度无法满足这一覆盖需求。因此，误差隔绝定理的两个前提——信道编码条件（$\tau < \Delta_{\mathcal{C}}/2$）与覆盖条件（理想终点到码本的距离 $< \Delta_{\mathcal{C}}/2 - \tau$）——在失效时引发**完全不同的灾难机制**：前者失效导致噪声逐段累积（定理 7.6 的递推退化），后者失效导致量化映射的**离散误判**——段间误差从零到 $\Omega(\Delta_{\mathcal{C}})$ 的跳崖，不经任何渐变中间态。覆盖缺口因此是误差隔绝架构中比噪声超限更为隐蔽、更为致命的失效模式。

---

**定理 7.6（一般段间误差递推，General Inter-Segment Error Recurrence）**：当误差隔绝条件**不满足**时（即 $\tau \ge \Delta_{\mathcal{C}}/2$，或理想终点不落在码本邻域内），设第 $k$ 段的实际起点 $\tilde{x}_{k-1}$ 与理想起点 $x^*_k$ 之间的偏差为 $\varepsilon_{k-1} \triangleq d(\tilde{x}_{k-1}, x^*_k)$（$\varepsilon_0 = 0$）。则段间误差满足递推不等式：

$$\varepsilon_k \;\le\; L^{l_0} \cdot \varepsilon_{k-1} \;+\; \delta_\pi \;+\; \tau$$

其中 $L$ 为系统的全局 Lipschitz 常数（§1.2），$\delta_\pi$ 为量化残差，$\tau$ 为段内 CAC 上界。

**证明**：

第 $k$ 段，实际起点为 $\tilde{x}_{k-1}$，理想起点为 $x^*_k$。由 $\Phi \in \mathrm{Lip}_L(\mathcal{X})$（§1.2 系统要求），$l_0$ 步复合映射满足 $\Phi^{l_0} \in \mathrm{Lip}_{L^{l_0}}(\mathcal{X})$（§1.2 级联扩张定律）。注意此处必须使用全局常数 $L^{l_0}$ 而非路径几何均值 $\bar{L}^{l_0}$：因为 $\tilde{x}_{k-1}$ 与 $x^*_k$ 是两个不同的输入点，路由映射 $\sigma$ 可能对它们做出不同的路由决策，因此两条轨线沿不同路径演化，各自的路径局部 Lipschitz 乘积可能不同。全局 $L^{l_0}$ 是对**任意两点**均成立的统一上界。由此与 CAC 上界：

$$d(\hat{h}^{(k)}, q^{(k)}(x^*_k)) \;\le\; d(\Phi^{l_0}(\tilde{x}_{k-1}), \Phi^{l_0}(x^*_k)) + d(\Phi^{l_0}(x^*_k), q^{(k)}(x^*_k))$$
$$\;\le\; L^{l_0} \cdot \varepsilon_{k-1} \;+\; \tau$$

重置后（由理想链的连续推进约定，$x^*_{k+1} = q^{(k)}(x^*_k)$）：
$$\varepsilon_k \;=\; d(\tilde{x}_k, x^*_{k+1}) \;=\; d(\pi(\hat{h}^{(k)}), q^{(k)}(x^*_k))$$
$$\;\le\; d(\pi(\hat{h}^{(k)}), \hat{h}^{(k)}) + d(\hat{h}^{(k)}, q^{(k)}(x^*_k))$$
$$\;\le\; \delta_\pi + L^{l_0} \cdot \varepsilon_{k-1} + \tau \quad \square$$

**推论 7.7（段间误差的三体制，Three Regimes of Inter-Segment Error）**：记 $\alpha = L^{l_0}$（段内端到端最大拉伸率），$\beta = \delta_\pi + \tau$（段内总噪声）。递推 $\varepsilon_k \le \alpha \varepsilon_{k-1} + \beta$ 给出：

$$\varepsilon_n \;\le\; \begin{cases} \dfrac{\beta}{1 - \alpha} & \text{若 } \alpha < 1 \text{（收敛体制，误差饱和）} \\[8pt] n\beta & \text{若 } \alpha = 1 \text{（临界体制，线性累积）} \\[8pt] \dfrac{\alpha^n - 1}{\alpha - 1}\,\beta & \text{若 } \alpha > 1 \text{（发散体制，指数爆炸）} \end{cases}$$

> **注（三体制与 推论 3.3 的深层对应）**：段间误差递推的三体制在结构上与 推论 3.3（CAC 界的两态行为）精确对偶。CAC 描述的是**段内连续误差**随步数的累积：$\bar{L} < 1$ 时饱和，$\bar{L} \ge 1$ 时爆炸。此处的递推描述的是**段间离散误差**随段数的累积：$L^{l_0} < 1$ 时饱和，$L^{l_0} \ge 1$ 时爆炸。两者的对偶揭示了一条统一原则——**乘性误差传播的稳定性完全由谱半径决定**，无论是连续步的 $\bar{L}$ 还是离散段的 $L^{l_0}$。

> **注（路径感知的更紧界）**：定理 7.6 使用全局 $L^{l_0}$ 以保证对任意路由决策的普适性。在实际应用中，若已知两点 $\tilde{x}_{k-1}$ 与 $x^*_k$ 在 $\varepsilon_{k-1}$ 充分小时沿相同路径被路由（这在段内拟合误差远小于 $\sigma$-决策边界分辨率 $\Delta/L$ 时是合理的假设，见 命题 2.7），则 $L^{l_0}$ 可收紧为路径几何均值 $\bar{L}^{l_0}$，使三体制的分界更为乐观。

> **注（误差隔绝是收敛体制的极限情形）**：当 $\delta_\pi = 0$（完美离散重置将段间偏差精确归零），$\beta = \tau$，且 $\alpha < 1$ 时，饱和误差为 $\tau/(1-\alpha)$。进一步令 $\alpha \to 0$（强收缩段），饱和误差趋于 $\tau$。误差隔绝定理可视为这一极限链的**最强特例**——它不依赖 $\alpha < 1$（不需要段内收缩），而是通过码本条件直接将 $\varepsilon_{k-1}$ 强制归零，从根本上绕过了递推的乘性传播。

---

### 7.3 容量-精度-深度的三元缩放律

§7.2.2 的代偿定律给出了 $M$ 与 $l^*_0$ 的基本关系。§8.2 的误差隔绝定理引入了码本 $\mathcal{C}$ 及其间距 $\Delta_{\mathcal{C}}$ 作为新的约束维度。本节将这些约束统一为一组刻画 Type B 系统工程参数空间的**闭合缩放律**。

**命题 7.8（三元约束统一，Unified Triple Constraint）**：设 Type B 系统需以容差 $\tau$ 逼近目标集 $R$（度量熵 $I_\varepsilon(\mathcal{S})$），且通过分段复合实现等效深度 $l_{eff} = n \cdot l_0$。若要求误差隔绝条件成立，则系统参数必须同时满足：

1. **代偿约束**（§7.2.2）：$\log M \;\ge\; (I_\varepsilon(\mathcal{S}) - \log \mathcal{N}(\varepsilon/L, \mathcal{X})) / l^*_0$；
2. **隔绝约束**（§8.2）：$\Delta_{\mathcal{C}} \;>\; 2\tau$；
3. **覆盖约束**：码本 $\mathcal{C}$ 必须使理想链的每段终点落在某个码本元素的 $(\Delta_{\mathcal{C}}/2 - \tau)$-邻域内。

**推论 7.9（$l^*_0$ 的扩展代价，Depth Extension Cost）**：增大段长 $l^*_0$（以减少代偿定律中 $M$ 的需求）时，有效单步误差上界 $E = \varepsilon_{max} + L_{max}\,\delta_{max}$ 必须满足 $E \le \tau / l^*_0$。然而，$\varepsilon_{max}$ 和 $\delta_{max}$ 存在不可逾越的**物理下限**：$\varepsilon_{max}$ 受限于基函数库 $F$ 的最优逼近精度（即 $\inf_{|F|=M} \varepsilon_{max}$，由目标函数类的逼近理论下界决定），$\delta_{max}$ 受限于训练数据的采集密度与目标函数定义域的覆盖程度。设系统的物理精度底线为 $\varepsilon^{\inf}_{max} > 0$、$\delta^{\inf}_{max} \ge 0$，则**最大可行段长**为：

$$l^*_0 \;\le\; \frac{\tau}{\varepsilon^{\inf}_{max} + L_{max}\,\delta^{\inf}_{max}}$$

此上界不可通过任何工程优化突破——它由系统的微观拟合精度底线（$\varepsilon^{\inf}_{max}$）和采样域覆盖质量底线（$\delta^{\inf}_{max}$）**绝对锁死**。当 $\varepsilon^{\inf}_{max} \to 0$（理想化的无限精度基函数库）时，$l^*_0 \to \infty$，约束消解；但在任何有限系统中，$\varepsilon^{\inf}_{max} > 0$ 确保了段长的有限性。

> **注（三元博弈的工程含义）**：Type B 系统的设计者面对三个可调旋钮：段长 $l^*_0$、基函数库规模 $M$、码本精度 $\Delta_{\mathcal{C}}$。增大 $l^*_0$ 可降低 $M$（代偿约束放松），但要求更精密的微观拟合（$\varepsilon_{max} \downarrow$），同时收紧隔绝约束（$\tau = E \cdot l^*_0$ 虽不变，但 $E$ 降低意味着每步容差更紧）。增大 $|\mathcal{C}|$ 可降低 $\Delta_{\mathcal{C}}$，放松隔绝约束，但增加外部控制环的解码复杂度。这三个旋钮的联合优化构成了 Type B 架构的核心工程问题。

**推论 7.10（码本规模的分辨率下界，Codebook Size Lower Bound）**：若理想链的终点集在 $\mathcal{X}$ 中的分布需要 $\mathcal{N}(\tau, \mathcal{X})$ 个 $\tau$-球覆盖，则为使隔绝约束的"覆盖条件"成立，码本规模必须满足：

$$|\mathcal{C}| \;\ge\; \mathcal{N}\!\left(\frac{\Delta_{\mathcal{C}}}{2} - \tau,\; \mathcal{X}_{target}\right)$$

其中 $\mathcal{X}_{target}$ 为理想链终点的值域。联合隔绝约束 $\Delta_{\mathcal{C}} > 2\tau$，取 $\Delta_{\mathcal{C}} = 2\tau + \eta$（$\eta > 0$ 为裕量），覆盖半径为 $\eta/2$，故：

$$|\mathcal{C}| \;\ge\; \mathcal{N}\!\left(\frac{\eta}{2},\; \mathcal{X}_{target}\right)$$

裕量 $\eta \to 0$ 时码本规模发散，$\eta \gg 0$ 时码本稀疏但覆盖粗糙。这是**离散化精度与码本开销**之间的基本权衡。

> **注（与 §1.1 度量熵的闭环）**：码本规模的下界 $\mathcal{N}(\eta/2, \mathcal{X}_{target})$ 本质上是理想链终点空间的 $(\eta/2)$-覆盖数——即 §1.1 定义的度量熵 $\log \mathcal{N}$ 的指数。这在信息论层面上闭合了一个深层回路：§1.1 的度量熵量化了目标空间的复杂度，命题 2.4 证明路由容量必须覆盖这一复杂度，§7.2.2 将其转化为 $M$ 的下界，而此处将其进一步转化为码本 $\mathcal{C}$ 的下界。**系统在参数空间（$M$）和符号空间（$|\mathcal{C}|$）中承受的最低复杂度，均由同一个度量熵刻度尺统一支配。**
