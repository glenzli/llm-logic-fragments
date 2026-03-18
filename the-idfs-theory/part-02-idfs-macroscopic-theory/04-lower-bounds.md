## 逼近误差的下界

### 4.1 组合近似瓶颈定理（CAB）

**定理 4.1（组合近似瓶颈定理，Compositional Approximation Bottleneck，CAB）**：
设系统以容差集 $\mathcal{E}$ 拟合了微观采样集 $\mathcal{S}$。对任意长度为 $l$ 的宏观有效链 $q \in \mathcal{T}_l$，设其对应的端到端物理系统映射为 $l$ 次迭代的复合 $\Phi_q = \Phi \circ \dots \circ \Phi$。

设某输入对 $x, y \in \mathrm{dom}(q)$ 满足以下空间相态（$x, y \in \mathrm{dom}(q)$ 保证理想链 $q$ 在两点处可执行，即 $q(x), q(y) \neq \bot$；近似轨道 $\Phi_q(x), \Phi_q(y)$ 由 IDFS 闭合性保证为 $\mathcal{X}$ 中的良定义元素）：
1. **输入分离与目标跃迁**：起点的初始距离为 $d(x, y) = \delta > 0$，但在理想长链 $q$ 下的映射距离跃迁为 $d(q(x), q(y)) = \Delta > 0$。
2. **拟合参数**：系统在参考点 $x$ 处的端到端逼近误差（拟合残差）记为 $\varepsilon_x \triangleq d(\Phi_q(x), q(x)) \geq 0$。
3. **系统扩张极限（拓扑应变力）**：系统在宏观映射下的最大分离拉伸，由 IDFS 的分段 Lipschitz 结构与路由跳变累积共同决定。在每一单步中，$\Phi$ 在路由分区内部满足 $L_j$-Lipschitz（连续拉伸），而跨越路由边界时额外引入平移跳变代价 $\Delta_{\sigma,j}$。经过 $l$ 步累积，两条从 $x$ 与 $y$ 出发的近似轨道之间的最大分离，等于连续平滑拉伸（$\Theta_{1,l} \cdot \delta$）与各步路由跳变经尾部乘积放大后的加权总和。记全链路的**最大拓扑应变力（Maximum Topological Strain Capacity）**为：
   $$\Omega_{l}(\delta) \;\triangleq\; \underbrace{\Theta_{1,l} \cdot \delta}_{\text{基础平滑拉伸}} \;+\; \underbrace{\sum_{j=1}^l \Delta_{\sigma, j} \cdot \Theta_{j+1,l}}_{\text{多步路由跳变累积}}$$
   在此路径上的最大相对拉伸被紧致地界定为 $d(\Phi_q(x), \Phi_q(y)) \leq \Omega_{l}(\delta)$。（该界由逐步递推 $d(h_j^x, h_j^y) \leq L_j \cdot d(h_{j-1}^x, h_{j-1}^y) + \Delta_{\sigma,j}$——桥接同一 $f$-链的 Lipschitz 性与跨路由跳变——展开得到，结构与 CAC 递推同构。）

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
> 这从底层理论上解释了，在处理高变分目标时，为何引入非连续的门控结构是必要的：**严格的平滑连续映射会在高变分目标前迅速丧失逼近容量**，而通过局部路由切换引入受控的拓扑断裂，正是系统为了规避逼近误差极值下界、实现泛化能力解耦的重要机制。

> **注（末端结构瓶颈 $\varepsilon_{y,\text{out}}$ 的含义）**：项 $\varepsilon_{y,\text{out}}$ 剖离出了 IDFS 末端算子层的结构刚性。无论前置映射 $\Phi'_q$ 将中间态流形通过应变力撕裂得多么复杂，IDFS 的端到端最终输出必须经过某个底层算子 $f \in F$ 映射回输出空间。若目标像点 $q(y)$ 不在任何 $f \in F$ 的可达集 $\bigcup_{f \in F} f(\mathcal{X})$ 中，则 $\varepsilon_{y,\text{out}} > 0$ 成为不可消除的常数瓶颈：此时前置计算中的一切精妙运算与路由碎裂皆无用武之地，端到端误差被末端算子的结构底盖死死卡定。

**推论 4.2（CAB 界的紧性，Tightness of the CAB Bound）**：对任意给定的单步拉伸常数序列 $L_j \geq 1$、拓扑路由跃迁代价序列 $\Delta_{\sigma,j} \geq 0$、输入截距 $\delta > 0$、参考点拟合精度 $\varepsilon_x \geq 0$ 及目标突跳变分 $\Delta > 0$，只要 $\Delta > \varepsilon_x + \Omega_l(\delta)$（即拓扑死锁下迫界严格为正），在维度不小于 1 的任意 Banach 空间（或 $\mathbb{R}^n$）中，**必然存在**一对相应的 IDFS 构型 $(F, \sigma)$ 与物理演化目标链 $q$，使得 CAB 被精密重构并触发极值死锁：

$$\varepsilon^*_y \;=\; \Delta \;-\; \varepsilon_x \;-\; \Omega_l(\delta)$$

即：即使系统投入了错综复杂的断裂路由（$\Delta_\sigma > 0$），理论计算给出的该死锁下界在广泛的泛函空间中也是**无可改善的（存在紧致实例全额变现该灾难下界）**。

**证明（同向极化构筑，Collinear Polarization Construction）**：
为证明涵盖 $\Delta_{\sigma,j} > 0$ 时的界限绝对紧致性，我们构造一个让系统极值拓扑应变力被“单向榨干”的张量流形特例。此构造机制与前述上界 推论 3.4 （关于 CAC 上界的严格坍缩证明）的底层几何公理完全同构：即利用所有误差源在单一方向上的**共线坍缩（Collinear Collapse）**。

设系统嵌入于 Banach 空间 $\mathcal{X}$ 中。取任意单位向量 $v \in \mathcal{X}$（$\|v\| = 1$），作为构造中所有误差源与演化方向的公共对齐轴。

1. **输入与定向对齐**：
   设定考量点 $x = 0$ 及其邻接点 $y = \delta \cdot v$（满足 $d(x,y) = \delta$）。
   设定目标最终演化落点为 $q(x) = 0$ 和 $q(y) = \Delta \cdot v$（满足目标间距跳跃 $d(q(x), q(y)) = \Delta$）。

2. **植入原点拟合偏差**：
   令系统由于过拟合或其他非连续干预机制，在 $x$ 处的宏观实际复合输出设定为 $\Phi^l(x) = \varepsilon_x \cdot v$。此时初态误差距离 $d(\Phi^l(x), q(x)) = \varepsilon_x$ 核验通过。

3. **最大化应变力演化加载（关键步）**：
   在长度为 $l$ 的累积迭代映射中，令系统使用的基函数簇仅沿着射线 $v$ 的方向产生最不利拉伸：每经历第 $j$ 步更新，物理演化沿 $v$ 被线性扩张 $L_j$ 倍。更极端地是，令其网格划分 $\sigma$ 在这每一步的 $y$ 的轨迹前缘精准穿插一条跨路由分界面（路由切换缝），导致基底函数替换而强行引入的向量平移跳变正相平行于 $v$ 且振幅恰为预留的 $\Delta_{\sigma, j}$。
   经历全 $l$ 步物理洗礼后，系统在 $y$ 与 $x$ 的相对分离不仅达到其 Lipschitz 几何倍缩展，更叠加上了一切碎片跃迁向量之和：
   $$\Phi^l(y) - \Phi^l(x) \;=\; \left( \Theta_{1,l}\cdot\delta + \sum_{j=1}^l \Delta_{\sigma,j}\Theta_{j+1,l} \right) \cdot v \;=\; \Omega_l(\delta) \cdot v$$
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

**推论 4.3（近似误差的综合变分下界，Comprehensive Variation Bound on Approx Error）**：设系统由近端区域的点间单步演化中可能伴随路径门控切换，将其局部单步拓展拉伸限记为 $\Omega_1(\rho) = L_{local}\cdot \rho + \Delta_{\sigma, \text{max}}$。设 $(r, \mathcal{X}_r) \in \mathcal{S}$，$r$ 在 $\mathcal{X}_r$ 上具有 $(\rho, \Delta)$-变分，记 $\varepsilon_r = \sup_{z \in \mathcal{X}_r} d(\Phi(z), r(z))$。则必然成立：

$$2\varepsilon_r \;+\; \Omega_1(\rho) \;\geq\; \Delta$$
即：
$$2\varepsilon_r \;+\; L_{local}\cdot\rho \;+\; \Delta_{\sigma, \text{max}} \;\geq\; \Delta$$

**证明（由 CAB 特化）**：取满足 $(\rho, \Delta)$-变分条件的点对 $x, y \in \mathcal{X}_r$。将 CAB 拓扑死锁界特化至 $l = 1$（单步，系统拉伸极度扩展至此单步应变极值 $\Omega_1(\delta)$）：

$$\varepsilon^*_y \;\geq\; \Delta_q - \varepsilon_x - \Omega_1(\delta) \;\geq\; \Delta - \varepsilon_x - (L_{local}\rho + \Delta_{\sigma, \text{max}})$$

由于局部闭集上的度量控制，$x, y \in \mathcal{X}_r$，两点的误差均受同一 sup 约束限制：$\varepsilon_x \leq \varepsilon_r$，$\varepsilon^*_y \leq \varepsilon_r$。代入上式解开：$\varepsilon_r \geq \Delta - \varepsilon_r - L_{local}\rho - \Delta_{\sigma, \text{max}}$，移项后即得所证综合表达式。$\square$

> **注（变分四元张力律）**：不等式 $2\varepsilon_r + L_{local}\rho + \Delta_{\sigma, \text{max}} \geq \Delta$ 刻画了四个极值参数间的根本性互斥张力：局部变分强度（宏观上表现为 $\Delta/\rho$）、路径局部平滑度（$L_{local}$）、离散路由跳跃界（$\Delta_{\sigma, \text{max}}$）与单步拟合残差（$\varepsilon_r$）无法同时被极小化。对于主要依赖连续映射的平滑系统（$L_{local} \ll L$ 且 $\Delta_\sigma \approx 0$），若强制逼近高频变分目标，必须承担**实质性的基础拟合误差 $\varepsilon_r \geq (\Delta - L_{local}\rho)/2$**。引入非连续路由门控以提升 $\Delta_{\sigma}$ 上限，其本质正是为了化解此处的极小化冲突。

> **注（与 5-Term CAC 的底层对接）**：推论 4.3 为五项精细化上界机制提供了下界的对偶解释。它揭示了单步泛化误差 $\varepsilon_{i_j}$ 不可规避的物理来源：输入空间的高变异度必然需要在演化中得以释放——要么通过剧烈的连续扭曲（增大 $L$），要么通过离散的拓扑断崖（积聚 $\Delta_\sigma$），否则就必须承受静态的底线错位（导致大 $\varepsilon_r$）。CAB 下界定出了这种局部妥协的最小代价；而一旦进入 CAC 上界的传导阶段，这些微观层面无法消除的单步误差，将立刻与宏观尾部扩张系数 $\Theta_{j+1,l}$ 发生乘性耦合，最终在端到端尺度上引发指数级扩散。这种从微观代价必然性到宏观误差爆炸性生长的完整链条，正是 OOD 坍塌定律的物理本质。

> **注（从几何基点向高维分布的延展）**：以上推论确立了最纯粹的度量几何底线，证明了即使在两点间也必然存在无法弥合的误差张力。然而，实际的物理系统与训练集绝非孤立的点对，而是一个具有特定统计测度（$\mu$）与内在维度（$D$）的复杂数据流形。当我们将这一“单点上的几何死锁”放入高维概率空间中考量时，局部的误差张力将不可避免地在流形上弥散，演化为大面积的、具有正测度的“不可拟合灾区”。这种由几何局域极值向全局统计失效的升维推演，正是后续 DFG 定理（co-Lipschitz 拟合缺口，§4.3）及其所揭示的“维度诅咒”的物理雏形。

> **注（扩展到 $\mathrm{dom}(r)$ 时的三元纠缠）**：推论 4.3 的分析严格限于采样域 $\mathcal{X}(r)$，其中 $\sigma$ 隐含于 $\Phi$ 的构造而不显式出现，两元张力 $(\varepsilon_r, L_{local})$ 足以刻画。若将分析扩展至整个 $\mathrm{dom}(r) \supseteq \mathcal{X}(r)$，则在 $\mathrm{dom}(r) \setminus \mathcal{X}(r)$ 的区域内，$\Phi(z) = \sigma(z)(z)$ 不受采样约束，$\sigma$ 的决策边界可能在 $\partial\mathcal{X}(r)$ 处被激活：由 命题 2.7（路由分辨率极限），跨越边界时路径局部 Lipschitz $L_j$ 逼近系统全局极限 $L$，使分辨率死锁在边界处达到最极端形态。此时变分约束涉及**三元纠缠** $(\varepsilon_r,\, L,\, \sigma)$——三者无法分别独立优化，对 $\mathrm{dom}(r)$ 的分析须同时约束 $\sigma$ 在 $\partial\mathcal{X}(r)$ 处的边界曲率。因此推论 4.2 的主体保持在 $\mathcal{X}(r)$ 上以确保形式严格性；三元纠缠的正式处理见 命题 5.6。


**命题 4.4（综合逼近可行性条件，Comprehensive Approximation Feasibility）**：由 CAC 定理（上界）与 CAB 定理（下界）联合推导出系统逼近泛化的理论天花板。设 IDFS $\mathcal{F} = (F, \sigma)$ 拟合了采样集 $\mathcal{S}$，各极限参数齐备。对任意有效链 $q \in \mathcal{T}_l$ 和任意 $x, y \in \mathrm{dom}(q)$（$d(x,y) = \delta$），记目标变分 $\Delta = d(q(x), q(y))$。

定义**综合逼近天花板阈值（Comprehensive Approximation Threshold）**：

$$\mathcal{A}_l(\delta) \;\triangleq\; \underbrace{\Omega_l(\delta)}_{\text{拓扑应变力限}} \;+\; \underbrace{(\varepsilon_{\max} + \rho_{\max} + \Delta_{\max}) \cdot \Lambda_l}_{\text{微观拟合与路由耗损}} \;+\; \underbrace{\delta_{\max} \cdot \Gamma_l}_{\text{采样偏离空间底压}}$$

（注：其中 $\Omega_l(\delta) = \Theta_{1,l}\cdot\delta + \Delta_{\max}\cdot\Lambda_l$ 为 $x$-$y$ 近似轨道间的路由差异代价；$\Delta_{\max}\Lambda_l$ 项另行出现于微观耗损中，对应 CAC 中理想-近似轨道间的路由失配代价——两者度量不同的物理路由跳变，不可合并）

则系统在 $y$ 处的宏观逼近误差带有绝对不可逆跨越的数学下底线：

$$\varepsilon^*_y \;\geq\; \Delta \;-\; \mathcal{A}_l(\delta)$$

**含义**：当系统面对的目标变分 $\Delta > \mathcal{A}_l(\delta)$ 时，即便在参考点 $x$ 处投入无尽的拟合资源使其误差逼近完美（即 $\varepsilon_x \to 0$），该系统在因目标突跳而产生的邻近点 $y$ 处，依然面临不可压缩的刚性正偏差 $\varepsilon^*_y > 0$。此条件界定了任何 IDFS 架构在应对突跳目标时的泛化有效性边界。

**证明**：由 CAB 死锁界：$\varepsilon^*_y \geq \Delta - \varepsilon_x - \Omega_l(\delta)$。由 CAC 上界（形式 A 均匀化）：$\varepsilon_x \leq (\varepsilon_{max} + \rho_{max} + \Delta_{max})\Lambda_l + \delta_{max}\Gamma_l$。代入：
$$\varepsilon^*_y \geq \Delta - (\varepsilon_{max} + \rho_{max} + \Delta_{max})\Lambda_l - \delta_{max}\Gamma_l - \Omega_l(\delta) = \Delta - \mathcal{A}_l(\delta)$$
其中 $\Omega_l(\delta) \leq \Theta_{1,l}\cdot\delta + \Delta_{max}\Lambda_l$，与 CAC 中的 $\Delta_{max}\Lambda_l$ 分别对应两种独立的路由跳变来源（轨道间 vs 理想-近似间），不可合并。$\square$

> **注（逼近资源三元预算解构）**：逼近阈值 $\mathcal{A}_l(\delta)$ 结构性地分解为三个彼此独立的刚性物理预算：
> - **拓扑应变极限 $\Omega_l(\delta)$**：系统跟随并包容目标变分的唯一主动结构性支撑，融合了系统固有的动态连续扩张本底 $\bar{L}$ 和离散路由门控赋予的跳变余量 $\Delta_\sigma$。
> - **拟合与路由综合耗损 $(\varepsilon_{max}+\rho_{max}+\Delta_{max})\Lambda_l$**：由微观近似残差、局部目标变异与理想-近似轨道间路由失配带来的内生性妥协底座，经由系统尾部连乘不可控地放大。
> - **采样偏离底压 $\delta_{max}\Gamma_l$**：由观测流形与实际计算基座点间的刚性剥离诱发的累积空间漂移代价。
>
> 目标若强行越过这三项预算构筑的容限上限时，系统必将遭遇原理性的外推失效。特别指出，在参数饱和度极化体制下（参照 推论 3.7，即当 $\Lambda_\infty < \infty$），该整体阈值将强制退化收敛为一个与初始输入距 $\delta$ 无关的有界常数，从而从根本逻辑上宣判长逻辑链对高频脉冲响应能力的丧失。

### 4.2 链误差下界（Chain Error Lower Bound, CEL）

§4.1 的下界针对**单步或端到端**的拟合误差。本节推导**链误差**（多步组合误差）的上确界下界——当系统 $\Phi$ 沿链路径的各步 $f$-链具有 co-Lipschitz 性且存在非零种子误差时，链的最大误差随深度几何增长。

**定义（$k$-co-Lipschitz 子集）**：设 $g: \mathcal{X} \to \mathcal{X}$ 为映射。称 $g$ 在 $A \subseteq \mathrm{dom}(g)$ 上 **$k$-co-Lipschitz**，若：

$$d(g(x), g(y)) \geq k \cdot d(x,y) \quad \forall\, x, y \in A$$

co-Lipschitz 性度量映射的**信息保持度**：$k > 0$ 保证不同输入映射为不同输出（单射性的量化加强），$k > 1$ 表示映射放大距离。对任意映射，其 co-Lipschitz 常数 $k$ 不超过 Lipschitz 常数 $L$。

> **注（与 §2 拟合形态的联系）**：在 IDFS 中 $\Phi|_{C_i} = f_i$（路由分区内系统为单一基函数）。$f_i$ 在 $C_i$ 上的 co-Lipschitz 性质对应不同的拟合形态：Logic Fitting（$J$ 有界，$k > 0$）→ 信息保持；Fact Fitting（$J \to 0$，$k = 0$）→ 信息坍缩，不满足 co-Lipschitz；Verbatim Fitting（$J \to \infty$，$k \gg 1$）→ 高保真但高放大。

**定理 4.5（链误差下界，Chain Error Lower Bound, CEL）**：设 IDFS $\mathcal{F} = (F, \sigma)$，链 $q = (r_{i_1}, \ldots, r_{i_l}) \in \mathcal{T}_l$（$l \geq 2$），$x_0 \in \mathrm{dom}(q)$。记理想轨道 $h^*_j = r_{i_j}(h^*_{j-1})$（$h^*_0 = x_0$），实际轨道 $h_j = \Phi(h_{j-1})$，链误差 $e_j = d(h_j, h^*_j)$。

设第 $j$ 步理想轨道所选路由 $\sigma(h^*_{j-1}) = f_{a_j}$（与 CAC 中 $L_j$ 的约定一致）在包含 $h_{j-1}, h^*_{j-1}$ 的区域上 $k_j$-co-Lipschitz。定义**路由失配代价**（与 CAC 中的 $\Delta^{err}_j$ 对偶）：

$$\Delta^{co}_j \;\triangleq\; d(\sigma(h_{j-1})(h_{j-1}),\; \sigma(h^*_{j-1})(h_{j-1}))$$

即同一输入 $h_{j-1}$ 在实际路由与理想路由下的输出差异。设 $\Phi$ 以误差 $\varepsilon_j$ 拟合 $r_{i_j}$（$\sup_x d(\Phi(x), r_{i_j}(x)) \leq \varepsilon_j$）。设种子误差 $\tau > 0$：$\exists\, x_0$ 使得 $e_1 \geq \tau$。则单步递推为：

$$e_j \;\geq\; k_j \cdot e_{j-1} \;-\; \Delta^{co}_j \;-\; \varepsilon_j$$

闭式下界为：

$$\sup_{x_0} e_l \;\geq\; \tau \cdot \prod_{j=2}^{l} k_j \;-\; \sum_{j=2}^{l}\left(\Delta^{co}_j + \varepsilon_j\right) \cdot \prod_{i=j+1}^{l} k_i$$

记 $k_{\min} = \min_j k_j$，$C_{\max} = \max_j (\Delta^{co}_j + \varepsilon_j)$，则：

$$\sup_{x_0} e_l \;\geq\; k_{\min}^{l-1}\left(\tau - \frac{C_{\max}}{k_{\min} - 1}\right) + \frac{C_{\max}}{k_{\min} - 1}$$

当 $k_{\min} > 1$ 且 $\tau > C_{\max}/(k_{\min} - 1)$ 时，下界为正且随 $l$ 几何增长。

**证明**：

1. $e_1 \geq \tau$（给定）。
2. 对 $j \geq 2$，分解 $d(\Phi(h_{j-1}), \Phi(h^*_{j-1}))$。由反三角不等式，插入中间点 $\sigma(h^*_{j-1})(h_{j-1})$（理想路由对实际轨道点的输出）：
$$d(\Phi(h_{j-1}), \Phi(h^*_{j-1})) = d(\sigma(h_{j-1})(h_{j-1}),\; \sigma(h^*_{j-1})(h^*_{j-1})) \;\geq\; d(\sigma(h^*_{j-1})(h_{j-1}),\; \sigma(h^*_{j-1})(h^*_{j-1})) - d(\sigma(h_{j-1})(h_{j-1}),\; \sigma(h^*_{j-1})(h_{j-1}))$$
第一项：同一 $f$-链 $\sigma(h^*_{j-1}) = f_{a_j}$ 作用于 $h_{j-1}$ 与 $h^*_{j-1}$，由 $f_{a_j}$ 的 $k_j$-co-Lipschitz：$\geq k_j \cdot e_{j-1}$。
第二项：$= \Delta^{co}_j$（路由失配代价）。
合并：$d(\Phi(h_{j-1}), \Phi(h^*_{j-1})) \geq k_j \cdot e_{j-1} - \Delta^{co}_j$。
3. 反三角不等式展开 $e_j$：
$$e_j = d(\Phi(h_{j-1}), r_{i_j}(h^*_{j-1})) \;\geq\; d(\Phi(h_{j-1}), \Phi(h^*_{j-1})) - d(\Phi(h^*_{j-1}), r_{i_j}(h^*_{j-1})) \;\geq\; k_j \cdot e_{j-1} - \Delta^{co}_j - \varepsilon_j$$
4. 展开递推即得闭式解。$\square$

> **注（与 CAC 的逐步对偶）**：CAC 与 CEL 的递推共享同一步的 $f$-链 $\sigma(h^*_{j-1}) = f_{a_j}$，其 Lip 常数为 $L_j$，co-Lip 常数为 $k_j$（$k_j \leq L_j$）。逐步对偶结构为：
>
> $$k_j \cdot e_{j-1} - (\Delta^{co}_j + \varepsilon_j) \;\leq\; e_j \;\leq\; L_j \cdot e_{j-1} + (\varepsilon_{i_j} + \rho_j + L_j\delta_j + \Delta_{\sigma,j})$$
>
> | | CAC（上界） | CEL（下界） |
> |---|---|---|
> | 放大因子 | $L_j$（路径 Lip） | $k_j$（路径 co-Lip） |
> | 同一 $f$-链 | $\sigma(h^*_{j-1})$ | $\sigma(h^*_{j-1})$ |
> | 噪声方向 | 累积（$+$） | 消耗（$-$） |
> | 路由失配 | $\Delta^{err}_j + \Delta^{sam}_j$ | $\Delta^{co}_j$ |
> | 增长条件 | $L_j > 1$ | $k_j > 1$（蕴含 $L_j > 1$） |

### 4.3 type-$p$ 统计下界

§4.2 的 CEL 通过逐步标量递推得到误差增长下界，噪声项取最坏情形（全额线性消耗）。本节在 §3.2 引理 3.11 的线性化误差传播框架下，直接从**向量**层面推导下界——利用 type-$p$ 空间的方向对消性质，收紧噪声消耗，**抬高**下界。

**定理 4.6（type-$p$ 统计下界，Statistical Lower Bound，SLB）**：设引理 3.11 的线性化框架成立且余项可忽略。设 $\mathcal{X}$ 为 type-$p$ Banach 空间（$1 \leq p \leq 2$），传播算子 $T_{1,l}$ 的最小奇异值（co-范数）$\sigma_{\min}(T_{1,l}) \geq \kappa_l > 0$（即 $\|T_{1,l} \cdot \mathbf{v}\| \geq \kappa_l \cdot \|\mathbf{v}\|$），传播后噪声序列 $\{T_{s+1,l} \cdot \mathbf{n}_s\}$ 的有效相关长度为 $\tau_c$。设噪声为零均值（$\mathbb{E}[\mathbf{n}_s] = 0$）或已分离非零均值分量（参见推论 4.7 的漂移-消耗分解；非零均值分量以 $\mathcal{O}(l)$ 线性消耗）。则零均值噪声分量的消耗满足：

$$\|\mathbf{e}_l\| \;\geq\; \kappa_l \cdot \|\mathbf{e}_0\| \;-\; \mathcal{O}\!\left(\tau_c^{1-1/p} \cdot l^{1/p}\right)$$

**证明**：

1. 由引理 3.11：$\mathbf{e}_l = T_{1,l} \cdot \mathbf{e}_0 + \sum_{s=1}^{l} T_{s+1,l} \cdot \mathbf{n}_s$。
2. 反三角不等式：$\|\mathbf{e}_l\| \geq \|T_{1,l} \cdot \mathbf{e}_0\| - \|\sum_{s=1}^{l} T_{s+1,l} \cdot \mathbf{n}_s\|$。
3. 第一项：由 $T_{1,l}$ 的 co-范数定义，$\|T_{1,l} \cdot \mathbf{e}_0\| \geq \kappa_l \cdot \|\mathbf{e}_0\|$。
4. 第二项：与定理 3.12（SUB）证明完全同构——将噪声序列分块，块内最坏情形叠加，块间应用 type-$p$ 不等式，得 $\|\sum T_{s+1,l} \cdot \mathbf{n}_s\| \sim \mathcal{O}(\tau_c^{1-1/p} \cdot l^{1/p})$。
5. 合并即得。$\square$

> **注（$\kappa_l$ 与 CEL 中 $\prod k_j$ 的关系）**：$\kappa_l = \sigma_{\min}(T_{1,l}) = \sigma_{\min}(\prod A_j)$。当各 $A_j$ 为正规算子时 $\sigma_{\min}(\prod A_j) = \prod \sigma_{\min}(A_j)$，此时 $\kappa_l = \prod k_j$（与 CEL 的路径 co-Lip 乘积一致）。一般情形下 $\kappa_l \leq \prod \sigma_{\min}(A_j)$。

> **注（与定理 3.12 的对偶结构）**：SLB 和 SUB 共享同一噪声向量和 $\sum T_{s+1,l} \cdot \mathbf{n}_s$，但对其使用方向相反：
>
> | | SUB（§3.2 定理 3.12） | SLB（本定理） |
> |---|---|---|
> | 误差界方向 | 上界（$\leq$） | 下界（$\geq$） |
> | 系统项 | $\|T_{1,l}\| \cdot \|\mathbf{e}_0\| \leq \Theta_{1,l} \cdot \|\mathbf{e}_0\|$ | $\|T_{1,l} \cdot \mathbf{e}_0\| \geq \kappa_l \cdot \|\mathbf{e}_0\|$ |
> | 噪声项 | $+\;\|\sum T \cdot \mathbf{n}\|$（累积） | $-\;\|\sum T \cdot \mathbf{n}\|$（消耗） |
> | type-$p$ 效果 | 累积减少 → 上界下降 | 消耗减少 → 下界上升 |
>
> 两者从相反方向收拢。在理想统计极限（$p=2$，$\tau_c=1$）下，噪声阶均为 $\mathcal{O}(\sqrt{l})$，误差被夹逼在 $[\kappa_l \tau - \mathcal{O}(\sqrt{l}),\; \Theta_{1,l} \tau + \mathcal{O}(\sqrt{l})]$ 的窄带内。

**推论 4.7（漂移-消耗对偶，Drift-Consumption Duality）**：将噪声向量 $\mathbf{n}_s$ 沿 $T_{1,l} \cdot \mathbf{e}_0$ 方向正交分解（对偶于 §3.2 推论 3.14 的漂移-扩散分解）：

$$\mathbf{n}_s \;=\; \mu^{co}_s \;+\; \eta^{co}_s$$

其中 $\mu^{co}_s$ 为沿初始误差传播方向的投影（**有效消耗**），$\eta^{co}_s$ 为正交分量（**无效消耗**）。则噪声消耗总量分解为：

$$\left\|\sum_{s=1}^{l} T_{s+1,l} \cdot \mathbf{n}_s\right\| \;\leq\; \underbrace{\left\|\sum T_{s+1,l} \cdot \mu^{co}_s\right\|}_{\text{有效消耗：}\mathcal{O}(l)} \;+\; \underbrace{\left\|\sum T_{s+1,l} \cdot \eta^{co}_s\right\|}_{\text{无效消耗：}\mathcal{O}(\tau_c^{1-1/p} l^{1/p})}$$

有效消耗（漂移分量）与增长方向对齐，全额线性消耗增长——这是噪声真正"阻止"误差增长的部分。无效消耗（扩散分量）正交于增长方向，由 type-$p$ 对消限制为 $\mathcal{O}(l^{1/p})$ 阶。

> **注（CAC 坍缩的对偶）**：§3.2 推论 3.15 证明了 CAC 坍缩等价于系统漂移占主导（$\eta = 0$，随机扩散消失）。对偶地，CEL 增长最持久的情形等价于有效消耗为零（$\mu^{co} = 0$）——所有噪声正交于增长方向，无法阻止误差增长。此时 $\|\mathbf{e}_l\| \geq \kappa_l \tau - \mathcal{O}(l^{1/p})$，误差以接近纯 $\kappa_l$ 的速率增长。
