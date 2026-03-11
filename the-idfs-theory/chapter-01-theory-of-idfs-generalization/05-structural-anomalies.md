## 结构特异性

本章揭示 IDFS 单映射共享架构产生的一系列反直觉结构特异性。所有异常现象共享同一根源：$\Phi$ 是为所有采样对 $(r, \mathcal{X}(r)) \in \mathcal{S}$ 全局共享的单一映射——它在某个区域上被一条采样约束锁定的行为，会对途经该区域的所有链路产生不可预见的副作用。§5.1 从单步的方向不对称性出发（命题 1–2），§5.2 揭示多步组合中这种不对称性如何被放大为灾难性的链路劫持（命题 3），§5.3 上升至系统层面，证明采样集扩增对拟合效果不具有单调性保证（命题 4）。

### 5.1 采样约束的方向不对称性

**命题 1（逆映射逼近的不对称性，Asymmetry of Inverse Approximation）**：设 $r \in R$ 为可逆映射，$(r, \mathcal{X}_r) \in \mathcal{S}$，且 $(r^{-1}, r(\mathcal{X}_r)) \notin \mathcal{S}$。设 IDFS $\mathcal{F} = (F, \sigma)$ 满足 $\sup_{x \in \mathcal{X}_r} d(\Phi(x), r(x)) \leq \varepsilon_r$。

则 $\Phi$ 对 $r^{-1}$ 的逼近误差与 $\varepsilon_r$ **逻辑独立**：存在满足上述条件的 $\Phi \in \mathrm{Lip}_L(\mathcal{X})$，使得

$$\sup_{y \in r(\mathcal{X}_r)} d\bigl(\Phi(y),\, r^{-1}(y)\bigr)$$

可以任意大（与 $\varepsilon_r$ 无约束关系）。

**证明**：由 §1.3，$\varepsilon_r$ 是 $\Phi$ 在 $\mathcal{X}_r$ 上对 $r$ 的局部误差上界——该约束的成立来源是 $(r, \mathcal{X}_r) \in \mathcal{S}$。$r^{-1}$ 的作用域为 $r(\mathcal{X}_r)$；由于 $(r^{-1}, r(\mathcal{X}_r)) \notin \mathcal{S}$，§1.3 对 $\Phi$ 在 $r(\mathcal{X}_r)$ 上的行为不施加任何约束。

**构造**：取 $\mathcal{X} = \mathbb{R}$，$\mathcal{X}_r = [0, 1]$，$r(x) = x + D$（$D$ 足够大使两段不重叠），则 $r^{-1}(y) = y - D$，$r(\mathcal{X}_r) = [D, D+1]$。定义
$$\Phi(x) = \begin{cases} x + D + \eta & x \in [0, 1] \\ x + C & x \in [D, D+1] \end{cases}$$
之间光滑插值保持全局 Lipschitz。则 $\varepsilon_r = \eta$（$\eta$ 任意小），而对 $y \in [D, D+1]$：$d(\Phi(y), r^{-1}(y)) = |y + C - (y - D)| = |C + D|$，可取任意大。$\square$

> **注（有向性）**：命题 1 的本质是：在不引入互逆采样对的框架下，知识拟合关系在度量空间上是**有向的**——$\Phi$ 拟合 $r$ 与拟合 $r^{-1}$ 是两个独立的约束，前者不蕴含后者。



**命题 2（采样域偏离的逆向不对称性，Asymmetry of Domain Deviation under Inversion）**：设 $r \in R$ 为可逆映射，$(r, \mathcal{X}(r)) \in \mathcal{S}$ 且 $(r^{-1}, r(\mathcal{X}(r))) \in \mathcal{S}$（两个方向均已建立采样约束，$\varepsilon$ 层面的约束对正逆两向均成立）。

记正向链各步采样域偏离为 $\delta_j^{\mathrm{fwd}} \triangleq d(h^*_{j-1},\, \mathcal{X}(r_{i_j}))$，逆向链各步采样域偏离为 $\delta_j^{\mathrm{inv}} \triangleq d(\tilde{h}^*_{j-1},\, r(\mathcal{X}(r_{i_j})))$（$\tilde{h}^*$ 为逆向链的理想轨道）。

则**两个方向的 $\delta$ 代价逻辑独立**：存在满足上述条件的 IDFS $(F,\sigma)$ 和 $r$，以及**同一初始输入** $x_0$，使得

$$\delta_1^{\mathrm{fwd}}(x_0) \;=\; 0 \qquad \text{而} \qquad \delta_1^{\mathrm{inv}}(r(x_0))$$

可以任意大——即使两个方向的单步近似误差均受控，$\delta$ 层面的不对称性不可消除。

**证明（构造）**：取 $\mathcal{X} = \mathbb{R}$，$\mathcal{X}(r) = [0,1]$，$r(x) = 2x+1$（扩张平移），则 $\mathcal{X}(r^{-1}) = r([0,1]) = [1,3]$，$r^{-1}(y) = (y-1)/2$。两个采样对均加入 $\mathcal{S}$，$\varepsilon$ 约束对两向均成立。

取初始输入 $x_0 = 0.5 \in [0,1] = \mathcal{X}(r)$。

**正向链**（以 $r$ 为目标）：$h^*_0 = x_0 = 0.5 \in [0,1]$，故 $\delta_1^{\mathrm{fwd}} = d(0.5,\,[0,1]) = 0$。

**逆向链**（以 $r^{-1}$ 为目标，从 $r(x_0) = 2$ 出发）：理想轨道为 $\tilde{h}^*_0 = r(x_0) = 2 \in [1,3]$，则 $\delta_1^{\mathrm{inv}} = d(2,\,[1,3]) = 0$。

此时两向均为零——但现在考察**第二步**。正向链第二步的理想中间态 $h^*_1 = r(0.5) = 2$，若第二步仍用 $r$ 则 $h^*_1 = 2 \in [0,1]$？不——$h^*_1 = 2 \notin [0,1]$，所以 $\delta_2^{\mathrm{fwd}} = d(2, [0,1]) = 1$。逆向链第二步的理想中间态 $\tilde{h}^*_1 = r^{-1}(2) = 0.5$，若第二步仍用 $r^{-1}$ 则 $\tilde{h}^*_1 = 0.5 \in [1,3]$？不——$0.5 \notin [1,3]$，所以 $\delta_2^{\mathrm{inv}} = d(0.5, [1,3]) = 0.5$。

两向均有偏离，但幅度不同（$1$ vs $0.5$）。更极端的不对称来自 $r$ 的**扩张率**：$r$ 将 $[0,1]$ 拉伸为 $[1,3]$（长度加倍），而 $r^{-1}$ 将 $[1,3]$ 压缩为 $[0,1]$。因此正向链的理想轨道“逃出”采样域的速度（$\delta_j^{\mathrm{fwd}}$ 的增长率）与逆向链“逃出”采样域的速度（$\delta_j^{\mathrm{inv}}$ 的增长率）由 $r$ 的局部 Lipschitz 常数决定，而 $\mathrm{Lip}(r) \neq \mathrm{Lip}(r^{-1})$（除非 $r$ 为等距映射）。

特别地，若取 $r(x) = Kx + b$（$K > 1$），则经 $n$ 步正向迭代后 $\delta_n^{\mathrm{fwd}} \sim K^n$（指数增长），而逆向迭代 $\delta_n^{\mathrm{inv}} \sim K^{-n}$（指数衰减）。两向的 $\delta$ 累积代价的比值 $\sim K^{2n} \to \infty$，不对称性随链长指数放大。$\square$

> **注**：命题 2 表明：命题 1 的有向性来自 $\varepsilon$ 约束的有向性（采样对存在与否），命题 2 的有向性来自 $\delta$ 结构的有向性（理想轨道与采样域的几何关系）——两者独立，互不蕴含。即使通过引入互逆采样对完全消除 $\varepsilon$ 层面的不对称，$\delta$ 层面的不对称仍然存在，其根源是 $r$ 的扩张/压缩率 $\mathrm{Lip}(r)/\mathrm{Lip}(r^{-1})$ 的不对称性——这是 CAC 精细界中 $\delta \cdot \Gamma$ 项引入的不可规避的新自由度。

### 5.2 组合误差的不可消除放大

§5.1 揭示了单步拟合的方向不对称性。本节进一步揭示：即使每个目标规则的单步拟合误差都可以任意小，**多步组合的端到端误差仍然可以被强制放大至任意大**——且此放大不是 CAC 上界的松弛，而是存在构型类使得**所有满足采样约束的 $\Phi$ 都必然遭受**的下界。

**命题 3（组合误差的强制放大，Forced Composition Error Amplification）**：存在一类采样配置 $\mathcal{S}_D$（以参数 $D > 0$ 索引），使得对**任意** $\Phi \in \mathrm{Lip}_L(\mathcal{X})$，若 $\Phi$ 同时满足 $\mathcal{S}_D$ 中所有采样约束（每条误差 $\leq \varepsilon$），则存在链 $q$ 的端到端误差满足：

$$\varepsilon^*_q \;\geq\; 2D - 2\varepsilon$$

其中 $D$ 可取任意大，$\varepsilon$ 任意小。即：**所有单步误差 $\leq \varepsilon$ 的 IDFS，其链误差的下界可以不受 $\varepsilon$ 约束地无穷增长。**

**构造**：取 $\mathcal{X} = \mathbb{R}$，$D > 1$。定义两个采样对：

- $(r_1,\; [0, 1]) \in \mathcal{S}_D$：$r_1(x) = x + D$（向右平移 $D$），$r_1([0,1]) = [D, D+1]$
- $(r_2,\; [D, D+1]) \in \mathcal{S}_D$：$r_2(y) = y - D$（向左平移 $D$），$r_2([D, D+1]) = [0, 1]$

两个采样域不重叠（$[0,1] \cap [D, D+1] = \emptyset$），采样约束互不冲突。

**证明**：

考察链 $q = (r_1, r_1)$（两步均以 $r_1$ 为目标）。链目标为 $r_1(r_1(x)) = x + 2D$。

**第 1 步**：初始输入 $x \in [0, 1] = \mathcal{X}(r_1)$。由采样约束 $(r_1, [0,1])$：

$$|h_1 - r_1(x)| = |\Phi(x) - (x + D)| \leq \varepsilon$$

故 $h_1 \in [x + D - \varepsilon,\; x + D + \varepsilon] \subseteq [D - \varepsilon,\; D + 1 + \varepsilon]$。

当 $\varepsilon < 1$ 时，$h_1 \in [D - \varepsilon, D + 1 + \varepsilon] \subseteq [D - 1, D + 2]$，特别地 **$h_1$ 落入 $\mathcal{X}(r_2) = [D, D+1]$ 的 $\varepsilon$-邻域内**。

**第 2 步**：$h_1$ 处于 $\mathcal{X}(r_2) = [D, D+1]$ 的 $\varepsilon$-邻域。由采样约束 $(r_2, [D, D+1])$，对 $y \in [D, D+1]$：

$$|\Phi(y) - (y - D)| \leq \varepsilon$$

取 $y^* = \mathrm{proj}_{[D, D+1]}(h_1)$（$h_1$ 在 $[D, D+1]$ 上的投影），则 $|h_1 - y^*| \leq \varepsilon$。由 Lipschitz 条件：

$$|\Phi(h_1) - \Phi(y^*)| \leq L \cdot |h_1 - y^*| \leq L\varepsilon$$

由三角不等式：

$$|\Phi(h_1) - (h_1 - D)| \leq |\Phi(h_1) - \Phi(y^*)| + |\Phi(y^*) - (y^* - D)| + |(y^* - D) - (h_1 - D)|$$
$$\leq L\varepsilon + \varepsilon + \varepsilon = (L + 2)\varepsilon$$

因此 $h_2 = \Phi(h_1) \approx h_1 - D \approx x$（直觉上：$\Phi$ 在 $[D, D+1]$ 附近被 $r_2$ 劫持为"向左平移 $D$"）。

**链误差下界**：

$$\varepsilon^*_q = |h_2 - r_1(r_1(x))| = |h_2 - (x + 2D)|$$

$$\geq |(h_1 - D) - (x + 2D)| - (L+2)\varepsilon$$

$$= |h_1 - x - 3D| - (L+2)\varepsilon$$

由第 1 步，$h_1 \in [x + D - \varepsilon, x + D + \varepsilon]$，故 $|h_1 - x - 3D| \geq 2D - \varepsilon$。因此：

$$\varepsilon^*_q \;\geq\; 2D - (L + 3)\varepsilon$$

对固定 $L$ 和 $\varepsilon$，令 $D \to \infty$，链误差下界 $\to \infty$。$\square$

> **注（劫持机制）**：此命题的核心是**采样域劫持**（Sampling Domain Hijacking）：$r_2$ 的采样约束在 $[D, D+1]$ 上锁死了 $\Phi$ 的行为（强制"向左平移 $D$"），而链 $q = (r_1, r_1)$ 的第 1 步恰好将中间态 $h_1$ 送入 $r_2$ 的领地。$\Phi$ 在 $[D, D+1]$ 上没有自由度去为 $r_1$ 的第 2 步服务——它被一个**与当前链完全无关的**采样约束强行绑架。这是经典逼近论中不存在的现象：在 IDFS 中，$\Phi$ 是被所有采样对**全局共享的**单一映射，一个采样对在某个区域锁定的行为，会对途经该区域的**所有链路**产生不可预见的副作用。

> **注（与 CAC 上界的一致性）**：命题 3 的下界 $2D - O(\varepsilon)$ **并不违反 CAC 定理**——两者完全自洽。在本构型中，链 $q = (r_1, r_1)$ 的第 2 步理想中间态 $h^*_1 = r_1(x) = x + D$，而第 2 步目标 $r_1$ 的采样域为 $\mathcal{X}(r_1) = [0,1]$，故采样域偏离 $\delta_2 = d(h^*_1, \mathcal{X}(r_1)) = x + D - 1 \geq D - 1$。CAC 上界 $\varepsilon^*_q \leq \varepsilon_{\max} \cdot \Lambda_2 + \delta_{\max} \cdot \Gamma_2$ 中的 $\delta_{\max} \geq D - 1$，因此 CAC 本身就已预言了 $\varepsilon^*_q$ 可达 $O(D)$ 量级——CAC 从未承诺此链的误差小。命题 3 的下界 $2D$ 不超过 CAC 的上界 $O(D)$，两者一致。
>
> 命题 3 的真正贡献是**证明 CAC 上界中的 $\delta$ 项在此构型下是紧的（tight）**：不是无害的理论最坏情形松弛，而是**必然被触及的灾难下界**。这源自一个 CAC 未刻画的机制——"采样域劫持"：$\Phi$ 在域外的行为不是"未知"（那仅意味着可能好可能坏），而是**被另一条不相关的采样约束锁定为确定性的错误行为**。

**推论 1（链序的极端不对称性，Extreme Asymmetry of Chain Ordering）**：经典函数复合中交换顺序最多导致数值和性质的变化。但在 IDFS 中，交换两步推理的顺序可以导致端到端误差从可控的 $\mathcal{O}(\varepsilon)$ **质变**为灾难性的发散（且此发散由系统结构强制保证，无法规避）。

**构造证明**：我们在命题 3 的思路上引入三个互不冲突的采样对（$\mathcal{X} = \mathbb{R}, D > 1$）：

- $(r_1, [0, 1])$：$r_1(x) = x + D$
- $(r_2, [D, D+1])$：$r_2(y) = y + D$
- $(r_3, [2D, 2D+1])$：$r_3(z) = z - 2D$（劫持约束）

考虑同一系统 $\Phi$ 在这三个约束下的两步复合，分别考察正序链 $q_A = (r_1, r_2)$ 和逆序链 $q_B = (r_2, r_1)$。

**正序链 $q_A = (r_1, r_2)$**：在初始输入 $x \in [0,1]$ 上运行。
第 1 步目标为 $r_1$，由采样约束 $h_1 = \Phi(x) \approx x+D$（误差 $\leq \varepsilon$）。此中间态落入 $\mathcal{X}(r_2) = [D, D+1]$ 的 $\varepsilon$-邻域。
第 2 步目标为 $r_2$，复用命题 3 的三角不等式论证（投影 $y^* = \mathrm{proj}_{[D,D+1]}(h_1)$，$|h_1 - y^*| \leq \varepsilon$）：$|\Phi(h_1) - (h_1 + D)| \leq (L+2)\varepsilon$。
因此 $h_2 \approx h_1 + D \approx x + 2D$，而目标值 $r_2(r_1(x)) = x+2D$。
**正序误差 $\varepsilon^*_{q_A} \leq (L+3)\varepsilon = \mathcal{O}(\varepsilon)$**（第 1 步误差经 Lipschitz 传播 $\leq L\varepsilon$，加第 2 步近似误差 $(L+2)\varepsilon$，总计 $(2L+2)\varepsilon$；取宽松界 $(L+3)\varepsilon$）。

**逆序链 $q_B = (r_2, r_1)$**：在初始输入 $y \in [D, D+1]$ 上运行。
第 1 步目标为 $r_2$，$h_1 \approx y+D$。此中间态落入 $[2D, 2D+1]$ 的 $\varepsilon$-邻域。
**劫持发生**：第 2 步目标本该是 $r_1$，但 $h_1$ 落入了 $r_3$ 的地盘！系统在 $[2D, 2D+1]$ 附近的行为被强行绑架为 $z \mapsto z - 2D$。因此 $\Phi(h_1) \approx h_1 - 2D \approx y - D$。
而真正的目标值为 $r_1(r_2(y)) = r_1(y+D) = y+2D$。
**逆序误差**：
$$\varepsilon^*_{q_B} = |\Phi(h_1) - (y+2D)| \approx |(y-D) - (y+2D)| = 3D \gg \varepsilon$$

**结论**：在同一个系统中，即使各单步规则完全掌握，仅因调用顺序互换，中间态流形被送入了不相关的"第三方领地"，导致原本完美的推理链彻底崩溃。$\square$

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
- **净效果不确定**：两个效应**对冲**——域扩增既压缩了可行集，又填补了链路间隙。最终效果取决于系统在扩展区域上的已有行为与 $r_i$ 的吻合程度。由命题 2，$\delta$ 的累积具有方向不对称性（正向 $\sim K^n$ 指数增长，逆向 $\sim K^{-n}$ 指数衰减），因此域扩增的 $\delta$ 填补效果本身也是**方向依赖的**——沿链流方向扩展可显著降低 $\delta$，逆链流方向则收益甚微。

**模式 B：采样对追加**（$\mathcal{S} \to \mathcal{S} \cup \{(r_{new}, \mathcal{X}_{new})\}$，全新规则）——引入新的拟合目标。

- $\varepsilon$ 效应（负面）：可行集收缩，与已有规则冲突不可避免（见下推论 2）。
- $\delta$ 效应（负面）：新约束可劫持已有链路（命题 3 机制），使域外链误差从"可能差"变为"必然差"。
- **净效果单调非递增，可严格退化**：新采样对不为任何已有规则填补 $\delta$ 间隙（它只服务 $r_{new}$），却在其采样域上锁死 $\Phi$ 的行为，两个效应同向为负。

**推论 2（训练追加的强制退化，Forced Degradation under Training Augmentation）**：模式 B 的退化不仅是可行集论证的抽象后果，而是存在确定性构型使退化**被强制保证**。此退化有两条结构独立的通道：

(a) **域内直接冲突**：若 $\mathcal{X}_{new} \cap \mathcal{X}(r) \neq \emptyset$ 且 $\Delta(x) = |r(x) - r_{new}(x)| > 0$ 对某些 $x$ 成立，则由三角不等式：

$$\varepsilon_r(x) + \varepsilon_{r_{new}}(x) \;\geq\; \Delta(x) \qquad \forall x \in \mathcal{X}(r) \cap \mathcal{X}_{new}$$

因此 $\max(\varepsilon_r(x),\; \varepsilon_{r_{new}}(x)) \geq \Delta(x)/2$。若系统选择在重叠区优先拟合 $r_{new}$（$\varepsilon_{r_{new}} \leq \varepsilon$），则 $\varepsilon_r(x) \geq \Delta(x) - \varepsilon$。

**构造**：$r(x) = x$，$r_{new}(x) = x + \Delta$ 在同一域 $[0,1]$ 上。追加 $(r_{new}, [0,1])$ 后，$r$ 在重叠区的误差被迫从 $0$ 升至 $\geq \Delta/2$。

(b) **域外链路劫持**：即使 $\mathcal{X}_{new} \cap \mathcal{X}(r) = \emptyset$（域完全不相交），新规则仍可破坏已有规则的**链路性能**——这正是命题 3 的实例化。在 $(r_1, [0,1])$ 的链 $q = (r_1, r_1)$ 原本可以自由运行的构型中，追加 $(r_2, [D, D+1])$ 将 $\Phi$ 在中间态域锁死为错误行为，链误差从 $0$ 升至 $\geq 2D$。

> **注（反直觉的根源）**：在经典统计学习中，训练样本是**信息**——更多信息意味着对目标的更好估计。但在 IDFS 中，采样对是**硬约束**——它不是告知 $\Phi$ 应该如何行动的建议，而是**强制** $\Phi$ 在特定域上锁定为特定行为。每增加一条约束，$\Phi$ 的全局行为自由度被剥夺一分。通道 (a) 是"领地争夺"——新旧规则在同一片土地上强制分占 $\Phi$ 的有限输出空间。通道 (b) 是"远程劫持"——新规则即使在不相干的领地上，也通过 $\Phi$ 的全局共享性，隔空锁死了旧任务的链路行为。两者的共同根源是 IDFS 的**单映射共享架构**：$\Phi$ 是一个为所有采样对服务的全局函数，任何局部约束都有不可预见的全局后果。

