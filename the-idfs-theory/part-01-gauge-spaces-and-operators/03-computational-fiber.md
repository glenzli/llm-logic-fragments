## 计算纤维

### 3.1 算子的计算纤维

设 $\phi \in \Omega$。算子 $\phi$ 将输入空间中的若干不同点映射为在伪度量下不可区分的输出——这种多对一坍缩诱导出一组等价类，即**计算纤维**。纤维是算子固有的离散拓扑结构，与 §1.5 定义的 Lip 矩阵所刻画的连续放缩行为形成对偶：Lip 矩阵约束算子复合下的**极差传播上界**，而纤维结构刻画算子将输入差异**精确缩减为零**的等价类聚类及其后果。

在多分量规范体系中，算子沿不同分量呈现非对称的坍缩行为，因此纤维的等价类判定天然应建立在任意分量子族之上。

#### 定义（子族复合伪度量，Sub-family Pseudometric）

对任意非空指标集子族 $J \subseteq I$（$J \neq \emptyset$），定义定义域上的复合伪度量：

$$d_J(x, y) \;\triangleq\; \max_{j \in J} d_j(x, y)$$

$d_J$ 保持扩展伪度量的对称性与三角不等式。$d_J(x, y) = 0$ 意味着 $x$ 与 $y$ 在子族 $J$ 的**每一个分量伪度量下皆不可区分**。

#### 定义（计算纤维，Computational Fiber）

设 $\phi \in \Omega$，$y \in \mathrm{Im}(\phi)$。指定非空指标集子族 $J \subseteq I$。定义 $y$ 在 $\phi$ 下关于规范子族 $\mathcal{G}_J$ 的**计算纤维**：

$$\mathfrak{F}_{\phi, J}(y) \;\triangleq\; \bigl\{x \in \mathrm{dom}(\phi) \;\big|\; d_J(\phi(x), y) = 0\bigr\}$$

即所有在复合伪度量 $d_J$ 下与映射目标 $y$ 完全等价的输入点集合。$\{\mathfrak{F}_{\phi, J}(y)\}_{y \in \mathrm{Im}(\phi)}$ 构成 $\mathrm{dom}(\phi)$ 的超覆盖。当 $J = \{j\}$ 时，记单分量纤维为 $\mathfrak{F}_{\phi, d_j}(y)$。由 $d_J = \max_{j \in J} d_j$ 的定义直接得 $\mathfrak{F}_{\phi, J}(y) = \bigcap_{j \in J} \mathfrak{F}_{\phi, d_j}(y)$。

> **注（计算纤维的极值形态）**：
> 计算纤维随子族 $J$ 的选取展现出两种极端形态：
> 1. **单分量纤维**：$|J| = 1$（$J = \{i\}$）时，纤维退化为单分量坍缩态，记为 $\mathfrak{F}_{\phi, d_i}(y)$。
> 2. **全纤维**：$J = I$ 时，$\mathfrak{F}_{\phi, I}(y)$ 要求在所有分量上均完全一致。当且仅当规范结构 $\mathcal{G}$ 具备**族分离性**（§1.1）时，全纤维退化为标准原像 $\phi^{-1}(y)$。
> 由交集的单调性，对任意 $i \in I$ 恒有 $\mathfrak{F}_{\phi, I}(y) \subseteq \mathfrak{F}_{\phi, d_i}(y)$。

> **注（单分量纤维与分量分划的关系）**：
> 当 $|J|=1$（$J = \{j\}$）时，单分量纤维的结构由算子 $\phi$ 在该分量上的分划类型决定：
> - 若 $j \in I_{\mathrm{id}}(\phi)$（恒等分量）：$\mathfrak{F}_{\phi, d_j}(y) = \{x : d_j(x, y) = 0\}$，纤维退化为 $y$ 在 $d_j$ 下的原始等价类，不包含 $\phi$ 引入的额外坍缩；
> - 若 $j \in I_{\mathrm{const}}(\phi)$（常值分量）：$\mathfrak{F}_{\phi, d_j}(y) = \mathrm{dom}(\phi)$，全定义域构成单一纤维；
> 因此，算子诱导的非平凡纤维收缩仅发生在**活跃分量** $j \in I_{\mathrm{act}}(\phi)$ 上。

### 3.2 吸收半径与吸收矩阵

纤维的度量厚度由**局部吸收半径**刻画——以某点为中心，能被完全包含在纤维内部的最大伪度量开球半径。

#### 定义（吸收半径，Absorption Radius）

设 $\phi \in \Omega$，$y \in \mathrm{dom}(\phi)$。指定输入端分量 $i \in I$ 与输出端子族 $J \subseteq I$（$J \neq \emptyset$）。定义算子 $\phi$ 在点 $y$ 处关于 $(d_i, J)$ 的**吸收半径**：

$$\alpha_{\phi, d_i, J}(y) \;\triangleq\; \sup\bigl\{r \geq 0 \;\big|\; B_{d_i}(y, r) \subseteq \mathfrak{F}_{\phi, J}(\phi(y))\bigr\}$$

即以 $y$ 为中心，在输入分量 $d_i$ 下能被完全包含于纤维 $\mathfrak{F}_{\phi, J}(\phi(y))$ 内的最大开球半径。定义全域**最小吸收半径**：

$$\underline{\alpha}_{\phi, d_i, J} \;\triangleq\; \inf_{y \in \mathrm{dom}(\phi)} \alpha_{\phi, d_i, J}(y)$$

$\alpha_{\phi, d_i, J}(y)$ 表征纤维在点 $y$ 处的局部 $d_i$-厚度：此半径内的任何 $d_i$-扰动，经 $\phi$ 映射后在子族 $J$ 上的输出差异均精确归零。当 $J = \{j\}$ 时，记为 $\alpha_{\phi, d_i, d_j}(y)$。当 $\phi$ 在子族 $J$ 上局部单射且 $d_i$ 为分离伪度量时，$\alpha_{\phi, d_i, J}(y) = 0$。

> **注（吸收半径的各向同性限制）**：吸收半径 $\alpha_{\phi, d_i, J}(y)$ 给出以 $y$ 为中心的各向同性 $d_i$-开球内接估计。真实的纤维 $\mathfrak{F}_{\phi, J}(\phi(y))$ 可呈现非凸、非连通的复杂形态，开球半径仅构成该等价类集合在 $d_i$ 方向上的内接下界。

#### 定义（吸收矩阵，Absorption Matrix）

基于单分量最小吸收半径，定义算子 $\phi \in \Omega$ 的**吸收矩阵** $\mathbf{A}(\phi) \in \bar{\mathbb{R}}_+^{|I| \times |I|}$：

$$[\mathbf{A}(\phi)]_{ji} \;\triangleq\; \underline{\alpha}_{\phi, d_i, d_j}$$

行索引 $j$ 对应输出分量，列索引 $i$ 对应输入分量，与 Lip 矩阵的索引约定一致。

吸收矩阵是算子的内禀属性，独立于外部观察者选取的子族 $J$。所有分量通路上的纤维截断容限均被封存在此矩阵中。

> **注（吸收矩阵与 Lip 矩阵的对偶性）**：Lip 矩阵 $\mathbf{L}(\phi)$ 刻画输入散度向各输出散度扩散的**极差放大上界**；吸收矩阵 $\mathbf{A}(\phi)$ 则界定输入波动被各分量**纤维截断的容限下界**。二者从放大与归零两侧共同界定同一算子的测度传播行为。

**命题 3.1（吸收矩阵的复合下界）**：设 $\phi_2 \circ \phi_1 \in \Omega$。则对所有 $j, i \in I$：

$$[\mathbf{A}(\phi_2 \circ \phi_1)]_{ji} \;\geq\; \min_{l \in I}\, [\mathbf{A}(\phi_1)]_{li}$$

即复合算子的吸收半径不弱于 $\phi_1$ 在全分量上同时吸收的最短通道。

**证明**：任取 $r < \min_{l \in I} [\mathbf{A}(\phi_1)]_{li}$。对任意处于复合定义域的点 $y \in \mathrm{dom}(\phi_2 \circ \phi_1) \subseteq \mathrm{dom}(\phi_1)$ 及任意扰动输入 $x \in B_{d_i}(y, r)$，由于 $r < [\mathbf{A}(\phi_1)]_{li} \leq \alpha_{\phi_1, d_i, d_l}(y)$ 对所有 $l \in I$ 严格成立，依据局部吸收半径的定义，必有输出在全分量上的完全坍缩：$d_l(\phi_1(x), \phi_1(y)) = 0$（$\forall l \in I$）。

选取外层算子 $\phi_2$ 的任意合法 Lip 矩阵 $\mathbf{L}^{(2)}$（即便其包含 $+\infty$ 条目），由基础 Lip 放缩不等式与 $\bar{\mathbb{R}}_+$ 算术约定（$0 \cdot \infty = 0$）：
$$d_j(\phi_2(\phi_1(x)), \phi_2(\phi_1(y))) \leq \sum_{l \in I} L_{l \to j}^{(2)} \cdot d_l(\phi_1(x), \phi_1(y)) = \sum_{l \in I} L_{l \to j}^{(2)} \cdot 0 = 0$$

因此开球 $B_{d_i}(y, r)$ 完全包含于复合算子的零效纤维 $\mathfrak{F}_{\phi_2 \circ \phi_1, d_j}(\phi_2(\phi_1(y)))$ 内。这蕴含局部吸收半径 $\alpha_{\phi_2 \circ \phi_1, d_i, d_j}(y) \geq r$。对所有 $y$ 取下确界，再令 $r \to \min_{l \in I} [\mathbf{A}(\phi_1)]_{li}$ 即得复合矩阵下界。$\square$

> **注（与 Lip 复合律的结构对比）**：Lip 矩阵在复合下满足**矩阵乘法**（命题 1.1）——上界在线性放缩下保持可累积性。吸收矩阵则无类似的矩阵乘法结构：纤维吸收要求输出在指定分量上**精确为零**，而这在多分量下是全分量的联合条件——$\phi_1$ 必须在**每一个**中间分量 $l$ 上同时归零，才能保证 $\phi_2$ 的 Lip 不等式输出为零。此联合条件导致复合律取 $\min$（最弱通道瓶颈），而非 Lip 复合律中的 $\sum \cdot$ 积。

### 3.3 计算多样性与纤维维数

算子 $\phi$ 输入空间的测度复杂度由源空间度量熵（§1.2）标定；$\phi$ 实际导出的有效输出差异分布则由 $\mathrm{Im}(\phi)$ 的受限度量熵判定。二者之差揭示了被纤维结构归零的拓扑冗余量。

#### 约定（标量 Lip 常数）

对固定的分量对 $(d_i, d_j) \in \mathcal{G}^2$，定义算子 $\phi$ 在该分量对上的**标量 Lip 常数**：

$$L_{\phi, d_i \to d_j} \;\triangleq\; \inf\bigl\{L_{i \to j} \;:\; \exists\, \mathbf{L} \in \mathscr{L}(\phi),\; L_{i \to j} \text{ 为 } \mathbf{L} \text{ 的 } (i, j) \text{ 条目}\bigr\}$$

即 $\phi$ 的全体合法 Lip 矩阵在 $(i, j)$ 条目上的下确界。纤维内部 $\phi$ 在 $d_j$ 下的输出不可区分，标量 Lip 常数仅反映跨纤维的输出变化率。

#### 定义（计算多样性，Computational Diversity）

对 $\phi \in \Omega$、子族 $J \subseteq I$ 及精度 $\varepsilon > 0$：

$$\mathrm{CD}_{\varepsilon, J}(\phi) \;\triangleq\; \log \mathcal{N}_{d_J}\bigl(\varepsilon,\, \mathrm{Im}(\phi)\bigr)$$

即 $\mathrm{Im}(\phi)$ 在复合伪度量 $d_J$ 下的 $\varepsilon$-覆盖数的对数，衡量输出空间的有效可区分态数。

#### 定义（纤维膨胀量，Fiber Inflation）

指定输入端子族 $K \subseteq I$、输出端子族 $J \subseteq I$ 及精度 $\varepsilon > 0$：

$$\mathrm{FI}_{\varepsilon, K, J}(\phi) \;\triangleq\; I_{\varepsilon, d_K}\bigl(\mathrm{dom}(\phi)\bigr) - I_{\varepsilon, d_J}\bigl(\mathrm{Im}(\phi)\bigr)$$

*(式中 $I_{\varepsilon, \cdot}$ 为 §1.2 定义的度量熵。当 $K = J$ 时简记为 $\mathrm{FI}_{\varepsilon, J}(\phi)$)*。纤维膨胀量度量了 $\phi$ 通过纤维坍缩将输入端 $d_K$-可区分态压缩为输出端 $d_J$-等价态的信息损失量。

> **注（$\varepsilon$ 的探测尺度角色）**：度量熵 $I_\varepsilon$ 依赖于精度参数 $\varepsilon$，但纤维成员资格由严格等式 $d_J(\phi(x), y) = 0$ 决定，不受 $\varepsilon$ 影响。$\varepsilon$ 仅作为度量复杂度的探测尺度参加计算。

#### 定义（纤维维数，Fiber Dimension）

$$\mathrm{dim}_{F,\varepsilon, K, J}(\phi) \;\triangleq\; \frac{\mathrm{FI}_{\varepsilon, K, J}(\phi)}{\log(1/\varepsilon)}$$

纤维维数衡量了算子 $\phi$ 在精度 $\varepsilon$ 下，从输入子族 $K$ 到输出子族 $J$ 的跨分量传导过程中，被纤维结构截断归零的等效拓扑自由度数。

**命题 3.2（Lip 常数与膨胀界）**：设 $L_{\phi, d_i \to d_j} < \infty$。则：

$$\mathrm{FI}_{\varepsilon, d_i, d_j}(\phi) \;\geq\; I_{\varepsilon, d_i}\bigl(\mathrm{dom}(\phi)\bigr) - I_{\varepsilon / L_{\phi, d_i \to d_j},\, d_i}\bigl(\mathrm{dom}(\phi)\bigr)$$

**证明**：$\phi$ 将 $\mathrm{dom}(\phi)$ 中的 $(\varepsilon/L)$-$d_i$ 球映射到 $\varepsilon$-$d_j$ 球内（由标量 Lip 常数定义）。故 $\mathcal{N}_{d_j}(\varepsilon, \mathrm{Im}(\phi)) \leq \mathcal{N}_{d_i}(\varepsilon/L, \mathrm{dom}(\phi))$。取对数代入即得。$\square$

**命题 3.3（分辨率-吸收界）**：设 $\underline{\alpha}_{\phi, d_i, d_j} = \alpha > 0$。则：

$$\mathrm{CD}_{\varepsilon, d_j}(\phi) \;\leq\; I_{\alpha, d_i}\bigl(\mathrm{dom}(\phi)\bigr)$$

**证明**：取 $\mathrm{dom}(\phi)$ 在 $d_i$ 下的 $\alpha$-覆盖 $\{c_1, \ldots, c_M\}$（$M = \mathcal{N}_{d_i}(\alpha, \mathrm{dom}(\phi))$）。由吸收半径定义，$B_{d_i}(c_m, \alpha) \subseteq \mathfrak{F}_{\phi, d_j}(\phi(c_m))$，故 $\phi$ 的全部输出可被 $\{\phi(c_1), \ldots, \phi(c_M)\}$ 在 $d_j$ 下 $\varepsilon$-覆盖（因纤维内输出 $d_j$-不可区分）。$\square$

**命题 3.4（链级纤维膨胀的可加性）**：设 $\psi = \phi_2 \circ \phi_1$，取 $d \in \mathcal{G}$。若 $\mathrm{Im}(\phi_1) \subseteq \mathrm{dom}(\phi_2)$（复合定义域无损耗），则：

$$\mathrm{FI}_{\varepsilon, d}(\psi) \;=\; \mathrm{FI}_{\varepsilon, d}(\phi_1) \;+\; \mathrm{FI}_{\varepsilon, d}(\phi_2\big|_{\mathrm{Im}(\phi_1)})$$

**证明**：由假设 $\mathrm{dom}(\psi) = \mathrm{dom}(\phi_1)$，$\mathrm{Im}(\psi) = \phi_2(\mathrm{Im}(\phi_1))$。加减中间项 $I_{\varepsilon, d}(\mathrm{Im}(\phi_1))$ 即得。$\square$

**推论 3.5（$k$-步链的纤维膨胀可加）**：设 $c_\phi = \phi_k \circ \cdots \circ \phi_1$，若逐步满足 $\mathrm{Im}(\phi_{m-1} \circ \cdots \circ \phi_1) \subseteq \mathrm{dom}(\phi_m)$（$2 \leq m \leq k$），则：

$$\mathrm{FI}_{\varepsilon, d}(c_\phi) \;=\; \sum_{m=1}^{k} \mathrm{FI}_{\varepsilon, d}(\phi_m\big|_{\mathrm{Im}(\phi_{m-1} \circ \cdots \circ \phi_1)})$$

每步复合贡献一项纤维膨胀。总坍缩维数等于逐步坍缩维数之和——链越长，累积纤维坍缩越深。

### 3.4 纤维截断

在算子链中，两个不同输入经前置步骤映射后的像点测距，可能被后续步骤的纤维结构截断为零——若两像点落入同一纤维内，则后续步骤在该分量上的输出差异**精确归零**，无论前步测距的绝对量值如何。

#### 单步纤维截断

**命题 3.6（纤维截断）**：设 $c = \phi_2 \circ \phi_1 \in \Omega$，$x, x' \in \mathrm{dom}(c)$。令 $y = \phi_1(x)$，$y' = \phi_1(x')$。若 $y$ 与 $y'$ 落入 $\phi_2$ 关于 $d_j$ 的同一纤维（即 $y' \in \mathfrak{F}_{\phi_2, d_j}(\phi_2(y))$），则：

$$d_j(c(x), c(x')) = d_j(\phi_2(y), \phi_2(y')) = 0$$

即 $\phi_1$ 产生的像点测距 $d_i(y, y')$（无论其量值）在分量 $d_j$ 上被 $\phi_2$ 的纤维结构**精确截断为零**，不向后续传播。

**证明**：$y' \in \mathfrak{F}_{\phi_2, d_j}(\phi_2(y))$ 意味着 $d_j(\phi_2(y'), \phi_2(y)) = 0$（由纤维定义直接得出）。$\square$

> **注（吸收半径作为截断的充分条件）**：若 $d_i(y, y') \leq \alpha_{\phi_2, d_i, d_j}(y)$，则由吸收半径定义有 $y' \in B_{d_i}(y, \alpha) \subseteq \mathfrak{F}_{\phi_2, d_j}(\phi_2(y))$，命题 3.6 的前提自动满足。因此，吸收半径给出了纤维截断发生的**可计算充分条件**。

#### 算子链中的逐步截断迭代

在级联算子链 $c_\phi = \phi_k \circ \cdots \circ \phi_1$ 中，取任意两个输入 $x, x' \in \mathrm{dom}(c_\phi)$。由于映射的确定性，它们在第 $m$ 步的像点 $x_m \triangleq (\phi_m \circ \cdots \circ \phi_1)(x)$ 与 $x'_m \triangleq (\phi_m \circ \cdots \circ \phi_1)(x')$ 唯一确定。

**命题 3.7（截断迭代律）**：对于第 $m+1$ 步算子 $\phi_{m+1}$，任意输出分量 $d_j$ 下的像点测距满足：

$$d_j(x_{m+1}, x'_{m+1}) \;\leq\; \begin{cases} 0 & \text{若存在 } i \in I \text{ 使得 } d_i(x_m, x'_m) < [\mathbf{A}(\phi_{m+1})]_{ji} \\ \sum\limits_{i \in I} [\mathbf{L}(\phi_{m+1})]_{ji} \cdot d_i(x_m, x'_m) & \text{否则} \end{cases}$$

**证明**：对第一种情况：若存在 $i \in I$ 使得 $d_i(x_m, x'_m) < [\mathbf{A}(\phi_{m+1})]_{ji} = \underline{\alpha}_{\phi_{m+1}, d_i, d_j}$，则 $d_i(x_m, x'_m) < \underline{\alpha} \leq \alpha_{\phi_{m+1}, d_i, d_j}(x_m)$，故 $x'_m \in B_{d_i}(x_m, \alpha(x_m)) \subseteq \mathfrak{F}_{\phi_{m+1}, d_j}(\phi_{m+1}(x_m))$（由吸收半径定义中的开球取 sup 结构保证）。由命题 3.6 直接得 $d_j(x_{m+1}, x'_{m+1}) = 0$。对第二种情况：由 Lip 矩阵定义直接得上界。$\square$

该迭代律表明：即便 $\mathbf{L}$ 矩阵允许前步测距发生跨分量的乘性放大，只要在某一输入分量 $d_i$ 上，两像点的当前测距未超过 $\phi_{m+1}$ 在 $(d_i, d_j)$ 通路上的最小吸收半径，则 $d_j$ 上的输出测距即被纤维截断为零。Lip 矩阵界定测距的**放大上限**，吸收矩阵提供测距的**归零下限**，二者共同决定了算子链中点对测距的逐步演化。

> **注（吸收条件的单分量充分性）**：截断条件仅需在**某一个**输入分量 $i$ 上满足即可触发 $d_j$ 输出归零。这是因为吸收半径的定义本身就是单输入分量的开球包含条件（$B_{d_i}(y, r) \subseteq \mathfrak{F}$），与其他分量上的测距无关。不同输入分量可独立提供截断通道。

### 3.5 纤维冲突

当一个算子将两个输入坍缩至同一纤维，而另一个算子要求区分这两个输入时，产生**纤维冲突**。

#### 定义（纤维冲突，Fiber Conflict）

设 $\phi, \psi \in \Omega$，$\tau > 0$，$d_j \in \mathcal{G}$。若存在 $x, x' \in \mathrm{dom}(\phi) \cap \mathrm{dom}(\psi)$ 使得：

$$d_j(\phi(x), \phi(x')) = 0 \quad \text{但} \quad d_j(\psi(x), \psi(x')) > 2\tau$$

则称 $\phi$ 与 $\psi$ 在点对 $(x, x')$ 上关于 $(d_j, \tau)$ 发生**纤维冲突**——$\phi$ 将 $x, x'$ 坍缩至同一 $d_j$-纤维，而 $\psi$ 要求它们在 $d_j$ 下保持超过 $2\tau$ 的距离。

> **注（纤维冲突的结构性）**：纤维冲突的条件 $d_j(\phi(x), \phi(x')) = 0$ 是等价类结构的性质，不随连续扰动而消失。这使得纤维冲突产生的偏离下界是**结构性的**，而非仅仅是度量估计。

**命题 3.8（纤维冲突的固有偏离下界）**：设复合算子链 $\hat{\psi} = \phi_k \circ \cdots \circ \phi_1$ 与一般算子 $\psi$ 共定义域。若 $\hat{\psi}$ 在内部传导的第 $m$ 步与 $\psi$ 发生纤维冲突，即存在 $x, x' \in \mathrm{dom}(\hat{\psi}) \cap \mathrm{dom}(\psi)$ 使得 $d_j(\phi_m(x_{m-1}), \phi_m(x'_{m-1})) = 0$（其中 $x_{m-1}, x'_{m-1}$ 为 $x, x'$ 经前 $m-1$ 步的中间态），则这两个算子在 $x$ 与 $x'$ 上的输出测距必然满足极小下界：

$$\max\bigl\{d_j(\hat{\psi}(x), \psi(x)),\; d_j(\hat{\psi}(x'), \psi(x'))\bigr\} \;\geq\; \frac{d_j(\psi(x), \psi(x'))}{2}$$

**证明**：$d_j(\phi_m(x_{m-1}), \phi_m(x'_{m-1})) = 0$ 蕴含 $d_j(\hat{\psi}_{\mathrm{tail}}(\phi_m(x_{m-1})), \hat{\psi}_{\mathrm{tail}}(\phi_m(x'_{m-1}))) = 0$（其中 $\hat{\psi}_{\mathrm{tail}} = \phi_k \circ \cdots \circ \phi_{m+1}$；由 Lip 不等式 $L \cdot 0 = 0$，遵循 §1.1 $\bar{\mathbb{R}}_+$ 约定），即 $d_j(\hat{\psi}(x), \hat{\psi}(x')) = 0$。由三角不等式：
$$d_j(\psi(x), \psi(x')) \leq d_j(\hat{\psi}(x), \psi(x)) + d_j(\hat{\psi}(x), \hat{\psi}(x')) + d_j(\hat{\psi}(x'), \psi(x'))$$
$$= d_j(\hat{\psi}(x), \psi(x)) + 0 + d_j(\hat{\psi}(x'), \psi(x'))$$
两项中至少一项 $\geq d_j(\psi(x), \psi(x'))/2$。$\square$

> **注（纤维截断与纤维冲突的对偶性）**：§3.4 的纤维截断——两像点落入同一纤维后测距被精确截断为零——是有利的多对一坍缩。纤维冲突——需要区分的输入被坍缩至同一纤维——是不利的多对一坍缩。两者是同一纤维结构的两面：吸收半径同时决定了算子的**鲁棒性**（截断容限）和**分辨率极限**（冲突阈值）。

### 3.6 纤维同构

前叙定理（特别是纤维截断与纤维冲突）揭示了一个核心事实：算子在复合网络中的关键隔离效能，根本上取决于它对输入空间实施的**离散网格化划分（等价类切割）**边界。这自然地诱导出了宏观算子空间的一类拓扑等价关系。

#### 定义（局部纤维同构，Local Fiber Isomorphism）

设 $\phi, \psi \in \Omega$，且其定义域交集 $D = \mathrm{dom}(\phi) \cap \mathrm{dom}(\psi) \neq \emptyset$。指定指标集子族 $J \subseteq I$。若对所有 $x, x' \in D$，恒有：

$$d_J(\phi(x), \phi(x')) = 0 \iff d_J(\psi(x), \psi(x')) = 0$$

则称算子 $\phi$ 与 $\psi$ 在限定子族 $J$ 及交集 $D$ 上**局部纤维同构**，记作 $\phi \sim_{J,D} \psi$。对固定的 $J$ 与 $D$，$\sim_{J,D}$ 是 $\{\phi \in \Omega : D \subseteq \mathrm{dom}(\phi)\}$ 上的等价关系（自反性与对称性由 $\iff$ 的逻辑性质直接成立；传递性由两个 $\iff$ 的链式传递得保）。

*(此条件等价于：$\phi$ 与 $\psi$ 的计算纤维集族 $\mathfrak{F}_{\phi, J}$ 与 $\mathfrak{F}_{\psi, J}$ 对公共定义域 $D$ 施加了完全相同的等价类剖分。)*

> 纤维同构等价关系 $\sim_{J,D}$ 在算子复合下的代数行为见 §4.4。

----
*[IDFS] ⊢ [GLENZLI] ⊢ [Part 01] ⊢ [03-computational-fiber] ⊢ [b3ba13bdc02a7e94]*
