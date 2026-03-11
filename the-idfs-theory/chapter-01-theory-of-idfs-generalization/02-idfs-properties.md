## IDFS 的基本性质

### 2.1 拓扑容量

**引理 1（IDFS 拓扑容量分解，Topological Capacity Decomposition）**：§1.2 定义的像集容量与路由容量具有以下上界：

$$\mathcal{C}_{\mathrm{img}}(F, \epsilon) \;\leq\; \log M + C_\epsilon$$

$$\mathcal{C}_{\mathrm{route}}(F, \sigma, \epsilon) \;\leq\; \mathcal{D} \log M + C_\epsilon$$

**证明**：

(1) 对任意输入 $x$，$\sigma(x) = f_{i_k} \circ \cdots \circ f_{i_1}$ 的输出必然落在末端算子 $f_{i_k}$ 的像集之内：$\sigma(x)(x) \in f_{i_k}(\mathcal{X})$。因此 $\bigcup_x \sigma(x)(x) \subseteq \bigcup_{i=1}^{M} f_i(\mathcal{X})$。由覆盖数的次可加性：$\mathcal{N} \leq \sum_{i=1}^{M} \mathcal{N}(\epsilon,\, f_i(\mathcal{X})) \leq M \cdot e^{C_\epsilon}$。取对数即得。

(2) 系统可选择的不同微观计算链总数受限于 $|\mathrm{Im}(\sigma)| \leq \sum_{k=1}^{\mathcal{D}} M^k \leq M^{\mathcal{D}}$（当 $M \geq 2$ 时）。每条路径的像集覆盖数不超过 $e^{C_\epsilon}$。取对数即得。$\square$

> **注（双容量的各自用途）**：像集容量 $\mathcal{C}_{\mathrm{img}}$ 是系统输出值域复杂度的紧上界，与链深 $\mathcal{D}$ 无关——更深的路由不扩展输出范围。路由容量 $\mathcal{C}_{\mathrm{route}}$ 则刻画了系统对不同输入做出差异化响应的能力，呈现 **离散路由熵（$\mathcal{D}\log M$） + 连续算子熵（$C_\epsilon$）** 的信息论双生结构。


### 2.2 容量极限定律与渐近拓扑灾难

引理 1 给出的拓扑容量上界完全独立于任何运动学假设（如 Lipschitz 连续性）。它纯粹基于信息论中的极限分辨精度确立了物理框架。考察 IDFS 规模趋于无穷时的渐近退化，揭示了系统工程中泛化与稳健性的刚性边界。

**推论 1（无穷基准库引发的过拟合坍缩，Overfitting Collapse via Infinite Operator Set）**：当系统深度 $\mathcal{D}$ 有限，而允许算子集无界扩展（$M \to \infty$）时：
$$\mathcal{C}_{\mathrm{img}} \to \infty, \quad \mathcal{C}_{\mathrm{route}} \to \infty$$
**拓扑意义**：输出容量 $\mathcal{C}_{\mathrm{img}}$ 的发散，意味着系统彻底摆脱了全空间紧致性约束。在缺乏空间压缩压力的高维域内，系统可为不同采样点分配完全独立的新算子组合而无需泛化。目标空间的度量结构不再主导内层表示，泛化过程退化为无压缩的无穷字典查表。

**推论 2（无穷深度引发的分形混沌，Fractal Chaos via Infinite Micro-Depth）**：当算子库维度 $M$ 有限，而允许微观深度无界扩展（$\mathcal{D} \to \infty$）时：
$$\mathcal{C}_{\mathrm{img}} \leq \log M + C_\epsilon < \infty, \quad \mathcal{C}_{\mathrm{route}} \to \infty$$
**拓扑意义**：路由容量向无穷发散，却被物理禁闭在恒定有界的像容量空间内。系统被强制要求在一个分辨极限给定的紧致空间内，挤压出无穷多条相互可分辨的离散轨迹。根据鸽巢原理，轨线间距必将被无限压缩，决策边界 $\sigma$ 从而被迫呈现无限稠密且处处撕裂的拓扑分形结构。输入空间的极微小扰动将被此致密折叠的计算网格映射向随机发散的轨道。系统由此丧失局部稳健性，陷落于确定性混沌。

> **注（自然界限）**：由此可见，IDFS 的**有效泛化逼近**——即通过有限结构逼近无穷状态空间的归纳压缩能力——只能存在于有限 $M$ 阻断过拟合、且有限 $\mathcal{D}$ 防控混沌的“边缘秩序”（Edge of Chaos）之中。这从最基础的信息论原理上证明了，任何试图通过单纯堆叠算子维度或无限拉长微观推理链来提升拟合效能的工程路径，必然分别触礁于记忆化与混沌崩塌的数学极限。

### 2.3 路由结构

**命题 1（组合耗尽与路由满射，Combinatorial Exhaustion and Routing Surjection）**：
设 IDFS $\mathcal{F} = (F, \sigma)$ 在 $\mathcal{X}$ 的某子集 $\mathcal{X}_{sub}$ 上以容差 $\epsilon$ 近似了由微观采样集 $\mathcal{S}$ 定义的目标集 $\mathcal{M}_\mathcal{S}$。若目标集的度量熵远超底层基算子的连续变形熵，即产生巨大的**信息阻抗（Information Impedance）**：
$$I_\epsilon(\mathcal{S}) \;\gg\; C_\epsilon$$

则依据鸽笼原理（Pigeonhole Principle），系统在 $\mathcal{X}_{sub}$ 上被激活的离散独立路径总数 $|\text{Im}(\sigma)|$ 必须具备指数级下界：
$$|\text{Im}(\sigma)| \;\ge\; e^{I_\epsilon(\mathcal{S}) - C_\epsilon} \;\to\; \infty$$

当目标集的复杂度逼近系统的**路由容量**天花板（即 $I_\epsilon(\mathcal{S}) \to \mathcal{C}_{\mathrm{route}} = \mathcal{D} \log M + C_\epsilon$）时，路由映射 $\sigma$ 将在 $\mathcal{X}_{sub}$ 上**退化为满射（Surjection）**：即 $\sigma(\mathcal{X}_{sub}) \approx F^{\le \mathcal{D}}$。

**证明**：
系统全局映射 $\Phi \triangleq \sigma(\cdot)(\cdot)$ 在 $\mathcal{X}_{sub}$ 上的像集可按激活路径分解。对每条被激活的路径 $q \in \text{Im}(\sigma)$，其像集 $q(\mathcal{X}_{sub})$ 的 $\epsilon$-覆盖数不超过 $e^{C_\epsilon}$（因 $q$ 的输出落在某末端算子 $f_i$ 的全有界像集内）。由覆盖数的次可加性：
$$\mathcal{N}\bigl(\epsilon, \Phi(\mathcal{X}_{sub})\bigr) \;\le\; \sum_{q \in \text{Im}(\sigma)} \mathcal{N}\bigl(\epsilon, q(\mathcal{X}_{sub})\bigr) \;\le\; |\text{Im}(\sigma)| \cdot e^{C_\epsilon}$$
若系统在 $\mathcal{X}_{sub}$ 上实现了对目标集的 $\epsilon$-近似，则 $\Phi(\mathcal{X}_{sub})$ 的覆盖数不低于目标集所需的 $e^{I_\epsilon(\mathcal{S})}$，故：
$$e^{I_\epsilon(\mathcal{S})} \;\le\; |\text{Im}(\sigma)| \cdot e^{C_\epsilon} \quad \Longrightarrow \quad |\text{Im}(\sigma)| \;\ge\; e^{I_\epsilon(\mathcal{S}) - C_\epsilon}$$
当 $I_\epsilon(\mathcal{S}) \to \mathcal{D} \log M + C_\epsilon$ 时，$|\text{Im}(\sigma)| \to M^\mathcal{D} = |F^{\le \mathcal{D}}|$，路由映射被迫耗尽所有可能的离散路径组合，构成满射。$\square$



**定义（路由混叠，Routing Aliasing）**：设单步系统 $\mathcal{F}$ 在子集 $\mathcal{X}_{sub} \subseteq \mathcal{X}$ 上运作。称在 $\mathcal{X}_{sub}$ 上存在第 $l$ 阶**路由混叠**，若存在 $x_1, x_2 \in \mathcal{X}_{sub}$ 使得模型在 $x_2$ 处的**单步微观路由决策**与从 $x_1$ 出发的 **$l$ 步宏观计算程序**完全等同：

$$\sigma(x_2) \;=\; \sigma_l(x_1) \;\triangleq\; \sigma\bigl(\Phi^{l-1}(x_1)\bigr) \circ \cdots \circ \sigma(x_1)$$

即系统用**同一条微观链**同时服务了一次单步任务（在 $x_2$ 处）和一次多步推理任务（从 $x_1$ 出发），形成计算程序层面的不可区分简并。路由混叠可由多种机制引起：组合耗尽（见下方推论）、$\sigma$ 的参数化约束、正则化、或有限精度表示等。

**推论（组合耗尽下的路由混叠必然性，Necessity of Routing Aliasing under Combinatorial Exhaustion）**：
在存在组合耗尽（$\sigma$ 退化为对 $F^{\le \mathcal{D}}$ 的满射）的复杂区域 $\mathcal{X}_{sub}$ 中，路由混叠**必然发生**。具体而言，对于任意一点 $x_1 \in \mathcal{X}_{sub}$，若其 $l$ 步宏观前向轨道保持在满射区域内（即 $\Phi^j(x_1) \in \mathcal{X}_{sub}$，$j = 0, \ldots, l-1$），且所诱导的复合微观链 $\sigma_l(x_1)$ 的总长度未超出微观深度上限（$|\sigma_l(x_1)| \le \mathcal{D}$），则必然存在 $x_2 \in \mathcal{X}_{sub}$ 使得 $\sigma(x_2) = \sigma_l(x_1)$。

**证明**：
由假设，$\Phi^j(x_1) \in \mathcal{X}_{sub}$ 保证了级联展开 $\sigma_l(x_1)$ 中的每一步 $\sigma(\Phi^j(x_1))$ 均处于满射区域内。$\sigma_l(x_1)$ 作为 $F$ 中底层算子首尾相接构成的链，其总长度 $|\sigma_l(x_1)| \leq \mathcal{D}$，故 $\sigma_l(x_1) \in F^{\le \mathcal{D}}$。由 $\sigma$ 在 $\mathcal{X}_{sub}$ 上对 $F^{\le \mathcal{D}}$ 的满射性，原像空间中必存在 $x_2 \in \mathcal{X}_{sub}$ 使得 $\sigma(x_2) = \sigma_l(x_1)$。$\square$


---

### 2.4 迭代动力学与决策边界

> **注**：以下命题刻画 IDFS 迭代映射 $\Phi$ 本身的动力学稳定性，不直接依赖 CAC 误差上界中的 $\varepsilon_{i_j}$、$\delta_j$ 结构；而是关于 Lipschitz 算子在长链迭代下的扰动传播行为及 $\sigma$-决策边界的不连续性质。

**命题 2（不动点收敛，Fixed-Point Convergence）**：若 $\Phi \in \mathrm{Lip}_L(\mathcal{X})$（全局）且 $L < 1$，$(\mathcal{X}, d)$ 完备，则 $\Phi$ 存在唯一不动点 $x^* = \Phi(x^*)$，$\Phi$-轨道从任意初始点收敛：$\hat{h}_l \to x^*$。

**证明**：$L < 1$ 时 $\Phi$ 是完备度量空间 $(\mathcal{X}, d)$ 上的压缩映射，由 **Banach 压缩映射定理**直接得不动点存在唯一性及轨道收敛。$\square$

**命题 3（扰动的长链衰减，Long-chain Decay of Perturbations）**：设 f-链步骤 $1, \ldots, l$ 的路径局部 Lipschitz 为 $L_j$。设第 $k-1$ 步存在任意来源的**状态扰动** $\Delta_{k-1} \triangleq d(\hat{h}_{k-1}^{(A)}, \hat{h}_{k-1}^{(B)}) > 0$ ——无论其来自原始输入差异还是前 $k-1$ 步的近似误差积累——若**尾部乘积** $\Theta_{k,l} \to 0$（$l \to \infty$，即收缩步主导），则：

$$d\!\bigl(\hat{h}_l^{(A)},\, \hat{h}_l^{(B)}\bigr) \;\leq\; \Theta_{k,l} \;\cdot\; \Delta_{k-1} \;\to\; 0$$

无论 $\Delta_{k-1}$ 多大，f-chain 终态均收敛——IDFS **抹除第 $k-1$ 步之前的一切扰动**，无论扰动来自输入差异、近似误差还是任何其他来源，均被尾部收缩机制彻底压制至零。

> **注（收缩极限 $l \to \infty$ 的合法性）**：与命题 4 中扩张链路因命题 5（路由分辨率极限）而被**强制截断**（$\sigma$ 无法在极近间距下维持跨边界选择，轨线被迫合并）不同，收缩路径不触发任何物理截断机制——系统只是将轨线越拉越近，不涉及分辨率死锁、路径合并或容量瓶颈。因此，在收缩主导的情形下，取 $l \to \infty$ 的数学极限是**物理上完全合法的**。这一非对称性是 IDFS 动力学中收缩与扩张行为的根本差异。

**特例（输入差异）**：取 $k = 1$，$\Delta_0 = d(x_A, x_B)$，则退化为对原始输入差异的衰减：$d(\hat{h}_l^{(A)}, \hat{h}_l^{(B)}) \leq \Theta_{1,l} \cdot d(x_A, x_B)$。

定义**有效区分深度** $l^\dagger = \max\{l \mid \Theta_{k,l} \geq \theta\}$（$\theta \in (0,1)$ 为可区分阈值），超过此深度后任意扰动均衰减至不可区分范围内。

**证明**：对局部 Lipschitz 条件连续应用，从第 $k$ 步截断：
$$d(\hat{h}_l^{(A)}, \hat{h}_l^{(B)}) \leq \Theta_{k,l} \cdot d(\hat{h}_{k-1}^{(A)}, \hat{h}_{k-1}^{(B)}) = \Theta_{k,l} \cdot \Delta_{k-1}$$
$\Delta_{k-1}$ 为有限正数，尾部乘积 $\Theta_{k,l} \to 0$ 时右端趋零。$\square$

> **注（对偶结构）**：$\Theta_{1,l}$（整条链的路径乘积，即 $\prod_{j=1}^l L_j$）与 $\Lambda_l$ 控制系统的两个方向：$\Lambda_l$ 衡量**误差的累积放大**（单步近似误差如何沿链传播），$\Theta_{1,l}$ 衡量**输入分离的保持程度**（不同输入的输出能否区分）。收缩机制（$L_j < 1$）同时压低 $\Theta_{1,l}$（输出坍缩，输入可区分性消失）和 $\Lambda_l$（抑制误差累积）；扩张机制（$L_j > 1$）则反之。两者的平衡决定了 IDFS 的长链稳定性。

**命题 4（扰动的长链扩张与容量截断，Long-chain Expansion and Capacity Truncation）**：设从第 $k$ 步起至有限的第 $l$ 步，f-链的每一步 $j = k, \ldots, l$ 均存在**扩张下界** $c_j \geq 1$，使得：

$$d\!\bigl(\hat{h}_j^{(A)},\, \hat{h}_j^{(B)}\bigr) \;\geq\; c_j \cdot d\!\bigl(\hat{h}_{j-1}^{(A)},\, \hat{h}_{j-1}^{(B)}\bigr)$$

定义**有限尾部扰动放大系数（下界）**：

$$\Pi_{k,l}^{-} \;\triangleq\; \prod_{j=k}^{l} c_j$$

设第 $k-1$ 步存在任意来源的**状态扰动** $\Delta_{k-1} \triangleq d(\hat{h}_{k-1}^{(A)}, \hat{h}_{k-1}^{(B)}) > 0$（无论来自初始差异或误差积累），则局部有限步内的终态距离必然被严格放大：

$$d\!\bigl(\hat{h}_l^{(A)},\, \hat{h}_l^{(B)}\bigr) \;\geq\; \Pi_{k,l}^{-} \cdot \Delta_{k-1}$$

**特例（输入差异）**：取 $k = 1$，$\Delta_0 = d(x_A, x_B)$，则退化为对原始输入差异的有限步放大：$d(\hat{h}_l^{(A)}, \hat{h}_l^{(B)}) \geq \Pi_{1,l}^{-} \cdot d(x_A, x_B)$。

**推论（无穷扩张的拓扑不可能性）**：若假设该扩张链可无限延续且 $\Pi_{k,\infty}^{-} \to \infty$，则要求终态距离 $d(\hat{h}_\infty^{(A)}, \hat{h}_\infty^{(B)}) \to \infty$。然而，由于引理 1 规定的全有界 IDFS 拓扑容量限制，距离发散在有限的度量包络内**不可能发生**。因此，连续的强扩张路线（$\forall j, c_j > 1$）在真实的高维折叠空间中必然是**有限长**的；它只能作为局部的瞬态不稳定现象存在，且注定被系统的宏观非线性收缩或离散边界跳变（见命题 5）所强制截断。

**证明**：局部放大不等式由扩张下界条件连续应用即得。推论部分依反证法：若无穷扩张成立，两点距离将超越全空间的固有直径 $\mathrm{diam}(\mathcal{X})$，这与引理 1 中像集容量 $\mathcal{C}_{\mathrm{img}} \leq \log M + C_\epsilon < \infty$（即存在全有界覆盖）的物理前提直接矛盾。因此无穷连乘假设不合法。$\square$

> **注（驱动条件是尾部乘积；扰动来源无关紧要）**：起始步 $k$ 任意，前 $k-1$ 步可扩张、可收缩、可无约束，不影响结论——关键只是 $\Delta_{k-1} > 0$ 存在。尾部乘积 $\Pi_{k,l}^{-} \to \infty$ 是爆炸的充分条件，而非要求每步 $c_j > 1$（例如 $c_j = 1 + 1/j^2$ 时乘积收敛，不会爆炸）。与命题 3 完全对称：命题 3 中收缩尾部乘积将任意有限扰动压至零，命题 4 中扩张尾部乘积将任意非零扰动放大至无穷——两者均与扰动的历史来源无关。命题 5 是命题 4 在 IDFS $\sigma$-决策边界处的**结构性实例**——边界跨越时 $c_j$ 逼近系统全局极限 $L$，使 $\Pi_{k,l}^{-}$ 在有限步内迅速积累至触发分辨率死锁。

---

**命题 5（决策边界的路由分辨率极限，Routing Resolution Limit at Decision Boundaries）**：设 IDFS $\mathcal{F} = (F, \sigma)$ 具有受控的宏观全局 Lipschitz 常数 $L < \infty$（如 §1.2 所述）。若 f-链第 $j$ 步转移中，状态 $a = \hat{h}_{j-1}$ 与 $b = h^*_{j-1}$ 距离为 $d(a,b)$，且路由引擎 $\sigma$ 因跨越了某种逻辑判定边界，将它们分别指派到了产生宏观行为差异的算子路径上，使得两个状态的单步演化结果呈现事实上的宏观偏离（无论由于 $\sigma$ 的何种离散选择，也不论基函数 $f$ 是否本身具备局部曲率）：

$$\Delta \;\triangleq\; d\bigl(\Phi(a),\, \Phi(b)\bigr) \;>\; 0$$

则这两个状态的输入物理间距必定陷入**分辨率死锁**：

$$d(a, b) \;\geq\; \frac{\Delta}{L}$$

**证明**：根据 IDFS 必须满足全局 $L$ 的稳态限制，有 $d(\Phi(a), \Phi(b)) \leq L \cdot d(a,b)$ 恒成立。代入宏观偏离假设 $\Delta = d(\Phi(a), \Phi(b))$，直接得到 $L \cdot d(a,b) \geq \Delta$，移项即得 $d(a,b) \geq \Delta/L$。
进一步考察边界处的实际路径扩张率 $L_j = d(\Phi(a), \Phi(b)) / d(a,b) = \Delta / d(a,b)$。当输入间距逼近理论底线（$d(a,b) \to \Delta/L$）时，实际扩张率 $L_j$ 必被推向系统的绝对物理极限 $L_j \to L$；若跨越底线（$d(a,b) < \Delta/L$）且强行要求系统输出 $\Delta$ 偏离，则在代数上要求 $L_j > L$，这违背系统的整体结构性底线。因此，该阈值不可逾越。$\square$

> **注（对分辨率死锁的结构性理解）**：这一极限揭示了一个深远的结构律：完全并非测度空间强行阻止状态靠近，而是当两点距离 $d(a,b)$ 小于该临界分辨率阈值 $\Delta/L$ 时，路由引擎 $\sigma$ 在数学上被绝对剥夺了将它们“劈开”并赋予 $\Delta$ 偏离度行为的能力。换言之，系统的全局稳态（有限 $L$）为 $\sigma$ 的离散切割精度设定了**不可被超越的物理决断极限**。

> **注（与命题 4 的关系：被分辨率极限斩断的长链）**：命题 5 提供了一种比无穷张量更深刻的断裂机制：**命题 4 中持续扩张的轨迹撞上了路由分辨率的“结构刻度线”。**当长链扩张（$\forall j, c_j \ge 1$）导致系统必须穿过具备宏观差异需求 $\Delta$ 的分类边界时，如果两点间距不足 $\Delta / L$，由于统计算力约束，$\sigma$ 在数学上**无法**执行带有 $\Delta$ 缝隙的切割，只能被迫将它们收束入产生近似输出的同一宏观行为管道中。这种由于极值逼近导致的分辨率盲区，粗暴地把本该分道扬镳的微观轨线重新捏合，从拓扑底层终结了随时间累积的指数发散。

> **注（与§4 推论 2 的三元纠缠的关系）**：三元纠缠的根源在于 $\sigma$ 引入了非平滑切割。当泛化任务由于复杂的逻辑组合，要求在极其微小的输入扰动 $d(a,b)$ 下做出宏观行为改变 $\Delta$ 时，如果所需的分辨率要求超出了 $\sigma$ 当前的理论极限 $\Delta / L$，由于系统只能**绝对遵循**全局张量边界 $L_j \le L$ 的硬性限制，它**必须且只能**放弃该处高频边界的正确切换，引发强制降维和泛化误判。这就是 OOD 边界崩塌的数学绝对机制：强行要求系统在超越其结构分辨率底线的区域进行细粒度路由时，系统会直接遵循物理极限发生特征坍缩，让 $\delta$ 偏离在乘积长链中承受不可恢复的宏观错误路线。

> **注（系统容量约束与极大曲率制衡）**：有限基算子系统内没有绝对的无穷大散度。命题 4 从反证的角度指出，假设存在一个连续不变的单点扩张行为（$c_j \ge 1$）将引导状态间距无限发散；但“全有界容量法则”宣判了这种不受限逃逸的不可能性。切断发散的不是外部修正，正是系统自身由于有限资源和最大全局拉伸上限决定的命题 5：一旦逼近距离极限，系统便会丧失离散选择能力。因此，有限物理框架自身通过 $L$ 张量制衡了局部发散妄想。

### 2.5 结构性非均匀张力

§2.4 揭示了 IDFS 迭代映射的动力学行为：收缩尾积压平扰动（命题 3），扩张尾积放大扰动（命题 4），$\sigma$-边界更产生局部极其剧烈且受制于分辨率极限的最大扩张差 $L_j$（命题 5）。这自然引出一个系统设计层面的问题：系统在长链中所展现出的**路径曲率**必须有多大的变异范围？本节表明，这一变异范围由目标任务集的多样性从下方强制决定。

回顾 §1.2 定义的**路径 Lipschitz 跨度** $\kappa_\Phi = \sup L_j / \inf L_j$。由于系统长链的局部 Lipschitz 常数 $L_j$ 完全由 $\sigma$ 为路径 $q$ 所拼接出的空间拉伸率度量，$\kappa_\Phi$ 构成了系统基于离散基元能拼装出的全局动态异质性的物理极限。

**定义（目标等效张力跨度，Target Effective Stretch Span）**：记 $R$ 为要求系统建模或逼近的目标规律集合。目标规律可能高度离散、非平滑甚至逻辑断裂，无需具备解析上的 Lipschitz 性质。但在微观层面上，当系统逼近某个目标 $r \in R$ 时，为在一定邻域内刻画出 $r$ 引起的特征分散或收束（例如类别坍缩或多态生成），系统必须展现出特定的**等效宏观形变率** $\lambda_r$（即为了成功模仿 $r$，系统路径必须释放出的平均截断扩张/收缩倍数）。定义目标集 $R$ 的 **等效张力跨度** $\gamma_R \geq 1$ 为：

$$\gamma_R \;\triangleq\; \frac{\sup_{r \in R} \lambda_r}{\inf_{r \in R} \lambda_r}$$

$\gamma_R$ 纯粹从“为了拟合它你需要多大张力”的角度量化了目标集内部的**动力学异质需求**——当任务集既要求系统执行极强的概念收束聚集（要求 $\lambda_r \ll 1$），又要求系统执行极强的内容生成发散（要求 $\lambda_r \gg 1$）时，$\gamma_R \gg 1$。

**命题 6（能力泛化的结构异质下界，Structural Heterogeneity Lower Bound for Generalization）**：设 IDFS 能够有效逼近目标集 $R$——即系统能够利用长链迭代，为每个 $r \in R$ 拼凑出能够提供与 $\lambda_r$ 需求相匹配的平均空间测度形变轨迹。则系统必需的内生路径曲率跨度下界为：

$$\kappa_\Phi \;\geq\; \gamma_R$$

**证明**：设系统由某长链逼近某目标 $r$，该路径的等效宏观形变率为 $\bar{L}$。根据 $\bar{L}$ 的极值属性（见 §1.2），必有 $\bar{L} \in [\inf L_j,\; \sup L_j]$。

为成功逼近最强扩张需求目标（要求 $\bar{L} \geq \sup_R \lambda_r$），系统路径必须能爆发出不低于该需求的峰值率：$\sup L_j \geq \sup_R \lambda_r$。
为成功逼近最强收缩需求目标（要求 $\bar{L} \leq \inf_R \lambda_r$），系统路径必须能潜入不高于该需求的谷值率：$\inf L_j \leq \inf_R \lambda_r$。
联立两不等式取商，即得核心结构关联：$\kappa_\Phi = \sup L_j / \inf L_j \geq \sup_R / \inf_R = \gamma_R$。$\square$

> **注（异质张力是泛化的内禀代价）**：$\kappa_\Phi \to 1$（即系统在任何路线上的步进形变被强行正则化至单一常值）必然导致 $\gamma_R \to 1$——系统随即丧失对动力学多样化目标的泛化能力。要使 IDFS 能够包罗万象，极端的路径张力 $\kappa_\Phi \geq \gamma_R$ 是必须支付的**结构性物理代价**。

> **注（与命题 5 的深层结构闭环）**：命题 5 表明，当系统被迫逼近路由分辨率极限时，$\sigma$-决策硬切换必将诱发极其剧烈的局部 $L_j$ 极值。这正是推高系统宏观 $\kappa_\Phi$ 的最核心**几何发源地**——正是由于 $\sigma$ 跨越离散缝隙时产生的极大拓扑排斥，逼出了远超常规平滑函数的 $L_j$ 峰值（极大拉飞 $\sup L_j$）。命题 5 与命题 6 在此闭环揭示：$\sigma$ 的离散切分既是 IDFS 实现复杂目标拼接复用的算力源泉，也是造成其动态路由产生高度异质差、走廊极易脆裂的绝对数学元凶。
