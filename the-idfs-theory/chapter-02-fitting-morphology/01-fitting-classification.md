## 拟合分类

第一章建立了 IDFS 的骨架理论，证明了系统的误差边界（CAC/CAB）、不可拟合集的正测度性（DFG）、以及 Type B 的构型唯一性。这些定理对所有 IDFS 绝对成立，不区分被拟合的目标 $r \in R$ 的内在性质。然而，当我们考察具体的拟合行为时，一个自然的问题浮现：**不同类型的目标在 $F$-空间中呈现出怎样不同的拟合形态？**

本节的核心主张是：IDFS 的拟合行为——即系统 $\Phi$ 逼近目标 $r \in R$ 时的内部结构——并非"域宽"维度上的量变，而是**算子映射行为的质变**。这一分类不依赖目标 $r$ 的性质（第一章不对 $r$ 施加任何假设），而是从系统 $(F, \sigma)$ 自身的内禀拓扑结构中直接读出——具体而言，从 $\sigma$ 的路由正则性与 $F$ 的局部雅可比矩阵 $J(x) = D\Phi(x)$ 的谱正则性中读出。

---

### 1.1 两个正则性判据

**前提**：设 IDFS $\mathcal{F} = (F, \sigma)$ 以容差集 $\mathcal{E}$ 拟合了采样集 $\mathcal{S}$。$\Phi$ 全局 $L$-Lipschitz。

**定义 1.1（$\sigma$-正则性）**：设 $U \subseteq \mathcal{X}$ 为开集。$\sigma$ 在 $U$ 上诱导分片划分 $\{U_\alpha\}_{\alpha \in \mathcal{A}}$，其中每片 $U_\alpha = \{x \in U : \sigma(x) = q_\alpha\}$ 对某条 $f$-链 $q_\alpha \in F^*$。定义**路由边界密度**：

$$\rho_\sigma(U) \;\triangleq\; \frac{\mathcal{H}^{d-1}\!\bigl(\bigcup_\alpha \partial U_\alpha \cap U\bigr)}{\mu(U)}$$

其中 $\mathcal{H}^{d-1}$ 为 $(d-1)$-维 Hausdorff 测度。称 $\sigma$ 在 $U$ 上 **$\sigma$-正则**，若 $\rho_\sigma(U) < \infty$；称 **$\sigma$-奇异**，若 $\rho_\sigma(U) = \infty$。

> **注（$\sigma$-奇异的物理含义）**：$\sigma$-奇异意味着路由决策在极小的空间尺度内碎裂为无穷多片——每片内 $\Phi$ 是光滑的（由 $f$-链给出，$\|J\| \leq L$），但片与片之间的拼接依赖 $\sigma$ 的硬编码，没有连续 $F$-域的支撑。

**定义 1.2（谱正则性）**：设 $\sigma$ 在 $x$ 的邻域 $\sigma$-正则，从而 $J(x) = D\Phi(x)$ 良定义。记 $J(x)$ 的奇异值谱为 $\sigma_1(x) \geq \sigma_2(x) \geq \cdots \geq \sigma_d(x) \geq 0$。

- 称 $\Phi$ 在 $x$ 处 **谱正则**，若 $J(x)$ 满秩且条件数有界：

$$\mathrm{rank}\, J(x) = d, \qquad \kappa(J(x)) \;\triangleq\; \frac{\sigma_1(x)}{\sigma_d(x)} \;\leq\; C$$

- 称 $\Phi$ 在 $x$ 处 **谱退化**，若 $J(x)$ 秩亏：

$$\sigma_d(x) \;\to\; 0 \qquad (\text{即 } \mathrm{rank}\, J(x) < d)$$

> **注（与 $L$-Lipschitz 的相容性）**：谱退化（$J \to 0$）与谱正则（$J$ 满秩有界）均满足 $\|J(x)\| \leq L$。唯一不可能的是 $\sigma_1(x) > L$。$\sigma$-奇异同样相容：$\Phi$ 可以是分片 $L$-Lipschitz 的，奇异性不在 $J$ 的模，而在 $\sigma$ 的不连续结构中。

---

### 1.2 三类拟合形态

$\sigma$ 和 $F$ 是 IDFS 的两个独立结构组件。三类拟合形态恰好对应于"退化/奇异发生在 $\sigma$、$F$、还是都不发生"这一组合判定。

#### 1.2.1 逐字式拟合（Verbatim Fitting）：狄拉克图钉

**定义（逐字式拟合）**：称 $\Phi$ 在 $\mathcal{X}(r_i)$ 上处于**逐字式拟合**形态，若以下条件成立：

$$\sigma \text{ 在 } \mathcal{X}(r_i) \text{ 上 } \sigma\text{-奇异}：\quad \rho_\sigma(\mathcal{X}(r_i)) = \infty$$

且 $\Phi$ 在每一 $\sigma$-分片 $U_\alpha$ 内部谱正则：$\kappa(J(x)) \leq C$，$\forall x \in U_\alpha^\circ$。

**复合性质**：$\chi = 0$（绝对不可复合）。设 $\varepsilon > 0$ 为上游误差。由 $\sigma$-奇异性，$\mathcal{X}(r_i)$ 内任意点的 $\varepsilon$-邻域几乎必然包含 $\sigma$ 的决策边界。跨越边界时 $\Phi$ 切换到不同的 $f$-链，导致输出发生 $O(1)$ 量级的不可预测跳变。形式地：

$$\forall \varepsilon > 0, \; \exists x, x' \in \mathcal{X}(r_i) : \quad d(x, x') < \varepsilon, \quad \sigma(x) \neq \sigma(x'), \quad d(\Phi(x), \Phi(x')) = \Omega(\tau)$$

因此误差传播呈现**混沌敏感性**——微小扰动导致宏观行为跳变，长链在此步瞬间断裂。

> **注（拓扑图像——狄拉克图钉）**：逐字式拟合在流形上的拓扑图像是一根"图钉"——0 维奇异点。$\sigma$ 的碎裂将流形粉碎为尘埃：每一粒碎片内部完好（$\|J\| \leq L$），但碎片之间无连续性。这不是 $F$ 的问题，而是纯粹的 $\sigma$-奇异。

#### 1.2.2 事实式拟合（Fact Fitting）：拓扑黑洞

**定义（事实式拟合）**：称 $\Phi$ 在 $\mathcal{X}(r_i)$ 上处于**事实式拟合**形态，若以下条件成立：

$$\sigma \text{ 在 } \mathcal{X}(r_i) \text{ 上 } \sigma\text{-正则}：\quad \rho_\sigma(\mathcal{X}(r_i)) < \infty$$

且 $\Phi$ 在 $\mathcal{X}(r_i)$ 上谱退化：

$$\sigma_d(J(x)) \;\to\; 0, \qquad \forall x \in \mathcal{X}(r_i) \quad (\text{即 } \mathrm{rank}\, J(x) < d)$$

**复合性质**：$l = 1$（链终止符）。$J(x) \to 0$ 意味着 $\Phi$ 将 $\mathcal{X}(r_i)$ 的局部流形折叠为低维（极端情况下为 0 维常数点）。设链中步骤 $j$ 为事实式拟合，则该步的输出变分为：

$$\|D\Phi_j \cdot v\| \;\leq\; \sigma_d(J_j) \cdot \|v\| \;\to\; 0, \qquad \forall v \in T_x\mathcal{X}$$

即**所有方向上的差分信号**在经过谱退化映射后被压缩至零。下游步骤 $j+1, j+2, \ldots$ 收到的是一个没有内部结构的点信号——无论后续算子是什么，它们无法从无方向差分的输入中推导出任何新结论。事实在链上充当**吸收壁**。

> **注（拓扑图像——黑洞）**：事实式拟合在流形上形成一个"拓扑盆地"——吸引域。一旦输入进入该区域，$F$ 算子将高维输入坍缩到同一个低维（乃至 0 维）输出。信息维度在此被不可逆地消灭。

#### 1.2.3 逻辑式拟合（Logic Fitting）：测地线

**定义（逻辑式拟合）**：称 $\Phi$ 在 $\mathcal{X}(r_i)$ 上处于**逻辑式拟合**形态，若以下条件成立：

$$\sigma \text{ 在 } \mathcal{X}(r_i) \text{ 上 } \sigma\text{-正则}：\quad \rho_\sigma(\mathcal{X}(r_i)) < \infty$$

且 $\Phi$ 在 $\mathcal{X}(r_i)$ 上谱正则：

$$\mathrm{rank}\, J(x) = d, \qquad \kappa(J(x)) \leq C, \qquad \forall x \in \mathcal{X}(r_i)$$

**复合性质**：$l \to \infty$（完美复合）。$J(x)$ 满秩良态意味着 $\Phi$ 在 $\mathcal{X}(r_i)$ 上是一个近似微分同胚，流形的拓扑结构（方向、距离、差分）被忠实地保持传递。形式地，设链中步骤 $j$ 为逻辑式拟合，输入切向量 $v$ 在该步的传播满足：

$$\frac{1}{C} \|v\| \;\leq\; \|J_j \cdot v\| \;\leq\; L \|v\|$$

即信息既不被指数放大（上界 $L$），也不被湮灭（下界 $1/C$）。CAC 的级联传播在逻辑域内是受控的流形滑移，不是指数爆炸（$\sigma$-碎裂导致），也不是信号消亡（$J \to 0$ 导致）。

> **注（拓扑图像——测地线）**：逻辑式拟合在流形上的拓扑图像是一条**测地线**——最自然的、无畸变的光滑轨道。如同黎曼流形上的测地线平行输运切向量而不引入额外弯曲，逻辑式映射忠实地搬运信息。这是三态中唯一的正则态，也是唯一允许长链演化而不丢失结构信息的形态。

---

### 1.3 域宽是正则性的后验推论

"域宽"在以往被视为分类的一阶判据。基于正则性分析，域宽被严格**降格为拓扑状态的后验推论**。

**命题 1.3（$\sigma$-奇异蕴含域宽萎缩）**：设 $\Phi$ 全局 $L$-Lipschitz，$\sigma$ 在 $\mathcal{X}(r_i)$ 上 $\sigma$-奇异。则对任意有限容差 $\tau$，拟合域 $P_\tau(r_i) = \{x \in \mathcal{X}(r_i) : d(\Phi(x), r_i(x)) < \tau\}$ 的测度满足：

$$\mu(P_\tau(r_i)) \;\leq\; \frac{2\tau}{\inf_\alpha \mathrm{diam}(U_\alpha)} \cdot \sup_\alpha \mu(U_\alpha) \;\to\; 0 \quad \text{as } \rho_\sigma \to \infty$$

**证明思路**：$\sigma$-奇异 $\Rightarrow$ 分片 $\{U_\alpha\}$ 的平均直径 $\bar{w} = \mathrm{diam}(U_\alpha) \to 0$。在每一片内 $\Phi$ 被约束为某条 $f$-链 $q_\alpha$。在相邻两片 $U_\alpha, U_\beta$ 的边界处，$\Phi$ 从 $q_\alpha$ 跳到 $q_\beta$。为使 $r_i$ 的 $\tau$-拟合在两片内同时成立，需要 $d(q_\alpha(x), q_\beta(x)) < 2\tau$ 在边界处。当碎片越来越密，能同时满足此条件的碎片组合越来越少，$P_\tau$ 退化为孤立碎片的稀疏子集。$\square$

**命题 1.4（谱退化蕴含吸引盆地域宽）**：设 $\sigma$ 在 $\mathcal{X}(r_i)$ 上 $\sigma$-正则，$\Phi$ 在 $\mathcal{X}(r_i)$ 上谱退化（$\sigma_d(J) \to 0$）。设 $\Phi$ 在 $\mathcal{X}(r_i)$ 上近似常值：$\exists\, C_0 \in \mathcal{X}$ 使得 $\sup_{x \in \mathcal{X}(r_i)} d(\Phi(x), C_0) \leq \varepsilon_0$。则：

$$P_\tau(r_i) \;\supseteq\; \{x \in \mathcal{X}(r_i) : d(r_i(x), C_0) < \tau - \varepsilon_0\}$$

即**所有输出与 $C_0$ 接近的输入**都自动落入 $\tau$-拟合域。由于 $\Phi$ 在此区域的输出变分极小（$J \to 0$），大量分散的输入可以被同一个常值映射覆盖——拟合域具有中等至宽大的测度。

**命题 1.5（谱正则蕴含全域贯通）**：设 $\Phi$ 在 $\mathcal{X}(r_i)$ 上 $\sigma$-正则且谱正则（$\kappa(J) \leq C$）。则 $\Phi|_{\mathcal{X}(r_i)}$ 是一个**双 Lipschitz 映射**：

$$\frac{1}{C} \cdot d(x, y) \;\leq\; d(\Phi(x), \Phi(y)) \;\leq\; L \cdot d(x, y), \qquad \forall x, y \in \mathcal{X}(r_i)$$

特别地，$\Phi$ 在 $\mathcal{X}(r_i)$ 上是**单射**，不存在流形折叠或撕裂。若 $r_i$ 在 $\mathcal{X}(r_i)$ 上的 $\tau$-拟合成立，则 $P_\tau(r_i) = \mathcal{X}(r_i)$ 可以覆盖该规则的全部定义域——不存在因拓扑障碍导致的拟合空洞。

---

### 1.4 近孤立性

**命题 1.6（逐字拟合的近孤立极值点性质）**：设 $(r_s, \mathcal{X}(r_s))$ 处于逐字式拟合（$\sigma$-奇异），$(r_j, \mathcal{X}(r_j))$ 处于逻辑式或事实式拟合（$\sigma$-正则）。设两者的 $\sigma$-分片结构不相容（即 $r_s$ 触发的密集碎裂边界集 $\partial_s$ 与 $r_j$ 的稳定链路域 $U_j$ 重合度有限）。则：

$$\mu\bigl(P_\tau(r_s) \cap P_\tau(r_j)\bigr) \;=\; o\bigl(\mu(P_\tau(r_j))\bigr) \quad \text{as } \rho_\sigma(\mathcal{X}(r_s)) \to \infty$$

**证明思路**：$r_j$ 的 $\tau$-拟合依赖 $\sigma$-正则域内连续 $f$-链的光滑行为。$r_s$ 的 $\tau$-拟合依赖 $\sigma$ 的密集碎裂在极窄碎片上的逐片匹配。在同一点 $x$，$\sigma(x)$ 只能指向一条确定的 $f$-链——它要么属于 $r_j$ 的稳定链路（为 $r_j$ 服务），要么处于 $r_s$ 的碎裂边界区（为 $r_s$ 服务），不可能同时两者兼顾。因此交集被限制在 $r_s$ 碎裂区域中恰好与 $r_j$ 的稳定链路输出 $\tau$-接近的巧合区域，其测度因碎片直径 $\to 0$ 而趋于零。$\square$

> **注（死记硬背 $\neq$ 过拟合）**：三态分类澄清了一个在工程语境中常被混淆的区分。**过拟合**是逻辑/事实拟合在训练集支撑太弱时的域范围问题——$\sigma$ 和 $F$ 均正则，只是泛化域不够宽。**死记硬背**是 $\sigma$ 自身的奇异化——路由碎裂导致的拓扑奇点，根本不在可泛化的结构内。前者是"覆盖不够"，后者是"根本不是覆盖"。

---

### 1.5 汇总定理

**定理 1.7（IDFS 拟合形态三态分类定理）**：设 IDFS $\mathcal{F} = (F, \sigma)$ 拟合采样集 $\mathcal{S}$。IDFS 内部的拟合行为由 $\sigma$-正则性（定义 1.1）与谱正则性（定义 1.2）的独立诊断唯一地分类为三种离散形态：

| 形态 | $\sigma$ | $J(x)$ | 拓扑图像 | 切向量传播 | 复合 | 域宽 |
|---|---|---|---|---|---|---|
| **逐字** | 奇异 ($\rho_\sigma = \infty$) | 每片内正则 | 图钉 | 混沌跳变 | $\chi=0$ | $\to 0$ |
| **事实** | 正则 ($\rho_\sigma < \infty$) | 退化 ($\sigma_d \to 0$) | 黑洞 | $\|Jv\| \to 0$ | $l=1$ | 中等 |
| **逻辑** | 正则 ($\rho_\sigma < \infty$) | 正则 ($\kappa \leq C$) | 测地线 | $\|v\|/C \leq \|Jv\| \leq L\|v\|$ | $l \to \infty$ | 全域 |

此分类具有以下结构性质：

1. **判据正交性**：$\sigma$-正则性与谱正则性分别作用于 IDFS 的不同结构组件，相互独立。

2. **完备性**：任何输入点 $x$ 处，$\Phi$ 的行为必然落入三种状态之一。$\sigma$ 要么奇异（逐字）、要么正则；在 $\sigma$-正则时，$J(x)$ 要么谱退化（事实）、要么谱正则（逻辑）。

3. **域宽推论**：域宽差异不是分类判据，而是正则性状态的宏观后果（命题 1.3–1.5）。

4. **与第一章的对接**：逻辑式拟合是 CAC 上界、CAB 下界、收缩走廊（推论 6.3）、三元困境（命题 6.12）的**标准适用对象**。事实式拟合因 $J \to 0$ 在链中充当**吸收壁**，自动终止链延伸。逐字式拟合因 $\sigma$-奇异而被 $R^*$ **结构性排除**。

> **注（知识与逻辑的解耦）**：旧视角中，知识与逻辑的区分是域宽的量变。本分类将其升格为**质变**：事实是 $F$-空间中的谱退化态（$J \to 0$，信息维度被折叠——降维的终止符）；逻辑是 $F$-空间中的谱正则态（$J$ 满秩良态，信息维度被保持——同构的搬运工）。前者对应拓扑盆地，后者对应测地线。盆地不可穿越，测地线无限延伸。
