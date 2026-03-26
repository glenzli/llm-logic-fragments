## 计算纤维

### 3.1 算子的计算纤维

设 $\phi \in \Omega$。算子 $\phi$ 将输入空间中的若干不同点映射为在伪度量下不可区分的输出——这种多对一坍缩诱导出一组等价类，即**计算纤维**。纤维是算子固有的离散拓扑结构，与 §1.5 定义的 Lip 矩阵所刻画的连续放缩行为形成对偶：Lip 矩阵约束算子定性复合下的**极差传播上界**，而纤维结构刻画算子将输入差异**精确缩减为零**的截断面聚类及其后果。

在多分量规范体系中，既然系统必然会沿不同信息管线呈现出非对称的局域坍缩与贯通相态演化，算符纤维拓扑测度的本源等价类核算，天然就应当直接构建、且必然统摄衍生于全系统任意维度的提取特征指标集子族之上。

#### 定义（子族复合伪度量，Sub-family Pseudometric）

对任意非空指标集子族 $J \subseteq I$（$J \neq \emptyset$），定义定义域上的复合伪度量：

$$d_J(x, y) \;\triangleq\; \max_{j \in J} d_j(x, y)$$

由于有限项 $\max$ 算则的封闭性可知，$d_J$ 严格保持扩展伪度量的对称性与三角不等式（即特征测度上的 $L_\infty$ 范数式收敛）。距离核定 $d_J(x, y) = 0$ 意味着输入状态 $x$ 与 $y$ 在所限定子族 $J$ 的**每一个分量伪度量下皆完全不可区分**。

#### 定义（计算纤维，Computational Fiber）

设 $\phi \in \Omega$，$y \in \mathrm{Im}(\phi)$。指定非空指标集子族 $J \subseteq I$。定义 $y$ 在 $\phi$ 下关于规范子族 $\mathcal{G}_J$ 的**计算纤维**：

$$\mathfrak{F}_{\phi, J}(y) \;\triangleq\; \bigcap_{j \in J} \mathfrak{F}_{\phi, d_j}(y) \;=\; \bigl\{x \in \mathrm{dom}(\phi) \;\big|\; d_J(\phi(x), y) = 0\bigr\}$$

即所有在 $J$ 分量族的复合确界测度 $d_J$ 下，与映射目标 $y$ 发生完全等价坍缩的源生输入点几何集合。$\{\mathfrak{F}_{\phi, J}(y)\}_{y \in \mathrm{Im}(\phi)}$ 构成包含测度的 $\mathrm{dom}(\phi)$ 超覆盖。

> **注（计算纤维演化的极值形态）**：
> 作为同源子族嵌套在度量维数势集上限与下确界域处的自然极值端点，计算纤维天然展现出两种纯粹的测度孤立形态：
> 1. **单分量纤维（Single-Component Fiber）**：当评估特征子族势被向极小化剥除至不可约下限 $|J| = 1$（受限于单一特征通道族 $J = \{i\}$）时，计算纤维展现出最底层的信道孤立单维坍缩退化态，此时直接记为 $\mathfrak{F}_{\phi, d_i}(y)$。
> 2. **全纤维（Full Fiber）**：当系统指标子族势向上延展至全集管线满载边界态 $J = I$ 时，计算纤维核算条件 $\mathfrak{F}_{\phi, I}(y)$ 施加了全约束势垒：要求在所有被观测的独立维度响应面上均绝对一致重合。在此刚性极域状态下，当且仅当底层基础规范结构 $\mathcal{G}$ 具备**族分离性**（§1.1）支持时，此全架构等价态才能无损地收缩至标准集论纯粹映射拓扑中的绝对原像定义域点集 $\phi^{-1}(y)$。
> 依据交集聚类的单调代数收敛同态特性可知，该特征集合域必定遵循严格的向心包含偏序：任取系统内部的任意单一界别分量 $i \in I$ 作为基底定标，必然恒有 $\mathfrak{F}_{\phi, I}(y) \subseteq \mathfrak{F}_{\phi, d_i}(y)$ 严格成立。

> **注（单分量极值与分量分划的退化关系）**：
> 当评估限界退化至唯一的单分量纤维极值状态（即 $|J|=1$, 考察特定映射轨线 $j \in I$）时，此独立底层信道纤维受到算子 $\phi$ 在该单分量上的宏观相态决定：
> - 若 $j \in I_{\mathrm{id}}(\phi)$（恒等分量）：$\mathfrak{F}_{\phi, d_j}(y) = \{x : d_j(x, y) = 0\}$，纤维退化为 $y$ 在 $d_j$ 下的本原等价类，不再包含由操作 $\phi$ 施加的附加测度压缩；
> - 若 $j \in I_{\mathrm{const}}(\phi)$（常值分量）：$\mathfrak{F}_{\phi, d_j}(y) = \mathrm{dom}(\phi)$ 对所有可达 $y \in \mathrm{Im}(\phi)$ 均等式成立——该方向的演化定义域测度差异被整体化简为常数零分布；
> 综上排他性逻辑可知：在多维组合推演中，算子所诱发的一切具备跨维度理论价值的非平凡几何收缩演化，在测度上均必然且唯一地收敛于**活跃特征簇** $j \in I_{\mathrm{act}}(\phi)$ 的代数范畴内。

### 3.2 吸收半径

纤维的厚度由**局部吸收半径**刻画——即以某点为中心，能被完全包含在目标纤维结构内部的最大伪度量开球半径。

#### 定义（吸收半径，Absorption Radius）

设 $\phi \in \Omega$，$y \in \mathrm{dom}(\phi)$。指定输入端单一测距分量 $i \in I$ 与输出端特征子族 $J \subseteq I$（$J \neq \emptyset$）。定义算子 $\phi$ 在点 $y$ 处关于特征映射对 $(d_i, J)$ 的**吸收半径**：

$$\alpha_{\phi, d_i, J}(y) \;\triangleq\; \sup\bigl\{r \geq 0 \;\big|\; B_{d_i}(y, r) \subseteq \mathfrak{F}_{\phi, J}(\phi(y))\bigr\}$$

即以 $y$ 为中心，在输入分量 $d_i$ 的测度下，能被完全包含于输出端特征子族 $J$ 的计算纤维 $\mathfrak{F}_{\phi, J}(\phi(y))$ 内的最大开球截面半径。由此提取定义该域上的**最小吸收半径**（极小化阈值）：

$$\underline{\alpha}_{\phi, d_i, J} \;\triangleq\; \inf_{y \in \mathrm{dom}(\phi)} \alpha_{\phi, d_i, J}(y)$$

$\alpha_{\phi, d_i, J}(y)$ 直接表征了计算纤维在流形 $y$ 处的**局部度量厚度**：任何受限于此 $d_i$-半径内的输入侧独立扰动，在历经算子 $\phi$ 映射后，在子族 $J$ 的局部等价类集合上均表现为零测度差异收敛。当输出子族退化为单分量 $|J|=1$（即 $J=\{j\}$）时，判定条件退化为最初的单通道相态 $\alpha_{\phi, d_i, d_j}(y)$。特别地，当映射 $\phi$ 在子族 $J$ 上满足局部单射性，且 $d_i$ 满足分离伪度量条件时，局部吸收半径必然坍缩收敛至 $\alpha_{\phi, d_i, J}(y) = 0$。

> **注（向同性初界与纤维的异构形态）**：数学上，局部吸收半径 $\alpha_{\phi, d_i, J}(y)$ 限定了一个以 $y$ 为中心的各向同性测度开球，它仅为该域局部等价态的成立提供了一个最保守的单向解析下界。但在非线性算子 $\phi$ 的多维映射投影下，真实的计算纤维 $\mathfrak{F}_{\phi, J}(y)$ 往往呈现出非凸、非连通及高度非向同性的复杂拓扑形态。此开球半径仅构成该等价类集合在特定维度上的内部逼近，而涵盖跨维度几何特征的测度等价连续（或离散）全集，才是算符相态同伦重组在流形上的真实拓扑全貌。

#### 定义（吸收矩阵，Absorption Matrix）

基于单分量最小吸收半径 $\underline{\alpha}_{\phi, d_i, d_j}$，针对算子 $\phi \in \Omega$ 定义其全测度相态下、与 Lip 矩阵共轭对等的**吸收矩阵** $\mathbf{A}(\phi) \in \bar{\mathbb{R}}_+^{|I| \times |I|}$：

$$[\mathbf{A}(\phi)]_{ji} \;\triangleq\; \underline{\alpha}_{\phi, d_i, d_j}$$

（注：采用 $[ \cdot ]_{ji}$ 标记以确保行索引对应输出特征 $j$，列索引对应输入特征 $i$，此转置记法与标准矩阵特征流向算子左乘状态列向量的代数拓扑严格同构）。

吸收矩阵 $\mathbf{A}(\phi)$ 是算子内禀的客观存在，它独立于由外部观察者任意指定的主观观测子族 $J$。网络中所有维度的底层相界无论是否被末端截取，其吞噬折叠的几何能力均被显式地客观封存在此矩阵之中。

> **注（吸收矩阵与 Lip 矩阵的拓扑对偶性）**：全局连续放缩矩阵 $\mathbf{L}(\phi)$ 刻画了输入散度向各输出散度扩散的**极差放大上界**；作为正交对偶，离散等价矩阵 $\mathbf{A}(\phi)$ 则严格定量设定了输入波动被各分支**同伦吸收的容限下界**。一者从线性度量的无限扩张侧，一者从非线性测度的等价归零死锁侧，共同闭合并界定了同一算子网络在局部流形上的全系统限界相态。

### 3.3 标量 Lip 常数

#### 约定（标量 Lip 常数与 Lip 矩阵的关系）

对固定的分量对 $(d_i, d_j) \in \mathcal{G}^2$，定义算子 $\phi$ 在该分量对上的**标量 Lip 常数**：

$$L_{\phi, d_i \to d_j} \;\triangleq\; \inf\bigl\{L_{i \to j} \;:\; \exists\, \mathbf{L} \in \mathscr{L}(\phi),\; L_{i \to j} \text{ 为 } \mathbf{L} \text{ 的 } (i, j) \text{ 条目}\bigr\}$$

即 $\phi$ 的全体合法 Lip 矩阵在 $(i, j)$ 条目上的下确界。$L_{\phi, d_i \to d_j} \in \bar{\mathbb{R}}_+$。纤维内部 $\phi$ 在 $d_j$ 下的输出不可区分（$d_j$-Lip $= 0$），标量 Lip 常数仅反映跨纤维的输出变化率。

### 3.4 多量子族计算多样性与纤维维数

算符 $\phi$ 初始接驳入定义域时的测度复杂度上限由源空间度量熵（§1.2）标定；而 $\phi$ 实际向目标域导出的宏观有效物理差异分布，则由 $\mathrm{Im}(\phi)$ 承载的受限度量熵独立判定。两者之度量偏差即揭示了被算符内部纤维构型彻底化解并代数归零的拓扑冗余量。配合前文维度的子族域扩展，此处各项测定公式与维数核算均严格原生定型于任意复合指标族之上。

#### 定义（计算多样性，Computational Diversity）

对 $\phi \in \Omega$、特设接收端复合隔离特征子族 $J \subseteq I$ 及探测精度容忍度 $\varepsilon > 0$：

$$\mathrm{CD}_{\varepsilon, J}(\phi) \;\triangleq\; \log \mathcal{N}_{d_J}\bigl(\varepsilon,\, \mathrm{Im}(\phi)\bigr)$$

使用多径上确界极值度量 $d_J$ 要求每一孤立输出向皆必须同时被容置在 $\varepsilon$ 切比雪夫球内，由此核算目标集合 $\mathrm{Im}(\phi)$ 抵御跨分支耦合扩散的最紧独立可解析网点基础底座规模。

#### 定义（纤维膨胀量，Fiber Inflation）

指定用于标定最初空间位姿的输入测度特征限定子族 $K \subseteq I$、用于下游重取采样的输出测度特征提取子族 $J \subseteq I$ 及统一容错极值精度 $\varepsilon > 0$：

$$\mathrm{FI}_{\varepsilon, K, J}(\phi) \;\triangleq\; I_{\varepsilon, d_K}\bigl(\mathrm{dom}(\phi)\bigr) - I_{\varepsilon, d_J}\bigl(\mathrm{Im}(\phi)\bigr)$$

*(式中 $I_{\varepsilon, \cdot}$ 依据 §1.2 空间度量熵取定。为代数便捷，同源等族跨接（当 $K = J$ 时）可收缩简记为原生子族内部本征膨胀量 $\mathrm{FI}_{\varepsilon, J}(\phi)$)*。膨胀核心原理：只有当 $\phi$ 在跨系非线性射影传输执行阶段内，通过内部不可逆纤维结构强制合并碾平了原本能并在 $d_K$ 前场观测坐标中清楚离析甄别的独立等价极差态，致使其转化为低纬 $d_J$ 复合等效态进而绝缘消弭，测度 $I$ 才会基于后置受限区间的信息骤缩效应直接显现出正负抵消后的截面正值突跃。

> **注（探索精度 $\varepsilon$ 的拓扑探针基底限制）**：上述测度的核心衍生参数 $\varepsilon$ 提供了一把测量极差尺度的浮标工具标尺。必须彻底理清的是：度量熵 $I_{\varepsilon}$ 所固有的动态极值属性是针对 $\varepsilon$-紧包络外壳本身的覆盖网眼，它并不能反向修改决定绝对方程式 $\mathfrak{F}_{\phi, J}$ 存在状态的核心根骨依据：等价全同收敛必定且唯一归因于极差代数锁死 $d = 0$。

#### 定义（纤维维数，Fiber Dimension / 零化拓扑维数）

运用经典分形信息几何中对 Minkowski 等势体（计盒模型）的基础对数量纲降维推衍生成原则提取内核指数：

$$\mathrm{dim}_{F,\varepsilon, K, J}(\phi) \;\triangleq\; \frac{\mathrm{FI}_{\varepsilon, K, J}(\phi)}{\log(1/\varepsilon)}$$

该项物理降阶算则精确计算了被执行算符 $\phi$ 在当前系统有效探针截面分辨率尺度 $\varepsilon$ 评估下，在自前端输入特征参考簇系 $K$ 暴力传导至系统末端输出响应特征提取簇系 $J$ 的跨流形交互变动过程中，遭到实质性截留、解耦或压缩归零而永久坏死散失掉的**原生等效拓扑自由度维数**总量。

**命题 3.1（对孤立单分量之 Lipschitz 局域映射维距退化的极限限界）**：严格约束条件在单向孤立度量接驳限定对 $(d_i, d_j)$ 之上时，预设其满足系统所准允的最宽泛标量常数值界 $L_{\phi, d_i \to d_j} < \infty$。则：

$$\mathrm{FI}_{\varepsilon, d_i, d_j}(\phi) \;\geq\; I_{\varepsilon, d_i}\bigl(\mathrm{dom}(\phi)\bigr) - I_{\varepsilon / L_{\phi, d_i \to d_j},\, d_i}\bigl(\mathrm{dom}(\phi)\bigr)$$

**证明**：$\phi$ 将 $\mathrm{dom}(\phi)$ 中的 $(\varepsilon/L)$-$d_i$ 球映射到 $\varepsilon$-$d_j$ 球内（由标量 Lip 常数定义）。故 $\mathcal{N}_{d_j}(\varepsilon, \mathrm{Im}(\phi)) \leq \mathcal{N}_{d_i}(\varepsilon/L, \mathrm{dom}(\phi))$。取对数代入即得。$\square$

**命题 3.2（分辨率-吸收界）**：设 $\underline{\alpha}_{\phi, d_i, d_j} = \alpha > 0$。则：

$$\mathrm{CD}_{\varepsilon, d_j}(\phi) \;\leq\; I_{\alpha, d_i}\bigl(\mathrm{dom}(\phi)\bigr)$$

**证明**：取 $\mathrm{dom}(\phi)$ 在 $d_i$ 下的 $\alpha$-覆盖 $\{c_1, \ldots, c_M\}$（$M = \mathcal{N}_{d_i}(\alpha, \mathrm{dom}(\phi))$）。由吸收半径定义，$B_{d_i}(c_m, \alpha) \subseteq \mathfrak{F}_{\phi, d_j}(\phi(c_m))$，故 $\phi$ 的全部输出可被 $\{\phi(c_1), \ldots, \phi(c_M)\}$ 在 $d_j$ 下 $\varepsilon$-覆盖（因纤维内输出 $d_j$-不可区分）。$\square$

### 3.5 纤维吸收

在算子链中，前一步的输出偏差可能被后一步的纤维结构吸收——若偏差不足以使输出点跨越纤维边界，后一步在该分量上的输出差异**精确归零**。

#### 基本纤维吸收

**定理 3.3（纤维吸收定理）**：设 $\phi_2 \circ \phi_1 \in \Omega$ 为两步复合。设 $\phi_1$ 在 $x$ 处的输出为 $\hat{y} = \phi_1(x)$，$y \in \mathrm{dom}(\phi_2)$ 为某参考点，偏差 $\delta = d_i(\hat{y}, y)$。

若 $\hat{y} \in \mathfrak{F}_{\phi_2, d_j}(\phi_2(y))$——即 $\hat{y}$ 与 $y$ 落入 $\phi_2$ 关于 $d_j$ 的同一根纤维——则：

$$d_j\bigl(\phi_2(\hat{y}),\, \phi_2(y)\bigr) = 0$$

前步偏差 $\delta$ 在分量 $d_j$ 上被**精确吸收**，不向后续传播。

**证明**：$\hat{y} \in \mathfrak{F}_{\phi_2, d_j}(\phi_2(y))$ 意味着 $d_j(\phi_2(\hat{y}), \phi_2(y)) = 0$（由纤维定义直接得出）。$\square$

> **注（吸收条件与吸收半径的关系）**：当 $\delta \leq \alpha_{\phi_2, d_i, d_j}(y)$ 时，$\hat{y} \in B_{d_i}(y, \delta) \subseteq \mathfrak{F}_{\phi_2, d_j}(\phi_2(y))$，吸收定理的前提自动满足。吸收半径给出了吸收发生的**充分条件**。

#### 算子链中的吸收矩阵非线性迭代

在绝对确定性的级联算子链 $c_\phi = \phi_k \circ \cdots \circ \phi_1$ 中，取定义域内任意两个初始空间测度点 $x, x' \in \mathrm{dom}(c_\phi)$。由于系统流形映射的唯一确定性，它们在算子网第 $m$ 步（$1 \leq m \leq k$）必然具有唯一确定的演化像点 $x_m \triangleq (\phi_m \circ \cdots \circ \phi_1)(x)$ 与 $x'_m \triangleq (\phi_m \circ \cdots \circ \phi_1)(x')$。

**命题 3.4（算子链的非线性截断迭代律）**：在复合测度网络全景中，点对像点序列在跨步测距上的拓展摆脱了单纯标量的孤立推演，完全受控于 $\mathbf{L}$ 与 $\mathbf{A}$ 两大内禀代数矩阵的结构性对冲。对于目标演化步 $\phi_{m+1}$，任意观测特征 $d_j$ 下的像点局部极差测距严格满足如下迭代界限方程式：

$$d_j(x_{m+1}, x'_{m+1}) \;\leq\; \begin{cases} 0 & \text{若仅存在单一活跃前置分量 } i \text{ 满足 } d_i(x_m, x'_m) \leq [\mathbf{A}(\phi_{m+1})]_{ji} \text{，且对其余 } p \neq i \text{ 均有 } d_p(x_m, x'_m) = 0 \\ \sum\limits_{i \in I} [\mathbf{L}(\phi_{m+1})]_{ji} \cdot d_i(x_m, x'_m) & \text{否则} \end{cases}$$

该复合界限方程直白地解构了算子链底层传导的代数对冲实质：前序节点累积的系统测距哪怕依凭 $\mathbf{L}_{m+1}$ 阵列进行了跨分量的累加扩溢，也绝不可能绕开原生 $\mathbf{A}$ 矩阵（即全域非线性“等价底线断路器”）的客观测度截断。一旦前置信道内的单边测距未能击穿特定的局部吸收底线，针对该目标信道 $d_j$ 上的任何高倍代数放缩都会即刻阶跃归零。端到端复合运算体系正是凭借流形底部的这道不可见的结构性吸收断层，彻底勒阻了经典分析中仅凭 $\prod \mathbf{L}_{\phi_m}$ 链式连乘模型所带来的无脑代数发散偏压。

> **注（与连续矩阵放缩的关系）**：该纯拓扑降元断层模型缝合了传统测度放缩理论的残缺。单纯的 Lip 矩阵只能界定系统散度的发散上限（膨胀）；而引入吸收矩阵后的非线性过滤推演，才真正在代数方程层面上赋予了理论架构一个能让微小波动发生孤立闭环等价（$\vec{\delta} \to 0$）的收敛下垫面底座。

#### 链级纤维膨胀的可加性

**命题 3.5（链级纤维膨胀的可加性）**：设 $\psi = \phi_2 \circ \phi_1$，取 $d_i = d_j = d \in \mathcal{G}$。若 $\mathrm{Im}(\phi_1) \subseteq \mathrm{dom}(\phi_2)$（即复合定义域无损耗），则：

$$\mathrm{FI}_{\varepsilon, d}(\psi) \;=\; \mathrm{FI}_{\varepsilon, d}(\phi_1) \;+\; \mathrm{FI}_{\varepsilon, d}(\phi_2\big|_{\mathrm{Im}(\phi_1)})$$

**证明**：由假设 $\mathrm{dom}(\psi) = \mathrm{dom}(\phi_1)$，$\mathrm{Im}(\psi) = \phi_2(\mathrm{Im}(\phi_1))$。加减中间项 $I_{\varepsilon, d}(\mathrm{Im}(\phi_1))$ 即得。$\square$

**推论 3.6（$k$-步链的纤维膨胀与余维可加）**：设 $c_\phi = \phi_k \circ \cdots \circ \phi_1$，若逐步满足 $\mathrm{Im}(\phi_{m-1} \circ \cdots \circ \phi_1) \subseteq \mathrm{dom}(\phi_m)$（$2 \leq m \leq k$），则：

$$\mathrm{FI}_{\varepsilon, d}(c_\phi) \;=\; \sum_{m=1}^{k} \mathrm{FI}_{\varepsilon, d}(\phi_m\big|_{\mathrm{Im}(\phi_{m-1} \circ \cdots \circ \phi_1)})$$

每步复合贡献一项纤维膨胀。总坍缩维数等于逐步坍缩维数之和——链越长，累积纤维坍缩越深。

### 3.6 纤维冲突

当一个算子将两个输入坍缩至同一纤维，而另一个算子要求区分这两个输入时，产生**纤维冲突**。

#### 定义（纤维冲突，Fiber Conflict）

设 $\phi, \psi \in \Omega$，$\tau > 0$，$d_j \in \mathcal{G}$。若存在 $x', x'' \in \mathrm{dom}(\phi) \cap \mathrm{dom}(\psi)$ 使得：

$$d_j(\phi(x'), \phi(x'')) = 0 \quad \text{但} \quad d_j(\psi(x'), \psi(x'')) > 2\tau$$

则称 $\phi$ 与 $\psi$ 在点对 $(x', x'')$ 上关于 $(d_j, \tau)$ 发生**纤维冲突**——$\phi$ 将 $x', x''$ 坍缩至同一 $d_j$-纤维，而 $\psi$ 要求它们在 $d_j$ 下保持超过 $2\tau$ 的距离。

> **注（精确纤维冲突的拓扑不变性）**：纤维冲突的条件 $d_j(\phi(x'), \phi(x'')) = 0$ 是等价类结构的性质，不随连续扰动而消失。这使得纤维冲突产生的逼近下界是**结构性的**，而非仅仅是度量估计。

**命题 3.7（纤维冲突的不可逼近性）**：设算子链 $\hat{\psi} = \phi_k \circ \cdots \circ \phi_1$ 尝试逼近目标 $\psi$。若在第 $m$ 步发生与 $\psi$ 的纤维冲突，即存在 $x', x'' \in \mathrm{dom}(\hat{\psi}) \cap \mathrm{dom}(\psi)$ 使得 $d_j(\phi_m(h'_{m-1}), \phi_m(h''_{m-1})) = 0$（其中 $h'_{m-1}, h''_{m-1}$ 为 $x', x''$ 经前 $m-1$ 步的中间态），则：

$$\max\bigl\{d_j(\hat{\psi}(x'), \psi(x')),\; d_j(\hat{\psi}(x''), \psi(x''))\bigr\} \;\geq\; \frac{d_j(\psi(x'), \psi(x''))}{2}$$

**证明**：$d_j(\phi_m(h'_{m-1}), \phi_m(h''_{m-1})) = 0$ 蕴含 $d_j(\hat{\psi}_{\mathrm{tail}}(\phi_m(h'_{m-1})), \hat{\psi}_{\mathrm{tail}}(\phi_m(h''_{m-1}))) = 0$（其中 $\hat{\psi}_{\mathrm{tail}} = \phi_k \circ \cdots \circ \phi_{m+1}$；由 Lip 不等式 $L \cdot 0 = 0$，遵循 §1.1 $\bar{\mathbb{R}}_+$ 约定），即 $d_j(\hat{\psi}(x'), \hat{\psi}(x'')) = 0$。由三角不等式：
$$d_j(\psi(x'), \psi(x'')) \leq d_j(\hat{\psi}(x'), \psi(x')) + d_j(\hat{\psi}(x'), \hat{\psi}(x'')) + d_j(\hat{\psi}(x''), \psi(x''))$$
$$= d_j(\hat{\psi}(x'), \psi(x')) + 0 + d_j(\hat{\psi}(x''), \psi(x''))$$
两项中至少一项 $\geq d_j(\psi(x'), \psi(x''))/2$。$\square$

> **注（纤维吸收与纤维冲突的对偶性）**：§3.5 的纤维吸收——偏差落入纤维内被精确消除——是有利的多对一坍缩。纤维冲突——需要区分的信号被坍缩至同一纤维——是不利的多对一坍缩。两者是同一纤维结构的两面：吸收半径同时决定了算子的**鲁棒性**（吸收容限）和**分辨率极限**（冲突阈值）。

----
*[IDFS] ⊢ [GLENZLI] ⊢ [Part 01] ⊢ [03-computational-fiber] ⊢ [b8867d6753c81282]*
