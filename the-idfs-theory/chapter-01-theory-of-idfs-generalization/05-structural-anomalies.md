## 结构特异性

本章揭示 IDFS 单映射共享架构产生的一系列反直觉结构特异性。所有异常现象共享同一根源：$\Phi$ 是为所有采样对 $(r, \mathcal{X}(r)) \in \mathcal{S}$ 全局共享的单一映射——它在某个区域上被一条采样约束锁定的行为，会对途经该区域的所有链路产生不可预见的副作用。§5.1 从单步的方向不对称性出发（命题 1–2），§5.2 揭示多步组合中这种不对称性如何被放大为灾难性的链路劫持（命题 3），§5.3 上升至系统层面，证明采样集扩增对拟合效果不具有单调性保证（命题 4）。

### 5.1 采样约束的方向不对称性

**命题 1（逆映射逼近的不对称性，Asymmetry of Inverse Approximation）**：设 $r \in R$ 为可逆映射，$(r, \mathcal{X}_r) \in \mathcal{S}$，且 $(r^{-1}, r(\mathcal{X}_r)) \notin \mathcal{S}$。设 IDFS $\mathcal{F} = (F, \sigma)$ 满足 $\sup_{x \in \mathcal{X}_r} d(\Phi(x), r(x)) \leq \varepsilon_r$。

则 $\Phi$ 对 $r^{-1}$ 的逼近误差与 $\varepsilon_r$ **逻辑独立**：存在满足上述条件的 $\Phi \in \mathrm{Lip}_L(\mathcal{X})$，使得

$$\sup_{y \in r(\mathcal{X}_r)} d\bigl(\Phi(y),\, r^{-1}(y)\bigr)$$

可以任意大（与 $\varepsilon_r$ 无约束关系）。

**证明**：由 §1.3，$\varepsilon_r$ 是 $\Phi$ 在 $\mathcal{X}_r$ 上对 $r$ 的局部误差上界——该约束来源于 $(r, \mathcal{X}_r) \in \mathcal{S}$。$r^{-1}$ 的作用域为 $r(\mathcal{X}_r)$；由于 $(r^{-1}, r(\mathcal{X}_r)) \notin \mathcal{S}$，§1.3 对 $\Phi$ 在 $r(\mathcal{X}_r)$ 上的行为不施加任何约束。

构造在一般度量空间 $(\mathcal{X}, d)$ 上进行：设 $\mathcal{X}_r$ 与 $r(\mathcal{X}_r)$ 的间距 $D = d(\mathcal{X}_r, r(\mathcal{X}_r)) > 0$（即 $r$ 将输入域"搬走"，两者不重叠）。由于 $\mathcal{S}$ 仅约束 $\Phi$ 在 $\mathcal{X}_r$ 上的行为（逼近 $r$），$\Phi$ 在 $r(\mathcal{X}_r)$ 上的行为完全自由——只需满足全局 Lipschitz 约束 $L$。当 $D > 0$ 时，$\Phi$ 在 $r(\mathcal{X}_r)$ 上的值与 $\Phi$ 在 $\mathcal{X}_r$ 上的值仅通过 Lipschitz 连续性联系，这允许 $\Phi(y)$（$y \in r(\mathcal{X}_r)$）偏离 $r^{-1}(y)$ 任意远——只要度量空间足够大以容纳目标点。因此存在满足所有采样约束且全局 $\mathrm{Lip}_L$ 的 $\Phi$，使得 $d(\Phi(y), r^{-1}(y))$ 可任意大。$\square$

**示例**：取 $\mathcal{X} = \mathbb{R}$，$\mathcal{X}_r = [0, 1]$，$r(x) = x + D$（$D$ 足够大使两段不重叠），则 $r(\mathcal{X}_r) = [D, D+1]$。定义 $\Phi(x) = x + D + \eta$（$x \in [0, 1]$），$\Phi(y) = y + C$（$y \in [D, D+1]$），之间光滑插值保持全局 Lipschitz。则 $\varepsilon_r = \eta$（$\eta$ 任意小），而 $d(\Phi(y), r^{-1}(y)) = |C + D|$，可取任意大。

> **注（有向性）**：命题 1 的本质是：在不引入互逆采样对的框架下，知识拟合关系在度量空间上是**有向的**——$\Phi$ 拟合 $r$ 与拟合 $r^{-1}$ 是两个独立的约束，前者不蕴含后者。



**命题 2（采样域偏离的逆向不对称性，Asymmetry of Domain Deviation under Inversion）**：设 $r \in R$ 为可逆映射，$(r, \mathcal{X}(r)) \in \mathcal{S}$ 且 $(r^{-1}, r(\mathcal{X}(r))) \in \mathcal{S}$（两个方向均已建立采样约束，$\varepsilon$ 层面的约束对正逆两向均成立）。

记正向链各步采样域偏离为 $\delta_j^{\mathrm{fwd}} \triangleq d(h^*_{j-1},\, \mathcal{X}(r_{i_j}))$，逆向链各步采样域偏离为 $\delta_j^{\mathrm{inv}} \triangleq d(\tilde{h}^*_{j-1},\, r(\mathcal{X}(r_{i_j})))$（$\tilde{h}^*$ 为逆向链的理想轨道）。

则当 $r$ **非等距**时，两个方向的 $\delta$ 累积代价**本质不对称**。设正向 Lipschitz 常数为 $K_{fwd} = \mathrm{Lip}(r)$，逆向 Lipschitz 常数为 $K_{inv} = \mathrm{Lip}(r^{-1})$（一般地 $K_{fwd} \neq 1/K_{inv}$，除非 $r$ 为 bi-Lipschitz 且线性）。则经 $n$ 步迭代后：

- 正向链 $\delta$ 增长率：$\delta_n^{\mathrm{fwd}} \sim K_{fwd}^n$（指数增长）
- 逆向链 $\delta$ 增长率：$\delta_n^{\mathrm{inv}} \sim K_{inv}^{-n}$（$K_{inv} > 1$ 时指数衰减）

两向的 $\delta$ 累积代价的不对称比 $\delta_n^{\mathrm{fwd}} / \delta_n^{\mathrm{inv}} \sim (K_{fwd} \cdot K_{inv})^n$，当 $K_{fwd} \cdot K_{inv} > 1$（即 $r$ 非等距）时，不对称性随链长指数放大。当且仅当 $r$ 为等距映射（$K_{fwd} = K_{inv} = 1$）时，两向 $\delta$ 行为对称。

**示例**：取 $\mathcal{X} = \mathbb{R}$，$\mathcal{X}(r) = [0,1]$，$r(x) = 2x+1$（扩张平移，$K = 2$），则 $r(\mathcal{X}(r)) = [1,3]$，$r^{-1}(y) = (y-1)/2$。取初始输入 $x_0 = 0.5$：

- 正向链第二步理想中间态 $h^*_1 = r(0.5) = 2 \notin [0,1]$，$\delta_2^{\mathrm{fwd}} = d(2, [0,1]) = 1$。
- 逆向链第二步理想中间态 $\tilde{h}^*_1 = r^{-1}(2) = 0.5 \notin [1,3]$，$\delta_2^{\mathrm{inv}} = d(0.5, [1,3]) = 0.5$。

比值 $\delta^{\mathrm{fwd}} / \delta^{\mathrm{inv}} = 2 = K$。经 $n$ 步后比值 $\to K^{2n} = 4^n \to \infty$。$\square$

> **注**：命题 2 表明：命题 1 的有向性来自 $\varepsilon$ 约束的有向性（采样对存在与否），命题 2 的有向性来自 $\delta$ 结构的有向性（理想轨道与采样域的几何关系）——两者独立，互不蕴含。即使通过引入互逆采样对完全消除 $\varepsilon$ 层面的不对称，$\delta$ 层面的不对称仍然存在，其根源是 $r$ 的扩张/压缩率 $\mathrm{Lip}(r)/\mathrm{Lip}(r^{-1})$ 的不对称性——这是 CAC 精细界中 $\delta \cdot \Gamma$ 项引入的不可规避的新自由度。

### 5.2 组合误差的不可消除放大

§5.1 揭示了单步拟合的方向不对称性。本节进一步揭示：即使每个目标规则的单步拟合误差都可以任意小，**多步组合的端到端误差仍然可以被强制放大至任意大**——且此放大不是 CAC 上界的松弛，而是存在构型类使得**所有满足采样约束的 $\Phi$ 都必然遭受**的下界。

**命题 3（采样域劫持，Sampling Domain Hijacking）**：设 IDFS $\mathcal{F} = (F, \sigma)$ 以容差集 $\mathcal{E}$（$\varepsilon_{max} = \max \varepsilon_i$）拟合采样集 $\mathcal{S}$。若存在两个采样对 $(r_A, \mathcal{X}(r_A)),\; (r_B, \mathcal{X}(r_B)) \in \mathcal{S}$ 满足**像域入侵条件**：

$$r_A(\mathcal{X}(r_A)) \;\cap\; \mathcal{X}(r_B) \;\neq\; \emptyset$$

即 $r_A$ 的输出像集与 $r_B$ 的采样域存在重叠。设某条 $f$-链 $q$ 的第一步以 $r_A$ 为目标（从 $x \in \mathcal{X}(r_A)$ 出发），第二步的目标行为为 $r_{target}$。由第一步的采样约束，中间态 $h_1 = \Phi(x)$ 满足 $d(h_1, r_A(x)) \leq \varepsilon_A$。若 $h_1 \in \mathcal{X}(r_B)$（当 $r_A(\mathcal{X}(r_A)) \subseteq \mathcal{X}(r_B)$ 且 $\varepsilon_A$ 足够小时自然成立），则 $\Phi$ 在 $h_1$ 处的行为被 $r_B$ 的采样约束锁定（即 $d(\Phi(h_1), r_B(h_1)) \leq \varepsilon_B$）。

定义像域入侵处的**行为差异**为：

$$\Delta(y) \;\triangleq\; d(r_B(y),\; r_{target}(y)) \qquad y \in r_A(\mathcal{X}(r_A)) \cap \mathcal{X}(r_B)$$

则链 $q$ 在第二步的端到端误差满足下界：

$$d(\Phi(h_1),\; r_{target}(h_1)) \;\geq\; \Delta(h_1) - \varepsilon_B$$

**证明**：由三角不等式直接得到：
$$d(\Phi(h_1), r_{target}(h_1)) \;\geq\; d(r_B(h_1), r_{target}(h_1)) - d(\Phi(h_1), r_B(h_1)) \;\geq\; \Delta(h_1) - \varepsilon_B$$
第二个不等式来自 $h_1 \in \mathcal{X}(r_B)$ 时的采样约束 $d(\Phi(h_1), r_B(h_1)) \leq \varepsilon_B$。$\square$

> **注（劫持机制的一般性）**：此命题揭示了 IDFS 单映射共享架构的结构性困境：**$\Phi$ 在 $\mathcal{X}(r_B)$ 上的行为被 $r_B$ 的采样约束全局锁定，但途经该区域的链路 $q$ 需要 $\Phi$ 在此处执行完全不同的行为 $r_{target}$**。行为差异 $\Delta$ 越大，劫持越严重——且 $\Delta$ 完全由采样集 $\mathcal{S}$ 的几何构型决定，与 $\varepsilon$ 无关。这不是 CAC 上界的松弛，而是**不可消除的结构性下界**。

> **注（与 CAC 上界的一致性）**：劫持下界 $\Delta - \varepsilon_B$ 并不违反 CAC 定理。在劫持构型中，链 $q$ 的第 2 步理想中间态 $h^*_1 = r_A(x)$ 通常不在 $r_{target}$ 的采样域 $\mathcal{X}(r_{target})$ 内，故 CAC 五项精细界中的多个域外项均可被触发：采样域偏离 $\delta_2 = d(h^*_1, \mathcal{X}(r_{target}))$ 可以任意大，目标域外变分 $\rho_2 = d(r_{target}(x'_2), r_{target}(h^*_1))$ 随之放大，且路由失准惩罚 $\Delta_{\sigma,2}$ 也可能因 $h^*_1$ 远离采样域而被激活——CAC 本身就已预言此类链的误差不可控。命题 3 的贡献是**证明 CAC 的这些域外项在此构型下是紧的**：$\Phi$ 在域外的行为不是"未知"，而是被 $r_B$ **锁定为确定性的错误行为**，使得理论上界被精确变现为下界。

> **注（劫持的高维几何本质：共振子空间拥挤）**：结合 §3.1 中揭示的"同向共面拉伸（Collinear Stretching）"现象，我们可以对域劫持给出更深层的维度解释。在高维空间中，两个随机选择的规则域碰巧发生空间重合的概率本应是测度为零的。劫持之所以在复杂泛化系统中高频发生，正是因为系统**存在主导的正交降维走廊（特征子空间）**。
>
> 不同的逻辑任务如果在底层被路由机制 $\sigma$ 映射到了具备强形变能力的同一个特征走廊内（例如为了追求拟合效率而共享了具备高 Lipschitz 响应的"主轴"），它们在物理上就**被迫在这个低维的共振子空间内发生了强烈的拥挤与踩踏**。这种由于共享高能维度而引发的高维投影重叠，使得本应不相干的独立任务发生剧烈的结构性碰撞（$r_A$ 的像不可避免触及 $r_B$ 的域）。这从底层几何上解释了大规模系统中"任务间干扰"或"灾难性遗忘"的发生机制：它是多任务在向少数共振子空间竞争性投影时，不可避免的物理碰撞代价。

**示例（行为差异的无穷增长）**：在一般度量空间中，$\Delta$ 可以任意大。取 $\mathcal{X} = \mathbb{R}$、$D > 1$，定义：

- $(r_1, [0, 1])$：$r_1(x) = x + D$，$r_1([0,1]) = [D, D+1]$
- $(r_2, [D, D+1])$：$r_2(y) = y - D$，$r_2([D, D+1]) = [0, 1]$

像域入侵：$r_1([0,1]) = [D, D+1] = \mathcal{X}(r_2)$，完全重合。考察链 $q = (r_1, r_1)$（两步均以 $r_1$ 为目标），链目标 $r_{target} = r_1$。

行为差异：$\Delta(y) = d(r_2(y), r_1(y)) = |(y - D) - (y + D)| = 2D$。

由命题 3，链误差 $\geq 2D - \varepsilon$。令 $D \to \infty$，链误差下界 $\to \infty$——**所有单步误差 $\leq \varepsilon$ 的 IDFS，其链误差的下界可以不受 $\varepsilon$ 约束地无穷增长。**

进一步验证：第 1 步后 $h_1 \approx x + D \in [D-\varepsilon, D+1+\varepsilon]$，落入 $\mathcal{X}(r_2)$ 的 $\varepsilon$-邻域。取 $y^* = \mathrm{proj}_{[D,D+1]}(h_1)$，由 Lipschitz 条件和三角不等式：$d(\Phi(h_1), (h_1 - D)) \leq (L+2)\varepsilon$。故 $h_2 \approx h_1 - D \approx x$，而目标值 $r_1(r_1(x)) = x + 2D$，链误差 $\geq 2D - (L+3)\varepsilon$。$\square$

**推论 1（链序的不对称劫持，Directional Asymmetry of Hijacking）**：命题 3 的像域入侵条件是**方向依赖的**——同一组规则的不同链序可以导致一个方向安全通过、另一个方向灾难性劫持。

设 $(r_A, \mathcal{X}_A),\; (r_B, \mathcal{X}_B),\; (r_C, \mathcal{X}_C) \in \mathcal{S}$，满足：

1. **正序安全**：$r_A(\mathcal{X}_A) \subseteq \mathcal{X}_B$，且正序链 $(r_A, r_B)$ 的第 2 步目标 $r_{target} = r_B$——$r_A$ 的输出落入 $r_B$ 的采样域，第 2 步直接被 $r_B$ 服务，行为差异 $\Delta_{fwd} = d(r_B, r_B) = 0$，无劫持。
2. **逆序劫持**：$r_B(\mathcal{X}_B) \cap \mathcal{X}_C \neq \emptyset$，且 $\Delta_{rev}(y) \triangleq d(r_C(y), r_A(y)) \gg 0$——$r_B$ 的输出落入第三方 $r_C$ 的领地，$r_C$ 的行为与逆序链的目标 $r_A$ 严重冲突。

则由命题 3 直接推得：

- 正序链 $(r_A, r_B)$：$\varepsilon^*_{q_{fwd}} \leq O(\varepsilon)$
- 逆序链 $(r_B, r_A)$：$\varepsilon^*_{q_{rev}} \geq \Delta_{rev} - \varepsilon_C$

误差的**方向不对称比** $\varepsilon^*_{q_{rev}} / \varepsilon^*_{q_{fwd}}$ 可达 $\Delta_{rev} / \varepsilon \to \infty$。$\square$

**示例（链序互换导致的灾难性质变）**：取 $\mathcal{X} = \mathbb{R}$、$D > 1$，三个采样对：

- $(r_1, [0, 1])$：$r_1(x) = x + D$
- $(r_2, [D, D+1])$：$r_2(y) = y + D$
- $(r_3, [2D, 2D+1])$：$r_3(z) = z - 2D$（劫持约束）

正序链 $q_A = (r_1, r_2)$：$x \in [0,1] \xrightarrow{r_1} h_1 \approx x+D \in \mathcal{X}(r_2) \xrightarrow{r_2} h_2 \approx x+2D$，目标 $r_2(r_1(x)) = x+2D$，误差 $\leq O(\varepsilon)$。

逆序链 $q_B = (r_2, r_1)$：$y \in [D,D+1] \xrightarrow{r_2} h_1 \approx y+D \in \mathcal{X}(r_3)$，**劫持发生**——$r_3$ 将 $\Phi(h_1)$ 锁定为 $h_1 - 2D \approx y-D$，而目标 $r_1(r_2(y)) = y+2D$，误差 $\approx 3D \gg \varepsilon$。$\square$

**推论 2（变分正交对邻域劫持的缓解，Mitigation of Neighborhood Hijacking via Variational Orthogonality）**：

命题 3 中劫持灾难的硬核条件是：中间态 $h_1$ **落入** $r_B$ 的采样域 $\mathcal{X}(r_B)$ 内——此时 $\Phi(h_1)$ 被采样约束硬性锁定，与 $\sigma$ 的路由选择无关（因为无论 $\sigma$ 选择哪条 $f$-链来计算 $\Phi(h_1)$，最终输出都是唯一的，且必须满足 $d(\Phi(h_1), r_B(h_1)) \leq \varepsilon_B$）。**在采样域绝对重合的情形下，变分正交无法提供任何拯救。**

但在实际系统中，命题 3 示例构造的精确重合是一个**零测度事件**。更常见的情形是：$h_1$ 落在 $\mathcal{X}(r_B)$ 的 $\varepsilon$-**邻域**中，但 $h_1 \notin \mathcal{X}(r_B)$。此时 $\Phi(h_1)$ 不直接受 $r_B$ 的采样约束控制——$\sigma$ 在 $h_1$ 处拥有**路由自由度**。劫持此时退化为**间接劫持**：由 Lipschitz 连续性，$\Phi(h_1)$ 被 $\Phi$ 在 $\mathcal{X}(r_B)$ 上的行为拉偏，拉偏幅度受限于 $L \cdot d(h_1, \mathcal{X}(r_B))$。

在此间隙中，$f$-链正交性（§2.4）提供了**结构性的侧向逃逸**：若 $\sigma$ 在 $h_1$ 处选择的 $f$-链 $q_{transit}$ 与 $r_B$ 在 $\mathcal{X}(r_B)$ 上所激活的 $f$-链 $q_{local}$ **变分正交**（$\mathrm{Cov}_{var}(q_{transit}, q_{local}) = 0$），则 $q_{local}$ 为拟合 $r_B$ 而产生的局部形变，在 $q_{transit}$ 的输出方向上**不产生系统性偏移**。途经链的误差从命题 3 的 $O(\Delta)$（绝对劫持）降至 $O(L\varepsilon)$（Lipschitz 自然传播），劫持被**从灾难性降级为常规误差积累**。

> **注（逃逸的条件与代价）**：侧向逃逸依赖两个前提：(i) $h_1$ 与 $\mathcal{X}(r_B)$ 之间存在非零间距（$\delta > 0$），为 $\sigma$ 的路由切分提供物理空间；(ii) $Im(\sigma)$ 中存在足够多的变分正交 $f$-链可供分配。前者由系统的单步近似精度 $\varepsilon$ 和链路的几何构型决定；后者由 $|F| = M$ 的函数集规模和路径 Lipschitz 跨度 $\kappa_\Phi$（§1.2）共同决定——$M$ 越大、$\kappa_\Phi$ 越高，$F^*$ 中可供动员的变分正交方向越多，系统在邻域间隙中实施"错峰路由"的能力越强。但当 $h_1$ 精确落入采样域（$\delta = 0$）时，逃逸空间归零，命题 3 的绝对劫持不可避免。

### 5.3 采样集扩增的非单调性

经典统计学习的核心信念之一是"更多数据 → 更好泛化"。本节证明：在 IDFS 框架中，这一信念**不成立**。采样集 $\mathcal{S}$ 的扩增对系统的拟合效果不提供单调递增保证，且存在两种结构上独立的扩增模式，其效果截然不同。

**命题 4（采样集扩增的非单调性，Non-Monotonicity of Sampling Set Expansion）**：设 IDFS $\mathcal{F} = (F, \sigma)$ 的系统容量 $(L, M)$ 固定。记 $\mathcal{F}(\mathcal{S}) = \{\Phi \in \mathrm{Lip}_L(\mathcal{X}) : \sup_{x \in \mathcal{X}(r)} d(\Phi(x), r(x)) \leq \varepsilon,\; \forall (r, \mathcal{X}(r)) \in \mathcal{S}\}$ 为满足所有采样约束的可行映射集。设 $\mathrm{cost}(\Phi, T)$ 为 $\Phi$ 在目标任务集 $T$ 上的代价函数（如端到端链误差）。则：

**(i) 可行集的单调收缩**：$\mathcal{S}_1 \subseteq \mathcal{S}_2 \;\Longrightarrow\; \mathcal{F}(\mathcal{S}_1) \supseteq \mathcal{F}(\mathcal{S}_2)$。因此

$$\inf_{\Phi \in \mathcal{F}(\mathcal{S}_1)} \mathrm{cost}(\Phi, T) \;\leq\; \inf_{\Phi \in \mathcal{F}(\mathcal{S}_2)} \mathrm{cost}(\Phi, T)$$

即：在固定系统容量下，$\mathcal{S}$ 的最优可达拟合效果**单调非递增**——只能不变或变差，绝不变好。

**证明**：$\mathcal{S}_2 \supseteq \mathcal{S}_1$ 意味着 $\mathcal{F}(\mathcal{S}_2)$ 需满足的约束是 $\mathcal{F}(\mathcal{S}_1)$ 的超集，故 $\mathcal{F}(\mathcal{S}_2) \subseteq \mathcal{F}(\mathcal{S}_1)$。在更小的集合上取下确界不可能更小。$\square$

**(ii) 两种扩增模式的效果分离**：上述单调收缩对 $\mathcal{S}$ 的任意扩增成立，但其物理后果因扩增模式而异：

**模式 A：域扩增**（$\mathcal{X}(r_i) \to \mathcal{X}'(r_i) \supset \mathcal{X}(r_i)$，同一规则 $r_i$）——在已有规则的采样域上加密或扩展覆盖。

- $\varepsilon$ 效应（负面）：$\Phi$ 必须在更大的区域上精确跟踪 $r_i$，自由度减少，$\varepsilon$ 项可能退化。
- $\delta$ 效应（正面）：途经 $\mathcal{X}'(r_i) \setminus \mathcal{X}(r_i)$ 的链路中间态从"域外"变为"域内"，$\delta$ 项降为 $0$，链路误差可因此显著改善。
- $\rho$ 效应（正面，与 $\delta$ 联动）：当域扩增使 $\delta_j \to 0$ 时，CAC 的目标域外变分 $\rho_j = d(r_{i_j}(x'_j), r_{i_j}(h^*_{j-1})) \to 0$ 也自动归零（因 $x'_j = h^*_{j-1}$ 时 $\rho_j = 0$）。$\rho$ 的消除是 $\delta$ 消除的数学共随，两者联动强化了域扩增的正面收益。
- $\Delta_\sigma$ 效应（正面/中性）：更密的采样覆盖可降低理想轨道点 $h^*_{j-1}$ 与最近采样点 $x'_j$ 跨越路由边界的概率，从而减小 $\Delta^{sam}_j$。但 $\Delta^{err}_j$（由前序累积误差决定）不受域扩增直接影响。
- **净效果不确定**：上述效应**部分对冲**——域扩增压缩了可行集（$\varepsilon$ 负面），但同时填补了链路间隙（$\delta$、$\rho$、$\Delta^{sam}$ 正面）。最终效果取决于系统在扩展区域上的已有行为与 $r_i$ 的吻合程度。由命题 2，$\delta$ 的累积具有方向不对称性（正向 $\sim K^n$ 指数增长，逆向 $\sim K^{-n}$ 指数衰减），因此域扩增的 $\delta$/$\rho$ 联合填补效果本身也是**方向依赖的**——沿链流方向扩展可显著降低 $\delta$ 与 $\rho$，逆链流方向则收益甚微。

**模式 B：采样对追加**（$\mathcal{S} \to \mathcal{S} \cup \{(r_{new}, \mathcal{X}_{new})\}$，全新规则）——引入新的拟合目标。

- $\varepsilon$ 效应（负面）：可行集收缩，与已有规则冲突不可避免（见下推论 3）。
- $\delta$ 效应（负面）：新约束可劫持已有链路（命题 3 机制），使域外链误差从"可能差"变为"必然差"。
- **净效果单调非递增，可严格退化**：新采样对不为任何已有规则填补 $\delta$ 间隙（它只服务 $r_{new}$），却在其采样域上锁死 $\Phi$ 的行为，两个效应同向为负。

**推论 3（训练追加的强制退化，Forced Degradation under Training Augmentation）**：模式 B 的退化不仅是可行集论证的抽象后果，而是存在确定性构型使退化**被强制保证**。此退化有两条结构独立的通道：

(a) **域内直接冲突**：若 $\mathcal{X}_{new} \cap \mathcal{X}(r) \neq \emptyset$ 且 $\Delta(x) = d(r(x), r_{new}(x)) > 0$ 对某些 $x$ 成立，则由三角不等式：

$$\varepsilon_r(x) + \varepsilon_{r_{new}}(x) \;\geq\; \Delta(x) \qquad \forall x \in \mathcal{X}(r) \cap \mathcal{X}_{new}$$

因此 $\max(\varepsilon_r(x),\; \varepsilon_{r_{new}}(x)) \geq \Delta(x)/2$。若系统选择在重叠区优先拟合 $r_{new}$（$\varepsilon_{r_{new}} \leq \varepsilon$），则 $\varepsilon_r(x) \geq \Delta(x) - \varepsilon$。

**构造**：$r(x) = x$，$r_{new}(x) = x + \Delta$ 在同一域 $[0,1]$ 上。追加 $(r_{new}, [0,1])$ 后，$r$ 在重叠区的误差被迫从 $0$ 升至 $\geq \Delta/2$。

(b) **域外链路劫持**：即使 $\mathcal{X}_{new} \cap \mathcal{X}(r) = \emptyset$（域完全不相交），新规则仍可破坏已有规则的**链路性能**——这正是命题 3 的实例化。在 $(r_1, [0,1])$ 的链 $q = (r_1, r_1)$ 原本可以自由运行的构型中，追加 $(r_2, [D, D+1])$ 将 $\Phi$ 在中间态域锁死为错误行为，链误差从 $0$ 升至 $\geq 2D$。

> **注（反直觉的根源）**：在经典统计学习中，训练样本是**信息**——更多信息意味着对目标的更好估计。但在 IDFS 中，采样对是**硬约束**——它不是告知 $\Phi$ 应该如何行动的建议，而是**强制** $\Phi$ 在特定域上锁定为特定行为。每增加一条约束，$\Phi$ 的全局行为自由度被剥夺一分。通道 (a) 是"领地争夺"——新旧规则在同一片土地上强制分占 $\Phi$ 的有限输出空间。通道 (b) 是"远程劫持"——新规则即使在不相干的领地上，也通过 $\Phi$ 的全局共享性，隔空锁死了旧任务的链路行为。两者的共同根源是 IDFS 的**单映射共享架构**：$\Phi$ 是一个为所有采样对服务的全局函数，任何局部约束都有不可预见的全局后果。

