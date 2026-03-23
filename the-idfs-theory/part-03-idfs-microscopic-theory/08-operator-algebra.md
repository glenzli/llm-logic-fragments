## §10 算子代数与最小基理论

§9 建立了计算纤维的分析工具。本节将纤维视角转向 $F$ 的**内部结构**——实际 IDFS 的基函数库 $F$ 几乎总是非最小的，即存在 $g \in F$ 可被 $F$ 中其他成员的 f-chain 替代。这种冗余并非缺陷，而是系统对频繁子链的压缩编码。本节从算子可分解性出发，经由拟合等价类，最终建立最小基理论与深度-冗余权衡。

#### $\Omega$ 上的度量

§1 定义了算子空间 $\Omega = \{\phi: (\mathcal{X}, d) \to (\mathcal{X}, d)\}$。本章在 $\Omega$ 上引入 **sup-范数距离**：

$$d_\Omega(\phi, \psi) \;\triangleq\; \sup_{x \in \mathcal{X}} d(\phi(x), \psi(x))$$

$(\Omega, d_\Omega)$ 构成一个度量空间。$F \subset \Omega$，$R \subset \Omega$，f-chain 的复合 $\phi_k \circ \cdots \circ \phi_1 \in \Omega$——所有算子、目标和复合链都是 $\Omega$ 中的点。以下结论对任意 $\phi, \psi \in \Omega$ 成立。在不至混淆时，限制到 $F$ 上的度量仍记为 $d_\Omega$。

### 8.1 算子可分解性

#### 定义（算子可分解性，Operator Factorizability）

设 $\psi, \phi_1, \ldots, \phi_k: \mathcal{X} \to \mathcal{X}$（$k \geq 2$）和子集 $U \subseteq \mathcal{X}$。定义 $\psi$ 相对于 $(\phi_1, \ldots, \phi_k)$ 在 $U$ 上的**分解偏差**：

$$\delta(\psi;\, \phi_1, \ldots, \phi_k;\, U) \;\triangleq\; d_\Omega(\psi,\; \phi_k \circ \cdots \circ \phi_1)\big|_U$$

称 $\psi$ 在 $U$ 上以偏差 $\delta$ **$(\phi_1, \ldots, \phi_k)$-可分解**（$\delta$-decomposable）。$\delta = 0$ 时称为**精确可分解**——实际系统中一般不容易精确成立。

**纤维刻画**：精确可分解（$\delta = 0$）时，$\psi$ 与 $\phi_k \circ \cdots \circ \phi_1$ 在 $U$ 上共享纤维划分——对所有 $y \in \mathrm{Im}(\psi|_U)$：

$$\mathfrak{F}_\psi(y) \cap U \;=\; \mathfrak{F}_{\phi_k \circ \cdots \circ \phi_1}(y) \cap U$$

当 $\delta > 0$ 时，纤维划分不再精确一致，但在 $\delta$-邻域内近似一致（§7.1 的 $\varepsilon$-纤维意义下）。

#### 不可约核（IDFS 特化）

在 IDFS 框架中，$\psi, \phi_i$ 取自具体的基函数库 $F$。以下定义依赖于 $F$ 的有限性。

称 $f \in F$ 为**全局 $\delta_0$-不可约的**（globally $\delta_0$-irreducible），若：

$$\nexists\; U \subseteq \mathcal{X}\;(\text{非空开}),\; k \geq 2,\; \phi_1, \ldots, \phi_k \in F \setminus \{f\}:\quad d_\Omega(f,\; \phi_k \circ \cdots \circ \phi_1)\big|_U \leq \delta_0$$

即不存在 $F$ 中其他成员的复合在任何非空开集上以偏差 $\leq \delta_0$ 逼近 $f$。$\delta_0 = 0$ 退化为精确不可约。

$F$ 的 **$\delta_0$-不可约核**：

$$F_{\min}^{\delta_0} \;\triangleq\; \{f \in F \mid f \text{ 全局 } \delta_0\text{-不可约}\}$$

**冗余度**：$\rho_{\delta_0}(F) \triangleq |F| - |F_{\min}^{\delta_0}|$。$\delta_0$ 越大，不可约条件越严格，$F_{\min}^{\delta_0}$ 越大。

**命题 8.1（$\delta_0$-不可约核的生成性）**：$F_{\min}^{\delta_0}$ 以偏差不超过 $|F| \cdot \delta_0$ 生成 $F$ 的 f-chain 覆盖——对任意 $g \in F \setminus F_{\min}^{\delta_0}$，存在开子集 $U$ 和 $F_{\min}^{\delta_0}$ 中的成员链，使得 $d_\Omega(g, f_k \circ \cdots \circ f_1)|_U \leq |F| \cdot \delta_0$。

**证明**：由 $g \notin F_{\min}^{\delta_0}$，$g$ 在某个非空开集 $U$ 上可被 $F$ 中其他成员的复合以偏差 $\leq \delta_0$ 逼近。若复合中某个 $f_i \notin F_{\min}^{\delta_0}$，继续递归替换，每步引入至多 $\delta_0$ 的额外偏差。由 $|F|$ 有限，递归必终止，总偏差 $\leq |F| \cdot \delta_0$。$\square$

> **注（局部不可约）**：全局 $\delta_0$-不可约是最强条件。更精细的概念是**局部不可约性**：$f$ 在特定子集 $U$ 上不可被 $\delta_0$-逼近，但在另一子集 $V$ 上可以。全局不可约核 $F_{\min}^{\delta_0} = \bigcap_U F_{\min}^{\delta_0, L}(U)$（遍历所有非空开集）是最小的不可约集。

---

### 8.2 子链替换

$\delta$-可分解性的直接应用：当一条 $\phi$-链中的连续子链可被另一算子近似替代时，产生一条**替换链**。

#### 定义（$\delta_0$-替换）

设 $\phi$-链 $\phi_k \circ \cdots \circ \phi_1$（$\phi_i \in \Omega$），$\chi \in \Omega$，$1 \leq a \leq b \leq k$（$b - a \geq 1$）。若：

$$d_\Omega(\chi,\; \phi_b \circ \cdots \circ \phi_a)\big|_U \;\leq\; \delta_0$$

则称 $\chi$ 为子链 $\phi_b \circ \cdots \circ \phi_a$ 在 $U$ 上的 **$\delta_0$-替换**。替换后得到新链：

$$\phi_k \circ \cdots \circ \phi_{b+1} \circ \chi \circ \phi_{a-1} \circ \cdots \circ \phi_1$$

**命题 8.2（单步替换的偏差传播）**：设 $\chi$ 为子链 $\phi_{a:b}$ 的 $\delta_0$-替换，$\phi_{1:k}'$ 为替换后的链。则：

$$d_\Omega(|\phi_{1:k}'|,\; |\phi_{1:k}|)\big|_U \;\leq\; \delta_0 \cdot \prod_{j=b+1}^{k} L_{\phi_j}$$

即替换引入的偏差 $\delta_0$ 被下游算子的广义 Lip 常数逐级放大。

**证明**：设 $x \in U$，$y = (\phi_{a-1} \circ \cdots \circ \phi_1)(x)$。则 $d(\chi(y), (\phi_b \circ \cdots \circ \phi_a)(y)) \leq \delta_0$。此偏差经过 $\phi_{b+1}, \ldots, \phi_k$ 逐步传播，每步至多放大 $L_{\phi_j}$ 倍（$L_{\phi_j} \in \bar{\mathbb{R}}_+$ 一定存在）。取 $\sup$ 即得。$\square$

> **注（多步替换）**：对同一条链执行多次不重叠的替换时，各替换引入的偏差分别经不同的下游路径放大后在输出端叠加。精确的误差上界依赖于各替换位置和下游 Lip 常数的具体分布，§8.3 的纤维分解不等式提供了更精细的分析工具。

#### 路由等效性（IDFS 特化）

在 IDFS 框架中，$\phi_i \in F$，替换算子 $\chi \in F$，链即 f-chain。然而，并非所有替换链都可用——只有当替换后的总传播偏差满足：

$$d_\Omega(|\phi_{1:k}'|,\; |\phi_{1:k}|)\big|_U \;\leq\; \varepsilon$$

即不超过拟合容差 $\varepsilon$ 时，替换链才是 $\sigma$ 的**可用等效路径**。命题 8.2 给出的 $\delta_0 \cdot \prod L_{\phi_j}$ 上界决定了替换的可行性：$\delta_0$ 和下游 Lip 的乘积越小，替换越安全。

由于不同的等效链可能具有截然不同的纤维结构，$\sigma$ 将 $\mathcal{X}(r_j)$ 的不同区域分配到不同等效链上时，同一个 $r_j$ 的拟合质量在 $\mathrm{dom}(r_j)$ 上一般不均匀。

#### 纤维解释

子链 $\delta_0$-替换（命题 8.2）是定理 7.9（纤维深度极限，$\mathcal{A} \neq \varnothing$）的**极端特例**：

在 $\phi$-链 $\phi_k \circ \cdots \circ \phi_1$ 中，若子链 $\phi_{a:b}$ 存在 $\delta_0$-替换 $\chi$，则该子链的纤维结构被**预编译**为单步 $\chi$ 的纤维结构。用 §7.6 的语言：子链中间步的纤维膨胀 $\mathrm{FI}_\varepsilon(\phi_m|_{\cdots})$ 的累积效果被 $\mathrm{FI}_\varepsilon(\chi)$ 替代——中间步骤不消耗额外的分辨率预算。

> **注（路由混叠与子链替换的区别）**：子链替换与路由混叠（§2 定义，§3 推论 3.2）是两种不同机制：
> - **路由混叠**：由组合耗尽驱动——$|\mathrm{Im}(\sigma)| < M^{\mathcal{D}}$ 时，不同输入 $x_1, x_2$ 的微观路由 $\sigma(x_2) = \sigma_l(x_1)$ 重合，产生**确定性泛化**（$x_2$ 的单步行为与 $x_1$ 的 $l$ 步宏观行为在计算程序层面完全等同）。
> - **子链替换**：由 $F$ 的代数冗余驱动——同一个目标 $r_j$ 可由多条不同的 f-chain 分别拟合 $\mathcal{X}(r_j)$ 的不同子区域。$\sigma$ **可能**（但不必然）将 $\mathcal{X}(r_j)$ 拆分到不同的等效链上。这种拆分可能带来一定程度的泛化（通过纤维扩散），但**不保证**——取决于各等效链的纤维质量。
>
> 前者是输入空间不同位置在**计算程序层面的简并**；后者是同一目标在**拟合路径层面的多重覆盖**。

---

### 8.3 算子代数结构

§8.2 给出了子链替换的粗糙偏差传播上界 $\delta_0 \cdot \prod L_{\psi_j}$。本节的目标是用 $\Omega$ 上的**纤维结构收紧这个界**——吸收半径提供距离死区，使得实际偏差传播远小于朴素 Lip 乘积。

#### 复合的度量相容性

复合 $\circ$ 赋予 $(\Omega, \circ)$ 幺半群（monoid）结构：结合律 $(\psi \circ \phi) \circ \chi = \psi \circ (\phi \circ \chi)$、恒等元 $\mathrm{id}$、一般不交换。关键问题是：复合与度量 $d_\Omega$ 如何相容？

**命题 8.4（左复合的 Lipschitz 收缩）**：对 $\psi, \phi_1, \phi_2 \in \Omega$：

$$d_\Omega(\psi \circ \phi_1,\; \psi \circ \phi_2) \;\leq\; L_\psi \cdot d_\Omega(\phi_1, \phi_2)$$

其中 $L_\psi \in \bar{\mathbb{R}}_+$ 为 $\psi$ 的广义 Lip 常数（一定存在）。即左复合 $\ell_\psi: \phi \mapsto \psi \circ \phi$ 是 $(\Omega, d_\Omega)$ 上的 $L_\psi$-广义 Lipschitz 映射。

**证明**：$d(\psi(\phi_1(x)), \psi(\phi_2(x))) \leq L_\psi \cdot d(\phi_1(x), \phi_2(x))$，取 $\sup$ 即得。$\square$

#### 纤维吸收的 $\Omega$-提升

命题 8.4 给出了朴素的广义 Lip 收缩。将 §7.5 的纤维吸收（定理 7.4）提升到 $(Ω, d_Ω)$ 上——逐点应用吸收半径判据后取 $\sup$——得到更精细的界。

**命题 8.5（纤维吸收的 $\Omega$-提升）**：对 $\psi \in \Omega$，$\varepsilon \geq 0$。则：

$$d_\Omega(\psi \circ \phi_1,\; \psi \circ \phi_2) \;\leq\; \varepsilon \;+\; L^\perp_\psi \cdot \max\bigl(0,\; d_\Omega(\phi_1, \phi_2) - \underline{\alpha}_\psi^\varepsilon\bigr)$$

其中 $\underline{\alpha}_\psi^\varepsilon$ 为 $\psi$ 的最小 $\varepsilon$-吸收半径（§7.1），$L^\perp_\psi \in \bar{\mathbb{R}}_+$ 为 $\psi$ 的局部横截广义 Lip 常数（§7.2）。

**证明**：对每个 $x$，设 $y_1 = \phi_1(x)$，$y_2 = \phi_2(x)$。若 $d(y_1, y_2) \leq \underline{\alpha}_\psi^\varepsilon$，则 $y_2 \in \mathfrak{F}_\psi^\varepsilon(\psi(y_1))$，故 $d(\psi(y_1), \psi(y_2)) \leq \varepsilon$。若 $d(y_1, y_2) > \underline{\alpha}_\psi^\varepsilon$，超出部分 $d(y_1, y_2) - \underline{\alpha}_\psi^\varepsilon$ 逃逸出 $\varepsilon$-纤维，在横截方向以 $L^\perp_\psi$ 放大。取 $\sup$ 即得。$\square$

> **注**：当 $\psi$ 为单射时，$\underline{\alpha}_\psi^\varepsilon = 0$ 对所有 $\varepsilon$，退化为命题 8.4。$\underline{\alpha}_\psi^\varepsilon \geq \varepsilon / L^\perp_\psi$ 恒成立（由 Lip 界保证），但实际吸收半径可远大于此——纤维内 $\psi$ 完全不放大，不受 $L^\perp$ 约束。

#### 定义（纤维-Lipschitz 幺半群）

称 $(\Omega, \circ, d_\Omega)$ 为 **纤维-Lipschitz 幺半群**（Fiber-Lipschitz Monoid），若对每个 $\psi \in \Omega$，存在 $\varepsilon \geq 0$ 使得左复合 $\ell_\psi$ 满足命题 8.5 的 $\varepsilon$-纤维吸收条件且 $\underline{\alpha}_\psi^\varepsilon > 0$。

条件的含义：复合不是简单的 Lipschitz 运算，而是**带近似吸收的收缩运算**——每个算子的 $\varepsilon$-吸收半径提供距离死区 $\underline{\alpha}_\psi^\varepsilon$，在此范围内的差异被压缩至 $\varepsilon$ 以内。

#### 命题 8.6（单步优势，Single-Step Advantage）

设 $\psi$ 在 $U$ 上以偏差 $\delta \geq 0$（§8.1）$(\phi_1, \phi_2)$-可分解，且满足**纤维保持条件** $\underline{\alpha}_\psi^\varepsilon \geq \min(\underline{\alpha}_{\phi_1}^\varepsilon, \underline{\alpha}_{\phi_2}^\varepsilon)$（§7.1）。则对任意 $\rho \in \Omega$：

**(i) 拟合等价性**：

$$\bigl|d_\Omega(\psi, \rho)\big|_U - d_\Omega(\phi_2 \circ \phi_1, \rho)\big|_U\bigr| \;\leq\; \delta$$

**证明**：由 $\delta$-可分解性，$d_\Omega(\psi, \phi_2 \circ \phi_1)|_U \leq \delta$。对任意 $\rho$，三角不等式给出 $d_\Omega(\psi, \rho)|_U \leq d_\Omega(\psi, \phi_2 \circ \phi_1)|_U + d_\Omega(\phi_2 \circ \phi_1, \rho)|_U \leq \delta + d_\Omega(\phi_2 \circ \phi_1, \rho)|_U$。交换 $\psi$ 与 $\phi_2 \circ \phi_1$ 的角色得反向不等式。取差即得。$\square$

**(ii) 吸收半径不退化**：

$$\underline{\alpha}_\psi^\varepsilon \;\geq\; \underline{\alpha}_{\phi_2 \circ \phi_1}^\varepsilon$$

**证明**：对复合链 $\phi_2 \circ \phi_1$，吸收半径受瓶颈约束。设 $y \in \mathrm{dom}(\phi_2)$，扰动 $y' \in B(y, r)$ 要留在 $(\phi_2 \circ \phi_1)$ 的 $\varepsilon$-纤维内，需同时满足 $y'$ 对 $\phi_1$ 和 $\phi_2$ 的纤维约束。因此 $\alpha_{\phi_2 \circ \phi_1}^\varepsilon(y) \leq \min(\alpha_{\phi_1}^\varepsilon(y), \alpha_{\phi_2}^\varepsilon(\phi_1(y)))$，取 $\inf$ 得 $\underline{\alpha}_{\phi_2 \circ \phi_1}^\varepsilon \leq \min(\underline{\alpha}_{\phi_1}^\varepsilon, \underline{\alpha}_{\phi_2}^\varepsilon)$。由纤维保持条件 $\underline{\alpha}_\psi^\varepsilon \geq \min(\underline{\alpha}_{\phi_1}^\varepsilon, \underline{\alpha}_{\phi_2}^\varepsilon)$ 即得。$\square$

> **注（与经典泛函分析的联系）**：$(\Omega, d_\Omega)$ 在经典泛函分析中对应 $C(\mathcal{X}, \mathcal{X})$ 的 sup-范数拓扑。命题 8.5 是对经典 Lipschitz 算子半群理论的**精细化**——经典理论只考虑全局广义 Lip 常数 $L$，纤维理论增加了吸收半径 $\underline{\alpha}_\psi^\varepsilon$ 的距离死区。当 $\psi$ 为单射时（$\underline{\alpha}_\psi^\varepsilon = 0$），退化为经典 Lipschitz。



> **注（OOD 差异的一种可能解释）**：§8.2 指出同一目标可由多条纤维结构不同的等效链拟合。纤维视角提供了一种**可能的**结构性视角：不同系统的 $\sigma$ 选择了纤维结构（吸收半径、横截灵敏度、膨胀量）不同的链，采样集内无差别，但采样集外的表现可能因此而异。具体影响取决于纤维几何与输入分布的匹配，不能一般性地断言。

---

### 8.4 最小基理论

#### 定义（拟合等价类）

对目标 $(r_j, \mathcal{X}(r_j)) \in \mathcal{S}$ 和容差 $\tau > 0$，定义 $r_j$ 的**拟合等价类**：

$$[r_j]_\tau \;\triangleq\; \{q \in F^{\leq \mathcal{D}} \mid \sup_{x \in \mathcal{X}(r_j)} d(q(x), r_j(x)) \leq \tau\}$$

即所有在 $\mathcal{X}(r_j)$ 上以容差 $\tau$ 拟合 $r_j$ 的 f-chain 集合。§8.2 的子链替换直接膨胀等价类（三角不等式）。

$F_{\min}^{\delta_0}$ 是 $F$ 的 $\delta_0$-不可约核（§8.1）。冗余基 $F \supsetneq F_{\min}^{\delta_0}$ 中的额外成员 $g$ 将多步 f-chain 复合预编译为单步——有效链深降低。

**命题 8.7（链深不增性）**：对目标 $r_j$，定义：

- $k_{\min}(r_j) = \min\{k \mid \exists\, q \in (F_{\min}^{\delta_0})^{\leq k} : q \in [r_j]_\tau\}$：用不可约核拟合 $r_j$ 的最短链深
- $k_F(r_j) = \min\{k \mid \exists\, q \in F^{\leq k} : q \in [r_j]_\tau\}$：用完整基拟合 $r_j$ 的最短链深

则 $k_F(r_j) \leq k_{\min}(r_j)$。

**证明**：$F_{\min}^{\delta_0} \subseteq F$，故 $F$ 的链空间包含 $F_{\min}^{\delta_0}$ 的链空间，最短链深不增。$\square$

#### 冗余的微观收益

链深降低 $\Delta k = k_{\min} - k_F \geq 0$ 在微观层面的直接推论：

**命题 8.8（有效消耗步数上界）**：链 $q$ 的有效消耗步集 $\mathcal{A}^c(q)$（§7.6）满足 $|\mathcal{A}^c(q)| \leq k$，其中 $k$ 为 $q$ 的链长。因此：

$$|\mathcal{A}^c(q_F)| \;\leq\; k_F \;\leq\; k_{\min}$$

即更短的链有更紧的分辨率消耗上界（定理 7.9）。注意这是上界的比较，不是实际消耗步数的比较——短链的实际 $|\mathcal{A}^c|$ 不一定小于长链。

**证明**：$\mathcal{A}^c(x) \subseteq \{1, \ldots, k\}$（§7.6），故 $|\mathcal{A}^c| \leq k$。由命题 8.7，$k_F \leq k_{\min}$。$\square$

更精确的收益需要命题 8.6（单步优势）的纤维保持条件。当冗余算子 $g \in F \setminus F_{\min}^{\delta_0}$ 以偏差 $\delta \leq \delta_0$ $(\phi_1, \phi_2)$-可分解，且满足纤维保持条件时：

- **拟合代价有界**：单步 $g$ 相对于展开链 $\phi_2 \circ \phi_1$ 的拟合偏差 $\leq \delta$（命题 8.6(i)）
- **吸收半径不退化**：$\underline{\alpha}_g^\varepsilon \geq \underline{\alpha}_{\phi_2 \circ \phi_1}^\varepsilon$——宏算子的纤维至少与其展开链一样厚（命题 8.6(ii)）

因此，冗余基在满足纤维保持条件时，以至多 $\delta$ 的拟合代价换取更短的链深和不退化的纤维厚度。

> **注（最小基的类比）**：$F_{\min}^{\delta_0}$ 可类比为系统的"基本指令集"——仅包含不可再分解的操作，一切复杂行为由组合推导。命题 8.7–10.8 表明这类最小配置的有效链深 $k_{\min}$ 最大，分辨率消耗上界最宽松。实际系统中冗余算子的存在——将常用子链预编译为单步——可视为以 $|F|$ 的增长换取链深的降低。

> **注（与 Kolmogorov 复杂度的类比）**：$F_{\min}^{\delta_0}$ 类似最短程序描述——最紧凑但执行需要最多步骤；冗余的 $F$ 类似带子程序缓存的描述——描述更长但执行更快。

> **注（纤维保持条件的限制）**：以上纤维层面的收益依赖命题 8.6 的纤维保持条件 $\underline{\alpha}_\psi^\varepsilon \geq \min(\underline{\alpha}_{\phi_1}^\varepsilon, \underline{\alpha}_{\phi_2}^\varepsilon)$。该条件要求宏算子的纤维至少与其组成部分的瓶颈一样厚——这是一个关于宏算子**内部结构**的非平凡假设，不能从可分解性本身推出。当条件不满足时，冗余仍降低链深，但纤维层面的优势无法保证。

----
*[IDFS] ⊢ [GLENZLI] ⊢ [Part 03] ⊢ [10-operator-algebra] ⊢ [a8029e2f743ee9b7]*
