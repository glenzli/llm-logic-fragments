## §9 计算纤维

§8 建立了 Type II 系统的分段复合架构与误差传播理论。本节退回到更基础的层面，建立一套基于**计算纤维**的分析工具，揭示 IDFS 在定义域扩张、误差控制、链深约束等现象背后的信息论结构。

### 9.1 映射的计算纤维

#### 定义（$\varepsilon$-计算纤维，$\varepsilon$-Computational Fiber）

设 $\phi \in \Omega$，$y \in \mathrm{Im}(\phi)$，$\varepsilon \geq 0$。定义 $y$ 在 $\phi$ 下的 **$\varepsilon$-计算纤维** 为所有 $\phi$-输出落入 $y$ 的 $\varepsilon$-邻域的输入点集合：

$$\mathfrak{F}_\phi^\varepsilon(y) \;\triangleq\; \{x \in \mathrm{dom}(\phi) \mid d(\phi(x), y) \leq \varepsilon\}$$

$\varepsilon = 0$ 时退化为**精确计算纤维** $\mathfrak{F}_\phi(y) \triangleq \mathfrak{F}_\phi^0(y) = \{x \mid \phi(x) = y\}$，其中所有点从 $\phi$ 的角度**计算不可区分**。$\varepsilon > 0$ 时，纤维中的点在精度 $\varepsilon$ 下产生近似不可区分的输出。$\{\mathfrak{F}_\phi^0(y)\}_{y \in \mathrm{Im}(\phi)}$ 构成 $\mathrm{dom}(\phi)$ 的划分。

> **注（纤维的不可知性）**：纤维的存在不预设任何关于"为什么"这些点产生相同（或近似相同）输出的假说。定义本身是纯度量空间的——只用了 $d(\phi(x), y) \leq \varepsilon$ 这一不等式。

#### 定义（纤维宽度，Fiber Width）

对 $y \in \mathrm{Im}(\phi)$，定义纤维 $\mathfrak{F}_\phi(y)$ 的**宽度**为其直径：

$$w_\phi(y) \;\triangleq\; \mathrm{diam}(\mathfrak{F}_\phi(y)) = \sup_{x, x' \in \mathfrak{F}_\phi(y)} d(x, x')$$

纤维宽度度量在保持输出不变的前提下，输入最多可以偏移多远。宽纤维意味着 $\phi$ 的计算对输入的大范围变异不敏感。

---

### 9.2 局部横截 Lipschitz 常数

广义 Lipschitz 常数 $L_\phi = \sup d(\phi(x), \phi(y)) / d(x, y) \in \bar{\mathbb{R}}_+$（§1.2）对所有点对一视同仁。纤维结构揭示了更精细的图景：纤维内 $\phi$ 是常值映射（Lip = 0），$\phi$ 的灵敏度仅体现在**不同纤维之间的位移**，且不同纤维处的灵敏度一般不同。

#### 定义（局部横截 Lipschitz 常数，Local Transversal Lipschitz Constant）

设 $\phi \in \Omega$，$y \in \mathrm{Im}(\phi)$。定义 $\phi$ 在 $y$ 处的**局部横截 Lipschitz 常数**：

$$L^\perp_\phi(y) \;\triangleq\; \sup_{y' \neq y \in \mathrm{Im}(\phi)} \frac{d(y, y')}{d_\perp(\mathfrak{F}_\phi(y), \mathfrak{F}_\phi(y'))} \;\in\; \bar{\mathbb{R}}_+$$

其中 $d_\perp(\mathfrak{F}_\phi(y), \mathfrak{F}_\phi(y')) = \inf_{x \in \mathfrak{F}_\phi(y),\, x' \in \mathfrak{F}_\phi(y')} d(x, x')$ 为两根纤维之间的最小距离。

$L^\perp_\phi(y)$ 度量的是：从纤维 $\mathfrak{F}_\phi(y)$ 出发，将输入移动到其他纤维所需的**最小位移**与对应输出变化之比。它是 $y$ 的函数——不同纤维处的横截灵敏度一般不同。全局广义 Lip 是所有局部横截 Lip 的上确界：

$$L_\phi \;=\; \sup_{y \in \mathrm{Im}(\phi)} L^\perp_\phi(y)$$

在链复合的误差传播中，当具体的中间输出值 $y$ 已知时，可用 $L^\perp_\phi(y) \leq L_\phi$ 给出更紧的局部界。


---

### 9.3 计算多样性与纤维膨胀

映射 $\phi$ 的**表观复杂度**由 $\mathrm{dom}(\phi)$ 的度量熵衡量——有多少可区分的输入。但 $\phi$ 实际执行了多少**不同的计算**，由其像集 $\mathrm{Im}(\phi)$ 的度量熵衡量——有多少可区分的输出。

#### 定义（计算多样性，Computational Diversity）

对 $\phi \in \Omega$ 和精度 $\varepsilon > 0$，定义 $\phi$ 的**计算多样性**：

$$\mathcal{D}_\varepsilon(\phi) \;\triangleq\; \log \mathcal{N}(\varepsilon, \mathrm{Im}(\phi))$$

#### 定义（纤维膨胀量，Fiber Inflation）

定义 $\phi$ 的**纤维膨胀量**为输入域与像集在度量熵上的差距：

$$\mathrm{FI}_\varepsilon(\phi) \;\triangleq\; \log \mathcal{N}(\varepsilon, \mathrm{dom}(\phi)) - \log \mathcal{N}(\varepsilon, \mathrm{Im}(\phi))$$

当 $\phi$ 为同一度量空间上的自映射（$\mathrm{Im}(\phi) \subseteq \mathrm{dom}(\phi)$，本理论中 $\Omega$ 的标准设定）时，$\mathrm{Im}(\phi)$ 是 $\mathrm{dom}(\phi)$ 的子集，故 $\mathcal{N}(\varepsilon, \mathrm{Im}(\phi)) \leq \mathcal{N}(\varepsilon, \mathrm{dom}(\phi))$，从而 $\mathrm{FI}_\varepsilon(\phi) \geq 0$ 恒成立。$\mathrm{FI}_\varepsilon(\phi) = 0$ 当且仅当 $\mathrm{dom}(\phi)$ 与 $\mathrm{Im}(\phi)$ 在 $\varepsilon$-尺度上具有相同的度量熵——每个可区分的输入产生一个可区分的输出，无冗余。

> **注（纤维膨胀是结构事实，非效率判断）**：某些任务本身就要求多对一映射（如分类），此时 $\mathrm{FI} > 0$ 是目标函数的固有性质。

#### 定义（纤维余维，Fiber Codimension）

对 $\phi \in \Omega$ 和精度 $\varepsilon > 0$，定义 $\phi$ 的**纤维余维**为纤维膨胀量的归一化形式：

$$\mathrm{codim}_\varepsilon(\phi) \;\triangleq\; \frac{\mathrm{FI}_\varepsilon(\phi)}{\log(1/\varepsilon)}$$

$\mathrm{codim}_\varepsilon(\phi)$ 度量 $\phi$ 在 $\varepsilon$-尺度上**有效坍缩的度量维数**。FI 是信息论量（依赖 $\varepsilon$ 的绝对值），codim 是几何量（对 $\varepsilon$ 归一化后近似为常数——当定义域和像集的度量熵随 $\log(1/\varepsilon)$ 线性增长时，$\mathrm{codim}_\varepsilon$ 随 $\varepsilon \to 0$ 趋于稳定极限，即 Minkowski 余维；当该极限不存在时，$\mathrm{codim}_\varepsilon$ 仍为精度 $\varepsilon$ 下的有效坍缩维数）。

**命题 9.1（Lipschitz 映射的纤维膨胀下界）**：设 $\phi$ 的广义 Lip 常数 $L_\phi < \infty$。则：

$$\mathrm{FI}_\varepsilon(\phi) \;\geq\; \log \mathcal{N}(\varepsilon, \mathrm{dom}(\phi)) - \log \mathcal{N}(\varepsilon/L_\phi, \mathrm{dom}(\phi))$$

**证明**：$\phi \in \mathrm{Lip}_{L_\phi}$ 蕴含 $\phi$ 将 $\mathrm{dom}(\phi)$ 中的 $\varepsilon/L_\phi$-球映射到 $\varepsilon$-球内。因此 $\mathcal{N}(\varepsilon, \mathrm{Im}(\phi)) \leq \mathcal{N}(\varepsilon/L_\phi, \mathrm{dom}(\phi))$。$\square$

---

### 9.4 三纤维不可区分定理

本节将纤维分析应用到 IDFS 拟合的核心结构——$r_j$、$\sigma$、$f$-chain 三者的纤维交集——揭示 $\mathrm{dom}(r_j)$ 上拟合扩张的一种基本机制。

#### 设定

设系统 $\Phi = (F, \sigma)$ 以容差 $\tau$ 拟合 $(r_j, \mathcal{X}(r_j)) \in \mathcal{S}$。对 $x_0 \in \mathcal{X}(r_j)$，路由 $\sigma(x_0)$ 选定一条 $f$-chain $q_f = f_{i_k} \circ \cdots \circ f_{i_1}$，使得 $\Phi(x_0) = q_f(x_0)$ 以误差 $\tau_0 = d(\Phi(x_0), r_j(x_0)) \leq \tau$ 拟合 $r_j$。

涉及三层纤维：

1. **目标纤维**：$\mathfrak{F}_{r_j}(r_j(x_0))$——产生与 $x_0$ 相同目标输出的所有点。
2. **路由纤维**：$\mathfrak{F}_\sigma(\sigma(x_0))$——与 $x_0$ 被路由到同一条 $f$-chain 的所有点。
3. **计算纤维**：$\mathfrak{F}_{q_f}(q_f(x_0))$——经过该 $f$-chain 后产生与 $x_0$ 相同输出的所有点。

#### 定义（$\varepsilon$-三纤维交集，Triple Fiber Intersection）

对 $\varepsilon_r, \varepsilon_f \geq 0$，定义 $x_0$ 处的 **$\varepsilon$-三纤维交集**：

$$\mathrm{TFI}^{\varepsilon_r, \varepsilon_f}(x_0) \;\triangleq\; \mathfrak{F}_{r_j}^{\varepsilon_r}(r_j(x_0)) \;\cap\; \mathfrak{F}_\sigma(\sigma(x_0)) \;\cap\; \mathfrak{F}_{q_f}^{\varepsilon_f}(q_f(x_0))$$

其中目标纤维和计算纤维使用 $\varepsilon$-纤维（$\varepsilon = 0$ 退化为精确纤维），路由纤维保持精确（$\sigma$ 为离散值映射，同一路由区域内精确相等）。当 $\varepsilon_r = \varepsilon_f = 0$ 时，简记 $\mathrm{TFI}(x_0) \triangleq \mathrm{TFI}^{0,0}(x_0)$。

**定理 9.2（三纤维不可区分定理）**：对任意 $x \in \mathrm{TFI}^{\varepsilon_r, \varepsilon_f}(x_0)$：

$$d(\Phi(x), r_j(x)) \;\leq\; \tau_0 + \varepsilon_r + \varepsilon_f$$

当 $\varepsilon_r = \varepsilon_f = 0$ 时，$d(\Phi(x), r_j(x)) = \tau_0$——$\mathrm{TFI}(x_0)$ 中的所有点在拟合层面**绝对不可区分**。

**证明**：由 $x \in \mathfrak{F}_\sigma(\sigma(x_0))$ 得 $\sigma(x) = \sigma(x_0) = q_f$，故 $\Phi(x) = q_f(x)$。对 $d(\Phi(x), r_j(x))$ 连续应用两次三角不等式：

$$d(\Phi(x), r_j(x)) \leq \underbrace{d(q_f(x), q_f(x_0))}_{\leq\, \varepsilon_f} + \underbrace{\tau_0}_{} + \underbrace{d(r_j(x_0), r_j(x))}_{\leq\, \varepsilon_r}$$

其中第一项由 $x \in \mathfrak{F}_{q_f}^{\varepsilon_f}(q_f(x_0))$，第三项由 $x \in \mathfrak{F}_{r_j}^{\varepsilon_r}(r_j(x_0))$。当 $\varepsilon_r = \varepsilon_f = 0$ 时取等。$\square$

> **注**：精确 TFI 给出"误差完全一致"，$\varepsilon$-TFI 给出"误差受控增长"——增长量恰好等于 $\varepsilon_r + \varepsilon_f$，三个来源线性可加、独立可控。

特别地，当 $r_j$ 和 $q_f$ 的广义 Lipschitz 常数在 $x_0$ 附近分别为 $L_r, L_f \in \bar{\mathbb{R}}_+$ 时，对 $x_0$ 的 $\sigma$-同路由 $\delta$-邻域中的任意 $x$（即 $d(x, x_0) \leq \delta$ 且 $\sigma(x) = \sigma(x_0)$）：

$$d(\Phi(x), r_j(x)) \;\leq\; \tau_0 + (L_r + L_f) \cdot \delta$$

此时 $\varepsilon_r = L_r \cdot \delta$，$\varepsilon_f = L_f \cdot \delta$。当中间输出 $y$ 已知时，$L_r$、$L_f$ 可精化为局部横截 Lip $L^\perp_r(r_j(x_0))$、$L^\perp_f(q_f(x_0))$（§9.2），给出更紧的界。

#### 纤维扩散：从采样集到定义域

定理 9.2 直接给出 IDFS 拟合如何从采样集 $\mathcal{X}(r_j)$ 向 $\mathrm{dom}(r_j)$ 扩散的精确表达。

**推论 9.3（纤维扩散，Fiber Diffusion）**：设 $\Phi$ 在 $\mathcal{X}(r_j)$ 上以容差 $\tau$ 拟合 $r_j$。对 $\tau' \geq \tau$，定义 $r_j$ 在容差 $\tau'$ 下的**纤维扩散集**：

$$\mathcal{X}_{\tau'}(r_j) \;\triangleq\; \bigcup_{x_0 \in \mathcal{X}(r_j)} \mathrm{TFI}^{\varepsilon_r, \varepsilon_f}(x_0) \quad \text{其中} \quad \varepsilon_r + \varepsilon_f \leq \tau' - \tau_0(x_0),\; \varepsilon_r, \varepsilon_f \geq 0$$

则 $\Phi$ 在 $\mathcal{X}_{\tau'}(r_j)$ 上以容差 $\tau'$ 拟合 $r_j$。（当 $\tau' = \tau_0(x_0)$ 时，$\varepsilon_r = \varepsilon_f = 0$，扩散集退化为精确 $\mathrm{TFI}(x_0)$。）

换言之：$\mathcal{X}(r_j)$ 上的拟合以每个采样点 $x_0$ 为中心，沿三纤维交集向 $\mathrm{dom}(r_j)$ **扩散**——扩散的范围由三纤维的 $\varepsilon$-宽度决定，扩散的代价是误差从 $\tau_0$ 增长到 $\tau_0 + \varepsilon_r + \varepsilon_f$。纤维越粗，扩散越远；可容忍的误差增量 $\tau' - \tau_0$ 越大，扩散集越广。

> **注（纤维扩散是 $\mathrm{dom}(r_j)$ 扩张的一种机制）**：纤维扩散不是 $\mathrm{dom}(r_j)$ 上泛化的唯一机制——不同的系统设计可能存在其他扩张方式。但纤维扩散是由 IDFS 的基本结构（$r_j$、$\sigma$、$F$ 三者各自独立的纤维划分）直接决定的，不依赖 $\mathcal{X}$ 的内部结构。

> **注（高度量维度下的结构性容量）**：当 $\mathrm{dom}(\Phi)$ 的度量维度 $\mathrm{dim}_\varepsilon(\mathrm{dom})$ 远大于三个映射的纤维余维之和 $\mathrm{codim}_\varepsilon(r_j) + \mathrm{codim}_\varepsilon(\sigma) + \mathrm{codim}_\varepsilon(q_f)$ 时，三纤维交集的度量维度仍然极高——高维为纤维扩散提供了巨大的**结构性容量**。但扩散是否实际发生、覆盖是否足够广，仍取决于三个映射纤维结构的具体几何关系和采样锚点的分布。

> **注（三纤维交集不是缺陷）**：三纤维交集的存在不意味着系统"出了问题"。它是 IDFS 在有限基函数库 $F$ 和有限路由容量 $|\mathrm{Im}(\sigma)|$ 下的结构性事实。本节的价值在于精确区分了 $\mathrm{dom}(r_j)$ 上的**计算扩张**（覆盖新的计算区域）与**纤维扩散**（在已有计算上的受控复制）。

---

### 9.5 纤维吸收

链复合中，前一步的输出误差可能被后一步的纤维结构**吸收**——如果误差不足以使输出点跨越纤维边界，后一步的计算完全不受影响。

#### 基本纤维吸收

**定理 9.4（纤维吸收定理）**：设 $\phi_2 \circ \phi_1$ 为两步复合。设 $\phi_1$ 在 $x$ 处的理想输出为 $y$，实际输出为 $\hat{y} = \phi_1(x)$，误差 $\delta = d(\hat{y}, y)$。

(i) **精确吸收**：若 $\hat{y}$ 与 $y$ 落入 $\phi_2$ 的同一根纤维（$\phi_2(\hat{y}) = \phi_2(y)$），则 $\phi_2(\phi_1(x)) = \phi_2(y)$——前步误差 $\delta$ 被**完全吸收**，不传播到后续输出。

(ii) **$\varepsilon$-吸收**：若 $\hat{y}$ 与 $y$ 落入 $\phi_2$ 的同一根 $\varepsilon$-纤维（$d(\phi_2(\hat{y}), \phi_2(y)) \leq \varepsilon$），则：

$$d(\phi_2(\phi_1(x)), \phi_2(y)) \leq \varepsilon$$

前步误差 $\delta$ 被**部分吸收**——无论 $\delta$ 多大，只要 $\hat{y}$ 留在 $y$ 的 $\varepsilon$-纤维内，传播到后续的残余误差至多为 $\varepsilon$，而非 Lipschitz 放大的 $L_{\phi_2} \cdot \delta$。

**证明**：(i) $\phi_2(\phi_1(x)) = \phi_2(\hat{y}) = \phi_2(y)$。(ii) 直接由 $\varepsilon$-纤维定义。$\square$


#### 映射链中的逐步纤维吸收

在映射链 $\psi = \phi_k \circ \cdots \circ \phi_1$ 中，纤维吸收在每一步都可能发生。设 $h_m = \phi_m(\cdots(\phi_1(x)))$ 为第 $m$ 步的实际中间态，$h_m^*$ 为理想中间态，误差 $\delta_m = d(h_m, h_m^*)$。

**命题 9.5（映射链逐步吸收）**：在链的第 $m+1$ 步，误差的有效传播满足：

$$\delta_{m+1} \leq \begin{cases} 0 & \text{若 } h_m \in \mathfrak{F}_{\phi_{m+1}}(\phi_{m+1}(h_m^*)) \quad \text{（精确吸收）} \\ \varepsilon_{m+1} & \text{若 } h_m \in \mathfrak{F}_{\phi_{m+1}}^{\varepsilon_{m+1}}(\phi_{m+1}(h_m^*)) \quad \text{（$\varepsilon$-吸收）} \\ L_{\phi_{m+1}} \cdot \delta_m & \text{否则} \quad \text{（广义 Lip 放大，$L_{\phi_{m+1}} \in \bar{\mathbb{R}}_+$）} \end{cases}$$

其中 $L_{\phi_{m+1}}$ 为 $\phi_{m+1}$ 的广义 Lipschitz 常数（§1.2），取值于 $\bar{\mathbb{R}}_+ = [0, +\infty]$。当中间输出 $y_m$ 已知时，第三分支的 $L_{\phi_{m+1}}$ 可精化为局部横截 Lip $L^\perp_{\phi_{m+1}}(y_m)$（§9.2），给出更紧的放大因子。当 $L_{\phi_{m+1}} = +\infty$ 时，第三分支退化为无界放大——此时纤维吸收（前两分支）是阻止误差爆炸的唯一机制。

因此，映射链的端到端误差传播不是简单的 $\prod L_{\phi_m}$ 乘积。在纤维吸收发生的步骤，有效放大因子**降至零**（精确吸收）或被**截断为** $\varepsilon_{m+1}/\delta_m$（$\varepsilon$-吸收），实际误差路径远短于最坏情况的广义 Lip 乘积。

> **注（CAC 上界的保守性来源）**：CAC 定理（§3）以 $\Theta_{j,l} = \prod_{k=j}^l L_k$ 逐层放大误差。实际传播远小于此上界，有两个来源：**(1)** 局部横截 Lip $L^\perp_\phi(y) \leq L_\phi$——每步的有效放大因子取决于具体中间输出 $y_m$，而非全局 $\sup$；**(2)** $\varepsilon$-纤维吸收——命题 9.5 的前两分支在每步将误差截断为 $\varepsilon$ 或 $0$，而非以 $L$ 传播。两者在 $f$-chain 内部（微观）和 $\Phi$-链的 $r$-链层面（宏观，CAC 的适用范围）**双重发生**——微观层面的吸收已隐含地降低了宏观 $L_k$ 的取值，但宏观层面 $\Phi$-级吸收是额外的、不被 $L_k$ 捕捉的保守性来源。

> **注（吸收的不可预测性）**：吸收步集 $\mathcal{A}$ 的分布与 $\phi$-chain 各步的具体纤维结构高度关联，无法从链的全局统计量预测——即使 $\varepsilon$-吸收后残余仅为 $\varepsilon$，也可能超出下一步纤维的吸收容量而逃逸；反之，未被吸收的误差经 Lip 传播后也可能恰好落入后续步的纤维内。唯一可以在一般性层面断言的是：高维空间中纤维更厚，为吸收的持续发生提供了更大的**结构性容量**。

---

### 9.6 链级纤维膨胀与深度极限

**命题 9.6（链级纤维膨胀的可加性）**：设 $\psi = \phi_2 \circ \phi_1$。则：

$$\mathrm{FI}_\varepsilon(\psi) \;=\; \mathrm{FI}_\varepsilon(\phi_1) \;+\; \mathrm{FI}_\varepsilon(\phi_2|_{\mathrm{Im}(\phi_1)})$$

**证明**：$\mathrm{dom}(\psi) = \mathrm{dom}(\phi_1)$，$\mathrm{Im}(\psi) = \phi_2(\mathrm{Im}(\phi_1))$。加减 $\log \mathcal{N}(\varepsilon, \mathrm{Im}(\phi_1))$：

$$\mathrm{FI}_\varepsilon(\psi) = \underbrace{[\log \mathcal{N}(\varepsilon, \mathrm{dom}(\phi_1)) - \log \mathcal{N}(\varepsilon, \mathrm{Im}(\phi_1))]}_{\mathrm{FI}_\varepsilon(\phi_1)} + \underbrace{[\log \mathcal{N}(\varepsilon, \mathrm{Im}(\phi_1)) - \log \mathcal{N}(\varepsilon, \phi_2(\mathrm{Im}(\phi_1)))]}_{\mathrm{FI}_\varepsilon(\phi_2|_{\mathrm{Im}(\phi_1)})}$$

$\square$

**推论 9.7（$k$-步链的纤维膨胀）**：设 $\psi = \phi_k \circ \cdots \circ \phi_1$。则：

$$\mathrm{FI}_\varepsilon(\psi) \;=\; \sum_{m=1}^{k} \mathrm{FI}_\varepsilon(\phi_m|_{\mathrm{Im}(\phi_{m-1} \circ \cdots \circ \phi_1)})$$

（约定 $\mathrm{Im}(\phi_0 \circ \cdots \circ \phi_1) = \mathrm{dom}(\phi_1)$。）

每一步复合贡献一项纤维膨胀。总膨胀是逐步膨胀之和——链越长，累积纤维坍缩越深，有效输出多样性逐步衰减。

**推论 9.8（余维可加性）**：将推论 9.7 除以 $\log(1/\varepsilon)$，得映射链的纤维余维可加：

$$\mathrm{codim}_\varepsilon(\psi) \;=\; \sum_{m=1}^{k} \mathrm{codim}_\varepsilon(\phi_m|_{\mathrm{Im}(\phi_{m-1} \circ \cdots \circ \phi_1)})$$

总坍缩维数 = 逐步坍缩维数之和。维度是可数的。

纤维膨胀递推直接导出映射链长度的一个**信息论上界**——与 §7 的 Lipschitz 链深上界互补。

#### 定义（吸收步集与有效消耗步集）

对给定输入 $x$ 和映射链 $\psi_F = \phi_k \circ \cdots \circ \phi_1$，定义：

- **吸收步集** $\mathcal{A}(x) = \{m \mid h_{m-1}(x) \in \mathfrak{F}_{\phi_m}^{\varepsilon_m}(\phi_m(h_{m-1}^*(x)))\}$——第 $m$ 步发生 $\varepsilon$-纤维吸收的步骤。
- **有效消耗步集** $\mathcal{A}^c(x) = \{1, \ldots, k\} \setminus \mathcal{A}(x)$——吸收不发生、纤维坍缩真正消耗分辨率的步骤。

**定理 9.9（纤维深度极限，Fiber Depth Limit）**：设映射链 $\psi_F = \phi_k \circ \cdots \circ \phi_1$ 以容差 $\tau$ 拟合目标链 $\psi_R$，即对所有 $x \in \mathrm{dom}(\psi_F)$，$d(\psi_F(x), \psi_R(x)) \leq \tau$。设在输入子集 $S \subseteq \mathrm{dom}(\psi_F)$ 上吸收步集 $\mathcal{A}$ 一致。则有效深度受限于**分辨率预算** $B$：

$$\sum_{m \in \mathcal{A}^c} \mathrm{FI}_\varepsilon(\phi_m|_{\cdots}) \;\leq\; B \;\triangleq\; \log \mathcal{N}(\varepsilon, \mathrm{dom}(\psi_F)) - \mathcal{D}_\varepsilon(\psi_R) + C_\tau$$

其中 $C_\tau = \log \mathcal{N}(\varepsilon, \mathrm{Im}(\psi_R)) - \log \mathcal{N}(\varepsilon + \tau, \mathrm{Im}(\psi_R)) \geq 0$（$\tau \ll \varepsilon$ 时 $C_\tau \approx 0$）。吸收步集 $\mathcal{A}$ 中的步骤**不计入分辨率消耗**——无论其 $\mathrm{FI}$ 多大，都是"免费深度"。

**证明**：分三步。

**第一步**（输出多样性下界）：由 $d(\psi_F(x), \psi_R(x)) \leq \tau$ 对所有 $x$ 成立，$\mathrm{Im}(\psi_F)$ 中每个点 $z$ 都有某个 $\psi_R$-输出 $z^*$ 满足 $d(z, z^*) \leq \tau$。$z^*$ 的 $(\varepsilon + \tau)$-球包含 $z$ 的 $\varepsilon$-球。故 $\mathrm{Im}(\psi_F)$ 的 $\varepsilon$-覆盖至少覆盖 $\mathrm{Im}(\psi_R)$ 的 $(\varepsilon + \tau)$-覆盖：

$$\mathcal{N}(\varepsilon, \mathrm{Im}(\psi_F)) \;\geq\; \mathcal{N}(\varepsilon + \tau, \mathrm{Im}(\psi_R))$$

取对数：$\mathcal{D}_\varepsilon(\psi_F) \geq \mathcal{D}_\varepsilon(\psi_R) - C_\tau$。

**第二步**（FI 分解）：由推论 9.7，$\mathcal{D}_\varepsilon(\psi_F) = \log \mathcal{N}(\varepsilon, \mathrm{dom}(\psi_F)) - \sum_{m=1}^{k} \mathrm{FI}_\varepsilon(\phi_m|_{\cdots})$。吸收步 $m \in \mathcal{A}$ 不消耗有效分辨率（误差被纤维吸收而非传播），故有效消耗仅为 $\sum_{m \in \mathcal{A}^c} \mathrm{FI}_\varepsilon(\phi_m|_{\cdots})$。

**第三步**（合并）：将第二步代入第一步的下界，移项即得。$\square$

即映射链可用的**分辨率预算**为 $B$。每层非吸收步 $\phi_m$ 消耗 $\mathrm{FI}_\varepsilon(\phi_m|_{\cdots})$ 的预算。当总消耗超过预算——即累积纤维膨胀耗尽定义域的度量熵优势——链的输出多样性不足以覆盖目标，**拟合在信息论层面不可能**。

比较两种情形：

**(i) 无吸收**（$\mathcal{A} = \varnothing$，最差情形）：所有步骤的 FI 全额计入，$\sum_{m=1}^k \mathrm{FI}_\varepsilon(\phi_m|_{\cdots}) \leq B$——朴素深度天花板。

**(ii) 大量吸收**（$|\mathcal{A}| \gg |\mathcal{A}^c|$）：有效消耗步数远少于名义链深 $k$，链可以远深于 (i) 的上界。

#### 定义（预算利用率，Budget Utilization Ratio）

$$\eta_\varepsilon(\psi_F) \;\triangleq\; \frac{\sum_{m \in \mathcal{A}^c} \mathrm{FI}_\varepsilon(\phi_m|_{\cdots})}{B} \;\in\; [0, 1]$$

定理 9.9 等价于 $\eta \leq 1$。$1 - \eta$ 为**深度安全裕度**——衡量系统距纤维枯竭的余量。$\eta \ll 1$ 时预算充裕；$\eta \to 1$ 时纤维退化，泛化趋于枯竭。当 $\mathcal{A} = \varnothing$ 时 $\eta$ 即朴素利用率（所有步骤全额计入）。

> **注（$\eta$ 的量级依赖）**：当 $\log \mathcal{N}(\varepsilon, \mathrm{dom})$ 远大于 $k$ 步的总 FI 消耗时，$\eta \to 0$——纤维深度极限不构成有效约束。但这不意味着 $\phi$-chain 的链深无约束：链越长，各步的误差经逐步传播后累积越大，这是度量论层面的独立约束。

> **注（有效深度 vs 名义深度）**：名义链深为 $k$，但有效消耗步数为 $|\mathcal{A}^c|$。当 $|\mathcal{A}| \gg |\mathcal{A}^c|$ 时，实际链可以远深于朴素上界 (i)。

#### 维度预算方程

将定理 9.9 除以 $\log(1/\varepsilon)$，得**维度计数**版本：

$$\sum_{m \in \mathcal{A}^c} \mathrm{codim}_\varepsilon(\phi_m|_{\cdots}) \;\leq\; \mathrm{dim}_\varepsilon(\mathrm{dom}(\psi_F)) - \mathrm{dim}_\varepsilon(\mathrm{Im}(\psi_R)) + C'_\tau$$

输入维度 $\geq$ 累积坍缩维度 + 目标输出维度。被吸收的步骤即使坍缩了维度也不计入。

> **注（微观与宏观深度约束的结构类比）**：定理 9.9 约束的是微观层面的 $\phi$-chain 链深（$f$-chain 内部的基函数步数），而 §7 的 Lip 链深上界约束的是宏观层面的 $r$-链深（$\Phi$ 的迭代次数）——两者不是同一个“深度”。但它们共享相同的结构：**Lipschitz 收缩是度量层面的纤维变粗**——$L < 1$ 意味着 $\phi$ 将邻近的点拉得更近，即纤维在 $\varepsilon$-尺度上变得更宽。无论微观还是宏观，链太长都导致纤维累积坍缩耗尽分辨率。

> **注（维度预算与纤维退化）**：当 $\mathrm{dim}_\varepsilon(\mathrm{dom})$ 足够大时，每步纤维坍缩可视为"消耗若干维度"，维度越高，分辨率预算越充裕，为更深的 $\phi$-chain 提供了更大的**结构性可能**。当预算耗尽（$\eta \to 1$）时，纤维退化为单点集：$\mathfrak{F}_{\psi_F}(\psi_F(x_0)) \cap \mathcal{X} = \{x_0\}$，$\mathrm{TFI}^{\varepsilon_r, \varepsilon_f}(x_0)$（§9.4）退化为 $\{x_0\}$，纤维层面的泛化能力**归零**，$L^\perp(y) \to L$，吸收与扩散优势同时消失。**纤维是泛化的载体——纤维退化是纤维层面泛化的根本极限。** 预算是否充裕、纤维退化是否实际发生，取决于 $\phi$-chain 各步的具体纤维结构，不能仅从维度大小推断。

---

### 9.7 纤维冲突

§9.4 刻画了纤维对齐的"好"情形。本节考察纤维**不对齐**的后果——一个映射坍缩了另一个映射需要区分的点。

#### 定义（$\varepsilon$-纤维冲突，$\varepsilon$-Fiber Conflict）

设 $\phi, \psi \in \Omega$，$\tau > 0$，$\varepsilon \geq 0$。若存在 $x', x'' \in \mathrm{dom}(\phi) \cap \mathrm{dom}(\psi)$ 使得：

$$d(\phi(x'), \phi(x'')) \leq \varepsilon \quad \text{但} \quad d(\psi(x'), \psi(x'')) > 2\tau$$

则称 $\phi$ 与 $\psi$ 在 $(x', x'')$ 上发生 **$\varepsilon$-纤维冲突**——$\phi$ 将 $\psi$ 需要区分的两个输入（几乎）坍缩到同一输出。$\varepsilon = 0$ 即精确纤维冲突。

**命题 9.10（$\varepsilon$-纤维冲突的不可拟合性）**：设映射链 $\hat{\psi} = \phi_k \circ \cdots \circ \phi_1$ 拟合目标 $\psi$。若在第 $m$ 步发生 $\varepsilon$-纤维冲突——即 $d(\phi_m(h'_{m-1}), \phi_m(h''_{m-1})) \leq \varepsilon$——且链的剩余部分 $\hat{\psi}_{\mathrm{tail}} = \phi_k \circ \cdots \circ \phi_{m+1}$ 的广义 Lip 常数为 $L_{\mathrm{tail}} \in \bar{\mathbb{R}}_+$，则 $\psi$ 在 $x'$、$x''$ 上的最大拟合误差满足：

$$\max\{d(\hat{\psi}(x'), \psi(x')),\; d(\hat{\psi}(x''), \psi(x''))\} \;\geq\; \frac{d(\psi(x'), \psi(x'')) - L_{\mathrm{tail}} \cdot \varepsilon}{2}$$

**证明**：记 $h'_m = \phi_m(h'_{m-1})$，$h''_m = \phi_m(h''_{m-1})$。由 $d(h'_m, h''_m) \leq \varepsilon$ 和 $\hat{\psi}_{\mathrm{tail}} \in \mathrm{Lip}_{L_{\mathrm{tail}}}$，得 $d(\hat{\psi}(x'), \hat{\psi}(x'')) \leq L_{\mathrm{tail}} \cdot \varepsilon$。由三角不等式：

$$d(\psi(x'), \psi(x'')) \leq d(\hat{\psi}(x'), \psi(x')) + d(\hat{\psi}(x'), \hat{\psi}(x'')) + d(\hat{\psi}(x''), \psi(x''))$$

$$\leq d(\hat{\psi}(x'), \psi(x')) + L_{\mathrm{tail}} \cdot \varepsilon + d(\hat{\psi}(x''), \psi(x''))$$

两项中至少一项 $\geq (d(\psi(x'), \psi(x'')) - L_{\mathrm{tail}} \cdot \varepsilon) / 2$。当 $\varepsilon = 0$ 时，链从第 $m$ 步共享相同轨线，$\hat{\psi}(x') = \hat{\psi}(x'')$，退化为精确冲突的不可拟合性。当 $L_{\mathrm{tail}} = +\infty$ 时下界退化为 $-\infty$（平凡成立）。$\square$

> $L_{\mathrm{tail}} \cdot \varepsilon$ 量化了"几乎坍缩"的残余区分能力——若链尾部的 $L_{\mathrm{tail}}$ 不足以将 $\varepsilon$ 的微小差异放大到覆盖目标输出差距，冲突仍然导致不可拟合。

> **注（IDFS 中的纤维冲突）**：在 IDFS 中，$\phi_m = f_{i_m} \in F$，$\psi = r_j \in R$。避免纤维冲突只有两条途径：(1) 路由 $\sigma$ 将冲突点分配到不同 $f$-chain（消耗路由容量 $|\mathrm{Im}(\sigma)|$），(2) 使用纤维更细的 $f_i$（要求 $F$ 中的函数具有更高的输出分辨率）。这与 CPI 定理（§4.2）的路由容量需求在微观层面对接。

> **注（纤维冲突与纤维吸收的对偶）**：§9.5 的纤维吸收——误差落入纤维内则被消除——是"好"的多对一坍缩。纤维冲突——需要区分的信号落入同一纤维——是"坏"的多对一坍缩。两者是同一纤维结构的两面：纤维宽度同时决定了系统的**误差容限**和**分辨率极限**。

> **注（冲突的结构性规避）**：纤维冲突要求两个映射的纤维结构“恰好”不兼容——$\phi$ 坍缩的方向恰是 $\psi$ 需要区分的方向。当 $\mathrm{codim}_\varepsilon(\phi) / \mathrm{dim}_\varepsilon(\mathrm{dom})$ 极小时——每个映射只坍缩极小比例的维度——高维空间为规避这种不兼容提供了更大的**结构性余量**。但冲突是否实际发生，仍取决于 $\phi$-chain 各步纤维结构的具体几何关系。

---

### 9.8 多约束纤维交集

当系统需要在重叠定义域上同时满足多个约束——拟合 $r_1, r_2, \ldots, r_k$ 在 $\bigcap_j \mathrm{dom}(r_j)$ 上——每个约束贡献一层纤维限制，有效交集逐层缩小。

#### 定义（$\varepsilon$-多约束纤维交集，$\varepsilon$-Multi-Constraint Fiber Intersection）

设系统 $\Phi$ 在 $x_0$ 处同时拟合 $k$ 个目标 $r_1, \ldots, r_k$，$\varepsilon \geq 0$。定义 $x_0$ 处的 **$\varepsilon$-$k$-纤维交集**：

$$\mathrm{TFI}_k^\varepsilon(x_0) \;\triangleq\; \mathfrak{F}_\sigma(\sigma(x_0)) \;\cap\; \mathfrak{F}_{q_f}^\varepsilon(q_f(x_0)) \;\cap\; \bigcap_{j=1}^{k} \mathfrak{F}_{r_j}^\varepsilon(r_j(x_0))$$

$\varepsilon = 0$ 即精确 $k$-纤维交集。$\varepsilon > 0$ 时目标纤维和计算纤维从精确等值集扩展为 $\varepsilon$-邻域，交集更大——但模糊意味着保障从精确不可区分退化为 $\varepsilon$-近似不可区分。路由纤维保持精确（$\sigma$ 为离散值映射，同一路由区域内精确相等）。

**命题 9.11（$\varepsilon$-$k$-纤维交集的维度递减）**：设 $\delta > 0$ 为度量分辨率尺度（区别于纤维容差 $\varepsilon$）。若 $k+2$ 层纤维约束（其中路由纤维为精确纤维，其余为 $\varepsilon$-纤维）彼此**独立**——即余维可加——则 $\varepsilon$-$k$-纤维交集的有效度量维度满足下界：

$$\mathrm{dim}_\delta(\mathrm{TFI}_k^\varepsilon(x_0)) \;\geq\; \mathrm{dim}_\delta(\mathrm{dom}) - \mathrm{codim}_\delta(\sigma) - \mathrm{codim}_\delta(q_f) - \sum_{j=1}^{k} \mathrm{codim}_\delta(r_j)$$

独立约束下取等。当约束非独立（余维不完全可加）时，交集维度更高——非独立的约束构成冗余，不消耗额外维度。

当总余维消耗超过定义域维度——即上式右端 $\leq 0$——$\varepsilon$-$k$-纤维交集**可能退化为空集或零维**，此时纤维扩散完全失效。

> **注（约束数的临界阈值）**：若每个 $r_j$ 的纤维余维约为 $c$，则在独立约束假设下，$\varepsilon$-$k$-纤维交集的维度随 $k$ 线性递减，在约 $k^* \approx (\mathrm{dim}_\delta(\mathrm{dom}) - \mathrm{codim}_\delta(\sigma) - \mathrm{codim}_\delta(q_f))\, /\, c$ 处退化至零维。$\mathrm{dim}_\delta(\mathrm{dom})$ 越大，$k^*$ 越大，为同时满足更多约束提供了更大的**结构性容量**。但系统能否实际达到 $k^*$ 个约束，仍取决于各约束的纤维几何关系——非独立约束（冗余）使交集退化更慢，而误差传播可能在 $k$ 远小于 $k^*$ 时就使拟合质量无法接受。

> **注（采样支撑缺失与外推风险）**：即使 $\mathrm{TFI}_k^\varepsilon(x_0)$ 非空，若其与采样集无交——$\mathrm{TFI}_k^\varepsilon(x_0) \cap \mathcal{X} = \varnothing$——纤维扩散仍然无法将拟合从 $\mathcal{X}$ 传递到 $x_0$：$\varepsilon$-纤维结构存在但无采样锚点，保障仅限于 $\varepsilon$-近似不可区分，无法提供精确拟合传递。定义 $x_0$ 处的**外推风险**为：
>
> $$\mathcal{R}(x_0) \;\triangleq\; L^\perp_{\Phi}(\Phi(x_0)) \cdot \Delta(x_0)$$
>
> 其中 $\Delta(x_0) = \inf_{x \in \mathcal{X}} d(x_0, x)$ 为 $x_0$ 到最近采样锚点的距离。$\mathcal{R}(x_0) \leq \tau$ 时外推仍在容差内；$\mathcal{R}(x_0) > \tau$ 时拟合保障失效。高维度量空间中存在两个对抗的力：$\Delta$ 因维度灾难而增大（有限采样无法覆盖高维空间），$L^\perp(y)$ 因纤维变厚而减小（§9.2）。系统能否工作取决于二者的**乘积**而非单独一个——这一平衡的具体量级将在特定度量空间中揭示。

> **注（维度的祝福）**：第二部分建立了**维度诅咒**的图景：高维使采样稀疏、路由混叠加剧、深度折叠不可避免。纤维视角则揭示了另一面——**维度的祝福**。设 $f: \mathcal{X} \to \mathcal{Y}$，$\mathrm{dim}_\delta(\mathcal{X}) = n$，$\mathrm{dim}_\delta(\mathcal{Y}) = m$，$m \ll n$。则 $f$ 的纤维维度约为 $n - m$：输入空间越高维，纤维越厚，每个输出值对应的等价输入集合越大。当 $m \ll n$ 时，输入空间的**绝大部分维度**属于纤维方向——高维为吸收提供了巨大的**结构性容量**。诅咒与祝福并非矛盾，而是同一高维结构的两个面——诅咒在**采样层面**（覆盖困难），祝福在**结构层面**（吸收的可能性更丰富）。但祝福是结构性可能，不是保障——纤维增厚是否实际带来泛化改善，取决于具体的纤维几何与采样分布的匹配。
