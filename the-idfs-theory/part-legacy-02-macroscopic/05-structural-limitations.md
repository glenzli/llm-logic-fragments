## 采样约束的结构性限制

本章揭示 IDFS 采样约束结构导致的一系列反直觉限制。§5.1 从单步层面出发，证明采样约束的信息量是单向的（命题 5.1），以及 $\delta$ 累积代价的正逆不对称性（命题 5.2）。§5.2 上升至多步链路，揭示共享 $\Phi$ 的域重叠如何引发链路劫持（命题 5.3）。§5.3 从系统层面证明采样集扩增对拟合效果不具有单调性保证（命题 5.4–5.5）。

### 5.1 采样约束的单向性

**命题 5.1（采样约束的单向性，Unidirectionality of Sampling Constraints）**：设 $r \in R$ 为可逆映射，$(r, \mathcal{X}_r) \in \mathcal{S}$，且 $(r^{-1}, r(\mathcal{X}_r)) \notin \mathcal{S}$。设 IDFS $\mathcal{F} = (F, \sigma)$ 满足 $\sup_{x \in \mathcal{X}_r} d(\Phi(x), r(x)) \leq \varepsilon_r$。记 $\mathcal{Y} \triangleq r(\mathcal{X}_r) \setminus \mathcal{X}_r$，设 $\mathcal{Y} \neq \emptyset$。

则在 $\mathcal{Y}$ 上，IDFS 的采样约束结构**不保证**正向拟合质量 $\varepsilon_r$ 蕴含逆向拟合质量。具体地：

**(i)（结构性沉默）**：采样约束 $(r, \mathcal{X}_r)$ 的作用域为 $\mathcal{X}_r$，对 $y \in \mathcal{Y}$ 结构性沉默——逆向误差由系统的其他因素决定。

**(ii)（全称下界）**：设 $L < \infty$。若存在 $y_0 \in \mathcal{Y}$ 使得（记 $x_0 \in \mathcal{X}_r$ 为距 $y_0$ 最近的点）：

$$d(r(x_0),\; r^{-1}(y_0)) \;>\; L \cdot d(y_0, x_0) + \varepsilon_r$$

则对**所有**满足采样约束的 $\Phi$，逆向误差在 $y_0$ 处存在**正的全称下界**。

> **注（不保证 ≠ 不可能）**：本命题断言的是 IDFS 的**采样约束结构不提供保证**，而非断言逆向拟合不可能。特定 IDFS 完全可以通过其他机制（如引入互逆采样对 $(r^{-1}, r(\mathcal{X}_r)) \in \mathcal{S}$、路由构型的对称性、或 $\Phi$ 本身的全局结构）实现高质量的双向拟合——但该能力源于系统的额外结构，不由正向采样约束单独蕴含。

**证明**：

**(i)**：§1.3 的采样约束 $(r, \mathcal{X}_r)$ 的作用域为 $\mathcal{X}_r$，对 $y_0 \in \mathcal{Y}$ 结构性沉默——直接由约束的作用域定义推出。

**(ii)**：取 $y_0 \in \mathcal{Y}$，$x_0 \in \mathcal{X}_r$ 为距 $y_0$ 最近的点。任意满足采样约束的 $\Phi$ 须满足 $d(\Phi(x_0), r(x_0)) \leq \varepsilon_r$，结合 Lipschitz 约束：

$$d(\Phi(y_0), r(x_0)) \;\leq\; L \cdot d(y_0, x_0) + \varepsilon_r \qquad \text{（即 $\Phi(y_0) \in B(r(x_0),\; L \cdot d(y_0, x_0) + \varepsilon_r)$）}$$

由三角不等式 $d(r(x_0), r^{-1}(y_0)) \leq d(r(x_0), \Phi(y_0)) + d(\Phi(y_0), r^{-1}(y_0))$，移项：

$$d(\Phi(y_0), r^{-1}(y_0)) \;\geq\; d(r(x_0), r^{-1}(y_0)) - L \cdot d(y_0, x_0) - \varepsilon_r$$

当 $d(r(x_0), r^{-1}(y_0)) > L \cdot d(y_0, x_0) + \varepsilon_r$ 时，右端恒正——$r^{-1}(y_0)$ 落在 Lipschitz 球外部，构成**全称正下界**。$\square$

**示例 (ii)**（全称下界）：取 $r(x) = 10x$ 在 $\mathcal{X}_r = [0, 1]$，系统 $L = 2$。$r(\mathcal{X}_r) = [0, 10]$。在 $y_0 = 5$，$x_0 = 1$：$r(x_0) = 10$，$r^{-1}(y_0) = 0.5$。Lipschitz 球：$B(10,\; 2 \cdot 4 + \varepsilon_r)$，即 $[2 - \varepsilon_r,\; 18 + \varepsilon_r]$。而 $r^{-1}(5) = 0.5 \notin [2 - \varepsilon_r,\; 18 + \varepsilon_r]$（对充分小 $\varepsilon_r$）。全称下界：$d(\Phi(5), 0.5) \geq 1.5 - \varepsilon_r > 0$。

> **注（有向性）**：命题 5.1 的本质是：IDFS 框架中，采样约束的信息量是**有向的**——$(r, \mathcal{X}_r)$ 仅约束 $\Phi$ 在 $\mathcal{X}_r$ 上对 $r$ 的行为，对 $\Phi$ 在其他域上对其他映射（包括 $r^{-1}$）的行为不提供任何推断依据。双向拟合能力是 IDFS 的**额外结构属性**，不是采样约束的逻辑后果。



**命题 5.2（$\delta$ 累积代价的不对称性，Asymmetry of Domain Deviation Cost）**：设 $r \in R$ 为可逆映射，$(r, \mathcal{X}(r)) \in \mathcal{S}$ 且 $(r^{-1}, r(\mathcal{X}(r))) \in \mathcal{S}$（两个方向均已建立采样约束）。

IDFS 的采样约束结构**不保证**正逆链的 $\delta$（采样域偏离）累积代价对称——即使 $\varepsilon$ 层面的约束对正逆两向均成立，正向链与逆向链的 $\delta$ 增长行为可以**本质不对称**。

**证明**（反例族构造）：取 $\mathcal{X} = \mathbb{R}$，$K > 1$，$b > 0$，$r(x) = Kx + b$（$\mathrm{Lip}(r) = K$），$r^{-1}(y) = (y - b)/K$（$\mathrm{Lip}(r^{-1}) = 1/K < 1$）。取 $\mathcal{X}(r) = [0,1]$，$r(\mathcal{X}(r)) = [b, K+b]$，两向采样约束均成立。取 $x_0 = 1$，$r(1) = K + b > 1$，正向轨道第一步即离开 $\mathcal{X}(r)$：

- **正向链**：理想轨道 $h^*_n = r^n(x_0) = K^n x_0 + b \cdot \frac{K^n - 1}{K - 1}$。$K > 1$ 时 $h^*_n = \Theta(K^n)$，$\delta_n^{\mathrm{fwd}} = d(h^*_n, [0,1]) = \Theta(K^n)$（指数增长）。
- **逆向链**：由 $\mathrm{Lip}(r^{-1}) = 1/K < 1$，$r^{-1}$ 为 $\mathbb{R}$ 上的压缩映射，轨道收敛至不动点 $y^* = b/(1-K)$，故 $\delta_n^{\mathrm{inv}} \to d(y^*, r(\mathcal{X}(r)))$（收敛至常数）。

不对称比 $\delta_n^{\mathrm{fwd}} / \delta_n^{\mathrm{inv}} \sim \Omega(K^n)$，随链长指数放大。$K$ 为任意 $> 1$ 的参数，故此反例族覆盖所有扩张率。

**示例**（$K = 2$，$b = 1$）：$r(x) = 2x+1$，$\mathcal{X}(r) = [0,1]$，$r(\mathcal{X}(r)) = [1,3]$。取 $x_0 = 0.5$：正向 $h^*_n = 1.5 \cdot 2^n - 1$，$\delta_n^{\mathrm{fwd}} = 1.5 \cdot 2^n - 2$；逆向不动点 $y^* = -1$，$\delta_n^{\mathrm{inv}} \to 2$。不对称比 $\sim \Omega(2^n)$。$\square$

> **注（不对称性的根源）**：不对称性源于 $r$ 的扩张/压缩率 $\mathrm{Lip}(r) / \mathrm{Lip}(r^{-1})$ 的几何不对称——扩张映射将轨道以指数速率甩出采样域，而其逆映射（压缩）将轨道收敛至不动点，偏离有界。这是 CAC 精细界中 $\delta \cdot \Gamma$ 项引入的不可规避的自由度。等距映射（$\mathrm{Lip}(r) = \mathrm{Lip}(r^{-1}) = 1$）是使两向 $\delta$ 行为对称的唯一情形。

> **注（与命题 5.1 的独立性）**：命题 5.1 的单向性来自采样约束的作用域限制（$\varepsilon$ 层面），命题 5.2 的不对称性来自 $\delta$ 结构的几何有向性——两者独立，互不蕴含。即使通过引入互逆采样对完全消除 $\varepsilon$ 层面的单向性，$\delta$ 层面的不对称仍然存在。

### 5.2 链路劫持

IDFS 的 $\Phi$ 是全局共享的单一映射——它在某个区域上被一条采样约束锁定的行为，会强制覆盖途经该区域的所有链路的目标行为。当链路的中间态落入第三方规则的采样域时，该规则的约束将劫持链路的预期行为，产生与 $\varepsilon$ 无关的误差下界。

**命题 5.3（链路劫持，Chain Hijacking）**：设 $(r_A, \mathcal{X}(r_A)),\; (r_B, \mathcal{X}(r_B)) \in \mathcal{S}$，满足**像域入侵**：$r_A(\mathcal{X}(r_A)) \cap \mathcal{X}(r_B) \neq \emptyset$。若某链路的中间态 $h_1 = \Phi(x) \in \mathcal{X}(r_B)$（$x \in \mathcal{X}(r_A)$），而链路第二步的目标为 $r_{target} \neq r_B$，则：

**(i)（劫持下界）**：

$$d(\Phi(h_1),\; r_{target}(h_1)) \;\geq\; d(r_B(h_1),\; r_{target}(h_1)) - \varepsilon_B$$

误差下界完全由 $\mathcal{S}$ 的几何构型决定，与 $\varepsilon$ 无关。

**(ii)（方向不对称性）**：像域入侵条件是**方向依赖的**——同一组规则的不同链序可以导致一个方向安全通过（$r_{target} = r_B$，$\Delta = 0$）、另一个方向灾难性劫持（$r_{target} \neq r_B$，$\Delta \gg 0$）。

**证明**：(i) $h_1 \in \mathcal{X}(r_B)$ 时 $d(\Phi(h_1), r_B(h_1)) \leq \varepsilon_B$，三角不等式即得。(ii) 由 (i) 直接代入不同链序的 $r_{target}$。$\square$

**示例**：取 $r_1(x) = x + D$（$\mathcal{X}(r_1) = [0,1]$），$r_2(y) = y + D$（$\mathcal{X}(r_2) = [D, D+1]$），$r_3(z) = z - 2D$（$\mathcal{X}(r_3) = [2D, 2D+1]$）。

- **正序** $(r_1, r_2)$：$h_1 \approx x + D \in \mathcal{X}(r_2)$，$r_{target} = r_2 = r_B$——不满足劫持前提（$r_{target} \neq r_B$），链被 $r_2$ 直接服务，误差 $\leq O(\varepsilon)$。
- **逆序** $(r_2, r_1)$：$h_1 \approx y + D \in \mathcal{X}(r_3)$，$r_{target} = r_1$——$r_3$ 劫持，$\Phi(h_1) \approx h_1 - 2D \approx y - D$，而目标 $r_1(h_1) \approx y + 2D$，误差 $\geq 3D - \varepsilon$。

方向不对称比 $\sim D / \varepsilon \to \infty$。$\square$

> **注（与 CAC 的一致性）**：劫持下界不违反 CAC——在劫持构型中，$h_1$ 通常不在 $r_{target}$ 的采样域内，故 CAC 精细界的域外项（$\delta$, $\rho$, $\Delta_\sigma$）均被激活且可任意大。命题 5.3 的贡献是证明这些域外项**被精确变现**：$\Phi$ 在 $r_{target}$ 域外的行为不是"未知"，而是被 $r_B$ 的约束**锁定为确定性的错误行为**。


### 5.3 采样集扩增的非单调性

经典统计学习的核心信念之一是"更多数据 → 更好泛化"。本节证明：在 IDFS 框架中，这一信念**不成立**。采样集 $\mathcal{S}$ 的扩增对系统的拟合效果不提供单调递增保证，且存在两种结构上独立的扩增模式，其效果截然不同。

**命题 5.4（采样集扩增的非单调性，Non-Monotonicity of Sampling Set Expansion）**：设 IDFS $\mathcal{F} = (F, \sigma)$ 的系统容量 $(L, M)$ 固定（$L < \infty$）。记 $\mathcal{F}(\mathcal{S}) = \{\Phi : \sup_{x \in \mathcal{X}(r)} d(\Phi(x), r(x)) \leq \varepsilon_r,\; \forall (r, \mathcal{X}(r)) \in \mathcal{S}\}$ 为满足所有采样约束的可行映射集。设 $\mathrm{cost}(\Phi, T)$ 为 $\Phi$ 在目标任务集 $T$ 上的代价函数（如端到端链误差）。则：

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
- **净效果不确定**：上述效应**部分对冲**——域扩增压缩了可行集（$\varepsilon$ 负面），但同时填补了链路间隙（$\delta$、$\rho$、$\Delta^{sam}$ 正面）。最终效果取决于系统在扩展区域上的已有行为与 $r_i$ 的吻合程度。

**模式 B：采样对追加**（$\mathcal{S} \to \mathcal{S} \cup \{(r_{new}, \mathcal{X}_{new})\}$，全新规则）——引入新的拟合目标。

- $\varepsilon$ 效应（负面）：可行集收缩，与已有规则冲突不可避免（见下推论 5.5）。
- $\delta$ 效应（负面）：新约束可劫持已有链路（命题 5.3 机制），使域外链误差从"可能差"变为"必然差"。
- **净效果单调非递增，可严格退化**：新采样对不为任何已有规则填补 $\delta$ 间隙（它只服务 $r_{new}$），却在其采样域上锁死 $\Phi$ 的行为，两个效应同向为负。

**推论 5.5（训练追加的强制退化，Forced Degradation under Training Augmentation）**：模式 B 的退化不仅是可行集论证的抽象后果，而是存在确定性构型使退化**被强制保证**。此退化有两条结构独立的通道：

(a) **域内直接冲突**：若 $\mathcal{X}_{new} \cap \mathcal{X}(r) \neq \emptyset$ 且 $\Delta(x) = d(r(x), r_{new}(x)) > 0$ 对某些 $x$ 成立，则由三角不等式：

$$\varepsilon_r(x) + \varepsilon_{r_{new}}(x) \;\geq\; \Delta(x) \qquad \forall x \in \mathcal{X}(r) \cap \mathcal{X}_{new}$$

因此 $\max(\varepsilon_r(x),\; \varepsilon_{r_{new}}(x)) \geq \Delta(x)/2$。若系统选择在重叠区优先拟合 $r_{new}$（$\varepsilon_{r_{new}} \leq \varepsilon$），则 $\varepsilon_r(x) \geq \Delta(x) - \varepsilon$。

**构造**：$r(x) = x$，$r_{new}(x) = x + \Delta$ 在同一域 $[0,1]$ 上。追加 $(r_{new}, [0,1])$ 后，$r$ 在重叠区的误差被迫从 $0$ 升至 $\geq \Delta/2$。

(b) **域外链路劫持**：即使 $\mathcal{X}_{new} \cap \mathcal{X}(r) = \emptyset$（域完全不相交），新规则仍可破坏已有规则的**链路性能**——这正是命题 5.3 的实例化。在 $(r_1, [0,1])$（$r_1(x) = x+D$）的链 $q = (r_1, r_1)$ 原本可以自由运行的构型中，追加 $(r_2, [D, D+1])$（$r_2(y) = y-D$）将 $\Phi$ 在中间态域锁死为错误行为，链误差从 $0$ 升至 $\geq 2D - \varepsilon$。

> **注（反直觉的根源）**：在经典统计学习中，训练样本是**信息**——更多样本意味着更好的估计。但在 IDFS 中，采样对是**硬约束**——它强制 $\Phi$ 在特定域上锁定为特定行为。每增加一条约束，$\Phi$ 的全局行为自由度减少。通道 (a) 是域内直接冲突——新旧规则在重叠域上竞争 $\Phi$ 的输出空间。通道 (b) 是域外链路劫持——新规则通过 $\Phi$ 的全局共享性，在远离其采样域的位置锁死了旧任务的链路行为。两者的共同根源是 IDFS 的单映射共享架构：$\Phi$ 是为所有采样对服务的全局函数，任何局部约束都有全局后果。

----
*[IDFS] ⊢ [GLENZLI] ⊢ [Part 02] ⊢ [05-structural-limitations] ⊢ [a97a583d97594a7d]*
