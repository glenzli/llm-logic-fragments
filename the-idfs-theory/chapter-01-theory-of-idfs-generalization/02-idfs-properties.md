## IDFS 的基本性质

### 2.1 路由结构

**命题 1（组合耗尽与路由满射，Combinatorial Exhaustion and Routing Surjection）**：
设 IDFS $(F, \sigma)$ 在 $\mathcal{X}$ 的某子集 $\mathcal{X}_{sub}$ 上以容差 $\epsilon$ 近似了由微观采样集 $\mathcal{S}$ 定义的目标集 $\mathcal{M}_\mathcal{S}$。若目标集的度量熵远超底层基算子的连续变形熵，即产生巨大的**信息阻抗（Information Impedance）**：
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



**定义（路由混叠，Routing Aliasing）**：设 IDFS $(F, \sigma)$ 在子集 $\mathcal{X}_{sub} \subseteq \mathcal{X}$ 上运作。称在 $\mathcal{X}_{sub}$ 上存在第 $l$ 阶**路由混叠**，若存在 $x_1, x_2 \in \mathcal{X}_{sub}$ 使得模型在 $x_2$ 处的**单步微观路由决策**与从 $x_1$ 出发的 **$l$ 步宏观计算程序**完全等同：

$$\sigma(x_2) \;=\; \sigma_l(x_1) \;\triangleq\; \sigma\bigl(\Phi^{l-1}(x_1)\bigr) \circ \cdots \circ \sigma(x_1)$$

即系统用**同一条微观链**同时服务了一次单步任务（在 $x_2$ 处）和一次多步推理任务（从 $x_1$ 出发），形成计算程序层面的不可区分简并。路由混叠可由多种机制引起：组合耗尽（见下方推论）、$\sigma$ 的参数化约束、正则化、或有限精度表示等。

**推论（组合耗尽下的路由混叠必然性，Necessity of Routing Aliasing under Combinatorial Exhaustion）**：
在存在组合耗尽（$\sigma$ 退化为对 $F^{\le \mathcal{D}}$ 的满射）的复杂区域 $\mathcal{X}_{sub}$ 中，路由混叠**必然发生**。具体而言，对于任意一点 $x_1 \in \mathcal{X}_{sub}$，若其 $l$ 步宏观前向轨道保持在满射区域内（即 $\Phi^j(x_1) \in \mathcal{X}_{sub}$，$j = 0, \ldots, l-1$），且所诱导的复合微观链 $\sigma_l(x_1)$ 的总长度未超出微观深度上限（$|\sigma_l(x_1)| \le \mathcal{D}$），则必然存在 $x_2 \in \mathcal{X}_{sub}$ 使得 $\sigma(x_2) = \sigma_l(x_1)$。

**证明**：
由假设，$\Phi^j(x_1) \in \mathcal{X}_{sub}$ 保证了级联展开 $\sigma_l(x_1)$ 中的每一步 $\sigma(\Phi^j(x_1))$ 均处于满射区域内。$\sigma_l(x_1)$ 作为 $F$ 中底层算子首尾相接构成的链，其总长度 $|\sigma_l(x_1)| \leq \mathcal{D}$，故 $\sigma_l(x_1) \in F^{\le \mathcal{D}}$。由 $\sigma$ 在 $\mathcal{X}_{sub}$ 上对 $F^{\le \mathcal{D}}$ 的满射性，原像空间中必存在 $x_2 \in \mathcal{X}_{sub}$ 使得 $\sigma(x_2) = \sigma_l(x_1)$。$\square$


---

### 2.2 动力系统与决策流形

> **注**：以下命题刻画 IDFS 迭代映射 $\Phi$ 本身的动力学稳定性，不直接依赖 CAC 误差上界中的 $\varepsilon_{i_j}$、$\delta_j$ 结构；而是关于 Lipschitz 算子在长链迭代下的扰动传播行为及 $\sigma$-决策边界的不连续性质。

**命题 2（不动点收敛，Fixed-Point Convergence）**：若 $\Phi \in \mathrm{Lip}_L(\mathcal{X})$（全局）且 $L < 1$，$(\mathcal{X}, d)$ 完备，则 $\Phi$ 存在唯一不动点 $x^* = \Phi(x^*)$，$\Phi$-轨道从任意初始点收敛：$\hat{h}_l \to x^*$。

**证明**：$L < 1$ 时 $\Phi$ 是完备度量空间 $(\mathcal{X}, d)$ 上的压缩映射，由 **Banach 压缩映射定理**直接得不动点存在唯一性及轨道收敛。$\square$

**命题 3（扰动的长链衰减，Long-chain Decay of Perturbations）**：设 f-链步骤 $1, \ldots, l$ 的路径局部 Lipschitz 为 $L_j$。设第 $k-1$ 步存在任意来源的**状态扰动** $\Delta_{k-1} \triangleq d(\hat{h}_{k-1}^{(A)}, \hat{h}_{k-1}^{(B)}) > 0$（注：$\Delta_{k-1}$ 为两条轨道之间的状态差，区别于 CAC 主定理中的采样域偏离 $\delta_j$）——无论其来自原始输入差异还是前 $k-1$ 步的近似误差积累——若**尾部乘积** $\Theta_{k,l} \to 0$（$l \to \infty$，即 $\sum_{j=k}^{\infty} \log L_j = -\infty$，收缩步主导），则：

$$d\!\bigl(\hat{h}_l^{(A)},\, \hat{h}_l^{(B)}\bigr) \;\leq\; \Theta_{k,l} \;\cdot\; \Delta_{k-1} \;\to\; 0$$

无论 $\Delta_{k-1}$ 多大，f-chain 终态均收敛——IDFS **抹除第 $k-1$ 步之前的一切扰动**，无论扰动来自输入差异、近似误差还是任何其他来源，均被尾部收缩机制彻底压制至零。

**特例（输入差异）**：取 $k = 1$，$\Delta_0 = d(x_A, x_B)$，则退化为对原始输入差异的衰减：$d(\hat{h}_l^{(A)}, \hat{h}_l^{(B)}) \leq \Theta_{1,l} \cdot d(x_A, x_B)$。

定义**有效区分深度** $l^\dagger = \max\{l \mid \Theta_{k,l} \geq \theta\}$（$\theta \in (0,1)$ 为可区分阈值），超过此深度后任意扰动均衰减至不可区分范围内。

**证明**：对局部 Lipschitz 条件连续应用，从第 $k$ 步截断：
$$d(\hat{h}_l^{(A)}, \hat{h}_l^{(B)}) \leq \Theta_{k,l} \cdot d(\hat{h}_{k-1}^{(A)}, \hat{h}_{k-1}^{(B)}) = \Theta_{k,l} \cdot \Delta_{k-1}$$
$\Delta_{k-1}$ 为有限正数，尾部乘积 $\Theta_{k,l} \to 0$ 时右端趋零。$\square$

> **注（对偶结构）**：$\Theta_{1,l}$（整条链的路径乘积，即 $\prod_{j=1}^l L_j$）与 $\Lambda_l$ 控制系统的两个方向：$\Lambda_l$ 衡量**误差的累积放大**（单步近似误差如何沿链传播），$\Theta_{1,l}$ 衡量**输入分离的保持程度**（不同输入的输出能否区分）。收缩机制（$L_j < 1$）同时压低 $\Theta_{1,l}$（输出坍缩，输入可区分性消失）和 $\Lambda_l$（抑制误差累积）；扩张机制（$L_j > 1$）则反之。两者的平衡决定了 IDFS 的长链稳定性。

**命题 4（扰动的长链爆炸，Long-chain Explosion of Perturbations）**：设从第 $k$ 步（$k \geq 1$）起，f-链的每一步 $j = k, \ldots, l$ 均存在**扩张下界** $c_j \geq 1$，使得：

$$d\!\bigl(\hat{h}_j^{(A)},\, \hat{h}_j^{(B)}\bigr) \;\geq\; c_j \cdot d\!\bigl(\hat{h}_{j-1}^{(A)},\, \hat{h}_{j-1}^{(B)}\bigr)$$

定义**尾部扰动放大系数（下界）**：

$$\Pi_{k,l}^{-} \;\triangleq\; \prod_{j=k}^{l} c_j$$

设第 $k-1$ 步存在任意来源的**状态扰动** $\Delta_{k-1} \triangleq d(\hat{h}_{k-1}^{(A)}, \hat{h}_{k-1}^{(B)}) > 0$——无论其来自原始输入差异还是前 $k-1$ 步的近似误差积累——则 f-chain 终态距离满足：

$$d\!\bigl(\hat{h}_l^{(A)},\, \hat{h}_l^{(B)}\bigr) \;\geq\; \Pi_{k,l}^{-} \cdot \Delta_{k-1}$$

**进一步**：若 $\Pi_{k,l}^{-} \to \infty$（等价于 $\sum_{j=k}^{\infty} \log c_j = +\infty$），则终态距离趋无穷——无论 $\Delta_{k-1}$ 多小，只要非零，尾部扩张机制将其**无限放大**。前 $k-1$ 步如何产生 $\Delta_{k-1}$ 无关紧要，爆炸由第 $k$ 步之后的乘积驱动。

**特例（输入差异）**：取 $k = 1$，$\Delta_0 = d(x_A, x_B)$，则退化为对原始输入差异的放大：$d(\hat{h}_l^{(A)}, \hat{h}_l^{(B)}) \geq \Pi_{1,l}^{-} \cdot d(x_A, x_B)$。

**证明**：对扩张下界条件从第 $k$ 步起连续应用，链式展开得 $d(\hat{h}_l^{(A)}, \hat{h}_l^{(B)}) \geq \Pi_{k,l}^{-} \cdot \Delta_{k-1}$。$\Delta_{k-1} > 0$ 为有限正数，$\Pi_{k,l}^{-} \to \infty$ 时右端趋无穷。$\square$

> **注（驱动条件是尾部乘积；扰动来源无关紧要）**：起始步 $k$ 任意，前 $k-1$ 步可扩张、可收缩、可无约束，不影响结论——关键只是 $\Delta_{k-1} > 0$ 存在。尾部乘积 $\Pi_{k,l}^{-} \to \infty$ 是爆炸的充分条件，而非要求每步 $c_j > 1$（例如 $c_j = 1 + 1/j^2$ 时乘积收敛，不会爆炸）。与命题 3 完全对称：命题 3 中收缩尾部乘积将任意有限扰动压至零，命题 4 中扩张尾部乘积将任意非零扰动放大至无穷——两者均与扰动的历史来源无关。命题 5 是命题 4 在 IDFS $\sigma$-决策边界处的**结构性实例**——边界跨越时 $c_j \to \infty$，使 $\Pi_{k,l}^{-}$ 以极端速度发散。

---

**命题 5（决策边界的局部曲率爆炸，Decision Boundary Curvature Explosion）**：设 IDFS $(F, \sigma)$ 如 §1.2 所定义。若 f-链第 $j$ 步中，近似状态 $\hat{h}_{j-1}$ 与理想状态 $h^*_{j-1}$ 被 $\sigma$ 选到了不同的函数——即 $\sigma(\hat{h}_{j-1}) = f_k \neq f_{k'} = \sigma(h^*_{j-1})$——且两函数在 $\hat{h}_{j-1}$ 处的输出差有宏观下界：


$$\Delta \;\triangleq\; d\bigl(f_k(\hat{h}_{j-1}),\, f_{k'}(\hat{h}_{j-1})\bigr) \;>\; 0, \qquad k \neq k'$$

则路径局部 Lipschitz 常数满足：

$$L_j \;=\; \frac{d\bigl(\Phi(\hat{h}_{j-1}),\, \Phi(h^*_{j-1})\bigr)}{d(\hat{h}_{j-1},\, h^*_{j-1})} \;\geq\; \frac{\Delta - L_{f_{k'}} \cdot d(\hat{h}_{j-1},\, h^*_{j-1})}{d(\hat{h}_{j-1},\, h^*_{j-1})}$$

当误差 $e_{j-1} = d(\hat{h}_{j-1}, h^*_{j-1}) \to 0$ 而两点仍跨越边界时，$L_j \to \infty$。

**证明**：设 $a = \hat{h}_{j-1}$，$b = h^*_{j-1}$，$\sigma(a) = f_k$，$\sigma(b) = f_{k'}$（$k \neq k'$）。则：

$$d\bigl(\Phi(a),\, \Phi(b)\bigr) = d\bigl(f_k(a),\, f_{k'}(b)\bigr)$$

由三角不等式：

$$d\bigl(f_k(a),\, f_{k'}(b)\bigr) \;\geq\; d\bigl(f_k(a),\, f_{k'}(a)\bigr) - d\bigl(f_{k'}(a),\, f_{k'}(b)\bigr) \;\geq\; \Delta - L_{f_{k'}} \cdot d(a, b)$$

其中 $L_{f_{k'}}$ 是函数 $f_{k'}$ 的 Lipschitz 常数（有界量）。两边除以 $d(a,b)$：

$$L_j \;\geq\; \frac{\Delta}{d(a,b)} - L_{f_{k'}} \;\xrightarrow{d(a,b) \to 0}\; +\infty \qquad \square$$

> **注（与命题 4 的关系）**：命题 5 是**命题 4 在 IDFS $\sigma$-边界处的结构性实例**。命题 4 要求以 co-Lipschitz 下界 $c_j > 1$ 作为前提条件；而命题 5 表明，当两点跨越 $\sigma$-决策边界时，该条件由 IDFS 结构**自动满足**，且下界以 $c_j \geq \Delta/d(a,b) - L_{f_{k'}} \to +\infty$ 的速度发散——即 IDFS 在边界附近天然具备极端扩张性。这是 $\sigma$ 将连续状态空间映射到离散函数集的内在代价：**边界处的不连续性产生无界局部扩张，是命题 4 最极端的退化情形**。

> **注（与§4 推论 2 的三元纠缠的关系）**：§4 推论 2 的注指出，将分析从采样域 $\mathcal{X}(r)$ 扩展至 $\mathrm{dom}(r)$ 时，$\sigma$ 的决策边界使全局 Lipschitz 常数 $L$ 无法刻画 $\Phi$ 在 $\mathcal{X}(r)$ 外的光滑度，由此产生 $(\varepsilon_r, L, \sigma)$ 三元纠缠。命题 5 给出了这一现象的精确机制：$\sigma$ 在 $\partial\mathcal{X}(r)$ 处选择不同函数，等价于跨越决策边界，此时路径局部 Lipschitz $L_j \to \infty$——这正是单一标量 $L$ 失效、$\sigma$ 必须显式出现的数学来源。换言之，**命题 5 是三元纠缠的形式基础**：正是 $\sigma$-边界处的 $L_j$ 无界性，使得 $\mathrm{dom}(r)$ 上的变分分析无法仅依赖 $(\varepsilon_r, L)$ 二元完成。此外，$L_j \to \infty$ 在 CAC 精细界中产生**双重不对称爆炸**：ε-项权重为 $\Theta_{j+1,l}$（不含本步 $L_j$），而 δ-项权重为 $\Theta_{j,l} = L_j \cdot \Theta_{j+1,l}$——因此同一次边界跨越中，δ 代价的爆炸速度比 ε 代价**额外快一个 $L_j$ 因子**，采样域偏离在边界附近会被优先且更剧烈地放大。
