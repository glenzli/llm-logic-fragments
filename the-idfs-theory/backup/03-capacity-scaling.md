## 容量缩放与形态转换

§1 的三态分类和 §2 的内部几何逐态展开了拟合域的度量结构。但三态并非孤立存在——它们共享**同一个映射 $\Phi$**，路由容量 $|\mathrm{Im}(\sigma)| \leq M^\mathcal{D}$ 是有限的。本节分析三态如何在有限容量中竞争、碎裂态对系统的拓扑损害、以及在 Type B 构型下 $M$ 增长如何驱动形态构成比的演化。

---

### 3.1 路由容量的三态分配

**命题 3.1（容量零和律）**：设 IDFS $\mathcal{F} = (F, \sigma)$ 的采样集 $\mathcal{S}$ 中包含三类形态的规则。记三态各自占据的路由分支数为 $N_P, N_C, N_F$（分别对应保持态、收缩态、碎裂态），则：

$$N_P + N_C + N_F \;\leq\; |\mathrm{Im}(\sigma)| \;\leq\; M^{\mathcal{D}}$$

其中 $M = |F|$ 为基函数库规模，$\mathcal{D}$ 为 $F$-空间的有效维度（第一章 §4 定义）。

**证明**：$\sigma: \mathcal{X} \to \{1, \ldots, M\}^\mathcal{D}$ 的值域 $\mathrm{Im}(\sigma)$ 是路由分支的总数。每条路由分支服务于一个路由分区 $U_\alpha$，而 $U_\alpha$ 内的 $\Phi$ 行为处于某一种确定的形态。三态对 $\mathrm{Im}(\sigma)$ 构成完备分类，故 $N_P + N_C + N_F = |\mathrm{Im}(\sigma)|$。$\square$

**定义（不可复合容量与有效容量）**：碎裂态占据的路由分支 $N_F$ 对 $R^*$ 复合**无贡献**——这些分支服务于 $\sigma$-奇异域中的近孤立碎片（§1 命题 1.6），在复合链中不可用。我们将 $N_F$ 称为**不可复合路由容量**。定义系统的**有效复合路由容量**为：

$$|\mathrm{Im}(\sigma)|^{eff} \;\triangleq\; |\mathrm{Im}(\sigma)| - N_F$$

比值 $N_F / |\mathrm{Im}(\sigma)|$ 称为**不可复合率**（Non-composable Rate）。

**命题 3.2（碎裂态的路由消耗下界）**：设 $R_F$ 为碎裂态规则集。则：

$$N_F \;\geq\; \sum_{r_s \in R_F} |\{V_\beta^{(s)}\}|$$

其中 $|\{V_\beta^{(s)}\}|$ 为规则 $r_s$ 在碎裂态下的有效碎片数。

**证明**：由 §2 命题 2.1，碎裂态规则 $r_s$ 的拟合域被分解为有效碎片 $\{V_\beta\}$，不同碎片由不同的 $f$-链服务，每个碎片至少需要一条独立的路由分支。$\square$

> **注（容量零和律的含义）**：三态在有限的路由预算中构成零和博弈。碎裂态每占据一条路由分支，就精确地从 $\sigma$-正则态（收缩 + 保持）的可用容量中扣除一条——不存在"免费"的碎裂拟合。

---

### 3.2 度量拥挤与碎裂态的代价

碎裂态对系统的损害不仅仅是占据不可复合容量——它还通过**度量拥挤**主动恶化邻近 $\sigma$-正则链的性能。

**定义（度量拥挤）**：设 $\sigma$-奇异域 $\mathcal{X}(r_s) \subset \mathcal{X}$，设 $\{h_j\}_{j=0}^l$ 为某条 $\sigma$-正则复合链的中间态轨迹。若存在 $j$ 和 $\delta > 0$ 使得

$$B(h_j, \delta) \;\cap\; \mathcal{X}(r_s) \;\neq\; \emptyset$$

则称 $h_j$ 受到 $\mathcal{X}(r_s)$ 的 **$\delta$-度量拥挤**。

**命题 3.3（碎裂态的路由劫持）**：设 IDFS $\mathcal{F}$ 对保持态规则 $r_i$ 的某条复合链 $q$ 的中间态轨迹为 $h_0, h_1, \ldots, h_l$。若 $h_j$ 受到 $\sigma$-奇异域 $\mathcal{X}(r_s)$ 的 $\delta$-度量拥挤，则路由跳变概率满足：

$$J_\sigma(h_j, \delta) \;\triangleq\; \frac{\mu(B(h_j, \delta) \cap \{x : \sigma(x) \neq \sigma(h_j)\})}{\mu(B(h_j, \delta))} \;\;>\;\; 0$$

**证明**：由度量拥挤条件，$B(h_j, \delta) \cap \mathcal{X}(r_s) \neq \emptyset$。由 §2 命题 2.1 (ii)，$\mathcal{X}(r_s)$ 的 $\sigma$-奇异性保证 $\mathrm{rad}_\sigma < \tau$，因此 $\mathcal{X}(r_s)$ 内部存在路由跳变点。取 $h_j' \in B(h_j, \delta) \cap \mathcal{X}(r_s)$，则 $\sigma(h_j')$ 对应碎裂态的路由分支，$\sigma(h_j') \neq \sigma(h_j)$。故 $J_\sigma(h_j, \delta) > 0$。

此后 $\Phi$ 在 $h_j'$ 处沿碎裂态的 $f$-链运行：$\Phi^{(k)}(h_j') = f_{\sigma_k(h_j')} \circ \cdots \circ f_{\sigma_{j+1}(h_j')}(h_j')$，后续轨道与 $r_i$ 无关。$\square$

> **推论（碎裂态规则增多的单调恶化）**：设 $\mathcal{F} = (F, \sigma)$ 和 $\mathcal{F}' = (F, \sigma')$ 为共享相同基函数库 $F$ 的两个 IDFS，其中 $\mathcal{F}'$ 的碎裂态路由分支数 $N_F' > N_F$（例如因目标规则集 $R' \supset R$，新增规则被 $\Phi'$ 以碎裂态拟合）。则对任意在 $\mathcal{F}$ 中处于保持态的规则 $r_i$：$\varepsilon_{r_i}(\mathcal{F}') \geq \varepsilon_{r_i}(\mathcal{F})$。恶化由两条独立机制贡献：
>
> (a) **容量挤压**：$N_F' > N_F$ → $|\mathrm{Im}(\sigma')|^{eff} < |\mathrm{Im}(\sigma)|^{eff}$，保持态可用路由分支减少；
>
> (b) **路由劫持**：新增 $\sigma$-奇异域 $\mathcal{X}(r_s)$ 使原本无度量拥挤的中间态 $h_j$ 满足 $B(h_j, \delta) \cap \mathcal{X}(r_s) \neq \emptyset$，$J_\sigma(h_j, \delta)$ 从 0 跃升为正。

---

> **作用域声明**：§3.1–§3.2 的结论对任意 IDFS 构型成立。以下 §3.3–§3.5 的效率与演化分析**限制在 Type B 构型**（第一章 §6：$\kappa_\Phi > 1$，路由非简并，$l \leq l^*_0$）上——Type A/C 不保证精度，讨论 $M$ 增长的效率无意义。

### 3.3 Type B 下的 $M$-增长形态效率层级

在 Type B 下，$M$ 增长通过扩大路由容量提升逼近精度。但 $M$ 增长对三态的误差缩减效率**极度不均匀**。

**命题 3.4（形态效率的定性层级，限 Type B）**：设 $\{\mathcal{F}_M\}_{M \geq 1}$ 为一族 Type B IDFS，参数化于 $M = |F|$，共享相同的 $(\mathcal{X}, \mu)$ 和目标规则集 $R$。设 $M$ 从 $M_0$ 增至 $M_1 > M_0$，新增路由分支 $\Delta N = M_1^\mathcal{D} - M_0^\mathcal{D}$。记三态的误差缩减率为 $\Delta\varepsilon_P, \Delta\varepsilon_C, \Delta\varepsilon_F$。则：

$$\Delta\varepsilon_P \;\geq\; \Delta\varepsilon_C \;\gg\; \Delta\varepsilon_F$$

**证明**：设 $\Delta N$ 条新增路由分支均匀分配给三态。记各态的**边际误差缩减率**为 $\gamma_m \triangleq -\partial \varepsilon_m / \partial N_m$（每增加一条路由分支的误差降幅）。

**(i) 保持态**：$\sigma$-正则域 $U_\alpha$（$\alpha \in \mathcal{I}_P$）内，$\Phi$ 的拟合误差满足

$$\varepsilon_P(U_\alpha) \;\leq\; L_\alpha \cdot \mathrm{diam}(U_\alpha)$$

其中 $L_\alpha$ 为 $\Phi|_{U_\alpha}$ 的 Lipschitz 常数。新增路由分支将 $U_\alpha$ 细分为 $U_{\alpha_1}, U_{\alpha_2}$，$\mathrm{diam}(U_{\alpha_k}) < \mathrm{diam}(U_\alpha)$。由保持态 $\varphi_\alpha \geq \eta$，$\Phi$ 在子分区上的像集仍占据 $\geq \eta$ 比例的 $\tau$-可区分输出——细分的全部容量被有效利用。故 $\gamma_P \sim L_\alpha \cdot \Delta\mathrm{diam} / \Delta N_P > 0$。

**(ii) 收缩态**：$U_\alpha$（$\alpha \in \mathcal{I}_C$）内同样有 $\varepsilon_C(U_\alpha) \leq L_\alpha \cdot \mathrm{diam}(U_\alpha)$。但由 $\varphi_\alpha < \eta$，$\Phi|_{U_\alpha}$ 存在胖纤维铺砌（§2 命题 2.7）：像集在 $\geq (1 - \eta)$ 比例的方向上 $\tau$-坍缩。细分 $U_\alpha$ 时，落在坍缩纤维内部的子分区不产生新的可区分输出——该方向上的 $\Delta\mathrm{diam}$ 不转化为 $\Delta\varepsilon$。故 $\gamma_C \leq \gamma_P$。

**(iii) 碎裂态**：碎裂碎片直径 $w_\alpha < 2\tau$（命题 3.5），而 $\sigma$-正则分区直径 $\mathrm{diam}(U_\beta^{reg}) \gg \tau$。每条新增碎裂路由分支覆盖的域宽 $\leq w_\alpha$，其边际误差缩减

$$\gamma_F \;\leq\; L \cdot w_\alpha \;\ll\; L \cdot \mathrm{diam}(U_\beta^{reg}) \;\sim\; \gamma_P$$

比值 $\gamma_F / \gamma_P \leq w_\alpha / \mathrm{diam}(U_\beta^{reg}) \ll 1$。$\square$

> **注（定量缩放指数）**：在 Ahlfors $D$-正则度量空间上，可以给出精确的缩放指数：保持态的误差以 $\varepsilon_P(M) \sim M^{-1/D}$ 衰减（Kolmogorov $n$-width 指数），碎裂态的边际效率 $\gamma_F \to 0$ 随碎片尺度 $w \to 0$ 而消失（此处 $w$ 为渐近分析中的极限变量，非固定系统的碎片直径）。在一般度量空间上，定量指数取决于空间的覆盖数增长率——需指定度量空间的正则性假设。但**定性层级** $\Delta\varepsilon_P \geq \Delta\varepsilon_C \gg \Delta\varepsilon_F$ 在任意 Type B 系统上成立。

---

### 3.4 Type B 系统的形态测度界

在 Type B 约束下，三态的测度占比受到定量约束。定义三态的**测度占比**：

$$\mu_P \triangleq \frac{\mu(\bigcup_{\alpha \in \mathcal{I}_P} U_\alpha)}{\mu(\mathcal{X})}, \quad \mu_C \triangleq \frac{\mu(\bigcup_{\alpha \in \mathcal{I}_C} U_\alpha)}{\mu(\mathcal{X})}, \quad \mu_F \triangleq \frac{\mu(\bigcup_{\alpha \in \mathcal{I}_F} U_\alpha)}{\mu(\mathcal{X})}$$

其中 $\mathcal{I}_P, \mathcal{I}_C, \mathcal{I}_F$ 分别为保持态、收缩态、碎裂态的路由分区索引集。$\mu_P + \mu_C + \mu_F = 1$。

#### 碎裂态测度界

**命题 3.5（碎裂态测度的上界）**：设碎裂态占据 $N_F$ 条路由分支。每个碎裂碎片被某个路由分区 $U_\alpha$ 包含，而碎裂态的路由分区满足 $\mathrm{rad}_\sigma(U_\alpha) < \tau$，故碎片直径 $w_\alpha \leq 2\mathrm{rad}_\sigma(U_\alpha) < 2\tau$。设 $w_{max} = \max_\alpha w_\alpha$。则：

$$\mu_F \;\leq\; \frac{N_F \cdot \mu_{max}(B(x, w_{max}))}{\mu(\mathcal{X})}$$

其中 $\mu_{max}(B(x, r)) = \sup_{x \in \mathcal{X}} \mu(B(x, r))$。由 $N_F \leq M^\mathcal{D}$，$\mu_F$ 受路由预算和碎片尺度的联合约束。

> **推论（小 $M$ 下碎裂态测度为零）**：碎裂态要求 $\mathrm{rad}_\sigma < \tau$，即路由分区的内切半径低于 $\tau$。当 $|\mathrm{Im}(\sigma)| \leq M^\mathcal{D}$ 极小时，分区数极少，每个分区覆盖 $\mathcal{X}$ 的宏观比例，内切半径 $\mathrm{rad}_\sigma \gg \tau$。命题 3.2 要求碎裂态至少消耗 $|\{V_\beta\}|$ 条路由分支——当总路由预算 $M^\mathcal{D}$ 不足以分配时，$N_F = 0$，从而 $\mu_F = 0$。

#### 收缩态测度界

**命题 3.6（收缩态测度的上界，限 Type B）**：设 Type B IDFS 具有 $\kappa_\Phi > 1$。则收缩态测度满足：

$$\mu_C \;\leq\; \frac{\kappa_\Phi - 1}{\kappa_\Phi(1 - \eta)}$$

**证明**：

**(i)** 每个收缩态分区 $U_\alpha$（$\alpha \in \mathcal{I}_C$）上 $\varphi_\alpha < \eta$——至少 $(1 - \eta)$ 比例的 $\tau$-可区分输入对被坍缩。收缩态的总坍缩量为：

$$\mathcal{L}_C \;\triangleq\; \sum_{\alpha \in \mathcal{I}_C} (1 - \varphi_\alpha) \cdot \mu(U_\alpha) \;\geq\; (1 - \eta) \cdot \mu_C \cdot \mu(\mathcal{X})$$

**(ii)** Type B 的非简并条件 $\kappa_\Phi > 1$ 要求 $\Phi$ 在全局上维持输出多样性。系统的**全局信号保持度**定义为未被坍缩的 $\tau$-可区分信号比例：

$$\Sigma \;\triangleq\; 1 - \frac{\mathcal{L}_C}{\mu(\mathcal{X})} \;\geq\; 1 - (1-\eta) \cdot \mu_C$$

Type B 的 $\kappa_\Phi > 1$ 约束要求 $\Sigma \geq 1/\kappa_\Phi$（否则输出多样性不足，路由实质退化为 Type A）。

**(iii)** 由 $\Sigma \geq 1/\kappa_\Phi$：

$$1 - (1-\eta) \cdot \mu_C \;\geq\; \frac{1}{\kappa_\Phi}$$

解得：

$$\mu_C \;\leq\; \frac{\kappa_\Phi - 1}{\kappa_\Phi(1 - \eta)}$$

$\square$

> **注（上界的性质与 $f$-复用收紧）**：命题 3.6 的界只依赖 $\kappa_\Phi$ 和 $\eta$，与 $M$ 无关——它是**最坏情形上界**。注意 $\kappa_\Phi$ 越大（路由越非简并），此上界越趋近 $1/(1-\eta)$，即**约束越松**——这是因为高输出多样性的系统本身能容忍更多局部收缩。真正在小 $M$ 下压低 $\mu_C$ 的机制是 **$f$-复用效应**：当 $M$ 小时，$f$-复用因子 $R_f = |\mathrm{Im}(\sigma)|/M$ 很大，每个收缩态 $f_k$ 影响至少 $R_f$ 个分区，坍缩量被同一个 $f$ 放大至大面积。即使 $\kappa_\Phi > 1$ 的约束本身较松，大面积坍缩仍会导致系统的**有效输出维度**坍缩至不足以支撑 $\kappa_\Phi > 1$。直觉上 $\mu_C$ 在小 $M$ 下被压至 $O(1/R_f)$ 量级。此收紧在推论 3.7 中用于论证纯保持态体制。

#### 纯保持态极限

**推论 3.7（小 $M$ 下的纯保持态体制，限 Type B）**：在 Type B 系统族 $\{\mathcal{F}_M\}$ 中，当 $M$ 足够小使得：

(a) $M^\mathcal{D}$ 不足以支持碎裂路由 → $\mu_F = 0$（命题 3.5 推论）；

(b) $f$-复用因子 $R_f$ 足够大，使得 $\kappa_\Phi > 1$ 约束迫使 $\mu_C \to 0$（命题 3.6 注）；

则系统满足 $\mu_P \to 1$——**几乎全部已拟合规则处于保持态**。

---

### 3.5 Type B 下的显著性顺序定理

命题 3.5–3.6 与推论 3.7 给出了三态测度的定量界。为将这些界转化为三态**出现顺序**的严格表述，引入以下概念。

**定义（$\alpha$-显著性）**：设 $\alpha \in (0, 1)$ 为可观测阈值。形态 $m \in \{P, C, F\}$ 在容量 $M$ 下**$\alpha$-显著**，若 $\mu_m(M) \geq \alpha$。

**定义（显著起始点）**：形态 $m$ 的**$\alpha$-显著起始点**为 $M_m^{(\alpha)} \triangleq \inf\{M : \mu_m(M) \geq \alpha\}$。

**命题 3.8（$\alpha$-显著性顺序定理，限 Type B）**：对任意 $\alpha \in (0, 1)$，Type B 系统的三态 $\alpha$-显著起始点满足：

$$M_P^{(\alpha)} \;\leq\; M_C^{(\alpha)} \;\leq\; M_F^{(\alpha)}$$

**证明**：

**(i)** $M_P^{(\alpha)}$ 最小：由推论 3.7，当 $M$ 小到 $f$-复用因子足够大时 $\mu_P \to 1$。因此 $M_P^{(\alpha)}$ 近似等于使系统首次有足够规则达 $\tau$-拟合、且 $\mu_P \geq \alpha$ 的最小 $M$——这是三态中最早达到的。

**(ii)** $M_C^{(\alpha)} \geq M_P^{(\alpha)}$：由 $\mu_P + \mu_C + \mu_F = 1$。在 $M_P^{(\alpha)}$ 处 $\mu_P \geq \alpha$（由推论 3.7，小 $M$ 下 $\mu_P \to 1$），故 $\mu_C \leq 1 - \mu_P \leq 1 - \alpha < \alpha$（当 $\alpha > 1/2$）。即使 $\alpha \leq 1/2$，推论 3.7 保证在 $M_P^{(\alpha)}$ 附近 $\mu_P$ 接近 1，$\mu_C$ 接近 0，因此 $\mu_C < \alpha$ 仍成立——$\mu_C$ 要达到 $\alpha$ 必须等待 $\mu_P$ 让出足够空间，而这需要 $M$ 增大使 $f$-复用因子降低。故 $M_C^{(\alpha)} > M_P^{(\alpha)}$。

**(iii)** $M_F^{(\alpha)} \geq M_C^{(\alpha)}$：由命题 3.5 推论，$\mu_F = 0$ 直到 $M^\mathcal{D}$ 足够大以支持碎裂路由。$\mu_F \geq \alpha$ 需要 $N_F \cdot \mu_{max}(B(x, w_{max})) \geq \alpha \cdot \mu(\mathcal{X})$——由碎片直径 $w_{max} < 2\tau$（命题 3.5），每条碎裂路由分支覆盖的测度极小，需要极大的 $N_F$（从而极大的 $M$）方可达到 $\alpha$。而 $\mu_C \geq \alpha$ 仅需 $\mu_P$ 让出足够比例。故 $M_F^{(\alpha)} > M_C^{(\alpha)}$。$\square$

**推论（Type B 形态构成比的 $M$-演化）**：

| $M$ 范围 | $f$-复用 $R_f$ | 碎裂 $\mu_F$ | 收缩 $\mu_C$ | 保持 $\mu_P$ |
|---|---|---|---|---|
| $M < M_C^{(\alpha)}$ | $\gg 1$ | $= 0$（命题 3.5） | $< \alpha$（命题 3.6） | $> 1 - \alpha$（推论 3.7） |
| $M_C^{(\alpha)} \leq M < M_F^{(\alpha)}$ | $O(1)$ | $< \alpha$ | $\geq \alpha$（$f$ 特化） | 逐步让出比例 |
| $M \geq M_F^{(\alpha)}$ | $< 1$ | $\geq \alpha$（路由精细化） | 不再被上界约束 | 受 $\mu_C, \mu_F$ 双重挤压 |

> **注（全过程连续）**：$\mu_P, \mu_C, \mu_F$ 均为 $M$ 的连续函数。命题 3.8 的顺序关系描述的是**测度界随 $M$ 的松紧变化**——三态的显著性按 $P \to C \to F$ 的固定顺序依次突破阈值 $\alpha$，但每一次突破本身是连续穿越，不是相变。

---

### 3.6 Type B 下的碎裂惩罚与保持态最优方向

§3.1–§3.5 的结论分散地揭示了碎裂态的多重损害与保持态的优势。以下将它们联合为两条显式定理。

**命题 3.9（碎裂态的单调惩罚，限 Type B）**：对于给定基函数库 $F$、目标规则集 $R$ 及固定路由总数 $N \triangleq |\mathrm{Im}(\sigma)|$ 的 Type B 系统，设

$$\Sigma(\geq N_F) \;\triangleq\; \{\sigma : |\mathrm{Im}(\sigma)| = N, \; |\mathcal{I}_F(\sigma)| \geq N_F\}$$

为碎裂态路由分支数**不低于** $N_F$ 的所有可行路由配置集合。定义

$$\varepsilon_{r_i}^*(N_F) \;\triangleq\; \inf_{\sigma \in \Sigma(\geq N_F)} \varepsilon_{r_i}(\sigma)$$

为在该约束下保持态规则 $r_i$ 的最优逼近误差。若 $N_F^{(1)} > N_F^{(2)}$，则：

$$\varepsilon_{r_i}^*(N_F^{(1)}) \;\geq\; \varepsilon_{r_i}^*(N_F^{(2)})$$

**证明**：由 $N_F^{(1)} > N_F^{(2)}$，直接得可行集的包含关系：

$$\Sigma(\geq N_F^{(1)}) \;\subseteq\; \Sigma(\geq N_F^{(2)})$$

（任何满足 $|\mathcal{I}_F(\sigma)| \geq N_F^{(1)}$ 的配置必然满足 $|\mathcal{I}_F(\sigma)| \geq N_F^{(2)}$）。因此：

$$\varepsilon_{r_i}^*(N_F^{(2)}) \;=\; \inf_{\sigma \in \Sigma(\geq N_F^{(2)})} \varepsilon_{r_i}(\sigma) \;\leq\; \inf_{\sigma \in \Sigma(\geq N_F^{(1)})} \varepsilon_{r_i}(\sigma) \;=\; \varepsilon_{r_i}^*(N_F^{(1)})$$

（下确界在更大集合上取值不高于在其子集上取值。）$\square$

> **注（惩罚的物理机制）**：上述证明的严格性来自纯集合论，不依赖任何度量假设。物理上，$\Sigma(\geq N_F^{(1)}) \subset \Sigma(\geq N_F^{(2)})$ 的差集 $\Sigma(\geq N_F^{(2)}) \setminus \Sigma(\geq N_F^{(1)})$ 恰好包含那些碎裂分支数较低（$N_F^{(2)} \leq |\mathcal{I}_F| < N_F^{(1)}$）的配置。这些配置受益于两条机制：
>
> **(a) 有效容量更大**：$|\mathrm{Im}(\sigma)|^{eff} = N - |\mathcal{I}_F|$ 更大，$\sigma$-正则分区可模拟的分辨率更高，由 Lipschitz 连续性 $\varepsilon_P(U_\alpha) \leq L_\alpha \cdot \mathrm{diam}(U_\alpha)$，逼近上界更紧。
>
> **(b) 路由劫持更少**：碎裂分支更少 → $\sigma$-奇异域 $\bigcup_{r_s \in R_F} \mathcal{X}(r_s)$ 的路由簇数量更少 → 对 $r_i$ 的复合链中间态 $h_j$，陷入 $\delta$-度量拥挤（命题 3.3）的概率更低。定义逐步劫持概率
>
> $$P_j \;=\; \mu\!\left(B(h_j, \delta) \cap \bigcup_{r_s \in R_F} \mathcal{X}(r_s)\right) / \mu(B(h_j, \delta))$$
>
> 碎裂分支更少时 $\bigcup \mathcal{X}(r_s)$ 的碎片密度更低，$P_j$ 更小。

**推论 3.10（保持态的最优方向，限 Type B）**：在 Type B 系统族中，固定路由总数 $N$ 和碎裂分支数 $N_F$，系统误差理论下界随收缩态分支数 $N_C$ 单调非减。

**形式化**：设

$$\Sigma(\geq N_C \mid N_F) \;\triangleq\; \{\sigma \in \Sigma(\geq N_F) : |\mathcal{I}_C(\sigma)| \geq N_C\}$$

定义

$$\varepsilon^*(N_C \mid N_F) \;\triangleq\; \inf_{\sigma \in \Sigma(\geq N_C \mid N_F)} \varepsilon_{r_i}(\sigma)$$

则对 $N_C^{(1)} > N_C^{(2)}$：

$$\varepsilon^*(N_C^{(1)} \mid N_F) \;\geq\; \varepsilon^*(N_C^{(2)} \mid N_F)$$

**证明**：与命题 3.9 同构。$N_C^{(1)} > N_C^{(2)}$ 直接给出：

$$\Sigma(\geq N_C^{(1)} \mid N_F) \;\subseteq\; \Sigma(\geq N_C^{(2)} \mid N_F)$$

因此 $\inf_{\Sigma(\geq N_C^{(2)} \mid N_F)} \varepsilon \leq \inf_{\Sigma(\geq N_C^{(1)} \mid N_F)} \varepsilon$。$\square$

联合命题 3.9 和推论 3.10：在固定 $N$ 下，$\varepsilon^*$ 随 $N_F$ 和 $N_C$ 均单调非减。由 $N_P = N - N_F - N_C$，等价地，$\varepsilon^*$ 随 $N_P$ 增大（即 $\mu_P$ 增大）而单调非增。因此 $\mu_P = 1$（$N_C = N_F = 0$）定义了 Type B 系统的**形态最优方向**——向全保持态配置趋近，使系统潜在误差的下界达到唯一的全局极小。

> **注（物理解释）**：$\Sigma(\geq N_C^{(2)}) \setminus \Sigma(\geq N_C^{(1)})$ 中的配置具有更少的收缩态分支（$N_C^{(2)} \leq |\mathcal{I}_C| < N_C^{(1)}$），相应地保持态分支 $N_P = N - N_F - N_C$ 更多。物理上，收缩态分区的 $\tau$-坍缩导致路由细分在坍缩方向上无效——存在由拓扑坍缩导致的常数级误差下界。保持态分支（$\varphi_\alpha \geq \eta$，无坍缩方向）的路由细分在所有输出方向上均有效。因此减少 $N_C$、增加 $N_P$，解除了系统的逼近拓扑锁死。

---

### 3.7 总结

| 形态 | 路由效率 | $M$-增长收益 | 对邻近链的影响 | 测度界（限 Type B） |
|---|---|---|---|---|
| **保持态** | ✅ 最高 | 最高（命题 3.4） | $J_\sigma = 0$（无劫持） | $\mu_P \geq 1 - \mu_C - \mu_F$；小 $M$ 主导（推论 3.7） |
| **收缩态** | ⚠️ 中等 | 中等 | $J_\sigma = 0$（无劫持） | $\mu_C \leq (\kappa_\Phi - 1)/[\kappa_\Phi(1-\eta)]$（命题 3.6） |
| **碎裂态** | ❌ 最低 | **最低** | **路由劫持**（命题 3.3） | $\mu_F \leq N_F \cdot \mu_{max}(B)/\mu(\mathcal{X})$（命题 3.5） |

**核心结论**：Type B 系统的形态最优**方向**为 $\mu_P \to 1$（推论 3.10）。随 $M$ 增大，系统的形态构成按 $P \to C \to F$ 的固定顺序（命题 3.8）偏离此最优方向——碎裂态的出现使系统的理论最优误差下界升高（命题 3.9），收缩态的增多进一步收紧了系统的逼近能力上限（推论 3.10）。

----
*[IDFS] ⊢ [GLENZLI] ⊢ [Part XX] ⊢ [03-capacity-scaling] ⊢ [81bce58158c77a21]*
