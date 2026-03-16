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

### 6.2 扩展系统的误差界

$\varphi$-扩展系统中 $L' = LK$ 替代 $L$ 进入 §3–§4 的所有定量结论。

**命题 6.2（CAC 界的 $K$-传播）**：设 $\varphi \in \mathrm{Lip}_K$。扩展系统的 CAC 误差上界为：

$$\varepsilon^*_{q,\varphi} \;\leq\; (\varepsilon_{\max} + \rho_{\max} + \Delta_{\max}) \cdot \Lambda_l^\varphi \;+\; \delta_{\max} \cdot \Gamma_l^\varphi$$

其中 $\Lambda_l^\varphi$、$\Gamma_l^\varphi$ 以 $L'_j = L_j \cdot K$ 计算。由 $\Theta_{j,l}^\varphi = K^{l-j+1} \cdot \Theta_{j,l}$，有：

$$\Lambda_l^\varphi \;=\; K \cdot \Lambda_l + O(K^l), \qquad K < 1 \;\Rightarrow\; \Lambda_l^\varphi < \Lambda_l, \qquad K > 1 \;\Rightarrow\; \Lambda_l^\varphi > \Lambda_l$$

$K < 1$ 收紧上界（保证增强）。$K > 1$ 松弛上界（保证减弱，但上界未必可达，故不意味实际误差增大）。

**证明**：§3 CAC 定理中 $L_j \to L'_j = L_jK$，递推结构不变。$\square$

**命题 6.3（CAB 界的 $K$-传播）**：设 $\varphi \in \mathrm{Lip}_K$。扩展系统的 CAB 误差下界为：

$$\varepsilon^*_{y,\varphi} \;\geq\; |\Delta_\varphi - \varepsilon_{\varphi,x}| \;-\; \Omega_{l,\varphi}(\delta)$$

其中 $\Omega_{l,\varphi}(\delta) = \Theta_{1,l}^\varphi \cdot \delta + \sum_j \Delta_{\sigma,j} \Theta_{j+1,l}^\varphi$。同样由 $\Theta^\varphi = K^{(\cdot)} \cdot \Theta$：

$$K < 1 \;\Rightarrow\; \Omega_{l,\varphi} < \Omega_l \;\Rightarrow\; \text{下界增大（判别性约束更严）}$$
$$K > 1 \;\Rightarrow\; \Omega_{l,\varphi} > \Omega_l \;\Rightarrow\; \text{下界减小（判别性约束放松）}$$

**证明**：§4 CAB 定理中 $L_j \to L_jK$，$\Omega_l$ 中各 $\Theta$ 项同步放缩。$\square$

**命题 6.4（CPI 界的 $K$-传播）**：CPI 定理（§4.2）要求 $|\mathrm{Im}(\sigma)| \geq \mathcal{N}(A, 2\epsilon/k) / \mathcal{N}(A, \epsilon/L_{local})$。在 $\varphi$-扩展下，$\mathrm{Im}(\sigma_\varphi) = \mathrm{Im}(\sigma)$（路由像集不变），但 $L'_{local} = L_{local} \cdot K$：

$$K > 1 \;\Rightarrow\; \mathcal{N}(A,\, \epsilon/(L_{local}K)) \;>\; \mathcal{N}(A,\, \epsilon/L_{local}) \;\Rightarrow\; \text{所需最小路由分支数增大}$$
$$K < 1 \;\Rightarrow\; \mathcal{N}(A,\, \epsilon/(L_{local}K)) \;<\; \mathcal{N}(A,\, \epsilon/L_{local}) \;\Rightarrow\; \text{约束放松}$$

**证明**：覆盖数 $\mathcal{N}(A, r)$ 关于 $r$ 单调递减，$\epsilon/(L_{local}K)$ 随 $K$ 增大而减小。$\square$

**命题 6.5（DFG 界的 $K$-传播）**：DFG 定理（§4.3）不可拟合集的测度下界含项 $(2\tau/(k - L_{local}))^D$。在 $\varphi$-扩展下 $L'_{local} = L_{local} K$：

- $K > 1 \Rightarrow k - L'_{local} < k - L_{local}$，成功集直径增大，测度下界减小（约束放松）。当 $L_{local}K \geq k$ 时，DFG 前提 $k > L_{local}$ 被破坏，定理不适用。
- $K < 1 \Rightarrow k - L'_{local} > k - L_{local}$，成功集收缩，测度下界增大（约束更严）。

**命题 6.6（SIB 界的 $K$-不变性）**：SIB 定理（§3.2）的下界取决于目标集 $\mathcal{S}$ 的度量熵 $I_\varepsilon(\mathcal{S})$，这是 $\mathcal{S}$ 的内禀性质，与系统的 Lipschitz 常数 $L$ 无关。$\varphi$-扩展将 $L \to LK$，但 $I_\varepsilon(\mathcal{S})$ 不变。因此 SIB 下界在任意基底扩展下严格不变。

**推论 6.7（$K$-不可能定理）**：五个界关于 $K$ 的单调方向如下：

| 界 | 类型 | $K < 1$ | $K > 1$ |
|---|---|---|---|
| CAC | 上界 | 收紧（保证增强） | 松弛（保证减弱） |
| CAB | 下界 | 收紧（约束更严） | 松弛（约束放松） |
| CPI | 下界 | 放松 | 更严 |
| DFG | 下界 | 更严 | 放松 |
| **SIB** | **下界** | **不变** | **不变** |

CAC/CAB/CPI/DFG 中任意两行的 $K < 1$ 与 $K > 1$ 列不同时全为有利方向。因此不存在 $K \neq 1$ 使所有界同时改善。SIB 是唯一对 $\varphi$ 完全免疫的界——它由任务的内禀信息复杂度决定，系统端的任何预变换无法改变。

> **注（恒等映射的唯一中性）**：$K = 1$（$\varphi = \mathrm{id}$）是唯一使 CAC/CAB/CPI/DFG 四个界均不变的点。任何非平凡的 $\varphi$ 必然在至少一个界上产生代价。

**命题 6.8（误差再分配，Error Redistribution）**：基底扩展的逐点误差 $e_\varphi(x) = d(\Phi(\varphi(x)), r(x))$ 与原始误差 $e(x) = d(\Phi(x), r(x))$ 之间不存在逐点单调关系。具体地，存在 $(\Phi, r, \varphi)$ 的构型，使得改善集 $\{x : e_\varphi(x) < e(x)\}$ 与恶化集 $\{x : e_\varphi(x) > e(x)\}$ 同时非空——即使 $K = 1$（所有五个全局界不变）。

**证明**（构造性）：设 $\Phi \in \mathrm{Lip}_L(\mathcal{X})$ 对目标 $r$ 的拟合误差在 $\mathcal{X}$ 上非均匀：存在非空子集 $A, B \subseteq \mathcal{X}$，$A \cap B = \emptyset$，使得 $e(x) \leq \tau$（$x \in A$）且 $e(x) > \tau$（$x \in B$）。取 $\varphi \in \mathrm{Lip}_K(\mathcal{X})$ 满足以下两条件：

1. **目标 $\varphi$-不变性**：$r \circ \varphi = r$（即 $r(\varphi(x)) = r(x)$，$\forall x$）；
2. **区域交换**：$\varphi(B) \subseteq A$ 且 $\varphi(A) \subseteq B$。

由条件 1，扩展误差化简为：$e_\varphi(x) = d(\Phi(\varphi(x)), r(x)) = d(\Phi(\varphi(x)), r(\varphi(x))) = e(\varphi(x))$。

由条件 2：
- $x_1 \in B$：$e_\varphi(x_1) = e(\varphi(x_1)) \leq \tau < e(x_1)$——**改善**。
- $x_2 \in A$：$e_\varphi(x_2) = e(\varphi(x_2)) > \tau \geq e(x_2)$——**恶化**。

当 $\varphi$ 为等距映射时 $K = 1$，推论 6.7 的五个界全部不变，但逐点误差分布已完全重新洗牌。$\square$

**示例**：$\mathcal{X} = \mathbb{R}$，$\Phi(x) = \max(0, x)$，$r(x) = |x|$，$\varphi(x) = -x$（$K = 1$）。原始误差：$e(x) = 0$（$x \geq 0$），$e(x) = |x|$（$x < 0$）。扩展后：$e_\varphi(x) = |x|$（$x \geq 0$），$e_\varphi(x) = 0$（$x < 0$）。误差从负半轴完整搬运至正半轴。

### 6.3 复合扩展

**命题 6.9（复合扩展的 Lip 链式法则）**：设 $\varphi_1, \varphi_2, \ldots, \varphi_n$ 为 $n$ 次依序扩展。则复合扩展系统 $\mathcal{F}_{\varphi_1 \circ \cdots \circ \varphi_n}$ 的全局 Lip 常数为：

$$L'_n \;=\; L \cdot \prod_{i=1}^{n} K_i, \qquad K_i = \mathrm{Lip}(\varphi_i)$$

**证明**：归纳应用定理 6.1。$\square$

**推论 6.10（扩展次数的物理上限）**：设系统需维持安全链深 $l^*_0 \geq l_{\min}$。由 $l^*_0 = \tau / E$ 且 $E$ 含 $L_{max}$（§3 CAC），扩展后 $L'_{max} = L_{max} \cdot \prod K_i$，$E$ 相应增大。设 $L'_{\sup}$ 为使 $l^*_0 \geq l_{\min}$ 成立的最大允许全局 Lip 常数，则可行扩展次数 $n$ 满足：

$$\prod_{i=1}^{n} K_i \;\leq\; \frac{L'_{\sup}}{L}$$

每次扩展消耗 Lip 预算，总预算有限。

### 6.4 全局偏置与条件偏置

**定义（全局偏置与条件偏置，Global vs. Conditional Bias）**：

- **全局偏置**：$\sigma_\varphi(x) = \sigma(\varphi(x)) \circ \varphi$，对所有 $x \in \mathcal{X}$ 一致挂载。
- **条件偏置**：设 $\mathcal{X}_{ctx} \subset \mathcal{X}$，定义：

$$\sigma'(x) \;=\; \begin{cases} \sigma(\varphi(x)) \circ \varphi & x \in \mathcal{X}_{ctx} \\ \sigma(x) & x \notin \mathcal{X}_{ctx} \end{cases}$$

条件偏置仅在子集 $\mathcal{X}_{ctx}$ 上激活扩展，其余区域保持原系统。

**命题 6.11（条件偏置的 Lip 不连续性）**：条件偏置系统 $\Phi'$ 在边界 $\partial \mathcal{X}_{ctx}$ 上一般不满足全局 Lip 条件。设 $x \in \mathcal{X}_{ctx}$，$y \notin \mathcal{X}_{ctx}$，$d(x,y) \to 0$，则：

$$d(\Phi'(x), \Phi'(y)) \;=\; d(\Phi(\varphi(x)),\, \Phi(y))$$

由 $\Phi$ 的连续性，当 $y \to x$ 时 $\Phi(y) \to \Phi(x)$，故 $d(\Phi'(x), \Phi'(y)) \to d(\Phi(\varphi(x)), \Phi(x))$。当 $\varphi(x) \neq x$ 时，$d(\Phi(\varphi(x)), \Phi(x)) > 0$（一般情况），而 $d(x,y) \to 0$，故 $\Phi'$ 在 $x$ 处不连续，跳变幅度不超过 $L \cdot d(\varphi(x), x)$。因此条件偏置的合法化需要 $\varphi$ 在 $\partial \mathcal{X}_{ctx}$ 附近满足连续过渡条件：$\varphi(x) \to x$（$x \to \partial \mathcal{X}_{ctx}$）。$\square$

> **注（全局偏置与条件偏置的结构对比）**：
>
> | 维度 | 全局偏置 | 条件偏置 |
> |---|---|---|
> | 连续性 | $\Phi_\varphi \in \mathrm{Lip}_{LK}$，无新边界 | $\partial \mathcal{X}_{ctx}$ 处产生 Lip 跳变（命题 6.9） |
> | 代价范围 | **全域**承受 $K$ 乘法代价 | 仅 $\mathcal{X}_{ctx}$ 内承受代价，其余区域保持原系统 |
> | CAC/CAB 传播 | 全域 $L' = LK$ | $\mathcal{X}_{ctx}$ 内 $L' = LK$，外部 $L' = L$ |
> | 路由结构 | 不引入新决策边界 | 边界跳变等价于新 $\sigma$-决策边界，受命题 2.7 约束 |
>
> 两者各有适用域：全局偏置以全域 $K$ 代价换取连续性保证；条件偏置以边界不连续为代价换取非目标区域的零代价。选择取决于 $\mathcal{X}_{ctx}$ 相对于 $\mathcal{X}$ 的测度占比和边界跳变的可控性。

