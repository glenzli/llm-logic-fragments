## IDFS 的基本性质

### 2.1 拓扑容量

**命题 2.1（IDFS 拓扑容量上界，Topological Capacity Bounds）**：§1.2 定义的像集容量与路由容量具有以下上界：

$$\mathcal{C}_{\mathrm{img}, d'}(\Phi, \epsilon) \;\leq\; \log \mathcal{N}_{d'}(\epsilon/L_{d'},\, \mathcal{X}) \qquad \text{（需 $L_{d'} < \infty$）}$$

$$\mathcal{C}_{\mathrm{route}}(\sigma) \;\leq\; \log \frac{M^{\mathcal{D}+1} - M}{M - 1} \;<\; (\mathcal{D}+1)\log M$$

**证明**：

(1) 设 $L_{d'} < \infty$。取 $\{B_{d'}(x_i, \epsilon/L_{d'})\}_{i=1}^{N}$ 为 $\mathcal{X}$ 的极小 $d'$-$\epsilon/L_{d'}$-覆盖（$N = \mathcal{N}_{d'}(\epsilon/L_{d'}, \mathcal{X})$）。对任意 $y \in \mathcal{X}$，$\exists\, x_i: d'(y, x_i) \leq \epsilon/L_{d'}$。由 $L_{d'}$ 的定义：

$$d'(\Phi(y), \Phi(x_i)) \;\leq\; L_{d'} \cdot d'(y, x_i) \;\leq\; L_{d'} \cdot \frac{\epsilon}{L_{d'}} \;=\; \epsilon$$

故 $\{B_{d'}(\Phi(x_i), \epsilon)\}_{i=1}^{N}$ 覆盖 $\Phi(\mathcal{X})$，$\mathcal{N}_{d'}(\epsilon, \Phi(\mathcal{X})) \leq \mathcal{N}_{d'}(\epsilon/L_{d'}, \mathcal{X})$。取对数即得。

(2) $|\mathrm{Im}(\sigma)| \leq \sum_{k=1}^{\mathcal{D}} M^k = \frac{M^{\mathcal{D}+1} - M}{M-1}$。取对数即得。$\square$

> **注（容量上界的 Lipschitz 依赖性）**：两个容量上界对 Lipschitz 有限性的依赖截然不同：像集容量上界需要 $L_{d'} < \infty$，当 $L_{d'} = +\infty$ 时无 Lipschitz 基上界，系统在像集维度上不可控；路由容量上界是纯离散量，与 $L_{d'}$ 完全无关。

> **注（无穷路由坍缩）**：当 $M \to \infty$ 或 $\mathcal{D} \to \infty$ 时，$\mathcal{C}_{\mathrm{route}} \to \infty$ 而 $\mathcal{C}_{\mathrm{img}, d'}$（在 $L_{d'} < \infty$ 下）保持有界——无穷条路由路径被压入有界像集空间，由鸽巢原理，路径间的像集重叠趋于完全，系统退化为无压缩字典查表。

**推论 2.2（级联系统容量，Cascaded System Capacity）**：由 §1.2.1，$l$-步级联系统 $\mathcal{F}_l = (F, \sigma_l)$ 自身构成 IDFS，其微观深度为 $l \cdot \mathcal{D}$。当 $L_{d'} < \infty$ 时，系统映射 $\Phi^l$ 在 $d'$ 下的广义 Lip 常数 $\leq L_{d'}^l < \infty$，将命题 2.1 施于 $\mathcal{F}_l$ 即得：

$$\mathcal{C}_{\mathrm{img}, d'}(\Phi^l, \epsilon) \;\leq\; \log \mathcal{N}_{d'}(\epsilon / L_{d'}^l,\, \mathcal{X})$$

$$\mathcal{C}_{\mathrm{route}}(\sigma_l) \;\leq\; \log \frac{M^{l\mathcal{D}+1} - M}{M - 1} \;<\; (l\mathcal{D}+1)\log M$$

> **注（级联的本质功能）**：像集容量上界在 $l \to \infty$ 下呈现单侧有效性：$L_{d'} < 1$ 时 $\epsilon/L_{d'}^l \to \infty$，$\mathcal{N} \to 1$，像集容量上界坍缩至零——与命题 2.5 的不动点收敛一致，推论有非平凡意义；$L_{d'} \geq 1$ 时 $\epsilon/L_{d'}^l \to 0$，$\mathcal{N} \to \infty$，上界发散，推论空洞。因此，级联不保证扩大像集，但确定性地放大路由组合数。

### 2.2 路由结构

**命题 2.3（组合耗尽与路由满射，Combinatorial Exhaustion and Routing Surjection）**：
设 IDFS $\mathcal{F} = (F, \sigma)$（$L_{d'} < \infty$）在 $\mathcal{X}$ 的某子集 $\mathcal{X}_{sub}$ 上以容差 $\epsilon$ 近似了采样集 $\mathcal{S}$ 定义的图集 $\mathrm{Gr}(\mathcal{S})$。若采样集的度量熵远超单路径的像集复杂度，即产生巨大的**信息阻抗（Information Impedance）**：
$$I_{\epsilon, d'}(\mathcal{S}) \;\gg\; \log \mathcal{N}_{d'}(\epsilon/L_{d'},\, \mathcal{X})$$

则依据鸽笼原理（Pigeonhole Principle），系统在 $\mathcal{X}_{sub}$ 上被激活的离散独立路径总数 $|\text{Im}(\sigma)|$ 必须具备指数级下界：
$$|\text{Im}(\sigma)| \;\ge\; e^{I_{\epsilon, d'}(\mathcal{S})} \big/ \mathcal{N}_{d'}(\epsilon/L_{d'},\, \mathcal{X}) \;\to\; \infty$$

当采样集的复杂度逼近系统的**路由容量**天花板（即 $I_{2\epsilon, d'}(\mathcal{S}) \to (\mathcal{D}+1) \log M + \log \mathcal{N}_{d'}(\epsilon/L_{d'}, \mathcal{X})$）时，路由映射 $\sigma$ 将在 $\mathcal{X}_{sub}$ 上**退化为满射（Surjection）**：即 $\sigma(\mathcal{X}_{sub}) \approx F^{\le \mathcal{D}}$。

**证明**：
系统全局映射 $\Phi \triangleq \sigma(\cdot)(\cdot)$ 在 $\mathcal{X}_{sub}$ 上的像集可按激活路径分解。对每条被激活的路径 $p \in \text{Im}(\sigma)$，$p$ 作为 $\mathcal{X} \to \mathcal{X}$ 的 Lipschitz 映射（$d'$ 下常数 $\leq L_{d'}$），其像集覆盖数 $\mathcal{N}_{d'}(\epsilon, p(\mathcal{X}_{sub})) \leq \mathcal{N}_{d'}(\epsilon/L_{d'}, \mathcal{X})$。由覆盖数的次可加性：
$$\mathcal{N}_{d'}\bigl(\epsilon, \Phi(\mathcal{X}_{sub})\bigr) \;\le\; |\text{Im}(\sigma)| \cdot \mathcal{N}_{d'}(\epsilon/L_{d'}, \mathcal{X})$$
若系统在 $\mathcal{X}_{sub}$ 上实现了对采样集的 $\epsilon$-近似，则 $\mathcal{V}(\mathcal{S})$ 被包含在 $\Phi(\mathcal{X}_{sub})$ 的 $\epsilon$-邻域内。由三角不等式，$\Phi(\mathcal{X}_{sub})$ 的 $\epsilon$-覆盖扩大 $\epsilon$ 后覆盖 $\mathcal{V}(\mathcal{S})$，故 $\mathcal{N}_{d'}(2\epsilon, \mathcal{V}(\mathcal{S})) \leq \mathcal{N}_{d'}(\epsilon, \Phi(\mathcal{X}_{sub}))$，即：
$$e^{I_{2\epsilon, d'}(\mathcal{S})} \;\le\; |\text{Im}(\sigma)| \cdot \mathcal{N}_{d'}(\epsilon/L_{d'}, \mathcal{X}) \quad \Longrightarrow \quad |\text{Im}(\sigma)| \;\ge\; e^{I_{2\epsilon, d'}(\mathcal{S})} / \mathcal{N}_{d'}(\epsilon/L_{d'}, \mathcal{X})$$
当 $I_{2\epsilon, d'}(\mathcal{S}) \to (\mathcal{D}+1) \log M + \log \mathcal{N}_{d'}(\epsilon/L_{d'}, \mathcal{X})$ 时，$|\text{Im}(\sigma)| \to \frac{M^{\mathcal{D}+1}-M}{M-1}$，路由映射被迫耗尽所有离散路径组合，构成满射。$\square$

> **注（路由分支的几何功能）**：从纯组合视角看，$|\mathrm{Im}(\sigma)|$ 的量纲仅仅是"可区分路径的种类数"。但从几何视角看，每一次路由切换——$\sigma$ 在相邻输入处选定不同的 $f$-链——意味着系统在该局部部署了一组不同的映射行为。因此 $\mathrm{Im}(\sigma)$ 不仅是组合意义上的"标签多样性"，更是几何意义上的**局部映射行为库的容量**。


**定义（路由混叠，Routing Aliasing）**：设单步系统 $\mathcal{F}$ 在子集 $\mathcal{X}_{sub} \subseteq \mathcal{X}$ 上运作。称在 $\mathcal{X}_{sub}$ 上存在第 $l$ 阶**路由混叠**，若存在 $x_1, x_2 \in \mathcal{X}_{sub}$ 使得模型在 $x_2$ 处的**单步微观路由决策**与从 $x_1$ 出发的 **$l$ 步宏观计算程序**完全等同：

$$\sigma(x_2) \;=\; \sigma_l(x_1) \;\triangleq\; \sigma\bigl(\Phi^{l-1}(x_1)\bigr) \circ \cdots \circ \sigma(x_1)$$

即系统用**同一条微观链**同时服务了一次单步拟合任务（在 $x_2$ 处）和一次多步复合拟合任务（从 $x_1$ 出发），形成计算程序层面的不可区分简并。路由混叠可由多种机制引起：组合耗尽（见下方推论）、$\sigma$ 的参数化约束、正则化、或有限精度表示等。

> **注（$\mathcal{F}^l \to \mathcal{F}$ 的计算程序等效）**：路由混叠的本质是级联系统 $\mathcal{F}^l$ 到单步系统 $\mathcal{F}$ 在 $\mathcal{X}_{sub}$ 上的**计算程序等效**。对每个触发混叠的对 $(x_1, x_2)$，$\mathcal{F}^l$ 从 $x_1$ 出发展开的完整 $l$-步宏观 $f$-链 $\sigma_l(x_1)$，恰好就是 $\mathcal{F}$ 在 $x_2$ 处单步调用的微观链 $\sigma(x_2)$。

**推论 2.4（组合耗尽下的路由混叠必然性，Necessity of Routing Aliasing under Combinatorial Exhaustion）**：
在度量 $d$ 下存在组合耗尽（$\sigma$ 退化为对 $F^{\le \mathcal{D}}$ 的满射）的复杂区域 $\mathcal{X}_{sub}$ 中，路由混叠**必然发生**。具体而言，对于任意一点 $x_1 \in \mathcal{X}_{sub}$，若其 $l$ 步宏观前向轨道保持在满射区域内（即 $\Phi^j(x_1) \in \mathcal{X}_{sub}$，$j = 0, \ldots, l-1$），且所诱导的复合微观链 $\sigma_l(x_1)$ 的总长度未超出微观深度上限（$|\sigma_l(x_1)| \le \mathcal{D}$），则必然存在 $x_2 \in \mathcal{X}_{sub}$ 使得 $\sigma(x_2) = \sigma_l(x_1)$。

**证明**：

1. $\forall\, j \in \{0, \ldots, l-1\}$：$\Phi^j(x_1) \in \mathcal{X}_{sub}$ $\Rightarrow$ $\sigma(\Phi^j(x_1)) \in \mathrm{Im}(\sigma|_{\mathcal{X}_{sub}})$。
2. $\sigma_l(x_1) = \sigma(\Phi^{l-1}(x_1)) \circ \cdots \circ \sigma(x_1)$，各因子均取自 $F^{\le \mathcal{D}}$，且 $|\sigma_l(x_1)| \leq \mathcal{D}$，故 $\sigma_l(x_1) \in F^{\le \mathcal{D}}$。
3. 由 $\sigma|_{\mathcal{X}_{sub}}$ 对 $F^{\le \mathcal{D}}$ 的满射性：$\exists\, x_2 \in \mathcal{X}_{sub}:\; \sigma(x_2) = \sigma_l(x_1)$。$\square$

---

### 2.3 迭代动力学与决策边界

本节刻画级联系统 $\mathcal{F}^l$ 的动力学稳定性——$\Phi$ 在多步迭代下的扰动传播行为，以及 $\sigma$-决策边界处的分辨率极限。

**命题 2.5（不动点收敛，Fixed-Point Convergence）**：设 $L < 1$，$（\mathcal{X}, d)$ 完备，则 $\Phi$ 存在唯一不动点 $x^* = \Phi(x^*)$，$\Phi$-轨道从任意初始点收敛：$\hat{h}_l \to x^*$。

**证明**：$L < 1$ 时 $\Phi$ 是完备度量空间 $(\mathcal{X}, d)$ 上的压缩映射，由 **Banach 压缩映射定理**直接得不动点存在唯一性及轨道收敛。$\square$

**命题 2.6（决策边界的路由分辨率极限，Routing Resolution Limit at Decision Boundaries）**：设 $L_{d'} < \infty$。若两状态 $a, b \in \mathcal{X}$ 被 $\sigma$ 分派至不同路径，产生 $d'$-偏离：

$$\Delta_{d'} \;\triangleq\; d'\bigl(\Phi(a),\, \Phi(b)\bigr) \;>\; 0$$

则输入在 $d'$ 下的间距满足下界：

$$d'(a, b) \;\geq\; \frac{\Delta_{d'}}{L_{d'}}$$

**证明**：

1. 由 $L_{d'} < \infty$：$\Delta_{d'} = d'(\Phi(a), \Phi(b)) \leq L_{d'} \cdot d'(a,b)$。
2. 移项：$d'(a,b) \geq \Delta_{d'}/L_{d'}$。$\square$

> **注（对分辨率死锁的结构性理解）**：当两点在 $d'$ 下的距离 $d'(a,b)$ 小于临界分辨率阈值 $\Delta_{d'}/L_{d'}$ 时，$\sigma$ 在数学上不可能将它们分派至产生 $\Delta_{d'}$ 偏离的不同路径。有限 $L_{d'}$ 为 $\sigma$ 的离散切割精度设定了**不可超越的分辨率极限**。


**命题 2.7（扰动的长链衰减，Long-chain Decay of Perturbations）**：在级联系统 $\mathcal{F}^l$ 中，设 $\hat{h}^{(A)}$、$\hat{h}^{(B)}$ 为两条从不同初始点出发的 $\Phi$-轨道。定义第 $j$ 步在伪度量 $d'$ 下的**有效扩张比** $L_{j,d'} \triangleq d'(\hat{h}_j^{(A)}, \hat{h}_j^{(B)}) / d'(\hat{h}_{j-1}^{(A)}, \hat{h}_{j-1}^{(B)}) \in \bar{\mathbb{R}}_+$（当 $L_{d'} < \infty$ 时满足 $L_{j,d'} \leq L_{d'}$）。设第 $k-1$ 步存在任意来源的**状态扰动** $\Delta_{k-1,d'} \triangleq d'(\hat{h}_{k-1}^{(A)}, \hat{h}_{k-1}^{(B)}) > 0$。若**尾部乘积** $\Theta_{k,l,d'} \triangleq \prod_{j=k}^l L_{j,d'} \to 0$（$l \to \infty$，即收缩步主导），则：

$$d'\!\bigl(\hat{h}_l^{(A)},\, \hat{h}_l^{(B)}\bigr) \;\leq\; \Theta_{k,l,d'} \;\cdot\; \Delta_{k-1,d'} \;\to\; 0$$

无论 $\Delta_{k-1,d'}$ 多大，迭代终态在 $d'$ 下均收敛——$\mathcal{F}^l$ 在 $d'$ 意义下**抹除第 $k-1$ 步之前的一切扰动**，均被尾部收缩机制彻底压制至零。

> **注（收缩与扩张的非对称性）**：收缩路径可无限延续（轨线越拉越近，不涉及任何发散），取 $l \to \infty$ 的极限是合法的（见 §1.2.1 注）。扩张路径则不具备此保证——这一非对称性是 IDFS 动力学中收缩与扩张行为的根本差异。

**特例（输入差异）**：取 $k = 1$，$\Delta_{0,d'} = d'(x_A, x_B)$，则退化为对原始输入差异的衰减：$d'(\hat{h}_l^{(A)}, \hat{h}_l^{(B)}) \leq \Theta_{1,l,d'} \cdot d'(x_A, x_B)$。

定义**有效区分深度** $l^\dagger_{d'} = \max\{l \mid \Theta_{k,l,d'} \geq \theta\}$（$\theta \in (0,1)$ 为可区分阈值），超过此深度后任意扰动均衰减至不可区分范围内。

**证明**：对局部 Lipschitz 条件连续应用，从第 $k$ 步截断：
$$d'(\hat{h}_l^{(A)}, \hat{h}_l^{(B)}) \leq \Theta_{k,l,d'} \cdot d'(\hat{h}_{k-1}^{(A)}, \hat{h}_{k-1}^{(B)}) = \Theta_{k,l,d'} \cdot \Delta_{k-1,d'}$$
$\Delta_{k-1,d'}$ 为有限正数，尾部乘积 $\Theta_{k,l,d'} \to 0$ 时右端趋零。$\square$


**命题 2.8（扰动的长链扩张，Long-chain Expansion of Perturbations）**：在级联系统 $\mathcal{F}^l$ 中，设从第 $k$ 步起至有限的第 $l$ 步，每一步 $j = k, \ldots, l$ 在伪度量 $d'$ 下均存在**扩张下界** $c_{j,d'} \geq 1$，使得：

$$d'\!\bigl(\hat{h}_j^{(A)},\, \hat{h}_j^{(B)}\bigr) \;\geq\; c_{j,d'} \cdot d'\!\bigl(\hat{h}_{j-1}^{(A)},\, \hat{h}_{j-1}^{(B)}\bigr)$$

定义**有限尾部扰动放大系数（下界）**：

$$\Pi_{k,l,d'}^{-} \;\triangleq\; \prod_{j=k}^{l} c_{j,d'}$$

设第 $k-1$ 步存在任意来源的**状态扰动** $\Delta_{k-1,d'} \triangleq d'(\hat{h}_{k-1}^{(A)}, \hat{h}_{k-1}^{(B)}) > 0$，则局部有限步内的终态 $d'$-距离必然被严格放大：

$$d'\!\bigl(\hat{h}_l^{(A)},\, \hat{h}_l^{(B)}\bigr) \;\geq\; \Pi_{k,l,d'}^{-} \cdot \Delta_{k-1,d'}$$

**证明**：逐步应用扩张下界条件：$d'(\hat{h}_k^{(A)}, \hat{h}_k^{(B)}) \geq c_{k,d'} \cdot \Delta_{k-1,d'}$，$d'(\hat{h}_{k+1}^{(A)}, \hat{h}_{k+1}^{(B)}) \geq c_{k+1,d'} \cdot c_{k,d'} \cdot \Delta_{k-1,d'}$，归纳得 $d'(\hat{h}_l^{(A)}, \hat{h}_l^{(B)}) \geq \Pi_{k,l,d'}^{-} \cdot \Delta_{k-1,d'}$。$\square$

**特例（输入差异）**：取 $k = 1$，$\Delta_{0,d'} = d'(x_A, x_B)$，则退化为对原始输入差异的有限步放大：$d'(\hat{h}_l^{(A)}, \hat{h}_l^{(B)}) \geq \Pi_{1,l,d'}^{-} \cdot d'(x_A, x_B)$。

### 2.4 单值映射的值竞争

$\Phi: \mathcal{X} \to \mathcal{X}$ 是单值映射——对每个输入 $y$，$\Phi(y)$ 只能取唯一值。当多个拟合目标在同一点竞争 $\Phi$ 的输出时，系统必须做出不可兼得的取舍。以下命题刻画了可逆映射引发的一类典型竞争。

**命题 2.9（可逆映射的值竞争，Value Competition under Invertible Rules）**：设 $r \in R$ 为可逆映射，$(r, \mathcal{X}_r) \in \mathcal{S}$。若 $\exists\, y \in \mathcal{X}_r \cap r(\mathcal{X}_r)$ 使得 $r(y) \neq r^{-1}(y)$，则 $y$ 是 $\tau$-不可完美拟合点：采样约束将 $\Phi(y)$ 锁定为 $\Phi(y) \approx r(y)$，使得 $d(\Phi(y), r^{-1}(y)) \approx d(r(y), r^{-1}(y)) > 0$——$\Phi$ 在 $y$ 处**物理上不可能**同时逼近 $r(y)$ 与 $r^{-1}(y)$。

**证明**：由 $y \in \mathcal{X}_r$，采样约束给出 $d(\Phi(y), r(y)) \leq \varepsilon_r$。以 $r(y)$ 为桥接点：

$$d(\Phi(y), r^{-1}(y)) \;\geq\; d(r(y), r^{-1}(y)) - \varepsilon_r$$

当 $r(y) \neq r^{-1}(y)$ 时，$d(r(y), r^{-1}(y)) > 0$，对充分小 $\varepsilon_r$，下界恒正——$\Phi(y)$ 被锁定在 $r(y)$ 附近，不可能同时接近 $r^{-1}(y)$。$\square$

**示例**：$r(x) = 2x$ 在 $\mathcal{X}_r = [0, 1]$，$r(\mathcal{X}_r) = [0, 2]$。在 $y = 0.5 \in \mathcal{X}_r \cap r(\mathcal{X}_r)$：$r(0.5) = 1$，$r^{-1}(0.5) = 0.25$。$\Phi(0.5) \approx 1$（采样约束），故 $d(\Phi(0.5), r^{-1}(0.5)) \approx 0.75$——由 $r$ 的几何决定，不可消除。

> **注（与 §1.4 的关系）**：值竞争是 §1.4 定义的 $\tau$-不可完美拟合集的一个**充分条件**：可逆映射 $r$ 在域重叠区域自动产生逆向拟合的不可完美点。对单值 $\Phi$ 而言，此竞争在裸数据层面**不可消解**。实际系统中通常不会遇到此问题，因为真实输入往往携带任务上下文或环境条件等附加信息，使得同一裸数据 $y$ 在不同任务下对应完整输入空间中的不同点——域重叠在完整输入空间中自然消失。

----
*[IDFS] ⊢ [GLENZLI] ⊢ [Part XX] ⊢ [02-idfs-properties] ⊢ [1791b83b01814afa]*
