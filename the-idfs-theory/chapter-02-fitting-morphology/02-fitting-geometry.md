## 拟合几何

§1 的三态分类基于 $\sigma$-正则性与谱正则性的正交判据，给出了拟合形态的**定义边界**——域宽、可复合性、拓扑图像。但分类本身不描述每种形态在 $F$-空间中的**内部拓扑结构**。本节逐一考察三种形态的拟合域 $P_\tau(r)$ 在度量空间 $\mathcal{X}$ 中呈现什么几何形态、具有怎样的稳定性、以及如何响应外部扰动。

### 2.1 几何可观测量

在展开三态的内部几何之前，定义贯穿本节的两个核心可观测量。

**定义（局部扰动敏感性，Local Perturbation Sensitivity）**：定义 $\Phi$ 在输入 $x_0$ 处的**局部扰动敏感性**：

$$S(x_0) \;\triangleq\; \limsup_{\delta \to 0} \frac{d(\Phi(x_0 + \delta),\, \Phi(x_0))}{\delta}$$

即 $\Phi$ 在 $x_0$ 处的有效局部 Lipschitz 常数。由 $\Phi$ 全局 $L$-Lipschitz，$S(x_0) \leq L$ 恒成立。在 $\sigma$-分片 $U_\alpha$ 内部，$S(x_0) = \|J(x_0)\| = \sigma_1(J(x_0))$（最大奇异值）。$S(x_0)$ 的值本身**不能区分**三种拟合形态（三态均满足 $S \leq L$），但其**空间不连续性**可以——见 §2.5。

**定义（路由跳变概率，Routing Jump Probability）**：设 $x_0 \in \mathcal{X}$，$\delta > 0$。定义 $\Phi$ 在 $x_0$ 处的**路由跳变概率**为：

$$J_\sigma(x_0, \delta) \;\triangleq\; \Pr_{x' \sim \mathrm{Unif}(B(x_0, \delta))}\!\bigl[\sigma(x') \neq \sigma(x_0)\bigr]$$

即在 $x_0$ 的 $\delta$-球内均匀采样时，路由决策发生改变的概率。$J_\sigma$ 是不依赖任何目标规则先验的、纯粹基于 $\sigma$ 结构的形态判据。

> **注（$J_\sigma$ 与 $\rho_\sigma$ 的关系）**：路由跳变概率 $J_\sigma(x_0, \delta)$ 是 §1 定义 1.1 路由边界密度 $\rho_\sigma$ 的局部化动态版本。$\rho_\sigma$ 是全局的、静态的边界密度；$J_\sigma$ 是逐点的、尺度相关的跳变概率。由 co-area formula，$J_\sigma(x_0, \delta) \approx \rho_\sigma^{local}(x_0) \cdot \delta$（在 $\delta$ 小时的一阶近似），其中 $\rho_\sigma^{local}$ 是 $x_0$ 处的局部边界密度。$\sigma$-奇异等价于 $\rho_\sigma^{local} = \infty$，此时 $J_\sigma \to 1$（$\forall \delta > 0$）。

---

### 2.2 逐字式拟合

逐字式拟合（$\sigma$-奇异）在三态中呈现最极端的几何结构。本小节完整描绘其内部拓扑：离散窄槽形态、碎片尺度约束、以及自锚定-脱槽动力学。

#### 2.2.1 离散窄槽定理

§1 命题 1.3 证明了逐字式拟合（有效 $\sigma$-奇异）的 $\tau$-拟合集 $P_\tau(r_s)$ 的总测度趋于零。本节精细化这一结论，揭示 $P_\tau(r_s)$ 不仅小，而且具有**强各向异性**的内部结构。

**定义（方向性直径，Directional Diameter）**：设 $A \subseteq \mathcal{X}$，$v$ 为 $\mathcal{X}$ 中的一个方向（在一般度量空间中，取 $v$ 为连接 $A$ 内两点的测地线方向）。定义 $A$ 沿 $v$ 方向的**方向性直径**：

$$\mathrm{diam}_v(A) \;\triangleq\; \sup \bigl\{ d(x, y) \;\big|\; x, y \in A,\; (x, y) \text{ 沿 } v \text{ 方向} \bigr\}$$

**定义（目标变分下界，Target Variation Lower Bound）**：设目标映射 $r_s$ 在 $P_\tau(r_s)$ 上沿方向 $v_s$ 具有**变分下界** $k_s > 0$，即对 $P_\tau(r_s)$ 中沿 $v_s$ 方向分离的任意两点 $x, y$：

$$d(r_s(x), r_s(y)) \;\geq\; k_s \cdot d(x, y)$$

$k_s$ 量化了 $r_s$ 作为目标映射沿主变分方向的**最低变化率**。

**命题 1（窄槽的各向异性，Anisotropy of the Narrow Groove）**：设 $(r_s, \mathcal{X}(r_s)) \in \mathcal{S}$ 处于逐字式拟合（$\sigma$-奇异），有效碎片最大直径为 $w$（§1 命题 1.3 定义）。设 $r_s$ 在 $P_\tau(r_s)$ 上沿方向 $v_s$ 具有变分下界 $k_s > 0$，总变分上界 $\Delta_s$。则 $P_\tau(r_s)$ 在每个有效碎片 $V_\beta$ 内的几何形态满足：

(i) **横向压缩**：在任意方向上，$P_\tau(r_s) \cap V_\beta$ 的直径受碎片直径约束：

$$\mathrm{diam}(P_\tau(r_s) \cap V_\beta) \;\leq\; w$$

当 $\rho^{eff}_\sigma \to \infty$ 时，$w \to 0$（§1 命题 1.3 证明 (ii)），每个碎片内的拟合集退化为微小域。

(ii) **纵向伸展受限**：若 $P_\tau(r_s)$ 中存在沿 $v_s$ 方向分离的两点 $x, y$（不必在同一碎片内），其间距受 $r_s$ 的总变分 $\Delta_s$ 与变分下界 $k_s$ 的比值控制：

$$d(x, y) \;\leq\; \frac{\Delta_s + 4\tau}{k_s}$$

(iii) **各向异性比**：横向直径 $w$ 与纵向最大伸展之比为：

$$\frac{w}{(\Delta_s + 4\tau)/k_s} \;\to\; 0 \quad \text{as } \rho^{eff}_\sigma \to \infty$$

即 $P_\tau(r_s)$ 的宏观形态是沿 $v_s$ 方向散布的一族极小碎片——整体构成一条**离散窄槽（Discrete Narrow Groove）**。

**证明**：

(i) $P_\tau(r_s) \cap V_\beta \subseteq V_\beta$，直径不超过 $\mathrm{diam}(V_\beta) \leq w$。

(ii) 取 $P_\tau(r_s)$ 中两点 $x, y$，沿 $v_s$ 方向分离。由追踪条件（$x, y \in P_\tau$）与反向三角不等式，$\Phi$ 在这两点的输出偏差满足下界：

$$d(\Phi(x), \Phi(y)) \;\geq\; d(r_s(x), r_s(y)) - d(\Phi(x), r_s(x)) - d(\Phi(y), r_s(y)) \;>\; d(r_s(x), r_s(y)) - 2\tau$$

由 $r_s$ 沿 $v_s$ 方向的变分下界 $k_s$：$d(r_s(x), r_s(y)) \geq k_s \cdot d(x, y)$。同时，由追踪条件与 $r_s$ 的总变分上界 $\Delta_s$：

$$d(\Phi(x), \Phi(y)) \;\leq\; d(\Phi(x), r_s(x)) + d(r_s(x), r_s(y)) + d(r_s(y), \Phi(y)) \;<\; \Delta_s + 2\tau$$

联合上下界：$k_s \cdot d(x, y) - 2\tau < \Delta_s + 2\tau$，解得 $d(x, y) < (\Delta_s + 4\tau)/k_s$。

> **注（co-Lipschitz 的来源）**：$\Phi$ 的膨胀下界 $d(\Phi(x), \Phi(y)) > k_s \cdot d(x,y) - 2\tau$ 来自**目标 $r_s$ 自身的变分下界 $k_s$**，经追踪条件（反向三角不等式）传导为系统 $\Phi$ 的近似膨胀下界。这不依赖 $\Phi$ 的 Lipschitz 上界（方向相反），而是逐字式拟合特有的结构——$r_s$ 的高变分迫使 $\Phi$ 也剧烈变化。

(iii) 直接取商，$w \to 0$ 而纵向伸展的上界 $(\Delta_s + 4\tau)/k_s$ 有限。$\square$

> **注（窄槽从连续到离散）**：窄槽在新框架下退化为**离散碎片链**——沿 $v_s$ 方向排列的一族尺寸 $\leq w$ 的孤立碎片，总伸展 $\leq (\Delta_s + 4\tau)/k_s$。系统在每个碎片内用该碎片的 $f$-链精确追踪 $r_s$ 的一小段输出，碎片之间由不同的 $f$-链接力完成逐步复现。

#### 2.2.2 碎片尺度的等距约束

§1 命题 1.3 的证明中使用了"有效碎片直径 $w \to 0$"的性质。本节给出 $w$ 与 $\rho^{eff}_\sigma$ 之间的定量关系。

**命题 2（碎片尺度的等距上界，Isoperimetric Fragment Scale Bound）**：设 $\mathcal{X}(r_i) \subseteq \mathbb{R}^d$ 为有界域，$\sigma$ 在其上有效 $\sigma$-奇异，有效分片 $\{V_\beta\}$ 共 $N$ 个。则平均碎片直径满足：

$$\bar{w} \;\triangleq\; \frac{1}{N} \sum_\beta \mathrm{diam}(V_\beta) \;\lesssim\; \left(\frac{\mu(\mathcal{X}(r_i))}{N}\right)^{1/d} \;\sim\; \left(\frac{\mu(\mathcal{X}(r_i))}{\rho^{eff}_\sigma}\right)^{1/(d-1)}$$

当 $\rho^{eff}_\sigma \to \infty$ 时，$\bar{w} \to 0$，速率由维度 $d$ 决定。

**证明思路**：由 isoperimetric inequality，$N$ 个分片在 $d$ 维空间中的平均体积 $\mu(\mathcal{X}(r_i))/N$，对应平均直径 $\sim (\mu/N)^{1/d}$。有效边界密度 $\rho^{eff}_\sigma = \mathcal{H}^{d-1}(\bigcup \partial V) / \mu$，由 isoperimetric inequality 的反向，$\mathcal{H}^{d-1}(\bigcup \partial V) \geq c_d \cdot N \cdot (\mu/N)^{(d-1)/d} = c_d \cdot \mu^{(d-1)/d} \cdot N^{1/d}$。因此 $\rho^{eff}_\sigma \geq c_d \cdot N^{1/d} / \mu^{1/d}$，解得 $N \lesssim (\rho^{eff}_\sigma)^d \cdot \mu$，代入平均直径公式即得。$\square$

> **注（维度的角色）**：$d$ 越高，相同 $\rho^{eff}_\sigma$ 下碎片可以更大（高维空间有更多的"表面积预算"）。当系统的有效状态空间维度 $d$ 很高时，$1/(d-1) \approx 0$，碎片直径对 $\rho^{eff}_\sigma$ 的依赖极弱——需要极高的边界密度才能压低碎片尺度。

#### 2.2.3 自锚定与脱槽

逐字式拟合的关键动力学现象：系统在 $P_\tau(r_s)$ 内部可以**逐步自稳定地运行**，但一旦某步输出偏出窄槽，后续不可恢复。

**定义（自锚定链，Self-Anchoring Chain）**：设 $(r_s, \mathcal{X}(r_s)) \in \mathcal{S}$ 处于逐字式拟合。定义 $r_s$ 的**自锚定链**为长度 $T$ 的逐步复合序列：

$$x_0 \;\in\; P_\tau(r_s), \quad x_{t+1} \;=\; \Phi(x_t), \quad t = 0, 1, \ldots, T-1$$

**命题 3（槽内自稳定性，Intra-Groove Self-Stability）**：若 $\Phi$ 在 $P_\tau(r_s)$ 上满足 $\tau$-拟合条件，且 $r_s$ 具有**迭代不变性**——$r_s(x) \in P_\tau(r_s)$ 对所有 $x \in P_\tau(r_s)$ 成立——则自锚定链在 $P_\tau(r_s)$ 内**逐步自稳定**：

$$d(x_{t+1}, r_s(x_t)) \;\leq\; \tau, \quad x_{t+1} \in P_\tau(r_s) \quad \forall\, t$$

**证明**：由 $x_t \in P_\tau(r_s)$，$d(\Phi(x_t), r_s(x_t)) < \tau$，故 $x_{t+1} = \Phi(x_t)$ 与 $r_s(x_t)$ 的距离 $< \tau$。由迭代不变性，$r_s(x_t) \in P_\tau(r_s)$。若 $\tau$ 足够小使 $x_{t+1}$ 不跌出 $P_\tau(r_s)$ 的碎片连通分量，则 $x_{t+1} \in P_\tau(r_s)$。以 $T$ 步归纳即得。$\square$

> **注（迭代不变性的含义）**：条件 $r_s(x) \in P_\tau(r_s)$ 是 $r_s$ 与 $\Phi$ 的**联合条件**——$P_\tau(r_s)$ 本身由 $\Phi$ 参与定义。该条件等价于 $\Phi(P_\tau(r_s)) \subseteq B_\tau(r_s(P_\tau(r_s))) \subseteq P_\tau(r_s)$，在系统需要反复迭代输出来逼近特定轨迹的场景中自然成立。

**命题 4（脱槽的不可逆性，Irreversibility of Groove Departure）**：设在自锚定链的第 $t^*$ 步，误差使 $x_{t^*+1} \notin P_\tau(r_s)$。则对所有后续步 $t > t^*$，系统不可能自发回到窄槽，除非外部干预。

**证明**：由 §1 命题 1.6（近孤立性），$P_\tau(r_s)$ 与其他规则的 $\tau$-拟合集交集可忽略。$x_{t^*+1}$ 落入某个 $\sigma$-正则域 $\mathcal{X}(r_j)$，后续轨道沿 $r_j$ 的拟合轨迹演化，完全偏离 $r_s$ 的窄槽。回归窄槽需要穿越到碎片直径 $w \to 0$ 的极小域——由第一章 §2 命题 2.14（路由分辨率极限），$\Phi$ 的 Lipschitz 连续性无法将轨道精确引导回该极小域。脱槽是**不可逆的拓扑事件**。$\square$

> **注（与分段复合的结构类比）**：自锚定链是 §7.2 分段复合链的**退化特例**（段长 $l_0 = 1$）。脱槽对应码本覆盖缺口。关键区别：分段复合通过**外部验证**实现重置，逐字式拟合的"自锚定"是系统**内部**的自发行为，无外部纠错——这正是 $\chi_s = 0$ 的动力学诠释。

---

### 2.3 事实式拟合

事实式拟合（$\sigma$-正则 + $J(x)$ 谱退化）在几何上表现为信息维度的不可逆折叠。本小节推导谱退化的直接几何后果。

#### 2.3.1 维度坍缩定理

**命题 5（维度坍缩定理，Dimension Collapse Theorem）**：设 $\Phi$ 在 $\mathcal{X}(r_i)$ 上 $\sigma$-正则且谱退化：$\mathrm{rank}\, J(x) \leq r < d$，$\forall x \in \mathcal{X}(r_i)$。则 $\Phi$ 的像集 $\Phi(\mathcal{X}(r_i))$ 的 Hausdorff 维度满足：

$$\dim_H\!\bigl(\Phi(\mathcal{X}(r_i))\bigr) \;\leq\; r \;<\; d$$

特别地，当 $J(x) \to 0$（所有奇异值趋于零）时，$\Phi(\mathcal{X}(r_i))$ 退化为接近**零维**的点云。

**证明**：$\mathrm{rank}\, J(x) \leq r$ 意味着 $\Phi$ 在 $x$ 的邻域内将 $d$ 维流形映射到 $\leq r$ 维的像。由秩定理，光滑映射的像集维度不超过雅可比的最大秩。在 $\sigma$-正则条件下 $\Phi$ 在每个分片内光滑（由确定的 $f$-链给出），故取分片像集之并，维度不超过 $r$。$\square$

#### 2.3.2 吸收壁的误差截断

**命题 6（吸收壁的误差截断，Error Truncation by Absorbing Wall）**：设链中步骤 $j$ 处于事实式拟合，$\sigma_d(J_j) \leq \eta$（$\eta$ 小）。则从步骤 $j$ 起，链的尾部误差传播被截断：

(i) **切向量压缩**：对任意切向量 $v$：$\|J_j \cdot v\| \leq \eta \|v\|$。经过步骤 $j$ 后，所有方向的微分信号被压缩至 $O(\eta)$。

(ii) **有效传播量**：步骤 $j$ 输出的有效信号幅度仅为 $O(\eta)$，后续步骤的放大因子作用于此微弱信号上，总有效传播量为：

$$\Theta_{j,l} \cdot \|v\| \;\sim\; \eta \cdot L^{l-j} \cdot \|v\|$$

当 $\eta \to 0$ 时，无论后续链多长，有效传播 $\to 0$。

(iii) **链深自动终止**：步骤 $j$ 后的输出是缺乏内部微分结构的"点信号"，下游步骤无法从无方向差分的输入中推导新结论——事实式拟合在链上充当**吸收壁**（§1 定义），有效链深 $l = 1$。

> **注（$\eta$ 的相变）**：$\eta = 0$（完美常值映射）是绝对吸收壁。$\eta > 0$ 时是"泄漏"吸收壁——若 $\eta \cdot L^{l-j}$ 不可忽略，则残余信号仍可在下游被放大。定量条件：$\eta \cdot L^{l-j} \ll \tau$ 时终止有效，否则需将事实步视为逻辑步的退化极限。

---

### 2.4 逻辑式拟合

逻辑式拟合（$\sigma$-正则 + 谱正则）的拟合域 $P_\tau(r_i)$ 在三态中最"温和"——宽域、低曲率、各向同性比接近 $1$。其内部几何没有逐字式的窄槽戏剧性，但有两个**二阶结构**值得推导。

#### 2.4.1 复合稳定半径

**命题 7（复合稳定半径，Composition Stability Radius）**：设 $r_i$ 为逻辑式拟合规则，$q = r_i \circ \cdots \circ r_i$（$l$ 步自复合链）。定义**复合稳定半径** $\rho_l$ 为满足以下条件的最大 $\rho$：对所有 $x \in P_\tau(r_i)$，$B(x, \rho) \cap \mathcal{X} \subset P_\tau(r_i)$，且 $l$ 步复合后误差仍 $\leq \tau$：

$$\rho_l \;\geq\; \frac{\tau - \varepsilon_{max} \cdot \Lambda_l}{L^l}$$

当 $l \leq l^*_0$（Type B 约束）时，分子 $\tau - \varepsilon_{max} \cdot \Lambda_l \geq 0$，复合稳定半径为正。

**证明**：对 $x_0 \in P_\tau(r_i)$，做 $\rho$-扰动得 $x_0' \in B(x_0, \rho)$。$l$ 步复合后：$d(\Phi^l(x_0), \Phi^l(x_0')) \leq L^l \cdot \rho$。$\Phi^l(x_0)$ 自身与理想的距离 $\leq \varepsilon_{max} \cdot \Lambda_l$。要求总误差 $\leq \tau$：$\varepsilon_{max} \cdot \Lambda_l + L^l \cdot \rho \leq \tau$，解得 $\rho \leq (\tau - \varepsilon_{max} \cdot \Lambda_l)/L^l$。$\square$

> **注（稳定半径与链深的对偶）**：$\rho_l$ 随 $l$ 以 $L^{-l}$ 指数衰减——链越长，对初始扰动越敏感。饱和态（$\bar{L} < 1$）下 $\rho_l$ 收敛至正常数；爆炸态（$\bar{L} \geq 1$）下 $\rho_l \to 0$。

#### 2.4.2 路由边界带

**命题 8（路由边界带，Routing Boundary Band）**：设 $r_i, r_j \in R$ 为相邻的逻辑式拟合规则，其采样域共享路由边界 $\partial_{ij}$。则 $\partial_{ij}$ 两侧存在宽度为 $O(\Delta_{ij}/L)$ 的**路由边界带**，在带内 $\Phi$ 的局部行为同时受 $r_i$ 和 $r_j$ 的拟合约束**竞争性影响**：

$$w_{ij} \;\leq\; \frac{d(r_i(x_0), r_j(x_0))}{L} \quad \text{对 } x_0 \in \partial_{ij}$$

**证明**：由第一章 §2 命题 2.14（路由分辨率极限），$\Phi$ 无法在 $\partial_{ij}$ 两侧无限尖锐地切换行为——在宽度 $\leq \Delta/L$ 的带内，$\Phi$ 被迫以连续方式从服务 $r_i$ 过渡到服务 $r_j$。$\square$

> **注（路由边界带与谱退化的关系）**：路由边界带内 $\Phi$ 需同时满足两个方向的拟合约束，Lipschitz 预算被竞争性消耗。这是产生谱退化（$J \to 0$）的一种**几何机制**——但不是唯一来源。§1 的分类框架将事实式拟合定义为 $\sigma$-正则 + $J$ 谱退化，不预设其几何起源。路由边界带是一类重要的几何发源地，但 $J \to 0$ 也可以由 $f$-链自身的压缩性质产生。

---

### 2.5 三态扰动特征分离

§2.2–§2.4 分别推导了三态的内部几何。本节将三者在扰动响应上统一对比。

**命题 9（$\sigma$-奇异域的路由跳变必然性）**：设 $\Phi$ 在 $\mathcal{X}(r_s)$ 上 $\sigma$-奇异。则对任意 $x_0 \in \mathcal{X}(r_s)$ 和任意 $\delta > 0$：

$$J_\sigma(x_0, \delta) \;\to\; 1 \quad \text{as } \rho^{eff}_\sigma \to \infty$$

即任何有限扰动**几乎必然**触发路由跳变。

**证明**：$\sigma$-奇异意味着 $B(x_0, \delta)$ 内 $\sigma$-边界集的 $(d-1)$-维 Hausdorff 测度趋于无穷。由 co-area formula，球内不被边界分隔的最大连通域的体积比趋于零。均匀采样命中 $\sigma(x_0)$ 同一路由分区的概率 $\to 0$，$J_\sigma \to 1$。$\square$

**推论（三态的扰动特征分离）**：三种拟合形态通过 $(S, J_\sigma)$ 的联合行为完全分离：

| 形态 | $S(x_0)$ | $J_\sigma(x_0, \delta)$ | 微分结构 | 物理响应 |
|---|---|---|---|---|
| **逐字** | $\leq L$（每片内） | $\to 1$ | 处处断裂 | 路由跳变导致计算路径不可预测 |
| **事实** | $\to 0$（$J \to 0$） | $< c < 1$ | 连续但退化 | 信息被坍缩，微分信号消亡 |
| **逻辑** | $\in [\sigma_{\min}, L]$ | $< c < 1$ | 连续且满秩 | 扰动被温和放大，结构保持 |

> **注（从 $S$ 到 $(S, J_\sigma)$）**：$S(x_0)$ 单独无法区分三态——三态均满足 $S \leq L$。需联合 $J_\sigma$（路由跳变概率）才能完成分离。逐字拟合的"不稳定"不体现在 $\Phi$ 的单步输出放大上（$\Phi$ 连续），而体现在**微小扰动触发完全不同的计算路径**上。

---

### 2.6 三态几何的统一画像

§2.1–§2.5 完整地描绘了三态在 $F$-空间中的几何画像：

| 形态 | $P_\tau$ 拓扑 | $S(x_0)$ | $J_\sigma(x_0, \delta)$ | 稳定半径 $\rho_l$ | 特有结构 |
|---|---|---|---|---|---|
| **逻辑式** | 宽域各向同性球 | $\in [\sigma_{\min}, L]$ | $< c < 1$ | $O((\tau - \varepsilon\Lambda_l)/L^l)$，正 | 路由边界带（命题 8） |
| **事实式** | 低维坍缩域 | $\to 0$ | $< c < 1$ | 由 $\eta$ 和后续链长决定 | 维度坍缩（命题 5） |
| **逐字式** | 离散碎片链 | $\leq L$（每片内） | $\to 1$ | 碎片直径 $w \to 0$ | 脱槽不可逆（命题 4） |
