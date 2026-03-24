## §8 算子代数

§7 建立了计算纤维的逐点分析工具。本节转向算子空间 $(\Omega, d_\Omega)$ 的**全局代数-度量结构**，在此框架下重新审视算子分解、子链替换与误差传播。核心结论是复合操作的**左右不对称性**——左复合可放大也可吸收，右复合从不放大但限制信息——以及由此衍生的上游压缩与下游吸收的**协同效应**。

#### $\Omega$ 上的度量

§1 定义了算子空间 $\Omega = \{\phi: (\mathcal{X}, d) \to (\mathcal{X}, d)\}$。本章在 $\Omega$ 上引入 **sup-范数距离**：

$$d_\Omega(\phi, \psi) \;\triangleq\; \sup_{x \in \mathcal{X}} d(\phi(x), \psi(x))$$

$(\Omega, d_\Omega)$ 构成一个度量空间。$F \subset \Omega$，$R \subset \Omega$，f-chain 的复合 $\phi_k \circ \cdots \circ \phi_1 \in \Omega$——所有算子、目标和复合链都是 $\Omega$ 中的点。以下结论对任意 $\phi, \psi \in \Omega$ 成立。在不至混淆时，限制到 $F$ 上的度量仍记为 $d_\Omega$。

定义**限制 sup-距离**：对 $S \subseteq \mathcal{X}$，

$$d_\Omega(\phi, \psi)\big|_S \;\triangleq\; \sup_{x \in S} d(\phi(x), \psi(x))$$

$d_\Omega(\phi, \psi) = d_\Omega(\phi, \psi)|_\mathcal{X}$。

---

### 8.1 算子空间的代数-度量结构

复合 $\circ$ 赋予 $(\Omega, \circ)$ 幺半群（monoid）结构：结合律 $(\psi \circ \phi) \circ \chi = \psi \circ (\phi \circ \chi)$、恒等元 $\mathrm{id}$、一般不交换。关键问题是：复合与度量 $d_\Omega$ 如何相容？

#### 左复合

**命题 8.1（左复合的 Lipschitz 性）**：对 $\psi, \phi_1, \phi_2 \in \Omega$：

$$d_\Omega(\psi \circ \phi_1,\; \psi \circ \phi_2) \;\leq\; L_\psi \cdot d_\Omega(\phi_1, \phi_2)$$

其中 $L_\psi \in \bar{\mathbb{R}}_+$ 为 $\psi$ 的广义 Lip 常数（一定存在）。即左复合 $\ell_\psi: \phi \mapsto \psi \circ \phi$ 是 $(\Omega, d_\Omega)$ 上的 $L_\psi$-广义 Lipschitz 映射。

**证明**：$d(\psi(\phi_1(x)), \psi(\phi_2(x))) \leq L_\psi \cdot d(\phi_1(x), \phi_2(x))$，取 $\sup$ 即得。$\square$

#### 纤维吸收的 $\Omega$-提升

命题 8.1 给出了朴素的广义 Lip 收缩。将 §7.5 的纤维吸收（定理 7.5）提升到 $(\Omega, d_\Omega)$ 上——逐点应用吸收半径判据后取 $\sup$——得到更精细的界。

**命题 8.2（纤维吸收的 $\Omega$-提升）**：对 $\psi \in \Omega$，$\varepsilon \geq 0$。则：

$$d_\Omega(\psi \circ \phi_1,\; \psi \circ \phi_2) \;\leq\; \varepsilon \;+\; L_\psi \cdot \max\bigl(0,\; d_\Omega(\phi_1, \phi_2) - \underline{\alpha}_\psi^\varepsilon\bigr)$$

其中 $\underline{\alpha}_\psi^\varepsilon$ 为 $\psi$ 的最小 $\varepsilon$-吸收半径（§7.1），$L_\psi \in \bar{\mathbb{R}}_+$ 为 $\psi$ 的广义 Lip 常数。

**证明**：对每个 $x$，设 $y_1 = \phi_1(x)$，$y_2 = \phi_2(x)$。分两种情况：

- 若 $d(y_1, y_2) \leq \underline{\alpha}_\psi^\varepsilon$，则由 $\varepsilon$-吸收半径定义（§7.1），$y_2 \in \mathfrak{F}_\psi^\varepsilon(\psi(y_1))$，故 $d(\psi(y_1), \psi(y_2)) \leq \varepsilon$。
- 若 $d(y_1, y_2) > \underline{\alpha}_\psi^\varepsilon$，则由 $\psi$ 的广义 Lip 性，$d(\psi(y_1), \psi(y_2)) \leq L_\psi \cdot d(y_1, y_2)$。

综合两种情况：$d(\psi(y_1), \psi(y_2)) \leq \max(\varepsilon,\; L_\psi \cdot d(y_1, y_2)) \leq \varepsilon + L_\psi \cdot \max(0, d(y_1, y_2) - \underline{\alpha}_\psi^\varepsilon)$（第一种情况下 $\max$ 项 $= 0$，贡献 $\leq \varepsilon$；第二种情况下两项均贡献）。取 $\sup_x$ 即得。$\square$

> **注**：当 $\psi$ 为单射时，$\underline{\alpha}_\psi^\varepsilon = 0$ 对所有 $\varepsilon$，退化为命题 8.1。

#### 右复合

**命题 8.3（右复合收缩）**：对 $\psi, \phi_1, \phi_2 \in \Omega$：

$$d_\Omega(\phi_1 \circ \psi,\; \phi_2 \circ \psi) \;=\; d_\Omega(\phi_1, \phi_2)\big|_{\mathrm{Im}(\psi)} \;\leq\; d_\Omega(\phi_1, \phi_2)$$

即右乘 $r_\psi: \phi \mapsto \phi \circ \psi$ 是 $(\Omega, d_\Omega)$ 上的 **1-Lipschitz** 映射——永远不放大。当 $\mathrm{Im}(\psi) = \mathcal{X}$ 时取等。

**证明**：$d_\Omega(\phi_1 \circ \psi, \phi_2 \circ \psi) = \sup_x d(\phi_1(\psi(x)), \phi_2(\psi(x)))$。令 $y = \psi(x)$，$x$ 遍历 $\mathcal{X}$ 时 $y$ 遍历 $\mathrm{Im}(\psi) \subseteq \mathcal{X}$，故 $\sup$ 限制到 $\mathrm{Im}(\psi)$ 上，不超过全局 $\sup$。$\square$

> **注（信息限制）**：右复合将 $\phi_1, \phi_2$ 的比较域从全空间 $\mathcal{X}$ **限制到** $\mathrm{Im}(\psi)$。$\phi_1, \phi_2$ 在 $\mathcal{X} \setminus \mathrm{Im}(\psi)$ 上的差异对 $\phi_1 \circ \psi$ 与 $\phi_2 \circ \psi$ 完全不可见——信息被 $\psi$ 的纤维结构**不可逆地过滤**。

#### 左右不对称性

**命题 8.4（复合的结构性非交换性）**：在 $(\Omega, \circ, d_\Omega)$ 中：

**(i)** 左乘 $\ell_\psi: \phi \mapsto \psi \circ \phi$ 是 $L_\psi$-Lipschitz 映射（命题 8.1）。当 $L_\psi > 1$ 时**放大**差异，当 $\underline{\alpha}_\psi^\varepsilon > 0$ 时在死区内**吸收**差异（命题 8.2）。

**(ii)** 右乘 $r_\psi: \phi \mapsto \phi \circ \psi$ 是 $1$-Lipschitz 映射（命题 8.3）。**从不放大**差异，但将比较域限制到 $\mathrm{Im}(\psi)$，导致信息的**不可逆丢失**。

#### 纤维-Lipschitz 幺半群

**定义**：称 $(\Omega, \circ, d_\Omega)$ 为 **纤维-Lipschitz 幺半群**（Fiber-Lipschitz Monoid），若对每个 $\psi \in \Omega$，存在 $\varepsilon \geq 0$ 使得左复合 $\ell_\psi$ 满足命题 8.2 的 $\varepsilon$-纤维吸收条件且 $\underline{\alpha}_\psi^\varepsilon > 0$。

条件的含义：复合不是简单的 Lipschitz 运算，而是**带近似吸收的收缩运算**——每个算子的 $\varepsilon$-吸收半径提供距离死区 $\underline{\alpha}_\psi^\varepsilon$，在此范围内的差异被压缩至 $\varepsilon$ 以内。

> **注（与经典泛函分析的联系）**：$(\Omega, d_\Omega)$ 在经典泛函分析中对应 $C(\mathcal{X}, \mathcal{X})$ 的 sup-范数拓扑。命题 8.2 是对经典 Lipschitz 算子半群理论的**精细化**——经典理论只考虑全局广义 Lip 常数 $L$，纤维理论增加了吸收半径 $\underline{\alpha}_\psi^\varepsilon$ 的距离死区。当 $\psi$ 为单射时（$\underline{\alpha}_\psi^\varepsilon = 0$），退化为经典 Lipschitz。

> **注（$\phi$-chain 中每一步的双重角色）**：在链 $\phi_k \circ \cdots \circ \phi_1$ 中，步 $\phi_m$（$1 < m < k$）同时扮演两个角色：作为 $\phi_{m-1} \circ \cdots \circ \phi_1$ 的**左因子**，它的 Lip 常数和吸收半径决定上游误差的放大/吸收；作为 $\phi_{m+1}$ 的**右因子**，$\mathrm{Im}(\phi_m \circ \cdots \circ \phi_1)$ 决定 $\phi_{m+1}$ 及其下游能"看到"多少信息。

---

### 8.2 算子可分解性

#### 定义（局部可分解性，Local Factorizability）

设 $\psi, \phi_1, \ldots, \phi_k: \mathcal{X} \to \mathcal{X}$（$k \geq 2$）和子集 $S \subseteq \mathcal{X}$。定义 $\psi$ 相对于 $(\phi_1, \ldots, \phi_k)$ 在 $S$ 上的**分解偏差**：

$$\delta(\psi;\, \phi_1, \ldots, \phi_k;\, S) \;\triangleq\; d_\Omega(\psi,\; \phi_k \circ \cdots \circ \phi_1)\big|_S$$

称 $\psi$ 在 $S$ 上以偏差 $\delta$ **$(\phi_1, \ldots, \phi_k)$-可分解**（$\delta$-decomposable）。$\delta = 0$ 时称为**精确可分解**。$S = \mathcal{X}$ 时称为**全局可分解**。

**纤维刻画**：精确可分解（$\delta = 0$）时，$\psi$ 与 $\phi_k \circ \cdots \circ \phi_1$ 在 $S$ 上共享纤维划分——对所有 $y \in \mathrm{Im}(\psi|_S)$：

$$\mathfrak{F}_\psi(y) \cap S \;=\; \mathfrak{F}_{\phi_k \circ \cdots \circ \phi_1}(y) \cap S$$

当 $\delta > 0$ 时，纤维划分不再精确一致，但在 $\delta$-邻域内近似一致（§7.1 的 $\varepsilon$-纤维意义下）。

#### 链结构提供的自然局部化

在链 $Q_+ \circ \psi \circ Q_-$ 中（$Q_+$ 为下游子链，$Q_-$ 为上游子链），将 $\psi$ 替换为 $\phi_k \circ \cdots \circ \phi_1$ 时，由命题 8.3（右复合收缩），替换的有效偏差取决于 $\psi$ 与 $\phi_k \circ \cdots \circ \phi_1$ 在 $\mathrm{Im}(Q_-)$ 上的差异：

$$\delta_\mathrm{eff} \;=\; d_\Omega(\psi,\; \phi_k \circ \cdots \circ \phi_1)\big|_{\mathrm{Im}(Q_-)}$$

链的上游子链 $Q_-$ **自动**提供了 $S = \mathrm{Im}(Q_-)$——无须额外指定局部化区域。

**命题 8.5（局部分解的端到端偏差）**：在链 $Q_+ \circ \psi \circ Q_-$ 中，将 $\psi$ 替换为 $\phi_k \circ \cdots \circ \phi_1$，产生的端到端偏差满足：

$$d_\Omega(Q_+ \circ \psi \circ Q_-,\; Q_+ \circ (\phi_k \circ \cdots \circ \phi_1) \circ Q_-) \;\leq\; L_{Q_+} \cdot \delta_\mathrm{eff}$$

**证明**：由命题 8.1（左复合 Lip），$\leq L_{Q_+} \cdot d_\Omega(\psi \circ Q_-, (\phi_k \circ \cdots \circ \phi_1) \circ Q_-)$。由命题 8.3（右复合收缩），$d_\Omega(\psi \circ Q_-, (\phi_k \circ \cdots \circ \phi_1) \circ Q_-) = d_\Omega(\psi, \phi_k \circ \cdots \circ \phi_1)|_{\mathrm{Im}(Q_-)} = \delta_\mathrm{eff}$。$\square$

> **注（基底扩展改变有效可分解性）**：取 $Q_- = \varphi$（§6 的预变换）。某个 $\psi$ 可能全局不可分解（$\delta$ 很大），但在 $\mathrm{Im}(\varphi)$ 上有效可分解（$\delta_\mathrm{eff} \ll \delta$）。基底扩展不仅改变 Lip 常数（§6 定理 6.1），还可能改变系统的**有效可分解结构**——某些全局不可分解的算子在预处理后的像集上变得可分解。

---

### 8.3 链内分解与替换

#### 子链替换

$\delta$-可分解性的直接应用：当 f-chain 中的连续子链可被另一算子近似替代时，产生一条**替换链**。

**定义（$\delta_0$-替换）**：设 $\phi$-链 $\phi_k \circ \cdots \circ \phi_1$（$\phi_i \in \Omega$），$\chi \in \Omega$，$1 \leq a \leq b \leq k$（$b - a \geq 1$），$S \subseteq \mathcal{X}$。若 $\chi$ 在 $S$ 上以偏差 $\leq \delta_0$ $(\phi_a, \ldots, \phi_b)$-可分解，则称 $\chi$ 为子链 $\phi_b \circ \cdots \circ \phi_a$ 在 $S$ 上的 **$\delta_0$-替换**。替换后得到新链：

$$\phi_k \circ \cdots \circ \phi_{b+1} \circ \chi \circ \phi_{a-1} \circ \cdots \circ \phi_1$$

**命题 8.6（替换的偏差传播）**：设 $\chi$ 为子链 $\phi_{a:b}$ 在 $S$ 上的 $\delta_0$-替换。令 $\Psi = \phi_{a-1} \circ \cdots \circ \phi_1$（上游子链）。则替换链 $\phi_{1:k}'$ 的端到端偏差满足：

$$d_\Omega(|\phi_{1:k}'|,\; |\phi_{1:k}|)\big|_S \;\leq\; \prod_{j=b+1}^{k} L_{\phi_j} \;\cdot\; d_\Omega(\chi,\; \phi_b \circ \cdots \circ \phi_a)\big|_{\Psi(S)}$$

即替换引入的偏差在 $\Psi(S) \subseteq \mathrm{Im}(\Psi)$ 上评估（右复合限制），再被下游算子的广义 Lip 常数逐级放大（左复合放大）。

**证明**：对左因子 $\phi_k \circ \cdots \circ \phi_{b+1}$ 逐步应用命题 8.1，得放大因子 $\prod_{j=b+1}^k L_{\phi_j}$。内层差异 $d_\Omega(\chi \circ \Psi, \phi_{a:b} \circ \Psi)|_S$：对 $x \in S$，令 $y = \Psi(x) \in \Psi(S)$，由命题 8.3 知 sup 限制到 $\Psi(S)$。$\square$

> **注（多步替换）**：对同一条链执行多次不重叠的替换时，各替换引入的偏差分别经不同的下游路径放大后在输出端叠加。

> **注（IDFS 中的路由等效性）**：在 IDFS 框架中（$\phi_i \in F$，$\chi \in F$），替换后的总传播偏差不超过拟合容差 $\varepsilon$ 时，替换链为 $\sigma$ 的**可用等效路径**。不同等效链可能具有截然不同的纤维结构，$\sigma$ 将 $\mathcal{X}(r_j)$ 的不同区域分配到不同等效链时，同一 $r_j$ 的拟合质量在 $\mathrm{dom}(r_j)$ 上一般不均匀。

> **注（路由混叠与子链替换的区别）**：子链替换与路由混叠（§2 定义，§3 推论 3.2）是两种不同机制：**路由混叠**由组合耗尽驱动——不同输入的微观路由重合，产生确定性泛化；**子链替换**由 $F$ 的代数冗余驱动——同一目标可由多条 f-chain 拟合不同子区域。前者是计算程序层面的简并，后者是拟合路径层面的多重覆盖。

> **注（纤维解释）**：子链 $\delta_0$-替换是定理 7.10（纤维深度极限）的极端特例：子链的纤维结构被**预编译**为单步 $\chi$ 的纤维结构——中间步骤不消耗额外的分辨率预算。

#### 扰动的上下游分解

**命题 8.7（扰动的上下游分解）**：在链 $q = \phi_k \circ \cdots \circ \phi_1$ 中，将 $\phi_m$ 替换为 $\phi_m'$，得到 $q'$。令 $\Psi = \phi_{m-1} \circ \cdots \circ \phi_1$。则：

$$d_\Omega(q, q') \;\leq\; \underbrace{\prod_{j=m+1}^{k} L_{\phi_j}}_{\text{下游 Lip 放大}} \;\cdot\; \underbrace{d_\Omega(\phi_m, \phi_m')\big|_{\mathrm{Im}(\Psi)}}_{\text{$\mathrm{Im}(\Psi)$ 上的有效扰动}}$$

**证明**：对左因子逐步应用命题 8.1，得 $\prod L_{\phi_j}$。内层由命题 8.3 限制到 $\mathrm{Im}(\Psi)$。$\square$

> **注（位置依赖的扰动灵敏度）**：扰动位置 $m$ 的两个竞争效应：
> - **链前端**（$m$ 小）：下游 Lip 乘积大，但 $\mathrm{Im}(\Psi)$ 接近全空间。
> - **链后端**（$m$ 大）：下游 Lip 乘积小，但 $\mathrm{Im}(\Psi)$ 可能远小于 $\mathcal{X}$。
>
> 最脆弱的位置取决于两个效应的具体平衡，不能一般性地断言。

#### 上游压缩促进吸收

将命题 8.7 与命题 8.2 的纤维吸收结合：

**命题 8.8（像集限制下的吸收条件）**：沿用命题 8.7 的记号。若：

$$d_\Omega(\phi_m, \phi_m')\big|_{\mathrm{Im}(\Psi)} \;\leq\; \underline{\alpha}_{\phi_{m+1}}^\varepsilon$$

则步 $m$ 的扰动在步 $m+1$ 被 $\varepsilon$-吸收：

$$d_\Omega(\phi_{m+1} \circ \phi_m \circ \Psi,\; \phi_{m+1} \circ \phi_m' \circ \Psi) \;\leq\; \varepsilon$$

**证明**：对每个 $x$，令 $y = \Psi(x) \in \mathrm{Im}(\Psi)$。由条件，$d(\phi_m(y), \phi_m'(y)) \leq \underline{\alpha}_{\phi_{m+1}}^\varepsilon$，即 $\phi_m'(y)$ 落在 $\phi_{m+1}$ 的 $\varepsilon$-纤维内。由 $\varepsilon$-纤维的定义，$d(\phi_{m+1}(\phi_m(y)), \phi_{m+1}(\phi_m'(y))) \leq \varepsilon$。取 $\sup$ 即得。$\square$

> **注（与命题 8.2 的对比）**：命题 8.2 要求 $d_\Omega(\phi_m, \phi_m') \leq \underline{\alpha}_{\phi_{m+1}}^\varepsilon$——全空间上的 sup。命题 8.8 仅要求 $\mathrm{Im}(\Psi)$ 上的 sup。当上游子链 $\Psi$ 具有厚纤维时，$\mathrm{Im}(\Psi)$ 是 $\mathcal{X}$ 的"窄"子集，吸收条件**显著更容易满足**。
>
> **物理含义**：上游的信息压缩与下游的纤维吸收是**协同的**——越深入链的中段，上游已充分压缩信息，中游的扰动越容易被下游吸收。这种协同效应是逐点纤维分析（§7）无法捕捉的，需要算子代数的全局视角。

#### 可分解性的度量关系

**命题 8.9（可分解性的度量关系，Metric Relations of Factorizability）**：设 $\psi$ 在 $S$ 上以偏差 $\delta \geq 0$ $(\phi_1, \phi_2)$-可分解，且满足**纤维保持条件** $\underline{\alpha}_\psi^\varepsilon \geq \min(\underline{\alpha}_{\phi_1}^\varepsilon, \underline{\alpha}_{\phi_2}^\varepsilon)$（§7.1）。则对任意 $\rho \in \Omega$：

**(i) 拟合等价性**：

$$\bigl|d_\Omega(\psi, \rho)\big|_S - d_\Omega(\phi_2 \circ \phi_1, \rho)\big|_S\bigr| \;\leq\; \delta$$

**证明**：由 $\delta$-可分解性，$d_\Omega(\psi, \phi_2 \circ \phi_1)|_S \leq \delta$。三角不等式取差即得。$\square$

**(ii) 吸收半径不退化**：

$$\underline{\alpha}_\psi^\varepsilon \;\geq\; \underline{\alpha}_{\phi_2 \circ \phi_1}^\varepsilon$$

**证明**：对复合链 $\phi_2 \circ \phi_1$，吸收半径受瓶颈约束：$\underline{\alpha}_{\phi_2 \circ \phi_1}^\varepsilon \leq \min(\underline{\alpha}_{\phi_1}^\varepsilon, \underline{\alpha}_{\phi_2}^\varepsilon)$。由纤维保持条件即得。$\square$

> **注（纤维保持条件的限制）**：纤维保持条件 $\underline{\alpha}_\psi^\varepsilon \geq \min(\underline{\alpha}_{\phi_1}^\varepsilon, \underline{\alpha}_{\phi_2}^\varepsilon)$ 要求宏算子的纤维至少与其组成部分的瓶颈一样厚——这是关于宏算子**内部结构**的非平凡假设，不能从可分解性本身推出。

> **注（OOD 差异的一种可能解释）**：同一目标可由多条纤维结构不同的等效链拟合。不同系统的 $\sigma$ 选择了纤维结构（吸收半径、横截灵敏度、膨胀量）不同的链，采样集内无差别，但采样集外的表现可能因此而异。具体影响取决于纤维几何与输入分布的匹配，不能一般性地断言。

#### 压缩-放大不等式

**命题 8.10（压缩-放大不等式）**：设 $\psi = \phi_2 \circ \phi_1$（精确分解）。则：

$$\mathrm{CD}_\varepsilon(\psi) \;\leq\; \mathrm{CD}_{\varepsilon/L_{\phi_2}}(\mathrm{Im}(\phi_1))$$

即 $\psi$ 的输出多样性不超过 $\phi_1$ 的像集在尺度 $\varepsilon/L_{\phi_2}$ 下的度量熵。

**证明**：$\phi_2$ 是 $L_{\phi_2}$-Lip，将 $\mathrm{Im}(\phi_1)$ 的 $(\varepsilon/L_{\phi_2})$-球映到 $\varepsilon$-球。$\mathrm{Im}(\phi_1)$ 的 $(\varepsilon/L_{\phi_2})$-覆盖诱导 $\mathrm{Im}(\psi) = \phi_2(\mathrm{Im}(\phi_1))$ 的 $\varepsilon$-覆盖，故 $\mathcal{N}(\varepsilon, \mathrm{Im}(\psi)) \leq \mathcal{N}(\varepsilon/L_{\phi_2}, \mathrm{Im}(\phi_1))$。$\square$

> **注（分解的三约束）**：命题 7.2（§7.3）和 8.10 联合揭示了分解 $\psi \approx \phi_2 \circ \phi_1$ 中三个目标的互相制衡：
>
> 1. **$\phi_1$ 压缩**促进 $\phi_2$ 的受限吸收（命题 8.8），但降低 $\mathrm{CD}(\mathrm{Im}(\phi_1))$；
> 2. **$\phi_2$ 吸收好**控制误差传播，但由命题 7.2（§7.3），$\mathrm{FI}(\phi_2)$ 大，进一步损失多样性；
> 3. 端到端**分辨率**要求 $\mathrm{CD}_\varepsilon(\psi) \geq \mathrm{CD}_\varepsilon(\rho)$（拟合需要），迫使 $L_{\phi_2}$ 足够大以在更精细的尺度上恢复目标复杂度（命题 8.10）——但 $L_{\phi_2}$ 大则放大误差（命题 8.1）。

---

### 8.4 基底同构的微观解读

§6 建立了基底同构定理：对输入施加预变换 $\varphi$（$\mathrm{Lip}(\varphi) = K$）等价于基底扩展，宏观代价为 Lip 乘积 $L \cdot K$。本节用 §8.1 的左右不对称性给出微观层面的精细图景——$K$ 这个标量代价在微观层面分解为**左复合放大**与**右复合信息限制**的对偶结构。

#### φ 作为全局右因子

$\varphi$-扩展后，每条 f-chain $q = \phi_k \circ \cdots \circ \phi_1$ 变为 $q \circ \varphi$。

**命题 8.11（预变换的可区分性衰减）**：对任意 $q_1, q_2 \in \Omega$：

$$d_\Omega(q_1 \circ \varphi,\; q_2 \circ \varphi) \;=\; d_\Omega(q_1, q_2)\big|_{\mathrm{Im}(\varphi)} \;\leq\; d_\Omega(q_1, q_2)$$

即预变换 $\varphi$ 使**所有链的可区分性均匀衰减**——不同链只在 $\mathrm{Im}(\varphi)$ 上被比较。

**证明**：命题 8.3 的直接应用（$\psi = \varphi$）。$\square$

> **注（宏观 Lip 代价的微观对偶）**：§6 的宏观视角看到的是 Lip 放大（$L \cdot K$，左复合效应）。命题 8.11 揭示了同一操作的另一面：$\varphi$ 同时**限制了信息**（右复合效应），将所有链的比较域从 $\mathcal{X}$ 缩到 $\mathrm{Im}(\varphi)$。Lip 代价不是纯粹的"代价"，而是**放大与限制的对偶**。

#### 压缩型预变换促进吸收

**命题 8.12（预变换的吸收促进）**：设 $\varphi$-扩展后的链为 $q \circ \varphi = \phi_k \circ \cdots \circ \phi_1 \circ \varphi$。若：

$$d_\Omega(\phi_1, \phi_1')\big|_{\mathrm{Im}(\varphi)} \;\leq\; \underline{\alpha}_{\phi_2}^\varepsilon$$

则链首步的扰动 $\phi_1 \to \phi_1'$ 在第二步被 $\varepsilon$-吸收。

**证明**：命题 8.8 的直接应用（$\Psi = \varphi$）。$\square$

> **注（压缩与鲁棒性）**：当 $\mathrm{Im}(\varphi) \subsetneq \mathcal{X}$ 时，两个基函数 $\phi_1, \phi_1'$ 可能在全空间上差异很大，但在 $\mathrm{Im}(\varphi)$ 上几乎一致——此时链的第一步扰动被第二步完全吸收。压缩型预处理的微观效应是：损失信息的同时，让后续链步对首步变化更鲁棒。

> **注（误差再分配的纤维解释）**：§6 命题 6.7 证明了误差在空间上的再分配（改善集与恶化集同时非空）。从纤维视角：$\varphi$ 将输入重映射到链的不同纤维区域。改善发生在 $\varphi(x)$ 落入链的**厚纤维区域**（吸收半径大）的点；恶化发生在 $\varphi(x)$ 落入**薄纤维区域**的点。误差再分配的本质是**输入与纤维几何的匹配度重洗**。

----
*[IDFS] ⊢ [GLENZLI] ⊢ [Part 03] ⊢ [08-operator-algebra] ⊢ [c0ab17afc08c28b1]*
