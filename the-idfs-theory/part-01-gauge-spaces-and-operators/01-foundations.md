## 基础

### 1.1 扩展规范空间

**定义（扩展规范空间，Extended Gauge Space）**：设 $\mathcal{X}$ 为非空集合。$\mathcal{X}$ 上的一个**规范结构** $\mathcal{G} = \{d_i\}_{i \in I}$（$I$ 为有限指标集）是一族**扩展伪度量**（extended pseudometric），每个 $d_i: \mathcal{X} \times \mathcal{X} \to \bar{\mathbb{R}}_+ = [0, +\infty]$ 满足：

1. $d_i(x, x) = 0$，
2. $d_i(x, y) = d_i(y, x)$（对称），
3. $d_i(x, z) \leq d_i(x, y) + d_i(y, z)$（三角不等式），
4. 允许 $d_i(x, y) = 0$ 而 $x \neq y$。

> **约定（$\bar{\mathbb{R}}_+$ 算术）**：全文采用标准扩展非负实数算术：$a + (+\infty) = +\infty$，$0 \cdot (+\infty) = 0$，$a \cdot (+\infty) = +\infty$（$a > 0$）。

称 $(\mathcal{X}, \mathcal{G})$ 为**扩展规范空间**（简称**规范空间**）。$\mathcal{G}$ 在 $\mathcal{X}$ 上生成**初始拓扑**——以所有形如 $\{x : d_i(x, x_0) < \varepsilon\}$ 的集合为子基。每个 $d_i$ 称为 $\mathcal{G}$ 的一个**分量（扩展）伪度量**，后续简称**分量伪度量**。

**定义（族分离性，Family Separation）**：

- **分离规范**（separating gauge）：$\forall x, y \in \mathcal{X}$，$(\forall i \in I:\; d_i(x, y) = 0) \;\Rightarrow\; x = y$。
- **非分离规范**（non-separating gauge）：$\exists\, x \neq y$ 使得 $\forall i \in I:\; d_i(x, y) = 0$。此时 $\mathcal{G}$ 在 $\mathcal{X}$ 上诱导等价关系 $x \sim_\mathcal{G} y$。

> **注（与度量空间的关系）**：度量空间 $(\mathcal{X}, d)$ 是扩展规范空间的特例，取 $\mathcal{G} = \{d\}$（单分量、分离、有限值 $d: \mathcal{X}^2 \to [0, \infty)$）。后续理论中，若需度量空间的特化结果，通过对 $\mathcal{G}$ 施加额外条件得到，而非作为基础假设。

### 1.2 空间度量熵

**定义（度量熵，Metric Entropy）**：对精度 $\varepsilon > 0$、分量伪度量 $d_i$ 与子集 $A \subseteq \mathcal{X}$，定义：

$$I_{\varepsilon, d_i}(A) \;\triangleq\; \log \mathcal{N}_{d_i}\bigl(\varepsilon,\, A\bigr)$$

其中 $\mathcal{N}_{d_i}(\varepsilon, A)$ 为在 $d_i$ 下覆盖 $A$ 所需的最小 $\varepsilon$-球数量。$I_{\varepsilon, d_i}$ 取值于 $\bar{\mathbb{R}}_+$：若 $A$ 不可有限覆盖则 $I_{\varepsilon, d_i}(A) = +\infty$；对 $A = \emptyset$ 约定 $I_{\varepsilon, d_i}(\emptyset) = 0$。

### 1.3 算子与吸收元空间

**定义（算子空间，Operator Space）**：指定**吸收元** $\bot \in \mathcal{X}$，要求 $d_i(\bot, \bot) = 0$ 对所有 $i$（由公理 1 自动满足）。定义：

$$\Omega = \{\, \phi : \mathcal{X} \to \mathcal{X} \;\big|\; \phi(\bot) = \bot \,\}$$

$\phi \in \Omega$ 称为 $\mathcal{X}$ 上的一个**算子**。$\phi(x) = \bot$ 表示 $\phi$ 在 $x$ 处未定义。

> **注（正常态与崩溃态的拓扑隔离）**：补充要求对所有 $x \in \mathcal{X} \setminus \{\bot\}$ 和 $i \in I$，规定 $d_i(x, \bot) = +\infty$。这一无穷势垒约定补全了测度定义：当全局核算两个算子的差分时，若对于同一输入其一正常收敛而另一触发吸收态崩溃，它们的作动距离将自然被核定为正无穷。这在理论上严格割裂了具有不同定义域的算子分支。

定义其**定义域**：

$$\mathrm{dom}(\phi) \;\triangleq\; \bigl\{\, x \in \mathcal{X} \;\big|\; \phi(x) \neq \bot \,\bigr\}$$

由 $\phi(\bot) = \bot$，对所有 $\phi \in \Omega$（包括 $\mathrm{id}_\mathcal{X}$）均有 $\bot \notin \mathrm{dom}(\phi)$。这是吸收元编码的自然结果：$\bot$ 的作用是将偏函数统一为全函数，$\mathrm{dom}(\phi)$ 刻画 $\phi$ 给出有意义输出的区域。

$\Omega$ 在函数复合下构成**幺半群**：$\phi_2 \circ \phi_1 \in \Omega$，$\mathrm{id}_{\mathcal{X}} \in \Omega$。

### 1.4 算子空间上的度量

对分量伪度量 $d_i \in \mathcal{G}$ 与子集 $S \subseteq \mathcal{X}$，定义 $\Omega$ 上的 **sup-范数距离**：

$$d_{\Omega, d_i}(\phi, \psi)\big|_S \;\triangleq\; \sup_{x \in S} d_i(\phi(x), \psi(x))$$

取 $S = \mathcal{X}$ 时简记 $d_{\Omega, d_i}(\phi, \psi) \triangleq d_{\Omega, d_i}(\phi, \psi)\big|_\mathcal{X}$。$d_{\Omega, d_i}$ 是 $\Omega$ 上的扩展伪度量（$d_{\Omega,d_i}(\phi,\phi) = 0$ 由公理 1 得到；对称性与三角不等式由 $d_i$ 的对应性质逐点继承后取 $\sup$ 保持）。$\mathcal{G}$ 在 $\Omega$ 上诱导规范结构 $\mathcal{G}_\Omega = \{d_{\Omega, d_i}\}_{i \in I}$。

### 1.5 Lipschitz 矩阵

**定义（Lipschitz 矩阵，Lipschitz Matrix）**：对 $\phi \in \Omega$，称非负矩阵 $\mathbf{L} = (L_{i \to j})_{i, j \in I}$（$L_{i \to j} \in \bar{\mathbb{R}}_+$）为 $\phi$ 的一个**合法 Lipschitz 矩阵**，若对所有 $x, y \in \mathrm{dom}(\phi)$ 和所有 $j \in I$：

$$d_j(\phi(x), \phi(y)) \;\leq\; \sum_{i \in I} L_{i \to j} \cdot d_i(x, y)$$

> **约定**：求和中的 $\bar{\mathbb{R}}_+$ 算术遵循 §1.1 约定（特别地 $+\infty \cdot 0 = 0$）。即若某条目 $L_{i \to j} = +\infty$ 但 $d_i(x, y) = 0$，该项贡献为零——在 $d_i$ 下不可区分的输入对，即使 $L_{i \to j}$ 无界，也不产生 $d_j$-输出差异。当 $L_{i \to j} = +\infty$ 且 $d_i(x, y) > 0$ 时，该项为 $+\infty$，不等式平凡成立。

记 $\phi$ 的全体合法 Lip 矩阵之集为 $\mathscr{L}(\phi)$。$\mathscr{L}(\phi)$ 在逐条目偏序 $\leq$ 下是**上闭集**（若 $\mathbf{L} \in \mathscr{L}(\phi)$ 且 $\mathbf{L}' \geq \mathbf{L}$ 逐条目，则 $\mathbf{L}' \in \mathscr{L}(\phi)$）且为**凸集**（凸组合封闭）。一般而言，$\mathscr{L}(\phi)$ **不存在唯一的逐条目最小元**——不同的合法矩阵对应将输出变化归因于各输入分量的不同方式。

> **注（非唯一性）**：规范结构中的伪度量族是空间结构的**投影**，一般不构成空间的独立参数化。因此，给定输入对 $(x,y)$ 的距离向量 $(d_i(x,y))_{i \in I}$ 无法被唯一分解为各分量的独立贡献。Lip 矩阵的非唯一性是此结构事实的忠实反映。

> **约定（广义 Lip）**：Lip 矩阵条目取值于 $\bar{\mathbb{R}}_+$（与 §1.1 一致）。需要有限性时显式标注。

> **注（退化情形）**：取 $|I| = 1$（单分量），Lip 矩阵退化为标量 Lipschitz 常数。

**定义（子集受限 Lip 矩阵，Set-Restricted Lip Matrix）**：对子集 $S \subseteq \mathrm{dom}(\phi)$，如果在 $S$ 上对任意 $x, y \in S$ 均满足上述距离放缩不等式，则称 $\mathbf{L}$ 为 $\phi$ 在 $S$ 上的一个受限 Lip 矩阵，记其合法矩阵集为 $\mathscr{L}(\phi)\big|_S$。显然 $\mathscr{L}(\phi) \subseteq \mathscr{L}(\phi)\big|_S$，即评估域越小，其界限可能越紧致。

**命题 1.1（Lip 矩阵复合律）**：若对于算子链 $\phi_2 \circ \phi_1$，设其几何交互截面为 $S_{12} = \mathrm{Im}(\phi_1) \cap \mathrm{dom}(\phi_2)$。若 $\mathbf{L}_1 \in \mathscr{L}(\phi_1)$，且 $\mathbf{L}_2 \in \mathscr{L}(\phi_2)\big|_{S_{12}}$，则 $\mathbf{L}_2 \cdot \mathbf{L}_1 \in \mathscr{L}(\phi_2 \circ \phi_1)$（标准矩阵乘法）。

**证明**：对任意 $x, y \in \mathrm{dom}(\phi_2 \circ \phi_1)$，必有 $\phi_1(x), \phi_1(y) \in S_{12}$。因此对所有 $j \in I$：

$$\begin{aligned}
d_j((\phi_2 \circ \phi_1)(x), (\phi_2 \circ \phi_1)(y)) 
&\leq \sum_{k \in I} L^{(2)}_{k \to j} \cdot d_k(\phi_1(x), \phi_1(y)) \quad (\text{因 } \phi_1(x), \phi_1(y) \in S_{12}) \\
&\leq \sum_{k \in I} L^{(2)}_{k \to j} \sum_{i \in I} L^{(1)}_{i \to k} \cdot d_i(x, y) \\
&= \sum_{i \in I} \biggl(\sum_{k \in I} L^{(2)}_{k \to j} \cdot L^{(1)}_{i \to k}\biggr) d_i(x, y)
\end{aligned}$$

括号内即 $(\mathbf{L}_2 \cdot \mathbf{L}_1)_{i \to j}$。$\square$

### 1.6 算子链

$\Omega$ 中有限个算子的复合 $c_\phi = \phi_k \circ \cdots \circ \phi_1$（$\phi_j \in \Omega$，$k \geq 0$）称为**算子链**（operator chain），$k$ 为其**长度**；$k = 0$ 时约定 $c_\phi = \mathrm{id}_{\mathcal{X}}$。由 $\Omega$ 的幺半群封闭性，$c_\phi \in \Omega$。

设 $\mathbf{L}_j \in \mathscr{L}(\phi_j)$ 为各步的合法 Lip 矩阵。由命题 1.1 的递归应用：

$$\mathbf{L}_k \cdot \cdots \cdot \mathbf{L}_1 \;\in\; \mathscr{L}(c_\phi)$$

由于 Lip 矩阵的非唯一性，上述全域标准乘积仅指出了一组代数存续的合法边界，它通常是**极为松散**的。因此，如何根据算子链内部真实的拓扑信息通路来剥离这种虚拟膨胀、寻找更加紧致的系统界限，构成了后续算子控制分析的核心课题。

----
*[IDFS] ⊢ [GLENZLI] ⊢ [Part 01] ⊢ [01-foundations]*
