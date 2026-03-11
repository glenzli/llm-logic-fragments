## 受限 IDFS

在 §3 中，CAC 定理给出了宏观误差的上界——系统的端到端误差**不超过** $(\varepsilon_{\max}+\rho_{\max}+\Delta_{\max}) \cdot \Lambda_l + \delta_{\max} \cdot \Gamma_l$（其中 $\rho_{\max}$、$\Delta_{\max}$ 分别为目标域外变分与路由失准惩罚的逐步极值）。在 §4 中，CAB 定理给出了误差的下界——在目标变分足够剧烈时，系统的端到端误差**不低于** $|\Delta - \varepsilon_x| - \Omega_l(\delta)$（$\Omega_l(\delta) = \bar{L}^l\delta + \sum_j \Delta_{\sigma,j}\Theta_{j+1,l}$ 为全链路最大拓扑应变力）。当一个 IDFS 同时面对这两个约束时——既要泛化误差可控（CAC 不爆炸），又要保持对目标的判别能力（CAB 不退化）——系统的核心参数 $\Theta_{j,l}$（路径局部 Lipschitz 乘积）将被双向夹击至一个狭窄的走廊之中。

### 6.1 完美系统假设下的 $\Theta$ 约束

> **前提（完美系统假设）**：本节的所有推导均基于以下理想化前提——对**同一条目标链** $q$，系统**同时满足** CAC 可控性（$\varepsilon^*_q \leq \tau$）和 CAB 判别性（末端分离度 $s > 0$）。这等价于要求系统在该路径上既不发生误差爆炸，也不丧失区分不同输入的能力。§6.2 将论证此前提为何在全路径层面不可满足。

#### 命题 6.1（Lipschitz 乘积的双界夹击，Dual-Bound Squeeze on $\Theta$）

**命题**：设 IDFS $\mathcal{F} = (F, \sigma)$，$\Phi \in \mathrm{Lip}(\mathcal{X})$，链长为 $l$。记 $\bar{L} = (\Theta_{1,l})^{1/l}$ 为路径局部 Lipschitz 常数的**几何均值**。若系统同时满足：

1. **上界约束（CAC 可控性）**：宏观容差被限定在安全阈值内，$\varepsilon^*_q \leq \tau$；
2. **下界约束（CAB 判别性）**：存在目标链 $q$ 及输入对 $(x, y)$，$d(x,y) = \delta$，$d(q(x), q(y)) = \Delta$，使得拓扑死锁界为正：$\Delta - \varepsilon_x - \Omega_l(\delta) > 0$。

则 $\Theta_{1,l}$ 被夹击于：

$$\frac{\Delta - \varepsilon_x - \tau}{\delta} \;\leq\; \Theta_{1,l} \;\leq\; \frac{\tau - (\varepsilon_{\max}+\rho_{\max}+\Delta_{\max}) \cdot \Lambda_l}{\delta_{\max}}$$

其中 $\Lambda_l = \sum_{j=1}^l \Theta_{j+1,l}$ 是误差累积放大系数。

#### 证明

**上界方向**：由 CAC 定理（§3.1 形式 A），$\varepsilon^*_q \leq (\varepsilon_{\max}+\rho_{\max}+\Delta_{\max}) \cdot \Lambda_l + \delta_{\max} \cdot \Gamma_l \leq \tau$。由 $\Gamma_l = \sum_j L_j \Theta_{j+1,l} \leq L_{max} \Lambda_l$，整理得 $\Theta_{1,l} \leq \bar{L}^l$ 必须满足 $\Lambda_l$ 不超过 $\tau / (\varepsilon_{\max} + \rho_{\max} + \Delta_{\max} + L_{max} \delta_{\max})$。特别地，若 $\bar{L} > 1$，则 $\Lambda_l \sim \bar{L}^l / (\bar{L} - 1) \to \infty$，必然在有限深度内违约。

**下界方向**：由 CAB 定理（§4.1），$\varepsilon^*_y \geq |\Delta - \varepsilon_x| - \Omega_l(\delta)$。在简化分析中取 $\Omega_l(\delta) \leq \bar{L}^l\delta + \Delta_{\max}\Lambda_l$（路由跳变累积上界），主导项为平滑拉伸 $\bar{L}^l\delta$。若要求此下界为正（即系统确实存在不可压缩的拟合残差），则 $\Theta_{1,l} = \bar{L}^l < (\Delta - \varepsilon_x) / \delta$（$\Delta_{\max}$ 项已被上界方向的 $\Lambda_l$ 约束吸收）。反之，若 $\Theta_{1,l}$ 过小——即 $\bar{L} < 1$（系统为路径平均收缩映射）——则 $\Theta_{1,l} = \bar{L}^l \to 0$，CAB 下界退化为 $\varepsilon^*_y \geq \Delta - \varepsilon_x$，看似下界仍在。然而，由 命题 2.12，全局收缩将系统的判别能力彻底压平：对任意 $a, b \in \mathcal{X}$，$d(\Phi^l(a), \Phi^l(b)) \leq \bar{L}^l \cdot d(a, b) \to 0$，系统在长链极限下将一切初始差异——包括不同输入之间的区分——映射为零。这意味着 $\Phi_q(x) \approx \Phi_q(y)$，系统丧失了在 $x$ 和 $y$ 之间做出不同响应的能力，从而**无法对任何具有非零变分的目标链 $q$ 实现有效拟合**。

综合两个方向：$\Theta_{1,l}$（及其几何均值 $\bar{L}$）被同时从上方和下方挤压。$\square$

#### 推论 6.2（长链收缩性，Long-Chain Contractivity）

**推论**：若 $l > l^*_0 = \tau / E$（$E = \varepsilon_{\max} + \rho_{\max} + \Delta_{\max} + \delta_{\max}$，即 CAC 形式 C 的有效单步误差），则序列 $\{L_j\}$ 中**不可能所有分量都 $\geq 1$**——系统必须在至少某些步骤上执行收缩。特别地，在均匀情况（$L_j = \bar{L}$）下，$\bar{L} < 1$。

**证明**：若所有 $L_j \geq 1$，则每个尾积 $\Theta_{k+1,l} = \prod_{j=k+1}^l L_j \geq 1$，故 $\Lambda_l = \sum_{k=0}^{l-1} \Theta_{k+1,l} \geq l$。同时 $\varepsilon_{\max} + \rho_{\max} + \Delta_{\max} + L_j\delta_{\max} \geq E$ 对每个 $j$ 成立。因此 $(\varepsilon_{\max}+\rho_{\max}+\Delta_{\max}) \cdot \Lambda_l + \delta_{\max} \cdot \Gamma_l \geq E \cdot l > E \cdot l^*_0 = \tau$，违反 CAC 约束。$\square$

> **注**：此推论对一般非均匀 $\{L_j\}$ 成立，不要求均匀假设。

#### 推论 6.3（收缩走廊，Contraction Corridor）

**推论**：设 $l > l^*_0$（长链态），系统需维持最小输出分离度 $s > 0$（$d(\Phi^l(x), \Phi^l(y)) \geq s$，$d(x,y) = \delta$）。记 $\zeta = \delta/s$ 为**空间压缩比**（注：此处 $\zeta$ 为纯几何参数，与 CAC 的目标域外变分 $\rho_j$ 无关）。以 $\beta = -\ln\bar{L} > 0$ 参数化，$\bar{L}$ 被约束于走廊：

$$\beta \;\in\; \left[\ln\frac{L_{max}}{\bar{L}} - \ln\!\bigl(1 - \tfrac{1}{l^*_0}\bigr),\;\; \frac{\ln\zeta}{l}\right]$$

等价地：

$$\zeta^{-1/l} \;\leq\; \bar{L} \;\leq\; \frac{\bar{L}}{L_{max}}\!\left(1 - \frac{1}{l^*_0}\right)$$

**证明**：

- **上界**（CAC 强制收缩）：由 $L_j \leq L_{max}$，尾积 $\Theta_{k+1,l} \leq L_{max}^{l-k}$。对 $L_{max} < 1$ 且 $l$ 充分大，$\Lambda_l \leq \sum_{k=0}^{l-1} L_{max}^{l-k} \leq 1/(1 - L_{max})$。代入 CAC 约束 $E \cdot \Lambda_l \leq \tau = E \cdot l^*_0$：
>  $$\frac{1}{1 - L_{max}} \;\leq\; l^*_0 \quad\Longrightarrow\quad L_{max} \;\leq\; 1 - \frac{1}{l^*_0}$$
> 由 $L_{max} \geq \bar{L}$（均值不超极值），利用 $L_{max} = (L_{max}/\bar{L}) \cdot \bar{L}$，解出：
>  $$\bar{L} \;\leq\; \frac{1 - 1/l^*_0}{L_{max}/\bar{L}} \;=\; \frac{\bar{L}}{L_{max}}\!\left(1 - \frac{1}{l^*_0}\right)$$
> 以 $\beta = -\ln\bar{L}$ 参数化：$\beta \geq \ln(L_{max}/\bar{L}) - \ln(1 - 1/l^*_0)$。
- **下界**（判别性托底）：$\Theta_{1,l} = \bar{L}^l \geq s/\delta = 1/\zeta$，即 $\beta \leq \ln\zeta / l$。$\square$

> **注（非均匀性的压制作用）**：比值 $L_{max}/\bar{L} \geq 1$ 起到了压制上限的作用。当路径极度异质（存在远大几何均值的步骤，$L_{max} \gg \bar{L}$），走廊上界被强行压低——系统必须"多收缩" $\ln(L_{max}/\bar{L})$ 来偿还单步最坏放大引入的惩罚。对于均匀路径（$L_j \equiv \bar{L}$，$L_{max}/\bar{L} = 1$），恢复均匀走廊 $\bar{L} \in [\zeta^{-1/l},\; 1 - 1/l^*_0]$。

> **注（走廊的方向不对称性，与 §5 命题 6.13 的对接）**：推论 6.3 以标量 $\bar{L}$ 参数化走廊，隐含地将"所有经过走廊的链"视为具有相同的误差累积特征。然而，§5 命题 6.13 证明了即使双向采样，$\delta$ 累积代价在正向与逆向链之间具有 $\mathrm{Lip}(r)^{2n}$ 级的指数不对称性。这意味着走廊实际上是**方向依赖的**：对同一目标 $r$ 及其逆 $r^{-1}$，走廊的有效宽度因方向而异。具体而言，当 $r$ 为扩张映射（$\mathrm{Lip}(r) > 1$）时，正向链的 $\delta^{fwd}$ 以 $\mathrm{Lip}(r)^n$ 指数增长（理想轨道迅速逃出采样域），而逆向链的 $\delta^{inv}$ 以 $\mathrm{Lip}(r)^{-n}$ 指数衰减。CAC 精细界中的 $\delta \cdot \Gamma$ 项因此在正向链上主导误差累积，正向走廊比逆向走廊**更窄**。更深刻的是，推论 6.8 的对偶陷阱因此获得了方向结构：同一收缩步 $L_{j^*} < 1$ 在正向链中是"压平输入差异"的生存机制，但在逆向链中——若系统需同时为 $r^{-1}$ 服务——它是扩张步，可能恰好成为崩溃触发器。这从 $\delta$ 维度进一步收紧了走廊的实际可用空间。

#### 推论 6.4（最大可行链深，Maximum Viable Chain Depth）

**推论**：由推论 6.3 的走廊非空条件，系统的最大可行链深为：

$$l_{\max} \;=\; \frac{\ln\zeta}{\ln(L_{max}/\bar{L}) + 1/l^*_0}$$

超过 $l_{\max}$ 后，收缩走廊为空。

**证明**：由推论 6.3，走廊非空要求 $\ln(L_{max}/\bar{L}) + 1/l^*_0 \leq \ln\zeta / l$，即 $l \leq \ln\zeta / (\ln(L_{max}/\bar{L}) + 1/l^*_0)$。$\square$

> **注（$l_{\max}$ 的两态极限）**：
> - **高精度系统**（$l^*_0$ 大，$1/l^*_0 \ll \ln(L_{max}/\bar{L})$）：$l_{\max} \approx \ln\zeta / \ln(L_{max}/\bar{L}) = \log_{(L_{max}/\bar{L})} \zeta$。最大链深仅取决于相对非均匀性和压缩比 $\zeta$，与系统绝对精度无关。
> - **低非均匀系统**（$L_{max}/\bar{L} \to 1$，$\ln(L_{max}/\bar{L}) \ll 1/l^*_0$）：$l_{\max} \approx l^*_0 \ln\zeta$。恢复均匀极限。
>
> 链深对压缩比始终仅有**对数依赖**。

#### 推论 6.5（渐近等距极限，Asymptotic Isometry）

**推论**：由推论 6.3 的走廊上界，在 $l^*_0 \to \infty$（系统精度趋于完美）且非均匀比值 $L_{max}/\bar{L}$ 有界的极限下，最优 $\bar{L}^* \to \bar{L}/L_{max}$——系统趋向**以 $L_{max}/\bar{L}$ 为尺度的准等距映射**。完全均匀时退化为严格等距。

**证明**：走廊上界 $\frac{\bar{L}}{L_{max}}(1 - 1/l^*_0) \to \bar{L}/L_{max}$，下界 $\zeta^{-1/l}$ 在 $l$ 适中时趋近 1。最优 $\bar{L}^*$ 在上界处取得。$\square$

> **注（收缩的物理含义）**：长链 IDFS 必须是轻度收缩的。系统在每一步平均压缩微量空间体积，以换取误差累积的有界性。非均匀性越大（$L_{max}$ 相对 $\bar{L}$ 极大），系统被迫收缩得越多——因为最"放肆"的局部步骤决定了误差累积的爆炸点。

> **注（与 CAC 两态行为的关系）**：CAC 推论 6.3 将体系分为稳定有界、收敛饱和两态。本命题表明，在 CAC+CAB 双重约束下，**只有稳定态（及其边缘）的轻度收缩子区域是长链极限下唯一可行的工程态**。过度收缩的深层饱和态虽免疫了代数爆炸，却会彻底违反 CAB 判别性导致分辨率死锁；纯扩张更是导致 OOD 直接不可持续。

#### 推论 6.6（强制饱和，Mandatory Saturation）

**推论**：设 IDFS 满足完美系统假设（CAC+CAB 同时成立），且链深 $l > l^*_0$。则系统**必然**处于 推论 3.6 的饱和体制——误差上界收敛到有限常数 $B_{sat} = (\varepsilon_{max}+\rho_{max}+\Delta_{max})\Lambda_\infty + \delta_{max}\Gamma_\infty$，且此天花板与链深 $l$ 无关。

**证明**：由推论 6.2，长链态下 $\bar{L} < 1$。由 推论 3.6，$\bar{L} < 1$ 蕴含 $\Lambda_\infty = \sum_{k=0}^{\infty} \bar{L}^k = 1/(1 - \bar{L}) < \infty$，故 $\varepsilon^*_q \leq B_{sat} < \infty$。$\square$

> **注（从条件到必然）**：推论 3.2 的两态分类——稳定有界与收敛饱和——在 §6 的双重夹击下仅存饱和一态。饱和不再是"一种可能的体制"，而是**任何同时保持可控性与判别性的长链系统的唯一归宿**。$B_{sat}$ 因此从条件性上界升格为系统精度的**无条件绝对天花板**。

> **注（稳定但平庸——§3 注记的兑现）**：推论 3.7 已预告：$\varepsilon^*_q \leq B_{sat}$ 是稳定性声明而非拟合性声明（见 §3 注"上界有限 $\neq$ 拟合质量好"）。本推论将该预告从"可能如此"升格为"必然如此"——推论 6.7 将证明系统丧失对输入尺度的感知，推论 6.8 将证明维持饱和所需的收缩步恰是拟合代价最高的瓶颈。三者合力确认：$B_{sat}$ 既是"不会更差"的上界保证，也是"不可能更好"的下界判决。

#### 推论 6.7（深度致盲，Depth-Induced Input Blindness）

**推论**：在推论 6.6 的条件下，§4 命题 6.12 的逼近阈值在长链极限下退化为：

$$\mathcal{A}_l(\delta) \;=\; \underbrace{\bar{L}^l \cdot \delta}_{\to\, 0} \;+\; \underbrace{(\varepsilon_{max}+\rho_{max}+\Delta_{max})\Lambda_l + \delta_{max}\Gamma_l}_{\to\, B_{sat}} \;\;\xrightarrow{l \to \infty}\;\; B_{sat}$$

即**与输入间距 $\delta$ 完全无关**。系统所能逼近的最大目标变分 $\Delta \leq \mathcal{A}_\infty = B_{sat}$，不依赖于两个输入之间的物理距离。

**证明**：由推论 6.6，$\bar{L} < 1$ 蕴含 $\bar{L}^l \to 0$。拉伸预算（§4 命题 6.12 第一项）消失，逼近阈值退化为纯累积误差项 $B_{sat}$。$\square$

> **注（输入致盲的物理含义）**：深层系统丧失了对输入空间**尺度**的一切感知能力。无论两个输入相距 $\delta = 0.001$ 还是 $\delta = 1000$，系统能忠实追踪的目标变分不超过同一个常数 $B_{sat}$。这是 Banach 压缩映射定理的信息论版本：压缩映射抹除了初始条件的度量结构，只保留拓扑邻近性。

#### 推论 6.8（收缩—变分对偶陷阱，Contraction–Variation Duality Trap）

**推论**：设系统满足推论 6.6 的条件。由推论 6.2，存在收缩步 $j^*$（$L_{j^*} < 1$）。则该步的 §4 推论 6.3 变分下界为：

$$\varepsilon_{i_{j^*}} \;\geq\; \frac{\Delta - L_{j^*} \rho_{var} - \Delta_{\sigma, \text{max}}}{2}$$

（此处 $\rho_{var}$ 为 §4 推论 6.3 中的变分尺度参数，与 CAC 的目标域外变分 $\rho_j$ 含义不同。）由 $L_{j^*} < 1$，此下界严格大于 $(\Delta - \rho_{var} - \Delta_{\sigma,\text{max}})/2$。特别地，当 $L_{j^*} \ll 1$（强收缩步）时，$\varepsilon_{i_{j^*}} \geq (\Delta - L_{j^*}\rho_{var} - \Delta_{\sigma,\text{max}})/2 \approx (\Delta - \Delta_{\sigma,\text{max}})/2$——单步误差逼近目标变分的一半（减去路由跳变的应变力余量）。

**证明**：由 §4 推论 6.3，对路径上任意步骤 $j$，单步拟合误差满足 $2\varepsilon_{i_j} + L_j\rho_{var,j} + \Delta_{\sigma,\text{max}} \geq \Delta_j$，即 $\varepsilon_{i_j} \geq (\Delta_j - L_j\rho_{var,j} - \Delta_{\sigma,\text{max}})/2$。对收缩步 $j^*$（$L_{j^*} < 1$），$L_{j^*}\rho_{var,j^*} < \rho_{var,j^*}$，故下界 $(\Delta_{j^*} - L_{j^*}\rho_{var,j^*} - \Delta_{\sigma,\text{max}})/2 > (\Delta_{j^*} - \rho_{var,j^*} - \Delta_{\sigma,\text{max}})/2$。$\square$

> **注（对偶陷阱的结构性意义）**：这揭示了一条深刻的结构性讽刺：**使系统得以生存的收缩步，恰恰是系统拟合质量最差的位置**。系统为了不在 CAC 层面爆炸，必须在某些步骤执行强收缩（$L_{j^*} \ll 1$）；但 §4 变分下界证明，正是这些强收缩步无法以低代价逼近任何具有显著变分的目标——它们被迫在"压平输入差异"的同时，将目标变分的一大半（减去路由跳变的应变力余量 $\Delta_{\sigma,\text{max}}$）转化为不可消除的拟合残差。让系统活下去的机制，正是让它拟合最差的机制。值得注意的是，$\Delta_{\sigma,\text{max}}$ 的存在提供了微小的缓解：离散路由跳变为系统贡献了一小部分应变力余量，以稍微降低了收缩步必须承担的拟合代价。

#### 推论 6.9（对偶陷阱代价的全局预算闭合，Global Budget Closure of Duality Trap Cost）

**推论**：推论 6.8 中 $\Delta_{\sigma,\text{max}}$ 的缓解量不是自由参数，而是受 §6.2 路由碎裂博弈命题的 CAC 容限 $B_\sigma$ 严格约束。将两者联立，收缩步的拟合残差可用系统的全局误差预算 $\tau$ 直接表达：

由 §6.2 博弈命题，$\Delta_{max}\Lambda_l \leq B_\sigma = \tau - (\varepsilon_{max}+\rho_{max})\Lambda_l - \delta_{max}\Gamma_l$，故 $\Delta_{\sigma,\text{max}} \leq \Delta_{max} \leq B_\sigma/\Lambda_l$。代入推论 6.8 的下界：

$$\varepsilon_{i_{j^*}} \;\geq\; \frac{\Delta - L_{j^*}\rho_{var} - B_\sigma/\Lambda_l}{2}$$

进一步展开 $B_\sigma$：

$$\varepsilon_{i_{j^*}} \;\geq\; \frac{\Delta - L_{j^*}\rho_{var}}{2} - \frac{\tau - (\varepsilon_{max}+\rho_{max})\Lambda_l - \delta_{max}\Gamma_l}{2\Lambda_l}$$

当 $l$ 足够大（$\Lambda_l \to \infty$），$B_\sigma/\Lambda_l \to 0$，路由碎裂的缓解效应被分摊至无穷项而趋于消失。此时对偶陷阱退化为推论 6.8 的纯粹形式 $\varepsilon_{i_{j^*}} \geq (\Delta-L_{j^*}\rho_{var})/2$——证明了路由碎裂在 $l \gg 1$ 的极限下**不构成实质性的逃逸**。

> **注（$\Delta/\tau$ 比值的物理含义）**：闭合不等式的核心参数是 $\Delta/\tau$——目标变分与系统容差的比值。当 $\Delta/\tau \gg 1$（目标变分远超系统精度预算）时，收缩步的拟合残差 $\varepsilon_{i_{j^*}} \sim \Delta/2$，走廊的路由碎裂预算几乎无法缓解；当 $\Delta/\tau \sim 1$ 时，系统可通过消耗全部 $B_\sigma$ 将对偶陷阱代价压至 $O(\tau)$ 量级——但这同时意味着路由碎裂预算耗尽，系统丧失了通过 $\Delta_\sigma$ 扩展 $\Omega_l$ 的能力。**精度预算与应变力预算之间的此消彼长，是平庸定理的另一种定量表达。**



#### 推论 6.10（误差—判别力 Pareto 前沿，Error–Discriminability Pareto Frontier）

**推论**：在推论 6.3 的走廊 $\bar{L} \in [\zeta^{-1/l},\; \frac{\bar{L}}{L_{max}}(1 - 1/l^*_0)]$ 内，定义：
- **误差代价** $\mathcal{E}(\bar{L}) \triangleq B_{sat}(\bar{L}) = (\varepsilon_{max}+\rho_{max}+\Delta_{max}) \cdot \frac{1}{1 - \bar{L}} + \delta_{max} \cdot \frac{\bar{L}}{1 - \bar{L}}$（由均匀近似简化的饱和界）
- **判别力** $\mathcal{D}(\bar{L}) \triangleq \bar{L}^l$（末端分离保持能力）

则 $\mathcal{E}$ 关于 $\bar{L}$ 严格递增，$\mathcal{D}$ 关于 $\bar{L}$ 严格递增。两者**同向依赖** $\bar{L}$，构成不可调和的 Pareto 前沿：

- **靠近走廊下界**（$\bar{L} \to \zeta^{-1/l}$）：$\mathcal{E}$ 最小（误差控制最优），$\mathcal{D}$ 最小（判别力最差）
- **靠近走廊上界**（$\bar{L} \to \frac{\bar{L}}{L_{max}}(1 - 1/l^*_0)$）：$\mathcal{D}$ 最大（判别力最优），$\mathcal{E}$ 最大（误差最差）

不存在使两者同时最优的 $\bar{L}$。

> **注（Pareto 前沿的工程解读）**：这是 §6 走廊约束的终极参数化表达。系统设计者在走廊内选择任何一个 $\bar{L}$，都是在**精度**与**分辨率**之间做精确的、定量的 Pareto 折衷。低 $\bar{L}$（强收缩）换来低误差但丧失输入区分能力；高 $\bar{L}$（轻收缩）保持区分能力但误差天花板飙升。同一系统在不同任务上表现出截然不同的性能特征，其根源并非任务本身的难度差异，而是系统在内部走廊中的工作点恰好落在 Pareto 前沿的不同位置。

> **注（五项化后的 Pareto 三维拆分）**：CAC 五项精细界将 $B_{sat}(\bar{L})$ 自然分解为四个**独立可调**的子项：
>
> $$B_{sat} = \underbrace{\frac{\varepsilon_{max}}{1-\bar{L}}}_{\text{拟合底压}} + \underbrace{\frac{\rho_{max}}{1-\bar{L}}}_{\text{目标变分代价}} + \underbrace{\frac{\Delta_{max}}{1-\bar{L}}}_{\text{路由拓扑代价}} + \underbrace{\frac{\delta_{max}\bar{L}}{1-\bar{L}}}_{\text{采样偏离代价}}$$
>
> 前三项（$\varepsilon_{max}$、$\rho_{max}$、$\Delta_{max}$）共享分母 $1/(1-\bar{L})$，但各自具有独立的物理调控机制：
> - $\varepsilon_{max}$：通过提升拟合精度（增大 $M$、细化路由分区）降低
> - $\rho_{max}$：通过选择目标分解路径（改变 $R$ 的分解方式以避免高局部振荡规则）降低
> - $\Delta_{max}$：通过优化路由连续性（使 $\sigma$ 的决策边界远离高流量区域）降低
>
> 这三个旋钮构成 $\bar{L}$-切面内的一个**三维 Pareto 体**——固定 $\bar{L}$ 后，系统仍可在 $(\varepsilon_{max}, \rho_{max}, \Delta_{max})$ 空间内做多目标优化。推论 6.10 原文中的一维 Pareto 前沿（$\mathcal{E}$ vs $\mathcal{D}$）实际上是此三维体在 $\bar{L}$-轴方向的投影。这意味着两个 $\bar{L}$ 相同的系统，可以通过不同的 $(\varepsilon_{max}, \rho_{max}, \Delta_{max})$ 配比达到截然不同的 $B_{sat}$——走廊内的自由度比一维前沿所暗示的要丰富得多。

---


#### 定理 6.11（完美即平庸定理，Perfection–Mediocrity Theorem）

**定理**：设 IDFS $\mathcal{F} = (F, \sigma)$ 在某条目标链 $q \in \mathcal{T}_l$（$l > l^*_0$）上同时满足 CAC 可控性与 CAB 判别性（完美系统假设）。则该系统同时展现以下四重结构性缺陷：

1. **误差封顶**（推论 6.6）：$\varepsilon^*_q \leq B_{sat}$，且 $B_{sat}$ 同时是上界与下界，系统无法突破也无法远离这个平庸的精度天花板。
2. **输入致盲**（推论 6.7）：系统丧失对输入空间尺度的感知，可追踪的最大目标变分 $\Delta \leq B_{sat}$，与输入间距 $\delta$ 无关。
3. **拟合瓶颈**（推论 6.8）：维持稳定所必需的收缩步——即系统的生存机制——恰是拟合代价最高的位置，单步残差 $\geq \Delta/2$。
4. **不可调和**（推论 6.10）：误差与判别力同向依赖 $\bar{L}$，不存在任何使两者同时最优的参数选择。

四重缺陷的共同根源是推论 6.2——$\bar{L} < 1$ 的结构必然性。该强制收缩在抵消了 CAC 爆炸的同时，也抵消了系统对距离、变分、和分辨率的一切精细控制。**要求一个系统在长链上同时完美可控且完美可判别，等价于将其固定在一个平庸的不动点上。**$\square$

> **注（结构性讽刺）**：完美系统假设的原意是将系统置于"CAC 与 CAB 同时满足"的理想态之中，以此作为分析起点。然而推论 6.6–8 证明，这个"理想态"本身就是一个陷阱——系统为了同时满足两个约束，被迫收缩到一个狭窄的走廊，而走廊内的每一个点都是“稳定但平庸”的。这正是 §6.2 提出三元困境的动机：既然完美等于平庸，真实系统必须主动放弃某一维度，才能在其余维度上获得实质性的能力。

### 6.2 IDFS 不可能三元困境

§6.1 的分析建立在完美系统假设上——单条路径同时满足 CAC 与 CAB。本节论证：当系统需要逼近多样化的目标规则集 $R$ 时，完美系统假设在**全路径层面不可同时满足**。

#### 命题 6.12（泛化-深度-控制不可能三元组，Generalization-Depth-Control Trilemma）

**命题**：设 IDFS $\mathcal{F} = (F, \sigma)$ 需以容差 $\varepsilon$ 逼近目标规则集 $R$ 中的所有链。记 $\gamma_R$ 为 $R$ 的等效张力跨度（§2.5 定义）。则以下三个性质不可同时满足：

1. **泛化性**（Generalization）：$R$ 具有高等效张力跨度 $\gamma_R \gg 1$。
2. **链深**（Depth）：系统支持长链推理 $l \gg l^*_0$。
3. **全路径控制**（Full-Path Control）：系统在所有目标链上同时满足 CAC+CAB。

> **注（$\gamma_R$ 的泛化性）**：此处复用 §2.5 定义的等效张力跨度 $\gamma_R = \sup_{r \in R} \lambda_r \;/\; \inf_{r \in R} \lambda_r$，其中 $\lambda_r$ 是系统为了逼近目标 $r$ 必须释放出的等效宏观形变率。这一定义**不要求目标 $r \in R$ 本身具有 Lipschitz 性质**——它可以是离散的、非光滑的、甚至纯符号逻辑的映射。$\gamma_R$ 量化的是目标集对系统**动力学异质性需求**的差距，而非目标自身的解析性质。

**证明**：

系统 $\Phi$ 是一个**单一映射**，其局部 Lipschitz 常数 $L_j$ 由 $\Phi$ 在中间态 $h_{j-1}$ 处的局部行为决定。不同的目标链 $q$ 经过不同的中间态序列，产生不同的 $\{L_j\}$ 序列。

**泛化性 $\to$ 非均匀（大 $L_{max}/\bar{L}$）**：若 $R$ 包含 Lipschitz 常数差异极大的规则（$\gamma_R \gg 1$），则 $\Phi$ 在不同区域必须表现出截然不同的局部 Lipschitz 行为——在某些区域近似强收缩规则（$L_j \ll 1$），在另一些区域近似强扩张规则（$L_j \gg 1$）。由 命题 2.15，基函数库的内部跨度 $\kappa_\Phi \geq \gamma_R \gg 1$。因此系统在逼近不同目标时展现出的相对非均匀性 $L_{max}/\bar{L}$ 必然随之攀升，至少处于 $\mathcal{O}(\gamma_R)$ 级别（当 $\inf L_j \approx \bar{L}$ 时取到）。

**高非均匀 $\to$ 短 $l_{\max}$**：由 §6.1 推论 6.4，$l_{\max} = \ln\zeta / (\ln(L_{max}/\bar{L}) + 1/l^*_0)$。当 $L_{max}/\bar{L} \sim \gamma_R \gg 1$ 时，$l_{\max} \approx \log_{\gamma_R} \zeta$，随 $\gamma_R$ 取对数级衰减——系统安全链深被 $R$ 的多样性无情碾压。

**长链 + 泛化 $\to$ 失控**：若强行要求 $l \gg l_{\max}$，则收缩走廊（§6.1 推论 6.3）在此剧烈变分下必定为空，绝不存在数学上合法的 $\bar{L}$ 既能压制累计爆炸又能维持末端判别。系统必须在某些路径上违反 CAC（误差爆炸而不可持续）或违背 CAB（发生分辨率合并，丧失逻辑隔离）。$\square$

> **注（等距陷阱）**：一个自然的逃逸尝试是令 $\Phi$ 为全局等距映射（$L_j \equiv 1$，$L_{max}/\bar{L} = 1$），从而获得最大链深 $l_{\max} = l^*_0 \ln\zeta$。然而，等距 $\Phi$ 只能精确逼近**同样是等距的**目标规则。对于 $\mathrm{Lip}(r) \neq 1$ 的规则，单步逼近误差 $\varepsilon_r$ 至少为 $|\mathrm{Lip}(r) - 1| \cdot \mathrm{diam}(\mathcal{X}_r)$ 量级——即等距消灭了非均匀系数 $L_{max}/\bar{L}$，但代价是 $\varepsilon_{\max}$ 的原地飙升，且同样通过 CAC 第一约束反向压垮了有效链深。泛化能力与链深的张力是**基于最基本欧氏空间度量学内禀且绝对的**。

#### 命题 6.13（路由碎裂的上下界对偶博弈，Upper-Lower Bound Duality Game of Routing Fragmentation）

三元困境的证明表明，系统的核心参数被 CAC 和 CAB 双向夹击至走廊之中。路由跳变代价 $\Delta_\sigma$ 在这两个约束中以**不同的系数结构**同时出现——一侧为正面，一侧为负面——构成了一个非平凡的对偶博弈。

**命题**：设 IDFS $\mathcal{F}$ 需在链深 $l > l^*_0$ 下同时满足 CAC 可控性（$\varepsilon^*_q \leq \tau$）与 CAB 判别性（末端目标变分 $\Delta > 0$）。路由跳变代价序列 $\{\Delta_{\sigma,j}\}_{j=1}^l$ 同时面对两重约束：

1. **CAC 侧（上界负面）**：$\Delta_\sigma$ 进入有效局部失配项 $(\varepsilon_{i_j} + \rho_j + \Delta_{\sigma,j})\Theta_{j+1,l}$，其加权总和不超过 $\tau$；取极值化：$\Delta_{max} \cdot \Lambda_l \leq \tau - (\varepsilon_{max}+\rho_{max})\Lambda_l - \delta_{max}\Gamma_l$。
2. **CAB 侧（下界正面）**：$\Delta_\sigma$ 进入拓扑应变力 $\Omega_l(\delta) = \bar{L}^l\delta + \sum_j \Delta_{\sigma,j}\Theta_{j+1,l}$，增大 $\Omega_l$ 放宽死锁条件 $\Delta - \varepsilon_x - \Omega_l(\delta) > 0$。

定义**路由碎裂的 CAC 容限（CAC Budget for Routing Fragmentation）**为 CAC 上界分配给路由跳变的最大预算：

$$B_\sigma \;\triangleq\; \tau - (\varepsilon_{max} + \rho_{max})\Lambda_l - \delta_{max}\Gamma_l$$

则 $\sum_j \Delta_{\sigma,j}\Theta_{j+1,l} \leq B_\sigma$，且系统面对的 CAB 死锁条件为：

$$\varepsilon^*_y \;\geq\; \Delta - \varepsilon_x - \bar{L}^l\delta - \sum_j \Delta_{\sigma,j}\Theta_{j+1,l}$$

系统追求最小化右端（使死锁尽量弱），等价于最大化路由碎裂的应变力贡献 $\sum_j \Delta_{\sigma,j}\Theta_{j+1,l}$——但此最大化受限于 $B_\sigma$。因此，最优 $\Delta_\sigma$ 分配的极限为：

$$\min_y \varepsilon^*_y \;\geq\; \Delta - \varepsilon_x - \bar{L}^l\delta - B_\sigma \;=\; \Delta - \varepsilon_x - \bar{L}^l\delta - \tau + (\varepsilon_{max}+\rho_{max})\Lambda_l + \delta_{max}\Gamma_l$$

当此值为正时，即使系统将 CAC 的**全部路由预算** $B_\sigma$ 投入应变力解耦，仍无法消除 CAB 死锁——三元困境不可逃逸。

**证明**：CAC 约束 $(\varepsilon_{max}+\rho_{max}+\Delta_{max})\Lambda_l + \delta_{max}\Gamma_l \leq \tau$ 移项得 $\Delta_{max}\Lambda_l \leq B_\sigma$。由 $\sum_j \Delta_{\sigma,j}\Theta_{j+1,l} \leq \Delta_{max}\Lambda_l$（各步极值化），上界确立。代入 CAB 死锁界，路由碎裂的最大应变力贡献不超过 $B_\sigma$，即使取等仍留有残余死锁量。$\square$

> **注（对偶博弈的非对称性与最优分配）**：$\Delta_\sigma$ 在 CAC 和 CAB 中虽以相同的加权形式 $\sum_j \Delta_{\sigma,j}\Theta_{j+1,l}$ 出现，但约束方向相反：CAC 要求该求和**尽量小**，CAB 要求该求和**尽量大**。两者的预算竞争构成一个**零和博弈**。系统设计者无法"独立地"优化路由碎裂策略——为 CAB 释放的每一单位应变力，都从 CAC 的误差预算中等额扣除。更精细地，当 $B_\sigma > 0$（CAC 尚有余量）时，系统可通过增大路由碎裂来部分缓解 CAB 死锁；当 $B_\sigma = 0$（CAC 已无余量）时，路由碎裂的应变力贡献完全被锁死，系统退化为纯平滑映射面对 CAB 的全部刚性。这精确地量化了 §4.1 注记（门控解耦机制）中"通过离散门控引入流形断层"这一逃逸路径的**定量上限**。

#### 三种 Type 的结构性画像

由 §6.1 的完美即平庸定理，任何真实系统必须主动放弃三元中的某一维度。以下利用 §2–§6.1 的定量工具，为每种 Type 建立精确的数学画像。

#### 6.2.1 Type A：放弃泛化性（死记硬背系统，Rote Memorization System）

**设定**：系统选择 $\gamma_R \approx 1$（目标集的等效张力跨度极小），由 命题 2.15，$\kappa_\Phi \approx 1$，从而 $L_{max}/\bar{L} \approx 1$。

**命题 6.14（查表退化，Lookup Degeneration）**：设 IDFS $\mathcal{F}$ 在 $\gamma_R \approx 1$ 条件下运行。则：

(i) **走廊最宽**：推论 6.3 的收缩走廊在 $L_{max}/\bar{L} \approx 1$ 时取得最大宽度，$\bar{L}$ 的设计自由度最大。

(ii) **链深最大**：推论 6.4 给出 $l_{max} \approx l^*_0 \ln\zeta$，系统可达理论上的最深推理。

(iii) **路由简并**：由 $\kappa_\Phi \approx 1$，系统的 $\mathcal{D}\log M$ 级微观路径在宏观变形效果上发生完全态简并——路由映射 $\sigma$ 虽可指定不同的组合路径 $q$，但所有路径的端到端 Lipschitz 常数 $\bar{L}_q$ 趋于一致。

**证明**：

(i) 由推论 6.3 走廊公式 $\beta \in [\ln(L_{max}/\bar{L}) - \ln(1-1/l^*_0),\; (\ln\zeta)/l]$，当 $L_{max}/\bar{L} \to 1$ 时，左端点 $\to -\ln(1-1/l^*_0) > 0$，走廊左界降至最低，宽度取得最大值。

(ii) 由推论 6.4 公式 $l_{max} = \ln\zeta / (\ln(L_{max}/\bar{L}) + 1/l^*_0)$，当 $\ln(L_{max}/\bar{L}) \to 0$ 时，$l_{max} \to l^*_0 \ln\zeta$，取到上确界。

(iii) 由 命题 2.15，基函数库的内部跨度 $\kappa_\Phi \ge \gamma_R$。当 $\gamma_R \approx 1$ 时，$\kappa_\Phi \approx 1$，即 $\sup_q \bar{L}_q / \inf_q \bar{L}_q \approx 1$。因此，无论 $\sigma$ 如何选择路径，所有路径的端到端拉伸率几乎相同。系统的路由容量 $\mathcal{C}_{route} \sim \mathcal{D}\log M$ 在代数上存在，但在度量意义上坍缩为等效的单通道映射。$\square$

> **注（零维吸引子极端）**：在路由简并条件下，若系统进一步选择 $\bar{L} \to 0$（以最大化训练点稳定性），则 $B_{sat} \to \varepsilon_{max}$（推论 6.6），系统像集坍缩为若干孤立的零维不动点。此时多步"推理"（$\Phi^l(x)$ 随 $l$ 增大）仅是原地跌落，丧失了历时计算的意义。若选择 $\bar{L} \approx 1$（等距映射），则由等距陷阱（§6.2 注），对 $\mathrm{Lip}(r) \neq 1$ 的目标，单步误差 $\varepsilon_r \ge |\mathrm{Lip}(r) - 1| \cdot \mathrm{diam}(\mathcal{X}_r)$，系统退化为刚性平移器。

**推论 6.15（采样诅咒，Sampling Curse）**：设 $\gamma_R \approx 1$ 的查表系统需在 $d$ 维输入空间 $\mathcal{X} \subseteq \mathbb{R}^d$（直径 $D$）上以容差 $\varepsilon$ 逼近目标规则 $r$（$\mathrm{Lip}(r) = \lambda_r$）。则所需采样点数满足：

$$|\mathcal{S}| \;\geq\; \left(\frac{D \cdot |\lambda_r - \bar{L}^l|}{\varepsilon}\right)^d$$

**证明**：

对任意未采样点 $x \notin \mathcal{S}$，令 $x' \in \mathcal{S}$ 为其最近邻，$d(x, x') \le \delta_{max}$。系统在 $x$ 处的端到端误差为：

$$\varepsilon(x) \;=\; d(\Phi_q(x),\; r(x))$$

由三角不等式，分解为采样点误差和传输偏差：

$$\varepsilon(x) \;\leq\; d(\Phi_q(x), \Phi_q(x')) + d(\Phi_q(x'), r(x')) + d(r(x'), r(x))$$

$$\;\leq\; \bar{L}^l_q \cdot \delta_{max} + \varepsilon(x') + \lambda_r \cdot \delta_{max}$$

由 $\kappa_\Phi \approx 1$，对所有路径 $q$，$\bar{L}^l_q \approx \bar{L}^l$（路由简并），上式对 $\sigma$ 的选择不敏感。即使 $\varepsilon(x') = 0$（训练点完美拟合），仍有：

$$\varepsilon(x) \;\geq\; |\lambda_r - \bar{L}^l| \cdot \delta_{max}$$

这是因为目标在 $[x', x]$ 上以 $\lambda_r$ 拉伸，而系统在所有路径上以一致的 $\bar{L}^l$ 拉伸，两者之差构成不可消除的插值残差（下界来自于当 $r$ 的局部行为与 $\Phi$ 的全局行为方向一致但幅度不同时的最小失配）。

为使 $\varepsilon(x) \le \varepsilon$，必须：

$$\delta_{max} \;\leq\; \frac{\varepsilon}{|\lambda_r - \bar{L}^l|}$$

在 $d$ 维空间中，直径为 $D$ 的域以 $\delta_{max}$-球覆盖所需的最小球心数为 $(D/\delta_{max})^d$，因此：

$$|\mathcal{S}| \;\geq\; \left(\frac{D}{\delta_{max}}\right)^d \;=\; \left(\frac{D \cdot |\lambda_r - \bar{L}^l|}{\varepsilon}\right)^d \quad \square$$

> **注（维度诅咒的物理根源）**：此下界的指数级爆发不是采样理论的一般结论，而是 $\kappa_\Phi \approx 1$（路由简并）的**直接后果**。若系统具备差异化路由（$\kappa_\Phi \gg 1$），则 $\sigma$ 可以为不同的局部区域指定不同的 $\bar{L}_q$，使得在 $\lambda_r$ 附近有 $\bar{L}^l_q \approx \lambda_r$ 的路径可选，从而 $|\lambda_r - \bar{L}^l_q| \to 0$，$\delta_{max} \to \infty$——即系统可在极稀疏采样下通过拓扑插值覆盖大片区域。**放弃泛化性（$\gamma_R \approx 1$）恰恰剥夺了这种拓扑插值能力。**

$\to$ **画像：深隧的刻板记忆器**。该系统可合法地拥有极深的推理链路和最宽的参数走廊，但这一切代数自由度都被路由简并所架空。系统的物理本质是一个以维度诅咒级别的数据穷举来换取确定性的查表器——能将离散的记忆点经过长链推演而维持绝对稳定（免于爆炸），但付出的代偿是让整个高维容量库成为死库。

> **注（$\Delta_\sigma = 0$ 的双重含义：精度优势与泛化丧失的数学同义词）**：路由简并（$\kappa_\Phi \approx 1$）蕴含路由切换在宏观上几乎不发生——$\sigma$ 在不同区域虽形式上可选不同路径，但由于所有路径的端到端效果一致，实际路由边界的跨越不产生有效的功能差异。因此 $\Delta^{err}_j \approx 0$（误差轨道与理想轨道的路由决策几乎不分裂）且 $\Delta^{sam}_j \approx 0$（局部采样域内的路由一致性天然满足），合计 $\Delta_{\sigma,j} \approx 0$。
>
> 这一归零有**精确的双重后果**：
> - **CAC 侧（精度优势）**：$\Delta_{max} \approx 0$ 意味着 $B_{sat}^{(A)} \approx (\varepsilon_{max}+\rho_{max})/(1-\bar{L}) + \delta_{max}\bar{L}/(1-\bar{L})$——比一般系统的 $B_{sat}$ 少了 $\Delta_{max}/(1-\bar{L})$ 项，饱和界更紧。
> - **CAB 侧（应变力丧失）**：由 §6.2 路由碎裂博弈命题，$\Delta_\sigma = 0$ 意味着 $\Omega_l(\delta)$ 中路由碎裂的应变力贡献**归零**，拓扑应变力退化为纯连续项 $\bar{L}^l\delta$，CAB 死锁条件 $\Delta - \varepsilon_x - \Omega_l \geq \varepsilon^*_y$ 中缺失了门控解耦的缓冲。面对 $\Delta > B_{sat}^{(A)}$ 的高变分目标，系统无力通过路由碎裂来扩展逼近范围。
>
> 两者合计：Type A 的 $\Delta_\sigma = 0$ 既是其精度天花板更低（精度更好）的原因，也是其面对高异质性目标完全无力的数学同义词。**路由碎裂的缺失不是系统的设计选择，而是路由简并的自动后果——$\kappa_\Phi \approx 1$ 在代数上锁死了 $\Delta_\sigma$，使系统丧失了在 CAC-CAB 博弈中利用路由自由度的一切可能。**



**设定**：系统选择 $l \le l^*_0$，从而 $\gamma_R$ 可任意大，$\bar{L}$ 不受走廊限制。

**命题 6.16（走廊解除与扩张解放，Corridor Liberation）**：设 IDFS $\mathcal{F}$ 在 $l \le l^*_0 = \tau/E$ 条件下运行。则：

(i) **收缩非必需**：推论 6.2 的前提（$l > l^*_0$）不成立，$\bar{L} < 1$ 不再是结构必然——系统可合法地在全路径上保持 $L_j \ge 1$ 甚至 $L_j \gg 1$。

(ii) **拉伸预算全额存活**：端到端拉伸量 $\Theta_{1,l}\delta = \bar{L}^l \cdot \delta$ 不受收缩走廊的强制衰减。当 $\bar{L} > 1$ 时，$\Theta_{1,l}\delta > \delta$——系统对初始微扰的响应被放大而非压缩。

(iii) **变分瓶颈消解**：由于不存在被迫的收缩步（$L_{j^*} < 1$），推论 6.8 的对偶陷阱（"收缩步即最高拟合代价步"）自动失效。系统可为任意目标变分 $\Delta$ 提供匹配的 $L_{local} \gg 1$，不受来自收缩需求的反向拉扯。

**证明**：

(i) 推论 6.2 证明了：若 $l > l^*_0$ 且所有 $L_j \ge 1$，则 $\Lambda_l \ge l > l^*_0$，违反 CAC 约束。其逆否命题为：若 $l \le l^*_0$，则 $\Lambda_l \le l \le l^*_0$，即使所有 $L_j \ge 1$，CAC 约束 $E \cdot \Lambda_l \le E \cdot l \le \tau$ 仍可满足。因此 $\bar{L} < 1$ 失去了结构必然性。

(ii) 在 $\bar{L} \ge 1$（非收缩态）下，$\Theta_{1,l} = \bar{L}^l \ge 1$。CAC 误差上界变为 $\varepsilon^*_q \le E \cdot \Lambda_l$。由于 $l \le l^*_0$，$\Lambda_l$ 至多为 $l^*_0 \cdot \bar{L}^l$（几何级数），总误差仍被 $\tau$ 封顶：$\varepsilon^*_q \le E \cdot l^*_0 \cdot \bar{L}^l$。因此系统在 $\bar{L} > 1$ 下仍可控，前提是 $l$ 足够小使得 $\bar{L}^l$ 未引爆几何级数求和。

(iii) 推论 6.8 的前提是"在长链要求 $\bar{L} < 1$ 的条件下，必须存在至少一个收缩步 $L_{j^*} < 1$"。当 $l \le l^*_0$ 时，无需 $\bar{L} < 1$，故不存在被迫的收缩步，推论 6.8 的对偶陷阱前提为假，结论自然失效。$\square$

**推论 6.17（空间换时间的代偿定律，Space-for-Time Compensation Law）**：设系统需以容差 $\varepsilon$ 逼近复杂目标集 $R$，其度量熵为 $I_\varepsilon(\mathcal{S})$。若系统将链深限制在 $l \le l^*_0$，则为保证路由容量足以覆盖目标集，基函数库规模 $M$ 必须满足：

$$M \;\geq\; \exp\!\left(\frac{I_\varepsilon(\mathcal{S}) - C_\varepsilon}{l^*_0}\right)$$

**证明**：

由 引理 2.1，路由容量 $\mathcal{C}_{route} \le \mathcal{D}\log M + C_\varepsilon$。在 Type B 中，有效链深 $\mathcal{D} \le l^*_0$。由 命题 2.4（组合耗尽），若系统需以容差 $\varepsilon$ 覆盖目标集的度量熵 $I_\varepsilon(\mathcal{S})$，则必须：

$$I_\varepsilon(\mathcal{S}) \;\le\; \mathcal{C}_{route} \;\le\; l^*_0 \cdot \log M + C_\varepsilon$$

整理得：

$$\log M \;\ge\; \frac{I_\varepsilon(\mathcal{S}) - C_\varepsilon}{l^*_0}$$

即 $M \ge \exp\bigl((I_\varepsilon(\mathcal{S}) - C_\varepsilon)/l^*_0\bigr)$。$\square$

> **注（深度杠杆的丧失）**：对比无链深限制的系统，后者可用 $\mathcal{D}\log M$ 的指数级组合熵来覆盖 $I_\varepsilon(\mathcal{S})$，其中 $\mathcal{D}$ 作为指数杠杆大幅降低了对 $M$ 的需求。Type B 通过将 $\mathcal{D}$ 锁死在 $l^*_0$，将这个乘法杠杆斩为常数，代偿地要求 $M$ 必须以目标复杂度的**指数量级**增长。

> **注（采样依赖的异质性）**：由于 $\bar{L}$ 不受走廊限制，Type B 系统保留了在平缓区域以大 $\delta$ 宽容度进行稀疏采样的能力。但为了用大 $M$ 锚定局部的高频特征（$L_{local} \gg 1$ 的剧烈拉伸算子），$\mathcal{S}$ 必须在决策边界或曲率剧变区提供极其密集的样本。训练集的结构核心从 Type A 的全域均匀穷举变成了**自适应异质网格**。

$\to$ **画像：宽浅全息镜**。将 Type B 描述为"放弃"是不准确的——它实质上是以牺牲内部长链迭代能力（$l > l^*_0$）为代价，来**全力保护短链映射的极高精度与广阔感知**。它允许内部极度暴烈的扩张响应（路由非简并，$\kappa_\Phi \gg 1$），毫无理论死角的局部误差控制。代价是算法结构的"扁平化"——以指数级参数膨胀来弥补深度组合杠杆的丧失。

#### 6.2.3 Type C：放弃全路径控制（容忍崩溃系统，Collapse-Tolerant System）

**设定**：系统保留 $\gamma_R \gg 1$ 和 $l$ 可大，但接受路由映射 $\sigma$ 无法将所有目标链引导至走廊之内。

**命题 6.18（双峰误差的不可消除性，Irreducibility of Bimodal Error）**：设 IDFS $\mathcal{F}$ 需以容差 $\varepsilon$ 逼近目标集 $R$（$\gamma_R \gg 1$），且链深 $l > l^*_0$。记 $\sigma$ 将输入空间 $\mathcal{X}$ 分割为：

- **安全域** $\mathcal{X}_{safe} = \{x : \text{路径 } q = \sigma_l(x) \text{ 的 } \bar{L}_q \text{ 落在收缩走廊内}\}$；
- **失控域** $\mathcal{X}_{fail} = \mathcal{X} \setminus \mathcal{X}_{safe}$。

则：

(i) **安全域内可控**：对 $x \in \mathcal{X}_{safe}$，§6.1 推论 6.6–8 全部生效，$\varepsilon(x) \le B_{sat}$。

(ii) **失控域误差发散**：对 $x \in \mathcal{X}_{fail}$，路径 $q$ 违反 CAC 或 CAB，$\varepsilon(x)$ 可达像空间直径 $D$。

(iii) **失控域测度存在正下界**：由 §4 DFG 定理，

$$\mu(\mathcal{X}_{fail}) \;\geq\; \mu(U_\tau) \;\geq\; \mu(\mathcal{X}_r)\!\left(1 - \frac{|\mathrm{Im}(\sigma)| \cdot e^{C_\varepsilon}}{e^{I_\varepsilon(\mathcal{S})}}\right)^{1/\beta}$$

此下界为正当且仅当目标集的度量熵与系统分辨率间存在非零缺口。无论如何优化 $\sigma$，失控域不可压缩至零测度。

**证明**：

(i) 在安全域内，路径 $q$ 满足 $\bar{L}_q < 1$（落在走廊内），完美系统假设对该路径成立。推论 6.6–8 的所有推导直接适用。

(ii) 在失控域内，路径 $q$ 不满足走廊约束。有两种失效模式：
- 若 $\bar{L}_q > 1 - 1/l^*_0$（走廊上界被击穿），则 CAC 累积误差 $\varepsilon^*_q \ge E \cdot \Lambda_l \to \infty$；
- 若 $\bar{L}_q < \zeta^{-1/l}$（走廊下界被击穿），则 CAB 末端分离度 $\bar{L}^l_q \cdot \delta < s$，系统丧失判别力。

两种情形下，系统均无法同时保证可控性与判别性，误差可任意接近像空间直径 $D$。

(iii) 由 §4 DFG 定理（不完美拟合集的正测度下界），$U_\tau = \{x : \varepsilon(x) > \tau\}$ 的测度存在由系统分辨率缺口决定的正下界。当 $\gamma_R \gg 1$ 且 $l > l^*_0$ 时，由 §6.2 三元困境命题的证明，走廊在高非均匀性下变窄甚至为空，使得落在走廊外的路径集的测度不可压缩至零。$\square$

**推论 6.19（边界脆弱性的定量刻画，Quantitative Boundary Fragility）**：设 $x_0 \in \partial\mathcal{X}_{safe}$（安全域与失控域的边界），$\delta_{adv}$ 为使 $x_0 + \delta_{adv}$ 从安全域跌入失控域的最小扰动量。则：

$$\delta_{adv} \;\leq\; \frac{1}{\sup_j |\nabla_{h_j} L_j|} \cdot \left|\bar{L}_{safe} - \bar{L}_{boundary}\right|$$

其中 $\bar{L}_{boundary}$ 是走廊边界值（推论 6.3 的上界或下界），$\bar{L}_{safe}$ 是当前路径在安全域内的 $\bar{L}$ 值。

**证明**：

在安全域边界 $x_0$ 处，路径 $q = \sigma_l(x_0)$ 的几何均值 $\bar{L}_q$ 恰好位于走廊边界附近。由于 $L_j$ 是 $\Phi$ 在中间态 $h_{j-1}$ 处的局部 Lipschitz 常数，对输入的微扰 $\delta$ 引起的 $L_j$ 变化率为：

$$\frac{\partial \bar{L}_q}{\partial x} \;\sim\; \frac{1}{l}\bar{L}^{1-1/l} \cdot \sum_j \frac{\partial L_j}{\partial h_{j-1}} \cdot \frac{\partial h_{j-1}}{\partial x}$$

在边界处，$\bar{L}_q$ 需偏移 $|\bar{L}_{safe} - \bar{L}_{boundary}|$ 才能跌出走廊。因此使系统跌出走廊的最小扰动量 $\delta_{adv}$ 不超过上式的逆。当走廊窄（$|\bar{L}_{safe} - \bar{L}_{boundary}|$ 小）或梯度陡（$\sup |\nabla L_j|$ 大）时，$\delta_{adv}$ 极小——微小的输入扰动即可引发灾难性的路径跳变。$\square$

> **注（对抗脆弱性的结构根源）**：此推论精确地刻画了对抗攻击的物理根源：攻击者无需理解系统的语义功能，只需找到一个使 $\bar{L}_q$ 跨越走廊边界的微扰方向。走廊越窄（$\gamma_R$ 越大时由推论 6.4 决定），$\delta_{adv}$ 越小，系统越脆弱。这是**结构性的、与训练数据无关的**脆弱性。

> **注（采样依赖的易碎性）**：Type C 系统要求 $\mathcal{S}$ 必须精确勾勒出 $\partial\mathcal{X}_{safe}$ 的拓扑结构。由于 $\sigma$ 是硬路由，$\partial\mathcal{X}_{safe}$ 附近的 $\delta_{adv}$ 极小，微小的采样空洞即可被系统放大为宏观的对抗崩溃。

$\to$ **画像：强但脆**。Type C 在安全域内性能优异（§6.1 全部生效），但失控域的存在不仅不可消除（测度正下界），其边界更是由走廊宽度和路由梯度共同决定的**薄壳脆弱剖面**。系统越泛化（$\gamma_R$ 大），走廊越窄，安全域与失控域的交界面越脆弱。

> **注（失控域误差发散的微观机制：采样域劫持，与 命题 5.3 的对接）**：上述命题 (ii) 从宏观层面证明了失控域内误差可达像空间直径 $D$，但未揭示其微观发生机制。命题 5.3（组合误差强制放大）恰好填补了这个缺口。当系统在走廊边界附近工作时（边界脆弱性推论的 $\delta_{adv}$ 极小），微小输入扰动将中间态 $h_j$ 推入一个由**不相关采样约束**锁定行为的区域——$\Phi$ 在该区域的全局行为已被另一条采样对 $(r', \mathcal{X}')$ 强制绑定为服务于 $r'$，无法为当前链路 $q$ 提供正确的映射。误差发散不是因为"系统没学好"（$\varepsilon$ 在每条规则上均可任意小），而是因为"系统在那个区域学的是别的东西"——这是 IDFS 单映射共享架构的固有副作用。
>
> 由此，Type C 的失败模式具有**离散跳变型（catastrophic）**而非连续退化型（graceful）的特征：误差从安全域的 $B_{sat}$ 跳变至失控域的 $\Omega(D)$，跳变幅度不低于 $2 \cdot d(\text{劫持域中心}, \text{目标值域})$（命题 5.3 的 $2D$ 下界），远非 $O(\delta_{adv})$ 级别的连续退化。这一离散跳变性质与边界脆弱性推论联合，揭示了 Type C 系统的一个严峻工程现实：**失败不是逐渐发生的——系统在走廊边界的一侧表现完美，跨过微小的 $\delta_{adv}$ 后立即灾难性崩溃，中间没有预警的渐变区间。**

**推论 6.20（灾难性路由跳变的精确分解，Precise Decomposition of Catastrophic Routing Jump）**：上述离散跳变型失败的跳变幅度可用 CAC 五项精细界中的路由失准惩罚 $\Delta^{err}_j$ 精确分解。设输入 $x_0 \in \mathcal{X}_{safe}$ 的 $\delta_{adv}$-邻域内存在 $x' \in \mathcal{X}_{fail}$（$d(x_0, x') = \delta_{adv}$）。设从 $x_0$ 出发的安全链在第 $j^*$ 步处（$j^* \leq l$），扰动后的实际轨道 $h_{j^*-1}(x')$ 首次跨越路由边界——即 $\sigma(h_{j^*-1}(x')) \neq \sigma(h_{j^*-1}(x_0))$。则：

(i) **跳变步的路由惩罚精确量化**：在第 $j^*$ 步，CAC 精细界中的路由偏转项被激活：

$$\Delta^{err}_{j^*} \;=\; d\bigl(\sigma(h_{j^*-1}(x'))(h_{j^*-1}(x')),\;\, \sigma(h_{j^*-1}(x_0))(h_{j^*-1}(x'))\bigr) \;\geq\; \frac{\Delta_\sigma^{bdry}}{L^{l-j^*}}$$

其中 $\Delta_\sigma^{bdry}$ 为跨越路由边界时两条激活链的**末端输出最小分离度**——由 命题 2.14（路由分辨率极限），$\Delta_\sigma^{bdry} \geq \Delta_{decision}/L$（$\Delta_{decision}$ 为路由决策导致的宏观行为差异）。

(ii) **跳变幅度的尾积放大**：第 $j^*$ 步的路由偏转 $\Delta^{err}_{j^*}$ 在后续 $l - j^*$ 步中被尾部乘积 $\Theta_{j^*+1,l}$ 放大。端到端误差的跳变量至少为：

$$\varepsilon^*(x') - \varepsilon^*(x_0) \;\geq\; \Delta^{err}_{j^*} \cdot \Theta_{j^*+1,l} \;-\; O(\delta_{adv} \cdot L^l)$$

当 $\delta_{adv}$ 极小（走廊极窄）而 $\Delta^{err}_{j^*} \cdot \Theta_{j^*+1,l}$ 为有限正值时，净跳变量为正——误差在 $\delta_{adv}$ 的微扰下发生量级为 $\Delta^{err}_{j^*} \cdot \Theta_{j^*+1,l}$ 的阶跃。

(iii) **跳变幅度与安全域 $B_{sat}$ 的关系**：在安全域内，路由不发生跳变（$\Delta^{err}_j = 0$），CAC 误差界由 $B_{sat}$ 封顶。跨越边界后，$\Delta^{err}_{j^*} > 0$ 被激活，误差界跳变至 $B_{sat} + \Delta^{err}_{j^*}\Theta_{j^*+1,l}$ 或更高。当 $j^*$ 处于链路早期（$j^*$ 小、$\Theta_{j^*+1,l}$ 大）且路由跳变后进入 命题 5.3 的劫持域时，后续所有步的 $\Delta^{err}_j$ 可能持续被激活，级联效应使总跳变量达到 $\sum_{j=j^*}^l \Delta^{err}_j \Theta_{j+1,l} \sim O(D)$（像空间直径级别）。

**证明**：(i) 在第 $j^*$ 步，$\sigma(h_{j^*-1}(x'))$ 与 $\sigma(h_{j^*-1}(x_0))$ 是两条不同的 $f$-链。由 IDFS 的定义，$\Delta^{err}_{j^*}$ 即为两条链在同一输入 $h_{j^*-1}(x')$ 处的输出差异——此差异是路由决策边界的直接物理后果。(ii) 第 $j^*$ 步的误差增量 $\Delta^{err}_{j^*}$ 进入 CAC 递推 $e_{j^*} \leq L_{j^*}e_{j^*-1} + \Delta^{err}_{j^*} + \cdots$，在后续步中被 $\Theta_{j^*+1,l}$ 放大。$\delta_{adv}$ 引起的初始轨道偏差项为 $L^{j^*}\delta_{adv}$，在 $\delta_{adv} \to 0$ 时可忽略，净效果由 $\Delta^{err}_{j^*}\Theta_{j^*+1,l}$ 主导。(iii) 安全域内 $\sigma(h_{j-1}(x_0)) = \sigma(h^*_{j-1})$ 恒成立（路由一致），$\Delta^{err}_j = 0$。跨越边界后的级联激活直接由 命题 5.3 的劫持机制驱动。$\square$

> **注（与 §2.4 正交降阶的对比：Type C 的正交无能）**：§2.4 的路由跳变正交降阶命题证明，当跳变方向变分正交时，路由惩罚的累积从 $\mathcal{O}(\Delta_{max}\Lambda_l)$ 降至 $\mathcal{O}(\Delta_{max}\sqrt{\Lambda_l})$。然而，Type C 的灾难性跳变通常**无法享受此降阶**：在安全域/失控域边界处，路由跳变不是"均匀随机散射"，而是由走廊宽度极限处的**临界路由决策边界**触发的单一事件。受 推论 3.3（同向共线坍缩）的物理机制制约，最危险的跳变恰恰是那些**与系统主特征方向对齐**的跳变——此时 $\Delta^{err}_{j^*}$ 完全沿主本征方向投射，不存在正交分散的余地。正交降阶是"多次独立小跳变"的统计效应；Type C 的灾难则是"单次临界大跳变"的确定性事件——两者的物理机制根本不同。

---


> **注（三种 Type 的特征对比）**：
>
> | 特征维度 | Type A：死记硬背 ($l_{\max}$ 深) | Type B：短链高保真 ($l \le l^*_0$) | Type C：容忍崩溃 ($l > l^*_0$) |
> |-----------|-----------------|--------------------|-----------------|
> | 放弃的核心 | 泛化性（$\gamma_R \approx 1$） | 链深（内部推理受限） | 全路径控制（容忍 $\mathcal{X}_{fail}$） |
> | 关键参数特征 | $\kappa_\Phi \approx 1, L_{max}/\bar{L} \approx 1$ | $\bar{L} \ge 1$ 甚至 $\gg 1$ 合法 | $\mu(\mathcal{X}_{fail}) > 0$ 正测度 |
> | 走廊状态 (§6.1) | 极宽（$\bar{L} \to 0$ 跌落不动点） | **不适用**（前提未触发） | 极窄（甚至为空） |
> | 路由分布 | 宏观**完全简并** (§6.2.1) | 极度细化与差异化 | 安全域内差异化 |
> | 拉伸预算保留 | 全额存活（但丧失插值能力） | **全额存活且受全路径控制** | 安全域内被强制衰减 |
> | 采样依赖 | $|\mathcal{S}| \ge (D|\lambda_r-\bar{L}^l|/\varepsilon)^d$（全域穷举） | 自适应异质网格（高频锚定决策边界） | 边界 $\partial\mathcal{X}_{safe}$ 的易碎覆盖 |
> | 参数代偿 | 无需额外代偿（$M$ 未被利用） | $M \ge \exp((I_\varepsilon-C_\varepsilon)/l^*_0)$（空间换时间） | 无（保留深度杠杆） |
> | 最糟失败模式 | 维度诅咒级别的过拟合 | 单次映射的计算深度瓶颈 | $\delta_{adv}$ 极小致幻、崩溃 (§6.2.3) |
> | §6.1 推论效力 | 全部生效（但无计算意义） | **不适用**（$l \le l^*_0$，前提不满足） | 仅在 $\mathcal{X}_{safe}$ 生效，外围发散 |


#### 6.2.4 构型优选（Architecture Selection）

**推论 6.21（可行构型唯一性，Uniqueness of Feasible Configuration）**——综合 §6.2 三元困境命题与 §6.2.1–§6.2.3 各 Type 命题：设 IDFS $\mathcal{F}$ 需以容差 $\varepsilon$ 逼近高异质性目标集 $R$（$\gamma_R \gg 1$），输入空间 $\mathcal{X}$ 的覆盖维数 $\dim(\mathcal{X}) \gg 1$。则在三元困境中，Type B 是唯一能同时满足此两项最低可行性边界的构型：

1. **误差全域有界性**：对所有输入 $x \in \mathcal{X}$，$\varepsilon(x) \le \tau < \infty$；
2. **采样非指数爆炸**：所需采样点数 $|\mathcal{S}|$ 不随 $\dim(\mathcal{X})$ 呈指数级增长。

**证明**：

- **Type A 违反边界 2**：由 §6.2.1 采样诅咒推论，为维持给定 $\varepsilon$，所需样本数 $|\mathcal{S}| \ge (D|\lambda_r - \bar{L}^l|/\varepsilon)^{\dim(\mathcal{X})}$。在 $\dim(\mathcal{X}) \gg 1$ 下指数爆炸。
- **Type C 违反边界 1**：由 §6.2.3 双峰不可消除性命题，系统必然存在 $\mu(\mathcal{X}_{fail}) > 0$ 的失控域，其内误差可达 $D \gg \tau$。由边界脆弱性推论，$\delta_{adv}$ 极小。
- **Type B 同时合规**：由 §6.2.2 走廊解除命题，$l \le l^*_0$ 保证 $\varepsilon \le E\cdot l \le \tau$（边界 1）。由代偿定律，$M \ge \exp((I_\varepsilon - C_\varepsilon)/l^*_0)$ 与目标集度量熵 $I_\varepsilon$ 而非 $\dim(\mathcal{X})$ 指数耦合（边界 2）。$\square$

**推论 6.22（长链复合的架构必然性，Architectural Necessity of Long-Chain Composition）**——上述可行构型唯一性推论的直接引申：设 IDFS $\mathcal{F}$ 为 Type B 系统（$l \le l^*_0$），但需完成等效链深 $l_{eff} \gg l^*_0$ 的复合任务。则：

(i) **内部自迭代必崩**：若将 $\mathcal{F}$ 以首尾相接方式自迭代 $l_{eff}/l$ 次（$\Phi^{l_{eff}}$），系统退化为 Type C，由 §6.2.3 双峰命题，必然存在正测度的失控域。

(ii) **外显离散重置为唯一逃逸**：要在遂行 $l_{eff}$ 深度任务的同时保持 Type B 的全域有界性，系统必须在每至多 $l^*_0$ 步后将中间输出**离散化并经外部验证**，执行一次**误差重置（Error Reset）**——将连续流形上的 $\bar{L}^l$ 乘性累积截断为独立的短链段。

(iii) **复合体的必然形态**：因此，能执行 $l_{eff} \gg l^*_0$ 复合任务的 IDFS 的物理实体必然是一个**双层结构**：一个 Type B 浅层高保真内核（负责单步/短链的精确映射），外挂于一个具备离散误差重置能力的外显控制环（负责链路调度与累积误差清零）。系统的链最大计算深度不再受 $l^*_0$ 限制，而是受外部控制环的重置频率与调度精度限制。

**证明**：

(i) $\Phi^{l_{eff}}$ 等价于一个链深为 $l_{eff}$ 的 IDFS。当 $l_{eff} > l^*_0$ 时，推论 6.2（长链收缩必要性）再次生效：系统要么被迫 $\bar{L} < 1$（进入走廊），要么违反 CAC。由 §6.2.3 双峰命题，正测度的 $\mathcal{X}_{fail}$ 不可避免。

(ii) 若在第 $k$ 步（$k \le l^*_0$）将 $h_k = \Phi^k(x)$ 的输出离散化为符号 $s_k$，并以 $s_k$（而非 $h_k$ 本身）作为下一段 $\Phi$ 的输入。离散化操作将连续流形上累积的拓扑偏差投影至离散码本，使得 $\bar{L}^k$ 的乘性累积被强制截断。新一段 $\Phi$ 从离散锚点 $s_k$ 重新启动，独立于前段的连续误差。每段长度 $\le l^*_0$，Type B 的全域有界性在段内生效。

(iii) 由 (i) 和 (ii)，$l_{eff}$ 深度任务在 Type B 约束下的唯一可行实现方式是将其分解为 $\lceil l_{eff}/l^*_0 \rceil$ 个独立短链段的串联，段间以离散重置连接。这天然要求一个外部控制层来管理段的调度、重置和验证。$\square$

> **注（Type B 的抗劫持鲁棒性：构型优选的第三条论证，与 命题 5.3–4 的对接）**：命题 5.6 证明了在固定系统容量下，采样集 $\mathcal{S}$ 的扩增使最优可达拟合效果**单调非递增**——特别是模式 B（新采样对追加）的净效果恒为负，因为新约束通过 命题 5.3 的劫持机制锁死 $\Phi$ 在中间态域的行为。这为 Type B 的构型唯一性在误差全域有界性和采样非指数爆炸两个边界之外提供了**第三条独立论证**：
>
> - **Type A 受劫持恶化**：Type A 的全域穷举策略要求 $|\mathcal{S}|$ 极大。每追加一批采样对，命题 5.6 模式 B 保证可行集进一步收缩，且新采样在域外的锁定效应通过劫持机制**结构性地恶化**已有链路的性能——这不仅是维度诅咒的采样代价，更是采样本身的**自毒化效应**。
> - **Type C 受劫持剧烈**：由上方注记，失控域 $\mathcal{X}_{fail}$ 的误差发散恰恰由劫持机制驱动。$|\mathcal{S}|$ 越大，中间态轨道途经"已被其他采样对锁定"的区域的概率越高，劫持发生得越频繁，失控域的实际危害越严重。
> - **Type B 天然抗劫持**：链深 $l \le l^*_0$ 极短，中间态 $h_j$ 偏离初始采样域的累积漂移有限（$\delta$ 增长被截断在 $E \cdot l^*_0 = \tau$ 以内），被不相关采样对劫持的几率受到结构性抑制。更关键的是，分段复合架构中的离散重置——码本 $\mathcal{C}$——将中间态强制拉回受控的锚点集合，从根本上阻止了中间态漂移进入劫持域。

> **注（离散重置的反劫持锚点解释，与 命题 5.3 的深层对接）**：§7.2 误差隔绝定理从代数层面证明了离散重置截断 $\Theta_{1,l}$ 的乘性累积。但从 §5 的视角审视，码本 $\mathcal{C}$ 的功能远不止截断乘性传播——它更根本地是一个**反劫持锚点集**。在无重置的连续长链中，中间态 $h_j$ 的累积漂移使其逐步远离初始采样域，不可避免地进入由其他采样对锁定的"他方领地"（命题 5.3 的劫持域）。码本 $\mathcal{C}$ 通过在每段终点将中间态投影回码本元素——一个系统行为被精确控制的锚点——来**强制阻止链路穿越劫持域的边界**。因此，码本的功能在度量空间层面是"重置误差"，但在 $\Phi$ 的行为空间层面是"将轨线拉回安全领地"。这两个解释互补而非重复：前者是定量的（误差界），后者是定性的（行为安全性）。
