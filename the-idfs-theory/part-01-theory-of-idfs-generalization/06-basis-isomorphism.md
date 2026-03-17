## 计算的基底同构（Basis Isomorphism of Computation）

### 6.1 基底扩展定理

本节的核心观察是：对 IDFS 输入施加的任何预变换 $\varphi$，在数学上等价于将 $\varphi$ 吸收为系统基底的一部分——外部计算与系统本身之间存在严格的同构关系。这一同构以 Lipschitz 常数的乘法代价为界。

**定义（基底扩展，Basis Extension）**：设 IDFS $\mathcal{F} = (F, \sigma)$，$\Phi \in \mathrm{Lip}_L(\mathcal{X})$。对映射 $\varphi: \mathcal{X} \to \mathcal{X}$，定义<b>$\varphi$-扩展系统</b> $\mathcal{F}_\varphi = (F_\varphi, \sigma_\varphi)$：

$$F_\varphi \;\triangleq\; F \cup \{\varphi\}, \qquad \sigma_\varphi(x) \;\triangleq\; \sigma(\varphi(x)) \circ \varphi$$

即所有路由路径永久挂载 $\varphi$ 为首步。扩展系统的全局映射为 $\Phi_\varphi(x) = \Phi(\varphi(x))$。

**定理 6.1（基底同构，Basis Isomorphism）**：设 $\varphi \in \mathrm{Lip}_K(\mathcal{X})$（$K < \infty$）。则：

1. $\mathcal{F}_\varphi$ 构成合法 IDFS，且 $\Phi_\varphi \in \mathrm{Lip}_{LK}(\mathcal{X})$；
2. 在 IDFS 外部对输入施加 $\varphi$ 等价于将 $\varphi$ 内化为基底：$\Phi \circ \varphi = \Phi_\varphi$；
3. 扩展的容量代价为：
   - 像集容量：$\mathcal{C}_{\mathrm{img}}(\Phi_\varphi, \epsilon) \leq \log \mathcal{N}(\epsilon/(LK), \mathcal{X})$（分辨率从 $\epsilon/L$ 收紧至 $\epsilon/(LK)$）；
   - 路由容量：$\mathcal{C}_{\mathrm{route}}(\sigma_\varphi) = \mathcal{C}_{\mathrm{route}}(\sigma)$（路由结构不变）；
   - 有效链深：$\mathcal{D}' = \mathcal{D} + 1$。

**证明**：

1. $d(\Phi_\varphi(x), \Phi_\varphi(y)) = d(\Phi(\varphi(x)), \Phi(\varphi(y))) \leq L \cdot d(\varphi(x), \varphi(y)) \leq LK \cdot d(x,y)$。
2. $\Phi_\varphi(x) = \sigma_\varphi(x)(x) = (\sigma(\varphi(x)) \circ \varphi)(x) = \sigma(\varphi(x))(\varphi(x)) = \Phi(\varphi(x))$。
3. 由 §2.1 命题 2.1，将 $L$ 替换为 $L' = LK$ 即得。$\square$

> **注（非 Lip 扩展）**：当 $\varphi \notin \mathrm{Lip}$ 时，$\Phi_\varphi = \Phi \circ \varphi$ 在代数上仍然良定义——$\mathcal{F}_\varphi$ 仍可作为形式系统运行。但 $\Phi_\varphi$ 不满足有限 Lip 常数，故 $\mathcal{F}_\varphi$ 不构成 IDFS，本章所有依赖 Lip 条件的定理（CAC、CAB、走廊约束等）均不适用。

> **注（同构的三层结构）**：基底同构不仅涵盖外部变换，还涵盖系统自身的计算与输入变更——三者在此框架下是同一种操作的不同实例：
>
> 1. **外部变换**：任意 $\varphi \in \mathrm{Lip}_K$ 作为预处理，吸收为基底（定理 6.1）。
> 2. **系统计算**：$\Phi \in \mathrm{Lip}_L$ 本身满足扩展前提。取 $\varphi = \Phi$，则 $\Phi^l$ 等价于 $l-1$ 次自扩展——f-链运算是基底同构的特例。
> 3. **输入变更**：将输入从 $x$ 变更为 $\varphi(x)$，在代数上恰好是 $\Phi_\varphi(x) = \Phi(\varphi(x))$——输入端的任何操作都等价于一次基底扩展。
>
> 章标题"计算的基底同构"正是此意：**变换**是**计算**的泛化，而两者与**输入变更**一同，统一为基底扩展的实例。系统无法区分"外部施加了变换"与"内部多了一层基函数"——它们在 Lip 代价结构上完全等价。

### 6.2 扩展系统的误差界

$\varphi$-扩展系统中 $L' = LK$ 替代 $L$ 进入 §3–§4 的所有定量结论。

**命题 6.2（CAC 界的 $K$-传播）**：设 $\varphi \in \mathrm{Lip}_K$。扩展系统的 CAC 误差上界为：

$$\varepsilon^*_{q,\varphi} \;\leq\; (\varepsilon_{\max} + \rho_{\max} + \Delta_{\max}) \cdot \Lambda_l^\varphi \;+\; \delta_{\max} \cdot \Gamma_l^\varphi$$

其中 $\Lambda_l^\varphi$、$\Gamma_l^\varphi$ 以 $L'_j = L_j \cdot K$ 计算。由 $\Theta_{j,l}^\varphi = K^{l-j+1} \cdot \Theta_{j,l}$，有：

$$\Lambda_l^\varphi \;=\; \sum_{j=1}^l K^{l-j} \Theta_{j+1,l}, \qquad K < 1 \;\Rightarrow\; \bar{\varepsilon} \downarrow, \qquad K > 1 \;\Rightarrow\; \bar{\varepsilon} \uparrow$$

**证明**：§3 CAC 定理中 $L_j \to L'_j = L_jK$，递推结构不变。$\square$

**命题 6.3（CAB 界的 $K$-传播）**：设 $\varphi \in \mathrm{Lip}_K$。扩展系统的 CAB 误差下界为：

$$\varepsilon^*_{y,\varphi} \;\geq\; |\Delta_\varphi - \varepsilon_{\varphi,x}| \;-\; \Omega_{l,\varphi}(\delta)$$

其中 $\Omega_{l,\varphi}(\delta) = \Theta_{1,l}^\varphi \cdot \delta + \sum_j \Delta_{\sigma,j} \Theta_{j+1,l}^\varphi$。同样由 $\Theta^\varphi = K^{(\cdot)} \cdot \Theta$：

$$K < 1 \;\Rightarrow\; \Omega_{l,\varphi} < \Omega_l \;\Rightarrow\; \underline{\varepsilon} \uparrow, \qquad K > 1 \;\Rightarrow\; \Omega_{l,\varphi} > \Omega_l \;\Rightarrow\; \underline{\varepsilon} \downarrow$$

**证明**：§4 CAB 定理中 $L_j \to L_jK$，$\Omega_l$ 中各 $\Theta$ 项同步放缩。$\square$


**命题 6.4（SIB 界的 $K$-传播）**：SIB（§3.2 定理 3.13）在理想统计条件（$p=2$，$\tau_c=1$）下给出误差上界 $\sqrt{\mathbb{E}[\|E_l\|^2]} \leq \sqrt{\sum_{j=1}^l (\Theta_{j+1,l} \cdot \sqrt{\mathbb{E}[\|\epsilon_j\|^2]})^2}$。由于 SIB 是 CAC 的统计精化，其 $K$-传播方向与 CAC 一致：$\varphi$-扩展下 $\Theta_{j+1,l} \to \Theta_{j+1,l} \cdot K^{l-j}$，故：

$$K < 1 \;\Rightarrow\; \bar{\varepsilon}^{SIB} \downarrow, \qquad K > 1 \;\Rightarrow\; \bar{\varepsilon}^{SIB} \uparrow$$

SIB 的渐近阶 $\mathcal{O}(\sqrt{l})$ 不因 $K$ 改变（由 type-$p$ 与 $\tau_c$ 决定），但系数随 $K$ 放缩。

**证明**：$\Theta_{j+1,l}^\varphi = \prod_{k=j+1}^l (L_k K) = K^{l-j} \Theta_{j+1,l}$。代入 SIB 公式，各项乘以 $K^{l-j}$。$K < 1$ 时各项缩小，$K > 1$ 时各项放大。$\square$

**推论 6.5（$K$-窄化定理，$K$-Narrowing Theorem）**：记 $\bar{\varepsilon}_q$ 为 CAC 上界，$\bar{\varepsilon}^{SIB}_q$ 为 SIB 上界，$\underline{\varepsilon}_y$ 为 CAB 下界。$\varphi$-扩展后对应量记为 $\bar{\varepsilon}_{q,\varphi}$、$\bar{\varepsilon}^{SIB}_{q,\varphi}$、$\underline{\varepsilon}_{y,\varphi}$。则：

| 界 | $K < 1$ | $K > 1$ |
|---|---|---|
| CAC 上界 | $\bar{\varepsilon} \downarrow$ | $\bar{\varepsilon} \uparrow$ |
| SIB 上界 | $\bar{\varepsilon}^{SIB} \downarrow$ | $\bar{\varepsilon}^{SIB} \uparrow$ |
| CAB 下界 | $\underline{\varepsilon} \uparrow$ | $\underline{\varepsilon} \downarrow$ |


上界与下界**同向运动**。$K < 1$ 时 $\bar{\varepsilon} \downarrow$、$\underline{\varepsilon} \uparrow$：误差窗口 $[\underline{\varepsilon},\; \bar{\varepsilon}]$ 窄化但整体上移。$K > 1$ 时反之。不存在 $K \neq 1$ 使误差窗口单侧收缩。

> **注（窄化的物理意义）**：$K < 1$ 将系统映射到收缩空间，所有距离被 $K$ 倍压缩。上界下降因为误差传播被抑制（好），但下界上升因为系统分辨能力同步下降——不同目标之间的距离也被压缩，拟合精度的几何下限随之上升（坏）。两者不可分离。

> **注（恒等映射的唯一中性）**：$K = 1$（$\varphi = \mathrm{id}$）是唯一使 CAC/SIB/CAB 三个界均不变的点。任何非平凡的 $\varphi$ 必然在误差窗口的两端同时产生效应。

> **注（CAC 误差项的联合效应）**：CAC 递推（§3.1）中的采样偏移 $\delta_j$ 可视为 $1$-Lipschitz 的逐步基底扩展（$\varphi_j: h^*_{j-1} \mapsto x'_j$，最近采样点投影）。在 §3.1 的 (B) 项分解中，若定义 $\varepsilon'_j = d(\Phi(x'_j), r_{i_j}(h^*_{j-1}))$，则 $\varepsilon'_j$ 合并了 (III)（逼近误差 $\varepsilon_{i_j}$）与 (IV)（目标变分 $\rho_j$）为单一可观测量，$\varepsilon'_j \leq \varepsilon_{i_j} + \rho_j$（三角不等式严格成立时严格更小）。此合并本身改善有限，但揭示了 $\varepsilon$ 与 $\rho$ 并非独立叠加——它们的联合效应 $\varepsilon'_j$ 在通常情况下优于各自上界之和。

**命题 6.6（CEL 增长率的 co-Lipschitz 调制）**：设 $\varphi$ 为 $K$-Lipschitz 且在 $A_\varphi \subseteq \mathcal{X}$ 上 $k_\varphi$-co-Lipschitz（$k_\varphi \leq K$）。设 CEL（定理 4.5）成立，$\Phi$ 的各步路径 co-Lip 常数为 $k_j$。设 $h_{j-1}, h^*_{j-1} \in A_\varphi$。则扩展系统 $\Phi_\varphi = \Phi \circ \varphi$ 的 CEL 递推中，有效 co-Lip 常数从 $k_j$ 变为 $k_j \cdot k_\varphi$：

$$e_j \;\geq\; k_j \cdot k_\varphi \cdot e_{j-1} \;-\; \Delta^{co}_j \;-\; \varepsilon^\varphi_j$$

其中 $\varepsilon^\varphi_j$ 为扩展系统在理想轨道点处的拟合误差。闭式下界中的增长率从 $k_{\min}^{l-1}$ 变为 $(k_{\min} \cdot k_\varphi)^{l-1}$：$k_\varphi > 1$ 时放大，$k_\varphi < 1$ 时衰减。

**证明**：扩展系统 $\Phi_\varphi = \Phi \circ \varphi$。$\varphi$ 的 $k_\varphi$-co-Lipschitz 保证 $d(\varphi(h_{j-1}), \varphi(h^*_{j-1})) \geq k_\varphi \cdot e_{j-1}$。$\Phi$ 对 $\varphi$ 输出应用路径 co-Lip $k_j$，贡献乘性因子 $k_j$。两者合成得 $k_j \cdot k_\varphi$，路由失配与拟合误差按原 CEL 结构扣除。$\square$

> **注（CEL 由 $k_\varphi$ 而非 $K$ 驱动）**：CEL 的增长率取决于 $k_\varphi$（$\varphi$ 的 co-Lip），而非 $K$（$\varphi$ 的 Lip）。二者的约束 $k_\varphi \leq K$ 意味着 $K < 1$ 蕴含 $k_\varphi < 1$（增长必然衰减），但 $K > 1$ 不蕴含 $k_\varphi > 1$（增长放大取决于 $\varphi$ 的具体结构）。因此 CEL 调制是推论 6.5 中 $K$-窄化之外的**独立维度**，需要额外的 co-Lip 假设。

> **注（SLB 的 $k_\varphi$-调制）**：统计下界 SLB（§4.3 定理 4.6）在 $\varphi$-扩展下的传播与 CEL 一致。SLB 中 $\kappa_l = \sigma_{\min}(T_{1,l})$ 在扩展后变为 $\kappa_l^\varphi = \sigma_{\min}(T_{1,l}^\varphi)$，由 $\sigma_{\min}(D\Phi \cdot D\varphi) \geq \sigma_{\min}(D\Phi) \cdot \sigma_{\min}(D\varphi)$，得 $\kappa_l^\varphi \geq k_\varphi^l \cdot \kappa_l$。噪声消耗项的 type-$p$ 缩减阶 $\mathcal{O}(\tau_c^{1-1/p} l^{1/p})$ 不受 $k_\varphi$ 影响。故 SLB 的 $k_\varphi$-调制与 CEL 同向：$k_\varphi > 1$ 时下界抬高，$k_\varphi < 1$ 时下界降低。


### 6.3 误差再分配

**命题 6.7（误差再分配，Error Redistribution）**：基底扩展的逐点误差 $e_\varphi(x) = d(\Phi(\varphi(x)), r(x))$ 与原始误差 $e(x) = d(\Phi(x), r(x))$ 之间不存在逐点单调关系。具体地，存在 $(\Phi, r, \varphi)$ 的构型，使得改善集 $\{x : e_\varphi(x) < e(x)\}$ 与恶化集 $\{x : e_\varphi(x) > e(x)\}$ 同时非空——即使 $K = 1$（所有全局界不变）。

**证明**（构造性）：设 $\Phi \in \mathrm{Lip}_L(\mathcal{X})$ 对目标 $r$ 的拟合误差在 $\mathcal{X}$ 上非均匀：存在非空子集 $A, B \subseteq \mathcal{X}$，$A \cap B = \emptyset$，使得 $e(x) \leq \tau$（$x \in A$）且 $e(x) > \tau$（$x \in B$）。取 $\varphi \in \mathrm{Lip}_K(\mathcal{X})$ 满足以下两条件：

1. **目标 $\varphi$-不变性**：$r \circ \varphi = r$（即 $r(\varphi(x)) = r(x)$，$\forall x$）；
2. **区域交换**：$\varphi(B) \subseteq A$ 且 $\varphi(A) \subseteq B$。

由条件 1，扩展误差化简为：$e_\varphi(x) = d(\Phi(\varphi(x)), r(x)) = d(\Phi(\varphi(x)), r(\varphi(x))) = e(\varphi(x))$。

由条件 2：
- $x_1 \in B$：$e_\varphi(x_1) = e(\varphi(x_1)) \leq \tau < e(x_1)$——**改善**。
- $x_2 \in A$：$e_\varphi(x_2) = e(\varphi(x_2)) > \tau \geq e(x_2)$——**恶化**。

当 $\varphi$ 为等距映射时 $K = 1$，推论 6.5 的三个界全部不变，但逐点误差分布已完全重新洗牌。$\square$

**示例**：$\mathcal{X} = \mathbb{R}$，$\Phi(x) = \max(0, x)$，$r(x) = |x|$，$\varphi(x) = -x$（$K = 1$）。原始误差：$e(x) = 0$（$x \geq 0$），$e(x) = |x|$（$x < 0$）。扩展后：$e_\varphi(x) = |x|$（$x \geq 0$），$e_\varphi(x) = 0$（$x < 0$）。误差从负半轴完整搬运至正半轴。

### 6.4 复合扩展

**命题 6.8（复合扩展的 Lip 链式法则）**：设 $\varphi_1, \varphi_2, \ldots, \varphi_n$ 为 $n$ 次依序扩展。则复合扩展系统 $\mathcal{F}_{\varphi_1 \circ \cdots \circ \varphi_n}$ 的全局 Lip 常数为：

$$L'_n \;=\; L \cdot \prod_{i=1}^{n} K_i, \qquad K_i = \mathrm{Lip}(\varphi_i)$$

**证明**：归纳应用定理 6.1。$\square$

**推论 6.9（扩展次数的物理上限）**：设系统需维持安全链深 $l^*_0 \geq l_{\min}$。由 $l^*_0 = \tau / E$ 且 $E$ 含 $L_{max}$（§3 CAC），扩展后 $L'_{max} = L_{max} \cdot \prod K_i$，$E$ 相应增大。设 $L'_{\sup}$ 为使 $l^*_0 \geq l_{\min}$ 成立的最大允许全局 Lip 常数，则可行扩展次数 $n$ 满足：

$$\prod_{i=1}^{n} K_i \;\leq\; \frac{L'_{\sup}}{L}$$

每次扩展消耗 Lip 预算，总预算有限。

### 6.5 全局偏置与条件偏置

**定义（全局偏置与条件偏置，Global vs. Conditional Bias）**：

- **全局偏置**：$\sigma_\varphi(x) = \sigma(\varphi(x)) \circ \varphi$，对所有 $x \in \mathcal{X}$ 一致挂载。
- **条件偏置**：设 $\mathcal{X}_{ctx} \subset \mathcal{X}$，定义：

$$\sigma'(x) \;=\; \begin{cases} \sigma(\varphi(x)) \circ \varphi & x \in \mathcal{X}_{ctx} \\ \sigma(x) & x \notin \mathcal{X}_{ctx} \end{cases}$$

条件偏置仅在子集 $\mathcal{X}_{ctx}$ 上激活扩展，其余区域保持原系统。

**命题 6.10（条件偏置的 Lip 不连续性）**：条件偏置系统 $\Phi'$ 在边界 $\partial \mathcal{X}_{ctx}$ 上一般不满足全局 Lip 条件。设 $x \in \mathcal{X}_{ctx}$，$y \notin \mathcal{X}_{ctx}$，$d(x,y) \to 0$，则：

$$d(\Phi'(x), \Phi'(y)) \;=\; d(\Phi(\varphi(x)),\, \Phi(y))$$

由 $\Phi$ 的连续性，当 $y \to x$ 时 $\Phi(y) \to \Phi(x)$，故 $d(\Phi'(x), \Phi'(y)) \to d(\Phi(\varphi(x)), \Phi(x))$。当 $\varphi(x) \neq x$ 时，$d(\Phi(\varphi(x)), \Phi(x)) > 0$（一般情况），而 $d(x,y) \to 0$，故 $\Phi'$ 在 $x$ 处不连续，跳变幅度不超过 $L \cdot d(\varphi(x), x)$。因此条件偏置的合法化需要 $\varphi$ 在 $\partial \mathcal{X}_{ctx}$ 附近满足连续过渡条件：$\varphi(x) \to x$（$x \to \partial \mathcal{X}_{ctx}$）。$\square$

> **注（全局偏置与条件偏置的结构对比）**：
>
> | 维度 | 全局偏置 | 条件偏置 |
> |---|---|---|
> | 连续性 | $\Phi_\varphi \in \mathrm{Lip}_{LK}$，无新边界 | $\partial \mathcal{X}_{ctx}$ 处产生 Lip 跳变（命题 6.10） |
> | 代价范围 | **全域**承受 $K$ 乘法代价 | 仅 $\mathcal{X}_{ctx}$ 内承受代价，其余区域保持原系统 |
> | CAC/CAB 传播 | 全域 $L' = LK$ | $\mathcal{X}_{ctx}$ 内 $L' = LK$，外部 $L' = L$ |
> | 路由结构 | 不引入新决策边界 | 边界跳变等价于新 $\sigma$-决策边界，受命题 2.7 约束 |
>
> 两者各有适用域：全局偏置以全域 $K$ 代价换取连续性保证；条件偏置以边界不连续为代价换取非目标区域的零代价。选择取决于 $\mathcal{X}_{ctx}$ 相对于 $\mathcal{X}$ 的测度占比和边界跳变的可控性。


