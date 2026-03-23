## 拟合几何

§1 的 $(\tau, \eta)$-三态分类基于 $\sigma$-正则性与 $f$-正则性的正交判据，给出了拟合形态的定义边界。但分类本身不描述每种形态在 $F$-空间中的**内部度量结构**。本节逐一考察三种形态的拟合域 $P_{\tau'}(r)$（§1 定义 1.3）在度量空间 $\mathcal{X}$ 中呈现什么几何形态、具有怎样的稳定性、以及如何响应外部扰动。

### 2.1 几何可观测量

在展开三态的内部几何之前，定义贯穿本节的核心可观测量。

**定义（路由跳变概率，Routing Jump Probability）**：设 $x_0 \in \mathcal{X}$，$\delta > 0$。定义 $\Phi$ 在 $x_0$ 处的**路由跳变概率**为：

$$J_\sigma(x_0, \delta) \;\triangleq\; \Pr_{x' \sim \mathrm{Unif}(B(x_0, \delta))}\!\bigl[\sigma(x') \neq \sigma(x_0)\bigr]$$

即在 $x_0$ 的 $\delta$-球内均匀采样时，路由决策发生改变的概率。$J_\sigma$ 是纯粹基于 $\sigma$ 结构的形态判据，不依赖任何目标规则先验。

> **注（$J_\sigma$ 与 $\mathrm{rad}_\sigma$ 的关系）**：当 $\delta < \mathrm{rad}_\sigma(x_0)$ 时，$B(x_0, \delta)$ 完全落在 $x_0$ 所属的路由分区内部，故 $J_\sigma(x_0, \delta) = 0$。当 $\delta > \mathrm{rad}_\sigma(x_0)$ 时，$J_\sigma > 0$——扰动球跨越了路由边界。在碎裂态中（$\mathrm{rad}_\sigma < \tau$），取 $\delta = \tau$ 即有 $J_\sigma(x_0, \tau) > 0$——量级为 $\tau$ 的扰动足以触发路由跳变。

---

### 2.2 碎裂态的内部几何

碎裂态（$\sigma$-奇异，$\mathrm{rad}_\sigma < \tau$）在三态中呈现最极端的几何结构。其内禀几何本质是路由碎片化：有效分片的内切半径低于系统分辨率 $\tau$，导致 $\tau$-量级的扰动即可触发计算路径跳变。

#### 2.2.1 计算路径歧义（无条件）

**命题 2.1（$\tau$-扰动下的计算路径歧义）**：设 $\Phi$ 在 $\mathcal{X}(r_i)$ 上处于碎裂态（有效 $\sigma$-奇异，$\mathrm{rad}^{eff}_\sigma < \tau$）。则：

(i) **碎片约束**：$P_{\tau'}(r_i)$ 被分解为有效碎片 $\{V_\beta\}$ 内的子集之并，每个子集的直径 $\leq \mathrm{diam}(V_\beta)$。

(ii) **计算歧义**：对任意 $x \in \mathcal{X}(r_i)$ 满足 $\mathrm{rad}_\sigma(x) < \tau$，存在 $x' \in B(x, \tau)$ 使得 $\sigma(x) \neq \sigma(x')$——量级为 $\tau$ 的扰动导致 $\Phi$ 执行不同的 $f$-链。$\Phi$ 的输出差异被 Lipschitz 性限制在 $d(\Phi(x), \Phi(x')) \leq L\tau$，但计算路径已经跳变。

(iii) **链复合断裂**：在多步复合中，步骤 $j$ 的计算路径跳变使后续步骤沿完全不同的 $f$-链序列演化。由于碎片直径 $\leq w$，轨道在下一步即可落入另一碎片，触发级联跳变。

> **注（碎裂态几何的本质）**：碎裂态的内禀几何就是**路由碎片化本身**——有效分片的内切半径低于系统分辨率 $\tau$。拟合域的测度、形状等宏观性质则取决于目标 $r$ 的具体结构。

#### 2.2.2 高变分目标下的窄槽结构

当目标 $r_s$ 满足 co-Lipschitz 条件——即输出对输入变化具有不可退化的响应率——时，碎裂态的拟合域呈现出显著的几何形态。

**定义（目标变分下界）**：设 $r_s$ 在 $P_{\tau'}(r_s)$ 上具有 **co-Lipschitz 下界** $k_s > 0$：

$$d(r_s(x), r_s(y)) \;\geq\; k_s \cdot d(x, y) \quad \forall\, x, y \in P_{\tau'}(r_s)$$

$k_s$ 量化了 $r_s$ 的最低变化率。记 $r_s$ 在 $P_{\tau'}(r_s)$ 上的总变分上界为 $\Delta_s$。

**命题 2.2（离散窄槽定理）**：设 $(r_s, \mathcal{X}(r_s))$ 处于碎裂态，有效碎片最大直径 $w$，$r_s$ 满足 co-Lipschitz 下界 $k_s > 0$、总变分上界 $\Delta_s$。则：

(i) **碎片内约束**：$\mathrm{diam}(P_{\tau'}(r_s) \cap V_\beta) \leq w$。

(ii) **跨碎片伸展受限**：$P_{\tau'}(r_s)$ 中任意两点 $x, y$ 满足 $d(x, y) \leq (\Delta_s + 4\tau')/k_s$。

(iii) **各向异性**：$w / [(\Delta_s + 4\tau')/k_s] \to 0$ as $\mathrm{rad}^{eff}_\sigma \to 0$。

$P_{\tau'}(r_s)$ 的宏观形态是一族极小碎片散布在有界区域中——**离散窄槽（Discrete Narrow Groove）**。

**证明**：(i) 显然。(ii) 取 $P_{\tau'}$ 中两点 $x, y$。由拟合条件与反向三角不等式：$d(\Phi(x), \Phi(y)) > d(r_s(x), r_s(y)) - 2\tau' \geq k_s \cdot d(x,y) - 2\tau'$。又 $d(\Phi(x), \Phi(y)) < \Delta_s + 2\tau'$。联合得 $d(x,y) < (\Delta_s + 4\tau')/k_s$。(iii) $w \to 0$ 而右端有限。$\square$

> **注（窄槽的拓扑图像）**：系统在每个碎片内用该碎片的 $f$-链精确追踪 $r_s$ 的一小段输出，碎片之间由不同的 $f$-链接力完成逐步复现。窄槽的"窄"来自碎片化，"槽"来自 $r_s$ 的高变分将碎片排列在有界跨度内。

#### 2.2.3 自锚定与脱槽

碎裂态在满足迭代不变性时具有一个关键动力学现象：系统在拟合域内部可以逐步自稳定运行，但一旦偏出，不可恢复。

**定义（自锚定链）**：设 $(r_s, \mathcal{X}(r_s))$ 处于碎裂态。定义 $r_s$ 的**自锚定链**为逐步复合序列：$x_0 \in P_{\tau'}(r_s)$，$x_{t+1} = \Phi(x_t)$。

**命题 2.3（槽内自稳定性）**：若 $r_s$ 具有**迭代不变性**——$r_s(x) \in P_{\tau'}(r_s)$ 对所有 $x \in P_{\tau'}(r_s)$ 成立——且 $\tau' < w/2$（$w$ 为碎片直径），则自锚定链在 $P_{\tau'}(r_s)$ 内逐步自稳定：$d(x_{t+1}, r_s(x_t)) \leq \tau'$，$x_{t+1} \in P_{\tau'}(r_s)$。

**证明**：由 $x_t \in P_{\tau'}(r_s)$，$d(\Phi(x_t), r_s(x_t)) < \tau'$。由迭代不变性，$r_s(x_t) \in P_{\tau'}(r_s)$。$\tau' < w/2$ 保证 $x_{t+1} = \Phi(x_t)$ 与 $r_s(x_t)$ 共处于同一碎片连通分量内，故 $x_{t+1} \in P_{\tau'}(r_s)$。归纳即得。$\square$

**命题 2.4（脱槽的不可逆性）**：设自锚定链在第 $t^*$ 步偏出 $P_{\tau'}(r_s)$。则后续步不可能自发回到窄槽。

**证明**：由 §1 命题 1.6（近孤立性），$P_{\tau'}(r_s)$ 与 $\sigma$-正则目标的拟合集交集可忽略。$x_{t^*+1}$ 落入某个 $\sigma$-正则域，后续轨道沿该域演化。回归窄槽需精确穿越至直径 $w \to 0$ 的碎片——$\Phi$ 的 Lipschitz 连续性无法实现此精度。脱槽不可逆。$\square$

---

### 2.3 $\sigma$-正则态的共有几何框架

收缩态与保持态共享 $\sigma$-正则性（$\mathrm{rad}_\sigma \geq \tau$），因此它们在路由层面具有**相同的度量基底**——$\tau$-量级的扰动不会引发路由跳变，$\Phi$ 在每个路由分区 $U_\alpha$ 内部沿一致的 $f$-链运行。二者的分野仅在于 $f$-层面的 $\tau$-保持率 $\varphi$ 是否达到阈值 $\eta$。本节先建立 $\sigma$-正则态共有的几何工具，再分别考察两个体制下的表现。

#### 2.3.1 $\tau$-纤维与 $\tau$-洁净集（对偶结构）

在 $\sigma$-正则的路由分区 $U_\alpha$ 内，$\Phi$ 的 $\tau$-尺度行为可通过两个互补集合来刻画。

**定义（$\tau$-坍缩集与 $\tau$-洁净集）**：设 $U_\alpha$ 为路由分区。

- **$\tau$-坍缩集**：$C_\tau(U_\alpha) = \{x \in U_\alpha : \exists\, y \in U_\alpha,\; d(x,y) \geq \tau,\; d(\Phi(x), \Phi(y)) < \tau\}$

- **$\tau$-洁净集**：$U_\alpha^{clean} = U_\alpha \setminus C_\tau(U_\alpha) = \{x \in U_\alpha : \forall\, y \in U_\alpha,\; d(x,y) \geq \tau \Rightarrow d(\Phi(x), \Phi(y)) \geq \tau\}$

$C_\tau$ 中的点存在某个 $\tau$-远的伙伴被映到 $\tau$-近处——信号被局部坍缩。$U_\alpha^{clean}$ 中的点在**所有 $\tau$-远方向**上保持可区分性。二者互补，$\mu(C_\tau) + \mu(U_\alpha^{clean}) = \mu(U_\alpha)$。

$\varphi_\alpha = \mu(U_\alpha^{clean}) / \mu(U_\alpha)$ 即§1 中定义的 $\tau$-保持率。阈值 $\eta$ 将 $\sigma$-正则域分为两个体制：$\varphi < \eta$（坍缩主导）和 $\varphi \geq \eta$（洁净主导）。

**定义（$\tau$-纤维）**：设 $z \in \Phi(U_\alpha)$。定义 $z$ 的 **$\tau$-纤维** 为：

$$F_\tau(z) \;\triangleq\; \{x \in U_\alpha : d(\Phi(x), z) < \tau\}$$

$\tau$-纤维是 $\Phi$ 在 $\tau$-分辨率下的等价类——同一纤维内的所有输入在输出端不可区分。

#### 2.3.2 复合稳定半径

**定义（复合稳定半径）**：设 $\Phi^l$ 为 $l$ 步复合，$\varepsilon^*_q$ 为第一章 §3 CAC 定理给出的宏观容差上界。定义**复合稳定半径** $\rho_l$ 为满足以下条件的最大 $\rho$：对 $x_0 \in P_{\tau'}(r_i)$，$\rho$-扰动后 $l$ 步复合的总误差仍 $\leq \tau'$。

**命题 2.5（复合稳定半径）**：

$$\rho_l \;\geq\; \frac{\tau' - \varepsilon^*_q}{L^l}$$

其中 $\varepsilon^*_q \leq (\varepsilon_{max} + \rho_{max} + \Delta_{max})\Lambda_l + \delta_{max}\Gamma_l$（第一章 §3 CAC 上界）。当 $\varepsilon^*_q < \tau'$ 时，$\rho_l > 0$。

**证明**：对 $x_0 \in P_{\tau'}(r_i)$，做 $\rho$-扰动得 $x_0'$。$l$ 步复合后：$d(\Phi^l(x_0'), \Phi^l(x_0)) \leq L^l \cdot \rho$（Lipschitz）。$\Phi^l(x_0)$ 自身与理想输出的距离 $\leq \varepsilon^*_q$（CAC 上界）。三角不等式：总误差 $\leq \varepsilon^*_q + L^l \cdot \rho \leq \tau'$，解得 $\rho \leq (\tau' - \varepsilon^*_q)/L^l$。$\square$

#### 2.3.3 路由边界带

**命题 2.6（路由边界带）**：设 $r_i, r_j \in R$ 为相邻的 $\sigma$-正则规则，其采样域共享路由边界 $\partial_{ij}$。则 $\partial_{ij}$ 两侧存在宽度 $\leq d(r_i(x_0), r_j(x_0))/L$ 的过渡带，$\Phi$ 在带内被迫以连续方式从服务 $r_i$ 过渡到服务 $r_j$。

**证明**：$\Phi$ 的 $L$-Lipschitz 性约束了输出变化梯度。在边界点 $x_0 \in \partial_{ij}$，$\Phi$ 需在距离 $\leq w$ 内从 $r_i(x_0)$ 附近过渡到 $r_j(x_0)$ 附近。由 Lipschitz 性：$d(r_i(x_0), r_j(x_0)) \leq L \cdot w$，解得 $w \geq d(r_i(x_0), r_j(x_0))/L$。$\square$

---

以上三个结构（$\tau$-纤维/洁净对偶、复合稳定半径、路由边界带）是所有 $\sigma$-正则态的共有几何工具。$\varphi$ 在阈值 $\eta$ 处将这些工具的表现分裂为两个截然不同的体制。

---

#### 2.3.4 收缩体制（$\varphi < \eta$）：坍缩主导

当 $\varphi_\alpha < \eta$ 时，$C_\tau$ 占据 $U_\alpha$ 的主导比例（$\geq 1 - \eta$），$\Phi$ 在 $U_\alpha$ 内的行为以 $\tau$-坍缩为主。

**命题 2.7（$\tau$-纤维集中定理）**：设 $\varphi_\alpha < \eta$。则 $U_\alpha$ 中至少比例 $1 - \eta$ 的输入属于胖纤维——存在同一 $\tau$-纤维内间距 $\geq \tau$ 的点对：

$$\mu(C_\tau(U_\alpha)) \;\geq\; (1 - \eta) \cdot \mu(U_\alpha)$$

**证明**：由 $\varphi_\alpha = 1 - \mu(C_\tau)/\mu(U_\alpha) < \eta$ 直接得 $\mu(C_\tau) > (1 - \eta) \cdot \mu(U_\alpha)$。对每个 $x \in C_\tau$，存在 $y$ 满足 $d(x,y) \geq \tau$ 但 $d(\Phi(x), \Phi(y)) < \tau$，即 $x, y$ 属于同一 $\tau$-纤维 $F_\tau(\Phi(x))$，且在纤维内间距 $\geq \tau$。$\square$

> **注（收缩态的几何图像）**：收缩态的内部几何是一族**粗纤维的铺砌**——$U_\alpha$ 被若干直径 $\geq \tau$ 的纤维覆盖，每根纤维内的输入虽然在度量上可区分，但 $\Phi$ 将它们映到直径 $< \tau$ 的输出簇中。

> **推论（差分截断）**：由命题 2.7，收缩步将至少 $1 - \eta$ 比例的 $\tau$-可区分输入对映射为 $\tau$-不可区分的输出对。下游步骤收到的有效输入多样性已被预先削减。

**命题 2.8（收缩态的信息不可逆丧失）**：设链中步骤 $j$ 处于收缩体制，步骤 $j+1, \ldots, j+k$ 均处于保持体制（$\varphi_{min} \geq \eta$）。则后续保持步**无法恢复**步骤 $j$ 丧失的 $\tau$-可区分信息。

**证明**：步骤 $j$ 坍缩的输入对 $(x, y)$ 满足 $d(\Phi_j(x), \Phi_j(y)) < \tau$。步骤 $j+1$ 以 $\tau$ 为分辨率，无法将 $\Phi_j(x)$ 与 $\Phi_j(y)$ 区分开。保持态保证 $\geq \tau$ 的差异不被坍缩，但不能将 $< \tau$ 的差异膨胀回 $\geq \tau$。$\square$

> **注（$\rho_l$ 在收缩体制下的地位）**：复合稳定半径 $\rho_l$ 在收缩体制下可以为正（路由稳定，Lipschitz 界仍约束扰动传播），但链的有效性已被 $\tau$-信息坍缩预先消解——$\rho_l > 0$ 只意味着"扰动不会让误差进一步恶化"，不意味着链在携带有用信号。

---

#### 2.3.5 保持体制（$\varphi \geq \eta$）：洁净主导

当 $\varphi_\alpha \geq \eta$ 时，$U_\alpha^{clean}$ 占据主导比例（$\geq \eta$），$\Phi$ 在 $U_\alpha$ 内的行为以 $\tau$-保持为主。

**命题 2.9（$\tau$-洁净集的全方向保持）**：设 $\varphi_\alpha \geq \eta$。则 $\mu(U_\alpha^{clean}) \geq \eta \cdot \mu(U_\alpha)$。对洁净集中的每个点 $x$，$\Phi$ 在 $\tau$-尺度上保持**所有方向**的可区分性。

**证明**：由 $\varphi_\alpha \geq \eta$ 直接得 $\mu(U_\alpha^{clean}) \geq \eta \cdot \mu(U_\alpha)$。$\tau$-洁净的定义直接保证全方向保持。$\square$

> **注（$\rho_l$ 在保持体制下的地位）**：这是 $\rho_l$ 唯一有物理意义的体制——路由稳定（$\sigma$-正则）且信号保持（$\varphi \geq \eta$），复合稳定半径给出了 $l$ 步链对初始扰动的真实容忍界。$\rho_l$ 随 $l$ 以 $L^{-l}$ 指数衰减，在 Type B 约束 $l \leq l^*_0$ 下保持为正。

> **注（多步 $\tau$-保持率的衰减条件）**：每步保持态至多将 $1 - \eta$ 比例的信号坍缩。直觉上 $l$ 步后存活比例至多 $\eta^l$。但严格的 $\eta^l$ 乘积界要求每步的坍缩集与前一步的洁净像"测度相容"——即前一步的洁净像在下一步的路由分区中不会过度集中于坍缩区域。当步骤之间的坍缩集无特殊关联时，$\eta^l$ 成立。在缺乏此条件时，只能依赖单步界（命题 2.9）和 Lipschitz 界（命题 2.5）分别约束。

---

### 2.4 三态几何的统一画像

§2.2–§2.3 分别推导了三态的内部几何。以下将三者在度量结构上统一对比。

| 形态 | 路由稳定性 | $P_{\tau'}$ 拓扑 | $\varphi$ | $\rho_l$ | 特有结构 |
|---|---|---|---|---|---|
| **碎裂态** | $\mathrm{rad}_\sigma < \tau$ | 离散碎片链 | （不约束） | 无意义（链断裂） | 窄槽（命题 2.2）、脱槽不可逆（命题 2.4） |
| **收缩态** | $\mathrm{rad}_\sigma \geq \tau$ | $\tau$-坍缩域 | $< \eta$ | 可正但信号已退化 | 胖纤维铺砌（命题 2.7）、信息漏斗（命题 2.8） |
| **保持态** | $\mathrm{rad}_\sigma \geq \tau$ | 宽域 | $\geq \eta$ | $(\tau' - \varepsilon^*_q)/L^l$，正 | 洁净集全方向保持（命题 2.9） |

----
*[IDFS] ⊢ [GLENZLI] ⊢ [Part XX] ⊢ [02-fitting-geometry] ⊢ [2987ac5fac2ce84c]*
