## §9 拟合形态

§7–§8 建立了计算纤维和算子代数的分析工具。本节利用这些工具对 IDFS 的拟合行为进行**形态分类**——从系统 $(F, \sigma)$ 自身的度量-纤维结构中读出拟合形态，不依赖外部目标的性质。

分类基于两个正交的判据：$\sigma$ 的路由稳定性（路由层面）与 $\Phi$ 在路由分区内的纤维结构（算子层面）。两者独立作用于 IDFS 的不同结构组件，各自有独立的分辨率标尺。

---

### 9.1 分类判据

#### 分类参数 $(\tau_\sigma, \tau_f)$

本章的分类由两个独立的标尺参数驱动：

1. **路由容差尺度** $\tau_\sigma > 0$：$\sigma$ 层面的分辨率标尺——输入扰动多大算穿越路由边界。
2. **纤维容差尺度** $\tau_f > 0$：$\Phi$ 层面的分辨率标尺——输出差异多小算纤维吸收（不可区分）。

两个尺度一般不同：$\tau_\sigma$ 由路由分区的几何决定（与 $\sigma$ 的设计、$|F|$ 的大小有关），$\tau_f$ 由 $f$-chain 的纤维结构决定（与 $F$ 中函数的平滑性有关）。同一系统可能 $\tau_\sigma \gg \tau_f$（路由粗糙但映射精细）或 $\tau_\sigma \ll \tau_f$（路由精细但映射钝化）——同一系统在不同的 $(\tau_\sigma, \tau_f)$ 下可能呈现不同的形态。在链式复合需要统一尺度的场合，取 $\tau = \max(\tau_\sigma, \tau_f)$ 给出保守分类，取 $\min$ 给出激进分类。

#### 定义 9.1（$\sigma$-正则性——路由纤维吸收半径）

$\sigma$ 是离散值映射（值域为有限集 $F^{\leq \mathcal{D}}$）。$\sigma$ 的精确纤维 $\mathfrak{F}_\sigma(\sigma(x)) = \{y : \sigma(y) = \sigma(x)\}$ 就是包含 $x$ 的路由分区 $U_\alpha$。由 §7.1，$\sigma$ 在 $x$ 处的精确吸收半径为：

$$\alpha_\sigma^0(x) \;=\; \sup\{r \geq 0 : B(x, r) \subseteq \mathfrak{F}_\sigma(\sigma(x))\}$$

即以 $x$ 为中心、完全落入同一路由分区的最大球半径。对 $U \subseteq \mathcal{X}$，最小精确吸收半径 $\underline{\alpha}_\sigma^0(U) = \inf_{x \in U} \alpha_\sigma^0(x)$。

在给定 $\tau_\sigma$ 下：
- **$\sigma$-正则**：$\underline{\alpha}_\sigma^0(U) \geq \tau_\sigma$——路由纤维足够厚，$\tau_\sigma$-扰动不穿越分区边界。
- **$\sigma$-奇异**：$\underline{\alpha}_\sigma^0(U) < \tau_\sigma$——路由纤维太薄，$\tau_\sigma$-扰动可穿越分区边界。

> **注（$\alpha_\sigma^0$ 的性质）**：$F$ 有限，路由分区至多有限片。分区内部的任意点 $x$ 必有 $\alpha_\sigma^0(x) > 0$；仅在分区边界上 $\alpha_\sigma^0 = 0$。$\sigma$-正则/奇异是 $\alpha_\sigma^0$ 相对于 $\tau_\sigma$ 的量级关系，不是绝对二分——这对应命题 2.6（路由分辨率极限）的决策边界死锁机制。

#### 定义 9.2（$f$-正则性——链纤维吸收半径）

设 $\sigma$ 在 $\mathcal{X}(r_i)$ 上 $\sigma$-正则。$\Phi$ 在每个路由分区 $U_\alpha$ 内由确定的 $f$-chain 给出，记为 $\hat{f}_\alpha$。$\hat{f}_\alpha$ 是连续值映射，其纤维结构由 §7.1 的 $\varepsilon$-吸收半径刻画。

在给定 $\tau_f$ 下，用 $\underline{\alpha}^{\tau_f}_{\hat{f}_\alpha}$——$\hat{f}_\alpha$ 在 $U_\alpha$ 上的最小 $\tau_f$-吸收半径——判断信息保持/坍缩：

- **$f$-退化**：$\underline{\alpha}^{\tau_f}_{\hat{f}_\alpha} \geq \tau_f$——$\hat{f}_\alpha$ 的 $\tau_f$-纤维覆盖了 $\tau_f$-球，输入的 $\tau_f$-扰动被纤维吸收，输出 $\tau_f$-不可区分。
- **$f$-正则**：$\underline{\alpha}^{\tau_f}_{\hat{f}_\alpha} < \tau_f$——$\hat{f}_\alpha$ 的 $\tau_f$-纤维不足以覆盖 $\tau_f$-球，输入的 $\tau_f$-扰动产生 $\tau_f$-可区分的输出。

> **注（判据的纤维统一）**：$\sigma$-正则性和 $f$-正则性是**同一个纤维工具**（§7.1 吸收半径）在不同映射上的实例：$\sigma$ 为离散值映射，使用精确纤维（$\varepsilon = 0$）；$\hat{f}_\alpha$ 为连续值映射，使用 $\varepsilon$-纤维（$\varepsilon = \tau_f$）。由命题 7.2（分辨率-吸收界），$\underline{\alpha}^{\tau_f} \geq \tau_f$ 蕴含纤维膨胀 $\mathrm{FI}_{\tau_f}$ 有非平凡下界——吸收半径越大，计算多样性越低。

---

### 9.2 三态分类

$\sigma$-正则性与 $f$-正则性的独立组合将每个路由分区的拟合行为分为三种形态。分类对象是单个路由分区 $U_\alpha$，而非 $\mathcal{X}(r_i)$ 整体——$\mathcal{X}(r_i)$ 是各分区形态的马赛克。

#### 定义 9.3（三态分类）

设 $U_\alpha$ 为 $\mathcal{X}(r_i)$ 中的一个路由分区，$\hat{f}_\alpha$ 为其上的 $f$-chain。在给定 $(\tau_\sigma, \tau_f)$ 下，$U_\alpha$ **精确地**属于以下三态之一：

- **碎裂态**：$\underline{\alpha}_\sigma^0(U_\alpha) < \tau_\sigma$。分区的路由纤维太薄，$\tau_\sigma$-扰动可穿越分区边界。
- **收缩态**：$\underline{\alpha}_\sigma^0(U_\alpha) \geq \tau_\sigma$ 且 $\underline{\alpha}^{\tau_f}_{\hat{f}_\alpha} \geq \tau_f$。路由稳定且纤维厚——$\tau_f$-扰动被纤维吸收。
- **保持态**：$\underline{\alpha}_\sigma^0(U_\alpha) \geq \tau_\sigma$ 且 $\underline{\alpha}^{\tau_f}_{\hat{f}_\alpha} < \tau_f$。路由稳定且纤维薄——$\tau_f$-扰动产生可区分输出。

三个条件互斥且穷尽：第一条与后两条由 $\underline{\alpha}_\sigma^0$ 与 $\tau_\sigma$ 的大小关系二分，后两条由 $\underline{\alpha}^{\tau_f}$ 与 $\tau_f$ 的大小关系二分。任一 $U_\alpha$ 必然落入且仅落入其中一类。

#### 定义 9.4（整体形态）

设 $\mathcal{X}(r_i)$ 的路由分区集为 $\{U_\alpha\}_{\alpha \in \mathcal{I}_i}$，各分区形态由定义 9.3 确定。称 $\mathcal{X}(r_i)$ 处于：

- **一致碎裂**（Uniformly Fragmented）：$\forall \alpha \in \mathcal{I}_i$，$U_\alpha$ 碎裂。
- **一致收缩**（Uniformly Contractive）：$\forall \alpha \in \mathcal{I}_i$，$U_\alpha$ 收缩。
- **一致保持**（Uniformly Preserving）：$\forall \alpha \in \mathcal{I}_i$，$U_\alpha$ 保持。
- **混合态**（Mixed）：分区形态不一致。

碎裂态意味着量级 $\tau_\sigma$ 的上游误差足以穿越路由边界。由命题 8.7（扰动的上下游分解），路由跳变的端到端代价为下游 Lip 乘积与完全不同基函数之间算子距离的乘积——不受约束。收缩态分区上纤维膨胀大，在链中充当吸收壁（命题 8.8），但同时损失输出多样性（命题 7.2）。保持态分区在链中传递信息而不退化输出多样性，是支持深链复合的标准域。

| 形态 | $\sigma$（尺度 $\tau_\sigma$） | $f$（尺度 $\tau_f$） | 链中角色 |
|---|---|---|---|
| **碎裂** | 奇异 ($\underline{\alpha}_\sigma^0 < \tau_\sigma$) | （不约束） | 路由跳变，链断裂 |
| **收缩** | 正则 ($\underline{\alpha}_\sigma^0 \geq \tau_\sigma$) | 退化 ($\underline{\alpha}^{\tau_f} \geq \tau_f$) | 吸收壁，深度受限 |
| **保持** | 正则 ($\underline{\alpha}_\sigma^0 \geq \tau_\sigma$) | 正则 ($\underline{\alpha}^{\tau_f} < \tau_f$) | 信息传递，支持深链 |

> **注（部分坍缩）**：保持态允许存在局部坍缩区域——$\underline{\alpha}^{\tau_f} < \tau_f$ 是最小值判据，不排除部分点的吸收半径接近 $\tau_f$。

> **注（碎裂态的本质与过拟合的区分）**：碎裂态可理解为 $\sigma$ 的路由分区与目标 $r_i$ 的纤维结构之间的冲突（§7.7）——$\sigma$ 将需要被同一 $f$-chain 处理的点分割到不同路由。这与过拟合不同：过拟合是保持/收缩态在采样集支撑不足时的泛化不足（$\sigma$ 和 $\Phi$ 均正则，但纤维扩散覆盖不广），而碎裂态是 $\sigma$ 自身的结构性奇异化。前者是"覆盖不够"，后者是"根本不是覆盖"。

---

### 9.3 拟合几何与容量约束

三态分类确定了拟合行为的定性形态。本节考察三态在度量空间中的**几何表现**以及在有限路由容量中的**竞争约束**。

#### 拟合域的直径界

**命题 9.5（拟合域直径界）**：设 $r_i$ 在 $\mathcal{X}(r_i)$ 上满足 co-Lipschitz 下界 $k_i > 0$（即 $d(r_i(x), r_i(y)) \geq k_i \cdot d(x,y)$）。定义 $\tau'$-拟合域 $P_{\tau'}(r_i) = \{x \in \mathcal{X}(r_i) : d(\Phi(x), r_i(x)) < \tau'\}$。则 $P_{\tau'}(r_i)$ 中任意两点 $x, y$ 满足：

$$d(x, y) \;\leq\; \frac{\mathrm{diam}(\Phi(\mathcal{X}(r_i))) + 2\tau'}{k_i}$$

**证明**：取 $P_{\tau'}$ 中两点 $x, y$。

(1) 由 $r_i$ 的 co-Lip 性：

$$d(r_i(x), r_i(y)) \;\geq\; k_i \cdot d(x, y) \tag{co-Lip}$$

(2) 由拟合条件 $d(\Phi(x), r_i(x)) < \tau'$、$d(\Phi(y), r_i(y)) < \tau'$ 及三角不等式：

$$d(r_i(x), r_i(y)) \;\leq\; d(r_i(x), \Phi(x)) + d(\Phi(x), \Phi(y)) + d(\Phi(y), r_i(y))$$
$$<\; \tau' + d(\Phi(x), \Phi(y)) + \tau'$$

移项得：

$$d(r_i(x), r_i(y)) \;<\; d(\Phi(x), \Phi(y)) + 2\tau' \tag{$\star$}$$

(3) $\Phi(x), \Phi(y) \in \Phi(\mathcal{X}(r_i))$，故：

$$d(\Phi(x), \Phi(y)) \;\leq\; \mathrm{diam}(\Phi(\mathcal{X}(r_i))) \tag{$\star\star$}$$

(4) 联合 (co-Lip)、($\star$)、($\star\star$)：

$$k_i \cdot d(x, y) \;\leq\; d(r_i(x), r_i(y)) \;<\; d(\Phi(x), \Phi(y)) + 2\tau' \;\leq\; \mathrm{diam}(\Phi(\mathcal{X}(r_i))) + 2\tau'$$

解得 $d(x, y) \leq (\mathrm{diam}(\Phi(\mathcal{X}(r_i))) + 2\tau') / k_i$。$\square$

> **注（三态下的拟合域几何）**：命题 9.5 的直径界对任何形态成立——它约束 $P_{\tau'}$ 的外部包络。三态的差异在于包络内部的结构：
>
> | 形态 | $P_{\tau'}$ 内部结构 | 几何图像 |
> |---|---|---|
> | 碎裂 | 被切成直径 $\leq w$ 的碎片散布其中 | 离散窄槽（$w \to 0$ 时碎片极小） |
> | 收缩 | 路由稳定，不被路由边界切割，但输出多样性受压（命题 9.6） | 钝化盆地（拟合准但信号退化） |
> | 保持 | 路由稳定，不被路由边界切割，输出多样性天花板高（命题 9.7） | 有效通道（拟合准且信号保持） |

#### $\sigma$-正则态的计算多样性对比

收缩态与保持态共享 $\sigma$-正则性，其分野在于 $\hat{f}_\alpha$ 的纤维厚度对输出多样性的约束。

**命题 9.6（收缩态的计算多样性上界）**：设 $U_\alpha$ 处于收缩态（$\underline{\alpha}^{\tau_f}_{\hat{f}_\alpha} \geq \tau_f$）。则 $\hat{f}_\alpha$ 在 $U_\alpha$ 上的 $\tau_f$-计算多样性满足：

$$\mathrm{CD}_{\tau_f}(\hat{f}_\alpha(U_\alpha)) \;\leq\; N_{\tau_f}(U_\alpha)$$

**证明**：

(1) 收缩态意味着对所有 $x \in U_\alpha$，$B(x, \tau_f) \cap U_\alpha \subseteq \mathfrak{F}^{\tau_f}(\hat{f}_\alpha(x))$——$\tau_f$-球内所有点输出 $\tau_f$-不可区分。

(2) 因此，若 $d(x, y) \leq \tau_f$，则 $d(\hat{f}_\alpha(x), \hat{f}_\alpha(y)) \leq \tau_f$。即 $\tau_f$-输入球的像包含在单个 $\tau_f$-输出类中。

(3) 设 $\{B(x_k, \tau_f)\}_{k=1}^{N}$ 为 $U_\alpha$ 的一个 $\tau_f$-覆盖（$N = N_{\tau_f}(U_\alpha)$）。由 (2)，同一覆盖球内的所有点输出 $\tau_f$-不可区分，因此不同的 $\tau_f$-可区分输出至多来自不同的覆盖球。故 $\mathrm{CD}_{\tau_f} \leq N$。$\square$

**命题 9.7（保持态的多样性优势）**：设 $U_\alpha$ 处于保持态（$\underline{\alpha}^{\tau_f}_{\hat{f}_\alpha} < \tau_f$）。则：

$$\mathrm{CD}_{\tau_f}(\hat{f}_\alpha(U_\alpha)) \;\leq\; N_{\underline{\alpha}^{\tau_f}}(U_\alpha)$$

其中 $\underline{\alpha}^{\tau_f} = \underline{\alpha}^{\tau_f}_{\hat{f}_\alpha} < \tau_f$。由覆盖数关于半径的单调递减性：

$$N_{\underline{\alpha}^{\tau_f}}(U_\alpha) \;\geq\; N_{\tau_f}(U_\alpha)$$

故保持态的多样性天花板**严格不低于**收缩态。$\underline{\alpha}^{\tau_f}$ 越小（纤维越薄），天花板越高。$\square$

> **注（纯度量对比）**：收缩态的每个输入点都被厚纤维覆盖，输出多样性被压至 $N_{\tau_f}(U_\alpha)$。保持态纤维薄，上界放宽到 $N_{\underline{\alpha}^{\tau_f}}(U_\alpha)$。这是不依赖测度的“收缩态低多样性 vs 保持态高多样性”的纯度量刻画。

#### 容量约束与碎裂惩罚

三态在有限路由预算 $|\mathrm{Im}(\sigma)| \leq M^\mathcal{D}$ 中构成零和博弈：碎裂态每占据一条路由分支，就从 $\sigma$-正则态的可用容量中扣除一条。

**命题 9.8（碎裂态的单调惩罚）**：设路由总数 $N = |\mathrm{Im}(\sigma)|$ 固定。记 $\Sigma(\geq N_F)$ 为碎裂态路由分支数不低于 $N_F$ 的所有可行路由配置集合，$\varepsilon^*_{r_i}(N_F) = \inf_{\sigma \in \Sigma(\geq N_F)} \varepsilon_{r_i}(\sigma)$。则对 $N_F^{(1)} > N_F^{(2)}$：

$$\varepsilon^*_{r_i}(N_F^{(1)}) \;\geq\; \varepsilon^*_{r_i}(N_F^{(2)})$$

**证明**：

(1) $N_F^{(1)} > N_F^{(2)}$ 给出可行集包含关系：$\Sigma(\geq N_F^{(1)}) \subseteq \Sigma(\geq N_F^{(2)})$。

(2) 下确界在子集上不低于超集上：$\inf_{\Sigma(\geq N_F^{(2)})} \varepsilon_{r_i} \leq \inf_{\Sigma(\geq N_F^{(1)})} \varepsilon_{r_i}$。$\square$

**推论 9.9（保持态最优方向）**：固定 $N$ 和 $N_F$，系统误差理论下界随收缩态分支数 $N_C$ 单调非减（证明与命题 9.8 同构）。由 $N_P = N - N_F - N_C$，误差下界随 $N_P$ 增大而单调非增。因此一致保持配置 $N_P = N$（$N_C = N_F = 0$）定义了系统的**形态最优方向**。

---

### 9.4 链内形态传播

在 $f$-chain $\hat{f} = f_{i_k} \circ \cdots \circ f_{i_1}$ 中，各步可能处于不同形态。根据形态序列的组成，将复合链分为三类：

- **$F$-链**：链中包含碎裂步（$\exists\, j$，步 $j$ 处于碎裂态）。链在碎裂步处断裂。
- **$C$-链**：链不含碎裂步但包含收缩步。链可运行但信号在收缩步处退化。
- **$P$-链**：链中每一步都处于保持态。信号在全链上保持 $\tau_f$-可区分性——$P$-链是唯一不丧失分辨率的链类型。

以下用 §8 的工具分析各类链的行为。

#### 复合稳定半径

**命题 9.10（复合稳定半径）**：设 $\Phi^l$ 为 $l$-步复合（$\sigma$-正则），$\varepsilon^*_q$ 为 §3 CAC 定理给出的宏观容差上界，$\tau' > 0$ 为拟合容差。若 $\varepsilon^*_q < \tau'$，则对 $x_0 \in P_{\tau'}(r_i)$，$\rho$-扰动后 $l$ 步复合的总误差仍 $\leq \tau'$，其中：

$$\rho_l \;\geq\; \frac{\tau' - \varepsilon^*_q}{L^l} \;>\; 0$$

**证明**：设 $x_0 \in P_{\tau'}(r_i)$，$\rho$-扰动得 $x_0'$（$d(x_0, x_0') \leq \rho$）。

(1) 由 $\Phi^l$ 的 Lip 性：$d(\Phi^l(x_0'), \Phi^l(x_0)) \leq L^l \cdot \rho$。

(2) 由 CAC 上界：$d(\Phi^l(x_0), r_i(x_0)) \leq \varepsilon^*_q$。

(3) 三角不等式：

$$d(\Phi^l(x_0'), r_i(x_0)) \;\leq\; L^l \cdot \rho + \varepsilon^*_q$$

令此 $\leq \tau'$，解得 $\rho \leq (\tau' - \varepsilon^*_q) / L^l$。$\square$

> **注**：$\rho_l$ 随 $l$ 以 $L^{-l}$ 指数衰减。在保持态（$P$-链）下此量有物理意义（链稳定运行），在收缩态（$C$-链）下 $\rho_l > 0$ 只意味着"扰动不恶化误差"，但信号已因纤维坍缩而退化。

#### 收缩步的信息不可逆丧失

**命题 9.11（收缩步的信息不可逆丧失）**：设链中步 $\phi_m$ 经过收缩态分区 $U_\alpha$（$\underline{\alpha}^{\tau_f}_{\hat{f}_\alpha} \geq \tau_f$）。则 $U_\alpha$ 内存在输入对 $(x, y)$，$d(x,y) \geq \tau_f$，被 $\phi_m$ 坍缩为 $d(\phi_m(x), \phi_m(y)) \leq \tau_f$。若后续步 $\phi_{m+1}, \ldots, \phi_{m+k}$ 均经过保持态分区，则这些坍缩的差异不可被恢复。

**证明**：

(1) 收缩态 $\underline{\alpha}^{\tau_f}_{\hat{f}_\alpha} \geq \tau_f$ 意味着对所有 $x \in U_\alpha$：

$$B(x, \tau_f) \cap U_\alpha \;\subseteq\; \mathfrak{F}^{\tau_f}(\Phi(x))$$

即 $\tau_f$-邻域内所有点的输出与 $x$ 的输出 $\tau_f$-不可区分。

(2) 取 $y \in U_\alpha$ 使 $d(x, y) = \tau_f$（$U_\alpha$ 的 $\sigma$-正则保证分区直径 $\geq 2\tau_\sigma$，当 $\tau_\sigma \geq \tau_f$ 时此 $y$ 存在）。由 (1)，$d(\Phi(x), \Phi(y)) \leq \tau_f$——$\tau_f$-可区分的输入对被坍缩为 $\tau_f$-不可区分的输出对。

(3) 后续保持态分区的 $\underline{\alpha}^{\tau_f} < \tau_f$ 保证纤维不覆盖 $\tau_f$-球——但这只意味着"存在未被坍缩的方向"，不意味着"放大已坍缩的差异"。已坍缩至 $\leq \tau_f$ 的输入对在后续分区的 $\tau_f$-纤维内部或边缘，不存在将其系统性放大回 $> \tau_f$ 的机制。$\square$

若 $C$-链中收缩步的输出像集多样性受限（命题 7.2），后续步若要恢复输出复杂度，由命题 8.10 需要 $L_{\phi_{m+1}}$ 足够大——但大 $L$ 同时放大误差（命题 8.1）。另一方面，保持态步不吸收 $\tau_f$-尺度误差，但由命题 8.8（像集限制下的吸收），上游保持步对像集的压缩仍能促进下游步在受限像集上的吸收。

#### 收缩-保持平衡

链中收缩步越多，吸收能力越强但有效深度越短（定理 7.10 的分辨率预算消耗越快）；保持步越多，深度越深但吸收越弱。两者之间的平衡由分辨率预算和目标的输出复杂度共同决定——这是命题 7.2 和 8.10 的三约束在链中的逐步实现。$P$-链是**唯一使分辨率预算衰减最慢**的链类型，因此是复合计算的最优信道。

----
*[IDFS] ⊢ [GLENZLI] ⊢ [Part 03] ⊢ [09-fitting-morphology] ⊢ [664a92ea9e0407d6]*
