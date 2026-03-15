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
3. 由 §2.1 引理 2.1，将 $L$ 替换为 $L' = LK$ 即得。$\square$

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

**推论 6.6（$K$-不可能定理）**：四个界关于 $K$ 的单调方向如下：

| 界 | 类型 | $K < 1$ | $K > 1$ |
|---|---|---|---|
| CAC | 上界 | 收紧（保证增强） | 松弛（保证减弱） |
| CAB | 下界 | 收紧（约束更严） | 松弛（约束放松） |
| CPI | 下界 | 放松 | 更严 |
| DFG | 下界 | 更严 | 放松 |

任意两行中，$K < 1$ 与 $K > 1$ 列不同时全为有利方向。因此不存在 $K \neq 1$ 使所有界同时改善。

> **注（恒等映射的唯一中性）**：$K = 1$（$\varphi = \mathrm{id}$）是唯一使上述四个界均不变的点。任何非平凡的 $\varphi$ 必然在至少一个界上产生代价。

**定理 6.10（逐点代价转移，Pointwise Cost Transfer）**：设 $r$ 具有 $(\beta, k)$-局部判别性，$\varphi \in \mathrm{Lip}_K$，$K < 1$，且 $k > L_{local} \cdot K$。记精度 $\tau$ 下的不可拟合集为：

$$U_\tau = \{x : d(\Phi(x), r(x)) > \tau\}, \qquad U_\tau^\varphi = \{x : d(\Phi_\varphi(x), r(x)) > \tau\}$$

若 $\varphi$ 改善了某点（$\exists\, x_1 \in U_\tau \setminus U_\tau^\varphi$），则必存在被劣化的点（$\exists\, x_2 \in U_\tau^\varphi \setminus U_\tau$）。

**证明**：

1. 由 DFG（§4.3），原系统不可拟合集测度：$\mu(U_\tau) \geq \beta \cdot \mu(\mathcal{X}_r) - |\mathrm{Im}(\sigma)| \cdot c_D^+ \cdot \bigl(\frac{2\tau}{k - L_{local}}\bigr)^D \triangleq B_0$。
2. 扩展系统中 $L'_{local} = L_{local}K$，DFG 给出：$\mu(U_\tau^\varphi) \geq \beta \cdot \mu(\mathcal{X}_r) - |\mathrm{Im}(\sigma)| \cdot c_D^+ \cdot \bigl(\frac{2\tau}{k - L_{local}K}\bigr)^D \triangleq B_\varphi$。
3. 由 $K < 1$：$k - L_{local}K > k - L_{local}$ $\Rightarrow$ $\bigl(\frac{2\tau}{k - L_{local}K}\bigr)^D < \bigl(\frac{2\tau}{k - L_{local}}\bigr)^D$ $\Rightarrow$ $B_\varphi > B_0$。
4. 若 $\exists\, x_1 \in U_\tau \setminus U_\tau^\varphi$（被救出），但 $U_\tau^\varphi \setminus U_\tau = \emptyset$（无劣化点），则 $U_\tau^\varphi \subseteq U_\tau \setminus \{x_1, \ldots\}$，$\mu(U_\tau^\varphi) \leq \mu(U_\tau) - \mu(\{x_1\})$。然而 $B_\varphi > B_0$ 要求 $\mu(U_\tau^\varphi) \geq B_\varphi > B_0 \leq \mu(U_\tau)$——当 DFG 下界紧致时矛盾。故 $U_\tau^\varphi \setminus U_\tau \neq \emptyset$。$\square$

> **注（代价转移的不等价性）**：DFG 下界的增长量 $B_\varphi - B_0 > 0$ 意味着被劣化的总测度**严格大于**被改善的总测度。$\varphi$ 的介入不是零和博弈——它是**负和**的：每改善一单位面积，至少劣化更多面积。

### 6.3 复合扩展

**命题 6.7（复合扩展的 Lip 链式法则）**：设 $\varphi_1, \varphi_2, \ldots, \varphi_n$ 为 $n$ 次依序扩展。则复合扩展系统 $\mathcal{F}_{\varphi_1 \circ \cdots \circ \varphi_n}$ 的全局 Lip 常数为：

$$L'_n \;=\; L \cdot \prod_{i=1}^{n} K_i, \qquad K_i = \mathrm{Lip}(\varphi_i)$$

**证明**：归纳应用定理 6.1。$\square$

**推论 6.8（扩展次数的物理上限）**：设系统需维持 $l^*_0 \geq l_{\min}$。由 $l^*_{0,n} = \tau / E_n$ 及 $E_n$ 随 $L'_n$ 单调递增，可行扩展次数 $n$ 满足：

$$\prod_{i=1}^{n} K_i \;\leq\; \frac{L'_{\max}}{L}$$

其中 $L'_{\max}$ 为使 $l^*_{0,n} \geq l_{\min}$ 的最大允许 Lip 常数。每次扩展消耗 Lip 预算，总预算有限。

### 6.4 全局偏置与条件偏置

**定义（全局偏置与条件偏置，Global vs. Conditional Bias）**：

- **全局偏置**：$\sigma_\varphi(x) = \sigma(\varphi(x)) \circ \varphi$，对所有 $x \in \mathcal{X}$ 一致挂载。
- **条件偏置**：设 $\mathcal{X}_{ctx} \subset \mathcal{X}$，定义：

$$\sigma'(x) \;=\; \begin{cases} \sigma(\varphi(x)) \circ \varphi & x \in \mathcal{X}_{ctx} \\ \sigma(x) & x \notin \mathcal{X}_{ctx} \end{cases}$$

条件偏置仅在子集 $\mathcal{X}_{ctx}$ 上激活扩展，其余区域保持原系统。

**命题 6.9（条件偏置的 Lip 不连续性）**：条件偏置系统 $\Phi'$ 在边界 $\partial \mathcal{X}_{ctx}$ 上一般不满足全局 Lip 条件。设 $x \in \mathcal{X}_{ctx}$，$y \notin \mathcal{X}_{ctx}$，$d(x,y) \to 0$，则：

$$d(\Phi'(x), \Phi'(y)) \;=\; d(\Phi(\varphi(x)),\, \Phi(y))$$

当 $\varphi(x) \neq x$ 时，此距离一般不趋于零，$\Phi'$ 在 $\partial \mathcal{X}_{ctx}$ 上产生不连续跳变。因此条件偏置的合法化需要 $\varphi$ 在 $\partial \mathcal{X}_{ctx}$ 附近满足连续过渡条件：$\varphi(x) \to x$（$x \to \partial \mathcal{X}_{ctx}$）。

> **注（全局偏置的结构优势）**：全局偏置不引入新的边界不连续，其 Lip 代价完全由 $K$ 的乘法因子吸收。条件偏置虽然在局部保留了原系统行为，但在边界处产生的 Lip 跳变等价于引入新的 $\sigma$-决策边界——由命题 2.9（路由分辨率极限），跳变幅度受 $\Delta/L'$ 约束。

