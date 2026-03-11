## 逼近误差的下界

### 4.1 组合近似瓶颈定理（CAB）

**定理（组合近似瓶颈定理，Compositional Approximation Bottleneck，CAB）**：
设系统以容差集 $\mathcal{E}$ 拟合了微观采样集 $\mathcal{S}$。对任意长度为 $l$ 的宏观有效链 $q \in \mathcal{T}_l$，设其对应的端到端物理系统映射为 $l$ 次迭代的复合 $\Phi_q = \Phi \circ \dots \circ \Phi$。

设某输入对 $x, y \in \mathrm{dom}(q)$ 满足以下空间相态（$x, y \in \mathrm{dom}(q)$ 保证理想链 $q$ 在两点处可执行，即 $q(x), q(y) \neq \bot$；近似轨道 $\Phi_q(x), \Phi_q(y)$ 由 IDFS 闭合性保证为 $\mathcal{X}$ 中的良定义元素）：
1. **输入分离与目标跃迁**：起点的初始距离为 $d(x, y) = \delta > 0$，但在理想长链 $q$ 下的映射距离跃迁为 $d(q(x), q(y)) = \Delta > 0$。
2. **拟合参数**：系统在参考点 $x$ 处的端到端逼近误差（拟合残差）记为 $\varepsilon_x \triangleq d(\Phi_q(x), q(x)) \geq 0$。
3. **系统扩张极限（拓扑应变力）**：系统在宏观映射下的最大分离拉伸，由 IDFS 的分段 Lipschitz 结构与路由跳变累积共同决定。在每一单步中，$\Phi$ 在路由分区内部满足 $L_j$-Lipschitz（连续拉伸），而跨越路由边界时额外引入平移跳变代价 $\Delta_{\sigma,j}$。经过 $l$ 步累积，两条从 $x$ 与 $y$ 出发的近似轨道之间的最大分离，等于连续平滑拉伸（$\bar{L}^l \cdot \delta$）与各步路由跳变经尾部乘积放大后的加权总和。记全链路的**最大拓扑应变力（Maximum Topological Strain Capacity）**为：
   $$\Omega_{l}(\delta) \;\triangleq\; \underbrace{\bar{L}^l \cdot \delta}_{\text{基础平滑拉伸}} \;+\; \underbrace{\sum_{j=1}^l \Delta_{\sigma, j} \cdot \Theta_{j+1,l}}_{\text{多步路由跳变累积}}$$
   在此路径上的最大相对拉伸被紧致地界定为 $d(\Phi_q(x), \Phi_q(y)) \leq \Omega_{l}(\delta)$。

定义**末端结构瓶颈（Intrinsic Structural Bottleneck）**为：
$$\varepsilon_{y,\text{out}} = \min_{f \in F}\; \inf_{h \in \mathcal{X}} d(f(h),\, q(y))$$
即遍历所有可能的末端算子 $f \in F$ 和所有可能的中间态 $h$，系统能够达到的与目标像点 $q(y)$ 的最小距离。无论 $\sigma$ 在最后一步如何选择算子，该下界均成立。

**定理结论**：系统在点 $y$ 处的端到端宏观泛化误差 $\varepsilon^*_y \triangleq d(\Phi_q(y), q(y))$（作为容差集 $\mathcal{E}^*$ 的具体表现），存在不可压缩的绝对数学下界：
$$\varepsilon^*_y \;\geq\; \max \Big( |\Delta - \varepsilon_x| - \Omega_l(\delta), \;\; \varepsilon_{y,\text{out}} \Big)$$

**证明**：
先推导**拓扑死锁（Topological Deadlock）**：
考察系统在点 $y$ 处的逼近误差：$\varepsilon^*_y = d(\Phi_q(y), q(y))$。
步骤 1（正向三角不等式）：以目标变分 $\Delta$ 为基准展开四边形度量链：
$$d(q(x), q(y)) \;\leq\; d(q(x), \Phi_q(x)) \;+\; d(\Phi_q(x), \Phi_q(y)) \;+\; d(\Phi_q(y), q(y))$$
代入已知条件与参量（系统等效极值扩张量 $\Omega_l(\delta)$）：
$$\Delta \;\leq\; \varepsilon_x \;+\; \Omega_l(\delta) \;+\; \varepsilon^*_y$$
移项得出 $\varepsilon^*_y$ 的第一重下界 (I)：
$$\varepsilon^*_y \;\geq\; \Delta - \varepsilon_x - \Omega_l(\delta)$$
步骤 2（反向三角不等式）：以参考点残差 $\varepsilon_x$ 为基准逆向展开：
$$d(q(x), \Phi_q(x)) \;\leq\; d(q(x), q(y)) \;+\; d(q(y), \Phi_q(y)) \;+\; d(\Phi_q(y), \Phi_q(x))$$
代入已知条件与参量：
$$\varepsilon_x \;\leq\; \Delta \;+\; \varepsilon^*_y \;+\; \Omega_l(\delta)$$
移项得出 $\varepsilon^*_y$ 的第二重下界 (II)：
$$\varepsilon^*_y \;\geq\; \varepsilon_x - \Delta - \Omega_l(\delta)$$
由于 $\varepsilon^*_y$ 必须同时满足 (I) 与 (II)，得出绝对值下界：
$$\varepsilon^*_y \;\geq\; |\Delta - \varepsilon_x| - \Omega_l(\delta)$$

再推导**末端拓扑结构瓶颈（Terminal Topological Bottleneck）**：
设系统在最后一步对 $y$ 实际选择的末端算子为 $f^{(y)} \in F$（由 $\sigma$ 在近似轨道的最后一步决定，不需先验知道）。设前置映射产生中间态 $h_y$，则：
$$\varepsilon^*_y = d(f^{(y)}(h_y),\, q(y)) \;\geq\; \inf_{h \in \mathcal{X}} d(f^{(y)}(h),\, q(y)) \;\geq\; \min_{f \in F}\; \inf_{h \in \mathcal{X}} d(f(h),\, q(y)) \;=\; \varepsilon_{y,\text{out}}$$

综上所述，逼近误差 $\varepsilon^*_y$ 必须同时满足上述两大独立限制：
$$\varepsilon^*_y \;\geq\; \max \Big( |\Delta - \varepsilon_x| - \Omega_l(\delta), \;\; \varepsilon_{y,\text{out}} \Big)$$
$\square$

> **注（拓扑应变力与门控解耦机制，Topological Strain and Gated Decoupling）**：将路由惩罚 $\Delta_\sigma$ 纳入系统扩张容限 $\Omega_l(\delta)$，从数学形式上扩大了减项，使得理论刚性下界得到适度放宽。这揭示了一个关键的架构设计法则：面对目标域的剧烈变分（高 $\Delta$），纯粹的平滑系统极易因全局 $L$ 的刚性约束而陷入泛化瓶颈（即拓扑死锁）；**系统突破该死锁的工程途径，在于通过离散门控引入流形断层（主动接纳跨路由边界的平移跳变 $\Delta_\sigma$）**。网络通过路由碎片化产生的拓扑扩张，实质上人为放大了 $\Omega_{l}$ 的容忍极限，从而在数学上吸收了由 $|\Delta - \varepsilon_x|$ 带来的刚性逼近误差。
>
> 这从底层理论上解释了，在处理复杂的高维认知分布或长程逻辑推理时，现代架构（如混合专家网络 MoE）为何普遍采用高度非连续的门控结构：**严格的平滑连续映射会在高变分目标前迅速丧失逼近容量**，而通过局部路由切换引入受控的拓扑断裂，正是系统为了规避逼近误差极值下界、实现泛化能力解耦的重要机制。

> **注（末端结构瓶颈 $\varepsilon_{y,\text{out}}$ 的含义）**：项 $\varepsilon_{y,\text{out}}$ 剖离出了 IDFS 末端算子层的结构刚性。无论前置映射 $\Phi'_q$ 将中间态流形通过应变力撕裂得多么复杂，IDFS 的端到端最终输出必须经过某个底层算子 $f \in F$ 映射回输出空间。若目标像点 $q(y)$ 不在任何 $f \in F$ 的可达集 $\bigcup_{f \in F} f(\mathcal{X})$ 中，则 $\varepsilon_{y,\text{out}} > 0$ 成为不可消除的常数瓶颈：此时前置计算中的一切精妙运算与路由碎裂皆无用武之地，端到端误差被末端算子的结构底盖死死卡定。

**推论 4.1（CAB 界的极值可达性与空间同构构筑，Extremal Reachability of the CAB Bound）**：对任意给定的单步拉伸常数序列 $L_j \geq 1$、拓扑路由跃迁代价序列 $\Delta_{\sigma,j} \geq 0$、输入截距 $\delta > 0$、参考点拟合精度 $\varepsilon_x \geq 0$ 及目标突跳变分 $\Delta > 0$，只要 $\Delta > \varepsilon_x + \Omega_l(\delta)$（即拓扑死锁下迫界严格为正），在维度不小于 1 的任意 Banach 空间（或 $\mathbb{R}^n$）中，**必然存在**一对相应的 IDFS 构型 $(F, \sigma)$ 与物理演化目标链 $q$，使得 CAB 被精密重构并触发极值死锁：

$$\varepsilon^*_y \;=\; \Delta \;-\; \varepsilon_x \;-\; \Omega_l(\delta)$$

即：即使系统投入了错综复杂的断裂路由（$\Delta_\sigma > 0$），理论计算给出的该死锁下界在广泛的泛函空间中也是**无可改善的（存在紧致实例全额变现该灾难下界）**。

**证明（同向极化构筑，Collinear Polarization Construction）**：
为证明涵盖 $\Delta_{\sigma,j} > 0$ 时的界限绝对紧致性，我们构造一个让系统极值拓扑应变力被“单向榨干”的张量流形特例。此构造机制与前述上界 推论 3.3 （关于 CAC 上界的严格坍缩证明）的底层几何公理完全同构：即利用系统动力学流形的**主特征向量映射坍缩**。

设系统嵌入于 Banach 切空间 $\mathcal{X}$ 中。任选取稳定雅可比矩阵的一个主特征单位向量 $v \in \mathcal{X}$（$\|v\| = 1$）。

1. **输入与定向对齐**：
   设定考量点 $x = 0$ 及其邻接点 $y = \delta \cdot v$（满足 $d(x,y) = \delta$）。
   设定目标最终演化落点为 $q(x) = 0$ 和 $q(y) = \Delta \cdot v$（满足目标间距跳跃 $d(q(x), q(y)) = \Delta$）。

2. **植入原点拟合偏差**：
   令系统由于过拟合或其他非连续干预机制，在 $x$ 处的宏观实际复合输出设定为 $\Phi^l(x) = \varepsilon_x \cdot v$。此时初态误差距离 $d(\Phi^l(x), q(x)) = \varepsilon_x$ 核验通过。

3. **最大化应变力演化加载（关键步）**：
   在长度为 $l$ 的累积迭代映射中，令系统使用的基函数簇仅沿着射线 $v$ 的方向产生最不利拉伸：每经历第 $j$ 步更新，物理演化沿 $v$ 被线性扩张 $L_j$ 倍。更极端地是，令其网格划分 $\sigma$ 在这每一步的 $y$ 的轨迹前缘精准穿插一条跨路由分界面（路由切换缝），导致基底函数替换而强行引入的向量平移跳变正相平行于 $v$ 且振幅恰为预留的 $\Delta_{\sigma, j}$。
   经历全 $l$ 步物理洗礼后，系统在 $y$ 与 $x$ 的相对分离不仅达到其 Lipschitz 几何倍缩展，更叠加上了一切碎片跃迁向量之和：
   $$\Phi^l(y) - \Phi^l(x) \;=\; \left( \bar{L}^l\delta + \sum_{j=1}^l \Delta_{\sigma,j}\Theta_{j+1,l} \right) \cdot v \;=\; \Omega_l(\delta) \cdot v$$
   进而得知：$\Phi^l(y) \;=\; (\varepsilon_x + \Omega_l(\delta)) \cdot v$。

4. **系统崩溃清算**：
   计量系统在 $y$ 处的最终泛化崩溃点：
   $$\varepsilon^*_y \;=\; d(\Phi^l(y),\, q(y)) \;=\; \| \Delta \cdot v \;\;-\;\; (\varepsilon_x + \Omega_l(\delta)) \cdot v \|$$
   基于不可逆预设前提 $\Delta > \varepsilon_x + \Omega_l(\delta)$，二者符号一致且被减项小，高维范数收缩为标量径向相减：
   $$\varepsilon^*_y \;=\; \Delta \;-\; \varepsilon_x \;-\; \Omega_l(\delta)$$
   
**等号成立的几何本质**：
在此极其恶劣的知识特征分布下，四个关键度量锚定系：基准原点目标 $q(x)$、系统由于训练引起的错位基准 $\Phi^l(x)$、系统竭尽全力通过平滑与跨界路由扯开的最大逃生点 $\Phi^l(y)$、以及它所追逐的目标变异远端 $q(y)$，**全部宛若算珠串联在了同一条主特征高维射线上（完全同向非散逸）**。
原本在高维空间中，不同维度的分量可能通过相互正交折叠使得多重泛函三角不等式取得广阔的缓冲地带（$A+B \gg C$）；但在该“同向排列极化”效应下，广阔的高维缓角自由度全部死锁。所有的物理逃脱都被单轴强行封死，三角不等式被严密退化为一维数量减法。这证明了：不论工程上设计了通过何等暴力分块切开知识界限（提供高达 $\Delta_\sigma$ 的门控越狱应变力）的手段，只要面对变分结构沿着单一特征深度极化（高 $\Delta$）的情况时，CAB 宣判的数学死锁底牌将立刻从“潜在底限”翻面为“绝对的精确毁灭”。 $\square$

> **注（末端瓶颈界的紧性复用）**：右侧次项 $\varepsilon_{y,\text{out}} = \inf_h d(f_\text{out}(h), q(y))$ 的取等同样属于极值可达集：只需令前置宏观映射 $\Phi'_q$ 在其拉伸极限内，恰好将 $y$ 的中间子流态推至离末端最优算界最近极值 $h^* = \arg\min_h d(f_\text{out}(h), q(y))$ 处，则 $\varepsilon^*_y$ 立刻死锁于 $\varepsilon_{y,\text{out}}$。这就确立了 CAB 统合判决中包含独立两项各自皆具备极致紧迫存在的纯粹客观物理法则。

**定义（映射的局部变分下界，Local Variation Lower Bound）**：设 $(\mathcal{X}, d)$ 为度量空间。称映射 $r \in \Omega$ 在子集 $\mathcal{X}_r \subseteq \mathcal{X}$ 上具有 **$(\rho, \Delta)$-变分**，若存在 $x, y \in \mathcal{X}_r$ 使得：

$$d(x, y) \;\leq\; \rho \quad \text{且} \quad d\bigl(r(x), r(y)\bigr) \;\geq\; \Delta$$

即 $r$ 在 $\rho$-邻域内存在幅度不小于 $\Delta$ 的剧烈跳变。（注：此处 $\rho$ 为输入空间中的距离尺度，与 CAC 定理中的采样域偏离 $\delta_j$ 含义不同，亦与 CAC 的目标域外变分 $\rho_j = d(r_{i_j}(x'_j), r_{i_j}(h^*_{j-1}))$ 不同——后者是输出空间中的度量距离。）

**推论 4.2（近似误差的综合变分下界，Comprehensive Variation Bound on Approx Error）**：设系统由近端区域的点间单步演化中可能伴随路径门控切换，将其局部单步拓展拉伸限记为 $\Omega_1(\rho) = L_{local}\cdot \rho + \Delta_{\sigma, \text{max}}$。设 $(r, \mathcal{X}_r) \in \mathcal{S}$，$r$ 在 $\mathcal{X}_r$ 上具有 $(\rho, \Delta)$-变分，记 $\varepsilon_r = \sup_{z \in \mathcal{X}_r} d(\Phi(z), r(z))$。则必然成立：

$$2\varepsilon_r \;+\; \Omega_1(\rho) \;\geq\; \Delta$$
即：
$$2\varepsilon_r \;+\; L_{local}\cdot\rho \;+\; \Delta_{\sigma, \text{max}} \;\geq\; \Delta$$

**证明（由 CAB 特化）**：取满足 $(\rho, \Delta)$-变分条件的点对 $x, y \in \mathcal{X}_r$。将 CAB 拓扑死锁界特化至 $l = 1$（单步，系统拉伸极度扩展至此单步应变极值 $\Omega_1(\delta)$）：

$$\varepsilon^*_y \;\geq\; \Delta_q - \varepsilon_x - \Omega_1(\delta) \;\geq\; \Delta - \varepsilon_x - (L_{local}\rho + \Delta_{\sigma, \text{max}})$$

由于局部闭集上的度量控制，$x, y \in \mathcal{X}_r$，两点的误差均受同一 sup 约束限制：$\varepsilon_x \leq \varepsilon_r$，$\varepsilon^*_y \leq \varepsilon_r$。代入上式解开：$\varepsilon_r \geq \Delta - \varepsilon_r - L_{local}\rho - \Delta_{\sigma, \text{max}}$，移项后即得所证综合表达式。$\square$

> **注（变分四元张力律）**：不等式 $2\varepsilon_r + L_{local}\rho + \Delta_{\sigma, \text{max}} \geq \Delta$ 刻画了四个极值参数间的根本性互斥张力：局部变分强度（宏观上表现为 $\Delta/\rho$）、路径局部平滑度（$L_{local}$）、离散路由跳跃界（$\Delta_{\sigma, \text{max}}$）与单步拟合残差（$\varepsilon_r$）无法同时被极小化。对于主要依赖连续映射的平滑网络（$L_{local} \ll L$ 且 $\Delta_\sigma \approx 0$），若强制逼近高频变分目标，系统在常规演化步上将面临刚性的下界限制，必须承担**实质性的基础拟合误差 $\varepsilon_r \geq (\Delta - L_{local}\rho)/2$**。这再次印证了为何现代架构（如 MoE）需要引入非连续门控以提升 $\Delta_{\sigma}$ 上限，其本质正是为了化解此处的极小化冲突。

> **注（与 5-Term CAC 的底层对接）**：推论 4.2 为五项精细化上界机制提供了下界的对偶解释。它揭示了单步泛化误差 $\varepsilon_{i_j}$ 不可规避的物理来源：输入空间的高变异度必然需要在演化中得以释放——要么通过剧烈的连续扭曲（增大 $L$），要么通过离散的拓扑断崖（积聚 $\Delta_\sigma$），否则就必须承受静态的底线错位（导致大 $\varepsilon_r$）。CAB 下界定出了这种局部妥协的最小代价；而一旦进入 CAC 上界的传导阶段，这些微观层面无法消除的单步误差，将立刻与宏观尾部扩张系数 $\Theta_{j+1,l}$ 发生乘性耦合，最终在端到端尺度上引发指数级扩散。这种从微观代价必然性到宏观误差爆炸性生长的完整链条，正是 OOD 坍塌定律的物理本质。

> **注（从几何基点向高维分布的延展）**：以上推论确立了最纯粹的度量几何底线，证明了即使在两点间也必然存在无法弥合的误差张力。然而，实际的物理系统与训练集绝非孤立的点对，而是一个具有特定统计测度（$\mu$）与内在维度（$D$）的复杂数据流形。当我们将这一“单点上的几何死锁”放入高维概率空间中考量时，局部的误差张力将不可避免地在流形上弥散，演化为大面积的、具有正测度的“不可拟合灾区”。这种由几何局域极值向全局统计失效的升维推演，正是后续 DFG 定理（判别性拟合缺口，§4.3）及其所揭示的“维度诅咒”的物理雏形。

> **注（扩展到 $\mathrm{dom}(r)$ 时的三元纠缠）**：推论 4.2 的分析严格限于采样域 $\mathcal{X}(r)$，其中 $\sigma$ 隐含于 $\Phi$ 的构造而不显式出现，两元张力 $(\varepsilon_r, L_{local})$ 足以刻画。若将分析扩展至整个 $\mathrm{dom}(r) \supseteq \mathcal{X}(r)$，则在 $\mathrm{dom}(r) \setminus \mathcal{X}(r)$ 的区域内，$\Phi(z) = \sigma(z)(z)$ 不受采样约束，$\sigma$ 的决策边界可能在 $\partial\mathcal{X}(r)$ 处被激活：由 命题 2.14（路由分辨率极限），跨越边界时路径局部 Lipschitz $L_j$ 逼近系统全局极限 $L$，使分辨率死锁在边界处达到最极端形态。此时变分约束涉及**三元纠缠** $(\varepsilon_r,\, L,\, \sigma)$——三者无法分别独立优化，对 $\mathrm{dom}(r)$ 的分析须同时约束 $\sigma$ 在 $\partial\mathcal{X}(r)$ 处的边界曲率。因此推论 4.2 的主体保持在 $\mathcal{X}(r)$ 上以确保形式严格性；三元纠缠的正式处理见 命题 5.6。

**命题 4.3（综合逼近可行性条件，Comprehensive Approximation Feasibility）**：由 CAC 定理（上界）与 CAB 定理（下界）联合推导出系统逼近泛化的理论天花板。设 IDFS $\mathcal{F} = (F, \sigma)$ 拟合了采样集 $\mathcal{S}$，各极限参数齐备。对任意有效链 $q \in \mathcal{T}_l$ 和任意 $x, y \in \mathrm{dom}(q)$（$d(x,y) = \delta$），记目标变分 $\Delta = d(q(x), q(y))$。

定义**综合逼近天花板阈值（Comprehensive Approximation Threshold）**：

$$\mathcal{A}_l(\delta) \;\triangleq\; \underbrace{\Omega_l(\delta)}_{\text{拓扑应变力限}} \;+\; \underbrace{(\varepsilon_{\max} + \rho_{\max}) \cdot \Lambda_l}_{\text{微观连续拟合耗损}} \;+\; \underbrace{\delta_{\max} \cdot \Gamma_l}_{\text{采样偏离空间底压}}$$

（注：其中 $\Omega_l(\delta) = \bar{L}^l\delta + \Delta_{\max}\cdot\Lambda_l$ 已囊括路由惩罚跳变）

则系统在 $y$ 处的宏观逼近误差带有绝对不可逆跨越的数学下底线：

$$\varepsilon^*_y \;\geq\; \Delta \;-\; \mathcal{A}_l(\delta)$$

**含义**：当系统面对的目标变分 $\Delta > \mathcal{A}_l(\delta)$ 时，即便在参考点 $x$ 处投入无尽的拟合资源使其误差逼近完美（即 $\varepsilon_x \to 0$），该系统在因目标突跳而产生的邻近点 $y$ 处，依然面临不可压缩的刚性正偏差 $\varepsilon^*_y > 0$。此条件界定了任何 IDFS 架构在应对突跳目标时的泛化有效性边界。

**证明**：结合带有应变力的 CAB 死锁界 $\varepsilon^*_y \geq \Delta - \varepsilon_x - \Omega_l(\delta)$ 与 CAC 上界定理（形式 A 均匀化约束）：$\varepsilon_x \leq (\varepsilon_{max} + \rho_{max} + \Delta_{max})\Lambda_l + \delta_{max}\Gamma_l$。将后者的极值约束代入前锚点 $\varepsilon_x$ 后提取分离参数。在此注意 $\Omega_l(\delta)$ 的定义包含 $\bar{L}^l\delta + \sum\Delta_{\sigma,j}\Theta_{j+1,l} \leq \bar{L}^l\delta + \Delta_{\max}\Lambda_l$。对各预算模块重新归并整理，即严格推导出该统合不等式。$\square$

> **注（逼近资源三元预算解构）**：逼近阈值 $\mathcal{A}_l(\delta)$ 结构性地分解为三个彼此独立的刚性物理预算：
> - **拓扑应变极限 $\Omega_l(\delta)$**：系统跟随并包容目标变分的唯一主动结构性支撑，融合了系统固有的动态连续扩张本底 $\bar{L}$ 和离散路由门控赋予的跳变余量 $\Delta_\sigma$。
> - **拟合综合耗损 $(\varepsilon_{max}+\rho_{max})\Lambda_l$**：由微观近似残差与局部目标变异带来的内生性妥协底座，并经由系统尾部连乘不可控地放大。这是逼近过拟合时最易被迅速挥霍的指标。
> - **采样偏离底压 $\delta_{max}\Gamma_l$**：由观测流形与实际计算基座点间的刚性剥离诱发的累积空间漂移代价。
>
> 目标若强行越过这三项预算构筑的容限上限时，系统必将遭遇原理性的外推失效。特别指出，在参数饱和度极化体制下（参照 推论 3.6，即当 $\Lambda_\infty < \infty$），该整体阈值将强制退化收敛为一个与初始输入距 $\delta$ 无关的有界常数，从而从根本逻辑上宣判长逻辑链对高频脉冲响应能力的丧失。

### 4.2 容量-精度不等式（CPI）

**定理（容量-精度不等式，Capacity-Precision Inequality，CPI）**：设 $(\mathcal{X}, d)$ 为度量空间，$A \subseteq \mathcal{X}$ 紧致。设 $r: A \to \mathcal{X}$ 在 $A$ 上具有 $k$-判别性（co-Lipschitz）：$d(r(x), r(y)) \geq k \cdot d(x,y)$，$k > 0$。设 IDFS $\mathcal{F} = (F, \sigma)$ 的计算映射 $\Phi$ 在其各个路由分区内局部为 $L_{local}$-Lipschitz，全局路由分支数为 $|\mathrm{Im}(\sigma)|$。

若系统在 $A$ 上实现全局误差 $\sup_{x \in A} d(\Phi(x), r(x)) \leq \epsilon$，则路由容量必须满足：

$$|\mathrm{Im}(\sigma)| \;\geq\; \frac{\mathcal{N}\bigl(A,\; 2\epsilon/k\bigr)}{\mathcal{N}\bigl(A,\; \epsilon/L_{local}\bigr)}$$

其中 $\mathcal{N}(A, \delta)$ 为 $A$ 的 $\delta$-覆盖数（即最少需要多少个半径为 $\delta$ 的球覆盖 $A$）。

**证明**（路由分区 + Lipschitz 覆盖传递）：

1. **覆盖传递**：由 $\sup_{x \in A} d(\Phi(x), r(x)) \leq \epsilon$，对任意 $r(x) \in r(A)$，存在 $\Phi(x)$ 使 $d(\Phi(x), r(x)) \leq \epsilon$。因此 $r(A) \subseteq B(\Phi(A), \epsilon)$——即 $\Phi(A)$ 是 $r(A)$ 的 $\epsilon$-网。由三角不等式，$\Phi(A)$ 的任意 $\epsilon$-覆盖给出 $r(A)$ 的 $2\epsilon$-覆盖：
$$\mathcal{N}(r(A),\, 2\epsilon) \;\leq\; \mathcal{N}(\Phi(A),\, \epsilon)$$

2. **路由分区**：$\sigma$ 将 $A$ 分为至多 $|\mathrm{Im}(\sigma)|$ 个分区 $\{C_i\}$，每个分区内 $\Phi|_{C_i}$ 为固定 $L_{local}$-Lipschitz 映射。由 Lipschitz 映射的覆盖数保持性：
$$\mathcal{N}(\Phi(A \cap C_i),\, \epsilon) \;\leq\; \mathcal{N}(A \cap C_i,\, \epsilon/L_{local}) \;\leq\; \mathcal{N}(A,\, \epsilon/L_{local})$$
由 union bound：
$$\mathcal{N}(\Phi(A),\, \epsilon) \;\leq\; |\mathrm{Im}(\sigma)| \cdot \mathcal{N}(A,\, \epsilon/L_{local})$$

3. **co-Lipschitz 放大**：$r$ 的 $k$-判别性意味着 $r^{-1}$（在像集上）是 $1/k$-Lipschitz，故：
$$\mathcal{N}(r(A),\, 2\epsilon) \;\geq\; \mathcal{N}(A,\, 2\epsilon/k)$$

4. 合并 1–3：$|\mathrm{Im}(\sigma)| \cdot \mathcal{N}(A, \epsilon/L_{local}) \geq \mathcal{N}(A, 2\epsilon/k)$，移项即得。$\square$

> **注（无测度依赖）**：整个证明仅使用度量空间的紧致性和覆盖数，不涉及任何测度、体积或维度概念。这使得 CPI 定理在比 DFG 定理（§4.3）**严格更弱**的假设下成立——代价是结论从"不可拟合集的测度下界"退化为"路由容量的组合下界"。

> **注（覆盖数比的几何本质：正交维度的暴力赎回）**：当 $k > 2L_{local}$（目标的判别强度超出系统局部光滑度的两倍）时，覆盖数比严格大于 1。
> 令人深思的是它与推论 4.1（同向极化死锁）之间极其璀璨的理论对偶火花：在前文的 CAB 死锁构造中，一旦目标变分进入一维极化态，高维空间中本应用于缓冲的 $D-1$ 个“横向正交维度”会全部失效坍缩。单张平滑映射流形（受制于固定的主特征向量集）在面对多维复杂变分时，必然在大量方向上遭遇此类共线死锁。
>
> 而 CPI 定理在此从宏观视角给出了系统的全局反制法则——**面对正交自由度的瘫痪，系统唯一的保命机制就是极其暴力的物理切分（增大 $|\mathrm{Im}(\sigma)|$）**。每切分出一个新的路由子域，系统就在局部重新部署了一组独立的基底特征集。在 $D$ 维流形下（度量熵 $\mathcal{N}(A, \delta) \asymp \delta^{-D}$），计算出的理论路由分支数必须呈指数级爆炸：$|\mathrm{Im}(\sigma)| \ge (2L_{local}/k)^D$。这也为现代 MoE 架构为何动辄需要成百上千个细粒度专家提供了终极几何学辩护：这正是系统为了“赎回”被死锁剥夺的高维正交逃生空间，所必须按指数折现支付的物理维度罚金。

> **注（与命题 2.4 的联系）**：CPI 定理的容量下界与 命题 2.4（组合耗尽与路由满射）在结构上深度对偶。命题 4.3 从信息论角度建立 $|\mathrm{Im}(\sigma)| \geq e^{I_\epsilon(\mathcal{S}) - C_\epsilon}$（目标度量熵超出基算子变形熵的指数倍）；CPI 从覆盖数角度建立 $|\mathrm{Im}(\sigma)| \geq \mathcal{N}(A, 2\epsilon/k) / \mathcal{N}(A, \epsilon/L_{local})$（目标辨识需求超出系统解析力的覆盖数比）。两者独立成立，在不同的数学框架下各自刻画了同一物理事实：**高维判别性目标对离散路由多样性的不可退让的刚性需求**。

> **注（正交维度收紧：有效路由容量的真正下界）**：CPI 定理中 $|\mathrm{Im}(\sigma)|$ 计量的是路由分支的**代数总数**——包括可能在变分意义上冗余的分支。由 §2.4 的 $f$-链变分正交理论，两条变分平行的路由分支（$\mathrm{Cov}_{var}(q_A, q_B) \neq 0$）在覆盖数意义上是**近似共线的**——它们各自服务的输入子域的像集在 $\mathcal{X}$ 中相互重叠，不构成独立的覆盖贡献。
>
> 定义 $|\mathrm{Im}(\sigma)|_{orth}$ 为 $\mathrm{Im}(\sigma)$ 中两两变分正交的最大子集大小。CPI 证明的第 2 步（路由分区 + union bound）本质上要求每个分区对覆盖数做**独立贡献**。当 $|\mathrm{Im}(\sigma)|$ 中大量分支变分平行时，这些分支的覆盖贡献存在严重重叠，union bound 给出的 $|\mathrm{Im}(\sigma)| \cdot \mathcal{N}(A, \epsilon/L_{local})$ 高估了 $\Phi(A)$ 的实际覆盖数。更精确的估计为：
>
> $$\mathcal{N}(\Phi(A),\, \epsilon) \;\leq\; |\mathrm{Im}(\sigma)|_{orth} \cdot \mathcal{N}(A,\, \epsilon/L_{local}) \;+\; (|\mathrm{Im}(\sigma)| - |\mathrm{Im}(\sigma)|_{orth}) \cdot \mathcal{N}_{red}$$
>
> 其中 $\mathcal{N}_{red} \leq \mathcal{N}(A, \epsilon/L_{local})$ 为冗余分支的覆盖贡献（因平行性可证 $\mathcal{N}_{red} \ll \mathcal{N}(A, \epsilon/L_{local})$）。在极端情形（所有非正交分支完全冗余，$\mathcal{N}_{red} = 0$）下，CPI 收紧为：
>
> $$|\mathrm{Im}(\sigma)|_{orth} \;\geq\; \frac{\mathcal{N}(A,\; 2\epsilon/k)}{\mathcal{N}(A,\; \epsilon/L_{local})}$$
>
> 这意味着系统不仅需要足够多的路由分支，更需要足够多的**变分正交**分支。在 §2.4 的框架下，$|\mathrm{Im}(\sigma)|_{orth}$ 受限于系统的变分正交维度，后者又受限于 $\kappa_\Phi$（路径 Lipschitz 跨度）。当 $\kappa_\Phi \approx 1$（Type A 的路由简并），$|\mathrm{Im}(\sigma)|_{orth} \approx 1$——即使代数上路由分支数庞大（$M^\mathcal{D}$），有效正交分支数坍缩至近 1，CPI 的需求在物理上不可能满足。**这从正交几何层面解释了 Type A 在高判别性目标下的根本失败。**

### 4.3 判别性拟合缺口定理（DFG）

**引理（不可完美拟合集的正测度性，Positive Measure of Imperfect Fitting Sets）**：设 $(\mathcal{X}, d, \mu)$ 为度量概率空间，$\mu$ 完全支撑。设 IDFS $\mathcal{F} = (F, \sigma)$ 的计算映射 $\Phi$ 在各路由分区内局部为 $L_{local}$-Lipschitz，$(r, \mathcal{X}_r) \in \mathcal{S}$，$\mathcal{X}_r$ 紧致且 $\mathrm{int}(\mathcal{X}_r) \neq \emptyset$。若 $r$ 具有 $(\rho, \Delta)$-变分且 $\Delta > \Omega_1(\rho) = L_{local}\rho + \Delta_{\sigma, \text{max}}$（即目标变分超过系统单步拓扑应变力），则对任意 $\tau < (\Delta - L_{local}\rho - \Delta_{\sigma, \text{max}})/2$：

$$\mu\bigl(U_\tau(r)\bigr) \;>\; 0$$

即误差超过 $\tau$ 的输入集合具有严格正测度。

**证明**（由推论 4.2 + 误差函数连续性）：先证 $r$ 在 $\mathcal{X}_r$ 上连续的情形（一般情形见后注）：

1. 由推论 4.2（综合变分下界），$\varepsilon_r = \sup_{z \in \mathcal{X}_r} d(\Phi(z), r(z)) \geq (\Delta - L_{local}\rho - \Delta_{\sigma, \text{max}})/2 > \tau$。
2. 定义误差函数 $g(x) = d(\Phi(x), r(x))$。由 $\Phi$ Lipschitz 与 $r$ 连续，$g$ 在 $\mathcal{X}_r$ 上连续。
3. 由 $\mathcal{X}_r$ 紧致与 $g$ 连续，sup 可达：存在 $x_0 \in \mathcal{X}_r$ 使得 $g(x_0) = \varepsilon_r > \tau$。
4. 由 $g$ 在 $x_0$ 处的连续性，存在 $\delta > 0$ 使得 $B_\delta(x_0) \cap \mathcal{X}_r \subseteq \{x : g(x) > \tau\} \subseteq U_\tau(r)$（$U_\tau$ 以 $\geq$ 定义，包含严格超水平集）。
5. 由 $\mathrm{int}(\mathcal{X}_r) \neq \emptyset$ 且 $x_0 \in \mathcal{X}_r$，取 $\delta$ 足够小使 $B_\delta(x_0) \cap \mathrm{int}(\mathcal{X}_r) \neq \emptyset$。此非空开集由 $\mu$ 的完全支撑性具有正测度，故 $\mu(B_\delta(x_0) \cap \mathcal{X}_r) > 0$。

因此 $\mu(U_\tau(r)) \geq \mu(B_\delta(x_0) \cap \mathcal{X}_r) > 0$。$\square$

> **注（定量下界）**：证明中的 $\delta$ 可被显式量化。由 $g$ 的 Lipschitz 常数 $\mathrm{Lip}(g) \leq L_{local} + \mathrm{Lip}(r)$（在单一路由分区内），令 $\delta_\tau = \frac{\varepsilon_r - \tau}{L_{local} + \mathrm{Lip}(r)}$，则 $B_{\delta_\tau}(x_0) \cap \mathcal{X}_r \subseteq U_\tau(r)$。若 $\mu$ 为 Ahlfors $D$-正则（即存在常数 $c_D^-, c_D^+ > 0$ 使得 $c_D^- \cdot s^D \leq \mu(B_s(x)) \leq c_D^+ \cdot s^D$，其中 $D$ 为 $\mathcal{X}$ 的 Ahlfors 维数），则 $\mu(U_\tau(r)) \geq c_D^- \cdot \delta_\tau^D$。此量化反映了"$r$ 的变分越剧烈（$\Delta/\rho$ 越大）、系统局部越平滑（$L_{local}$ 越小），不可拟合集越大"的直觉。值得注意的是，路由跳变代价 $\Delta_{\sigma, \text{max}}$ 的存在会缩小引理的适用阈值——这意味着在路由碎裂的区域，系统的离散断层已经无偿消耗了一部分拓扑应变力，反而放松了局部拟合的底噪触发条件。

> **注（$r$ 不连续时的一般情形）**：上述证明利用了 $r$ 的连续性来保证 $g$ 连续。若 $r$ 在某点 $x_0 \in \mathrm{int}(\mathcal{X}_r)$ **不连续**（存在 $z_n \to x_0$ 使 $r(z_n) \to a \neq r(x_0)$），则由 $\Phi$ 的连续性 $\Phi(z_n) \to \Phi(x_0)$，故 $g(z_n) \to d(\Phi(x_0), a)$。由三角不等式 $d(a, r(x_0)) \leq d(\Phi(x_0), a) + d(\Phi(x_0), r(x_0))$，故 $\max(d(\Phi(x_0), a),\, g(x_0)) \geq d(a, r(x_0))/2 > 0$。若 $d(\Phi(x_0), a) > 0$，则由 $z \mapsto d(\Phi(z), a)$ 的连续性，存在 $z_n$ 的开邻域使 $g > 0$。因此**连续函数 $\Phi$ 无法跟踪 $r$ 的跳跃，不连续只会扩大 $U_\tau(r)$**——定理结论在一般情形下仍然成立。

**定义（局部判别性，Partial Discriminativity）**：称连续映射 $r$ 在 $\mathcal{X}_r$ 上具有 **$(\beta, k)$-局部判别性**，若存在子集 $A \subseteq \mathcal{X}_r$，$\mu(A) \geq \beta \cdot \mu(\mathcal{X}_r)$（$\beta \in (0,1]$），使得 $r|_A$ 满足 co-Lipschitz 条件：

$$d(r(x), r(y)) \geq k \cdot d(x,y) \quad \forall\, x, y \in A$$

即 $r$ 在其定义域的至少 $\beta$ 比例区域上能严格区分不同输入。参数 $\beta$ 量化了判别性的**覆盖度**，$k$ 量化了判别性的**强度**。

> **注（自然性）**：局部判别性远弱于全局 co-Lipschitz（后者要求 $\beta = 1$）。几乎所有具有实际意义的知识映射都满足此条件：数学运算在几乎全域上严格单调（$\beta \approx 1$）；语言理解将不同输入映射至不同语义表征；逻辑推理由不同前提导出不同结论。仅"常函数型"知识（在正测度集上完全平坦）不满足此条件——但此类知识本身不产生非平凡的拟合需求。

**定理（判别性拟合缺口定理，Discriminative Fitting Gap，DFG）**：设 $(\mathcal{X}, d, \mu)$ 为度量概率空间，$\mu$ 为 Ahlfors $D$-正则测度（即 $c_D^- \cdot s^D \leq \mu(B_s(x)) \leq c_D^+ \cdot s^D$；注意 Ahlfors 正则蕴含完全支撑）。设 IDFS $\mathcal{F} = (F, \sigma)$ 的计算映射 $\Phi$ 在各路由分区内局部为 $L_{local}$-Lipschitz，$(r, \mathcal{X}_r) \in \mathcal{S}$，$r$ 具有 $(\beta, k)$-局部判别性且 $k > L_{local}$（即目标在判别性区域上的 co-Lipschitz 扩张率超过系统在各路由分区内的局部平滑度——在分区内部无路由跳变，故此处不含 $\Delta_\sigma$ 项）。则对任意 $\tau > 0$：

$$\mu\bigl(U_\tau(r)\bigr) \;\geq\; \beta \cdot \mu(\mathcal{X}_r) \;-\; |\mathrm{Im}(\sigma)| \cdot c_D^+ \cdot \left(\frac{2\tau}{k - L_{local}}\right)^D$$

**证明**（路由分区 + co-Lipschitz 直径约束）：

1. **路由分区**：$\sigma$ 将 $\mathcal{X}_r$ 分为至多 $|\mathrm{Im}(\sigma)|$ 个分区单元 $\{C_i\}$，每个单元内 $\Phi|_{C_i}$ 为固定 $L_{local}$-Lipschitz 函数（分区内部不存在路由跳变，$\Delta_\sigma = 0$）。
2. **直径约束**：设 $A$ 为 $r$ 的判别性子集。对每个路由单元 $C_i$，取 $x, y \in S_\tau \cap C_i \cap A$（其中 $S_\tau = \{z : d(\Phi(z), r(z)) < \tau\}$ 为成功集）。由于 $x, y$ 属于同一路由分区，$\Phi$ 在此分区内为连续的 $L_{local}$-Lipschitz 映射，三角不等式给出：
$$k \cdot d(x,y) \leq d(r(x), r(y)) \leq d(r(x), \Phi(x)) + d(\Phi(x), \Phi(y)) + d(\Phi(y), r(y)) < \tau + L_{local} \cdot d(x,y) + \tau$$
故 $(k - L_{local}) \cdot d(x,y) < 2\tau$，即 $\mathrm{diam}(S_\tau \cap C_i \cap A) < \frac{2\tau}{k - L_{local}}$。

3. **体积估计**：$S_\tau \cap C_i \cap A$ 被包含在某直径为 $\frac{2\tau}{k-L_{local}}$ 的球内，由 Ahlfors 正则性：$\mu(S_\tau \cap C_i \cap A) \leq c_D^+ \cdot \left(\frac{2\tau}{k-L_{local}}\right)^D$。
4. **Union bound**：$\mu(S_\tau \cap A) \leq |\mathrm{Im}(\sigma)| \cdot c_D^+ \cdot \left(\frac{2\tau}{k-L_{local}}\right)^D$。
5. **测度差**：$\mu(U_\tau \cap A) = \mu(A) - \mu(S_\tau \cap A) \geq \beta \cdot \mu(\mathcal{X}_r) - |\mathrm{Im}(\sigma)| \cdot c_D^+ \cdot \left(\frac{2\tau}{k-L_{local}}\right)^D$。

由 $U_\tau(r) \supseteq U_\tau \cap A$，结论成立。$\square$

> **注（可解读性）**：界中的两项有清晰的对抗结构。第一项 $\beta \cdot \mu(\mathcal{X}_r)$ 是"目标的判别性区域总量"——$r$ 在其定义域中有多大比例需要被精确区分。第二项 $|\mathrm{Im}(\sigma)| \cdot c_D^+ \cdot \left(\frac{2\tau}{k-L_{local}}\right)^D$ 是"系统通过路由分支所能覆盖的量"——路由多样性 $|\mathrm{Im}(\sigma)|$ 乘以每条路径在 co-Lipschitz 约束下的最大成功集体积。由于使用分区内的局部 $L_{local}$（而非全局 $L \ge L_{local}$），每个分区的成功集直径上界 $2\tau/(k-L_{local})$ 更为紧致，使得 DFG 给出的测度下界**严格强于**使用全局 $L$ 时的版本。特别地，下界为正的充分条件为：
> $$\tau \;<\; \frac{k - L_{local}}{2}\left(\frac{\beta \cdot \mu(\mathcal{X}_r)}{|\mathrm{Im}(\sigma)| \cdot c_D^+}\right)^{1/D}$$

**推论（宏观容错界的不可突破定理，Unbreakable Bound on Macroscopic Error Tolerance）**：设 DFG 定理的假设成立。若要求不可拟合集的测度占比不超过容忍度 $\alpha$（$0 \leq \alpha < \beta$），即 $\mu(U_\tau(r)) \leq \alpha \cdot \mu(\mathcal{X}_r)$，则误差容差 $\tau$ 必须满足：

$$\tau \;\geq\; \frac{k - L_{local}}{2} \cdot \left( \frac{(\beta - \alpha) \cdot \mu(\mathcal{X}_r)}{|\mathrm{Im}(\sigma)| \cdot c_D^+} \right)^{1/D}$$

**证明**：将系统要求 $\mu(U_\tau(r)) \leq \alpha \cdot \mu(\mathcal{X}_r)$ 代入 DFG 定理的测度下界结论中得：
$$ \alpha \cdot \mu(\mathcal{X}_r) \;\geq\; \mu(U_\tau(r)) \;\geq\; \beta \cdot \mu(\mathcal{X}_r) \;-\; |\mathrm{Im}(\sigma)| \cdot c_D^+ \cdot \left(\frac{2\tau}{k - L_{local}}\right)^D $$
移项并隔离参数 $\tau$ 项：
$$ |\mathrm{Im}(\sigma)| \cdot c_D^+ \cdot \left(\frac{2\tau}{k - L_{local}}\right)^D \;\geq\; (\beta - \alpha) \cdot \mu(\mathcal{X}_r) $$
由于 $k > L_{local}$，两边同取 $1/D$ 次方并移去系数 $\frac{2}{k-L_{local}}$，即立刻解出 $\tau$ 必须满足如下不等式：
$$ \tau \;\geq\; \frac{k - L_{local}}{2} \cdot \left( \frac{(\beta - \alpha) \cdot \mu(\mathcal{X}_r)}{|\mathrm{Im}(\sigma)| \cdot c_D^+} \right)^{1/D} $$
$\square$

> **注（物理实质解读与维度诅呒）**：此推论揭示了此下界的极其重要的物理意义：
> 1. **有效复杂度阻力 $(\beta - \alpha)$**：当目标函数的判别性覆盖率 $\beta$ 超过系统业务层面允许的失败率 $\alpha$ 时，此数学法则即被直接触发。若期望完全拟合（$\alpha \to 0$），分子取到极限 $\beta$。
> 2. **拓扑拉扯惩罚 $(k - L_{local})/2$**：误差基底严格正比于目标判别强度 $k$ 与系统**分区内局部平滑度** $L_{local}$ 之差。注意此处使用的是 $L_{local}$（而非全局 $L$），这使得拓扑拉扯惩罚更为精确——当 $L_{local} \ll L$ 时（即系统在分区内部远比跨分区时更平滑），该惩罚项更大，不可拟合的误差底线也随之抬高。这意味着系统越是依赖路由碎裂来“购买”正交自由度（大 $L$, 小 $L_{local}$），其在**每个碎片内部**所必须承受的拟合精度代价就越高。
> 3. **宏观维度诅呒（Dimensionality Curse 的终极形式）**：括号外侧的 $1/D$ 次方揭示了核心的维度效应。设系统的路由分支数 $|\mathrm{Im}(\sigma)|$ 随维度 $D$ 的增长率为 $M(D)$。若 $M(D)$ 至多为 $D$ 的亚指数函数（即 $\log M(D) = o(D)$，对应于多项式或亚指数级的系统容量增长——这对绝大多数实际可实现的系统而言是合理的假设），则：
> $$\left(\frac{(\beta - \alpha)\mu(\mathcal{X}_r)}{M(D) \cdot c_D^+}\right)^{1/D} \;\to\; 1 \quad (D \to \infty)$$
> 此时容错极限收敛至：$\tau_{min} \to \frac{k - L_{local}}{2}$。该定论表明，在亚指数容量增长体制下，纯粹依靠"暴力扩大网络容量"来抗击高维复杂知识特征的逼近误差，注定会在维度面前丧失边际效益——误差被焘死在由目标与系统在分区内的拓扑拉扯差 $(k-L_{local})/2$ 决定的硬底上。唯有路由分支数以 $2^{\Omega(D)}$ 速率指数增长（即系统容量与输入维度呈指数对抗），方能突破此维度封锁——但这在工程上等价于对输入空间的逐点穷举，本身即意味着泛化能力的完全丧失。
