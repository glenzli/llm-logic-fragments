## 逼近误差的下界

### 4.1 组合近似瓶颈定理（CAB）

**定理（组合近似瓶颈定理，Compositional Approximation Bottleneck，CAB）**：
设系统以容差集 $\mathcal{E}$ 拟合了微观采样集 $\mathcal{S}$。对任意长度为 $l$ 的宏观有效链 $q \in \mathcal{T}_l$，设其对应的端到端物理系统映射为 $l$ 次迭代的复合 $\Phi_q = \Phi \circ \dots \circ \Phi$。

设某输入对 $x, y \in \mathrm{dom}(q)$ 满足以下空间相态（$x, y \in \mathrm{dom}(q)$ 保证理想链 $q$ 在两点处可执行，即 $q(x), q(y) \neq \bot$；近似轨道 $\Phi_q(x), \Phi_q(y)$ 由 IDFS 闭合性保证为 $\mathcal{X}$ 中的良定义元素）：
1. **输入分离与目标跃迁**：起点的初始距离为 $d(x, y) = \delta > 0$，但在理想长链 $q$ 下的映射距离跃迁为 $d(q(x), q(y)) = \Delta > 0$。
2. **拟合参数**：系统在参考点 $x$ 处的端到端逼近误差（拟合残差）记为 $\varepsilon_x \triangleq d(\Phi_q(x), q(x)) \geq 0$。
3. **系统扩张极限**：系统宏观映射下的最大拉伸距离受到 $l$-链累积扩张律的限制，即 $d(\Phi_q(x), \Phi_q(y)) \leq \Theta_{1,l} \cdot \delta$（其中 $\Theta_{1,l}$ 为宏观全链 $l$ 步的路径局部 Lipschitz 乘积上界；若不知具体路径，可保守地取先验可计算的全局界 $L^l$）。

定义**末端结构瓶颈（Intrinsic Structural Bottleneck）**为：
$$\varepsilon_{y,\text{out}} = \min_{f \in F}\; \inf_{h \in \mathcal{X}} d(f(h),\, q(y))$$
即遍历所有可能的末端算子 $f \in F$ 和所有可能的中间态 $h$，系统能够达到的与目标像点 $q(y)$ 的最小距离。无论 $\sigma$ 在最后一步如何选择算子，该下界均成立。

**定理结论**：系统在点 $y$ 处的端到端宏观泛化误差 $\varepsilon^*_y \triangleq d(\Phi_q(y), q(y))$（作为容差集 $\mathcal{E}^*$ 的具体表现），存在不可压缩的绝对数学下界：
$$\varepsilon^*_y \;\geq\; \max \Big( |\Delta - \varepsilon_x| - \Theta_{1,l} \cdot \delta, \;\; \varepsilon_{y,\text{out}} \Big)$$

**证明**：
先推导**拓扑死锁（Topological Deadlock）**：
考察系统在点 $y$ 处的逼近误差：$\varepsilon^*_y = d(\Phi_q(y), q(y))$。
步骤 1（正向三角不等式）：以目标变分 $\Delta$ 为基准展开四边形度量链：
$$d(q(x), q(y)) \;\leq\; d(q(x), \Phi_q(x)) \;+\; d(\Phi_q(x), \Phi_q(y)) \;+\; d(\Phi_q(y), q(y))$$
代入已知条件与参量：
$$\Delta \;\leq\; \varepsilon_x \;+\; \Theta_{1,l} \cdot \delta \;+\; \varepsilon^*_y$$
移项得出 $\varepsilon^*_y$ 的第一重下界 (I)：
$$\varepsilon^*_y \;\geq\; \Delta - \varepsilon_x - \Theta_{1,l} \cdot \delta$$
步骤 2（反向三角不等式）：以参考点残差 $\varepsilon_x$ 为基准逆向展开：
$$d(q(x), \Phi_q(x)) \;\leq\; d(q(x), q(y)) \;+\; d(q(y), \Phi_q(y)) \;+\; d(\Phi_q(y), \Phi_q(x))$$
代入已知条件与参量：
$$\varepsilon_x \;\leq\; \Delta \;+\; \varepsilon^*_y \;+\; \Theta_{1,l} \cdot \delta$$
移项得出 $\varepsilon^*_y$ 的第二重下界 (II)：
$$\varepsilon^*_y \;\geq\; \varepsilon_x - \Delta - \Theta_{1,l} \cdot \delta$$
由于 $\varepsilon^*_y$ 必须同时满足 (I) 与 (II)，得出绝对值下界：
$$\varepsilon^*_y \;\geq\; |\Delta - \varepsilon_x| - \Theta_{1,l} \cdot \delta$$

再推导**末端拓扑结构瓶颈（Terminal Topological Bottleneck）**：
设系统在最后一步对 $y$ 实际选择的末端算子为 $f^{(y)} \in F$（由 $\sigma$ 在近似轨道的最后一步决定，不需先验知道）。设前置映射产生中间态 $h_y$，则：
$$\varepsilon^*_y = d(f^{(y)}(h_y),\, q(y)) \;\geq\; \inf_{h \in \mathcal{X}} d(f^{(y)}(h),\, q(y)) \;\geq\; \min_{f \in F}\; \inf_{h \in \mathcal{X}} d(f(h),\, q(y)) \;=\; \varepsilon_{y,\text{out}}$$

综上所述，逼近误差 $\varepsilon^*_y$ 必须同时满足上述两大独立限制：
$$\varepsilon^*_y \;\geq\; \max \Big( |\Delta - \varepsilon_x| - \Theta_{1,l} \cdot \delta, \;\; \varepsilon_{y,\text{out}} \Big)$$
$\square$

> **注（拟合跷跷板效应，The Fitting Seesaw Effect）**：项 $|\Delta - \varepsilon_x| - \Theta_{1,l} \cdot \delta$ 揭示了一个非对称的“跷跷板效应”。当系统的全局扩张率受限（$\Theta_{1,l}$ 较小）而目标链 $q$ 在 $(x, y)$ 间呈现剧烈变分（$\Delta$ 极大）时：若在参考点 $x$ 处达到完美拟合（$\varepsilon_x \to 0$），则 $y$ 处的宏观容差被刚性托底至 $\varepsilon^*_y \geq \Delta - \Theta_{1,l}\delta$。即系统**不可能同时在相邻两点上实现任意低误差**——局部的极高精度必然引爆邻近的泛化误差。

> **注（末端结构瓶颈 $\varepsilon_{y,\text{out}}$ 的含义）**：项 $\varepsilon_{y,\text{out}}$ 剖离出了 IDFS 末端算子层的结构刚性。无论前置映射 $\Phi'_q$ 将中间态流形扭曲得多么复杂，IDFS 的端到端最终输出必须经过某个底层算子 $f \in F$ 映射回输出空间。若目标像点 $q(y)$ 不在任何 $f \in F$ 的可达集 $\bigcup_{f \in F} f(\mathcal{X})$ 中，则 $\varepsilon_{y,\text{out}} > 0$ 成为不可消除的常数瓶颈：此时前置计算中的一切精妙运算皆无用武之地，端到端误差被末端算子的结构底盖死死卡定。

**推论 1（CAB 界的类紧性，Class-Level Tightness of the CAB Bound）**：对任意给定的标量 $\varepsilon_x \geq 0$、$\Delta > 0$、$\delta > 0$、$L > 0$ 和正整数 $l$，只要 $\Delta > \varepsilon_x + L^l\delta$（即拓扑死锁界为正），**一定存在**具体的 IDFS 构造 $(F, \sigma)$ 使得 CAB 拓扑死锁界精确取等：

$$\varepsilon^*_y \;=\; \Delta \;-\; \varepsilon_x \;-\; \Theta_{1,l} \cdot \delta$$

即：CAB 的拓扑死锁下界在 IDFS 函数类意义下是**不可改善的**。

**证明（存在性构造）**：取 $\mathcal{X} = \mathbb{R}$，$d(x,y) = |x-y|$，设 $x = 0$，$y = \delta$。

**目标链的构造**：令 $q(z) = \alpha z$（$\alpha = \Delta/\delta$），则 $q(0) = 0$，$q(\delta) = \Delta$，目标变分精确等于 $\Delta$。

**系统的构造**：令 $\Phi(z) = Lz + a$（线性映射，$\mathrm{Lip}(\Phi) = L$ 精确），其中 $a = \varepsilon_x \cdot \frac{L-1}{L^l - 1}$（$L \neq 1$ 时；$L = 1$ 时取 $a = \varepsilon_x / l$）。则 $l$ 步复合：

$$\Phi^l(z) \;=\; L^l z \;+\; a \cdot \frac{L^l - 1}{L - 1} \;=\; L^l z \;+\; \varepsilon_x$$

**验证各量**：
- 路径乘积：$\Theta_{1,l} = L^l$（每步 $L_j = L$，精确）。
- 参考点残差：$\varepsilon_x = d(\Phi^l(0), q(0)) = |\varepsilon_x - 0| = \varepsilon_x$（精确）。
- 系统输出距离：$d(\Phi^l(0), \Phi^l(\delta)) = L^l\delta = \Theta_{1,l}\delta$（**线性映射精确取等 Lipschitz 界**）。
- 目标点误差：$\varepsilon^*_y = d(\Phi^l(\delta), q(\delta)) = |L^l\delta + \varepsilon_x - \Delta|$。由假设 $\Delta > \varepsilon_x + L^l\delta$，故 $\varepsilon^*_y = \Delta - \varepsilon_x - L^l\delta$。

**等号成立的机制**：在 $\mathbb{R}$ 上，四点 $q(x) = 0$, $\Phi^l(x) = \varepsilon_x$, $\Phi^l(y) = \varepsilon_x + L^l\delta$, $q(y) = \Delta$ 沿实数轴**同向有序排列**，三角不等式精确退化为等式——中间两点完全"夹在"两个目标点之间，无任何几何抵消。$\square$

> **注（末端瓶颈界的紧性）**：$\varepsilon_{y,\text{out}} = \inf_h d(f_\text{out}(h), q(y))$ 的取等同样可构造实现：令前置映射 $\Phi'_q$ 恰好将 $y$ 映射到最优中间态 $h^* = \arg\min_h d(f_\text{out}(h), q(y))$，则 $\varepsilon^*_y = d(f_\text{out}(h^*), q(y)) = \varepsilon_{y,\text{out}}$。因此 CAB 界的两项均可独立取等，整个 $\max$ 在函数类意义下紧确。

**定义（映射的局部变分下界，Local Variation Lower Bound）**：设 $(\mathcal{X}, d)$ 为度量空间。称映射 $r \in \Omega$ 在子集 $\mathcal{X}_r \subseteq \mathcal{X}$ 上具有 **$(\rho, \Delta)$-变分**，若存在 $x, y \in \mathcal{X}_r$ 使得：

$$d(x, y) \;\leq\; \rho \quad \text{且} \quad d\bigl(r(x), r(y)\bigr) \;\geq\; \Delta$$

即 $r$ 在 $\rho$-邻域内存在幅度不小于 $\Delta$ 的剧烈跳变。（注：此处 $\rho$ 为变分尺度，与 CAC 定理中的采样域偏离 $\delta_j$ 含义不同。）

**推论 2（近似误差的变分下界，Variation Bound on Approximation Error）**：设 $\Phi \in \mathrm{Lip}_L(\mathcal{X})$。设 $(r, \mathcal{X}_r) \in \mathcal{S}$，$r$ 在 $\mathcal{X}_r$ 上具有 $(\rho, \Delta)$-变分，记 $\varepsilon_r = \sup_{z \in \mathcal{X}_r} d(\Phi(z), r(z))$。则必然成立：

$$2\varepsilon_r \;+\; L \cdot \rho \;\geq\; \Delta$$

**证明（由 CAB 特化）**：取满足 $(\rho, \Delta)$-变分条件的点对 $x, y \in \mathcal{X}_r$。将 CAB 拓扑死锁界特化至 $l = 1$（单步，$\Theta_{1,1} = L$），以 $q = r$、$\delta = d(x,y) \leq \rho$、$\Delta_{q} = d(r(x), r(y)) \geq \Delta$：

$$\varepsilon^*_y \;\geq\; \Delta_q - \varepsilon_x - L\delta \;\geq\; \Delta - \varepsilon_x - L\rho$$

由 $x, y \in \mathcal{X}_r$，两点的误差均受同一 sup 约束：$\varepsilon_x \leq \varepsilon_r$，$\varepsilon^*_y \leq \varepsilon_r$。代入上式：$\varepsilon_r \geq \Delta - \varepsilon_r - L\rho$，即 $2\varepsilon_r + L\rho \geq \Delta$。$\square$

> **注（三方互斥律）**：式 $2\varepsilon_r + L\rho \geq \Delta$ 刻画了三个量的内在紧张：局部变分幅度 $\Delta/\rho$、全局光滑度 $L$、单步近似误差 $\varepsilon_r$ 三者不能同时任意小。若要近似具有高局部变分（$\Delta/\rho \gg L$）的 $r$，则**近似误差必然不小于** $\varepsilon_r \geq (\Delta - L\rho)/2$。

> **注（与 CAC 的联系）**：推论 2 中的 $\varepsilon_r$ 即 CAC 主定理中第 $j$ 步的单步近似误差 $\varepsilon_{i_j} = \sup_{x \in \mathcal{X}(r_{i_j})} d(\Phi(x), r_{i_j}(x))$（§1.3）。推论 2 给出 $\varepsilon_{i_j}$ 的**结构性下界**：只要 $r_{i_j}$ 在采样域内具有 $(\rho, \Delta)$-变分，就有 $\varepsilon_{i_j} \geq (\Delta - L\rho)/2$。将此下界代入 CAC 精细界，第 $j$ 步的近似误差贡献至少为 $\frac{\Delta - L\rho}{2} \cdot \Theta_{j+1,l}$——这是 $r_{i_j}$ 的局部变分结构对链式误差传播的**不可规避的底部贡献**。

> **注（扩展到 $\mathrm{dom}(r)$ 时的三元纠缠）**：推论 2 的分析严格限于采样域 $\mathcal{X}(r)$，其中 $\sigma$ 隐含于 $\Phi$ 的构造而不显式出现，两元张力 $(\varepsilon_r, L)$ 足以刻画。若将分析扩展至整个 $\mathrm{dom}(r) \supseteq \mathcal{X}(r)$，则在 $\mathrm{dom}(r) \setminus \mathcal{X}(r)$ 的区域内，$\Phi(z) = \sigma(z)(z)$ 不受采样约束，$\sigma$ 的决策边界可能在 $\partial\mathcal{X}(r)$ 处被激活：由§6 命题 4，跨越边界时路径局部 Lipschitz $L_j \to \infty$，全局常数 $L$ 不再能刻画 $\Phi$ 在 $\mathcal{X}(r)$ 外的光滑度。此时变分约束涉及**三元纠缠** $(\varepsilon_r,\, L,\, \sigma)$——三者无法分别独立优化，对 $\mathrm{dom}(r)$ 的分析须同时约束 $\sigma$ 在 $\partial\mathcal{X}(r)$ 处的边界曲率。因此推论 2 的主体保持在 $\mathcal{X}(r)$ 上以确保形式严格性；三元纠缠的正式处理见§6 命题 4。

**命题 1（逼近可行性条件，Approximation Feasibility Condition）**：由 CAC 定理（§3，上界）与 CAB 定理（下界）联合推得。设 IDFS $\mathcal{F} = (F, \sigma)$ 以微观容差 $\varepsilon_{max}$ 和微观偏离 $\delta_{max}$ 拟合了采样集 $\mathcal{S}$。对任意有效链 $q \in \mathcal{T}_l$ 和任意 $x, y \in \mathrm{dom}(q)$（$d(x,y) = \delta$），记目标变分 $\Delta = d(q(x), q(y))$。

定义**逼近阈值（Approximation Threshold）**：

$$\mathcal{A}_l(\delta) \;\triangleq\; \underbrace{\Theta_{1,l} \cdot \delta}_{\text{拉伸预算}} \;+\; \underbrace{\varepsilon_{max} \cdot \Lambda_l}_{\text{拟合预算}} \;+\; \underbrace{\delta_{max} \cdot \Gamma_l}_{\text{偏离预算}}$$

则系统在点 $y$ 处的宏观逼近误差满足：

$$\varepsilon^*_y \;\geq\; \Delta \;-\; \mathcal{A}_l(\delta)$$

**含义**：若目标变分 $\Delta > \mathcal{A}_l(\delta)$，则即使系统对参考点 $x$ 的拟合达到 CAC 所允许的最优水平，$y$ 处的误差仍存在不可压缩的正下界 $\varepsilon^*_y \geq \Delta - \mathcal{A}_l(\delta) > 0$，对任何 IDFS 的设计方式均成立。

**证明**：由 CAB 拓扑死锁界：$\varepsilon^*_y \geq \Delta - \varepsilon_x - \Theta_{1,l}\delta$。由 CAC 定理（形式 A 均匀化）：$\varepsilon_x \leq \varepsilon_{max}\Lambda_l + \delta_{max}\Gamma_l$。代入消去 $\varepsilon_x$ 即得。$\square$

> **注（三项预算的正交含义）**：逼近阈值 $\mathcal{A}_l(\delta)$ 分解为三个彼此独立、可分别归因的预算项，分别界定了系统在三个正交方向上的逼近资源：
> - **拉伸预算** $\Theta_{1,l}\delta$：系统的动力学扩张能力——由 Lipschitz 尾部乘积 $\Theta_{1,l}$ 和输入距离 $\delta$ 共同决定，衡量系统能从给定的输入间距中"放大"出多少输出间距；
> - **拟合预算** $\varepsilon_{max}\Lambda_l$：微观近似误差的累积放大——每步的最坏拟合误差 $\varepsilon_{max}$ 经尾部扩张系数 $\Lambda_l$ 累积传播后的总容差空间；
> - **偏离预算** $\delta_{max}\Gamma_l$：采样域偏离的累积放大代价——理想轨道偏离采样域引入的额外误差，经 $\Gamma_l$ 累积传播。
>
> 三项之和即为系统所能承受的**目标变分天花板**：低于此天花板，系统有足够的资源逼近目标变分；高于此天花板，逼近必然失败。

> **注（饱和体制下的变分封顶）**：在§3 推论 5 的饱和条件下（$\Lambda_\infty < \infty$，$\Gamma_\infty < \infty$，$\Theta_{1,\infty} \to 0$），逼近阈值收敛至与输入距离 $\delta$ 无关的常数：$\mathcal{A}_\infty = \varepsilon_{max}\Lambda_\infty + \delta_{max}\Gamma_\infty$。此时目标变分天花板为有限常数——无论两个输入相距多远，系统所能逼近的目标变分不超过 $\mathcal{A}_\infty$。这从下界方向印证了推论 5 的上界结论：在强收缩下，系统对任意长逻辑组合具有"无限泛化免疫力"，但代价是丧失了逼近高变分目标的能力。

### 4.2 容量-精度不等式（CPI）

**定理（容量-精度不等式，Capacity-Precision Inequality，CPI）**：设 $(\mathcal{X}, d)$ 为度量空间，$A \subseteq \mathcal{X}$ 紧致。设 $r: A \to \mathcal{X}$ 在 $A$ 上具有 $k$-判别性（co-Lipschitz）：$d(r(x), r(y)) \geq k \cdot d(x,y)$，$k > 0$。设 IDFS $\mathcal{F} = (F, \sigma)$ 的计算映射 $\Phi \in \mathrm{Lip}_L(\mathcal{X})$，路由分支数为 $|\mathrm{Im}(\sigma)|$。

若系统在 $A$ 上实现全局误差 $\sup_{x \in A} d(\Phi(x), r(x)) \leq \epsilon$，则路由容量必须满足：

$$|\mathrm{Im}(\sigma)| \;\geq\; \frac{\mathcal{N}\bigl(A,\; 2\epsilon/k\bigr)}{\mathcal{N}\bigl(A,\; \epsilon/L\bigr)}$$

其中 $\mathcal{N}(A, \delta)$ 为 $A$ 的 $\delta$-覆盖数（即最少需要多少个半径为 $\delta$ 的球覆盖 $A$）。

**证明**（路由分区 + Lipschitz 覆盖传递）：

1. **覆盖传递**：由 $\sup_{x \in A} d(\Phi(x), r(x)) \leq \epsilon$，对任意 $r(x) \in r(A)$，存在 $\Phi(x)$ 使 $d(\Phi(x), r(x)) \leq \epsilon$。因此 $r(A) \subseteq B(\Phi(A), \epsilon)$——即 $\Phi(A)$ 是 $r(A)$ 的 $\epsilon$-网。由三角不等式，$\Phi(A)$ 的任意 $\epsilon$-覆盖给出 $r(A)$ 的 $2\epsilon$-覆盖：
$$\mathcal{N}(r(A),\, 2\epsilon) \;\leq\; \mathcal{N}(\Phi(A),\, \epsilon)$$

2. **路由分区**：$\sigma$ 将 $A$ 分为至多 $|\mathrm{Im}(\sigma)|$ 个分区 $\{C_i\}$，每个分区内 $\Phi|_{C_i}$ 为固定 $L$-Lipschitz 映射。由 Lipschitz 映射的覆盖数保持性：
$$\mathcal{N}(\Phi(A \cap C_i),\, \epsilon) \;\leq\; \mathcal{N}(A \cap C_i,\, \epsilon/L) \;\leq\; \mathcal{N}(A,\, \epsilon/L)$$
由 union bound：
$$\mathcal{N}(\Phi(A),\, \epsilon) \;\leq\; |\mathrm{Im}(\sigma)| \cdot \mathcal{N}(A,\, \epsilon/L)$$

3. **co-Lipschitz 放大**：$r$ 的 $k$-判别性意味着 $r^{-1}$（在像集上）是 $1/k$-Lipschitz，故：
$$\mathcal{N}(r(A),\, 2\epsilon) \;\geq\; \mathcal{N}(A,\, 2\epsilon/k)$$

4. 合并 1–3：$|\mathrm{Im}(\sigma)| \cdot \mathcal{N}(A, \epsilon/L) \geq \mathcal{N}(A, 2\epsilon/k)$，移项即得。$\square$

> **注（无测度依赖）**：整个证明仅使用度量空间的紧致性和覆盖数，不涉及任何测度、体积或维度概念。这使得 CPI 定理在比 DFG 定理（§4.3）**严格更弱**的假设下成立——代价是结论从"不可拟合集的测度下界"退化为"路由容量的组合下界"。

> **注（覆盖数比的物理含义）**：当 $k > 2L$（即目标的判别强度至少是系统光滑度的两倍）时，分子的覆盖尺度 $2\epsilon/k < \epsilon/L$ 严格小于分母的覆盖尺度，故分子对应**更精细**的覆盖——覆盖数比 $> 1$，路由容量受到非平凡约束。比值的大小取决于 $A$ 的度量熵随尺度的增长速率：对 $D$-维空间（$\mathcal{N}(A, \delta) \asymp \delta^{-D}$），比值为 $(2L/k)^D$，呈指数级增长。

> **注（与§2 命题 1 的联系）**：CPI 定理的容量下界与 §2.1 命题 1（组合耗尽与路由满射）在结构上深度对偶。命题 1 从信息论角度建立 $|\mathrm{Im}(\sigma)| \geq e^{I_\epsilon(\mathcal{S}) - C_\epsilon}$（目标度量熵超出基算子变形熵的指数倍）；CPI 从覆盖数角度建立 $|\mathrm{Im}(\sigma)| \geq \mathcal{N}(A, 2\epsilon/k) / \mathcal{N}(A, \epsilon/L)$（目标辨识需求超出系统解析力的覆盖数比）。两者独立成立，在不同的数学框架下各自刻画了同一物理事实：**判别性目标对路由多样性的刚性需求**。

### 4.3 判别性拟合缺口定理（DFG）

**引理（不可完美拟合集的正测度性，Positive Measure of Imperfect Fitting Sets）**：设 $(\mathcal{X}, d, \mu)$ 为度量概率空间，$\mu$ 完全支撑。设 $\Phi \in \mathrm{Lip}_L(\mathcal{X})$，$(r, \mathcal{X}_r) \in \mathcal{S}$，$\mathcal{X}_r$ 紧致且 $\mathrm{int}(\mathcal{X}_r) \neq \emptyset$。若 $r$ 具有 $(\rho, \Delta)$-变分且 $\Delta > L\rho$，则对任意 $\tau < (\Delta - L\rho)/2$：

$$\mu\bigl(U_\tau(r)\bigr) \;>\; 0$$

即误差超过 $\tau$ 的输入集合具有严格正测度。

**证明**（由推论 2 + 误差函数连续性）：先证 $r$ 在 $\mathcal{X}_r$ 上连续的情形（一般情形见后注）：

1. 由推论 2，$\varepsilon_r = \sup_{z \in \mathcal{X}_r} d(\Phi(z), r(z)) \geq (\Delta - L\rho)/2 > \tau$。
2. 定义误差函数 $g(x) = d(\Phi(x), r(x))$。由 $\Phi$ Lipschitz 与 $r$ 连续，$g$ 在 $\mathcal{X}_r$ 上连续。
3. 由 $\mathcal{X}_r$ 紧致与 $g$ 连续，sup 可达：存在 $x_0 \in \mathcal{X}_r$ 使得 $g(x_0) = \varepsilon_r > \tau$。
4. 由 $g$ 在 $x_0$ 处的连续性，存在 $\delta > 0$ 使得 $B_\delta(x_0) \cap \mathcal{X}_r \subseteq \{x : g(x) > \tau\} \subseteq U_\tau(r)$（$U_\tau$ 以 $\geq$ 定义，包含严格超水平集）。
5. 由 $\mathrm{int}(\mathcal{X}_r) \neq \emptyset$ 且 $x_0 \in \mathcal{X}_r$，取 $\delta$ 足够小使 $B_\delta(x_0) \cap \mathrm{int}(\mathcal{X}_r) \neq \emptyset$。此非空开集由 $\mu$ 的完全支撑性具有正测度，故 $\mu(B_\delta(x_0) \cap \mathcal{X}_r) > 0$。

因此 $\mu(U_\tau(r)) \geq \mu(B_\delta(x_0) \cap \mathcal{X}_r) > 0$。$\square$

> **注（定量下界）**：证明中的 $\delta$ 可被显式量化。由 $g$ 的 Lipschitz 常数 $\mathrm{Lip}(g) \leq L + \mathrm{Lip}(r)$，令 $\delta_\tau = \frac{\varepsilon_r - \tau}{L + \mathrm{Lip}(r)}$，则 $B_{\delta_\tau}(x_0) \cap \mathcal{X}_r \subseteq U_\tau(r)$。若 $\mu$ 为 Ahlfors $D$-正则（即存在常数 $c_D^-, c_D^+ > 0$ 使得 $c_D^- \cdot s^D \leq \mu(B_s(x)) \leq c_D^+ \cdot s^D$，其中 $D$ 为 $\mathcal{X}$ 的 Ahlfors 维数——度量测度空间的内在维度，对 $\mathcal{X} \subseteq \mathbb{R}^n$ 配 Lebesgue 测度即 $D = n$），则 $\mu(U_\tau(r)) \geq c_D^- \cdot \delta_\tau^D$。此量化反映了"$r$ 的变分越剧烈（$\Delta/\rho$ 越大）、系统的光滑度越高（$L$ 越小），不可拟合集越大"的直觉。

> **注（$r$ 不连续时的一般情形）**：上述证明利用了 $r$ 的连续性来保证 $g$ 连续。若 $r$ 在某点 $x_0 \in \mathrm{int}(\mathcal{X}_r)$ **不连续**（存在 $z_n \to x_0$ 使 $r(z_n) \to a \neq r(x_0)$），则由 $\Phi$ 的连续性 $\Phi(z_n) \to \Phi(x_0)$，故 $g(z_n) \to d(\Phi(x_0), a)$。由三角不等式 $d(a, r(x_0)) \leq d(\Phi(x_0), a) + d(\Phi(x_0), r(x_0))$，故 $\max(d(\Phi(x_0), a),\, g(x_0)) \geq d(a, r(x_0))/2 > 0$。若 $d(\Phi(x_0), a) > 0$，则由 $z \mapsto d(\Phi(z), a)$ 的连续性，存在 $z_n$ 的开邻域使 $g > 0$。因此**连续函数 $\Phi$ 无法跟踪 $r$ 的跳跃，不连续只会扩大 $U_\tau(r)$**——定理结论在一般情形下仍然成立。

**定义（局部判别性，Partial Discriminativity）**：称连续映射 $r$ 在 $\mathcal{X}_r$ 上具有 **$(\beta, k)$-局部判别性**，若存在子集 $A \subseteq \mathcal{X}_r$，$\mu(A) \geq \beta \cdot \mu(\mathcal{X}_r)$（$\beta \in (0,1]$），使得 $r|_A$ 满足 co-Lipschitz 条件：

$$d(r(x), r(y)) \geq k \cdot d(x,y) \quad \forall\, x, y \in A$$

即 $r$ 在其定义域的至少 $\beta$ 比例区域上能严格区分不同输入。参数 $\beta$ 量化了判别性的**覆盖度**，$k$ 量化了判别性的**强度**。

> **注（自然性）**：局部判别性远弱于全局 co-Lipschitz（后者要求 $\beta = 1$）。几乎所有具有实际意义的知识映射都满足此条件：数学运算在几乎全域上严格单调（$\beta \approx 1$）；语言理解将不同输入映射至不同语义表征；逻辑推理由不同前提导出不同结论。仅"常函数型"知识（在正测度集上完全平坦）不满足此条件——但此类知识本身不产生非平凡的拟合需求。

**定理（判别性拟合缺口定理，Discriminative Fitting Gap，DFG）**：设 $(\mathcal{X}, d, \mu)$ 为度量概率空间，$\mu$ 为 Ahlfors $D$-正则测度（即 $c_D^- \cdot s^D \leq \mu(B_s(x)) \leq c_D^+ \cdot s^D$；注意 Ahlfors 正则蕴含完全支撑）。设 $\Phi \in \mathrm{Lip}_L(\mathcal{X})$，$(r, \mathcal{X}_r) \in \mathcal{S}$，$r$ 具有 $(\beta, k)$-局部判别性且 $k > L$（即目标的判别扩张率超过系统的最大扩张率——co-Lipschitz 形式的推论 2 条件 $\Delta > L\rho$；此条件同时蕴含 $r$ 具有 $(\rho, k\rho)$-变分，故无需单独假设变分条件）。则对任意 $\tau > 0$：

$$\mu\bigl(U_\tau(r)\bigr) \;\geq\; \beta \cdot \mu(\mathcal{X}_r) \;-\; |\mathrm{Im}(\sigma)| \cdot c_D^+ \cdot \left(\frac{2\tau}{k - L}\right)^D$$

**证明**（路由分区 + co-Lipschitz 直径约束）：

1. **路由分区**：$\sigma$ 将 $\mathcal{X}_r$ 分为至多 $|\mathrm{Im}(\sigma)|$ 个分区单元 $\{C_i\}$，每个单元内 $\Phi|_{C_i}$ 为固定 $L$-Lipschitz 函数。
2. **直径约束**：设 $A$ 为 $r$ 的判别性子集。对每个路由单元 $C_i$，取 $x, y \in S_\tau \cap C_i \cap A$（其中 $S_\tau = \{z : d(\Phi(z), r(z)) < \tau\}$ 为成功集）。由三角不等式：
$$k \cdot d(x,y) \leq d(r(x), r(y)) \leq d(r(x), \Phi(x)) + d(\Phi(x), \Phi(y)) + d(\Phi(y), r(y)) < \tau + L \cdot d(x,y) + \tau$$
故 $(k - L) \cdot d(x,y) < 2\tau$，即 $\mathrm{diam}(S_\tau \cap C_i \cap A) < \frac{2\tau}{k - L}$。

3. **体积估计**：$S_\tau \cap C_i \cap A$ 被包含在某直径为 $\frac{2\tau}{k-L}$ 的球内，由 Ahlfors 正则性：$\mu(S_\tau \cap C_i \cap A) \leq c_D^+ \cdot \left(\frac{2\tau}{k-L}\right)^D$。
4. **Union bound**：$\mu(S_\tau \cap A) \leq |\mathrm{Im}(\sigma)| \cdot c_D^+ \cdot \left(\frac{2\tau}{k-L}\right)^D$。
5. **测度差**：$\mu(U_\tau \cap A) = \mu(A) - \mu(S_\tau \cap A) \geq \beta \cdot \mu(\mathcal{X}_r) - |\mathrm{Im}(\sigma)| \cdot c_D^+ \cdot \left(\frac{2\tau}{k-L}\right)^D$。

由 $U_\tau(r) \supseteq U_\tau \cap A$，结论成立。$\square$

> **注（可解读性）**：界中的两项有清晰的对抗结构。第一项 $\beta \cdot \mu(\mathcal{X}_r)$ 是"目标的判别性区域总量"——$r$ 在其定义域中有多大比例需要被精确区分。第二项 $|\mathrm{Im}(\sigma)| \cdot c_D^+ \cdot \left(\frac{2\tau}{k-L}\right)^D$ 是"系统通过路由分支所能覆盖的量"——路由多样性 $|\mathrm{Im}(\sigma)|$ 乘以每条路径在 co-Lipschitz 约束下的最大成功集体积。当精度要求 $\tau$ 足够小、目标变分强度 $k$ 足够大、或路由分支数不足以覆盖判别性区域时，不可拟合集占据显著甚至绝大比例。特别地，下界为正的充分条件为：
> $$\tau \;<\; \frac{k - L}{2}\left(\frac{\beta \cdot \mu(\mathcal{X}_r)}{|\mathrm{Im}(\sigma)| \cdot c_D^+}\right)^{1/D}$$

**推论（宏观容错界的不可突破定理，Unbreakable Bound on Macroscopic Error Tolerance）**：设 DFG 定理的假设成立。若要求不可拟合集的测度占比不超过容忍度 $\alpha$（$0 \leq \alpha < \beta$），即 $\mu(U_\tau(r)) \leq \alpha \cdot \mu(\mathcal{X}_r)$，则误差容差 $\tau$ 必须满足：

$$\tau \;\geq\; \frac{k - L}{2} \cdot \left( \frac{(\beta - \alpha) \cdot \mu(\mathcal{X}_r)}{|\mathrm{Im}(\sigma)| \cdot c_D^+} \right)^{1/D}$$

**证明**：将系统要求 $\mu(U_\tau(r)) \leq \alpha \cdot \mu(\mathcal{X}_r)$ 代入 DFG 定理的测度下界结论中得：
$$ \alpha \cdot \mu(\mathcal{X}_r) \;\geq\; \mu(U_\tau(r)) \;\geq\; \beta \cdot \mu(\mathcal{X}_r) \;-\; |\mathrm{Im}(\sigma)| \cdot c_D^+ \cdot \left(\frac{2\tau}{k - L}\right)^D $$
移项并隔离参数 $\tau$ 项：
$$ |\mathrm{Im}(\sigma)| \cdot c_D^+ \cdot \left(\frac{2\tau}{k - L}\right)^D \;\geq\; (\beta - \alpha) \cdot \mu(\mathcal{X}_r) $$
由于 $k > L$，两边同取 $1/D$ 次方并移去系数 $\frac{2}{k-L}$，即立刻解出 $\tau$ 必须满足如下不等式：
$$ \tau \;\geq\; \frac{k - L}{2} \cdot \left( \frac{(\beta - \alpha) \cdot \mu(\mathcal{X}_r)}{|\mathrm{Im}(\sigma)| \cdot c_D^+} \right)^{1/D} $$
$\square$

> **注（物理实质解读与维度诅咒）**：此推论揭示了此下界的极其重要的物理意义：
> 1. **有效复杂度阻力 $(\beta - \alpha)$**：当目标函数的判别性覆盖率 $\beta$ 超过系统业务层面允许的失败率 $\alpha$ 时，此数学法则即被直接触发。若期望完全拟合（$\alpha \to 0$），分子取到极限 $\beta$。
> 2. **拓扑拉扯惩罚 $(k - L)/2$**：误差基底严格正比于目标的相对拉扯强度：目标自带的内部扩张率与系统提供的基础平滑性收敛度的极差。
> 3. **宏观维度诅咒（Dimensionality Curse 的终极形式）**：括号外侧的 $1/D$ 次方揭示了核心的维度效应。设系统的路由分支数 $|\mathrm{Im}(\sigma)|$ 随维度 $D$ 的增长率为 $M(D)$。若 $M(D)$ 至多为 $D$ 的亚指数函数（即 $\log M(D) = o(D)$，对应于多项式或亚指数级的系统容量增长——这对绝大多数实际可实现的系统而言是合理的假设），则：
> $$\left(\frac{(\beta - \alpha)\mu(\mathcal{X}_r)}{M(D) \cdot c_D^+}\right)^{1/D} \;\to\; 1 \quad (D \to \infty)$$
> 此时容错极限收敛至：$\tau_{min} \to \frac{k - L}{2}$。该定论表明，在亚指数容量增长体制下，纯粹依靠"暴力扩大网络容量"来抗击高维复杂知识特征的逼近误差，注定会在维度面前丧失边际效益——误差被焊死在由目标与系统的拓扑拉扯差 $(k-L)/2$ 决定的硬底上。唯有路由分支数以 $2^{\Omega(D)}$ 速率指数增长（即系统容量与输入维度呈指数对抗），方能突破此维度封锁——但这在工程上等价于对输入空间的逐点穷举，本身即意味着泛化能力的完全丧失。
