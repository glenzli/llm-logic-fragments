## 拟合几何

§1 的三态分类基于路径 Lipschitz 常数 $L_i$ 与全局约束 $L$ 的关系，给出了拟合形态的**外部边界**——域宽、可复合性、CAC 状态。但分类本身不描述每种形态在 $F$-空间中的**内部拓扑结构**。本节逐一考察三种形态的拟合域 $P_\tau(r)$ 在度量空间 $\mathcal{X}$ 中呈现什么几何形态、具有怎样的稳定性、以及如何响应外部扰动。

### 2.0 局部扰动敏感性

在展开三态的内部几何之前，定义一个贯穿本节的核心可观测量。

**定义（局部扰动敏感性，Local Perturbation Sensitivity）**：定义 $\Phi$ 在输入 $x_0$ 处的**局部扰动敏感性**：

$$S(x_0) \;\triangleq\; \limsup_{\delta \to 0} \frac{d(\Phi(x_0 + \delta),\, \Phi(x_0))}{\delta}$$

即 $\Phi$ 在 $x_0$ 处的有效局部 Lipschitz 常数。$S(x_0)$ 是**不依赖语义标签的、纯度量空间可计算的形态判据**——在任意 $x_0 \in \mathcal{X}$ 处测量 $\Phi$ 的局部扰动放大率，即可判定该点处于何种拟合形态（见 §2.1–§2.5 各小节的结论）。

---

### 2.1 窄槽定理

§1 命题 2 证明了逐字式拟合的 $\tau$-拟合集 $P_\tau(r_s)$ 的直径不超过 $O(\tau/L_s)$。本节精细化这一结论，揭示 $P_\tau(r_s)$ 不仅小，而且具有**强各向异性**的内部结构。

**定义（方向性直径，Directional Diameter）**：设 $A \subseteq \mathcal{X}$，$v$ 为 $\mathcal{X}$ 中的一个方向（在一般度量空间中，取 $v$ 为连接 $A$ 内两点的测地线方向）。定义 $A$ 沿 $v$ 方向的**方向性直径**：

$$\mathrm{diam}_v(A) \;\triangleq\; \sup \bigl\{ d(x, y) \;\big|\; x, y \in A,\; (x, y) \text{ 沿 } v \text{ 方向} \bigr\}$$

**命题 1（窄槽的各向异性，Anisotropy of the Narrow Groove）**：设 $(r_s, \mathcal{X}(r_s)) \in \mathcal{S}$ 为逐字式拟合形态（$L_s \gg L$）。设 $r_s$ 在 $\mathcal{X}(r_s)$ 上具有 $(\rho, \Delta_s)$-变分（§4.1 定义），变分方向为 $v_s$（即 $r_s$ 的值域在 $v_s$ 方向上跳变最剧烈）。则 $P_\tau(r_s)$ 的几何形态满足：

(i) **横向压缩**：在垂直于 $v_s$ 的方向上，$P_\tau(r_s)$ 的直径受 $\Phi$ 的全局 Lipschitz 常数控制：

$$\mathrm{diam}_{\perp v_s}(P_\tau(r_s)) \;\leq\; \frac{2\tau}{L_s - L}$$

(ii) **纵向伸展受限**：沿 $v_s$ 方向，$P_\tau(r_s)$ 的直径受 $\Phi$ 对 $r_s$ 的变分追踪能力控制：

$$\mathrm{diam}_{v_s}(P_\tau(r_s)) \;\leq\; \frac{\Delta_s + 2\tau}{L_s}$$

(iii) **各向异性比**：横向直径与纵向直径之比为：

$$\frac{\mathrm{diam}_{\perp v_s}}{\mathrm{diam}_{v_s}} \;\leq\; \frac{2\tau \cdot L_s}{(\Delta_s + 2\tau)(L_s - L)} \;\approx\; \frac{2\tau}{\Delta_s} \quad (L_s \gg L)$$

当 $\tau \ll \Delta_s$（拟合精度远小于目标变分幅度）时，各向异性比 $\ll 1$——$P_\tau(r_s)$ 为一条沿 $v_s$ 方向极度拉伸、垂直方向极度压扁的**窄槽（Narrow Groove）**。

**证明**：

(i) 取 $P_\tau(r_s)$ 中两点 $x, y$，沿垂直于 $v_s$ 的方向分离。在该方向上，$r_s$ 的变分近似为零（$d(r_s(x), r_s(y)) \approx 0$，因 $r_s$ 的剧烈变化集中在 $v_s$ 方向）。由 $x, y \in P_\tau$：

$$d(\Phi(x), \Phi(y)) \;\leq\; d(\Phi(x), r_s(x)) + d(r_s(x), r_s(y)) + d(r_s(y), \Phi(y)) \;<\; 2\tau + 0 = 2\tau$$

同时，$\Phi$ 在 $\mathcal{X}(r_s)$ 上的局部 Lipschitz 常数为 $L_s$（§1 定义），故：

$$d(\Phi(x), \Phi(y)) \;\geq\; L_s \cdot d(x, y) - 2\tau$$

（此处利用了反向三角不等式：$L_s \cdot d(x,y) \leq d(\Phi(x), \Phi(y)) + 2\tau$。更精确地，$\Phi$ 在逼近 $r_s$ 时必须在 $v_s$ 垂直方向上展现近乎平坦的行为，因为 $r_s$ 在该方向无变分但 $\Phi$ 的全局 Lipschitz 为 $L$，所以 $\Phi$ 的横向拉伸不超过 $L \cdot d(x,y)$。）联合两个约束：$L_s \cdot d(x,y) - 2\tau \leq L \cdot d(x,y)$，解得 $d(x,y) \leq 2\tau/(L_s - L)$。

(ii) 取 $P_\tau(r_s)$ 中两点 $x, y$，沿 $v_s$ 方向分离。由 $r_s$ 的 $(\rho, \Delta_s)$-变分，$d(r_s(x), r_s(y)) \leq \Delta_s$（变分上界）。由 $x, y \in P_\tau$：

$$L_s \cdot d(x, y) \;\leq\; d(r_s(x), r_s(y)) + 2\tau \;\leq\; \Delta_s + 2\tau$$

解得 $d(x,y) \leq (\Delta_s + 2\tau)/L_s$。

(iii) 直接取商。$\square$

> **注（窄槽的物理含义）**：窄槽几何揭示了逐字式拟合在 $F$-空间中的精确拓扑形态——它不是一个"小球"（各向同性的微小域），而是一条沿目标序列方向极度拉伸的**拓扑细丝**。系统在这条细丝上精确地追踪 $r_s$ 的逐步输出，但任何偏离细丝方向的微小扰动都会因 $L_s \gg L$ 的极高曲率而被急剧放大——横向直径 $2\tau/(L_s - L)$ 的极小性正是这一放大效应的几何反映。与 §1 命题 2 给出的"域宽极小"的标量结论相比，窄槽定理揭示了域宽极小在不同方向上的**定量非均匀分布**。

---

### 2.2 自锚定与脱槽

逐字式拟合的一个关键现象是：系统在 $P_\tau(r_s)$ 内部可以**逐步自稳定地运行**——每一步输出被追加到输入后，新输入仍落在 $P_\tau(r_s)$ 内。但一旦某步输出偏出窄槽，后续不可恢复。本节将这一现象形式化。

**定义（自锚定链，Self-Anchoring Chain）**：设 $(r_s, \mathcal{X}(r_s)) \in \mathcal{S}$ 为逐字式拟合。定义 $r_s$ 的**自锚定链**为长度 $T$ 的逐步复合序列：

$$x_0 \;\in\; P_\tau(r_s), \quad x_{t+1} \;=\; \Phi(x_t), \quad t = 0, 1, \ldots, T-1$$

即系统从窄槽内的某个初始点出发，每步将输出作为下一步输入，逐步演化。

**命题 2（槽内自稳定性，Intra-Groove Self-Stability）**：若 $\Phi$ 在 $P_\tau(r_s)$ 上满足条件 $d(\Phi(x), r_s(x)) < \tau$ 对所有 $x \in P_\tau(r_s)$ 成立（$\tau$-拟合集的定义），且 $r_s$ 具有**自回归不变性**——$r_s(x) \in P_\tau(r_s)$ 对所有 $x \in P_\tau(r_s)$ 成立——则自锚定链在 $P_\tau(r_s)$ 内**逐步自稳定**：

$$d(x_{t+1}, r_s(x_t)) \;\leq\; \tau, \quad x_{t+1} \in P_\tau(r_s) \quad \forall\, t$$

即每步输出 $x_{t+1} = \Phi(x_t)$ 与 $r_s$ 的理想输出 $r_s(x_t)$ 之间的偏差恒 $\leq \tau$，且 $x_{t+1}$ 留在窄槽内。

**证明**：由 $x_t \in P_\tau(r_s)$，$d(\Phi(x_t), r_s(x_t)) < \tau$，故 $x_{t+1} = \Phi(x_t)$ 与 $r_s(x_t)$ 的距离 $< \tau$。由自回归不变性，$r_s(x_t) \in P_\tau(r_s)$。由三角不等式，$d(x_{t+1}, r_s(x_t)) < \tau$，若 $\tau < \mathrm{diam}_{v_s}(P_\tau(r_s))/2$（窄槽足够长以容纳 $\tau$-偏差），则 $x_{t+1} \in P_\tau(r_s)$。以 $T$ 步归纳即得。$\square$

> **注（自回归不变性的含义）**：条件 $r_s(x) \in P_\tau(r_s)$ 要求 $r_s$ 的理想输出序列**始终留在自身的窄槽内**。这在精确序列复现的场景中自然成立：若 $r_s$ 的目标是逐步输出序列 $(w_1, w_2, \ldots, w_T)$，则每步的理想输出（下一个 token 的嵌入拼接到前缀后）仍是精确前缀邻域的元素——窄槽沿序列方向延伸的拓扑正是 §2.1 纵向伸展的物理内容。

**命题 3（脱槽的不可逆性，Irreversibility of Groove Departure）**：设在自锚定链的第 $t^*$ 步，误差使 $x_{t^*+1}$ 偏出 $P_\tau(r_s)$：$x_{t^*+1} \notin P_\tau(r_s)$。则对所有后续步 $t > t^*$，系统不可能自发回到窄槽——即不存在 $t' > t^*$ 使得 $x_{t'} \in P_\tau(r_s)$——除非外部干预将 $x_t$ 重置为 $P_\tau(r_s)$ 中的元素。

**证明**：由 §1 命题 3（采样域孤立），$P_\tau(r_s)$ 与所有其他规则的采样域不相交。一旦 $x_{t^*+1} \notin P_\tau(r_s)$，$x_{t^*+1}$ 落入某个 $\mathcal{X}(r_j)$（$r_j \neq r_s$）的领域——$\Phi$ 在该区域的行为由 $r_j$ 的拟合约束主导，其 Lipschitz 常数为 $L_j \leq L \ll L_s$。后续轨道 $x_{t^*+2}, x_{t^*+3}, \ldots$ 沿 $r_j$ 的拟合轨迹演化，以 $L_j$ 级的温和形变率运动——完全偏离 $r_s$ 的窄槽。

回归窄槽需要 $x_t$ 从 $\mathcal{X}(r_j)$ 穿越到 $P_\tau(r_s)$。但由 §2 命题 5（路由分辨率极限），跨越 $\sigma$-决策边界需要 $d(x_t, P_\tau(r_s)) \leq \Delta/L$，而 $P_\tau(r_s)$ 的直径为 $O(\tau/L_s) \ll \Delta/L$——窄槽作为回归目标太小，$\Phi$ 的 Lipschitz 连续性无法将轨道精确引导回该极小域。

因此，脱槽是**不可逆的拓扑事件**——与 §7.2 覆盖缺口注记的离散跳崖在机制上同构。$\square$

> **注（与分段复合的结构类比）**：命题 2 的自锚定链在形式上是 §7.2 分段复合链的**退化特例**——段长 $l_0 = 1$，码本 $\mathcal{C}$ 退化为 $\Phi$ 在 $P_\tau(r_s)$ 上的像集。误差隔绝条件 $\tau < \Delta_{\mathcal{C}}/2$ 的类比物是：每步输出足够接近窄槽中心线，使得下一步的输入不跌出窄槽。脱槽（命题 3）对应码本覆盖缺口——输出偏出窄槽后，没有任何锚点能将轨道拉回，等价于覆盖条件被击穿。但有一个关键区别：真正的分段复合架构（§7.2）通过**外部验证**（显式码本 $\mathcal{C}$）实现重置，而逐字式拟合的"自锚定"是系统**内部**的自发行为，没有外部纠错机制。一旦脱槽，系统无法自我修正——这正是逐字式拟合不参与 $R^*$ 复合（$\chi_s = 0$）的动力学诠释。

---

### 2.3 扰动敏感性

窄槽的极端各向异性（命题 1）蕴含了逐字式拟合对外部扰动的极端敏感性。本节将其量化为一个可观测判据。

**命题 4（逐字式拟合的 Lipschitz 不稳定性，Lipschitz Instability of Verbatim Fitting）**：设 $(r_s, \mathcal{X}(r_s)) \in \mathcal{S}$ 为逐字式拟合，$(r_i, \mathcal{X}(r_i)) \in \mathcal{S}$ 为逻辑式拟合（$L_i \leq L$）。对初始输入 $x_0$ 做 $\delta$-扰动得到 $x_0' = x_0 + \delta$，则系统在一步后的输出偏差满足：

| 拟合形态 | 输出偏差上界 | 量级 |
|---|---|---|
| 逻辑式拟合 | $d(\Phi(x_0), \Phi(x_0')) \leq L_i \cdot \delta$ | $O(\delta)$ |
| 逐字式拟合 | $d(\Phi(x_0), \Phi(x_0')) \leq L_s \cdot \delta$ | $O(L_s \cdot \delta)$ |

两者的输出偏差之比 $\geq L_s / L_i \gg 1$。

**证明**：直接由 $\Phi$ 在各自采样域上的路径 Lipschitz 常数定义。$\square$

**推论（扰动敏感性比作为形态判据，Perturbation Sensitivity Ratio as Morphology Criterion）**：由 §2.0 定义的局部扰动敏感性 $S(x_0)$：

- $S(x_0) \leq L$（约束内）：$x_0$ 位于逻辑式或事实式拟合的域内。
- $S(x_0) \gg L$（约束外）：$x_0$ 位于逐字式拟合的窄槽内。

> **注（三态的扰动特征谱）**：将扰动敏感性比与 §1 的三态汇总定理联合，得到完整的形态-扰动对应关系：
>
> | 拟合形态 | $S(x_0)$ | 对扰动的响应 | 可复合性 |
> |---|---|---|---|
> | **逻辑式** | $\leq L$ | 稳定（扰动被温和放大） | ✅ |
> | **事实式** | $\lesssim L$ | 局部稳定（边界区可能敏感） | ✅（条件性） |
> | **逐字式** | $\gg L$ | **极不稳定**（微小扰动引发脱槽） | ❌ |
>
> 此特征谱完全由 §1 的 $L_i$ 分类决定，与 §2.1 的窄槽几何自洽：$S \gg L$ 的极不稳定性正是窄槽极端各向异性的动力学表现——横向直径 $2\tau/(L_s - L)$ 的极小性意味着，任何垂直于窄槽的扰动 $\delta > 2\tau/(L_s - L)$ 都足以将轨道推出 $P_\tau(r_s)$，触发命题 3 的不可逆脱槽。

---

### 2.4 逻辑式拟合的几何：复合稳定域

逻辑式拟合（$L_i \leq L$）的拟合域 $P_\tau(r_i)$ 在三态中是最"温和"的——宽域、低曲率、各向同性比接近 $1$。其内部几何没有逐字式的窄槽戏剧性，但有两个**二阶结构**值得推导。

**命题 5（复合稳定半径，Composition Stability Radius）**：设 $r_i$ 为逻辑式拟合规则（$L_i \leq L$），$q = r_i \circ \cdots \circ r_i$（$l$ 步自复合链）。定义**复合稳定半径** $\rho_l$ 为满足以下条件的最大 $\rho$：对所有 $x \in P_\tau(r_i)$，$B(x, \rho) \cap \mathcal{X} \subset P_\tau(r_i)$，且 $l$ 步复合后误差仍 $\leq \tau$：

$$\rho_l \;\geq\; \frac{\tau - \varepsilon_{max} \cdot \Lambda_l}{L^l}$$

当 $l \leq l^*_0$（Type B 约束）时，分子 $\tau - \varepsilon_{max} \cdot \Lambda_l \geq 0$（CAC 保证误差 $\leq \tau$），复合稳定半径为正。

**证明**：对 $x_0 \in P_\tau(r_i)$，做 $\rho$-扰动得 $x_0' \in B(x_0, \rho)$。$l$ 步复合后的误差差异：

$$d(\Phi^l(x_0), \Phi^l(x_0')) \;\leq\; L^l \cdot \rho$$

$\Phi^l(x_0)$ 自身与理想 $q(x_0)$ 的距离 $\leq \varepsilon_{max} \cdot \Lambda_l$。要求 $\Phi^l(x_0')$ 与 $q(x_0')$ 的距离仍 $\leq \tau$：

$$\varepsilon_{max} \cdot \Lambda_l + L^l \cdot \rho \;\leq\; \tau$$

解得 $\rho \leq (\tau - \varepsilon_{max} \cdot \Lambda_l)/L^l$。$\square$

> **注（稳定半径与链深的对偶）**：$\rho_l$ 随 $l$ 以 $L^{-l}$ 指数衰减——链越长，对初始扰动越敏感。这不是缺陷而是 CAC 的忠实投影：§3 推论 2 的两态行为（$\bar{L} < 1$ 饱和 vs $\bar{L} \geq 1$ 爆炸）在此获得了空间几何的对偶——饱和态（$L < 1$）下 $\rho_l$ 收敛至正常数 $(\tau - \varepsilon_{max}/(1-L))$；爆炸态（$L \geq 1$）下 $\rho_l \to 0$，与逐字式窄槽的极端各向异性在 $L \to \infty$ 极限下**会合**。

**命题 6（路由边界带，Routing Boundary Band）**：设 $r_i, r_j \in R$ 为相邻的逻辑式拟合规则，其采样域 $\mathcal{X}(r_i)$ 与 $\mathcal{X}(r_j)$ 共享路由边界——即存在路由决策面 $\partial_{ij} = \{x \in \mathcal{X} : \sigma \text{ 在 } x \text{ 处切换 } r_i \leftrightarrow r_j\}$。则 $\partial_{ij}$ 两侧存在宽度为 $O(\Delta_{ij}/L)$ 的**路由边界带**，在带内 $\Phi$ 的局部行为同时受 $r_i$ 和 $r_j$ 的拟合约束**竞争性影响**：

$$w_{ij} \;\leq\; \frac{d(r_i(x_0), r_j(x_0))}{L} \quad \text{对 } x_0 \in \partial_{ij}$$

**证明**：由 §2 命题 5（路由分辨率极限），$\sigma$ 在 $\partial_{ij}$ 附近的切换精度受 $\Phi$ 的 Lipschitz 连续性限制。$\Phi$ 无法在 $\partial_{ij}$ 两侧无限尖锐地切换行为——在宽度 $\leq \Delta/L$ 的带内，$\Phi$ 被迫以连续方式从服务 $r_i$ 过渡到服务 $r_j$。$\square$

> **注（路由边界带是事实式拟合的发源地）**：命题 6 揭示了事实式拟合形态的几何根源——它不是一个独立的拟合"类别"，而是**两个相邻逻辑式拟合域的路由边界带**。在边界带内，$\Phi$ 的 Lipschitz 约束被两侧的竞争性需求推至 $L_j \approx L$，产生了 §1 推论 1 中"约束边界"等价类的所有特征：条件性可复合、链深更紧、DFG 缺口更显著。

---

### 2.5 事实式拟合的几何：边界区链深骤降

命题 6 将事实式拟合定位为路由边界带。本节推导在边界带内的具体后果。

**命题 7（边界区链深骤降，Boundary Zone Chain Depth Collapse）**：设 $r_j$ 为事实式拟合规则，位于路由边界带内（$L_j = L - \epsilon$，$\epsilon > 0$ 小）。则 $r_j$ 的最大可行链深：

$$l_{max}^{(j)} \;=\; \frac{\tau}{\varepsilon_{max} + (L - \epsilon)\delta_{max}} \;\approx\; l^*_0 \cdot \left(1 + \frac{\epsilon \cdot \delta_{max}}{E_0}\right)$$

其中 $E_0 = \varepsilon_{max} + L\delta_{max}$，$l^*_0 = \tau/E_0$。当 $\epsilon \to 0$（$L_j \to L$），$l_{max}^{(j)} \to l^*_0$——链深恰好退化至 Type B 安全链深。富余量 $\Delta l \approx \epsilon \cdot \delta_{max} \cdot l^*_0 / E_0$ 在 $\epsilon$ 小时微不足道。

然而，将 $r_j$ 插入包含逻辑式拟合步骤的混合链后，整条链的有效 Lipschitz 常数由最坏步主导——链深退回 $l^*_0$，富余量被抵消。

**证明**：由 §6.1 推论 3，最大链深 $l_{max} = \tau/E$，其中 $E = \varepsilon_{max} + L_j \delta_{max}$。当 $L_j = L - \epsilon$，$E = E_0 - \epsilon\delta_{max}$，$l_{max} = \tau/(E_0 - \epsilon\delta_{max})$。Taylor 展开得近似式。

对混合链，CAC 定理中 $\Theta_{j+1,l} = \prod_{k=j+1}^{l} L_k$，若任一步 $L_k = L$，则整条链的尾积 $\geq L^{l-j}$，有效链深退回逻辑式水平。$\square$

> **注（三态几何的统一画像）**：§2.0–§2.5 完整地描绘了三态在 $F$-空间中的几何画像：
>
> | 形态 | $P_\tau$ 拓扑 | $S(x_0)$ | 稳定半径 $\rho_l$ | 特有结构 |
> |---|---|---|---|---|
> | **逻辑式** | 宽域各向同性球 | $\leq L$ | $O((\tau - \varepsilon\Lambda_l)/L^l)$，正 | 路由边界带（命题 6） |
> | **事实式** | 路由边界带 | $\lesssim L$ | 略大于逻辑式 | 链深骤降（命题 7） |
> | **逐字式** | 窄槽（各向异性比 $\ll 1$） | $\gg L$ | $O(\tau/(L_s-L))$，极小 | 脱槽不可逆（命题 3） |

