## 逼近误差的上界

### 3.1 组合近似封闭定理（CAC）

**定理（组合近似封闭性，Compositional Approximation Closure，CAC；亦称组合泛化定理，Combinatorial Generalization Theorem，CGT）**：设 IDFS $\mathcal{F} = (F, \sigma)$，$\Phi \in \mathrm{Lip}(\mathcal{X})$（§1.2）。若该基础 IDFS 以容差集 $\mathcal{E}$ 拟合了微观采样集 $\mathcal{S}$（§1.3），则由其诱导出的 $l$-步宏观系统 $\mathcal{F}_l = (F, \sigma_l)$，必将以宏观容差集 $\mathcal{E}^*$ 拟合由 $\mathcal{S}$ 生成的、深度限定为 $l$ 的宏观有效链集 $\mathcal{T}_l$（§1.1）。

具体而言，对任意宏观链 $q \in \mathcal{T}_l$（其中 $q = r_{i_l} \circ \cdots \circ r_{i_1}$，确切长度为 $l$），其所对应的宏观容差 $\varepsilon^*_q \in \mathcal{E}^*$ 由下式定界：对于任意初始输入 $x \in \mathrm{dom}(q)$，定义**理想轨道**与**近似轨道**：

$$h^*_0 = x, \quad h^*_j = r_{i_j}(h^*_{j-1}) \qquad \text{（理想轨道，沿 }r\text{-链执行）}$$
$$h_0 = x, \quad h_j = \Phi(h_{j-1}) \qquad \text{（近似轨道，沿 }\Phi\text{ 执行）}$$

记 $e_j = d(h_j,\, h^*_j)$（第 $j$ 步误差），$e_0 = 0$。记第 $j$ 步的理想中间态 $h^*_{j-1}$ 处，$\sigma$ 所选定的激活链（§1.2）为 $\sigma(h^*_{j-1}) \in F^*$。定义该步的 **理想轨道激活链 Lipschitz 常数**：

$$L_j \;\triangleq\; \mathrm{Lip}\bigl(\sigma(h^*_{j-1})\bigr)$$

$L_j$ 是理想轨道在第 $j$ 步所选定的**激活链** $\sigma(h^*_{j-1})$ 在相关邻域内的度量性质——不涉及其他路由区域的激活链行为，也不涉及实际轨道 $h_{j-1}$ 的路由分配。记**尾部乘积**：

$$\Theta_{j,l} \;\triangleq\; \prod_{k=j}^{l} L_k \qquad \text{（$j > l$ 时约定空积 $\Theta_{j,l} = 1$）}$$

定义**误差累积放大系数**与**系统偏离累积放大系数**：

$$\Lambda_l \;\triangleq\; \sum_{j=1}^{l} \Theta_{j+1,l}\,, \qquad \Gamma_l \;\triangleq\; \sum_{j=1}^{l} \Theta_{j,l}$$

（关系：$\Gamma_l = \sum_{j=1}^l L_j \Theta_{j+1,l}$；若各 $L_j$ 一致为 $L$，则 $\Gamma_l = L\Lambda_l$。）

对每步 $j$，记 $x'_j \in \mathcal{X}(r_{i_j})$ 为距理想中间态 $h^*_{j-1}$ 最近的采样域点，$\delta_j \triangleq d(h^*_{j-1}, x'_j)$ 为偏离距离。定义第 $j$ 步的**目标域外变分（Target Out-of-Domain Variation）**：

$$\rho_j \;\triangleq\; d\bigl(r_{i_j}(x'_j),\, r_{i_j}(h^*_{j-1})\bigr)$$

$\rho_j$ 度量的是目标规则 $r_{i_j}$ 自身在采样域边界 $x'_j$ 与理想轨道点 $h^*_{j-1}$ 之间的输出差异——这是一个不依赖任何正则性假设（$r$ 无需 Lipschitz）的纯度量空间可观测量。当 $\delta_j = 0$（理想轨道在采样域内）时自动有 $\rho_j = 0$。

由于 $\Phi = (F, \sigma)$ 是由路由引擎 $\sigma$ 拼缀的**分段映射**（§1.2：$\Phi(x) = \sigma(x)(x)$），累积误差 $e_{j-1}$ 可能将实际轨道 $h_{j-1}$ 推过路由决策边界，导致 $\sigma(h_{j-1}) \neq \sigma(h^*_{j-1})$——即实际轨道与理想轨道被分配到**不同的激活链**。同理，理想轨道点 $h^*_{j-1}$ 与最近采样点 $x'_j$ 也可能处于不同路由区域。定义第 $j$ 步的**路由失准惩罚（Routing Misalignment Penalty）**：

$$\Delta_{\sigma,j} \;\triangleq\; \underbrace{d\bigl(\sigma(h_{j-1})(h_{j-1}),\; \sigma(h^*_{j-1})(h_{j-1})\bigr)}_{\Delta^{err}_j\;:\;\text{误差致路由偏转}} \;+\; \underbrace{d\bigl(\sigma(h^*_{j-1})(x'_j),\; \sigma(x'_j)(x'_j)\bigr)}_{\Delta^{sam}_j\;:\;\text{采样域路由失配}}$$

$\Delta^{err}_j$ 度量的是：由于累积误差使实际状态 $h_{j-1}$ 被路由到了"错误的"激活链 $\sigma(h_{j-1})$，该激活链与理想激活链 $\sigma(h^*_{j-1})$ 在 **同一输入** $h_{j-1}$ 处的输出差异。$\Delta^{sam}_j$ 度量的是：理想轨道的激活链 $\sigma(h^*_{j-1})$ 与最近采样点的激活链 $\sigma(x'_j)$ 在 $x'_j$ 处的输出差异。两项均为纯粹属于**系统路由拓扑 $\sigma$** 的物理量——它们与目标 $r$ 无关，与拟合误差 $\varepsilon$ 无关，纯粹反映 $\sigma$ 的离散分段结构对连续逼近链的干扰代价。当 $\sigma(h_{j-1}) = \sigma(h^*_{j-1})$ 时 $\Delta^{err}_j = 0$；当 $\sigma(h^*_{j-1}) = \sigma(x'_j)$ 时 $\Delta^{sam}_j = 0$。在实际系统中 $\Delta^{sam}_j$ 通常极小（$x'_j$ 与 $h^*_{j-1}$ 仅距 $\delta_j$，大概率共路由），主导项为 $\Delta^{err}_j$——即**累积误差跨越路由边界时的拓扑跳变代价**。

> **注（$\Delta_{\sigma}$ 与 $\rho$ 的对偶结构）**：$\rho_j$ 与 $\Delta_{\sigma,j}$ 形成一对精确对偶——$\rho_j$ 刻画的是**目标** $r$ 在域外的行为变化（目标的不连续性代价），$\Delta_{\sigma,j}$ 刻画的是**系统** $\Phi$ 在路由边界处的行为变化（系统的不连续性代价）。两者分别守护误差界中"理想世界"与"实际系统"各自的拓扑完整性。
>
> **注（$\Delta_{\sigma}$ 与 命题 2.7 的关系）**：命题 2.7 证明了路由分辨率极限 $d(a,b) \geq \Delta/L$。$\Delta^{err}_j$ 正是该命题的定量后果：当累积误差 $e_{j-1}$ 超过理想轨道到最近路由边界的距离 $d(h^*_{j-1}, \partial\mathrm{Link})$ 时，$\sigma$ 不可避免地将实际状态分配到**不同激活链**，$\Delta^{err}_j > 0$ 随即被触发。命题 2.7 还揭示了接近边界时 $L_j \to L$ 的极限行为——这是 $\Delta^{err}_j$ 的**连续面预兆**；$\Delta^{err}_j$ 本身是**跨越边界后的离散面后果**。二者合成了路由边界的完整双重危害。

则系统在整个链 $q$ 上的宏观容差界满足：

$$\varepsilon^*_q \;\triangleq\; \sup_{x \in \mathrm{dom}(q)} d\bigl(h_l,\, q(x)\bigr) \;\leq\; \sum_{j=1}^{l} \bigl(\varepsilon_{i_j} + \rho_j + \Delta_{\sigma,j}\bigr) \cdot \Theta_{j+1,l} \;+\; \sum_{j=1}^{l}\delta_j\cdot \Theta_{j,l}$$

第一项中，$\varepsilon_{i_j} + \rho_j + \Delta_{\sigma,j}$ 构成第 $j$ 步的**有效局部失配（Effective Local Mismatch）**——系统在采样点处的逼近误差（$\varepsilon$）、目标自身在域外的变分（$\rho$）、以及路由拓扑跳变的代价（$\Delta_\sigma$）之三重叠加。三项分别刻画三个**独立的物理来源**：$\varepsilon$ 源于系统 $\Phi$ 的拟合不完美，$\rho$ 源于目标 $r$ 的域外行为，$\Delta_\sigma$ 源于路由引擎 $\sigma$ 的离散分段结构。第二项 $\delta_j \cdot \Theta_{j,l}$ 为系统对采样域间隙的拉伸放大代价。

**证明**：第 $j$ 步，取 $x'_j \in \mathcal{X}(r_{i_j})$ 为距 $h^*_{j-1}$ 最近的采样域点（$d(h^*_{j-1}, x'_j) = \delta_j$）。

由 $h_j = \Phi(h_{j-1})$，$h^*_j = r_{i_j}(h^*_{j-1})$，误差为：

$$e_j = d\bigl(\Phi(h_{j-1}),\, r_{i_j}(h^*_{j-1})\bigr)$$

插入中间点 $\Phi(h^*_{j-1})$，由第一次三角不等式得：

$$e_j \;\leq\; \underbrace{d\bigl(\Phi(h_{j-1}),\, \Phi(h^*_{j-1})\bigr)}_{\text{(A) 误差传播 + 路由跳变}} \;+\; d\bigl(\Phi(h^*_{j-1}),\, r_{i_j}(h^*_{j-1})\bigr)$$

**对 (A) 项的路由感知分解**：$\Phi$ 是分段映射 $\Phi(x) = \sigma(x)(x)$（§1.2）。实际轨道与理想轨道可能被路由到不同激活链：$\Phi(h_{j-1}) = \sigma(h_{j-1})(h_{j-1})$，$\Phi(h^*_{j-1}) = \sigma(h^*_{j-1})(h^*_{j-1})$。插入桥接点 $\sigma(h^*_{j-1})(h_{j-1})$——用**理想轨道的激活链**作用于**实际状态**——再次运用三角不等式：

$$d\bigl(\Phi(h_{j-1}),\, \Phi(h^*_{j-1})\bigr) \;\leq\; \underbrace{d\bigl(\sigma(h_{j-1})(h_{j-1}),\; \sigma(h^*_{j-1})(h_{j-1})\bigr)}_{\text{(I') 路由跳变惩罚}\;=\;\Delta^{err}_j} \;+\; \underbrace{d\bigl(\sigma(h^*_{j-1})(h_{j-1}),\; \sigma(h^*_{j-1})(h^*_{j-1})\bigr)}_{\text{(I) 同激活链内误差传播}\;\leq\; L_j \cdot e_{j-1}}$$

第 (I) 项由**单一激活链** $\sigma(h^*_{j-1})$ 的 Lipschitz 性质定界——不涉及任何跨路由区域的拉伸，$L_j$ 的使用是完全合法的。第 (I') 项是纯粹的路由拓扑代价：两条不同激活链在**同一输入** $h_{j-1}$ 处的输出差异。当 $\sigma(h_{j-1}) = \sigma(h^*_{j-1})$ 时（无路由跨越），$\Delta^{err}_j = 0$。

**对 $d(\Phi(h^*_{j-1}), r_{i_j}(h^*_{j-1}))$ 的路由感知拆分**：$h^*_{j-1}$ 可能不在采样域 $\mathcal{X}(r_{i_j})$ 内，$\varepsilon_{i_j}$ 的约束不能直接套用。通过桥接采样域内的最近点 $x'_j$，由第二次三角不等式展开。首先对 $\Phi$-差项做路由感知分解——插入桥接点 $\sigma(h^*_{j-1})(x'_j)$：

$$d\bigl(\Phi(h^*_{j-1}),\, \Phi(x'_j)\bigr) \;\leq\; \underbrace{d\bigl(\sigma(h^*_{j-1})(h^*_{j-1}),\; \sigma(h^*_{j-1})(x'_j)\bigr)}_{\text{(II) 同激活链内系统偏离}\;\leq\; L_j \cdot \delta_j} \;+\; \underbrace{d\bigl(\sigma(h^*_{j-1})(x'_j),\; \sigma(x'_j)(x'_j)\bigr)}_{\text{(II') 采样域路由失配}\;=\;\Delta^{sam}_j}$$

第 (II) 项由**同一激活链** $\sigma(h^*_{j-1})$ 的 Lipschitz 性定界——$L_j$ 同样合法，因为它与 (I) 项中使用的是**完全相同的激活链**。第 (II') 项度量理想激活链与采样点处激活链在 $x'_j$ 处的差异。结合剩余两项不变：

$$\underbrace{d\bigl(\Phi(x'_j),\, r_{i_j}(x'_j)\bigr)}_{\text{(III) 采样域内逼近误差}\;\leq\; \varepsilon_{i_j}} \;+\; \underbrace{d\bigl(r_{i_j}(x'_j),\, r_{i_j}(h^*_{j-1})\bigr)}_{\text{(IV) 目标域外变分}\;=\; \rho_j}$$

> **注（六项拆分的物理解剖）**
>
> - **(I) 同激活链内误差传播**（$\leq L_j e_{j-1}$）：前序累积误差被理想轨道所选定的激活链 $\sigma(h^*_{j-1})$ 以其局部 Lipschitz 常数 $L_j$ 放大。
> - **(I') 误差致路由偏转**（$= \Delta^{err}_j$）：累积误差将实际状态推过路由边界，导致系统调用了"错误的"激活链。这是 命题 2.7（路由分辨率极限）在误差链中的直接后果——当 $e_{j-1} > d(h^*_{j-1}, \partial\mathrm{Link})$ 时，路由跳变不可避免。
> - **(II) 同激活链内系统偏离放大**（$\leq L_j \delta_j$）：理想中间态 $h^*_{j-1}$ 偏离采样域的几何代价被 $\sigma(h^*_{j-1})$ 放大。
> - **(II') 采样域路由失配**（$= \Delta^{sam}_j$）：理想轨道与最近采样点的路由选择差异。通常 $\Delta^{sam}_j \approx 0$。
> - **(III) 采样域内逼近误差**（$\leq \varepsilon_{i_j}$）：$\Phi$ 在采样域内对 $r_{i_j}$ 的局部拟合误差。
> - **(IV) 目标域外变分**（$= \rho_j$）：目标规则 $r_{i_j}$ 自身在采样点 $x'_j$ 与理想中间态 $h^*_{j-1}$ 之间的输出差异。不依赖对 $r$ 的正则性假设。
>
> 六项按**物理归属**分为四族：(I)+(I') 属于**前序误差**（历史积累），(II)+(II') 属于**采样域偏离**（数据覆盖缺口），(III) 属于**系统拟合**（$\Phi$ 的有限容量），(IV) 属于**目标本征**（$r$ 的域外行为）。其中 (I')+(II') 构成的路由失准惩罚 $\Delta_{\sigma,j}$ 纯粹属于**系统拓扑**——它是 $\sigma$ 的离散分段结构对连续逼近链的干扰代价。
>
> **关于桥接方向的选择**：桥接点 $\sigma(h^*_{j-1})(h_{j-1})$ 用**理想轨道的激活链**作用于**实际状态**。这一选择使得 (I) 与 (II) 两项中的 Lipschitz 常数 $L_j$ 均来自**同一条激活链** $\sigma(h^*_{j-1})$——两者**合法共享同一条激活链的 Lipschitz 常数**，不存在跨路由区域复用的问题。路由跳变的全部代价被严格隔离到 $\Delta_{\sigma,j}$ 中，而 $L_j$ 始终保持为**单一激活链内部**的合法 Lipschitz 约束。需要强调的是，$L_j$ 被锚定于理想轨道所选定的激活链 $\sigma(h^*_{j-1})$，而非复合映射 $\Phi$ 在某一对点上的路径局部常数——后者在 $\Phi$ 的分段映射结构下，当两点跨越路由边界时将失去定义的唯一性。激活链锚定使得 $L_j$ 的含义清晰且路由跨越代价显式可观测。

分别定界后合并六项：

$$e_j \;\leq\; \underbrace{L_j \cdot e_{j-1}}_{\text{(I)}} \;+\; \underbrace{\Delta^{err}_j}_{\text{(I')}} \;+\; \underbrace{L_j \cdot \delta_j}_{\text{(II)}} \;+\; \underbrace{\Delta^{sam}_j}_{\text{(II')}} \;+\; \underbrace{\varepsilon_{i_j}}_{\text{(III)}} \;+\; \underbrace{\rho_j}_{\text{(IV)}}$$

合并路由惩罚 $\Delta_{\sigma,j} = \Delta^{err}_j + \Delta^{sam}_j$，递推关系为：$e_j \leq L_j\, e_{j-1} + L_j\,\delta_j + \varepsilon_{i_j} + \rho_j + \Delta_{\sigma,j}$，$e_0 = 0$。逐步展开前两步：

$$e_1 \leq \varepsilon_{i_1} + \rho_1 + \Delta_{\sigma,1} + L_1\delta_1$$
$$e_2 \leq L_2 e_1 + \varepsilon_{i_2} + \rho_2 + \Delta_{\sigma,2} + L_2\delta_2 \leq (\varepsilon_{i_1} + \rho_1 + \Delta_{\sigma,1} + L_1\delta_1)\, L_2 + \varepsilon_{i_2} + \rho_2 + \Delta_{\sigma,2} + L_2\delta_2$$

第 $j$ 步新增项 $(\varepsilon_{i_j} + \rho_j + \Delta_{\sigma,j} + L_j\delta_j)$ 在后续各步中被乘以 $\Theta_{j+1,l}$，归纳得：

$$e_l \;\leq\; \sum_{j=1}^{l}\bigl(\varepsilon_{i_j} + \rho_j + \Delta_{\sigma,j} + L_j\,\delta_j\bigr)\cdot \Theta_{j+1,l}$$

分离四项，利用 $L_j \cdot \Theta_{j+1,l} = \Theta_{j,l}$，并将同系数的 $\varepsilon$、$\rho$、$\Delta_\sigma$ 合并：

$$e_l \;\leq\; \sum_{j=1}^{l}(\varepsilon_{i_j} + \rho_j + \Delta_{\sigma,j})\cdot \Theta_{j+1,l} \;+\; \sum_{j=1}^{l}\delta_j\cdot \Theta_{j,l}$$

第一项中 $\varepsilon_{i_j} + \rho_j + \Delta_{\sigma,j}$ 为有效局部失配，以系数 $\Theta_{j+1,l}$（不含本步 $L_j$）向后累积放大；第二项中系统偏离 $\delta_j$ 以系数 $\Theta_{j,l} = L_j \Theta_{j+1,l}$（含本步 $L_j$）向后累积放大——同一步的系统偏离代价比有效局部失配代价高 $L_j$ 倍。当 $\Delta_{\sigma,j} = 0$（无路由跨越）且 $\rho_j = 0$（域内链或目标局部常值）时，退化为纯 $\varepsilon_{i_j}$。

> **保守简化**：精细界可退化为以下简化形式。令 $\rho_{\max} \triangleq \max_j \rho_j$，$\Delta_{\max} \triangleq \max_j \Delta_{\sigma,j}$。
>
> **形式 A（均匀化各步误差）**：令 $\varepsilon_{\max} \triangleq \max_j \varepsilon_{i_j}$，$\delta_{\max} \triangleq \max_j \delta_j$：
>
> $$e_l \;\leq\; (\varepsilon_{\max} + \rho_{\max} + \Delta_{\max})\cdot\Lambda_l \;+\; \delta_{\max}\cdot\Gamma_l$$
>
> 当 $\Delta_{\max} = 0$（路由稳定、无边界跨越）且 $\rho_{\max} = 0$（域内链）时退化为 $\varepsilon_{\max}\Lambda_l + \delta_{\max}\Gamma_l$。
>
> **形式 B（均匀化路径放大系数）**：以全局 $L$ 替换所有局部 $L_j$（$\Theta_{j+1,l} \leq L^{l-j}$），各步 $\varepsilon_{i_j}$、$\delta_j$、$\rho_j$、$\Delta_{\sigma,j}$ 保持异质：
>
> $$e_l \;\leq\; \sum_{j=1}^{l}\bigl(\varepsilon_{i_j} + \rho_j + \Delta_{\sigma,j} + L\delta_j\bigr)\cdot L^{l-j}$$
>
> 其中 $\varepsilon_{i_j} + \rho_j + \Delta_{\sigma,j} + L\delta_j$ 为第 $j$ 步的**有效单步误差**（逼近误差 + 目标域外变分 + 路由跳变代价 + 放大一次的采样域偏离），被后续 $L^{l-j}$ 放大。
>
> **形式 C（路径均值保守界）**：利用路径几何均值 $\bar{L} = (\Theta_{1,l})^{1/l}$（见 §1.2），有 $\Gamma_l \leq \bar{L}\Lambda_l$ 及 $\Lambda_l \leq \frac{\bar{L}^l-1}{\bar{L}-1}$（当 $\bar{L} \neq 1$）。在形式 A 基础上整体放缩：
>
> $$e_l \;\leq\; \bigl(\varepsilon_{\max} + \rho_{\max} + \Delta_{\max} + \bar{L}\,\delta_{\max}\bigr)\cdot\frac{\bar{L}^l-1}{\bar{L}-1}$$
>
> （$\bar{L}=1$ 时极限为 $(\varepsilon_{\max}+\rho_{\max}+\Delta_{\max}+\delta_{\max})\cdot l$。）形式 C 是最常用的**宏观粗粒度界**，用平均拉伸率 $\bar{L}$ 替代了极端的全局确界 $L$，避免了高度异质路径下（$\kappa_\Phi \gg 1$）界限过松的问题。**降低误差的五条路径**：压低 $\varepsilon_{\max}$（改善拟合），控制 $\delta_{\max}$（增大采样覆盖），控制路径均值 $\bar{L}$（进而控制 $\Lambda_l$），选择目标在域外变分较小的分解路径（控制 $\rho_{\max}$），以及**改善路由稳定性**以降低 $\Delta_{\max}$——使误差不轻易触发路由跳变，可通过扩大区域宽度或增加 $\sigma$ 输出连续性实现。

$\square$


**推论 3.1（计算折叠等效，Computational Folding Equivalence）**：设在 $\mathcal{X}_{sub}$ 上存在第 $l$ 阶路由混叠，即存在 $x_1, x_2 \in \mathcal{X}_{sub}$ 使得 $\sigma(x_2) = \sigma_l(x_1)$。则单步系统 $\mathcal{F}$ 在 $x_2$ 处**执行与 $l$ 步宏观系统相同的计算程序**，而该程序的宏观容差由 CAC 定理的 $\mathcal{E}^*$ 控制。由命题 2.4 推论，组合耗尽保证了路由混叠的必然存在。
> **注（路由混叠与计算时空重叠）**：这是路由混叠的反直觉结构后果。路由映射 $\sigma$ 将空间的不同位置（$x_2$ vs $x_1$）和不同演化深度（单步 vs $l$ 步）映射到**同一条微观计算链**，赋予了 $\Phi$ 一种**计算时空折叠**特征：单步映射在某些输入上的行为，与系统经 $l$ 步迭代后的行为，在计算程序层面完全重合。两者因共享同一条链而共享同一套 CAC 容差界。

**推论 3.2（宏观容差界 $\mathcal{E}^*$ 的两态行为，Two-Regime Behavior of the Macroscopic Tolerance Bound）**：宏观容差界 $\varepsilon^*_q$ 的两项共享 $\Theta_{j,l}$ 结构，但步骤 $j$ 的权重有差异：$\varepsilon$-项权重为 $\Theta_{j+1,l}$（不含本步 $L_j$），$\delta$-项权重为 $\Theta_{j,l} = L_j \cdot \Theta_{j+1,l}$（含本步 $L_j$）。因此**同一步 $j$ 的微观采样域偏离代价比拟合误差代价高 $L_j$ 倍**：$L_j > 1$（扩张步）时 $\delta$ 惩罚尤为严苛，$L_j < 1$（收缩步）时 $\delta$ 惩罚被折减。两项的主导步 $j^*$ 均不是微观误差绝对值最大者——准确的主导步是使放大后贡献（$\varepsilon_{i_j} \cdot \Theta_{j+1,l}$ 或 $\delta_j \cdot \Theta_{j,l}$）最大的步骤，早期步骤往往占优。

由于 IDFS 是有限系统（有限步长 $l$、有限全局常数 $L$、有限单步误差 $\varepsilon_{max}$、有限偏离 $\delta_{max}$），且 $\Phi^l$ 自身仍然是满足 $L^l$ 约束的 IDFS（§1.2 代数自相似性），宏观容差上界 $\varepsilon^*_q$ **恒为有限数**。更重要的是，由于 命题 2.7（路由分辨率极限）的绝对物理约束，当误差积累使轨线间距被压缩到 $\sigma$ 的分辨率死锁以下时，系统必然发生**路径合并**——无论 $\bar{L}$ 多大，持续扩张的链路在物理上无法维持，误差增长被系统的有限容量自动截断。因此，从微观容差 $\mathcal{E}$ 跃迁至宏观容差 $\mathcal{E}^*$ 呈现两种物理情形：

**稳定有界（Stable Bounded，$\varepsilon^*_q < D$）**：当路径中扩张与收缩因子相互交织时，误差沿深度 $l$ 逐步积累但始终有限。记 $D \triangleq \mathrm{diam}(\Phi^l(\mathcal{X}))$ 为系统像空间固有直径。由形式 C 保守界：

$$\varepsilon^*_q \;\leq\; (\varepsilon_{max} + \rho_{max} + \Delta_{max} + \bar{L}\,\delta_{max}) \cdot \frac{\bar{L}^l - 1}{\bar{L} - 1} \;\leq\; D$$

受全局 $L$ 约束和路径合并效应的共同制衡，宏观容差 $\varepsilon^*_q$ 始终被锁定在 $D$ 以内。积累速率取决于路径 Lipschitz 序列 $\{L_j\}$ 的具体结构。该态是 IDFS 在一般混合路径下的**默认运行模式**。

**收敛饱和（Saturated，$\Lambda_\infty < \infty$）**：若路径具备充分强的收缩势能，使得截断尾积级数收敛（见推论 3.6），宏观容差界被一个**与深度 $l$ 完全无关的有限常数**绝对封顶：

$$\varepsilon^*_q \;\leq\; (\varepsilon_{max} + \rho_{max} + \Delta_{max}) \cdot \Lambda_\infty \;+\; \delta_{max} \cdot \Gamma_\infty \;\triangleq\; B_{sat} \;<\; \infty$$

此时系统呈现出"任意深度逻辑链免疫力"，微观组件被安全地镶嵌在大尺度吸引域内。

> **注（上界有限 $\neq$ 拟合质量好）**：$\varepsilon^*_q \leq B_{sat}$ 是关于误差**不发散**的保证，而非关于拟合精度的承诺。$B_{sat}$ 刻画的是系统的**最差情形天花板**——对于任何在此范围内的目标，系统都不会崩溃。但这并不排除误差在 $B_{sat}$ 附近甚至恰好等于 $B_{sat}$ 的情形大面积出现。换言之，饱和是一种**稳定性声明**（系统不爆炸），而非**拟合性声明**（系统拟合得好）。事实上，§4 的 CAB 下界将证明：在收缩主导的饱和体制下，系统对**高变分目标**的拟合误差存在不可消去的正下界，且 §7 将进一步揭示，饱和所必需的收缩步恰恰是拟合代价最高的步骤。饱和态系统的精确图景是**稳定但平庸**——以主动放弃高频变分追踪为代价换取端到端有界性。

> **注（物理直径封顶，Diameter Capping）**：CAC 定理给出的 $\varepsilon^*_q$ 是代数上界，而 $\Phi \in \mathrm{Lip}_L$ 蕴含像集直径有限（$D = \mathrm{diam}(\Phi^l(\mathcal{X})) \leq L^l \cdot \mathrm{diam}(\mathcal{X})$），提供了一个独立于 CAC 的**绝对物理天花板**：端到端误差不可能超越系统像空间的固有直径 $D$。两个独立上界取交，给出系统的**有效误差界**：
> $$e_l \;\leq\; \min\!\bigl(\varepsilon^*_q,\; D\bigr)$$
> 当 CAC 代数上界超过 $D$ 时（扩张路径），物理直径接管约束权；当 CAC 代数上界远低于 $D$ 时（收缩路径），CAC 界提供实质更紧的保证。

> **注（路径跨度 $\kappa_\Phi$ 与 CAC 界松紧度）**：CAC 的保守简化形式（形式 C）以全局 $L$ 替换所有局部 $L_j$，其松弛程度直接受 §1.2 定义的路径 Lipschitz 跨度 $\kappa_\Phi = \sup L_j / \inf L_j$ 调控。当 $\kappa_\Phi \to 1$（均匀路径），形式 C 与精细界几乎吻合——保守简化几乎无损。当 $\kappa_\Phi \gg 1$（高度异质路径，典型的大规模 IDFS 如大语言模型），$L_{max}$ 远超大多数步的实际 $L_j$，保守界严重高估误差。此时系统的**实际泛化能力远优于理论悲观预测**，精细界（形式 A）或几何均值 $\bar{L}$ 估计（见推论 3.5）方能揭示真实表现。

---

CAC 定理给出了链误差的代数上界。一个自然的问题是：这个上界是否可能过于松弛？以下推论以存在性构造证明**上界中的每一项都可以被精确取等**——CAC 界在整个 IDFS 函数类上是不可改善的。

**推论 3.3（宏观容差集的类紧性，Class-Level Tightness of the Macroscopic Tolerance Set）**：对任意给定的微观采样集 $\mathcal{S}$ 及其容差集 $\mathcal{E}$（由任意给定序列 $\varepsilon_{i_j} \geq 0$ 决定），任意给定的偏离序列 $\delta_j \geq 0$、目标域外变分序列 $\rho_j \geq 0$、路由惩罚序列 $\Delta_{\sigma,j} \geq 0$ 和 Lipschitz 序列 $\{L_j\}_{j=1}^l$，**一定存在**某个以 $\mathcal{E}$ 拟合了 $\mathcal{S}$ 的具体 IDFS 构造 $(F, \sigma)$ 及目标分解 $r_{i_l} \circ \cdots \circ r_{i_1}$，使得在生成链 $q$ 上，其端到端逼近误差精确填满了宏观容差上界 $\varepsilon^*_q \in \mathcal{E}^*$：

$$e_l \;=\; \varepsilon^*_q \;=\; \sum_{j=1}^{l} (\varepsilon_{i_j} + \rho_j + \Delta_{\sigma,j}) \cdot \Theta_{j+1,l} \;+\; \sum_{j=1}^{l} \delta_j \cdot \Theta_{j,l}$$

即：由微观容差集 $\mathcal{E}$ 跃迁生成宏观容差集 $\mathcal{E}^*$ 的映射定理边界，在整个 IDFS 函数类意义下是**不可改善的**（不存在更紧的普适代数界）。

**证明（Banach 空间中的主本征子空间几何坍缩构造）**：我们在一般赋范向量空间（Banach 空间）中构造一个特定的非线性算子序列，证明在多维空间中，当且仅当所有物理误差源发生严格的三维/高维共线共振时，泛函三角不等式才会退化为标量界满载。

将系统状态视为高维向量 $\vec{h}_j \in \mathcal{X}$。设第 $j$ 步选定的理想激活链 $f_{\sigma(\vec{h}^*_{j-1})}$ 在 $\vec{h}^*_{j-1}$ 邻域内可微，其 Fréchet 导数（雅可比线性算子）记为 $D\Phi_j$。设其算子谱范数（即最大拉伸因子）刚好达到选定的 Lipschitz 常数限界：$\|D\Phi_j\| = L_j$。

**1. 向量场对齐与主本征坍缩（Dimensional Collapse）**：
根据算子范数定义，必存在一个特定的单位方向向量 $\vec{v}_{dom}$（主特征/奇异向量），使得算子在该方向上的拉伸达到极限：$D\Phi_j(\vec{v}_{dom}) = L_j \vec{v}_{dom}$（为构造简便，我们设其为特征向量且对应正特征值）。
我们强制所有的误差演化与拓扑偏离严格**坍缩坍塌在 $\vec{v}_{dom}$ 所生成的一维子空间内**。

设 $\vec{h}^*_j \equiv \vec{0}$。
- 构造前序误差向量 $\vec{e}_{j-1} = \|\vec{e}_{j-1}\| \cdot \vec{v}_{dom}$；
- 构造采样偏离向量 $\vec{\delta}_j = \|\vec{\delta}_j\| \cdot \vec{v}_{dom}$（即最近采样点 $\vec{x}'_j = \vec{h}^*_{j-1} + \vec{\delta}_j = \|\vec{\delta}_j\|\vec{v}_{dom}$）。

**2. 目标变分与误差输入的同向化构造**：
- 设定目标规则 $r_{i_j}$ 使得除了保留原点不动（$r_{i_j}(\vec{0})=\vec{0}$）外，它在越过采样边界 $\vec{x}'_j$ 时，沿着 $\vec{v}_{dom}$ 发生突跳：$r_{i_j}(\vec{x}'_j) = \|\vec{\rho}_j\| \cdot \vec{v}_{dom}$ 且严格满足设定量级 $\|\vec{\rho}_j\| = \rho_j$。
- 系统在 $\vec{x}'_j$ 处的拟合偏差同样被强制指任为向着同一致命维度的常量偏移：$\vec{\Phi}(\vec{x}'_j) = r_{i_j}(\vec{x}'_j) + \varepsilon_{i_j} \cdot \vec{v}_{dom}$。

**3. 路由断裂平移向量的同向化**：
强制 $\sigma$ 的路由边界在空间中与 $\vec{v}_{dom}$ 正交，使得沿 $\vec{v}_{dom}$ 稍作移动就会跨域并触发不同的激活链。设定跨越边界后的激活链除了继承 $D\Phi_j$ 的线性部分外，在输出空间中相比于理想链恰好产生一个平行于 $\vec{v}_{dom}$ 的绝对平移代价：
- 因实际轨道越界而引入的平移抛离：$\Delta^{err}_j \cdot \vec{v}_{dom}$
- 因采样点越界而引入的平移抛离：$\Delta^{sam}_j \cdot \vec{v}_{dom}$

**4. 多维三角不等式的标量级联退化**：
合并此时系统中发生的真实位移（利用一阶近似，或直接假设映射沿该方向全局保真）：
$$ \vec{h}_j = \vec{\Phi}(\vec{h}_{j-1}) = \underbrace{D\Phi_j(\vec{e}_{j-1})}_{L_j \cdot \|\vec{e}_{j-1}\| \vec{v}_{dom}} + \underbrace{\Delta^{err}_j \vec{v}_{dom}}_{\text{路由偏轨向量}} + \underbrace{D\Phi_j(\vec{\delta}_j)}_{L_j \cdot \delta_j \vec{v}_{dom}} + \underbrace{\Delta^{sam}_j \vec{v}_{dom}}_{\text{采样失配向量}} + \underbrace{\varepsilon_{i_j} \vec{v}_{dom}}_{\text{拟合偏差向量}} + \underbrace{\rho_j \vec{v}_{dom}}_{\text{目标跳变向量}} $$

六个高维物理分量因全部属于同一个一维特征子空间 $\mathrm{span}(\vec{v}_{dom})$，且系数全部为正。当我们对等式两边取空间范数时，多维空间的三角不等式 $\|\vec{A} + \vec{B}\| \le \|\vec{A}\| + \|\vec{B}\|$ 发生了**严格的共线退化（Collinear Equality）**：
$$ e_j = \|\vec{h}_j\| = L_j e_{j-1} + L_j \delta_j + \Delta_j^{err} + \Delta_j^{sam} + \varepsilon_{i_j} + \rho_j $$
（结合 $\Delta_{\sigma,j} = \Delta_j^{err} + \Delta_j^{sam}$）。
在后续的链式迭代中，每一步我们都精心挑选坐标架使其对齐当时的主本征方向。整个多维动力学宏观误差精确等于各步一维标量上限的级联求和：
$$e_l = \|\vec{h}_l\| = \sum_{j=1}^{l} (\varepsilon_{i_j} + \rho_j + \Delta_{\sigma,j}) \cdot \Theta_{j+1,l} \;+\; \sum_{j=1}^{l} \delta_j \cdot \Theta_{j,l}$$
这证明了高维空间抽象下界限亦不可改善。$\square$

**直观示例（$\mathbb{R}^n$ 主雅可比矩阵对齐崩溃）**：
上述泛函抽象在实用的 $\mathbb{R}^n$ 矩阵动力学中极其常见。假设在第 $j$ 步，理想点位于原点，系统在该处的雅可比矩阵 $J$ 是一个对角阵，其主特征值为 $\lambda_1 = L_j \gg 1$ 位于第一个轴 $\vec{e}_1$，而其他维度的收缩率远小于 $1$。

如果系统的微观不确定性（即偏差源）是各向同性（无偏）的，那么大概率只有一小部分投影会落在 $\vec{e}_1$ 轴上被放大。但**在最坏情况下**：
前序传来的误差大头恰好倒向了 $\vec{e}_1$（ $\vec{h}_{j-1} \approx e_{j-1}\vec{e}_1$ ）；数据采样的盲区刚好分布在 $\vec{e}_1$ 方向（ $\vec{\delta}_j = \delta_j\vec{e}_1$ ）；并且在 $\vec{e}_1$ 正向上存在一个决策分类超平面（目标发生跃变的边界），在此处路由网络 $\sigma$ 为了迎合突跃而强行调用了一个包含常数跳变偏置项的专家网络（引发 $\vec{\rho}$ 与 $\vec{\Delta}_\sigma$ 的双重同向爆裂）。
此时，所有矩阵与向量乘法退化为了标量的标位累加。系统高耸的 Lipschitz 上限在这一维上被“吃干抹净”，彻底将五股破坏力量按最大化指数累加上去。这就是**在结构特征明显的复杂非线性动力学系统中，理论上看似极低概率的灾难性上界在物理现实常被触发的拓扑宿命**。

确立了 CAC 界的紧性后，接下来从中提取几个关键的操作性推论——将代数上界转化为对链深、收敛性等工程参数的显式约束。

**推论 3.4（保底可靠链深，Guaranteed Safe Chain Depth）**：若要求系统在生成的宏观链上不发生泛化崩溃，即要求宏观容差集 $\mathcal{E}^*$ 中的元素被严格界定在安全阈值 $\tau > 0$ 内（$\varepsilon^*_q \leq \tau$），则相应的宏观有效链集 $\mathcal{T}_l$ 必须在逻辑深度上实施截断（即限制最大推导步数 $l$）。

记 $L_{max} \triangleq \sup_j L_j$（即 §1.2 路径 Lipschitz 常数的上确界，由系统要求 $L_j \leq L$，恒有 $L_{max} \leq L$）。利用 $\Gamma_l \leq L_{max}\,\Lambda_l$，确保 $\varepsilon^*_q \leq \tau$ 的充分条件合并为：

$$(\varepsilon_{\max} + \rho_{max} + \Delta_{\max} + L_{max}\,\delta_{\max})\cdot\Lambda_l \;\leq\; \tau$$

再利用 $\Lambda_l \leq \dfrac{L_{max}^l - 1}{L_{max} - 1}$，对 $L_{max} > 1$ 显式求解，给出**保底可靠链深**：

$$l^* \;=\; \left\lfloor \frac{\log\!\left(1 + \dfrac{\tau(L_{max}-1)}{\varepsilon_{\max} + \rho_{max} + \Delta_{\max} + L_{max}\,\delta_{\max}}\right)}{\log L_{max}} \right\rfloor$$

即：任意长度 $\leq l^*$ 的链均保证 $e_l \leq \tau$。

$L_{max} = 1$ 时退化为线性：$l^* = \lfloor \tau/(\varepsilon_{\max} + \rho_{\max} + \Delta_{\max} + \delta_{\max}) \rfloor$。

**证明**：

**第一步（合并两项）**：由 $L_{max} = \sup_j L_j$，对每项有 $L_j \Theta_{j+1,l} \leq L_{max}\,\Theta_{j+1,l}$，故：

$$\Gamma_l = \sum_{j=1}^l L_j \Theta_{j+1,l} \;\leq\; L_{max} \sum_{j=1}^l \Theta_{j+1,l} = L_{max}\,\Lambda_l$$

代入充分条件：

$$\varepsilon_{\max}\,\Lambda_l + \delta_{\max}\,\Gamma_l \;\leq\; \varepsilon_{\max}\,\Lambda_l + \delta_{\max}\cdot L_{max}\,\Lambda_l = (\varepsilon_{\max} + L_{max}\,\delta_{\max})\,\Lambda_l \;\leq\; \tau$$

**第二步（约束 $\Lambda_l$）**：上式等价于：

$$\Lambda_l \;\leq\; \frac{\tau}{\varepsilon_{\max} + \rho_{\max} + \Delta_{\max} + L_{max}\,\delta_{\max}}$$

**第三步（对 $l$ 求解显式下界）**：由 $\Theta_{j+1,l} \leq L_{max}^{l-j}$，故：

$$\Lambda_l = \sum_{j=1}^l \Theta_{j+1,l} \;\leq\; \sum_{j=1}^l L_{max}^{l-j} = \frac{L_{max}^l - 1}{L_{max} - 1} \qquad (L_{max} > 1)$$

要使 $(L_{max}^l-1)/(L_{max}-1) \leq \tau/(\varepsilon_{\max}+\rho_{\max}+\Delta_{\max}+L_{max}\delta_{\max})$，取对数解 $l$ 的最大整数：

$$l^* = \left\lfloor \frac{\log\!\left(1 + \dfrac{\tau(L_{max}-1)}{\varepsilon_{\max} + \rho_{\max} + \Delta_{\max} + L_{max}\,\delta_{\max}}\right)}{\log L_{max}} \right\rfloor$$

由构造，任意长度 $\leq l^*$ 的链均满足 $(\varepsilon_{\max}+\rho_{\max}+\Delta_{\max}+L_{max}\delta_{\max})\Lambda_l \leq \tau$，进而由 CAC 定理保证 $e_l \leq \tau$。$\square$

> **注**：$l^*$ 仅依赖单步边界值，先验可计算。分母 $\varepsilon_{\max} + \rho_{\max} + \Delta_{\max} + L_{max}\,\delta_{\max}$ 即**有效单步误差**（近似误差、目标变分、路由跳变代价与放大一次的采样域偏离代价之和，呼应 CAC 主定理形式 B）。$L_{max}$ 取路径局部最大而非全局 $L$，结合保守的 $\Lambda_l$ 上界，$l^*$ 通常是悲观估计。

**推论 3.5（路径感知安全深度，Path-Aware Safe Depth）**：若已知具体路径的几何均值 $\bar{L}$（§1.2），则对 $\bar{L} > 1$，安全深度可收紧为：

$$l^*_{\bar{L}} \;=\; \left\lfloor \frac{\log\!\left(1 + \dfrac{\tau(\bar{L}-1)}{\varepsilon_{\max} + \rho_{\max} + \Delta_{\max} + \bar{L}\,\delta_{\max}}\right)}{\log \bar{L}} \right\rfloor$$

由 $\bar{L} \leq L_{max}$（均值 $\leq$ 极值），恒有 $l^*_{\bar{L}} \geq l^*$。当路径中大量收缩步将几何均值拉低到远小于 $L_{max}$ 时（即 $\kappa_\Phi \gg 1$ 的高异质路径），$l^*_{\bar{L}} \gg l^*$——系统实际可安全走的深度远超保守估计。$\bar{L} < 1$ 时安全深度不受限（对应推论 3.6 的饱和态）。


**推论 3.6（宏观容差集的收缩有界性，Boundedness of $\mathcal{E}^*$ under Contraction）**：记 $\Theta_{j,\infty} \triangleq \lim_{l\to\infty} \Theta_{j,l} = \prod_{k=j}^{\infty} L_k$（当极限存在时）。若局部收缩足够强导致累积系数收敛：

$$\Lambda_\infty \;\triangleq\; \sum_{j=1}^{\infty} \Theta_{j+1,\infty} \;<\; \infty \qquad \text{且} \qquad \Gamma_\infty \;\triangleq\; \sum_{j=1}^{\infty} \Theta_{j,\infty} \;<\; \infty$$

则不论微观集 $\mathcal{S}$ 生成的有效链集 $\mathcal{T}_\infty$ 有多庞大（甚至包含无限长链极限），其诱导的整个**宏观容差集 $\mathcal{E}^*$ 必然是一致有界的**（Uniformly Bounded）：对任意长链 $q \in \mathcal{T}_\infty$，

$$\varepsilon^*_q \;\leq\; (\varepsilon_{\max} + \rho_{\max} + \Delta_{\max}) \cdot \Lambda_\infty \;+\; \delta_{\max} \cdot \Gamma_\infty \;<\; \infty$$

即：在强收缩下，由有限微观容差（$\mathcal{E}$）爆发出的无限组合宏观误差（$\mathcal{E}^*$）被强制封顶。系统展现出对任意长逻辑组合的"无限泛化免疫力"。

> **注（$l \to \infty$ 极限的合法性）**：虽然 IDFS 是有限系统，但此处取 $l \to \infty$ 在物理上是合法的。推论 3.6 的前提条件要求收缩步主导（$\Theta_{j,l} \to 0$），而收缩路径不触发任何物理截断机制——系统只是将轨线越拉越近，不涉及 命题 2.7 的分辨率死锁或路径合并（后者仅约束扩张行为）。因此，无限长收缩链的极限分析在 IDFS 框架内是完全自洽的。

**证明**：由 CAC 定理精细界（形式 A）：

$$e_l \;\leq\; (\varepsilon_{\max} + \rho_{\max} + \Delta_{\max})\cdot\Lambda_l \;+\; \delta_{\max}\cdot\Gamma_l$$

由 $\Lambda_l \nearrow \Lambda_\infty$ 和 $\Gamma_l \nearrow \Gamma_\infty$（两个级数均单调递增趋向各自极限），故 $e_l \leq (\varepsilon_{\max} + \rho_{\max} + \Delta_{\max})\cdot\Lambda_\infty + \delta_{\max}\cdot\Gamma_\infty$。$\square$

> **注（允许局部扩张；$\Gamma_\infty$ 与 $\Lambda_\infty$ 同阶）**：推论 3.6 不要求 $L_j < 1$ 逐步成立——即使某些步存在 $L_j > 1$（局部扩张），只要后续有足够强的收缩步将尾部乘积压平，$\Lambda_\infty$ 仍然有限。此外，由 $\Gamma_\infty = \sum_j L_j \Theta_{j+1,\infty} \leq L_{max} \cdot \Lambda_\infty$，而 §1.2 系统要求保证 $L_j \leq L < \infty$ 恒成立（即 $L_{max} \leq L$ 自动有界），故 $\Lambda_\infty < \infty$ 自动蕴含 $\Gamma_\infty < \infty$，条件可合并为单一的 $\Lambda_\infty < \infty$。

**路径均值特例（$\bar{L} < 1$）**：收缩饱和**不要求**全局 $L < 1$——即使系统在某些步具有 $L_j > 1$（局部扩张），只要路径的几何均值 $\bar{L} < 1$（§1.2），尾积便以指数速率衰减，保证 $\Lambda_\infty < \infty$。此时饱和界为：

$$e_l \;\leq\; \frac{\varepsilon_{\max} + \rho_{\max} + \Delta_{\max} + \bar{L}\,\delta_{\max}}{1 - \bar{L}}$$

这比全局 $L < 1$ 的要求宽松得多——系统允许存在局部的剧烈拉伸，只要在整条路径的统计平均意义上呈现净收缩即可。

**保守特例（全局 $L < 1$）**：若 $\Phi \in \mathrm{Lip}_L$ 且 $L < 1$，则 $L_j \leq L$，$\bar{L} \leq L$，故：

$$\Lambda_\infty \leq \frac{1}{1-L}, \qquad \Gamma_\infty \leq \frac{L}{1-L}$$

退化为保守界：

$$e_l \;\leq\; \frac{\varepsilon_{\max} + \rho_{\max} + \Delta_{\max} + L\,\delta_{\max}}{1-L}$$

分子即**有效单步误差**（呼应形式 B），分母为收缩余量 $(1-L)$。注意路径均值特例严格弱于此条件：$\bar{L} < 1$ 允许存在 $L > 1$ 的系统，只要路径平均收缩即可饱和。

---

**推论 3.7（生成基约简与零样本泛化，Generative Basis Reduction and Zero-Shot Generalization）**：取原目标真实法则全集 $R$ 的一个**生成基** $R_0 \subseteq R$，及其对应的微观采样集 $\mathcal{S}_0 \subset \mathcal{S}$。若系统 $\Phi$ 以均匀微观容差集 $\mathcal{E}_0 = \{\varepsilon_0\}$ 局部拟合了该生成基 $\mathcal{S}_0$。

对于任意我们没有显式训练并测试的“未见规则” $r_i \in R \setminus R_0$，只要它能够沿 $R_0$ 逻辑展开为一条分解路径 $r_i = r_{i_{d_i}} \circ \cdots \circ r_{i_1}$，那么由同构物理意义可知：未见规则 $r_i$ 在数学上彻底等价于由微观基集 $\mathcal{S}_0$ 诱导生成的宏观链集 $\mathcal{T}_{d_i}$ 中的某个**宏观链元素** $q_i$。

因此，根据 CAC 定理，系统必定能以由 $\mathcal{E}_0$ 跃迁出的**宏观容差** $\varepsilon^*_{q_i} \in \mathcal{E}^*_0$ 覆盖拟合这个未曾见过的复杂规则 $r_i$。即 $r_i$ 的泛化误差边界被严格锚定为：

$$\sup_{x \in \mathcal{X}(r_{i_1})} d\bigl(\Phi^{d_i}(x),\, r_i(x)\bigr) \;\leq\; \varepsilon^*_{q_i} \;=\; \bigl(\varepsilon_0 + \rho_{\max,i}^{\mathrm{path}} + \Delta_{\max,i}^{\mathrm{path}}\bigr) \cdot \Lambda_{d_i}^{\mathrm{path}} \;+\; \delta_{\max,i}^{\mathrm{path}} \cdot \Gamma_{d_i}^{\mathrm{path}}$$

取所有 $r_i \in R \setminus R_0$ 的上确界：

$$\varepsilon_{\max}^R \;\leq\; \max_{r_i \in R \setminus R_0} \Bigl(\bigl(\varepsilon_0 + \rho_{\max,i}^{\mathrm{path}} + \Delta_{\max,i}^{\mathrm{path}}\bigr) \cdot \Lambda_{d_i}^{\mathrm{path}} + \delta_{\max,i}^{\mathrm{path}} \cdot \Gamma_{d_i}^{\mathrm{path}}\Bigr)$$

**证明**：情形 1（$r \in R_0$）直接由假设满足。情形 2（$r_i \in R \setminus R_0$）见下方证明详展。$\square$

**证明详展（情形 2）**：设分解路径 $r_i = r_{i_{d_i}} \circ \cdots \circ r_{i_1}$，对任意 $x \in \mathcal{X}(r_{i_1})$：

- **$r$-链轨道**：$h_0^* = x$，$h_j^* = r_{i_j}(h_{j-1}^*)$，$h_{d_i}^* = r_i(x)$
- **$\Phi$-轨道**：$\hat{h}_0 = x$，$\hat{h}_j = \Phi(\hat{h}_{j-1})$

$e_j = d(\hat{h}_j,\, h_j^*)$，$e_0 = 0$。对第 $j$ 步，取 $x'_j \in \mathcal{X}(r_{i_j})$ 为距 $h^*_{j-1}$ 最近的采样域点（$d(h^*_{j-1}, x'_j) = \delta_j^{\mathrm{path}}$），套用 CAC 主定理的五项拆分级联即可：

$$e_j \;\leq\; L_j e_{j-1} \;+\; L_j \delta^{\mathrm{path}}_j \;+\; \Delta_{\sigma,j}^{\mathrm{path}} \;+\; \varepsilon_0 \;+\; \rho_j^{\mathrm{path}}$$

递推展开得 $e_{d_i} \leq \bigl(\varepsilon_0 + \rho_{\max,i}^{\mathrm{path}} + \Delta_{\max,i}^{\mathrm{path}}\bigr) \cdot \Lambda_{d_i}^{\mathrm{path}} + \delta_{\max,i}^{\mathrm{path}} \cdot \Gamma_{d_i}^{\mathrm{path}}$。对 $x$ 取上确界即得。$\square$

**含义（剖面策略）**：分解路径同时受到两套正交因子的约束：$\Lambda_{d_i}^{\mathrm{path}}$ 由路径 Lipschitz 结构决定（有效单步误差的级联放大）；$\delta_{\max,i}^{\mathrm{path}} \cdot \Gamma_{d_i}^{\mathrm{path}}$ 由路径的域覆盖质量决定（采样域偏离代价的独立放大）；同时，选择的路径还会切分目标自身的难度（决定 $\rho$）和系统经过该路径时的拓扑稳定性（决定 $\Delta_\sigma$）。
这里存在极其深刻的取舍：路径切得越碎（$d_i$ 很大），单步的目标可能越平缓导致 $\rho$ 和 $\varepsilon_0$ 减小，但 $\Lambda$ 往往随深度指数爆炸，且经过碎片的路由时大 $\Delta_\sigma$ 爆发的概率剧增。选择分解时须在这多维张力下联合优化。

**定义（组合覆盖代价，Compositional Coverage Cost）**：给定生成基 $R_0$，定义 $R$ 在 $R_0$ 下的 **（一般）组合覆盖代价**为：

$$\mathcal{C}^{\mathrm{gen}}(R, R_0) \;\triangleq\; |R_0| \;\times\; \max_{r_i \in R \setminus R_0} \Bigl(\bigl(\varepsilon_0 + \rho_{\max,i}^{\mathrm{path}} + \Delta_{\max,i}^{\mathrm{path}}\bigr) \cdot \Lambda_{d_i}^{\mathrm{path}} \;+\; \delta_{\max,i}^{\mathrm{path}} \cdot \Gamma_{d_i}^{\mathrm{path}}\Bigr)$$

其中两个因子各有明确含义：

- $|R_0|$：**直接拟合宽度**，即 $\Phi$ 须直接近似的基规则数量，决定采样对构造的规模代价；
- $\max_{r_i}(\cdots)$：**最坏派生误差**，即在所有非基规则中，通过分解路径传播后误差最大的那条——同时含有效局部失配的放大项（$(\varepsilon_0+\rho+\Delta_\sigma) \cdot \Lambda$）和采样域偏离代价项（$\delta \cdot \Gamma$）。

两者的乘积刻画了一种**覆盖效率的权衡**：$|R_0|$ 越大，直接近似的规则越多，采样对构造代价越高，但每条分解路径可以更短（$d_i$ 更小），从而 $\Lambda$ 更小、$\Delta_\sigma$ 触发几率更低；$|R_0|$ 越小则反之，派生路径更长，拓扑断裂代价与偏离代价均趋于爆炸。$\mathcal{C}^{\mathrm{gen}}$ 的最小化即在这两者间寻找最优的生成基大小与路径质量的平衡点。

> **理论基准（全纯相容，Holomorphic Compatibility）**：若所有分解路径不仅满足**域链相容**（$\delta_{\max,i}^{\mathrm{path}} = 0$），还满足**拓扑相容**（$\Delta_{\max,i}^{\mathrm{path}} = 0$）与**目标正则**（$\rho_{\max,i}^{\mathrm{path}} = 0$），则代价退化为最纯粹的代数形式：
>
> $$\mathcal{C}(R, R_0) \;\triangleq\; |R_0| \;\times\; \max_{r_i \in R \setminus R_0} \varepsilon_0 \cdot \Lambda_{d_i}^{\mathrm{path}}$$
>
> 此时代价仅由系统拟合底线 $\varepsilon_0$ 和拉伸系数 $\Lambda$ 决定。全纯相容在现实中极难精确满足（零偏离、零跳跃、零断裂），但作为**理论极值下界**，提供一个可量化的乐观基准。在全纯相容下进一步取 $\Phi \in \mathrm{Lip}_L$，记 $d_{\max} = \max_i d_i$，保守界退化为：
>
> $$\varepsilon_{\max}^R \;\leq\; \varepsilon_0 \cdot \frac{L^{d_{\max}} - 1}{L - 1}$$

**推论 3.8（精度理论下界，Theoretical Precision Floor）**：设 $\Phi$ 对所有 $r_0 \in R_0$ 实现局部精度 $\varepsilon_0$，且分解路径满足上述全纯相容（即理论基准条件）。则任意生成基 $R_0$ 对应的覆盖精度不优于：

$$\varepsilon^* \;=\; \varepsilon_0 \cdot \min_{R_0 \;\text{生成}\; R}\; \max_{r_i \in R \setminus R_0} \Lambda_{d_i}^{\mathrm{path}}(R_0)$$

即 $\varepsilon^*$ 是在全纯相容理想化条件下，遍历所有生成基选择后的**最优精度下界**。在现实场景（含有 $\delta, \rho, \Delta_\sigma$）中，实际覆盖精度总满足 $\varepsilon_{\mathrm{actual}} \geq \varepsilon^*$，$\varepsilon^*$ 一般不可达，仅作为理论参照。

**证明**：直接由推论 3.7 的域链相容特例，对所有可行的 $R_0$ 取最优（最小化误差放大因子）即得。$\square$


**推论 3.9（轨道暴露精化界，Trajectory Exposure Refinement）**：CAC 精细界中，第 $j$ 步的微观容差 $\varepsilon_{i_j} = \sup_{x' \in \mathcal{X}(r_{i_j})} d(\Phi(x'), r_{i_j}(x'))$ 取的是 $r_{i_j}$ 整个采样域上的最坏误差。利用 §1.4 的 $\tau$-不可完美拟合集，可对轨道避开高误差区域的初始点逐步收紧。

设宏观链 $q = r_{i_l} \circ \cdots \circ r_{i_1} \in \mathcal{T}_l$，理想轨道 $h^*_0 = x$，$h^*_j = r_{i_j}(h^*_{j-1})$。定义 $q$ 的**全链 $\tau$-暴露集**为理想轨道在某步命中 $U_\tau(r_{i_j})$ 的全体初始点：

$$B^{\tau}(q) \;\triangleq\; \bigcup_{j=1}^{l} \bigl\{\, x \in \mathrm{dom}(q) \;\big|\; h^*_{j-1}(x) \in U_\tau(r_{i_j}) \,\bigr\}$$

则对任意 $x \notin B^{\tau}(q)$，宏观误差满足：

$$e_l(x) \;\leq\; \sum_{j=1}^{l} \bigl(\tau + \rho_j + \Delta_{\sigma,j}\bigr) \cdot \Theta_{j+1,l} \;+\; \sum_{j=1}^{l} \delta_j \cdot \Theta_{j,l}$$

**证明**：$x \notin B^{\tau}(q)$ 意味着每步 $h^*_{j-1}(x) \notin U_\tau(r_{i_j})$，即该点处的实际微观误差 $d(\Phi(h^*_{j-1}), r_{i_j}(h^*_{j-1})) < \tau$。CAC 递推中第 (III) 项从 $\varepsilon_{i_j}$ 收紧为 $\tau$，其余各项不变。$\square$

> **注**：此推论解释了为什么系统的实际表现往往优于 CAC 的预测——$\varepsilon_{i_j}$ 是 $r_{i_j}$ 采样域上的**最坏**误差，但具体 $x$ 的理想轨道在第 $j$ 步命中的点 $h^*_{j-1}(x)$ 未必处于最坏区域。对 $x \in B^{\tau}(q)$，仍须回退到 $\varepsilon_{i_j}$ 界。

---

### 3.2 条件统计精化界

在 §3.1 的 CAC 定理中，我们得出了宏观误差的纯确定性逐点上界。本节引入**空间几何**与**时间相关性**两个维度的假设，将 CAC 界的最坏情形阶 $\mathcal{O}(l)$ 收紧至统计意义下的更优阶。

> **注（$\mathcal{O}$ 记号）**：本文中 $\mathcal{O}$ 采用分析学标准定义：$f = \mathcal{O}(g)$ 表示存在常数 $C > 0$ 使得 $|f| \leq C|g|$，用以描述函数的渐近增长阶或衰减阶。
CAC 界是纯确定性的——它对 $\mathcal{X}$ 的几何结构和误差序列的统计性质不做任何假设，因此代价是最保守的。本节将逐步引入空间几何与时间相关性两个维度的假设，**层层收紧** CAC 界，最终抵达理论极限。

#### 前提：空间几何参数与时间相关性参数

**定义（type-$p$ 空间参数）**：设 $\mathcal{X}$ 的局部切空间具有 Banach 空间结构，其 **type 指数** $p \in [1, 2]$ 刻画了空间对独立随机向量叠加的对消能力。type-$p$ 不等式保证：对零均值独立随机向量 $\{v_j\}$，

$$\mathbb{E}\!\left[\left\|\sum_j v_j\right\|^p\right] \;\leq\; T_p^p \cdot \sum_j \mathbb{E}\!\left[\|v_j\|^p\right]$$

其中 $T_p$ 为空间的 type 常数。$p = 1$ 对应一般度量空间（无对消），$p = 2$ 对应希尔伯特空间（完全正交对消）。

**定义（有效相关长度 $\tau_c$）**：设系统在第 $j$ 步的综合局部误差（含微观逼近、采样偏离、目标变分与路由跳变，在切空间局部展开）为随机向量 $\epsilon_j$，$\mathbb{F}_{j-1}$ 为系统前 $j-1$ 步演化生成的历史完备信息（$\sigma$-代数）。定义**有效相关长度** $\tau_c \geq 1$ 为使得 $|i - j| > \tau$ 时 $\epsilon_i$ 与 $\epsilon_j$ 近似独立的最小间隔。$\tau_c = 1$ 对应完全独立（鞅差序列），$\tau_c = l$ 对应完全相关。

> **注**：$\tau_c = 1$ 且 $\mathbb{E}[\epsilon_j \mid \mathbb{F}_{j-1}] = 0$ 即满足鞅差序列假设（Martingale Difference Sequence，MDS）。在一般工程现实中，有限容量的拟合系统通常无法严格满足 MDS；但在纯粹的理论极限下，满足 MDS 的系统等价于在**无偏先验（Unbiased Prior）**下的**最优贝叶斯估计器（Optimal Bayesian Estimator）**，其每次外推仅受内禀信息熵的不确定性限制。

#### 定理 3.10（统计精化界，The Statistical Refinement Bound，SRB）

**定理 3.10**：设 IDFS $\mathcal{F} = (F, \sigma)$ 的度量空间 $\mathcal{X}$ 的局部切空间为 type-$p$ Banach 空间（$1 \leq p \leq 2$），系统演化误差序列 $\{\epsilon_j\}$ 的有效相关长度为 $\tau_c$，局部线性化算子 $T_{j,l} = \prod_{k=j+1}^l D\Phi(h_{k-1})$ 的算子范数受限于 $\Theta_{j,l}$。则宏观演化 $l$ 步后的总误差满足：

$$\|E_l\| \;\sim\; \mathcal{O}\!\left(\tau_c^{1-1/p} \cdot l^{1/p}\right)$$

**证明精要**：将 $l$ 步误差序列分为 $\lfloor l/\tau_c \rfloor$ 个长度为 $\tau_c$ 的块。块内误差可相干叠加（最坏情况），每块误差 $\sim \mathcal{O}(\tau_c)$。块间近似独立，在 type-$p$ 空间中对 $\lfloor l/\tau_c \rfloor$ 个独立块应用 type-$p$ 不等式，得块间叠加 $\sim \mathcal{O}((l/\tau_c)^{1/p})$。两者合成：$\mathcal{O}(\tau_c \cdot (l/\tau_c)^{1/p}) = \mathcal{O}(\tau_c^{1-1/p} \cdot l^{1/p})$。$\square$

> **注（退化验证）**：
> - $(p = 2,\, \tau_c = 1)$：$\mathcal{O}(1^{1/2} \cdot l^{1/2}) = \mathcal{O}(\sqrt{l})$，退化为理想统计界（下方推论）。
> - $(p = 1,\, \tau_c = l)$：$\mathcal{O}(l^{0} \cdot l) = \mathcal{O}(l)$，退化为 CAC 界。
> - $(p = 1,\, \tau_c = 1)$：$\mathcal{O}(1^{0} \cdot l) = \mathcal{O}(l)$，一般空间即使独立也无正交对消。
> - $(p = 2,\, \tau_c = l)$：$\mathcal{O}(l^{1/2} \cdot l^{1/2}) = \mathcal{O}(l)$，希尔伯特空间但完全相关也无对消。

#### 定理 3.11（理想统计界，The Statistical Ideal Bound，SIB）

**定理 3.11**：若 $\mathcal{X}$ 局部同胚于希尔伯特空间（$p = 2$）且误差满足鞅差序列假设（$\tau_c = 1$），则统计精化界退化为：

$$\sqrt{\mathbb{E}[\|E_l\|^2]} \;\leq\; \sqrt{ \sum_{j=1}^l \left( \Theta_{j,l} \cdot \sqrt{\mathbb{E}[\|\epsilon_j\|^2]} \right)^2 }$$

**证明**：在 $p = 2$（希尔伯特空间）下，$\epsilon_j$ 零均值且 $\tau_c = 1$（逐步独立），经确定性线性算子映射后的误差序列 $\{T_{j,l}(\epsilon_j)\}$ 在切空间中保持正交，即 $\mathbb{E}[\langle T_{i,l}(\epsilon_i), T_{j,l}(\epsilon_j) \rangle] = 0 \quad (\forall i \neq j)$。根据 Bienaymé 等式，总误差的平方期望等于各部分误差平方期望之和。取算子范数放缩 $\|T_{j,l}\| \leq \Theta_{j,l}$，两边开均方根，得证。$\square$

> **注**：SIB 是统计精化界在 $(p, \tau_c)$ 参数空间中的**极端理想点**——它同时要求空间具备最强的正交对消能力（Hilbert）和误差具备最弱的时间相关性（完全独立），因此给出了最紧的渐近阶 $\mathcal{O}(\sqrt{l})$。这是动力学系统在多步迭代下泛化误差的**绝对涨落底线**。

**推论 3.12（漂移-扩散定律，Drift-Diffusion Law）**：在一般系统中，受限于微观基函数集 $F$ 的局部结构偏置以及有效采样覆盖的有限性，系统的单步误差演化通常无法自发满足严格的 MDS 假设。单步误差向量必定包含一个系统性的方向偏置（Drift）。将真实误差 $\epsilon_j$ 进行正交分解：

$$\epsilon_j \;=\; \mu_j \;+\; \eta_j$$

其中：
- $\mu_j \triangleq \mathbb{E}[\epsilon_j \mid \mathbb{F}_{j-1}]$ 为系统性偏置向量（Drift）；
- $\eta_j$ 为零均值的纯随机噪声向量（Diffusion）。

代入线性化演化积分，宏观总误差被分解为两项：

$$\mathbb{E}[\|E_l\|^2] \;=\; \underbrace{ \left\| \sum_{j=1}^l T_{j,l}(\mu_j) \right\|^2 }_{\text{系统漂移项：} \mathcal{O}(l^2)} \;+\; \underbrace{ \sum_{j=1}^l \mathbb{E}\left[ \|T_{j,l}(\eta_j)\|^2 \right] }_{\text{随机扩散项：} \mathcal{O}(\tau_c^{2-2/p} \cdot l^{2/p})}$$

开方后，系统的泛化总误差呈现为漂移-扩散动力学形式：

$$Error_{total} \;\sim\; \underbrace{\mathcal{O}(l) \cdot \|\mu_{bias}\|}_{\text{漂移（不可压缩）}} \;+\; \underbrace{\mathcal{O}\!\left(\tau_c^{1-1/p} \cdot l^{1/p}\right) \cdot \|\eta_{noise}\|}_{\text{扩散（空间几何 × 时间相关性）}}$$

> **注（漂移-扩散的不对称性）**：漂移项始终以 $\mathcal{O}(l)$ 线性增长——这是确定性相干叠加的必然结果，与空间几何和时间相关性均无关。因此，包含强系统性漂移（$\mu_{bias} \neq 0$）的系统必然坠入 CAC 灾难界。空间几何参数 $p$ 和时间相关长度 $\tau_c$ **仅能改善噪声项的涨落底线**，而无法触及漂移项——后者的消除必须依赖外部的对抗或校验机制。

**推论 3.13（CAC 坍缩的几何-统计等价性，Geometric-Statistical Equivalence of CAC Collapse）**：推论 3.3 证明 CAC 上界绝对紧致时所依托的**同向共线拉伸（Collinear Stretching）**构造，在物理法则上完全等价于漂移-扩散定律中**系统漂移项取得统治地位的非各向同性极值形态**。

**证明**：在同向共面拉伸构造中，泛化路线被剥夺了独立自由度并强行压缩于单一主特征射线上。在此极端几何拓扑下，第 $j$ 步的一切微观偏差均沿着特征方向发生严格的平移叠加，即微观误差向量呈现确定性的完全同向偏置：$\epsilon_j = \mu_j$，而代表周围维度统计对消自由度的随机涨落彻底消失，即方差 $\eta_j \equiv 0$。

代入漂移-扩散方程验证：右侧第二项（随机扩散项）因 $\|\eta\| = 0$ 被绝对归零。系统的整体误差演化百分之百由左侧第一项接管：
$$Error_{total} \;\approx\; \left\| \sum_{j=1}^l T_{j,l}(\mu_j) \right\| \;\sim\; \mathcal{O}(l) \cdot \|\mu_{bias}\|$$

当误差仅由第一项构成时，所有的相干矢量投影都在同一个一维法向量标架上，使得空间累加由原本可能具备高维折叠缓冲性质的积分运算，直接退化为一维数量序列的最坏情况线性累加（代数上界）。此时，系统不留任何统计学后路地精准撞击 CAC 灾难天花板。$\square$

> **注（上界的双面同构）**：这个等价性深刻揭示了：代数的 CAC 不等式与统计的 Drift-Diffusion 并非两套平行的度量，而是对同一个系统性崩溃现象的两面描述。当系统发生局部崩溃时，在代数上叫"满足了所有三角放缩的同向性"，在统计上则叫做"系统随机扩散自由度丧失导致的纯漂移积累"。
