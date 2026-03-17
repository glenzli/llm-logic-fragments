## IDFS 的基本性质

### 2.1 拓扑容量

**命题 2.1（IDFS 拓扑容量上界，Topological Capacity Bounds）**：§1.2 定义的像集容量与路由容量具有以下上界：

$$\mathcal{C}_{\mathrm{img}}(\Phi, \epsilon) \;\leq\; \log \mathcal{N}(\epsilon/L,\, \mathcal{X})$$

$$\mathcal{C}_{\mathrm{route}}(\sigma) \;\leq\; \mathcal{D} \log M$$

**证明**：

(1) 设 $\{B(x_i, \epsilon/L)\}_{i=1}^{N}$ 为 $\mathcal{X}$ 的极小 $\epsilon/L$-覆盖（$N = \mathcal{N}(\epsilon/L, \mathcal{X})$）。对任意 $y \in \mathcal{X}$，$\exists\, x_i: d(y, x_i) \leq \epsilon/L$。由 $\Phi \in \mathrm{Lip}_L$：

$$d(\Phi(y), \Phi(x_i)) \;\leq\; L \cdot d(y, x_i) \;\leq\; L \cdot \frac{\epsilon}{L} \;=\; \epsilon$$

故 $\{B(\Phi(x_i), \epsilon)\}_{i=1}^{N}$ 覆盖 $\Phi(\mathcal{X})$，$\mathcal{N}(\epsilon, \Phi(\mathcal{X})) \leq \mathcal{N}(\epsilon/L, \mathcal{X})$。取对数即得。

(2) $|\mathrm{Im}(\sigma)| \leq \sum_{k=1}^{\mathcal{D}} M^k \leq M^{\mathcal{D}}$（$M \geq 2$）。取对数即得。$\square$

> **注（双容量的各自用途）**：像集容量 $\mathcal{C}_{\mathrm{img}}$ 由 $\Phi$ 的 Lipschitz 常数 $L$ 和输入空间 $\mathcal{X}$ 的几何共同决定——$L$ 越大，$\Phi$ 的像集在 $\epsilon$ 分辨率下可能越复杂，但不超过 $\mathcal{X}$ 在 $\epsilon/L$ 分辨率下的复杂度。路由容量 $\mathcal{C}_{\mathrm{route}}$ 则是纯离散量，刻画系统可执行的不同计算路径数。

**推论 2.2（无穷路由坍缩）**：$M \to \infty$（$\mathcal{D}$ 有限）或 $\mathcal{D} \to \infty$（$M$ 有限）时：

$$\mathcal{C}_{\mathrm{img}} \leq \log \mathcal{N}(\epsilon/L, \mathcal{X}) < \infty, \quad \mathcal{C}_{\mathrm{route}} \to \infty$$

无穷条路由路径被压入有界的像集空间。由鸽巢原理，不同路径的像集重叠趋于完全，$\sigma$ 的决策边界无限稠密。系统表现为无压缩字典查表——每条路径仅服务一个（或极少数）输入点。

**推论 2.3（级联系统容量，Cascaded System Capacity）**：由 §1.2.1，$l$-步级联系统 $\mathcal{F}_l = (F, \sigma_l)$ 自身构成 IDFS，其微观深度为 $l \cdot \mathcal{D}$，系统映射 $\Phi^l \in \mathrm{Lip}_{L^l}$。将命题 2.1 施于 $\mathcal{F}_l$ 即得：

$$\mathcal{C}_{\mathrm{img}}(\Phi^l, \epsilon) \;\leq\; \log \mathcal{N}(\epsilon / L^l,\, \mathcal{X})$$

$$\mathcal{C}_{\mathrm{route}}(\sigma_l) \;\leq\; l \cdot \mathcal{D} \cdot \log M$$

> **注（级联的本质功能）**：像集容量上界在 $l \to \infty$ 下呈现单侧有效性：$L < 1$ 时 $\epsilon/L^l \to \infty$，$\mathcal{N} \to 1$，像集容量上界坍缩至零——与命题 2.6 的不动点收敛一致，推论有非平凡意义；$L \geq 1$ 时 $\epsilon/L^l \to 0$，$\mathcal{N} \to \infty$，上界发散，推论空洞。因此，级联不保证扩大像集，但确定性地放大路由组合数。

### 2.2 路由结构

**命题 2.4（组合耗尽与路由满射，Combinatorial Exhaustion and Routing Surjection）**：
设 IDFS $\mathcal{F} = (F, \sigma)$ 在 $\mathcal{X}$ 的某子集 $\mathcal{X}_{sub}$ 上以容差 $\epsilon$ 近似了采样集 $\mathcal{S}$ 定义的图集 $\mathrm{Gr}(\mathcal{S})$。若采样集的度量熵远超单路径的像集复杂度，即产生巨大的**信息阻抗（Information Impedance）**：
$$I_\epsilon(\mathcal{S}) \;\gg\; \log \mathcal{N}(\epsilon/L,\, \mathcal{X})$$

则依据鸽笼原理（Pigeonhole Principle），系统在 $\mathcal{X}_{sub}$ 上被激活的离散独立路径总数 $|\text{Im}(\sigma)|$ 必须具备指数级下界：
$$|\text{Im}(\sigma)| \;\ge\; e^{I_\epsilon(\mathcal{S})} \big/ \mathcal{N}(\epsilon/L,\, \mathcal{X}) \;\to\; \infty$$

当采样集的复杂度逼近系统的**路由容量**天花板（即 $I_\epsilon(\mathcal{S}) \to \mathcal{D} \log M + \log \mathcal{N}(\epsilon/L, \mathcal{X})$）时，路由映射 $\sigma$ 将在 $\mathcal{X}_{sub}$ 上**退化为满射（Surjection）**：即 $\sigma(\mathcal{X}_{sub}) \approx F^{\le \mathcal{D}}$。

**证明**：
系统全局映射 $\Phi \triangleq \sigma(\cdot)(\cdot)$ 在 $\mathcal{X}_{sub}$ 上的像集可按激活路径分解。对每条被激活的路径 $q \in \text{Im}(\sigma)$，$q$ 作为 $\mathcal{X} \to \mathcal{X}$ 的 Lipschitz 映射（常数 $\leq L$），其像集覆盖数 $\mathcal{N}(\epsilon, q(\mathcal{X}_{sub})) \leq \mathcal{N}(\epsilon/L, \mathcal{X})$。由覆盖数的次可加性：
$$\mathcal{N}\bigl(\epsilon, \Phi(\mathcal{X}_{sub})\bigr) \;\le\; |\text{Im}(\sigma)| \cdot \mathcal{N}(\epsilon/L, \mathcal{X})$$
若系统在 $\mathcal{X}_{sub}$ 上实现了对采样集的 $\epsilon$-近似，则 $\Phi(\mathcal{X}_{sub})$ 的覆盖数不低于 $e^{I_\epsilon(\mathcal{S})}$，故：
$$e^{I_\epsilon(\mathcal{S})} \;\le\; |\text{Im}(\sigma)| \cdot \mathcal{N}(\epsilon/L, \mathcal{X}) \quad \Longrightarrow \quad |\text{Im}(\sigma)| \;\ge\; e^{I_\epsilon(\mathcal{S})} / \mathcal{N}(\epsilon/L, \mathcal{X})$$
当 $I_\epsilon(\mathcal{S}) \to \mathcal{D} \log M + \log \mathcal{N}(\epsilon/L, \mathcal{X})$ 时，$|\text{Im}(\sigma)| \to M^\mathcal{D}$，路由映射被迫耗尽所有离散路径组合，构成满射。$\square$

> **注（路由分支的几何功能）**：从纯组合视角看，$|\mathrm{Im}(\sigma)|$ 的量纲仅仅是"可区分路径的种类数"。但从几何视角看（详见 §2.4），每一次路由切换——$\sigma$ 在相邻输入处选定不同的 $f$-链——意味着系统在该局部部署了一组不同的映射行为。因此 $\mathrm{Im}(\sigma)$ 不仅是组合意义上的"标签多样性"，更是几何意义上的**局部映射行为库的容量**。


**定义（路由混叠，Routing Aliasing）**：设单步系统 $\mathcal{F}$ 在子集 $\mathcal{X}_{sub} \subseteq \mathcal{X}$ 上运作。称在 $\mathcal{X}_{sub}$ 上存在第 $l$ 阶**路由混叠**，若存在 $x_1, x_2 \in \mathcal{X}_{sub}$ 使得模型在 $x_2$ 处的**单步微观路由决策**与从 $x_1$ 出发的 **$l$ 步宏观计算程序**完全等同：

$$\sigma(x_2) \;=\; \sigma_l(x_1) \;\triangleq\; \sigma\bigl(\Phi^{l-1}(x_1)\bigr) \circ \cdots \circ \sigma(x_1)$$

即系统用**同一条微观链**同时服务了一次单步拟合任务（在 $x_2$ 处）和一次多步复合拟合任务（从 $x_1$ 出发），形成计算程序层面的不可区分简并。路由混叠可由多种机制引起：组合耗尽（见下方推论）、$\sigma$ 的参数化约束、正则化、或有限精度表示等。

> **注（$\mathcal{F}^l \to \mathcal{F}$ 的计算程序等效）**：路由混叠的本质是级联系统 $\mathcal{F}^l$ 到单步系统 $\mathcal{F}$ 在 $\mathcal{X}_{sub}$ 上的**计算程序等效**。对每个触发混叠的对 $(x_1, x_2)$，$\mathcal{F}^l$ 从 $x_1$ 出发展开的完整 $l$-步宏观 $f$-链 $\sigma_l(x_1)$，恰好就是 $\mathcal{F}$ 在 $x_2$ 处单步调用的微观链 $\sigma(x_2)$。

**推论 2.5（组合耗尽下的路由混叠必然性，Necessity of Routing Aliasing under Combinatorial Exhaustion）**：
在存在组合耗尽（$\sigma$ 退化为对 $F^{\le \mathcal{D}}$ 的满射）的复杂区域 $\mathcal{X}_{sub}$ 中，路由混叠**必然发生**。具体而言，对于任意一点 $x_1 \in \mathcal{X}_{sub}$，若其 $l$ 步宏观前向轨道保持在满射区域内（即 $\Phi^j(x_1) \in \mathcal{X}_{sub}$，$j = 0, \ldots, l-1$），且所诱导的复合微观链 $\sigma_l(x_1)$ 的总长度未超出微观深度上限（$|\sigma_l(x_1)| \le \mathcal{D}$），则必然存在 $x_2 \in \mathcal{X}_{sub}$ 使得 $\sigma(x_2) = \sigma_l(x_1)$。

**证明**：

1. $\forall\, j \in \{0, \ldots, l-1\}$：$\Phi^j(x_1) \in \mathcal{X}_{sub}$ $\Rightarrow$ $\sigma(\Phi^j(x_1)) \in \mathrm{Im}(\sigma|_{\mathcal{X}_{sub}})$。
2. $\sigma_l(x_1) = \sigma(\Phi^{l-1}(x_1)) \circ \cdots \circ \sigma(x_1)$，各因子均取自 $F^{\le \mathcal{D}}$，且 $|\sigma_l(x_1)| \leq \mathcal{D}$，故 $\sigma_l(x_1) \in F^{\le \mathcal{D}}$。
3. 由 $\sigma|_{\mathcal{X}_{sub}}$ 对 $F^{\le \mathcal{D}}$ 的满射性：$\exists\, x_2 \in \mathcal{X}_{sub}:\; \sigma(x_2) = \sigma_l(x_1)$。$\square$


---

### 2.3 迭代动力学与决策边界

本节刻画级联系统 $\mathcal{F}^l$ 的动力学稳定性——$\Phi$ 在多步迭代下的扰动传播行为，以及 $\sigma$-决策边界处的分辨率极限。

**命题 2.6（不动点收敛，Fixed-Point Convergence）**：若 $\Phi \in \mathrm{Lip}_L(\mathcal{X})$（全局）且 $L < 1$，$(\mathcal{X}, d)$ 完备，则 $\Phi$ 存在唯一不动点 $x^* = \Phi(x^*)$，$\Phi$-轨道从任意初始点收敛：$\hat{h}_l \to x^*$。

**证明**：$L < 1$ 时 $\Phi$ 是完备度量空间 $(\mathcal{X}, d)$ 上的压缩映射，由 **Banach 压缩映射定理**直接得不动点存在唯一性及轨道收敛。$\square$

**命题 2.7（决策边界的路由分辨率极限，Routing Resolution Limit at Decision Boundaries）**：设 $\Phi \in \mathrm{Lip}_L(\mathcal{X})$。若两状态 $a, b \in \mathcal{X}$ 被 $\sigma$ 分派至不同路径，产生宏观偏离：

$$\Delta \;\triangleq\; d\bigl(\Phi(a),\, \Phi(b)\bigr) \;>\; 0$$

则输入间距满足下界：

$$d(a, b) \;\geq\; \frac{\Delta}{L}$$

**证明**：

1. 由 $\Phi \in \mathrm{Lip}_L$：$\Delta = d(\Phi(a), \Phi(b)) \leq L \cdot d(a,b)$。
2. 移项：$d(a,b) \geq \Delta/L$。
3. 边界处局部扩张率 $L_j = \Delta / d(a,b)$。当 $d(a,b) \to \Delta/L$ 时，$L_j \to L$。若 $d(a,b) < \Delta/L$，则 $L_j > L$，矛盾。$\square$

> **注（对分辨率死锁的结构性理解）**：这一极限揭示了一个深远的结构律：完全并非测度空间强行阻止状态靠近，而是当两点距离 $d(a,b)$ 小于该临界分辨率阈值 $\Delta/L$ 时，路由引擎 $\sigma$ 在数学上被绝对剥夺了将它们"劈开"并赋予 $\Delta$ 偏离度行为的能力。换言之，系统的全局稳态（有限 $L$）为 $\sigma$ 的离散切割精度设定了**不可被超越的物理决断极限**。


**命题 2.8（扰动的长链衰减，Long-chain Decay of Perturbations）**：在级联系统 $\mathcal{F}^l$ 中，设第 $j$ 步的路径 Lipschitz 常数为 $L_j$（$j = 1, \ldots, l$）。设第 $k-1$ 步存在任意来源的**状态扰动** $\Delta_{k-1} \triangleq d(\hat{h}_{k-1}^{(A)}, \hat{h}_{k-1}^{(B)}) > 0$ ——无论其来自原始输入差异还是前 $k-1$ 步的近似误差积累——若**尾部乘积** $\Theta_{k,l} \to 0$（$l \to \infty$，即收缩步主导），则：

$$d\!\bigl(\hat{h}_l^{(A)},\, \hat{h}_l^{(B)}\bigr) \;\leq\; \Theta_{k,l} \;\cdot\; \Delta_{k-1} \;\to\; 0$$

无论 $\Delta_{k-1}$ 多大，迭代终态均收敛——$\mathcal{F}^l$ **抹除第 $k-1$ 步之前的一切扰动**，无论扰动来自输入差异、近似误差还是任何其他来源，均被尾部收缩机制彻底压制至零。

> **注（收缩与扩张的非对称性）**：收缩路径可无限延续（轨线越拉越近，不涉及任何发散），取 $l \to \infty$ 的极限是合法的（见 §1.2.1 注）。扩张路径则不具备此保证——这一非对称性是 IDFS 动力学中收缩与扩张行为的根本差异。

**特例（输入差异）**：取 $k = 1$，$\Delta_0 = d(x_A, x_B)$，则退化为对原始输入差异的衰减：$d(\hat{h}_l^{(A)}, \hat{h}_l^{(B)}) \leq \Theta_{1,l} \cdot d(x_A, x_B)$。

定义**有效区分深度** $l^\dagger = \max\{l \mid \Theta_{k,l} \geq \theta\}$（$\theta \in (0,1)$ 为可区分阈值），超过此深度后任意扰动均衰减至不可区分范围内。

**证明**：对局部 Lipschitz 条件连续应用，从第 $k$ 步截断：
$$d(\hat{h}_l^{(A)}, \hat{h}_l^{(B)}) \leq \Theta_{k,l} \cdot d(\hat{h}_{k-1}^{(A)}, \hat{h}_{k-1}^{(B)}) = \Theta_{k,l} \cdot \Delta_{k-1}$$
$\Delta_{k-1}$ 为有限正数，尾部乘积 $\Theta_{k,l} \to 0$ 时右端趋零。$\square$

> **注（对偶结构）**：$\Theta_{1,l}$（$l$ 步迭代的路径乘积，即 $\prod_{j=1}^l L_j$）与 $\Lambda_l$ 控制系统的两个方向：$\Lambda_l$ 衡量**误差的累积放大**（单步近似误差如何沿迭代传播），$\Theta_{1,l}$ 衡量**输入分离的保持程度**（不同输入的输出能否区分）。收缩机制（$L_j < 1$）同时压低 $\Theta_{1,l}$（输出坍缩，输入可区分性消失）和 $\Lambda_l$（抑制误差累积）；扩张机制（$L_j > 1$）则反之。两者的平衡决定了 $\mathcal{F}^l$ 的迭代稳定性。

**命题 2.9（扰动的长链扩张，Long-chain Expansion of Perturbations）**：在级联系统 $\mathcal{F}^l$ 中，设从第 $k$ 步起至有限的第 $l$ 步，每一步 $j = k, \ldots, l$ 均存在**扩张下界** $c_j \geq 1$，使得：

$$d\!\bigl(\hat{h}_j^{(A)},\, \hat{h}_j^{(B)}\bigr) \;\geq\; c_j \cdot d\!\bigl(\hat{h}_{j-1}^{(A)},\, \hat{h}_{j-1}^{(B)}\bigr)$$

定义**有限尾部扰动放大系数（下界）**：

$$\Pi_{k,l}^{-} \;\triangleq\; \prod_{j=k}^{l} c_j$$

设第 $k-1$ 步存在任意来源的**状态扰动** $\Delta_{k-1} \triangleq d(\hat{h}_{k-1}^{(A)}, \hat{h}_{k-1}^{(B)}) > 0$（无论来自初始差异或误差积累），则局部有限步内的终态距离必然被严格放大：

$$d\!\bigl(\hat{h}_l^{(A)},\, \hat{h}_l^{(B)}\bigr) \;\geq\; \Pi_{k,l}^{-} \cdot \Delta_{k-1}$$

**特例（输入差异）**：取 $k = 1$，$\Delta_0 = d(x_A, x_B)$，则退化为对原始输入差异的有限步放大：$d(\hat{h}_l^{(A)}, \hat{h}_l^{(B)}) \geq \Pi_{1,l}^{-} \cdot d(x_A, x_B)$。



### 2.4 $f$-链正交性

§2.1 的路由容量 $\mathcal{C}_{route} \leq \mathcal{D}\log M$ 量化了系统可区分路径的**代数上界**。但这个对数量并未揭示其几何本质——在有限维度量空间 $(\mathcal{X}, d)$ 上，为什么系统的有效表征容量能远超 $\mathcal{X}$ 自身的拓扑维度？本节从 $F$-链空间的正交性出发，为路由容量赋予几何解释。

核心洞察是：系统的表征能力不由 $\mathcal{X}$ 中的单个状态点决定，而由 $\sigma$ 从函数集 $F$ 中选出的**组合路径**（$f$-链）决定。正交性应在路径空间 $F^*$ 上定义，而非在输入空间 $\mathcal{X}$ 上定义。

#### 定义（结构正交，Operator-Support Orthogonality）

设两条 $f$-链 $q_A = f_{a_l} \circ \cdots \circ f_{a_1} \in F^*$ 和 $q_B = f_{b_l} \circ \cdots \circ f_{b_1} \in F^*$。记两者的 **算子支撑集**（Operator Support）分别为 $\mathrm{supp}(q_A) = \{f_{a_1}, \ldots, f_{a_l}\}$，$\mathrm{supp}(q_B) = \{f_{b_1}, \ldots, f_{b_l}\}$。

若 $\mathrm{supp}(q_A) \cap \mathrm{supp}(q_B) = \varnothing$——即两条链在演化过程中没有调用 $F$ 中任何相同的算子——则称 $q_A$ 和 $q_B$ **结构正交**。

**命题 2.10（结构正交容量，Structural Orthogonality Capacity）**：设 $|F| = M$。$N$ 条两两结构正交的 $f$-链 $q_1, \ldots, q_N$ 满足：

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

---

### 2.4b 方向容量与路径跨度的必然分化

§2.4 的正交性分析刻画了 $f$-链在**离散组合空间** $F^*$ 上的独立性。本节转向连续几何层面，揭示有限维度量空间 $(\mathcal{X}, d)$ 对系统行为多样性施加的**方向容量约束**——当目标集的变分需求足够丰富时，系统的路径 Lipschitz 跨度 $\kappa_\Phi$（§1.2 定义）不可能保持均匀。

**定义（变分模式，Variation Pattern）**：设映射 $r: \mathcal{X} \to \mathcal{X}$ 在点 $x$ 处可微（或局部 Lipschitz）。$r$ 在 $x$ 处的**变分模式**是一个质性描述：$r$ 沿哪些方向扩张（$\|Dr(x) \cdot \mathbf{v}\| > \|\mathbf{v}\|$）、沿哪些方向收缩（$\|Dr(x) \cdot \mathbf{v}\| < \|\mathbf{v}\|$），以及各方向的拉伸/压缩比率。在$d$ 维空间中，变分模式由**至多 $d$ 个奇异值**刻画（$Dr$ 的奇异值分解）。

**命题 2.10b（方向容量耗尽与跨度分化，Directional Capacity Exhaustion and Span Differentiation）**：设 IDFS $\Phi \in \mathrm{Lip}_L(\mathcal{X})$，$\dim(\mathcal{X}) = d$，$|F| = M$。设目标集 $R$ 包含 $K$ 个目标，要求系统在各自采样域上以容差 $\varepsilon$ 逼近，且这些目标的**变分模式两两不同**（需要在不同方向上展现不同的拉伸/压缩组合）。

若 $K > M \cdot d$，则系统**不可能以 $\kappa_\Phi \approx 1$（即路径 Lipschitz 常数近似均匀）的方式同时逼近所有目标**。具体地：

$$\kappa_\Phi \;\geq\; \frac{\max_k L_{\text{eff},k}}{\min_k L_{\text{eff},k}}$$

其中 $L_{\text{eff},k}$ 是系统在逼近第 $k$ 个目标时的有效路径 Lipschitz 常数。当目标的变分模式差异足够大时，此比值 $\gg 1$。

**证明**：

系统的每个基函数 $f_i \in F$ 在 $d$ 维空间中有 $d$ 个独立的奇异方向。通过选择不同的输入状态（中间态 $h$），$f_i$ 可以在不同点处展现不同的局部行为，但在**同一点**处，$f_i$ 的行为由其 $d$ 个奇异值完全确定。

若系统要以 $\kappa_\Phi \approx 1$（所有路径 $L_q$ 近似相等）逼近 $K$ 个变分模式互不相同的目标，则系统在各目标域上的局部行为必须在**同一 $L$ 值**下容纳 $K$ 种不同的方向组合。每个基函数在单点处提供 $d$ 个方向"槽位"——沿不同方向可独立选择拉伸或压缩。$M$ 个基函数在至多 $M$ 个局部域上共提供 $M \cdot d$ 个方向槽位。

当 $K > M \cdot d$ 时，由鸽巢原理，至少存在两个目标 $r_a, r_b$ 共享同一基函数在同一方向上运作，但需要不同的拉伸率。系统被迫为它们提供不同的路径 $L_q$——或者通过路由到不同基函数（路径 Lipschitz 分化），或者在相同基函数上接受拟合残差。前者导致 $\kappa_\Phi > 1$，后者导致 $\varepsilon$ 增大。

当目标的变分模式差异足够大（$r_a$ 需强扩张、$r_b$ 需强收缩），路径 Lipschitz 常数被迫以正比于变分比值的因子分化：$\kappa_\Phi \gtrsim \max_k L_{\text{eff},k} / \min_k L_{\text{eff},k}$。$\square$

> **注（$Md$ 的物理含义）**：$M \cdot d$ 是系统的**总方向容量**——$M$ 个基函数各提供 $d$ 个独立行为方向。对于现代大规模 IDFS（如大语言模型），$M$ 和 $d$ 都很大（$M \sim 10^3$–$10^5$，$d \sim 10^3$–$10^4$），总方向容量 $Md \sim 10^6$–$10^9$。但自然语言的变分模式数量可能远超此值——这正是系统必须发展出高度非均匀路径行为（$\kappa_\Phi \gg 1$）的内在驱动力。

> **注（与 §7 的连接）**：本命题仅建立 $\kappa_\Phi \gg 1$ 的必然性，不涉及其代价。代价分析见 §7：$\kappa_\Phi \gg 1$ 意味着某些路径上 $L_j \gg 1$，这些路径上 CAC 递推棘轮（推论 7.2）加速运转，$\Theta_{1,l} \to 0$ 更快——系统在高变分路径上被迫进入饱和与致盲。方向容量耗尽是三元困境（命题 7.12）的结构性根源。


### 2.5 计算有界性与非图灵完备性

上述性质刻画了 IDFS 的拓扑容量、路由结构和动力学行为。本节确立 IDFS 的**计算论定位**——它在计算能力层级中处于何处。

**定理 2.11（IDFS 的非图灵完备性）**：IDFS 不具备图灵完备性。

**证明**：IDFS $\mathcal{F} = (F, \sigma)$ 的单步执行 $\Phi(x) = \sigma(x)(x)$ 中，$\sigma(x)$ 是 $F^*$ 中的一条有限长链 $q = f_{i_k} \circ \cdots \circ f_{i_1}$（$k \le \mathcal{D}$）。因此 $\Phi$ 的每次求值在至多 $\mathcal{D}$ 步内终止。级联系统 $\mathcal{F}^l$ 的总有效链深 $l \cdot \mathcal{D}$ 仍然有限。

图灵完备系统能够表达**不终止计算**（停机问题的不可判定性即依赖于此）。由于 IDFS 的一切计算在有限步内终止，它无法表达不终止计算，因此不具备图灵完备性。$\square$

> **注（非图灵完备性的根源）**：非图灵完备性源于两条基本约束的联合：(1) $F$ 有限（$|F| = M$），限制了单步计算的多样性；(2) $f$-链深度有界（$k \le \mathcal{D}$），限制了计算的时间展开。二者共同将 IDFS 的计算能力封死在有限自动机与图灵机之间——系统能执行的不同计算总数上界为 $\sum_{k=0}^{\mathcal{D}} M^k$，这是一个有限数。
