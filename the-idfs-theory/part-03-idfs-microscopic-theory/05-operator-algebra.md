## F 的内部结构

### 算子可分解性与跨深度混叠


**定义（算子可分解性，Operator Factorizability）**：设 $f, g_1, \ldots, g_k \in F$（$k \geq 2$）。称 $f$ 在子集 $U \subseteq \mathcal{X}$ 上 **$(g_1, \ldots, g_k)$-可分解**，若：

$$\forall\, x \in U:\quad f(x) \;=\; (g_k \circ \cdots \circ g_1)(x)$$

即 $f$ 在 $U$ 上的行为与 $g_1, \ldots, g_k$ 的 $k$-步复合完全一致。注意：这是 $F$ **内部**的代数性质——$f$ 和 $g_1, \ldots, g_k$ 均为基函数库 $F$ 的成员，$k$ 是 $F$ 内的复合步数，与级联系统 $\mathcal{F}^l$ 的宏观链深 $l$ 无关。

**定义（不可约基与算子冗余度，Irreducible Basis and Operator Redundancy）**：称 $F$ 为**不可约的**，若不存在 $f \in F$ 在任何非空开子集 $U \subseteq \mathcal{X}$ 上可分解为 $F$ 中其他成员的复合。$F$ 的**不可约核** $F_{\min} \subseteq F$ 是删除所有在某些子集上可分解的成员后剩下的最大不可约子集。差值 $M - |F_{\min}|$ 度量了 $F$ 的**算子冗余度**。

算子可分解性在**微观层面**意味着 $F^{\leq \mathcal{D}}$ 中存在冗余：$f$ 和 $g_k \circ \cdots \circ g_1$ 是两条不同的 $f$-链，在 $U$ 上给出相同输出。但这并不意味着系统"随机选择"其中之一——$\sigma$ 是**确定性函数**，对每个 $x$ 恰好选择一条链。可分解性的意义在于：$\sigma$ 所做的选择有一个**隐藏的等效替代**，系统的实际路由决策掩盖了这种冗余。

真正的结构性后果出现在**宏观层面**——算子冗余引发跨深度等效：

**命题 2.6（算子冗余引致的跨深度混叠，Cross-Depth Aliasing from Operator Redundancy）**：设 $f$ 在 $U$ 上 $(g_1, \ldots, g_k)$-可分解。记中间态 $h_0 = x$，$h_i = g_i(h_{i-1})$（$i = 1, \ldots, k$）。若级联系统 $\mathcal{F}$ 的路由映射 $\sigma$ 满足以下**中间态配合条件**：

$$\sigma(h_0) = g_1, \quad \sigma(h_1) = g_2, \quad \ldots, \quad \sigma(h_{k-1}) = g_k$$

则级联系统 $\mathcal{F}^k$ 从 $x$ 出发的 $k$-步宏观输出与 $\mathcal{F}^1$ 使用 $\sigma(x) = f$ 的单步输出一致：

$$\Phi^k(x) \;=\; g_k(\cdots g_1(x)\cdots) \;=\; f(x) \;=\; \Phi(x)\big|_{\sigma(x)=f}$$

即名义链深 1 的计算可展开为名义链深 $k$ 的计算，产生**跨深度等效**。

**证明**：

1. $\mathcal{F}^k$ 执行序列：$\hat{h}_0 = x$；由中间态配合 $\sigma(h_0) = g_1$，$\hat{h}_1 = g_1(x) = h_1$；由 $\sigma(h_1) = g_2$，$\hat{h}_2 = g_2(h_1) = h_2$；以此类推至 $\hat{h}_k = g_k(\cdots g_1(x)\cdots) = h_k$。
2. 由可分解性：$h_k = f(x)$（$x \in U$）。
3. $\mathcal{F}^1$ 使用 $\sigma(x) = f$：$\Phi(x) = f(x) = h_k$。两者一致。$\square$

> **注（中间态配合非自动）**：跨深度等效**不是**可分解性的自动后果。它要求 $\sigma$ 恰好在每个中间态 $h_i$ 处选择 $g_{i+1}$——这是对 $\sigma$ 的**全局路由结构**的要求，不由 $f$ 在 $U$ 上的局部性质保证。在路由满射（命题 2.4）或高度组合耗尽下，配合条件更易满足——$\sigma$ 被迫覆盖 $F^{\leq \mathcal{D}}$ 中的大量链，增加了恰好命中 $g_1, g_2, \ldots$ 的概率。

> **注（与路由混叠的对偶和联合）**：路由混叠（推论 2.5）与算子冗余混叠方向相反、机制不同：路由混叠将 $\mathcal{F}^l$ **折叠**为 $\mathcal{F}$（宏观→微观，组合耗尽驱动）；算子冗余将 $\mathcal{F}$ **展开**为 $\mathcal{F}^k$（微观→宏观，$F$ 的代数结构驱动）。两者串联产生 $\mathcal{F}^l \approx \mathcal{F}^{l'}$ 的**跨深度等效网络**——系统的有效计算深度不再由名义链深唯一确定。

> **注（$F_{\min}$ 的实际意义）**：实际大规模 IDFS 中，$F$ 通常远非不可约——训练过程倾向于让某些基函数学习到其他基函数的复合模式（"自组织宏指令"）。这并非缺陷，而是系统对频繁子链的**压缩编码**：将常用的 $k$-步复合预编译为单步算子，降低有效链深从而改善 CAC 误差累积。代价是混叠倍增——系统在更多子域上具有多种等效路径，路由 $\sigma$ 的选择自由度被冗余掩盖。

---

### part-07-epsilon-prisoner/00-placeholder.md569XZilms链正交性

### 2.4 $f$-链正交性

§2.1 的路由容量 $\mathcal{C}_{route} \leq \mathcal{D}\log M$ 量化了系统可区分路径的**代数上界**。但这个对数量并未揭示其几何本质——在有限维度量空间 $(\mathcal{X}, d)$ 上，为什么系统的有效表征容量能远超 $\mathcal{X}$ 自身的拓扑维度？本节从 $F$-链空间的正交性出发，为路由容量赋予几何解释。

核心洞察是：系统的表征能力不由 $\mathcal{X}$ 中的单个状态点决定，而由 $\sigma$ 从函数集 $F$ 中选出的**组合路径**（$f$-链）决定。正交性应在路径空间 $F^*$ 上定义，而非在输入空间 $\mathcal{X}$ 上定义。

#### 定义（结构正交，Operator-Support Orthogonality）

设两条 $f$-链 $q_A = f_{a_l} \circ \cdots \circ f_{a_1} \in F^*$ 和 $q_B = f_{b_l} \circ \cdots \circ f_{b_1} \in F^*$。记两者的 **算子支撑集**（Operator Support）分别为 $\mathrm{supp}(q_A) = \{f_{a_1}, \ldots, f_{a_l}\}$，$\mathrm{supp}(q_B) = \{f_{b_1}, \ldots, f_{b_l}\}$。

若 $\mathrm{supp}(q_A) \cap \mathrm{supp}(q_B) = \varnothing$——即两条链在演化过程中没有调用 $F$ 中任何相同的算子——则称 $q_A$ 和 $q_B$ **结构正交**。

**命题 2.11（结构正交容量，Structural Orthogonality Capacity）**：设 $|F| = M$。$N$ 条两两结构正交的 $f$-链 $q_1, \ldots, q_N$ 满足：

$$\sum_{i=1}^{N} |\mathrm{supp}(q_i)| \;\leq\; M$$

**证明**：各 $\mathrm{supp}(q_i)$ 两两不交，故 $\sum_i |\mathrm{supp}(q_i)| = \bigl|\bigcup_i \mathrm{supp}(q_i)\bigr| \leq |F| = M$。$\square$

由此直接得到：

- **等长注入链**（链长 $l$，各链无重复算子，$|\mathrm{supp}(q_i)| = l$）：$N \leq \lfloor M/l \rfloor$。将 $F$ 均分为 $\lfloor M/l \rfloor$ 组即可构造达到上界的配置。
- **绝对上界**：$N \leq M$（当每条链仅使用一个算子时达到）。

> **注（路径空间的容量优势）**：在有限维度量空间 $\mathcal{X}$ 中，$\dim(\mathcal{X})$ 约束了可独立嵌入的方向数。但在 $F^*$ 中，即使要求最严格的结构正交，仍有 $\lfloor M/\mathcal{D} \rfloor$ 条互不干扰的最大深度链，总容量最多可达 $M$ 条独立链。若放松到允许部分算子共享（见下方像集正交），有效容量更大。系统的表征空间是组合路径空间 $F^*$，其有效维度可远超 $\dim(\mathcal{X})$。

> **注（$F^*$ 与 $\mathrm{Im}(\sigma)$ 的关系）**：结构正交是 $F^*$ 上的纯代数性质，不依赖 $\sigma$；像集正交则由 $\sigma$ 的路由划分决定。§2.1 的路由容量上界 $|\mathrm{Im}(\sigma)| \leq M^{\mathcal{D}}$ 约束了被激活链的总数；正交性分析进一步揭示这些链中有多少是**真正独立的**（像集正交的），有多少是**冗余的**（像集重叠的）。

#### 定义（像集正交，Image Orthogonality）

在 IDFS $(F, \sigma)$ 中，$\sigma$ 将输入空间 $\mathcal{X}$ 划分为不同的路由域，每条被激活的 $f$-链 $q \in \mathrm{Im}(\sigma)$ 仅在其路由域 $\sigma^{-1}(q) \subseteq \mathcal{X}$ 上实际运算。即使两条链共享算子，只要它们在各自路由域上的输出不重叠，其映射行为即互不耦合。

设 $q \in \mathrm{Im}(\sigma)$，定义其**有效像集**为：

$$\mathrm{Im}_\sigma(q) \;\triangleq\; q(\sigma^{-1}(q))$$

其中 $\sigma^{-1}(q) = \{x \in \mathcal{X} : \sigma(x) = q\}$ 为 $q$ 在 $\sigma$ 下的**原像集**（preimage），即 $\sigma$ 将输入路由至 $q$ 的全体输入点。

两条 $f$-链 $q_A, q_B \in \mathrm{Im}(\sigma)$ **像集正交**，若：

$$\mathrm{Im}_\sigma(q_A) \cap \mathrm{Im}_\sigma(q_B) \;=\; \varnothing$$

即两条链在各自路由域上的值域完全分离。由 $\Phi \in \mathrm{Lip}_L$，$\Phi$ 在 $\mathrm{Im}_\sigma(q_B)$ 附近的局部形变被 Lipschitz 连续性限制在该区域的邻域内，不会传播到 $\mathrm{Im}_\sigma(q_A)$ 所在的区域。

> **注（两种正交的关系）**：结构正交是纯代数条件（算子支撑集不交），不涉及 $\sigma$；像集正交是几何条件（有效像集分离），由 $\sigma$ 的路由划分决定。两者相互独立。
