## 拟合分类

第一章建立了 IDFS 的骨架理论，证明了系统的误差边界（CAC/CAB）、不可拟合集的正测度性（DFG）、以及 Type B 的构型唯一性。这些定理对所有 IDFS 绝对成立。然而，当我们考察具体的拟合行为时，一个自然的问题浮现：**同为满足误差边界的拟合行为，系统在 $F$-空间内部呈现出怎样的底层度量形态？**

本节的核心主张是：系统的拟合形态分类应当纯粹**从算子映射行为的质变**中划定。这一分类完全内生——它不依赖外部目标的性质，而是从系统 $(F, \sigma)$ 自身的度量结构中直接读出：具体而言，从 $\sigma$ 的路由稳定性与 $\Phi$ 的像集区分度中读出。

---

**定义（分类参数 $(\tau, \eta)$）**：设 IDFS $\mathcal{F} = (F, \sigma)$ 以容差集 $\mathcal{E}$ 拟合了采样集 $\mathcal{S}$，$\Phi$ 全局 $L$-Lipschitz，$\mu$ 为 $\mathcal{X}$ 上的 Borel 测度。本章的拟合形态分类（$(\tau, \eta)$-三态分类）由两个独立的标尺参数给定：

1. **特征容差尺度（Characteristic Tolerance Scale）** $\tau > 0$：系统的**分辨率极限**。$\tau$ 同时作用于两个正则性判据的分辨率标尺：
   - 对 **$\sigma$**：$\mathrm{rad}_\sigma$ 与 $\tau$ 的大小关系决定路由是否稳定
   - 对 **$f$**：输出差异 $d(\Phi(x), \Phi(y)) < \tau$ 定义"对下游不可区分"
   
   典型地，$\tau$ 由第一章的误差界自然给出（CAC 单步逼近误差 $\varepsilon_{max}$ 或 CAB 不可压缩误差的量级）。

2. **保持率阈值（Preservation Threshold）** $\eta \in (0, 1]$：$f$-正则性的判据阈值——$\Phi$ 在路由分区上的 $\tau$-保持率 $\varphi$ 与 $\eta$ 的大小关系决定映射是收缩还是保持。$\eta$ 刻画的是：下游步骤要求当前步输出保留多大比例的可区分信息。

**同一系统在不同的 $(\tau, \eta)$ 下可能呈现不同的形态**——这不是分类的缺陷，而是其物理本质：系统的拟合形态是**相对于它所面临的分辨率环境与信号保持要求**而言的。

---

### 1.1 两个正则性判据

在给定 $(\tau, \eta)$ 下，定义两个独立的正则性判据。

#### 定义 1.1（$\sigma$-正则性——路由稳定半径）

设 $x \in \mathcal{X}$。定义 $x$ 处的 **路由稳定半径（Routing Stability Radius）** 为使 $\sigma$ 在 $x$ 的球邻域内保持不变的最大半径：

$$\mathrm{rad}_\sigma(x) \;\triangleq\; \sup\bigl\{\, r > 0 \;\big|\; \sigma(y) = \sigma(x),\; \forall\, y \in B_r(x) \,\bigr\}$$

设 $U \subseteq \mathcal{X}$ 为子集。定义 $\sigma$ 在 $U$ 上的 **最小路由稳定半径**：

$$\mathrm{rad}_\sigma(U) \;\triangleq\; \inf_{x \in U}\, \mathrm{rad}_\sigma(x)$$

> **注（有限系统中 $\mathrm{rad}_\sigma$ 恒为正）**：由于 $F$ 有限（$|F| = M$），$\sigma$ 的值域 $F^{\leq \mathcal{D}}$ 至多 $M^\mathcal{D}$ 个元素，路由分区至多有限片。因此，在分区内部的任意点 $x$，$\mathrm{rad}_\sigma(x) > 0$ 必然成立（仅在分区边界上 $\mathrm{rad}_\sigma = 0$，但边界是零测集）。因此，$\sigma$-正则性的判定 **不是** $\mathrm{rad}_\sigma = 0$ 与 $> 0$ 的绝对二分，而是 $\mathrm{rad}_\sigma$ **相对于 $\tau$ 的量级关系**。

在给定 $\tau$ 下：

- 称 $\sigma$ 在 $U$ 上 **$\sigma$-正则**，若 $\mathrm{rad}_\sigma(U) \geq \tau$——路由分区对量级为 $\tau$ 的扰动免疫。

- 称 $\sigma$ 在 $U$ 上 **$\sigma$-奇异**，若 $\mathrm{rad}_\sigma(U) < \tau$——路由分区的厚度不足以抵御量级为 $\tau$ 的扰动。

> **注（与命题 2.14 的对接）**：命题 2.14（路由分辨率极限）给出了分辨率死锁阈值 $\Delta/L$：当两点间距小于此值时，$\sigma$ 在数学上被剥夺了将它们分配到不同路由的能力。$\sigma$-奇异条件 $\mathrm{rad}_\sigma < \tau$ 正是此机制的反面——当碎片比上游误差还薄时，系统无法维持路由决策的稳定性。

#### 定义 1.2（$f$-正则性——$\tau$-保持率）

设 $\sigma$ 在 $\mathcal{X}(r_i)$ 上 $\sigma$-正则，从而 $\Phi$ 在 $\mathcal{X}(r_i)$ 的每个路由分区 $U_\alpha = \{x \in \mathcal{X}(r_i) : \sigma(x) = q_\alpha\}$ 内由确定的 $f$-链 $q_\alpha \in F^*$ 给出。

定义 $U_\alpha$ 的 **$\tau$-坍缩集（$\tau$-Collapsed Set）**——输入 $\tau$-可区分但输出 $\tau$-不可区分的那些点：

$$C_\tau(U_\alpha) \;\triangleq\; \bigl\{x \in U_\alpha : \exists\, y \in U_\alpha,\; d(x,y) \geq \tau,\; d(\Phi(x), \Phi(y)) < \tau \bigr\}$$

定义 $\Phi$ 在 $U_\alpha$ 上的 **$\tau$-保持率（$\tau$-Preservation Ratio）**：

$$\varphi_\alpha \;\triangleq\; 1 - \frac{\mu(C_\tau(U_\alpha))}{\mu(U_\alpha)}$$

$\varphi_\alpha \in [0, 1]$ 度量的是：在路由分区 $U_\alpha$ 内，**有多大比例的输入在 $\tau$-分辨率下保持了输出可区分性**。

定义 $\Phi$ 在 $\mathcal{X}(r_i)$ 上的 **最小 $\tau$-保持率**：

$$\varphi_{min} \;\triangleq\; \inf_\alpha\, \varphi_\alpha$$

在给定 $\eta$ 下：

- **$f$-退化**：$\varphi_{min} < \eta$（$\tau$-坍缩比例过大，下游无法从输出中提取充分的区分信号）
- **$f$-正则**：$\varphi_{min} \geq \eta$（$\tau$-保持率充分，输出多样性被保留传递）

> **注（$\tau$ 的统一语义）**：$\tau$ 在 $\sigma$-正则性和 $f$-正则性中扮演同一角色——**系统的分辨率极限**。对 $\sigma$，$\tau$ 定义了"输入扰动多大算穿越路由边界"；对 $f$，$\tau$ 定义了"输出差异多小算不可区分"。两者由同一个物理现实驱动：下游步骤面临的有效误差量级。

> **注（与 co-Lipschitz 常数的关系）**：若 $\Phi$ 在 $U_\alpha$ 上满足 co-Lipschitz 条件 $d(\Phi(x), \Phi(y)) \geq c \cdot d(x,y)$（$c > 0$），则对所有 $\tau$-可区分的输入对，输出距离 $\geq c\tau \geq \tau$（当 $c \geq 1$），从而 $C_\tau = \emptyset$，$\varphi_\alpha = 1$。co-Lipschitz 是 $f$-正则的充分条件，但 $f$-正则不要求 co-Lipschitz——它容许存在局部坍缩区域，只要全局的坍缩比例不超过 $1 - \eta$。

> **注（连续谱与混合形态）**：现实系统中 $\varphi$ 是连续变化的。一个算子可以同时具有收缩特征和保持特征——在某些子区域输出可区分，在另一些子区域输出坍缩。$\varphi$ 作为比例量自然捕捉了这种混合行为，不存在"一个坏点杀死全局"的问题。

> **注（有限空间中的自然行为）**：在有限空间（计数测度 $\mu = |\cdot|$）下，$\varphi_\alpha = 1 - |C_\tau(U_\alpha)| / |U_\alpha|$，即"输出在 $\tau$-尺度上保持可区分的输入比例"。这对有限系统和连续系统同样良定义，无需额外假设。

---

### 1.2 $(\tau, \eta)$ 下的三类拟合形态

在给定分类参数 $(\tau, \eta)$ 下，$\sigma$ 和 $f$ 的独立正则性判据将 IDFS 的拟合行为分为三种形态。以下阐述各形态的复合潜力与拓扑特征。

#### 1.2.1 碎裂态（Fragmented Fitting）

**定义（碎裂态）**：称 $\Phi$ 在 $\mathcal{X}(r_i)$ 上处于 **碎裂态** ，若 $\sigma$-奇异：

$$\mathrm{rad}_\sigma(\mathcal{X}(r_i)) \;<\; \tau$$

**复合性质**：长链断裂。$\mathrm{rad}_\sigma < \tau$ 意味着 $\mathcal{X}(r_i)$ 内存在碎片的稳定半径小于系统特征容差——量级为 $\tau$ 的上游误差足以穿越路由边界。在链式复合中，步骤 $j$ 的误差使扰动后的输入落入不同的碎裂分片，下一步 $\Phi$ 激活毫不相关的 $f$-链，导致计算路径发散。形式地，存在 $x, x' \in \mathcal{X}(r_i)$：

$$d(x, x') < \tau, \quad \sigma(x) \neq \sigma(x')$$

命题 2.14（路由分辨率极限）保证了此情形下的路由跳变代价 $\Delta^{err}$ 不可避免——长链在此步断裂。

> **注（拓扑图像）**：碎裂态的拓扑图像是路由结构的"尘化"——$\sigma$ 的碎裂将度量空间的路由结构粉碎为薄层：每一层内部完好（$\Phi = q_\alpha$，$L$-Lipschitz），但层与层之间的路由选择在尺度 $\tau$ 内跳变。$\Phi$ 的值连续（$L$-Lipschitz），但其变分响应结构在 $\tau$-尺度上断裂。

#### 1.2.2 收缩态（Contractive Fitting）

**定义（收缩态）**：称 $\Phi$ 在 $\mathcal{X}(r_i)$ 上处于 **收缩态** ，若 $\sigma$-正则且 $f$-退化：

$$\varphi_{min} \;<\; \eta$$

**复合性质**：链延伸受抑。$\varphi_{min} < \eta$ 意味着 $\Phi$ 在路由分区内部将过大比例的 $\tau$-可区分输入对坍缩为 $\tau$-不可区分的输出。设链中某步骤处于收缩态，则对该分区内的大部分输入对 $x, x'$（$d(x, x') \geq \tau$）：

$$d\bigl(\Phi(x),\, \Phi(x')\bigr) \;<\; \tau$$

下游收到的信号中，大量的输入差异已被抹平至系统的分辨率极限以下，迫使后续算子在无法有效区分输入来源的退化空间中操作。收缩态在链上充当**信息坍缩区域**，长链在此失去分辨力。

> **注（拓扑图像——盆地）**：收缩态在度量空间中形成一个"拓扑盆地"——吸引域。$\tau$-可区分的输入在输出端被合并为 $\tau$-不可区分的簇。这不要求像集坍缩为单个点——只要求足够大比例（$> 1 - \eta$）的输入在 $\tau$-尺度上失去可区分性。

#### 1.2.3 保持态（Preserving Fitting）

**定义（保持态）**：称 $\Phi$ 在 $\mathcal{X}(r_i)$ 上处于 **保持态** ，若 $\sigma$-正则且 $f$-正则：

$$\varphi_{min} \;\geq\; \eta$$

即对每个路由分区 $U_\alpha$，至少有比例 $\eta$ 的输入在 $\tau$-分辨率下保持了输出可区分性。

**复合性质**：支持深链复合。$\varphi_{min} \geq \eta$ 意味着 $\Phi$ 在每个路由分区内保留了充分比例的 $\tau$-可区分信号。信息既不在 $\tau$-尺度上被大面积湮灭，也不引发不可预测的碎裂路由跳变。CAC 的级联传播在保持态域内表现为受控的度量滑移，从而允许复杂计算沿长链稳健伸展。

> **注（拓扑图像——测地线）**：保持态的拓扑图像是一条**测地线**——最自然的、无畸变的轨道。保持态映射忠实地搬运 $\tau$-尺度上的度量信息：大多数不同输入保持可区分（$\varphi \geq \eta$），距离不在 $\tau$-尺度上被批量抹平。这是三态中唯一的正则态，也是唯一允许长链演化而不丢失结构信息的形态。

> **注（部分坍缩与混合形态）**：保持态允许存在局部坍缩区域（$C_\tau$ 非空）——只要坍缩比例不超过 $1 - \eta$。这正确捕捉了"大部分保持、少部分坍缩"的混合行为，如 $f(x) = \max(x, 0)$ 在正半轴上保持、负半轴上坍缩。

---

### 1.3 宏观性质：拟合域宽度的推论

前述的 $\sigma$-奇异、$f$-退化等分类判据都是纯粹的局部或算子级（operator-level）特性。在本节中，我们考察这些底层分类如何决定系统的宏观表现。为了度量宏观表现，我们首先引入一个核心概念。

**定义（拟合域）**：对于给定的有限容差 $\tau' > 0$ 和目标 $r_i$，定义系统 $\Phi$ 在 $r_i$ 上的 **$\tau'$-拟合域（Fitting Domain）** 为满足逼近精度的输入子集：

$$P_{\tau'}(r_i) \;\triangleq\; \{x \in \mathcal{X}(r_i) : d(\Phi(x), r_i(x)) < \tau'\}$$

拟合域 $P_{\tau'}(r_i)$ 刻画了系统"在给定的精度 $\tau'$ 下，究竟覆盖了多大范围的输入"。以下设 $\mu$ 为 $\mathcal{X}$ 上的 Borel 测度，我们用测度 $\mu(P_{\tau'})$ 来度量**域宽**。以下命题表明，拟合域的宽度本质上是由算子的底层分类状态（碎裂、收缩、保持）所决定的**后验宏观特征**。

**定义（有效 $\sigma$-奇异性）**：称 $\sigma$ 在 $\mathcal{X}(r_i)$ 上 **有效奇异**（effectively singular），若将所有使用相同 $f$-链的相邻分片合并后，碎裂仍然不消失。即记合并后的分片为 $\{V_\beta\}$（每个 $V_\beta$ 是使用同一 $f$-链的最大连通域），有效 $\sigma$-奇异要求：

$$\mathrm{rad}^{eff}_\sigma(\mathcal{X}(r_i)) \;\triangleq\; \inf_\beta\, \sup\bigl\{r > 0 \mid B_r(x) \subseteq V_\beta,\; \exists\, x \in V_\beta\bigr\} \;<\; \tau$$

此条件排除了退化情况——$\sigma$ 在形式上碎裂为多片但所有碎片使用相同 $f$-链（此时合并后只有一片，无有效奇异）。

**命题 1.3（有效 $\sigma$-奇异蕴含域宽萎缩）**：设 $\Phi$ 全局 $L$-Lipschitz，$\sigma$ 在 $\mathcal{X}(r_i)$ 上有效 $\sigma$-奇异。则对任意有限容差 $\tau'$，拟合域 $P_{\tau'}(r_i) = \{x \in \mathcal{X}(r_i) : d(\Phi(x), r_i(x)) < \tau'\}$ 的测度满足：

$$\mu(P_{\tau'}(r_i)) \;\leq\; \sum_{q \in F^{\leq \mathcal{D}}} \mu\bigl(\{x \in \Sigma_q : d(q(x), r_i(x)) < \tau'\}\bigr)$$

其中 $\Sigma_q = \bigcup_{\alpha: q_\alpha = q} U_\alpha$ 为使用 $f$-链 $q$ 的所有碎片之并。当有效碎片直径 $\to 0$ 时，$\mu(P_{\tau'}) \to 0$。

**证明**：

(i) **分解**：$P_{\tau'}(r_i) = \bigsqcup_\alpha (P_{\tau'}(r_i) \cap U_\alpha)$。在每片 $U_\alpha$ 内，$\Phi = q_\alpha$（固定 $f$-链）。故 $P_{\tau'}(r_i) \cap U_\alpha = \{x \in U_\alpha : d(q_\alpha(x), r_i(x)) < \tau'\}$。按链分组即得上式。

(ii) **有效碎片的直径约束**：有效 $\sigma$-奇异意味着合并后的有效分片 $\{V_\beta\}$ 中存在碎片的内切半径 $< \tau$。当 $\mathrm{rad}^{eff}_\sigma \to 0$ 时，碎片直径 $w \to 0$。

(iii) **单链域宽压缩**：每条链 $q$ 的碎片并集 $\Sigma_q$ 随 $w \to 0$ 碎裂为直径 $\leq w \to 0$ 的不连通碎片集。在每个碎片 $V_\beta$ 内，$q$ 是 $L$-Lipschitz 的，其值域直径 $\leq Lw$。由于有效奇异保证相邻碎片使用不同的 $f$-链，$r_i$ 在不同碎片上需要被不同的 $q$-链近似。但 $\Phi$ 全局连续意味着 $q_\beta(x_0) = q_\gamma(x_0)$ 在边界点处，而 $q_\beta, q_\gamma$ 作为不同映射在远离边界时发散。每个碎片对 $P_{\tau'}$ 的贡献独立受限于 $\mu(V_\beta) \to 0$，总和 $\mu(P_{\tau'}) \to 0$。$\square$

**命题 1.4（$f$-退化蕴含吸引盆地域宽）**：设 $\sigma$ 在 $\mathcal{X}(r_i)$ 上 $\sigma$-正则，$\Phi$ 在 $\mathcal{X}(r_i)$ 上 $f$-退化（$\varphi_{min} < \eta$）。记 $\Phi$ 在路由分区 $U_\alpha$ 上的 **像集直径** $D_\alpha \triangleq \mathrm{diam}(\Phi(U_\alpha))$。则对任意 $y_0 \in \Phi(U_\alpha)$：

$$P_{\tau'}(r_i) \cap U_\alpha \;\supseteq\; \{x \in U_\alpha : d(r_i(x),\, \Phi(U_\alpha)) < \tau' - D_\alpha\}$$

$\varphi_{min} < \eta$ 意味着大部分输入对被 $\tau$-坍缩，像集直径 $D_\alpha$ 相对于 $\mathrm{diam}(U_\alpha)$ 受到压缩。大量分散的输入映射到直径有限的像集中——拟合域具有中等至宽大的测度。

**命题 1.5（$f$-正则蕴含拓扑忠实性）**：设 $\Phi$ 在 $\mathcal{X}(r_i)$ 上 $\sigma$-正则且 $f$-正则（$\varphi_{min} \geq \eta$）。则在每个路由分区 $U_\alpha$ 内，至少比例 $\eta$ 的输入满足：对所有 $d(x, y) \geq \tau$ 的 $y \in U_\alpha$，有 $d(\Phi(x), \Phi(y)) \geq \tau$。即 $\Phi$ 在 $U_\alpha$ 的 $\varphi_\alpha$-比例子集上是 **$\tau$-忠实**的——$\tau$-可区分的输入被映射为 $\tau$-可区分的输出。若 $r_i$ 在 $\mathcal{X}(r_i)$ 上的 $\tau'$-拟合成立，则 $P_{\tau'}(r_i)$ 的覆盖不存在因输出坍缩导致的大面积拟合空洞。

---

### 1.4 近孤立性

**定义（$\sigma$-分片结构不相容）**：设 $\sigma$ 在 $\mathcal{X}(r_s)$ 上 $\sigma$-奇异（$\mathrm{rad}_\sigma(\mathcal{X}(r_s)) < \tau$），在 $\mathcal{X}(r_j)$ 上 $\sigma$-正则（$\mathrm{rad}_\sigma(\mathcal{X}(r_j)) \geq \tau$）。称两者 **$\sigma$-分片结构不相容**，若 $r_s$ 的碎裂路由分区在 $r_j$ 的任何单个稳定路由分区 $U^{(j)}_\beta$ 内保持有界的碎裂密度：即在每个 $U^{(j)}_\beta$ 内，$\sigma$ 对 $r_s$ 所诱导的不同 $f$-链数有限。

**命题 1.6（碎裂态的近孤立极值点性质）**：设 $(r_s, \mathcal{X}(r_s))$ 处于碎裂态（$\sigma$-奇异），$(r_j, \mathcal{X}(r_j))$ 处于保持态或收缩态（$\sigma$-正则）。设两者 $\sigma$-分片结构不相容。则：

$$\mu\bigl(P_{\tau'}(r_s) \cap P_{\tau'}(r_j)\bigr) \;=\; o\bigl(\mu(P_{\tau'}(r_j))\bigr) \quad \text{as } \mathrm{rad}_\sigma(\mathcal{X}(r_s)) \to 0$$

**证明思路**：$r_j$ 的 $\tau'$-拟合依赖 $\sigma$-正则域内连续 $f$-链的稳定行为。$r_s$ 的 $\tau'$-拟合依赖 $\sigma$ 的密集碎裂在极窄碎片上的逐片匹配。在同一点 $x$，$\sigma(x)$ 只能指向一条确定的 $f$-链——它要么属于 $r_j$ 的稳定链路，要么处于 $r_s$ 的碎裂边界区，不可能同时两者兼顾。因此交集被限制在巧合区域，其测度因碎片直径 $\to 0$ 而趋于零。$\square$

> **注（碎裂态 $\neq$ 过拟合）**：三态分类澄清了一个在工程语境中常被混淆的区分。**过拟合**是保持/收缩态在采样集支撑太弱时的域范围问题——$\sigma$ 和 $f$ 均正则，只是泛化域不够宽。**碎裂态**（传统意义上的"死记硬背"）是 $\sigma$ 自身的相对奇异化——路由碎裂导致稳定半径低于系统容差的拓扑奇点，根本不在可泛化的结构内。前者是"覆盖不够"，后者是"根本不是覆盖"。

---

### 1.5 汇总定理

**定理 1.7（IDFS $(\tau, \eta)$-三态分类定理）**：设 IDFS $\mathcal{F} = (F, \sigma)$ 拟合采样集 $\mathcal{S}$，特征容差尺度 $\tau > 0$，保持率阈值 $\eta \in (0, 1]$。IDFS 内部的拟合行为由 $\sigma$-正则性（定义 1.1）与 $f$-正则性（定义 1.2）的独立诊断分类为三种形态：

| 形态 | $\sigma$ | $f$（$\tau$-保持率） | 拓扑图像 | 扰动传播 | 复合 | 域宽 |
|---|---|---|---|---|---|---|
| **碎裂** | 奇异 ($\mathrm{rad}_\sigma < \tau$) | （不约束） | 尘化 | 路由跳变 | 易断裂 | $\to 0$ |
| **收缩** | 正则 ($\mathrm{rad}_\sigma \geq \tau$) | 退化 ($\varphi_{min} < \eta$) | 盆地 | 信号被批量抹平 | 延伸受抑 | 中等 |
| **保持** | 正则 ($\mathrm{rad}_\sigma \geq \tau$) | 正则 ($\varphi_{min} \geq \eta$) | 测地线 | 信号被保留传递 | 支持深链 | 全域 |

此分类具有以下结构性质：

1. **判据正交性**：$\sigma$-正则性与 $f$-正则性分别作用于 IDFS 的不同结构组件（$\sigma$ 的路由稳定性 vs $\Phi$ 在分区内的输出区分度），相互独立。

2. **双参数、统一分辨率**：$\tau$ 同时作用于 $\sigma$ 和 $f$ 的分辨率标尺——它定义了"多大的扰动算有效"和"多小的差异算不可区分"。$\eta$ 决定"多大比例的坍缩可以容忍"。

3. **域宽推论**：域宽差异不是分类判据，而是正则性状态的宏观后果（命题 1.3–1.5）。

4. **与第一章的对接**：保持态是 CAC 上界、CAB 下界、收缩走廊（推论 6.3）、三元困境（命题 6.12）的**标准适用对象**。收缩态因 $\varphi_{min} < \eta$ 在链中充当**吸收壁**，自动终止链延伸。碎裂态因 $\sigma$-奇异而被 $R^*$ **结构性排除**。

> **注（形态体制的解耦）**：本分类将形态升格为拓扑质变：收缩态是 $F$-空间中的 $\tau$-信号湮灭体制（$\varphi < \eta$）；保持态是 $F$-空间中的 $\tau$-信号保持体制（$\varphi \geq \eta$）。前者对应拓扑盆地，后者对应测地线。这两种体制分别决定了复合计算链是因信息枯竭而终止，还是能忠实搬运度量信息以走完深长计算。
