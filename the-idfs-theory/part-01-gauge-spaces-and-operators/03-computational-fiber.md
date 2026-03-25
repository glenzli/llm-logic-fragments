## 计算纤维

### 3.1 算子的计算纤维

设 $\phi \in \Omega$，$d_i \in \mathcal{G}$ 为分量伪度量。§2.1 的分量分划确定了 $\phi$ 在 $d_i$ 上的行为类型（恒等/常值/活跃）。本章在**活跃分量**上建立更精细的分析工具——**计算纤维**，刻画算子在特定分量下将哪些输入视为不可区分。

#### 定义（计算纤维，Computational Fiber）

设 $\phi \in \Omega$，$y \in \mathrm{Im}(\phi)$，$d_i \in \mathcal{G}$。定义 $y$ 在 $\phi$ 下关于 $d_i$ 的**计算纤维**：

$$\mathfrak{F}_{\phi, d_i}(y) \;\triangleq\; \bigl\{x \in \mathrm{dom}(\phi) \;\big|\; d_i(\phi(x), y) = 0\bigr\}$$

即所有在 $d_i$ 下与 $y$ 产生不可区分输出的输入点的集合。

$\{\mathfrak{F}_{\phi, d_i}(y)\}_{y \in \mathrm{Im}(\phi)}$ 构成 $\mathrm{dom}(\phi)$ 的一个覆盖（当 $d_i$ 为度量时为划分；当 $d_i$ 为伪度量时，不同 $y, y'$ 满足 $d_i(y, y') = 0$ 的纤维可能重合）。取 $d_i = d$ 时简记 $\mathfrak{F}_\phi(y) \triangleq \mathfrak{F}_{\phi, d}(y)$。


> **注（纤维与分量分划的关系）**：当 $i \in I_{\mathrm{id}}(\phi)$ 时，$\mathfrak{F}_{\phi, d_i}(y) = \{x : d_i(\phi(x), y) = 0\} = \{x : d_i(x, y) = 0\}$——纤维退化为 $y$ 在 $d_i$ 下的等价类，不携带关于 $\phi$ 的信息。当 $i \in I_{\mathrm{const}}(\phi)$ 时，$\mathfrak{F}_{\phi, d_i}(y) = \mathrm{dom}(\phi)$ 对所有 $y \in \mathrm{Im}(\phi)$——纤维退化为全域，同样无信息。纤维理论的非平凡内容集中在 $i \in I_{\mathrm{act}}(\phi)$ 上。

### 3.2 吸收半径

纤维的几何厚度由**吸收半径**刻画——以某点为中心，能完全包含在其对应纤维内的最大球半径。

#### 定义（吸收半径，Absorption Radius）

设 $\phi \in \Omega$，$y \in \mathrm{dom}(\phi)$。指定输入端伪度量 $d_{in}$ 与输出端伪度量 $d_{out}$。定义 $\phi$ 在 $y$ 处关于 $(d_{in}, d_{out})$ 的**吸收半径**：

$$\alpha_{\phi, d_{in}, d_{out}}(y) \;\triangleq\; \sup\bigl\{r \geq 0 \;\big|\; B_{d_{in}}(y, r) \subseteq \mathfrak{F}_{\phi, d_{out}}(\phi(y))\bigr\}$$

即以 $y$ 为中心，在 $d_{in}$ 度量下能完全包含在 $\phi(y)$ 的 $d_{out}$-纤维内的最大球半径。定义**最小吸收半径**：

$$\underline{\alpha}_{\phi, d_{in}, d_{out}} \;\triangleq\; \inf_{y \in \mathrm{dom}(\phi)} \alpha_{\phi, d_{in}, d_{out}}(y)$$

取 $d_{in} = d_{out} = d$ 时简记 $\alpha_\phi(y)$ 和 $\underline{\alpha}_\phi$。

$\alpha_{\phi, d_{in}, d_{out}}(y)$ 度量纤维在 $y$ 处的**局部厚度**：在此 $d_{in}$-半径内的输入扰动不改变输出在 $d_{out}$ 下的等价类。当 $\phi$ 为单射且 $d_{in}, d_{out}$ 均为分离度量时，$\alpha_{\phi, d_{in}, d_{out}}(y) = 0$（无纤维结构）。

> **注（双度量的意义）**：允许 $d_{in} \neq d_{out}$ 刻画了跨分量的鲁棒性——输入在分量 $d_{in}$ 上的扰动是否被输出在分量 $d_{out}$ 上的纤维吸收。这直接与 §1.4 的 Lip 矩阵对偶：Lip 矩阵刻画放大上界，$\alpha_{\phi, d_{in}, d_{out}}$ 刻画吸收下界。


### 3.3 局部横截 Lipschitz 常数

全局广义 Lipschitz 常数 $L_\phi$ 对所有点对一视同仁。纤维结构揭示了更精细的图景：纤维内部 $\phi$ 在 $d_{out}$ 下为常值（$d_{out}$-Lip = 0），$\phi$ 的灵敏度仅体现在**不同纤维之间的最小横截距离**上。

#### 定义（局部横截 Lipschitz 常数，Local Transversal Lipschitz Constant）

设 $\phi \in \Omega$，$y \in \mathrm{Im}(\phi)$，指定伪度量对 $(d_{in}, d_{out})$。定义：

$$L^{\perp}_{\phi, d_{in}, d_{out}}(y) \;\triangleq\; \sup_{\substack{y' \in \mathrm{Im}(\phi) \\ d_{out}(y, y') > 0}} \frac{d_{out}(y, y')}{d_{\perp, d_{in}}\bigl(\mathfrak{F}_{\phi, d_{out}}(y),\, \mathfrak{F}_{\phi, d_{out}}(y')\bigr)} \;\in\; \bar{\mathbb{R}}_+$$

其中 $d_{\perp, d_{in}}(A, B) = \inf_{x \in A,\, x' \in B} d_{in}(x, x')$ 为两集合在 $d_{in}$ 下的最小距离。

$L^{\perp}_{\phi, d_{in}, d_{out}}(y)$ 度量从纤维 $\mathfrak{F}_{\phi, d_{out}}(y)$ 出发，要使输出在 $d_{out}$ 下发生可观测变化，输入在 $d_{in}$ 下**至少**需要跨越的横截距离之比。全局广义 Lip 常数是所有局部横截 Lip 的上确界：

$$L_{\phi, d_{in} \to d_{out}} \;=\; \sup_{y \in \mathrm{Im}(\phi)} L^{\perp}_{\phi, d_{in}, d_{out}}(y)$$

在分析算子链中具体轨线时，当中间态 $y$ 已知，可用局部 $L^{\perp}(y) \leq L_{\phi, d_{in} \to d_{out}}$ 给出更紧的界。

### 3.4 计算多样性与纤维膨胀

算子 $\phi$ 的输入复杂度由 $\mathrm{dom}(\phi)$ 的度量熵衡量，而 $\phi$ 实际执行的不同计算数量由 $\mathrm{Im}(\phi)$ 的度量熵衡量。两者之差即纤维结构所吸纳的冗余。

#### 定义（计算多样性，Computational Diversity）

对 $\phi \in \Omega$、伪度量 $d'$ 及精度 $\varepsilon > 0$：

$$\mathrm{CD}_{\varepsilon, d'}(\phi) \;\triangleq\; \log \mathcal{N}_{d'}\bigl(\varepsilon,\, \mathrm{Im}(\phi)\bigr)$$

#### 定义（纤维膨胀量，Fiber Inflation）

指定输入端伪度量 $d_{in}$、输出端伪度量 $d_{out}$ 及精度 $\varepsilon > 0$：

$$\mathrm{FI}_{\varepsilon, d_{in}, d_{out}}(\phi) \;\triangleq\; \log \mathcal{N}_{d_{in}}\bigl(\varepsilon,\, \mathrm{dom}(\phi)\bigr) - \log \mathcal{N}_{d_{out}}\bigl(\varepsilon,\, \mathrm{Im}(\phi)\bigr)$$

取 $d_{in} = d_{out} = d$ 时简记 $\mathrm{FI}_\varepsilon(\phi)$。当 $\phi$ 为自映射且 $d_{in} = d_{out}$ 时，$\mathrm{FI}_\varepsilon(\phi) \geq 0$。$\mathrm{FI} = 0$ 当且仅当输入与输出在 $\varepsilon$-尺度上具有相同的度量熵。

> **注（精度 $\varepsilon$ 与分量选择的关系）**：计算多样性和纤维膨胀仍然依赖精度参数 $\varepsilon$，因为度量熵本身是 $\varepsilon$-依赖的。但此处的 $\varepsilon$ 是度量熵的量化参数，不再是纤维定义中的模糊化参数——纤维本身已经是精确的。

#### 定义（纤维余维，Fiber Codimension）

$$\mathrm{codim}_{\varepsilon, d_{in}, d_{out}}(\phi) \;\triangleq\; \frac{\mathrm{FI}_{\varepsilon, d_{in}, d_{out}}(\phi)}{\log(1/\varepsilon)}$$

度量 $\phi$ 在 $\varepsilon$-尺度上有效坍缩的度量维数。

**命题 3.1（Lipschitz 映射的纤维膨胀下界）**：设 $L_{\phi, d_{in} \to d_{out}} < \infty$。则：

$$\mathrm{FI}_{\varepsilon, d_{in}, d_{out}}(\phi) \;\geq\; \log \mathcal{N}_{d_{in}}\bigl(\varepsilon,\, \mathrm{dom}(\phi)\bigr) - \log \mathcal{N}_{d_{in}}\bigl(\varepsilon / L_{\phi, d_{in} \to d_{out}},\, \mathrm{dom}(\phi)\bigr)$$

**证明**：$\phi$ 将 $\mathrm{dom}(\phi)$ 中的 $(\varepsilon/L)$-$d_{in}$ 球映射到 $\varepsilon$-$d_{out}$ 球内。故 $\mathcal{N}_{d_{out}}(\varepsilon, \mathrm{Im}(\phi)) \leq \mathcal{N}_{d_{in}}(\varepsilon/L, \mathrm{dom}(\phi))$。$\square$

**命题 3.2（分辨率-吸收界）**：设 $\underline{\alpha}_{\phi, d_{in}, d_{out}} = \alpha > 0$。则：

$$\mathrm{CD}_{\varepsilon, d_{out}}(\phi) \;\leq\; \log \mathcal{N}_{d_{in}}\bigl(\alpha,\; \mathrm{dom}(\phi)\bigr)$$

**证明**：取 $\mathrm{dom}(\phi)$ 在 $d_{in}$ 下的 $\alpha$-覆盖 $\{c_1, \ldots, c_M\}$。由吸收半径定义，$B_{d_{in}}(c_j, \alpha) \subseteq \mathfrak{F}_{\phi, d_{out}}(\phi(c_j))$，故 $\phi$ 的全部输出可被 $\{\phi(c_1), \ldots, \phi(c_M)\}$ 在 $d_{out}$ 下覆盖。$\square$

### 3.5 纤维吸收

在算子链中，前一步的输出偏差可能被后一步的纤维结构**吸收**——若偏差不足以使输出点跨越纤维边界，后一步的计算结果不受影响。

#### 基本纤维吸收

**定理 3.3（纤维吸收定理）**：设 $\phi_2 \circ \phi_1$ 为两步复合。设 $\phi_1$ 在 $x$ 处的理想输出为 $y$，实际输出为 $\hat{y} = \phi_1(x)$，偏差 $\delta = d_{in}^{(2)}(\hat{y}, y)$。

若 $\hat{y} \in \mathfrak{F}_{\phi_2, d_{out}^{(2)}}(\phi_2(y))$——即 $\hat{y}$ 与 $y$ 落入 $\phi_2$ 关于 $d_{out}^{(2)}$ 的同一根纤维——则：

$$d_{out}^{(2)}\bigl(\phi_2(\hat{y}),\, \phi_2(y)\bigr) = 0$$

前步偏差 $\delta$ 被**完全吸收**，不向后续传播。

**证明**：$\hat{y} \in \mathfrak{F}_{\phi_2, d_{out}^{(2)}}(\phi_2(y))$ 意味着 $d_{out}^{(2)}(\phi_2(\hat{y}), \phi_2(y)) = 0$。$\square$

> **注（吸收条件与吸收半径的关系）**：当 $\delta \leq \alpha_{\phi_2, d_{in}^{(2)}, d_{out}^{(2)}}(y)$ 时，$\hat{y} \in B_{d_{in}^{(2)}}(y, \delta) \subseteq \mathfrak{F}_{\phi_2, d_{out}^{(2)}}(\phi_2(y))$，吸收定理的前提自动满足。吸收半径给出了吸收发生的**充分条件**。

#### 算子链中的逐步纤维吸收

在算子链 $c_\phi = \phi_k \circ \cdots \circ \phi_1$ 中，设 $h_m$ 为第 $m$ 步的实际中间态，$h_m^*$ 为理想中间态，偏差 $\delta_m = d^{(m)}(h_m, h_m^*)$。

**命题 3.4（算子链逐步吸收）**：在链的第 $m+1$ 步，偏差的传播满足：

$$\delta_{m+1} = \begin{cases} 0 & \text{若 } \delta_m \leq \alpha_{\phi_{m+1}, d^{(m)}, d^{(m+1)}}(h_m^*) \quad \text{（纤维吸收）} \\ \leq\, L_{\phi_{m+1}, d^{(m)} \to d^{(m+1)}} \cdot \delta_m & \text{否则} \quad \text{（Lip 放大）} \end{cases}$$

算子链的端到端偏差不是全局 Lip 常数乘积 $\prod L_{\phi_m}$ 的简单累积。在纤维吸收发生的步骤，有效放大率降至零，实际偏差路径远小于最坏情况的 Lip 乘积。

#### 链级纤维膨胀的可加性

**命题 3.5（链级纤维膨胀的可加性）**：设 $\psi = \phi_2 \circ \phi_1$，取 $d_{in} = d_{out} = d$。则：

$$\mathrm{FI}_\varepsilon(\psi) \;=\; \mathrm{FI}_\varepsilon(\phi_1) \;+\; \mathrm{FI}_\varepsilon(\phi_2|_{\mathrm{Im}(\phi_1)})$$

**证明**：$\mathrm{dom}(\psi) = \mathrm{dom}(\phi_1)$，$\mathrm{Im}(\psi) = \phi_2(\mathrm{Im}(\phi_1))$。加减中间项 $\log \mathcal{N}_\varepsilon(\mathrm{Im}(\phi_1))$ 即得。$\square$

**推论 3.6（$k$-步链的纤维膨胀与余维可加）**：设 $c_\phi = \phi_k \circ \cdots \circ \phi_1$，则：

$$\mathrm{FI}_\varepsilon(c_\phi) \;=\; \sum_{m=1}^{k} \mathrm{FI}_\varepsilon(\phi_m|_{\mathrm{Im}(\phi_{m-1} \circ \cdots \circ \phi_1)})$$
$$\mathrm{codim}_\varepsilon(c_\phi) \;=\; \sum_{m=1}^{k} \mathrm{codim}_\varepsilon(\phi_m|_{\mathrm{Im}(\phi_{m-1} \circ \cdots \circ \phi_1)})$$

每步复合贡献一项纤维膨胀。总坍缩维数等于逐步坍缩维数之和——链越长，累积纤维坍缩越深。

### 3.6 纤维冲突

当一个算子将两个输入坍缩至同一纤维，而另一个算子要求区分这两个输入时，产生**纤维冲突**。

#### 定义（纤维冲突，Fiber Conflict）

设 $\phi, \psi \in \Omega$，$\tau > 0$，$d_{out} \in \mathcal{G}$。若存在 $x', x'' \in \mathrm{dom}(\phi) \cap \mathrm{dom}(\psi)$ 使得：

$$d_{out}(\phi(x'), \phi(x'')) = 0 \quad \text{但} \quad d_{out}(\psi(x'), \psi(x'')) > 2\tau$$

则称 $\phi$ 与 $\psi$ 在点对 $(x', x'')$ 上关于 $(d_{out}, \tau)$ 发生**纤维冲突**——$\phi$ 将 $x', x''$ 坍缩至同一 $d_{out}$-纤维，而 $\psi$ 要求它们在 $d_{out}$ 下保持超过 $2\tau$ 的距离。

> **注（精确纤维冲突更强）**：相比旧体系的 $\varepsilon$-纤维冲突（$d(\phi(x'), \phi(x'')) \leq \varepsilon$），精确纤维冲突要求 $d_{out}(\phi(x'), \phi(x'')) = 0$——这是更强的条件。但由于 $d_{out}$ 为伪度量，$d_{out} = 0$ 不意味着 $\phi(x') = \phi(x'')$，只意味着它们在该分量下不可区分。

**命题 3.7（纤维冲突的不可逼近性）**：设算子链 $\hat{\psi} = \phi_k \circ \cdots \circ \phi_1$ 尝试逼近目标 $\psi$。若在第 $m$ 步发生与 $\psi$ 的纤维冲突（即 $d_{out}(\phi_m(h'_{m-1}), \phi_m(h''_{m-1})) = 0$），且链的尾部 $\hat{\psi}_{\mathrm{tail}} = \phi_k \circ \cdots \circ \phi_{m+1}$ 的 Lip 常数为 $L_{\mathrm{tail}} \in \bar{\mathbb{R}}_+$，则：

$$\max\bigl\{d(\hat{\psi}(x'), \psi(x')),\; d(\hat{\psi}(x''), \psi(x''))\bigr\} \;\geq\; \frac{d(\psi(x'), \psi(x''))}{2}$$

**证明**：$d_{out}(\phi_m(h'_{m-1}), \phi_m(h''_{m-1})) = 0$ 蕴含 $d_{out}(\hat{\psi}_{\mathrm{tail}}(\phi_m(h'_{m-1})), \hat{\psi}_{\mathrm{tail}}(\phi_m(h''_{m-1}))) = 0$（$L_{\mathrm{tail}} \cdot 0 = 0$），即 $d_{out}(\hat{\psi}(x'), \hat{\psi}(x'')) = 0$。由三角不等式：$d(\psi(x'), \psi(x'')) \leq d(\hat{\psi}(x'), \psi(x')) + d(\hat{\psi}(x'), \hat{\psi}(x'')) + d(\hat{\psi}(x''), \psi(x'')) = d(\hat{\psi}(x'), \psi(x')) + 0 + d(\hat{\psi}(x''), \psi(x''))$。两项中至少一项 $\geq d(\psi(x'), \psi(x''))/2$。$\square$

> **注（纤维吸收与纤维冲突的对偶性）**：§3.5 的纤维吸收——偏差落入纤维内被消除——是有利的多对一坍缩。纤维冲突——需要区分的信号落入同一纤维——是不利的多对一坍缩。两者是同一纤维结构的两面：吸收半径同时决定了算子的**鲁棒性**（吸收容限）和**分辨率极限**（冲突阈值）。

----
*[IDFS] ⊢ [GLENZLI] ⊢ [Part 01] ⊢ [03-computational-fiber] ⊢ [89297bc2d2307757]*
