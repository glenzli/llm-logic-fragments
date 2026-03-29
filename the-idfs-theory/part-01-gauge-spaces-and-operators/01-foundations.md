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

**定义（度量熵，Metric Entropy）**：对精度 $\varepsilon > 0$、分量伪度量 $d_i$ 与子集 $U \subseteq \mathcal{X}$，定义：

$$I_{\varepsilon, d_i}(U) \;\triangleq\; \log \mathcal{N}_{d_i}\bigl(\varepsilon,\, U\bigr)$$

其中 $\mathcal{N}_{d_i}(\varepsilon, U)$ 为在 $d_i$ 下覆盖 $U$ 所需的最小 $\varepsilon$-球数量。$I_{\varepsilon, d_i}$ 取值于 $\bar{\mathbb{R}}_+$：若 $U$ 不可有限覆盖则 $I_{\varepsilon, d_i}(U) = +\infty$；对 $U = \emptyset$ 约定 $I_{\varepsilon, d_i}(\emptyset) = 0$。

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

对分量伪度量 $d_i \in \mathcal{G}$ 与子集 $U \subseteq \mathcal{X}$，定义 $\Omega$ 上的 **sup-范数距离**：

$$d_{\Omega, d_i}(\phi, \psi)\big|_U \;\triangleq\; \sup_{x \in U} d_i(\phi(x), \psi(x))$$

取 $U = \mathcal{X}$ 时简记 $d_{\Omega, d_i}(\phi, \psi) \triangleq d_{\Omega, d_i}(\phi, \psi)\big|_\mathcal{X}$。$d_{\Omega, d_i}$ 是 $\Omega$ 上的扩展伪度量（$d_{\Omega,d_i}(\phi,\phi) = 0$ 由公理 1 得到；对称性与三角不等式由 $d_i$ 的对应性质逐点继承后取 $\sup$ 保持）。$\mathcal{G}$ 在 $\Omega$ 上诱导规范结构 $\mathcal{G}_\Omega = \{d_{\Omega, d_i}\}_{i \in I}$。

### 1.5 Lipschitz 矩阵

**定义（Lipschitz 矩阵，Lipschitz Matrix）**：对 $\phi \in \Omega$，称非负矩阵 $\mathbf{L} = (L_{i \to j})_{i, j \in I}$（$L_{i \to j} \in \bar{\mathbb{R}}_+$）为 $\phi$ 的一个**合法 Lipschitz 矩阵**，若对所有 $x, y \in \mathrm{dom}(\phi)$ 和所有 $j \in I$：

$$d_j(\phi(x), \phi(y)) \;\leq\; \sum_{i \in I} L_{i \to j} \cdot d_i(x, y)$$

> **约定（广义 Lip）**：Lip 矩阵条目取值于 $\bar{\mathbb{R}}_+$（与 §1.1 一致），即允许 $L_{i \to j} = +\infty$。需要有限性时显式标注。求和中的 $\bar{\mathbb{R}}_+$ 算术遵循 §1.1 约定（特别地 $+\infty \cdot 0 = 0$）。即若某条目 $L_{i \to j} = +\infty$ 但 $d_i(x, y) = 0$，该项贡献为零——在 $d_i$ 下不可区分的输入对，即使 $L_{i \to j}$ 无界，也不产生 $d_j$-输出差异。当 $L_{i \to j} = +\infty$ 且 $d_i(x, y) > 0$ 时，该项为 $+\infty$，不等式平凡成立。

记 $\phi$ 的全体合法 Lip 矩阵之集为 $\mathscr{L}(\phi)$。$\mathscr{L}(\phi)$ 在逐条目偏序 $\leq$ 下是**上闭集**（若 $\mathbf{L} \in \mathscr{L}(\phi)$ 且 $\mathbf{L}' \geq \mathbf{L}$ 逐条目，则 $\mathbf{L}' \in \mathscr{L}(\phi)$）且为**凸集**（Lip 不等式右侧关于矩阵条目线性，线性不等式族的解集天然凸组合封闭）。一般而言，$\mathscr{L}(\phi)$ **不存在唯一的逐条目最小元**——不同的合法矩阵对应将输出变化归因于各输入分量的不同方式。

> **注（非唯一性）**：规范结构中的伪度量族是空间结构的**投影**，一般不构成空间的独立参数化。因此，给定输入对 $(x,y)$ 的距离向量 $(d_i(x,y))_{i \in I}$ 无法被唯一分解为各分量的独立贡献。Lip 矩阵的非唯一性是此结构事实的忠实反映。


> **注（退化情形）**：取 $|I| = 1$（单分量），Lip 矩阵退化为标量 Lipschitz 常数。

**定义（子集受限 Lip 矩阵，Set-Restricted Lip Matrix）**：对子集 $U \subseteq \mathrm{dom}(\phi)$，如果在 $U$ 上对任意 $x, y \in U$ 均满足上述距离放缩不等式，则称 $\mathbf{L}$ 为 $\phi$ 在 $U$ 上的一个受限 Lip 矩阵，记其合法矩阵集为 $\mathscr{L}(\phi)\big|_U$。显然 $\mathscr{L}(\phi) \subseteq \mathscr{L}(\phi)\big|_U$，即评估域越小，其界限可能越紧致。

**命题 1.1（Lip 矩阵复合律）**：对于复合算子 $\phi_2 \circ \phi_1$，选定起始定义域的局部子集 $U_1 \subseteq \mathrm{dom}(\phi_2 \circ \phi_1)$，记像集 $U_2 = \phi_1(U_1)$（由复合定义直接保证 $U_2 \subseteq \mathrm{dom}(\phi_2)$）。若 $\mathbf{L}_1 \in \mathscr{L}(\phi_1)\big|_{U_1}$ 且 $\mathbf{L}_2 \in \mathscr{L}(\phi_2)\big|_{U_2}$，则 $\mathbf{L}_2 \cdot \mathbf{L}_1 \in \mathscr{L}(\phi_2 \circ \phi_1)\big|_{U_1}$。

**证明**：对任意 $x, y \in U_1$，复合映射不仅合法且有像点 $\phi_1(x), \phi_1(y) \in U_2$。对于任意 $j \in I$ 展开：

根据 $\mathbf{L}_2 \in \mathscr{L}(\phi_2)\big|_{U_2}$，代入像点对 $(\phi_1(x), \phi_1(y))$：
$$d_j((\phi_2 \circ \phi_1)(x), (\phi_2 \circ \phi_1)(y)) \;\leq\; \sum_{k \in I} L^{(2)}_{k \to j} \cdot d_k(\phi_1(x), \phi_1(y))$$

由于 $\mathbf{L}_1 \in \mathscr{L}(\phi_1)\big|_{U_1}$，对一切 $k \in I$ 均有 $d_k(\phi_1(x), \phi_1(y)) \leq \sum_{i \in I} L^{(1)}_{i \to k} \cdot d_i(x,y)$。因 $L^{(2)}_{k \to j} \geq 0$，同乘 $L^{(2)}_{k \to j}$ 并对 $k \in I$ 求和，不等号方向不变（由 $0 \cdot (+\infty) = 0$ 约定保证代数一致性）：
$$\leq\; \sum_{k \in I} L^{(2)}_{k \to j} \left( \sum_{i \in I} L^{(1)}_{i \to k} \cdot d_i(x, y) \right)$$

利用 $\bar{\mathbb{R}}_+$ 对有限和的加法交换律与乘法分配律，交换求和次序：
$$=\; \sum_{i \in I} \biggl(\sum_{k \in I} L^{(2)}_{k \to j} \cdot L^{(1)}_{i \to k}\biggr) \cdot d_i(x, y)$$

内部加和即为代数矩阵乘法元素 $(\mathbf{L}_2 \cdot \mathbf{L}_1)_{i \to j}$ 的定义，故 $\mathbf{L}_2 \cdot \mathbf{L}_1 \in \mathscr{L}(\phi_2 \circ \phi_1)\big|_{U_1}$。$\square$

### 1.6 受限下界矩阵（co-Lipschitz 矩阵）

**定义（子集受限 co-Lipschitz 矩阵，Set-Restricted co-Lipschitz Matrix）**：对 $\phi \in \Omega$ 与给定的非空子集 $U \subseteq \mathrm{dom}(\phi)$，称非负矩阵 $\mathbf{K} = (K_{i \to j})_{i, j \in I}$（$K_{i \to j} \in \bar{\mathbb{R}}_+$）为 $\phi$ 在 $U$ 上的一个**合法受限 co-Lipschitz 矩阵**（后续可简称为 co-Lip 矩阵），若对所有 $x, y \in U$ 和所有 $j \in I$：

$$d_j(\phi(x), \phi(y)) \;\geq\; \sum_{i \in I} K_{i \to j} \cdot d_i(x, y)$$

记 $\phi$ 在 $U$ 上的全体合法 co-Lip 矩阵之集为 $\mathscr{K}(\phi)\big|_U$。与 $\mathscr{L}(\phi)$ 的上闭凸集属性对偶，$\mathscr{K}(\phi)\big|_U$ 在逐条目偏序 $\leq$ 下是**下闭凸集**。

> **注（受限定义的拓扑必要性）**：Lip 矩阵（§1.5）给出了输入伪度量的放缩上限，而 co-Lip 矩阵界定了局部保距下限。对于存在多对一映射的算子（即 $d_j = 0$ 但 $d_i > 0$），若在全域 $\mathrm{dom}(\phi)$ 上评估，非负性要求强制 $K_{i \to j} = 0$。因此，非平凡（严格大于零）的下界矩阵必须定义在排除了拓扑重叠点对的子集 $U$ 上。

**定义（下界支撑集，Lower-bound Support Set）**：
为标定算子 $\phi$ 能够保持伪度量分离性的局部定义域，基于受限下界矩阵界定两类子集族：
- **通路支撑集** $\mathcal{U}_{i \to j}(\phi)$：包含所有子集 $U \subseteq \mathrm{dom}(\phi)$，其上存在合法矩阵 $\mathbf{K} \in \mathscr{K}(\phi)\big|_U$ 且满足 $K_{i \to j} > 0$。对于该子集上的任意两点，只要 $d_i(x,y)>0$，必有保距下界 $d_j(\phi(x),\phi(y)) \geq K_{i \to j} d_i(x,y) > 0$。
- **非退化保距域** $\mathcal{U}_{> \mathbf{0}}(\phi)$：包含所有子集 $U \subseteq \mathrm{dom}(\phi)$，其上存在合法矩阵 $\mathbf{K} \in \mathscr{K}(\phi)\big|_U$ 使得矩阵 $\mathbf{K} \neq \mathbf{0}$。有 $\mathcal{U}_{> \mathbf{0}}(\phi) = \bigcup_{i, j \in I} \mathcal{U}_{i \to j}(\phi)$。

限定评估子集于 $U \in \mathcal{U}_{> \mathbf{0}}(\phi)$ 等价于排除了使算子发生全分量伪度量退化（所有输出伪度量为 0）的区域，保证下界矩阵存在非零条目。

**命题 1.2（co-Lip 矩阵复合律）**：对于复合算子 $\phi_2 \circ \phi_1$，选定起始定义域的局部子集 $U_1 \subseteq \mathrm{dom}(\phi_2 \circ \phi_1)$，记像集 $U_2 = \phi_1(U_1)$（由复合定义直接保证 $U_2 \subseteq \mathrm{dom}(\phi_2)$）。若 $\mathbf{K}_1 \in \mathscr{K}(\phi_1)\big|_{U_1}$ 且 $\mathbf{K}_2 \in \mathscr{K}(\phi_2)\big|_{U_2}$，则 $\mathbf{K}_2 \cdot \mathbf{K}_1 \in \mathscr{K}(\phi_2 \circ \phi_1)\big|_{U_1}$。

**证明**：对任意 $x, y \in U_1$，复合映射不仅合法且有像点 $\phi_1(x), \phi_1(y) \in U_2$。对于任意 $j \in I$ 展开：

根据 $\mathbf{K}_2 \in \mathscr{K}(\phi_2)\big|_{U_2}$，代入像点对 $(\phi_1(x), \phi_1(y))$：
$$d_j((\phi_2 \circ \phi_1)(x), (\phi_2 \circ \phi_1)(y)) \;\geq\; \sum_{k \in I} K^{(2)}_{k \to j} \cdot d_k(\phi_1(x), \phi_1(y))$$

由于 $\mathbf{K}_1 \in \mathscr{K}(\phi_1)\big|_{U_1}$，对一切 $k \in I$ 均有 $d_k(\phi_1(x), \phi_1(y)) \geq \sum_{i \in I} K^{(1)}_{i \to k} \cdot d_i(x,y)$。因 $K^{(2)}_{k \to j} \geq 0$，同乘 $K^{(2)}_{k \to j}$ 并对 $k \in I$ 求和，不等号方向不变（由 $0 \cdot (+\infty) = 0$ 约定保证代数一致性）：
$$\geq\; \sum_{k \in I} K^{(2)}_{k \to j} \left( \sum_{i \in I} K^{(1)}_{i \to k} \cdot d_i(x, y) \right)$$

利用 $\bar{\mathbb{R}}_+$ 对有限和的加法交换律与乘法分配律，交换求和次序：
$$=\; \sum_{i \in I} \biggl(\sum_{k \in I} K^{(2)}_{k \to j} \cdot K^{(1)}_{i \to k}\biggr) \cdot d_i(x, y)$$

内部加和即为代数矩阵乘法元素 $(\mathbf{K}_2 \cdot \mathbf{K}_1)_{i \to j}$ 的定义，故 $\mathbf{K}_2 \cdot \mathbf{K}_1 \in \mathscr{K}(\phi_2 \circ \phi_1)\big|_{U_1}$。$\square$

> **注（测度非退化的代数判据）**：命题 1.2 给出了复合算子局部保距性的计算判据。只要矩阵乘积存在非零项 $[\mathbf{K}_2 \cdot \mathbf{K}_1]_{i \to j} > 0$，则表明起点的 $i$ 分量伪度量差异至少能传递至终点的 $j$ 分量（$d_j > 0$），从而在代数上排除了复合算子在对应子集发生拓扑重叠（等价类合并）。

### 1.7 算子链

$\Omega$ 中有限个算子的复合 $c_k = \phi_k \circ \cdots \circ \phi_1$（$\phi_m \in \Omega$，$k \geq 0$）称为**算子链**（operator chain），$k$ 为其**长度**；$k = 0$ 时约定 $c_0 = \mathrm{id}_{\mathcal{X}}$。由 $\Omega$ 的幺半群封闭性，$c_k \in \Omega$。

**推论 1.3（算子链局部矩阵界限）**：
对于起始定义域子集 $U_1 \subseteq \mathrm{dom}(c_k)$，递归定义中间像集 $U_{m+1} = \phi_m(U_m)$（$m = 1, \dots, k$），从而保证对所有 $m$ 均有 $U_m \subseteq \mathrm{dom}(\phi_m)$。由命题 1.1 与 1.2 对复合算子的归纳递推，全链的局部距离测量矩阵判定如下：

1. **Lip 矩阵放缩上限**：若各单步具有合法矩阵 $\mathbf{L}_m \in \mathscr{L}(\phi_m)\big|_{U_m}$，则全链满足：
   $$\mathbf{L}_k \cdot \cdots \cdot \mathbf{L}_1 \;\in\; \mathscr{L}(c_k)\big|_{U_1}$$
2. **co-Lip 矩阵保距下限**：若各单步具有合法矩阵 $\mathbf{K}_m \in \mathscr{K}(\phi_m)\big|_{U_m}$，则全链满足：
   $$\mathbf{K}_k \cdot \cdots \cdot \mathbf{K}_1 \;\in\; \mathscr{K}(c_k)\big|_{U_1}$$

> **注（退化界限）**：当边界情形 $k=0$ 时，$c_0 = \mathrm{id}_{\mathcal{X}}$。定义矩阵空复合乘积为单位矩阵 $\mathbf{I}$，其平凡匹配恒等算子的上下界域：$\mathbf{I} \in \mathscr{L}(\mathrm{id}_{\mathcal{X}}) \cap \mathscr{K}(\mathrm{id}_{\mathcal{X}})$。

由于矩阵的不唯一性以及复合途中的信息降维，仅依赖算子链法则连积给出的边界理论上往往是**松散**的。因此，在此纯代数边界约束的基础上，进一步结合由算子内核引起的纯拓扑属性（如 §3 探讨的纤维域截断）进而获取严密的系统级界限，构成了后续（见 §4）控制理论框架的核心要旨。

----
*[IDFS] ⊢ [GLENZLI] ⊢ [Part 01] ⊢ [01-foundations] ⊢ [2d16820dfcc74b9b]*
