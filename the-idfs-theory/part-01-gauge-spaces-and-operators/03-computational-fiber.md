## 计算纤维

### 3.1 算子的计算纤维

设 $\phi \in \Omega$，$d_i \in \mathcal{G}$ 为分量伪度量。算子 $\phi$ 将输入空间中的若干不同点映射为 $d_i$ 下不可区分的输出——这种多对一坍缩在每个分量伪度量上诱导出一组等价类，即**计算纤维**。纤维是算子固有的离散拓扑结构，与 §1.5 定义的 Lip 矩阵所刻画的连续放缩行为形成对偶：Lip 矩阵约束算子间距离在复合下的**传播上界**，纤维结构刻画算子将输入差异**精确坍缩为零**的等价类划分及其拓扑后果。

纤维在 §2.1 分量分划的各类型上表现不同：在恒等分量 $I_{\mathrm{id}}$ 和常值分量 $I_{\mathrm{const}}$ 上退化为平凡结构（见下注），其非平凡内容集中在活跃分量 $I_{\mathrm{act}}$ 上。

#### 定义（计算纤维，Computational Fiber）

设 $\phi \in \Omega$，$y \in \mathrm{Im}(\phi)$，$d_i \in \mathcal{G}$。定义 $y$ 在 $\phi$ 下关于 $d_i$ 的**计算纤维**：

$$\mathfrak{F}_{\phi, d_i}(y) \;\triangleq\; \bigl\{x \in \mathrm{dom}(\phi) \;\big|\; d_i(\phi(x), y) = 0\bigr\}$$

即所有在 $d_i$ 下与 $y$ 产生不可区分输出的输入点的集合。

$\{\mathfrak{F}_{\phi, d_i}(y)\}_{y \in \mathrm{Im}(\phi)}$ 构成 $\mathrm{dom}(\phi)$ 的一个覆盖。当 $d_i$ 满足分离规范（§1.1）时，纤维族构成严格划分；当 $d_i$ 不满足分离规范时，满足 $d_i(y, y') = 0$ 的不同 $y, y' \in \mathrm{Im}(\phi)$ 的纤维必然相同（由三角不等式：$d_i(\phi(x), y) = 0 \iff d_i(\phi(x), y') = 0$）。

#### 定义（全纤维，Full Fiber）

设 $\phi \in \Omega$，$y \in \mathrm{Im}(\phi)$。定义 $y$ 在 $\phi$ 下关于**全体规范结构** $\mathcal{G}$ 的**全纤维**：

$$\mathfrak{F}_{\phi, \mathcal{G}}(y) \;\triangleq\; \bigcap_{i \in I} \mathfrak{F}_{\phi, d_i}(y) \;=\; \bigl\{x \in \mathrm{dom}(\phi) \;\big|\; \forall i \in I,\; d_i(\phi(x), y) = 0\bigr\}$$

全纤维是所有分量纤维的交集。$\mathfrak{F}_{\phi, \mathcal{G}}(y) \subseteq \mathfrak{F}_{\phi, d_i}(y)$ 对所有 $i \in I$ 成立。当规范 $\mathcal{G}$ 满足族分离性时，$\mathfrak{F}_{\phi, \mathcal{G}}(y)$ 退化为集合论原像 $\phi^{-1}(y)$。

> **注（分量纤维与全纤维的层级）**：分量纤维 $\mathfrak{F}_{\phi, d_i}(y)$ 刻画算子在**单个分量**上的坍缩——输入差异仅在 $d_i$ 下被消灭，可能在其他分量上依然可区分。全纤维 $\mathfrak{F}_{\phi, \mathcal{G}}(y)$ 刻画算子在**全部分量**上的坍缩——输入差异在所有伪度量下均被消灭。后续的吸收与冲突分析以分量纤维为基本单元，全纤维在需要跨分量统一分析时出现。

> **注（纤维与分量分划的关系）**：当 $i \in I_{\mathrm{id}}(\phi)$ 时，$\mathfrak{F}_{\phi, d_i}(y) = \{x : d_i(x, y) = 0\}$——纤维退化为 $y$ 在 $d_i$ 下的等价类，不携带关于 $\phi$ 的信息。当 $i \in I_{\mathrm{const}}(\phi)$ 时，$\mathfrak{F}_{\phi, d_i}(y) = \mathrm{dom}(\phi)$ 对所有 $y \in \mathrm{Im}(\phi)$——纤维退化为全域。纤维理论的非平凡内容集中在 $i \in I_{\mathrm{act}}(\phi)$ 上。

### 3.2 吸收半径

纤维的厚度由**吸收半径**刻画——以某点为中心，能完全包含在其对应纤维内的最大球半径。

#### 定义（吸收半径，Absorption Radius）

设 $\phi \in \Omega$，$y \in \mathrm{dom}(\phi)$。指定输入端分量伪度量 $d_i$ 与输出端分量伪度量 $d_j$（$d_i, d_j \in \mathcal{G}$）。定义 $\phi$ 在 $y$ 处关于 $(d_i, d_j)$ 的**吸收半径**：

$$\alpha_{\phi, d_i, d_j}(y) \;\triangleq\; \sup\bigl\{r \geq 0 \;\big|\; B_{d_i}(y, r) \subseteq \mathfrak{F}_{\phi, d_j}(\phi(y))\bigr\}$$

即以 $y$ 为中心，在 $d_i$ 下能完全包含在 $\phi(y)$ 的 $d_j$-纤维内的最大球半径。定义**最小吸收半径**：

$$\underline{\alpha}_{\phi, d_i, d_j} \;\triangleq\; \inf_{y \in \mathrm{dom}(\phi)} \alpha_{\phi, d_i, d_j}(y)$$

$\alpha_{\phi, d_i, d_j}(y)$ 度量纤维在 $y$ 处的**局部厚度**：在此 $d_i$-半径内的输入扰动不改变输出在 $d_j$ 下的等价类。当 $\phi$ 在 $d_j$ 上为单射且 $d_i$ 为分离伪度量时，$\alpha_{\phi, d_i, d_j}(y) = 0$（纤维退化为单点集）。

> **注（吸收半径与 Lip 矩阵的对偶性）**：Lip 矩阵条目 $L_{i \to j}$ 刻画输入 $d_i$-差异向输出 $d_j$-差异的**放大上界**，吸收半径 $\alpha_{\phi, d_i, d_j}$ 刻画输入 $d_i$-扰动被输出 $d_j$-等价类**吸收的下界**。二者分别从上方和下方约束同一算子在分量对 $(d_i, d_j)$ 上的灵敏度。

### 3.3 标量 Lip 常数

#### 约定（标量 Lip 常数与 Lip 矩阵的关系）

对固定的分量对 $(d_i, d_j) \in \mathcal{G}^2$，定义算子 $\phi$ 在该分量对上的**标量 Lip 常数**：

$$L_{\phi, d_i \to d_j} \;\triangleq\; \inf\bigl\{L_{i \to j} \;:\; \exists\, \mathbf{L} \in \mathscr{L}(\phi),\; L_{i \to j} \text{ 为 } \mathbf{L} \text{ 的 } (i, j) \text{ 条目}\bigr\}$$

即 $\phi$ 的全体合法 Lip 矩阵在 $(i, j)$ 条目上的下确界。$L_{\phi, d_i \to d_j} \in \bar{\mathbb{R}}_+$。纤维内部 $\phi$ 在 $d_j$ 下的输出不可区分（$d_j$-Lip $= 0$），标量 Lip 常数仅反映跨纤维的输出变化率。

### 3.4 计算多样性与纤维膨胀

算子 $\phi$ 的输入复杂度由 $\mathrm{dom}(\phi)$ 的度量熵（§1.2）衡量，而 $\phi$ 实际产生的不同计算结果由 $\mathrm{Im}(\phi)$ 的度量熵衡量。两者之差即纤维结构所吸纳的冗余。

#### 定义（计算多样性，Computational Diversity）

对 $\phi \in \Omega$、分量伪度量 $d_j \in \mathcal{G}$ 及精度 $\varepsilon > 0$：

$$\mathrm{CD}_{\varepsilon, d_j}(\phi) \;\triangleq\; \log \mathcal{N}_{d_j}\bigl(\varepsilon,\, \mathrm{Im}(\phi)\bigr)$$

#### 定义（纤维膨胀量，Fiber Inflation）

指定输入端分量伪度量 $d_i$、输出端分量伪度量 $d_j$ 及精度 $\varepsilon > 0$：

$$\mathrm{FI}_{\varepsilon, d_i, d_j}(\phi) \;\triangleq\; I_{\varepsilon, d_i}\bigl(\mathrm{dom}(\phi)\bigr) - I_{\varepsilon, d_j}\bigl(\mathrm{Im}(\phi)\bigr)$$

其中 $I_{\varepsilon, d}$ 为 §1.2 定义的度量熵。取 $d_i = d_j = d$ 时简记 $\mathrm{FI}_{\varepsilon, d}(\phi)$。

> **注（精度 $\varepsilon$ 的角色）**：计算多样性和纤维膨胀依赖精度参数 $\varepsilon$，因为度量熵本身是 $\varepsilon$-依赖的。但此处的 $\varepsilon$ 是度量熵的量化参数，并非纤维定义中的模糊化——纤维本身始终是精确的（$d_j = 0$）。

#### 定义（纤维余维，Fiber Codimension）

$$\mathrm{codim}_{\varepsilon, d_i, d_j}(\phi) \;\triangleq\; \frac{\mathrm{FI}_{\varepsilon, d_i, d_j}(\phi)}{\log(1/\varepsilon)}$$

度量 $\phi$ 在 $\varepsilon$-尺度上从 $d_i$ 到 $d_j$ 有效坍缩的度量维数。

**命题 3.1（Lipschitz 映射的纤维膨胀下界）**：设 $L_{\phi, d_i \to d_j} < \infty$。则：

$$\mathrm{FI}_{\varepsilon, d_i, d_j}(\phi) \;\geq\; I_{\varepsilon, d_i}\bigl(\mathrm{dom}(\phi)\bigr) - I_{\varepsilon / L_{\phi, d_i \to d_j},\, d_i}\bigl(\mathrm{dom}(\phi)\bigr)$$

**证明**：$\phi$ 将 $\mathrm{dom}(\phi)$ 中的 $(\varepsilon/L)$-$d_i$ 球映射到 $\varepsilon$-$d_j$ 球内（由标量 Lip 常数定义）。故 $\mathcal{N}_{d_j}(\varepsilon, \mathrm{Im}(\phi)) \leq \mathcal{N}_{d_i}(\varepsilon/L, \mathrm{dom}(\phi))$。取对数代入即得。$\square$

**命题 3.2（分辨率-吸收界）**：设 $\underline{\alpha}_{\phi, d_i, d_j} = \alpha > 0$。则：

$$\mathrm{CD}_{\varepsilon, d_j}(\phi) \;\leq\; I_{\alpha, d_i}\bigl(\mathrm{dom}(\phi)\bigr)$$

**证明**：取 $\mathrm{dom}(\phi)$ 在 $d_i$ 下的 $\alpha$-覆盖 $\{c_1, \ldots, c_M\}$（$M = \mathcal{N}_{d_i}(\alpha, \mathrm{dom}(\phi))$）。由吸收半径定义，$B_{d_i}(c_m, \alpha) \subseteq \mathfrak{F}_{\phi, d_j}(\phi(c_m))$，故 $\phi$ 的全部输出可被 $\{\phi(c_1), \ldots, \phi(c_M)\}$ 在 $d_j$ 下 $\varepsilon$-覆盖（因纤维内输出 $d_j$-不可区分）。$\square$

### 3.5 纤维吸收

在算子链中，前一步的输出偏差可能被后一步的纤维结构吸收——若偏差不足以使输出点跨越纤维边界，后一步在该分量上的输出差异**精确归零**。

#### 基本纤维吸收

**定理 3.3（纤维吸收定理）**：设 $\phi_2 \circ \phi_1 \in \Omega$ 为两步复合。设 $\phi_1$ 在 $x$ 处的输出为 $\hat{y} = \phi_1(x)$，$y \in \mathrm{dom}(\phi_2)$ 为某参考点，偏差 $\delta = d_i(\hat{y}, y)$。

若 $\hat{y} \in \mathfrak{F}_{\phi_2, d_j}(\phi_2(y))$——即 $\hat{y}$ 与 $y$ 落入 $\phi_2$ 关于 $d_j$ 的同一根纤维——则：

$$d_j\bigl(\phi_2(\hat{y}),\, \phi_2(y)\bigr) = 0$$

前步偏差 $\delta$ 在分量 $d_j$ 上被**精确吸收**，不向后续传播。

**证明**：$\hat{y} \in \mathfrak{F}_{\phi_2, d_j}(\phi_2(y))$ 意味着 $d_j(\phi_2(\hat{y}), \phi_2(y)) = 0$（由纤维定义直接得出）。$\square$

> **注（吸收条件与吸收半径的关系）**：当 $\delta \leq \alpha_{\phi_2, d_i, d_j}(y)$ 时，$\hat{y} \in B_{d_i}(y, \delta) \subseteq \mathfrak{F}_{\phi_2, d_j}(\phi_2(y))$，吸收定理的前提自动满足。吸收半径给出了吸收发生的**充分条件**。

#### 算子链中的逐步纤维吸收

在算子链 $c_\phi = \phi_k \circ \cdots \circ \phi_1$ 中，设 $h_m$ 为第 $m$ 步的实际中间态，$h_m^*$ 为参考中间态，偏差 $\delta_m = d_j(h_m, h_m^*)$（$d_j \in \mathcal{G}$ 为指定的输出端分量伪度量）。

**命题 3.4（算子链逐步吸收）**：在链的第 $m+1$ 步，偏差在分量 $d_j$ 上的传播满足：

$$\delta_{m+1} = \begin{cases} 0 & \text{若 } \delta_m \leq \alpha_{\phi_{m+1}, d_j, d_j}(h_m^*) \quad \text{（纤维吸收）} \\ \leq\, L_{\phi_{m+1}, d_j \to d_j} \cdot \delta_m & \text{否则} \quad \text{（Lip 放大）} \end{cases}$$

算子链的端到端偏差不是标量 Lip 常数乘积 $\prod_{m=1}^{k} L_{\phi_m}$ 的简单累积。在纤维吸收发生的步骤，有效放大率降至零，实际偏差路径可远小于最坏情况的 Lip 乘积。

> **注（与 CH2 矩阵放缩的关系）**：命题 3.4 的 Lip 分支是 CH2 矩阵放缩理论的单分量特化形式。多分量耦合放缩的完整分析见 §2.3。纤维吸收分支则是本章独有的：Lip 矩阵的连续放缩理论无法捕捉 $\delta \to 0$ 的阶跃式归零。

#### 链级纤维膨胀的可加性

**命题 3.5（链级纤维膨胀的可加性）**：设 $\psi = \phi_2 \circ \phi_1$，取 $d_i = d_j = d \in \mathcal{G}$。若 $\mathrm{Im}(\phi_1) \subseteq \mathrm{dom}(\phi_2)$（即复合定义域无损耗），则：

$$\mathrm{FI}_{\varepsilon, d}(\psi) \;=\; \mathrm{FI}_{\varepsilon, d}(\phi_1) \;+\; \mathrm{FI}_{\varepsilon, d}(\phi_2\big|_{\mathrm{Im}(\phi_1)})$$

**证明**：由假设 $\mathrm{dom}(\psi) = \mathrm{dom}(\phi_1)$，$\mathrm{Im}(\psi) = \phi_2(\mathrm{Im}(\phi_1))$。加减中间项 $I_{\varepsilon, d}(\mathrm{Im}(\phi_1))$ 即得。$\square$

**推论 3.6（$k$-步链的纤维膨胀与余维可加）**：设 $c_\phi = \phi_k \circ \cdots \circ \phi_1$，若逐步满足 $\mathrm{Im}(\phi_{m-1} \circ \cdots \circ \phi_1) \subseteq \mathrm{dom}(\phi_m)$（$2 \leq m \leq k$），则：

$$\mathrm{FI}_{\varepsilon, d}(c_\phi) \;=\; \sum_{m=1}^{k} \mathrm{FI}_{\varepsilon, d}(\phi_m\big|_{\mathrm{Im}(\phi_{m-1} \circ \cdots \circ \phi_1)})$$

每步复合贡献一项纤维膨胀。总坍缩维数等于逐步坍缩维数之和——链越长，累积纤维坍缩越深。

### 3.6 纤维冲突

当一个算子将两个输入坍缩至同一纤维，而另一个算子要求区分这两个输入时，产生**纤维冲突**。

#### 定义（纤维冲突，Fiber Conflict）

设 $\phi, \psi \in \Omega$，$\tau > 0$，$d_j \in \mathcal{G}$。若存在 $x', x'' \in \mathrm{dom}(\phi) \cap \mathrm{dom}(\psi)$ 使得：

$$d_j(\phi(x'), \phi(x'')) = 0 \quad \text{但} \quad d_j(\psi(x'), \psi(x'')) > 2\tau$$

则称 $\phi$ 与 $\psi$ 在点对 $(x', x'')$ 上关于 $(d_j, \tau)$ 发生**纤维冲突**——$\phi$ 将 $x', x''$ 坍缩至同一 $d_j$-纤维，而 $\psi$ 要求它们在 $d_j$ 下保持超过 $2\tau$ 的距离。

> **注（精确纤维冲突的拓扑不变性）**：纤维冲突的条件 $d_j(\phi(x'), \phi(x'')) = 0$ 是等价类结构的性质，不随连续扰动而消失。这使得纤维冲突产生的逼近下界是**结构性的**，而非仅仅是度量估计。

**命题 3.7（纤维冲突的不可逼近性）**：设算子链 $\hat{\psi} = \phi_k \circ \cdots \circ \phi_1$ 尝试逼近目标 $\psi$。若在第 $m$ 步发生与 $\psi$ 的纤维冲突，即存在 $x', x'' \in \mathrm{dom}(\hat{\psi}) \cap \mathrm{dom}(\psi)$ 使得 $d_j(\phi_m(h'_{m-1}), \phi_m(h''_{m-1})) = 0$（其中 $h'_{m-1}, h''_{m-1}$ 为 $x', x''$ 经前 $m-1$ 步的中间态），则：

$$\max\bigl\{d_j(\hat{\psi}(x'), \psi(x')),\; d_j(\hat{\psi}(x''), \psi(x''))\bigr\} \;\geq\; \frac{d_j(\psi(x'), \psi(x''))}{2}$$

**证明**：$d_j(\phi_m(h'_{m-1}), \phi_m(h''_{m-1})) = 0$ 蕴含 $d_j(\hat{\psi}_{\mathrm{tail}}(\phi_m(h'_{m-1})), \hat{\psi}_{\mathrm{tail}}(\phi_m(h''_{m-1}))) = 0$（其中 $\hat{\psi}_{\mathrm{tail}} = \phi_k \circ \cdots \circ \phi_{m+1}$；由 Lip 不等式 $L \cdot 0 = 0$，遵循 §1.1 $\bar{\mathbb{R}}_+$ 约定），即 $d_j(\hat{\psi}(x'), \hat{\psi}(x'')) = 0$。由三角不等式：
$$d_j(\psi(x'), \psi(x'')) \leq d_j(\hat{\psi}(x'), \psi(x')) + d_j(\hat{\psi}(x'), \hat{\psi}(x'')) + d_j(\hat{\psi}(x''), \psi(x''))$$
$$= d_j(\hat{\psi}(x'), \psi(x')) + 0 + d_j(\hat{\psi}(x''), \psi(x''))$$
两项中至少一项 $\geq d_j(\psi(x'), \psi(x''))/2$。$\square$

> **注（纤维吸收与纤维冲突的对偶性）**：§3.5 的纤维吸收——偏差落入纤维内被精确消除——是有利的多对一坍缩。纤维冲突——需要区分的信号被坍缩至同一纤维——是不利的多对一坍缩。两者是同一纤维结构的两面：吸收半径同时决定了算子的**鲁棒性**（吸收容限）和**分辨率极限**（冲突阈值）。

----
*[IDFS] ⊢ [GLENZLI] ⊢ [Part 01] ⊢ [03-computational-fiber]*
