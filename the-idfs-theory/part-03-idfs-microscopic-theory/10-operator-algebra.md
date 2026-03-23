## §10 算子代数与最小基理论

§9 建立了计算纤维的分析工具。本节将纤维视角转向 $F$ 的**内部结构**——实际 IDFS 的基函数库 $F$ 几乎总是非最小的，即存在 $g \in F$ 可被 $F$ 中其他成员的 f-chain 替代。这种冗余并非缺陷，而是系统对频繁子链的压缩编码。本节从算子可分解性出发，经由拟合等价类，最终建立最小基理论与深度-冗余权衡。

#### $\Omega$ 上的度量

§1 定义了算子空间 $\Omega = \{\phi: (\mathcal{X}, d) \to (\mathcal{X}, d)\}$。本章在 $\Omega$ 上引入 **sup-范数距离**：

$$d_\Omega(\phi, \psi) \;\triangleq\; \sup_{x \in \mathcal{X}} d(\phi(x), \psi(x))$$

$(\Omega, d_\Omega)$ 构成一个度量空间。$F \subset \Omega$，$R \subset \Omega$，f-chain 的复合 $\phi_k \circ \cdots \circ \phi_1 \in \Omega$——所有算子、目标和复合链都是 $\Omega$ 中的点。以下结论对任意 $\phi, \psi \in \Omega$ 成立。在不至混淆时，限制到 $F$ 上的度量仍记为 $d_\Omega$。

### 10.1 算子可分解性

#### 定义（算子可分解性，Operator Factorizability）

设 $\psi, \phi_1, \ldots, \phi_k: \mathcal{X} \to \mathcal{X}$（$k \geq 2$）和子集 $U \subseteq \mathcal{X}$。定义 $\psi$ 相对于 $(\phi_1, \ldots, \phi_k)$ 在 $U$ 上的**分解偏差**：

$$\delta(\psi;\, \phi_1, \ldots, \phi_k;\, U) \;\triangleq\; d_\Omega(\psi,\; \phi_k \circ \cdots \circ \phi_1)\big|_U$$

称 $\psi$ 在 $U$ 上以偏差 $\delta$ **$(\phi_1, \ldots, \phi_k)$-可分解**（$\delta$-decomposable）。$\delta = 0$ 时称为**精确可分解**——实际系统中一般不容易精确成立。

**纤维刻画**：精确可分解（$\delta = 0$）时，$\psi$ 与 $\phi_k \circ \cdots \circ \phi_1$ 在 $U$ 上共享纤维划分——对所有 $y \in \mathrm{Im}(\psi|_U)$：

$$\mathfrak{F}_\psi(y) \cap U \;=\; \mathfrak{F}_{\phi_k \circ \cdots \circ \phi_1}(y) \cap U$$

当 $\delta > 0$ 时，纤维划分不再精确一致，但在 $\delta$-邻域内近似一致（§9.1 的 $\varepsilon$-纤维意义下）。

#### 不可约核（IDFS 特化）

在 IDFS 框架中，$\psi, \phi_i$ 取自具体的基函数库 $F$。以下定义依赖于 $F$ 的有限性。

称 $f \in F$ 为**全局 $\delta_0$-不可约的**（globally $\delta_0$-irreducible），若：

$$\nexists\; U \subseteq \mathcal{X}\;(\text{非空开}),\; k \geq 2,\; \phi_1, \ldots, \phi_k \in F \setminus \{f\}:\quad d_\Omega(f,\; \phi_k \circ \cdots \circ \phi_1)\big|_U \leq \delta_0$$

即不存在 $F$ 中其他成员的复合在任何非空开集上以偏差 $\leq \delta_0$ 逼近 $f$。$\delta_0 = 0$ 退化为精确不可约。

$F$ 的 **$\delta_0$-不可约核**：

$$F_{\min}^{\delta_0} \;\triangleq\; \{f \in F \mid f \text{ 全局 } \delta_0\text{-不可约}\}$$

**冗余度**：$\rho_{\delta_0}(F) \triangleq |F| - |F_{\min}^{\delta_0}|$。$\delta_0$ 越大，不可约条件越严格，$F_{\min}^{\delta_0}$ 越大。

**命题 10.1（$\delta_0$-不可约核的生成性）**：$F_{\min}^{\delta_0}$ 以偏差不超过 $|F| \cdot \delta_0$ 生成 $F$ 的 f-chain 覆盖——对任意 $g \in F \setminus F_{\min}^{\delta_0}$，存在开子集 $U$ 和 $F_{\min}^{\delta_0}$ 中的成员链，使得 $d_\Omega(g, f_k \circ \cdots \circ f_1)|_U \leq |F| \cdot \delta_0$。

**证明**：由 $g \notin F_{\min}^{\delta_0}$，$g$ 在某个非空开集 $U$ 上可被 $F$ 中其他成员的复合以偏差 $\leq \delta_0$ 逼近。若复合中某个 $f_i \notin F_{\min}^{\delta_0}$，继续递归替换，每步引入至多 $\delta_0$ 的额外偏差。由 $|F|$ 有限，递归必终止，总偏差 $\leq |F| \cdot \delta_0$。$\square$

> **注（局部不可约）**：全局 $\delta_0$-不可约是最强条件。更精细的概念是**局部不可约性**：$f$ 在特定子集 $U$ 上不可被 $\delta_0$-逼近，但在另一子集 $V$ 上可以。全局不可约核 $F_{\min}^{\delta_0} = \bigcap_U F_{\min}^{\delta_0, L}(U)$（遍历所有非空开集）是最小的不可约集。

---

### 10.2 子链替换

$\delta$-可分解性的直接应用：当一条 $\phi$-链中的连续子链可被另一算子近似替代时，产生一条**替换链**。

#### 定义（$\delta_0$-替换）

设 $\phi$-链 $\phi_k \circ \cdots \circ \phi_1$（$\phi_i \in \Omega$），$\chi \in \Omega$，$1 \leq a \leq b \leq k$（$b - a \geq 1$）。若：

$$d_\Omega(\chi,\; \phi_b \circ \cdots \circ \phi_a)\big|_U \;\leq\; \delta_0$$

则称 $\chi$ 为子链 $\phi_b \circ \cdots \circ \phi_a$ 在 $U$ 上的 **$\delta_0$-替换**。替换后得到新链：

$$\phi_k \circ \cdots \circ \phi_{b+1} \circ \chi \circ \phi_{a-1} \circ \cdots \circ \phi_1$$

**命题 10.2（单步替换的偏差传播）**：设 $\chi$ 为子链 $\phi_{a:b}$ 的 $\delta_0$-替换，$\phi_{1:k}'$ 为替换后的链。则：

$$d_\Omega(|\phi_{1:k}'|,\; |\phi_{1:k}|)\big|_U \;\leq\; \delta_0 \cdot \prod_{j=b+1}^{k} L_{\phi_j}$$

即替换引入的偏差 $\delta_0$ 被下游算子的广义 Lip 常数逐级放大。

**证明**：设 $x \in U$，$y = (\phi_{a-1} \circ \cdots \circ \phi_1)(x)$。则 $d(\chi(y), (\phi_b \circ \cdots \circ \phi_a)(y)) \leq \delta_0$。此偏差经过 $\phi_{b+1}, \ldots, \phi_k$ 逐步传播，每步至多放大 $L_{\phi_j}$ 倍（$L_{\phi_j} \in \bar{\mathbb{R}}_+$ 一定存在）。取 $\sup$ 即得。$\square$

> **注（多步替换）**：对同一条链执行多次不重叠的替换时，各替换引入的偏差分别经不同的下游路径放大后在输出端叠加。精确的误差上界依赖于各替换位置和下游 Lip 常数的具体分布，§10.3 的纤维分解不等式提供了更精细的分析工具。

#### 路由等效性（IDFS 特化）

在 IDFS 框架中，$\phi_i \in F$，替换算子 $\chi \in F$，链即 f-chain。然而，并非所有替换链都可用——只有当替换后的总传播偏差满足：

$$d_\Omega(|\phi_{1:k}'|,\; |\phi_{1:k}|)\big|_U \;\leq\; \varepsilon$$

即不超过拟合容差 $\varepsilon$ 时，替换链才是 $\sigma$ 的**可用等效路径**。命题 10.2 给出的 $\delta_0 \cdot \prod L_{\phi_j}$ 上界决定了替换的可行性：$\delta_0$ 和下游 Lip 的乘积越小，替换越安全。

由于不同的等效链可能具有截然不同的纤维结构，$\sigma$ 将 $\mathcal{X}(r_j)$ 的不同区域分配到不同等效链上时，同一个 $r_j$ 的拟合质量在 $\mathrm{dom}(r_j)$ 上一般不均匀。§10.3 将深化代数结构，§10.4 将通过拟合等价类给出精确刻画。

#### 纤维解释

子链 $\delta_0$-替换（命题 10.2）是定理 9.9（纤维深度极限，$\mathcal{A} \neq \varnothing$）的**极端特例**：

在 $\phi$-链 $\phi_k \circ \cdots \circ \phi_1$ 中，若子链 $\phi_{a:b}$ 存在 $\delta_0$-替换 $\chi$，则该子链的纤维结构被**预编译**为单步 $\chi$ 的纤维结构。用 §9.6 的语言：子链中间步的纤维膨胀 $\mathrm{FI}_\varepsilon(\phi_m|_{\cdots})$ 的累积效果被 $\mathrm{FI}_\varepsilon(\chi)$ 替代——中间步骤不消耗额外的分辨率预算。

> **注（路由混叠与子链替换的区别）**：子链替换与路由混叠（§2 定义，§3 推论 3.2）是两种不同机制：
> - **路由混叠**：由组合耗尽驱动——$|\mathrm{Im}(\sigma)| < M^{\mathcal{D}}$ 时，不同输入 $x_1, x_2$ 的微观路由 $\sigma(x_2) = \sigma_l(x_1)$ 重合，产生**确定性泛化**（$x_2$ 的单步行为与 $x_1$ 的 $l$ 步宏观行为在计算程序层面完全等同）。
> - **子链替换**：由 $F$ 的代数冗余驱动——同一个目标 $r_j$ 可由多条不同的 f-chain 分别拟合 $\mathcal{X}(r_j)$ 的不同子区域。$\sigma$ **可能**（但不必然）将 $\mathcal{X}(r_j)$ 拆分到不同的等效链上。这种拆分可能带来一定程度的泛化（通过纤维扩散），但**不保证**——取决于各等效链的纤维质量。
>
> 前者是输入空间不同位置在**计算程序层面的简并**；后者是同一目标在**拟合路径层面的多重覆盖**。

---

### 10.3 算子代数结构

§10.2 给出了子链替换的粗糙偏差传播上界 $\delta_0 \cdot \prod L_{\psi_j}$。本节的目标是用 $\Omega$ 上的**纤维结构收紧这个界**——纤维宽度提供距离死区，使得实际偏差传播远小于朴素 Lip 乘积。

#### 复合的度量相容性

复合 $\circ$ 赋予 $(\Omega, \circ)$ 幺半群（monoid）结构：结合律 $(\psi \circ \phi) \circ \chi = \psi \circ (\phi \circ \chi)$、恒等元 $\mathrm{id}$、一般不交换。关键问题是：复合与度量 $d_\Omega$ 如何相容？

**命题 10.4（左复合的 Lipschitz 收缩）**：对 $\psi, \phi_1, \phi_2 \in \Omega$：

$$d_\Omega(\psi \circ \phi_1,\; \psi \circ \phi_2) \;\leq\; L_\psi \cdot d_\Omega(\phi_1, \phi_2)$$

其中 $L_\psi \in \bar{\mathbb{R}}_+$ 为 $\psi$ 的广义 Lip 常数（一定存在）。即左复合 $\ell_\psi: \phi \mapsto \psi \circ \phi$ 是 $(\Omega, d_\Omega)$ 上的 $L_\psi$-Lipschitz 映射。

**证明**：$d(\psi(\phi_1(x)), \psi(\phi_2(x))) \leq L_\psi \cdot d(\phi_1(x), \phi_2(x))$，取 $\sup$ 即得。$\square$

#### $\varepsilon$-纤维吸收

命题 10.4 给出了朴素的 Lip 收缩。纤维结构提供了**更精细的吸收机制**——当两个输入的差距足够小（落入同一根 $\varepsilon$-纤维内，§9.1），输出差异被压缩至 $\varepsilon$ 以内，而非以 $L$ 放大。

**命题 10.5（$\varepsilon$-纤维吸收）**：对 $\psi \in \Omega$，$\varepsilon \geq 0$，$L^\perp_\psi(y)$ 为 $\psi$ 在 $y$ 处的局部横截 Lip 常数（§9.2）。则：

$$d_\Omega(\psi \circ \phi_1,\; \psi \circ \phi_2) \;\leq\; \begin{cases} \varepsilon & \text{若 } d_\Omega(\phi_1, \phi_2) \leq \varepsilon / L^\perp_\psi \\ L^\perp_\psi \cdot d_\Omega(\phi_1, \phi_2) & \text{否则} \end{cases}$$

**证明**：对每个 $x$，设 $y_1 = \phi_1(x)$，$y_2 = \phi_2(x)$。若 $d(y_1, y_2) \leq \varepsilon / L^\perp_\psi(y_1)$，则 $d(\psi(y_1), \psi(y_2)) \leq L^\perp_\psi(y_1) \cdot d(y_1, y_2) \leq \varepsilon$，即 $y_2 \in \mathfrak{F}_\psi^\varepsilon(\psi(y_1))$（§9.5 的 $\varepsilon$-吸收）。否则，以 $L^\perp_\psi$ 放大（§9.2）。取 $\sup$ 即得。$\square$

即 $\varepsilon / L^\perp_\psi$ 扮演**距离死区**的角色：差距在此范围内时，$\psi$ 的纤维吸收将输出差异压缩至 $\varepsilon$；超出时退化为朴素 Lip 放大。纤维越粗（$L^\perp$ 越小），死区越宽。当 $\psi$ 为单射时 $L^\perp_\psi = L_\psi$，死区最窄，退化为命题 10.4。

#### 定义（纤维-Lipschitz 幺半群）

称 $(\Omega, \circ, d_\Omega)$ 为 **纤维-Lipschitz 幺半群**（Fiber-Lipschitz Monoid），若对每个 $\psi \in \Omega$，$L^\perp_\psi < L_\psi$——即至少存在一些纤维方向使放大率低于全局上界。

条件的含义：复合不是简单的 Lipschitz 运算，而是**带纤维吸收的收缩运算**——每个算子的 $\varepsilon$-纤维提供死区 $\varepsilon / L^\perp_\psi$，在此范围内的差异被压缩至 $\varepsilon$ 以内。

#### 纤维分解不等式

纤维-Lipschitz 幺半群的核心应用：将 §10.1 的 $\delta$-可分解性（$\delta > 0$ 为一般情形）与 $\varepsilon$-纤维吸收结合，收紧 §10.2 的朴素 Lip 乘积上界。

**命题 10.6（纤维分解不等式，Fiber Decomposition Inequality）**：设 $\psi$ 在 $U$ 上以偏差 $\delta \geq 0$（§10.1）$(\phi_1, \phi_2)$-可分解。设 $\phi_1$ 的中间态误差为 $\varepsilon_1$，$\phi_2$ 的拟合误差为 $\varepsilon_2$。则对任意参考函数 $\rho$：

$$d_\Omega(\psi, \rho) \;\leq\; \delta \;+\; \varepsilon_2 \;+\; \begin{cases} \varepsilon & \text{若 } \varepsilon_1 \leq \varepsilon / L^\perp_{\phi_2} \\ L^\perp_{\phi_2} \cdot \varepsilon_1 & \text{否则} \end{cases}$$

**证明**：$\delta = d_\Omega(\psi, \phi_2 \circ \phi_1)|_U$ 由度量三角不等式给出。命题 10.5 应用于左复合 $\ell_{\phi_2}$ 得 $d_\Omega(\phi_2 \circ \phi_1, \phi_2 \circ \phi_1^*)$ 的纤维吸收界，其中 $\phi_1^*$ 为理想中间映射。再加上 $\phi_2$ 自身的拟合误差 $\varepsilon_2$。$\square$

比较两种退化：

**(i) 无纤维吸收**（$\varepsilon_1 > \varepsilon / L^\perp_{\phi_2}$）：$d_\Omega(\psi, \rho) \leq \delta + \varepsilon_2 + L^\perp_{\phi_2} \cdot \varepsilon_1$——中间态误差以 $L^\perp_{\phi_2}$ 放大。

**(ii) 纤维吸收生效**（$\varepsilon_1 \leq \varepsilon / L^\perp_{\phi_2}$）：$d_\Omega(\psi, \rho) \leq \delta + \varepsilon_2 + \varepsilon$——无论 $\varepsilon_1$ 具体多大，只要不超过死区，传播误差被压缩至 $\varepsilon$。$L^\perp_{\phi_2}$ 越小（纤维越粗），越容易触发吸收。

#### 推论 10.7（单步优势，Single-Step Advantage）

设 $\psi$ 在 $U$ 上以偏差 $\delta \geq 0$ $(\phi_1, \phi_2)$-可分解，且满足**纤维保持条件** $L^\perp_\psi \leq \max(L^\perp_{\phi_1}, L^\perp_{\phi_2})$。则：

**(i)** $\bigl|d_\Omega(\psi, \rho)\big|_U - d_\Omega(\phi_2 \circ \phi_1, \rho)\big|_U\bigr| \;\leq\; \delta$

**(ii)** $L^\perp_\psi \;\leq\; L^\perp_{\phi_2 \circ \phi_1}$（单步的横截 Lip 不比展开链更大）

**(iii)** $\mathcal{D}_{\tau'}(\rho, \phi_2 \circ \phi_1) \;\subseteq\; \mathcal{D}_{\tau' + \delta}(\rho, \psi)$

**证明**：(i) 由 $\delta$-可分解性定义和三角不等式直接得。(ii) §9.6 纤维深度极限：复合中的纤维膨胀使链的横截灵敏度递增（$L^\perp_{\phi_2 \circ \phi_1} \geq \max(L^\perp_{\phi_1}, L^\perp_{\phi_2})$），由纤维保持条件即得。(iii) 由 (i)(ii) 和容差扩大 $\delta$ 得。$\square$

> **注（冗余是"近似免费的午餐"）**：推论 10.7 表明宏算子 $\psi$ 与链展开 $\phi_2 \circ \phi_1$ 在 $U$ 上拟合误差至多相差 $\delta$，而纤维宽度**只宽不窄**（$L^\perp$ 只小不大）。当 $\delta \ll \tau$ 时，$\psi$ 以几乎零代价获得更宽的纤维和更大的扩散集——冗余不仅降低有效深度，还保持更宽的纤维。

#### 拟合误差的 IDFS 解读

在 IDFS 框架中，取 $\psi$ 为 f-chain 的复合，$\rho = r_j$（目标），则 $d_\Omega(\psi, r_j)$ 即为拟合误差。拟合等价类（§10.4）即为以 $r_j$ 为中心、$\tau$ 为半径的**闭球**：

$$[r_j]_\tau \;=\; \{q \in F^{\leq \mathcal{D}} \mid d_\Omega(q, r_j) \leq \tau\}$$

命题 10.6 在此框架下表述为：从 f-chain 复合到 $r_j$ 的 $d_\Omega$-距离满足带 $\varepsilon$-纤维吸收的三角不等式——中间经过 $\phi_2 \circ \phi_1$ 时，$\phi_2$ 的纤维结构提供死区 $\varepsilon / L^\perp_{\phi_2}$。

> **注（与经典泛函分析的联系）**：$(F, d_\Omega)$ 在经典泛函分析中对应 $C(\mathcal{X}, \mathcal{Y})$ 的 sup-范数拓扑。$\varepsilon$-纤维吸收是对经典 Lipschitz 算子半群理论的**精细化**——经典理论只考虑全局广义 Lip 常数 $L$，纤维理论用局部横截 Lip $L^\perp$ 替代，揭示纤维方向上的距离死区。当 $\psi$ 为单射时（$L^\perp_\psi = L_\psi$），纤维吸收退化为经典 Lipschitz。

---

### 10.4 拟合等价类与纤维质量

§10.2 定义了子链 $\delta_0$-替换，§10.3 建立了 $(F, d_\Omega)$ 上的代数结构。本节将视角扩大到**所有**能拟合 $r_j$ 的 f-chain——即 $d_\Omega$ 下以 $r_j$ 为中心的 $\tau$-球——并分析它们的纤维质量差异对泛化的影响。

#### 定义（拟合等价类）

对目标 $(r_j, \mathcal{X}(r_j)) \in \mathcal{S}$ 和容差 $\tau > 0$，定义 $r_j$ 的**拟合等价类**：

$$[r_j]_\tau \;\triangleq\; \{q \in F^{\leq \mathcal{D}} \mid \sup_{x \in \mathcal{X}(r_j)} d(q(x), r_j(x)) \leq \tau\}$$

即所有在 $\mathcal{X}(r_j)$ 上以容差 $\tau$ 拟合 $r_j$ 的 f-chain 集合。$[r_j]_\tau \neq \varnothing$ 当且仅当系统 $\Phi$ 以容差 $\tau$ 拟合 $(r_j, \mathcal{X}(r_j))$。

**命题 10.8（替换膨胀等价类）**：设 $[r_j]_\tau \neq \varnothing$ 且存在 f-chain $\psi_{1:k} \in [r_j]_\tau$ 和 $\chi \in F$ 为某子链的 $\delta_0$-替换（§10.2），使得替换后的链 $\psi_{1:k}'$ 满足 $d_\Omega(|\psi_{1:k}'|, |\psi_{1:k}|)|_{\mathcal{X}(r_j)} \leq \tau - d_\Omega(|\psi_{1:k}|, r_j)$。则 $|[r_j]_\tau| \geq 2$。

**证明**：由三角不等式，$d_\Omega(|\psi_{1:k}'|, r_j) \leq d_\Omega(|\psi_{1:k}'|, |\psi_{1:k}|) + d_\Omega(|\psi_{1:k}|, r_j) \leq \tau$。故 $\psi_{1:k}' \in [r_j]_\tau$ 且 $\psi_{1:k}' \neq \psi_{1:k}$（链结构不同）。$\square$

#### 等价类的纤维质量差异

$[r_j]_\tau$ 内所有链在 $\mathcal{X}(r_j)$ 上的误差均 $\leq \tau$——采样集内无差别。但它们的**纤维结构**可能截然不同。

**定义（链的纤维质量）**：对 $q \in [r_j]_\tau$，定义其在 $\mathcal{X}(r_j)$ 上的**纤维质量指标**：

- **纤维宽度下确界**：$\underline{w}_q \;\triangleq\; \inf_{x_0 \in \mathcal{X}(r_j)} w_q(q(x_0))$——链在采样集上的最窄纤维，刻画泛化的最弱环节。
- **局部横截灵敏度**：$L^\perp_q(y)$（§9.2）——在具体中间输出 $y$ 处的跨纤维放大率。
- **纤维膨胀量**：$\mathrm{FI}_\varepsilon(q)$（§9.6）——链的总信息坍缩量。

**命题 10.9（纤维宽度决定扩散集包含）**：设 $q_A, q_B \in [r_j]_\tau$。若对所有 $x_0 \in \mathcal{X}(r_j)$，$w_{q_A}(q_A(x_0)) \geq w_{q_B}(q_B(x_0))$，则对任意容差 $\tau' \geq \tau$：

$$\mathcal{D}_{\tau'}(r_j, q_B) \;\subseteq\; \mathcal{D}_{\tau'}(r_j, q_A)$$

其中 $\mathcal{D}_{\tau'}(r_j, q) = \bigcup_{x_0 \in \mathcal{X}(r_j)} \mathrm{TFI}^{\varepsilon_r, \varepsilon_f}(x_0;\, q)$ 为链 $q$ 在容差 $\tau'$ 下的纤维扩散集（推论 9.3）。

**证明**：TFI 的第三项 $\mathfrak{F}_q^{\varepsilon_f}(q(x_0))$ 满足：$w_q(q(x_0))$ 更大时，$\varepsilon_f$-纤维覆盖更大范围的输入，即 $\mathfrak{F}_{q_A}^{\varepsilon_f}(q_A(x_0)) \supseteq \mathfrak{F}_{q_B}^{\varepsilon_f}(q_B(x_0))$。TFI 的前两项（$\mathfrak{F}_\sigma$ 和 $\mathfrak{F}_r$）不依赖 $q$ 的纤维宽度。因此 $\mathrm{TFI}(x_0;\, q_A) \supseteq \mathrm{TFI}(x_0;\, q_B)$ 对每个 $x_0$ 成立，取并即得结论。$\square$

**推论 10.10（$\sigma$ 选择效应）**：设 $q^* = \arg\max_{q \in [r_j]_\tau} \underline{w}_q$。则 $\mathcal{D}_{\tau'}(r_j, q^*)$ 在 $[r_j]_\tau$ 的所有单链选择中最大（集合包含意义下）。反之，选择 $\underline{w}_q$ 最小的链产生最小的扩散集。因此 $\sigma$ 的路由选择直接控制采样外泛化的范围。

> **注（等价类内的选择解释 OOD 差异）**：两个 IDFS 系统 $\Phi_1$、$\Phi_2$ 在 $\mathcal{X}(r_j)$ 上拟合误差相同（均 $\leq \tau$），但 OOD 表现可能有数量级差距。纤维视角给出了一种结构性解释：$\Phi_1$ 的 $\sigma_1$ 选择了 $[r_j]_\tau$ 中 $\underline{w}_q$ 大的链，$\Phi_2$ 的 $\sigma_2$ 选择了 $\underline{w}_q$ 小的链。采样集内无差别，采样集外差别由纤维质量决定。

---

### 10.5 最小基理论

#### 深度-冗余权衡

非最小 $F$ 的冗余有明确的代价与收益：

- **代价**：$|F| > |F_{\min}^{\delta_0}|$ 增大了路由混叠的可能性——$\sigma$ 的组合空间 $M^{\mathcal{D}}$ 随 $M = |F|$ 指数增长，但路由容量 $|\mathrm{Im}(\sigma)|$ 受限，混叠倍增。
- **收益**：冗余的 $g$ 充当"宏指令"，将多步 f-chain 复合预编译为单步。有效链深从 $k_{\min}$ 降至 $k_F \leq k_{\min}$，CAC 误差积累从 $O(L^{k_{\min}})$ 降至 $O(L^{k_F})$——**指数级改善**。

**定理 10.11（深度-冗余权衡，Depth-Redundancy Trade-off）**：设 $F_{\min}^{\delta_0}$ 为 $F$ 的 $\delta_0$-不可约核，$L \in \bar{\mathbb{R}}_+$ 为系统的广义 Lip 常数。对目标 $r_j$，定义：

- $k_{\min}(r_j) = \min\{k \mid \exists\, q \in (F_{\min}^{\delta_0})^{\leq k} : q \in [r_j]_\tau\}$：用不可约核拟合 $r_j$ 的最短链深
- $k_F(r_j) = \min\{k \mid \exists\, q \in F^{\leq k} : q \in [r_j]_\tau\}$：用完整基拟合 $r_j$ 的最短链深

则 $k_F(r_j) \leq k_{\min}(r_j)$，且当 $L > 1$ 时，CAC 误差满足：

$$\frac{\varepsilon_{\mathrm{CAC}}(F_{\min}^{\delta_0}, r_j)}{\varepsilon_{\mathrm{CAC}}(F, r_j)} \;\geq\; L^{k_{\min}(r_j) - k_F(r_j)}$$

即冗余基相对于最小基的误差改善至少为 $L^{\Delta k}$，其中 $\Delta k = k_{\min} - k_F$ 是冗余节省的链深。

**证明**：$k_F \leq k_{\min}$ 由 $F_{\min}^{\delta_0} \subseteq F$ 直接得——$F$ 的链空间包含 $F_{\min}^{\delta_0}$ 的链空间，故最短链深不增。CAC 的误差主项为 $\varepsilon_0 \cdot \Lambda_k^{\mathrm{path}}$，其中 $\Lambda_k \sim L^k$。代入两个深度即得比值下界。$\square$

> **注（最小世界模型的形式化）**：$F_{\min}^{\delta_0}$ 对应"只学原理"的最小世界模型（minimal world model）——系统仅掌握不可再分解的基本操作，一切复杂行为由组合推导。定理 10.11 揭示了这一理想的**结构性代价**：最小模型最"纯粹"（最少原语、最紧凑），但由于有效链深 $k_{\min}$ 最大，CAC 误差积累最严重。实际系统通过学习冗余的 $g$（即"经验模型"），以 $|F|$ 的线性增长换取误差的**指数级改善**。这解释了为什么大规模系统（如 Transformer）倾向于学习大量看似"冗余"的内部表征——这不是过拟合，是对有效深度的**结构性优化**。

> **注（与 Kolmogorov 复杂度的类比）**：$F_{\min}^{\delta_0}$ 类似最短程序描述——最紧凑但执行需要最多步骤；冗余的 $F$ 类似带子程序缓存的描述——描述更长但执行更快。最优 $|F|$ 在两者之间：足够小以避免路由混叠爆炸（$M^{\mathcal{D}}$ 增长），足够大以压缩关键的高频子链（$k_F \ll k_{\min}$）。

> **注（纤维深度极限下的精化）**：定理 10.11 使用 CAC 的 Lip 乘积上界。结合 §9.6 的纤维深度极限（定理 9.9），冗余的 $F$ 还带来纤维层面的优势：宏指令 $g$ 的纤维宽度可能大于 $f_k \circ \cdots \circ f_1$ 的复合纤维宽度（复合链的纤维膨胀使纤维趋窄），从而冗余 $F$ 不仅降低有效深度，还通过更宽的纤维改善采样外泛化（推论 10.10）。

----
*[IDFS] ⊢ [GLENZLI] ⊢ [Part 03] ⊢ [10-operator-algebra] ⊢ [a8029e2f743ee9b7]*
