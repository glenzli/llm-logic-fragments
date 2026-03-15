## IDFS 的基本性质

### 2.1 拓扑容量

**引理 2.1（IDFS 拓扑容量上界，Topological Capacity Bounds）**：§1.2 定义的像集容量与路由容量具有以下上界：

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

### 2.2 路由结构

**命题 2.3（组合耗尽与路由满射，Combinatorial Exhaustion and Routing Surjection）**：
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

> **注（路由分支的几何功能）**：从纯组合视角看，$|\mathrm{Im}(\sigma)|$ 的量纲仅仅是"基函数索引的种类数"。但从 IDFS 的变分几何结构看（§2.4），每一次路由切换 $\sigma(x) = f_i \to f_j$，实质上意味着系统在该局部部署了一组全新的变分响应特征——切换前后的 $f$-链在同一输入邻域上的变分响应幅度 $\delta q(x, x')$ 与变分耦合结构一般完全不同，即路由切换跨越了变分正交性的断裂面。因此 $\mathrm{Im}(\sigma)$ 不仅是组合意义上的"标签多样性"，更是几何意义上的**局部变分基底集合库的容量**。该几何角色的理论后果将在 §4.2（CPI 定理）中被严格量化。


**定义（路由混叠，Routing Aliasing）**：设单步系统 $\mathcal{F}$ 在子集 $\mathcal{X}_{sub} \subseteq \mathcal{X}$ 上运作。称在 $\mathcal{X}_{sub}$ 上存在第 $l$ 阶**路由混叠**，若存在 $x_1, x_2 \in \mathcal{X}_{sub}$ 使得模型在 $x_2$ 处的**单步微观路由决策**与从 $x_1$ 出发的 **$l$ 步宏观计算程序**完全等同：

$$\sigma(x_2) \;=\; \sigma_l(x_1) \;\triangleq\; \sigma\bigl(\Phi^{l-1}(x_1)\bigr) \circ \cdots \circ \sigma(x_1)$$

即系统用**同一条微观链**同时服务了一次单步拟合任务（在 $x_2$ 处）和一次多步复合拟合任务（从 $x_1$ 出发），形成计算程序层面的不可区分简并。路由混叠可由多种机制引起：组合耗尽（见下方推论）、$\sigma$ 的参数化约束、正则化、或有限精度表示等。

**推论 2.4（组合耗尽下的路由混叠必然性，Necessity of Routing Aliasing under Combinatorial Exhaustion）**：
在存在组合耗尽（$\sigma$ 退化为对 $F^{\le \mathcal{D}}$ 的满射）的复杂区域 $\mathcal{X}_{sub}$ 中，路由混叠**必然发生**。具体而言，对于任意一点 $x_1 \in \mathcal{X}_{sub}$，若其 $l$ 步宏观前向轨道保持在满射区域内（即 $\Phi^j(x_1) \in \mathcal{X}_{sub}$，$j = 0, \ldots, l-1$），且所诱导的复合微观链 $\sigma_l(x_1)$ 的总长度未超出微观深度上限（$|\sigma_l(x_1)| \le \mathcal{D}$），则必然存在 $x_2 \in \mathcal{X}_{sub}$ 使得 $\sigma(x_2) = \sigma_l(x_1)$。

**证明**：

1. $\forall\, j \in \{0, \ldots, l-1\}$：$\Phi^j(x_1) \in \mathcal{X}_{sub}$ $\Rightarrow$ $\sigma(\Phi^j(x_1)) \in \mathrm{Im}(\sigma|_{\mathcal{X}_{sub}})$。
2. $\sigma_l(x_1) = \sigma(\Phi^{l-1}(x_1)) \circ \cdots \circ \sigma(x_1)$，各因子均取自 $F^{\le \mathcal{D}}$，且 $|\sigma_l(x_1)| \leq \mathcal{D}$，故 $\sigma_l(x_1) \in F^{\le \mathcal{D}}$。
3. 由 $\sigma|_{\mathcal{X}_{sub}}$ 对 $F^{\le \mathcal{D}}$ 的满射性：$\exists\, x_2 \in \mathcal{X}_{sub}:\; \sigma(x_2) = \sigma_l(x_1)$。$\square$


---

### 2.3 迭代动力学与决策边界

> **注**：以下命题刻画 IDFS 迭代映射 $\Phi$ 本身的动力学稳定性，不直接依赖 CAC 误差上界中的 $\varepsilon_{i_j}$、$\delta_j$ 结构；而是关于 Lipschitz 算子在长链迭代下的扰动传播行为及 $\sigma$-决策边界的不连续性质。

**命题 2.5（不动点收敛，Fixed-Point Convergence）**：若 $\Phi \in \mathrm{Lip}_L(\mathcal{X})$（全局）且 $L < 1$，$(\mathcal{X}, d)$ 完备，则 $\Phi$ 存在唯一不动点 $x^* = \Phi(x^*)$，$\Phi$-轨道从任意初始点收敛：$\hat{h}_l \to x^*$。

**证明**：$L < 1$ 时 $\Phi$ 是完备度量空间 $(\mathcal{X}, d)$ 上的压缩映射，由 **Banach 压缩映射定理**直接得不动点存在唯一性及轨道收敛。$\square$

**命题 2.6（扰动的长链衰减，Long-chain Decay of Perturbations）**：设 f-链步骤 $1, \ldots, l$ 的路径局部 Lipschitz 为 $L_j$。设第 $k-1$ 步存在任意来源的**状态扰动** $\Delta_{k-1} \triangleq d(\hat{h}_{k-1}^{(A)}, \hat{h}_{k-1}^{(B)}) > 0$ ——无论其来自原始输入差异还是前 $k-1$ 步的近似误差积累——若**尾部乘积** $\Theta_{k,l} \to 0$（$l \to \infty$，即收缩步主导），则：

$$d\!\bigl(\hat{h}_l^{(A)},\, \hat{h}_l^{(B)}\bigr) \;\leq\; \Theta_{k,l} \;\cdot\; \Delta_{k-1} \;\to\; 0$$

无论 $\Delta_{k-1}$ 多大，f-chain 终态均收敛——IDFS **抹除第 $k-1$ 步之前的一切扰动**，无论扰动来自输入差异、近似误差还是任何其他来源，均被尾部收缩机制彻底压制至零。

> **注（收缩极限 $l \to \infty$ 的合法性）**：与命题 2.7 中扩张链路因命题 2.9（路由分辨率极限）而被**强制截断**（$\sigma$ 无法在极近间距下维持跨边界选择，轨线被迫合并）不同，收缩路径不触发任何物理截断机制——系统只是将轨线越拉越近，不涉及分辨率死锁、路径合并或容量瓶颈。因此，在收缩主导的情形下，取 $l \to \infty$ 的数学极限是**物理上完全合法的**。这一非对称性是 IDFS 动力学中收缩与扩张行为的根本差异。

**特例（输入差异）**：取 $k = 1$，$\Delta_0 = d(x_A, x_B)$，则退化为对原始输入差异的衰减：$d(\hat{h}_l^{(A)}, \hat{h}_l^{(B)}) \leq \Theta_{1,l} \cdot d(x_A, x_B)$。

定义**有效区分深度** $l^\dagger = \max\{l \mid \Theta_{k,l} \geq \theta\}$（$\theta \in (0,1)$ 为可区分阈值），超过此深度后任意扰动均衰减至不可区分范围内。

**证明**：对局部 Lipschitz 条件连续应用，从第 $k$ 步截断：
$$d(\hat{h}_l^{(A)}, \hat{h}_l^{(B)}) \leq \Theta_{k,l} \cdot d(\hat{h}_{k-1}^{(A)}, \hat{h}_{k-1}^{(B)}) = \Theta_{k,l} \cdot \Delta_{k-1}$$
$\Delta_{k-1}$ 为有限正数，尾部乘积 $\Theta_{k,l} \to 0$ 时右端趋零。$\square$

> **注（对偶结构）**：$\Theta_{1,l}$（整条链的路径乘积，即 $\prod_{j=1}^l L_j$）与 $\Lambda_l$ 控制系统的两个方向：$\Lambda_l$ 衡量**误差的累积放大**（单步近似误差如何沿链传播），$\Theta_{1,l}$ 衡量**输入分离的保持程度**（不同输入的输出能否区分）。收缩机制（$L_j < 1$）同时压低 $\Theta_{1,l}$（输出坍缩，输入可区分性消失）和 $\Lambda_l$（抑制误差累积）；扩张机制（$L_j > 1$）则反之。两者的平衡决定了 IDFS 的长链稳定性。

**命题 2.7（扰动的长链扩张与容量截断，Long-chain Expansion and Capacity Truncation）**：设从第 $k$ 步起至有限的第 $l$ 步，f-链的每一步 $j = k, \ldots, l$ 均存在**扩张下界** $c_j \geq 1$，使得：

$$d\!\bigl(\hat{h}_j^{(A)},\, \hat{h}_j^{(B)}\bigr) \;\geq\; c_j \cdot d\!\bigl(\hat{h}_{j-1}^{(A)},\, \hat{h}_{j-1}^{(B)}\bigr)$$

定义**有限尾部扰动放大系数（下界）**：

$$\Pi_{k,l}^{-} \;\triangleq\; \prod_{j=k}^{l} c_j$$

设第 $k-1$ 步存在任意来源的**状态扰动** $\Delta_{k-1} \triangleq d(\hat{h}_{k-1}^{(A)}, \hat{h}_{k-1}^{(B)}) > 0$（无论来自初始差异或误差积累），则局部有限步内的终态距离必然被严格放大：

$$d\!\bigl(\hat{h}_l^{(A)},\, \hat{h}_l^{(B)}\bigr) \;\geq\; \Pi_{k,l}^{-} \cdot \Delta_{k-1}$$

**特例（输入差异）**：取 $k = 1$，$\Delta_0 = d(x_A, x_B)$，则退化为对原始输入差异的有限步放大：$d(\hat{h}_l^{(A)}, \hat{h}_l^{(B)}) \geq \Pi_{1,l}^{-} \cdot d(x_A, x_B)$。

**推论 2.8（无穷扩张的拓扑不可能性）**：不存在使 $\Pi_{k,\infty}^{-} \to \infty$ 的无穷扩张链。

**证明**（反证）：假设 $\forall j \geq k,\, c_j > 1$ 且 $\Pi_{k,\infty}^{-} \to \infty$。由命题 2.7：

$$d(\hat{h}_l^{(A)}, \hat{h}_l^{(B)}) \;\geq\; \Pi_{k,l}^{-} \cdot \Delta_{k-1} \;\xrightarrow{l \to \infty}\; \infty$$

但 $\hat{h}_l^{(A)}, \hat{h}_l^{(B)} \in \Phi(\mathcal{X})$，而 $\Phi \in \mathrm{Lip}_L$ $\Rightarrow$ $\mathrm{diam}(\Phi(\mathcal{X})) \leq L \cdot \mathrm{diam}(\mathcal{X}) < \infty$。矛盾。$\square$

> **注（驱动条件是尾部乘积；扰动来源无关紧要）**：起始步 $k$ 任意，前 $k-1$ 步可扩张、可收缩、可无约束，不影响结论——关键只是 $\Delta_{k-1} > 0$ 存在。尾部乘积 $\Pi_{k,l}^{-} \to \infty$ 是爆炸的充分条件，而非要求每步 $c_j > 1$（例如 $c_j = 1 + 1/j^2$ 时乘积收敛，不会爆炸）。与命题 2.3 完全对称：命题 2.6 中收缩尾部乘积将任意有限扰动压至零，命题 2.7 中扩张尾部乘积将任意非零扰动放大至无穷——两者均与扰动的历史来源无关。命题 2.9 是命题 2.7 在 IDFS $\sigma$-决策边界处的**结构性实例**——边界跨越时 $c_j$ 逼近系统全局极限 $L$，使 $\Pi_{k,l}^{-}$ 在有限步内迅速积累至触发分辨率死锁。

---

**命题 2.9（决策边界的路由分辨率极限，Routing Resolution Limit at Decision Boundaries）**：设 $\Phi \in \mathrm{Lip}_L(\mathcal{X})$。若两状态 $a, b \in \mathcal{X}$ 被 $\sigma$ 分派至不同路径，产生宏观偏离：

$$\Delta \;\triangleq\; d\bigl(\Phi(a),\, \Phi(b)\bigr) \;>\; 0$$

则输入间距满足下界：

$$d(a, b) \;\geq\; \frac{\Delta}{L}$$

**证明**：

1. 由 $\Phi \in \mathrm{Lip}_L$：$\Delta = d(\Phi(a), \Phi(b)) \leq L \cdot d(a,b)$。
2. 移项：$d(a,b) \geq \Delta/L$。
3. 边界处局部扩张率 $L_j = \Delta / d(a,b)$。当 $d(a,b) \to \Delta/L$ 时，$L_j \to L$。若 $d(a,b) < \Delta/L$，则 $L_j > L$，矛盾。$\square$

> **注（对分辨率死锁的结构性理解）**：这一极限揭示了一个深远的结构律：完全并非测度空间强行阻止状态靠近，而是当两点距离 $d(a,b)$ 小于该临界分辨率阈值 $\Delta/L$ 时，路由引擎 $\sigma$ 在数学上被绝对剥夺了将它们“劈开”并赋予 $\Delta$ 偏离度行为的能力。换言之，系统的全局稳态（有限 $L$）为 $\sigma$ 的离散切割精度设定了**不可被超越的物理决断极限**。

> **注（与命题 2.3 的关系：被分辨率极限斩断的长链）**：命题 2.3 提供了一种比无穷张量更深刻的断裂机制：**命题 2.3 中持续扩张的轨迹撞上了路由分辨率的“结构刻度线”。**当长链扩张（$\forall j, c_j \ge 1$）导致系统必须穿过具备宏观差异需求 $\Delta$ 的分类边界时，如果两点间距不足 $\Delta / L$，由于统计算力约束，$\sigma$ 在数学上**无法**执行带有 $\Delta$ 缝隙的切割，只能被迫将它们收束入产生近似输出的同一宏观行为管道中。这种由于极值逼近导致的分辨率盲区，粗暴地把本该分道扬镳的微观轨线重新捏合，从拓扑底层终结了随时间累积的指数发散。

> **注（与推论 4.2 的三元纠缠的关系）**：三元纠缠的根源在于 $\sigma$ 引入了非平滑切割。当泛化任务由于复杂的逻辑组合，要求在极其微小的输入扰动 $d(a,b)$ 下做出宏观行为改变 $\Delta$ 时，如果所需的分辨率要求超出了 $\sigma$ 当前的理论极限 $\Delta / L$，由于系统只能**绝对遵循**全局张量边界 $L_j \le L$ 的硬性限制，它**必须且只能**放弃该处高频边界的正确切换，引发强制降维和泛化误判。这就是 OOD 边界崩塌的数学绝对机制：强行要求系统在超越其结构分辨率底线的区域进行细粒度路由时，系统会直接遵循物理极限发生特征坍缩，让 $\delta$ 偏离在乘积长链中承受不可恢复的宏观错误路线。

> **注（系统容量约束与极大曲率制衡）**：有限基算子系统内没有绝对的无穷大散度。命题 2.7 从反证的角度指出，假设存在一个连续不变的单点扩张行为（$c_j \ge 1$）将引导状态间距无限发散；但$\Phi$ 的 Lipschitz 有界性（$\mathrm{diam}(\Phi(\mathcal{X})) < \infty$）宣判了这种不受限逃逸的不可能性。切断发散的不是外部修正，正是系统自身由于有限资源和最大全局拉伸上限决定的命题 2.9：一旦逼近距离极限，系统便会丧失离散选择能力。因此，有限物理框架自身通过 $L$ 张量制衡了局部发散妄想。

### 2.4 结构性非均匀张力

§2.5 揭示了 IDFS 迭代映射的动力学行为：收缩尾积压平扰动（命题 2.6），扩张尾积放大扰动（命题 2.7），$\sigma$-边界更产生局部极其剧烈且受制于分辨率极限的最大扩张差 $L_j$（命题 2.9）。这自然引出一个系统设计层面的问题：系统在长链中所展现出的**路径曲率**必须有多大的变异范围？本节表明，这一变异范围由目标任务集的多样性从下方强制决定。

回顾 §1.2 定义的**路径 Lipschitz 跨度** $\kappa_\Phi = \sup L_j / \inf L_j$。由于系统长链的局部 Lipschitz 常数 $L_j$ 完全由 $\sigma$ 为路径 $q$ 所拼接出的空间拉伸率度量，$\kappa_\Phi$ 构成了系统基于离散基元能拼装出的全局动态异质性的物理极限。

**定义（目标等效张力跨度，Target Effective Stretch Span）**：记 $R$ 为要求系统建模或逼近的目标规律集合。目标规律可能高度离散、非平滑甚至逻辑断裂，无需具备解析上的 Lipschitz 性质。但在微观层面上，当系统逼近某个目标 $r \in R$ 时，为在一定邻域内刻画出 $r$ 引起的特征分散或收束（例如类别坍缩或多态生成），系统必须展现出特定的**等效宏观形变率** $\lambda_r$（即为了成功模仿 $r$，系统路径必须释放出的平均截断扩张/收缩倍数）。定义目标集 $R$ 的 **等效张力跨度** $\gamma_R \geq 1$ 为：

$$\gamma_R \;\triangleq\; \frac{\sup_{r \in R} \lambda_r}{\inf_{r \in R} \lambda_r}$$

$\gamma_R$ 纯粹从“为了拟合它你需要多大张力”的角度量化了目标集内部的**动力学异质需求**——当任务集既要求系统执行极强的概念收束聚集（要求 $\lambda_r \ll 1$），又要求系统执行极强的内容生成发散（要求 $\lambda_r \gg 1$）时，$\gamma_R \gg 1$。

**命题 2.10（结构异质下界，Structural Heterogeneity Lower Bound）**：设 IDFS 以路径形变率 $\bar{L}$ 逼近目标集 $R$ 中的每个 $r$（需 $\bar{L} \approx \lambda_r$）。则：

$$\kappa_\Phi \;\geq\; \gamma_R$$

**证明**：

1. 由 §1.2，$\bar{L} \in [\inf L_j,\, \sup L_j]$。
2. 逼近 $\sup_R \lambda_r$ $\Rightarrow$ $\sup L_j \geq \sup_R \lambda_r$。
3. 逼近 $\inf_R \lambda_r$ $\Rightarrow$ $\inf L_j \leq \inf_R \lambda_r$。
4. 取商：$\kappa_\Phi = \sup L_j / \inf L_j \geq \sup_R \lambda_r / \inf_R \lambda_r = \gamma_R$。$\square$

> **注（异质张力是泛化的内禀代价）**：$\kappa_\Phi \to 1$（即系统在任何路线上的步进形变被强行正则化至单一常值）必然导致 $\gamma_R \to 1$——系统随即丧失对动力学多样化目标的泛化能力。要使 IDFS 能够包罗万象，极端的路径张力 $\kappa_\Phi \geq \gamma_R$ 是必须支付的**结构性物理代价**。

> **注（与命题 2.3 的深层结构闭环）**：命题 2.9 表明，当系统被迫逼近路由分辨率极限时，$\sigma$-决策硬切换必将诱发极其剧烈的局部 $L_j$ 极值。这正是推高系统宏观 $\kappa_\Phi$ 的最核心**几何发源地**——正是由于 $\sigma$ 跨越离散缝隙时产生的极大拓扑排斥，逼出了远超常规平滑函数的 $L_j$ 峰值（极大拉飞 $\sup L_j$）。命题 2.9 与命题 2.10 在此闭环揭示：$\sigma$ 的离散切分既是 IDFS 实现复杂目标拼接复用的算力源泉，也是造成其动态路由产生高度异质差、走廊极易脆裂的绝对数学元凶。

**推论 2.11（能力-脆弱同源性，Capability–Fragility Duality）**：$\gamma_R \gg 1$ 时，系统被迫建立 $L_{max} \geq \sup_R \lambda_r \gg 1$ 的高拉伸走廊。该走廊同时是 §3 CAC 误差放大的主通道。

**证明**：

1. 由命题 2.10，$\gamma_R \gg 1$ $\Rightarrow$ $\sup L_j \gg 1$。
2. 由 §3 CAC 定理，误差上界含 $\mathcal{O}(L_{max}^l)$ 项，当扰动 $\delta$ 与 $L_{max}$ 对应的拉伸方向对齐时取到。
3. 拟合所需的高拉伸方向 $\equiv$ 误差放大的主方向。两者在同一几何构造上，不可独立调控。$\square$

### 2.5 $f$-链正交性

§2.1 的路由容量 $\mathcal{C}_{route} \leq \mathcal{D}\log M$ 量化了系统可区分路径的**代数上界**。但这个对数量并未揭示其几何本质——在有限维度量空间 $(\mathcal{X}, d)$ 上，为什么系统的有效表征容量能远超 $\mathcal{X}$ 自身的拓扑维度？本节从 $F$-链空间的正交性出发，为路由容量赋予几何解释。

核心洞察是：知识的载体不是 $\mathcal{X}$ 中的单个状态点，而是 $\sigma$ 从函数集 $F$ 中选出的**组合路径**（$f$-链）。正交性应在路径空间 $F^*$ 上定义，而非在输入空间 $\mathcal{X}$ 上定义。

#### 定义（结构正交，Operator-Support Orthogonality）

设两条 $f$-链 $q_A = f_{a_l} \circ \cdots \circ f_{a_1} \in F^*$ 和 $q_B = f_{b_l} \circ \cdots \circ f_{b_1} \in F^*$。定义两者的**算子重合度（Operator Overlap）**为：

$$\mathrm{Overlap}(q_A, q_B) \;\triangleq\; |\{f_{a_1}, \ldots, f_{a_l}\} \cap \{f_{b_1}, \ldots, f_{b_l}\}|$$

若 $\mathrm{Overlap}(q_A, q_B) = 0$——即两条链在演化过程中没有调用 $F$ 中任何相同的算子——则称 $q_A$ 和 $q_B$ **结构正交**。

**命题 2.12（结构正交容量的组合爆炸）**：在 $|F| = M$ 的函数集中，可构造的长度为 $l$ 的两两结构正交 $f$-链的最大数量为：

$$N_{struct} \;=\; \left\lfloor M / l \right\rfloor$$

总可构造的注入（无重复算子）$f$-链数为 $M!/(M-l)!$。

**证明**：将 $F$ 的 $M$ 个算子分成 $\lfloor M/l \rfloor$ 组，每组 $l$ 个。每组内部按任意序复合构成一条 $f$-链，不同组的链算子集完全不交。注入链数由排列数直接给出。$\square$

> **注（容量的降维打击）**：在有限维度量空间 $\mathcal{X}$ 中，$\mathcal{X}$ 的拓扑维数 $\dim(\mathcal{X})$ 约束了可独立嵌入的"方向"数。但在 $|F| = M$ 的函数集构成的自由幺半群 $F^*$ 中，即使要求最严格的结构正交，仍有 $M/l$ 条互不干扰的 $f$-链——当 $M = 10^4$、$l = 10$ 时即为 $10^3$ 条结构正交链，远超 $\dim(\mathcal{X})$。若放松到允许部分算子共享（见下方变分正交），有效容量更大。这解释了为什么系统能"存下万物"——知识不存在点上，而存在组合路径上。

> **注（$F^*$ 与 $Im(\sigma)$ 的关系）**：正交性是 $F^*$ 上的纯代数/几何性质，其定义不依赖选择映射 $\sigma$ 或微观深度 $\mathcal{D}$。但系统的**有效正交维度**取决于 $\sigma$ 实际激活了 $F^*$ 中的哪些链——即 $Im(\sigma) \subseteq F^*$ 中有多少条链两两变分正交。§2.1 的路由容量上界 $|Im(\sigma)| \leq M^{\mathcal{D}}$ 约束了被激活链的总数；本节的正交性分析则进一步揭示，这些被激活的链中有多少是**真正独立的**（变分正交的），有多少是**冗余的**（变分平行的）。

#### 定义（变分正交，Variational Deformation Orthogonality）

结构正交要求算子集完全不交——在实际系统中过于严格（基础算子被几乎所有 $f$-链共享）。更根本的独立性概念是：两条链对输入微扰产生的**局部几何形变相互独立**。

设 $x \in \mathcal{X}$，$x' \in \mathcal{X}$ 为 $x$ 的 $\epsilon$-邻域中的点。定义 $f$-链 $q \in F^*$ 在 $x$ 处的**变分响应幅度**为：

$$\delta q(x, x') \;\triangleq\; d(q(x'), q(x))$$

定义两条 $f$-链 $q_A, q_B \in F^*$ 的**变分耦合度（Variational Coupling）**为：

$$\mathrm{Cov}_{var}(q_A, q_B) \;\triangleq\; \mathbb{E}_{x \sim \mu,\, d(x,x') = \epsilon}\!\left[\delta q_A(x, x') \cdot \delta q_B(x, x') - \mathbb{E}[\delta q_A] \cdot \mathbb{E}[\delta q_B]\right]$$

其中期望取遍输入分布 $\mu$ 和半径为 $\epsilon$ 的微扰方向。若 $\mathrm{Cov}_{var}(q_A, q_B) = 0$，则称两条链在 $\mu$ 下**变分正交**——即它们对同一微扰的局部形变幅度不相关。

> **注（物理含义）**：变分正交意味着——当输入发生微小扰动时，$f$-链 $q_A$ 的输出变化幅度与 $q_B$ 的输出变化幅度**统计上无关**。一条链受到的局部拉伸或压缩，不会预测另一条链的拉伸或压缩。这就是为什么系统可以同时表征两个语义截然不同的概念——即使它们的输入在 $\mathcal{X}$ 中可能相近，$\sigma$ 将它们路由到变分正交的两条 $f$-链上，后续形变行为完全独立，互不干扰。

> **注（欧氏空间中的简化）**：当 $\mathcal{X} \subseteq \mathbb{R}^n$ 时，$\delta q(x, x')$ 可用差向量 $\Delta q = q(x') - q(x)$ 替代，变分耦合度退化为变分向量的内积 $\langle \Delta q_A, \Delta q_B \rangle$ 的期望——即 Sobolev 型的导数内积。变分正交此时等价于两条链的局部形变**方向垂直**。

**命题 2.13（结构正交蕴含变分正交）**：若 $q_A, q_B \in F^*$ 结构正交（算子集不交），且 $F$ 中各算子的像集在 Hausdorff 距离意义上彼此有正间距，则 $q_A$ 和 $q_B$ 变分正交。

**证明**：设 $q_A = f_{a_l} \circ \cdots \circ f_{a_1}$，$q_B = f_{b_l} \circ \cdots \circ f_{b_1}$，算子集不交。$q_A$ 的末端输出落在 $f_{a_l}(\mathcal{X})$ 内，$q_B$ 的末端输出落在 $f_{b_l}(\mathcal{X})$ 内。对输入微扰，$\delta q_A$ 的幅度完全由 $f_{a_l}$ 的像集的局部几何决定，$\delta q_B$ 的幅度完全由 $f_{b_l}$ 的像集的局部几何决定。当两个像集在 Hausdorff 距离意义上分离时，它们的局部拉伸行为无结构性关联，变分耦合度在 $\mu$-平均下为零。$\square$

> **注（有效容量 = 变分正交维度）**：$F^*$ 中的变分正交关系定义了一种**有效维度**——系统中可以**同时无干扰共存**的独立 $f$-链的最大数量。结构正交容量 $\lfloor M/l \rfloor$ 是有效维度的一个保守下界。变分正交容量可以远大于此——共享算子的 $f$-链只要形变幅度不相关，就互不干扰。
>
> 这一概念与 §2.4 命题 2.10 的路径 Lipschitz 跨度 $\kappa_\Phi$（§1.2 定义）深刻关联：
> - $\kappa_\Phi \approx 1$（所有路径的形变率几乎相同）$\implies$ **变分正交维度坍缩**——结构上不同的 $f$-链在变分意义上全部"平行"，有效容量远低于代数容量 $M^\mathcal{D}$。这正是第二章 §7.2.1 Type A（路由简并、死库）的几何本质。
> - $\kappa_\Phi \gg 1$（路径的形变率高度多样）$\implies$ **变分正交维度高**——同一算子 $f \in F$ 在不同输入域上产生不同方向的形变，共享算子不构成干扰。有效容量接近代数容量。这就是 Type B 的优势来源。

**命题 2.14（路由跳变代价的正交降阶，Orthogonal De-escalation of Routing Mismatch Penalty）**：§3.1 CAC 五项精细界中的路由失准惩罚 $\Delta^{err}_j = d(\sigma(h_{j-1})(h_{j-1}),\, \sigma(h^*_{j-1})(h_{j-1}))$ 度量的是**两条不同 $f$-链在同一输入处的输出差异**。该罚项在误差界中的累积行为，取决于实际激活链 $\sigma(h_{j-1})$ 与理想激活链 $\sigma(h^*_{j-1})$ 的**变分正交性**。

设系统演化 $l$ 步，前 $l$ 步中存在 $n_{switch}$ 次路由跳变（$\sigma(h_{j-1}) \neq \sigma(h^*_{j-1})$，即实际轨道与理想轨道的路由决策分裂）。记第 $j$ 次跳变时，实际激活链 $q^{act}_j = \sigma(h_{j-1})$，理想激活链 $q^{ideal}_j = \sigma(h^*_{j-1})$，二者的**路由跳变向量**为 $\vec{\Delta}_j = q^{act}_j(h_{j-1}) - q^{ideal}_j(h_{j-1})$（在 $\mathcal{X} \subseteq \mathbb{R}^n$ 的局部切空间中）。则：

(i) **完全同向（最坏情形）**：若所有 $n_{switch}$ 次跳变的跳变向量 $\vec{\Delta}_j$ 均沿同一方向对齐（$\vec{\Delta}_j = |\vec{\Delta}_j| \cdot \vec{v}$），则经尾部乘积放大后的总路由惩罚为：

$$\sum_j \Delta^{err}_j \cdot \Theta_{j+1,l} \;=\; \sum_j |\vec{\Delta}_j| \cdot \Theta_{j+1,l} \;=\; \Delta_{max} \cdot \Lambda_l$$

退化为 CAC 形式 A 的最保守界。此情形与 推论 3.3（同向共线坍缩构造）完全同构——所有误差源坍缩于主特征射线。

(ii) **变分正交（统计改善）**：若各次路由跳变时 $q^{act}_j$ 与 $q^{ideal}_j$ 变分正交（$\mathrm{Cov}_{var}(q^{act}_j, q^{ideal}_j) = 0$），则跳变向量 $\vec{\Delta}_j$ 的方向在切空间中**统计无关**（不同跳变事件的形变方向独立）。由 §3.2 统计精化界（SRB），在 type-$p$ Banach 空间中，路由惩罚的累积总和从最坏的 $\mathcal{O}(\Delta_{max} \cdot \Lambda_l)$ 降阶为：

$$\left\|\sum_j \vec{\Delta}_j \cdot \Theta_{j+1,l}\right\| \;\sim\; \mathcal{O}\!\left(\Delta_{max} \cdot \Lambda_l^{1/p}\right)$$

当 $p = 2$（Hilbert 空间）时，降阶为 $\mathcal{O}(\Delta_{max} \cdot \sqrt{\Lambda_l})$——路由惩罚的有效累积速率从线性降至平方根。

**证明**：

(i) 由三角不等式在一维子空间的退化，同向量的范数之和等于和的范数。尾部乘积放大保持方向不变。

(ii) 路由跳变向量 $\vec{\Delta}_j$ 可视为由路由边界跨越事件引入的"噪声项"。变分正交保证了各跳变向量在切空间中方向独立。将 $\{\vec{\Delta}_j \cdot \Theta_{j+1,l}\}$ 视为零均值独立随机向量（均值为零是因为变分正交意味着形变方向无系统偏置），在 type-$p$ 空间中应用 type-$p$ 不等式（§3.2 定义），总和的 $p$-阶矩满足 $\mathbb{E}[\|\sum \vec{\Delta}_j \Theta_{j+1,l}\|^p] \leq T_p^p \sum \mathbb{E}[\|\vec{\Delta}_j \Theta_{j+1,l}\|^p] \leq T_p^p \Delta_{max}^p \sum \Theta_{j+1,l}^p$。由 Jensen 不等式或直接估计，$\sum \Theta_{j+1,l}^p \leq (\sum \Theta_{j+1,l})^p \cdot n_{switch}^{1-p} = \Lambda_l^p \cdot n_{switch}^{1-p}$，开 $p$ 次根并取 $n_{switch} \leq l$ 即得渐近阶。$\square$

> **注（正交降阶的物理含义与 §3.2 漂移-扩散定律的闭合）**：此命题揭示了路由跳变代价的双重性质——它既是 §3.1 CAC 的**确定性代数项**（最坏情形同向累积），又可以是 §3.2 SRB 的**随机扩散项**（正交散射），取决于系统 $f$-链空间的正交结构。在 §3.2 的漂移-扩散框架中，同向路由跳变对应纯粹的**系统漂移**（$\mu_{bias}$），正交路由跳变对应**随机扩散**（$\eta_{noise}$）。因此，**$f$-链正交性是将路由惩罚从漂移项"降级"为扩散项的精确数学机制**。由此也可推知：在 §7.2 的路由碎裂博弈中，若系统通过优化 $\sigma$ 的路由拓扑使跳变方向趋于正交，则 $\Delta_\sigma$ 的实际 CAC 代价远低于最坏情形的 $\Delta_{max}\Lambda_l$——路由预算 $B_\sigma$ 的有效利用率因正交性而大幅提升。

> **注（与 推论 5.5 的联动：正交性的反劫持新含义）**：推论 5.5 已证明变分正交在邻域劫持中提供侧向逃逸。当与路由惩罚的正交降阶联合时，正交性具有更深层的功能：在 §5 的劫持场景中，中间态 $h_1$ 进入 $r_B$ 的领地附近，$\Phi$ 在 $h_1$ 处选择的过渡链 $q_{transit}$ 若与 $r_B$ 的局部链 $q_{local}$ 变分正交，则不仅 $q_{local}$ 的形变不产生系统偏移（§5 原有结论），更关键的是，由此引发的路由跳变 $\Delta^{err}$ 在后续链路中以**扩散而非漂移**模式累积——劫持的"余震"不会沿主特征方向相干叠加，而是被正交方向分散。这从误差传播层面解释了为什么高正交维度的系统（高 $\kappa_\Phi$、大 $M$）更能抵御劫持的级联恶化。

**命题 2.15（$\Delta^{sam}$ 的结构正交消去，Structural Orthogonality Elimination of $\Delta^{sam}$）**：§3.1 CAC 五项精细界中的采样域路由失配项 $\Delta^{sam}_j = d(\sigma(h^*_{j-1})(x'_j),\; \sigma(x'_j)(x'_j))$ 度量的是：理想轨道所处位置 $h^*_{j-1}$ 的激活链与最近采样点 $x'_j$ 处的激活链，在 $x'_j$ 处的输出差异。该项在结构正交条件下**自动归零**。

设 $h^*_{j-1}$ 为理想轨道的第 $j-1$ 步中间态，$x'_j = \mathrm{argmin}_{x \in \mathcal{X}(r_{i_j})} d(h^*_{j-1}, x)$ 为其最近采样点，距离为 $\delta_j = d(h^*_{j-1}, x'_j)$。设 $\sigma(h^*_{j-1})$ 激活的 $f$-链 $q_A$ 与 $\sigma(x'_j)$ 激活的 $f$-链 $q_B$ 结构正交（算子集不交），且 $F$ 中各算子的像集在 Hausdorff 距离意义上具有正间距 $d_H > 0$。

则当 $\delta_j < d_H/L$ 时，$\sigma(h^*_{j-1}) = \sigma(x'_j)$——即 $h^*_{j-1}$ 与 $x'_j$ 必然位于同一路由分区内，从而 $\Delta^{sam}_j = 0$。

**证明**：由 §2.3 命题 2.9（路由分辨率极限），路由决策边界两侧的最小输入间距为 $\geq \Delta_{decision}/L$。在结构正交条件下，算子像集的 Hausdorff 正间距 $d_H > 0$ 意味着不同路由分区的输出像集在 $d_H$ 尺度上分离。由此，路由决策产生的宏观行为差异 $\Delta_{decision} \geq d_H$，因此路由边界到 $h^*_{j-1}$ 的最小距离 $\geq d_H/L$。当 $\delta_j = d(h^*_{j-1}, x'_j) < d_H/L$ 时，$h^*_{j-1}$ 与 $x'_j$ 不可能被路由边界分隔（否则违反分辨率极限），故 $\sigma(h^*_{j-1}) = \sigma(x'_j)$，$\Delta^{sam}_j = d(\sigma(h^*_{j-1})(x'_j), \sigma(x'_j)(x'_j)) = 0$。$\square$

> **注（$\Delta^{sam} = 0$ 的实际含义与局限）**：此命题表明，在算子像集充分分离的系统中，只要理想轨道的采样域偏离 $\delta_j$ 足够小（小于 $d_H/L$），采样域路由失配项自动消除。这为 Type B 系统提供了额外的精度优势——短链中 $\delta_j$ 被截断（命题 2.3 (i)），且 Type B 可通过增大 $M$ 来增加算子多样性和像集间距（$d_H$ 随 $M$ 增大趋于增加），两者协同使 $\Delta^{sam}$ 在 Type B 中几乎恒为零。然而在长链系统中，$\delta_j$ 因漂移累积可能远超 $d_H/L$，此消去条件不再成立——长链的采样域路由失配是结构性不可避免的。

---



### 2.6 计算有界性与非图灵完备性

上述性质刻画了 IDFS 的拓扑容量、路由结构和动力学行为。本节确立 IDFS 的**计算论定位**——它在计算能力层级中处于何处。

**定理 2.16（IDFS 的非图灵完备性）**：IDFS 不具备图灵完备性。

**证明**：IDFS $\mathcal{F} = (F, \sigma)$ 的单步执行 $\Phi(x) = \sigma(x)(x)$ 中，$\sigma(x)$ 是 $F^*$ 中的一条有限长链 $q = f_{i_k} \circ \cdots \circ f_{i_1}$（$k \le \mathcal{D}$）。因此 $\Phi$ 的每次求值在至多 $\mathcal{D}$ 步内终止。即使引入分段复合（§8），总有效链深 $l_{eff} = s \cdot l_0$ 仍然有限（段数 $s$ 和段内深度 $l_0$ 均有限）。

图灵完备系统能够表达**不终止计算**（停机问题的不可判定性即依赖于此）。由于 IDFS 的一切计算在有限步内终止，它无法表达不终止计算，因此不具备图灵完备性。$\square$

> **注（非图灵完备性的根源）**：非图灵完备性源于两条基本约束的联合：(1) $F$ 有限（$|F| = M$），限制了单步计算的多样性；(2) $f$-链深度有界（$k \le \mathcal{D}$），限制了计算的时间展开。二者共同将 IDFS 的计算能力封死在有限自动机与图灵机之间——系统能执行的不同计算总数上界为 $\sum_{k=0}^{\mathcal{D}} M^k$，这是一个有限数。
