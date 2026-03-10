## 受限 IDFS

在 §3 中，CAC 定理给出了宏观误差的上界——系统的端到端误差**不超过** $\varepsilon_{\max} \cdot \Lambda_l + \delta_{\max} \cdot \Gamma_l$。在 §4 中，CAB 定理给出了误差的下界——在目标变分足够剧烈时，系统的端到端误差**不低于** $|\Delta - \varepsilon_x| - \Theta_{1,l} \cdot \delta$。当一个 IDFS 同时面对这两个约束时——既要泛化误差可控（CAC 不爆炸），又要保持对目标的判别能力（CAB 不退化）——系统的核心参数 $\Theta_{j,l}$（路径局部 Lipschitz 乘积）将被双向夹击至一个狭窄的走廊之中。

### 5.1 完美系统假设下的 $\Theta$ 约束

> **前提（完美系统假设）**：本节的所有推导均基于以下理想化前提——对**同一条目标链** $q$，系统**同时满足** CAC 可控性（$\varepsilon^*_q \leq \tau$）和 CAB 判别性（末端分离度 $s > 0$）。这等价于要求系统在该路径上既不发生误差爆炸，也不丧失区分不同输入的能力。§5.2 将论证此前提为何在全路径层面不可满足。

#### 命题（Lipschitz 乘积的双界夹击，Dual-Bound Squeeze on $\Theta$）

**命题**：设 IDFS $\mathcal{F} = (F, \sigma)$，$\Phi \in \mathrm{Lip}(\mathcal{X})$，链长为 $l$。记 $\bar{L} = (\Theta_{1,l})^{1/l}$ 为路径局部 Lipschitz 常数的**几何均值**。若系统同时满足：

1. **上界约束（CAC 可控性）**：宏观容差被限定在安全阈值内，$\varepsilon^*_q \leq \tau$；
2. **下界约束（CAB 判别性）**：存在目标链 $q$ 及输入对 $(x, y)$，$d(x,y) = \delta$，$d(q(x), q(y)) = \Delta$，使得拓扑死锁界为正：$\Delta - \varepsilon_x - \Theta_{1,l} \cdot \delta > 0$。

则 $\Theta_{1,l}$ 被夹击于：

$$\frac{\Delta - \varepsilon_x - \tau}{\delta} \;\leq\; \Theta_{1,l} \;\leq\; \frac{\tau - \varepsilon_{\max} \cdot \Lambda_l'}{\delta_{\max}}$$

其中 $\Lambda_l' = \sum_{j=1}^l \Theta_{j+1,l}$（误差累积放大系数，不含首步的 Lipschitz 乘积）。

#### 证明

**上界方向**：由 CAC 定理（§3.1），$\varepsilon^*_q \leq \varepsilon_{\max} \cdot \Lambda_l + \delta_{\max} \cdot \Gamma_l \leq \tau$。由 $\Gamma_l = \sum_j L_j \Theta_{j+1,l} \leq \bar{L}_{\max} \Lambda_l$，整理得 $\Theta_{1,l} \leq \bar{L}^l$ 必须满足 $\Lambda_l$ 不超过 $\tau / (\varepsilon_{\max} + \bar{L}_{\max} \delta_{\max})$。特别地，若 $\bar{L} > 1$，则 $\Lambda_l \sim \bar{L}^l / (\bar{L} - 1) \to \infty$，必然在有限深度内违约。

**下界方向**：由 CAB 定理（§4.1），$\varepsilon^*_y \geq |\Delta - \varepsilon_x| - \Theta_{1,l} \cdot \delta$。若要求此下界为正（即系统确实存在不可压缩的拟合残差），则 $\Theta_{1,l} < (\Delta - \varepsilon_x) / \delta$。反之，若 $\Theta_{1,l}$ 过小——即 $\bar{L} < 1$（系统为全局收缩映射）——则 $\Theta_{1,l} = \bar{L}^l \to 0$，CAB 下界退化为 $\varepsilon^*_y \geq \Delta - \varepsilon_x$，看似下界仍在。然而，由 §2 命题 4，全局收缩将系统的判别能力彻底压平：对任意 $a, b \in \mathcal{X}$，$d(\Phi^l(a), \Phi^l(b)) \leq \bar{L}^l \cdot d(a, b) \to 0$，系统在长链极限下将一切初始差异——包括不同输入之间的区分——映射为零。这意味着 $\Phi_q(x) \approx \Phi_q(y)$，系统丧失了在 $x$ 和 $y$ 之间做出不同响应的能力，从而**无法对任何具有非零变分的目标链 $q$ 实现有效拟合**。

综合两个方向：$\Theta_{1,l}$（及其几何均值 $\bar{L}$）被同时从上方和下方挤压。$\square$

#### 推论 1（长链收缩性，Long-Chain Contractivity）

**推论**：若 $l > l^*_0 = \tau / E$（$E = \varepsilon_{\max} + \delta_{\max}$），则序列 $\{L_j\}$ 中**不可能所有分量都 $\geq 1$**——系统必须在至少某些步骤上执行收缩。特别地，在均匀情况（$L_j = \bar{L}$）下，$\bar{L} < 1$。

**证明**：若所有 $L_j \geq 1$，则每个尾积 $\Theta_{k+1,l} = \prod_{j=k+1}^l L_j \geq 1$，故 $\Lambda_l = \sum_{k=0}^{l-1} \Theta_{k+1,l} \geq l$。同时 $\varepsilon_{\max} + L_j\delta_{\max} \geq E$ 对每个 $j$ 成立。因此 $\varepsilon_{\max} \cdot \Lambda_l + \delta_{\max} \cdot \Gamma_l \geq E \cdot l > E \cdot l^*_0 = \tau$，违反 CAC 约束。$\square$

> **注**：此推论对一般非均匀 $\{L_j\}$ 成立，不要求均匀假设。

#### 推论 2（收缩走廊，Contraction Corridor）

**定义（Lipschitz 分散度）**：设 $\bar{L} = (\Theta_{1,l})^{1/l}$ 为路径局部 Lipschitz 常数的几何均值。定义 **Lipschitz 分散度** $\kappa \geq 1$ 为满足 $L_j \in [\bar{L}/\kappa,\; \kappa\bar{L}]$（$\forall j$）的最小常数。$\kappa = 1$ 对应均匀情况，$\kappa > 1$ 允许逐步变化。

**推论**：设 $l > l^*_0$（长链态），系统需维持最小输出分离度 $s > 0$（$d(\Phi^l(x), \Phi^l(y)) \geq s$，$d(x,y) = \delta$）。记 $\rho = \delta/s$ 为**空间压缩比**。以 $\beta = -\ln\bar{L} > 0$ 参数化，$\bar{L}$ 被约束于走廊：

$$\beta \;\in\; \left[\ln\kappa + \frac{1}{l^*_0},\;\; \frac{\ln\rho}{l}\right]$$

等价地：

$$\rho^{-1/l} \;\leq\; \bar{L} \;\leq\; \frac{e^{-1/l^*_0}}{\kappa}$$

**证明**：

- **上界**（CAC 强制收缩）：由 $L_j \leq \kappa\bar{L}$，尾积 $\Theta_{k+1,l} \leq (\kappa\bar{L})^{l-k}$，故 $\Lambda_l \leq \sum_{k=0}^{l-1}(\kappa\bar{L})^{l-k}$。对 $\kappa\bar{L} < 1$ 且 $l$ 充分大，$\Lambda_l \leq 1/(1 - \kappa\bar{L})$。代入 CAC 约束 $E \cdot \Lambda_l \leq \tau$，得 $1 - \kappa\bar{L} \geq 1/l^*_0$，即 $\bar{L} \leq (1 - 1/l^*_0)/\kappa \approx e^{-1/l^*_0}/\kappa$。以 $\beta$ 参数化：$\beta \geq \ln\kappa + 1/l^*_0$。
- **下界**（判别性托底）：$\Theta_{1,l} = \bar{L}^l \geq s/\delta = 1/\rho$，即 $\beta \leq \ln\rho / l$。$\square$

> **注（$\kappa$ 的作用）**：$\kappa$ 量化了系统逐步 Lipschitz 常数的非均匀性。$\kappa > 1$ 时，走廊上界被压低 $\kappa$ 倍——系统必须"多收缩" $\ln\kappa$ 来偿还非均匀性引入的最坏步放大代价。$\kappa = 1$ 恢复均匀走廊 $\bar{L} \in [\rho^{-1/l},\; e^{-1/l^*_0}]$。

#### 推论 3（最大可行链深，Maximum Viable Chain Depth）

**推论**：由推论 2 的走廊非空条件，系统的最大可行链深为：

$$l_{\max} \;=\; \frac{\ln\rho}{\ln\kappa + 1/l^*_0}$$

超过 $l_{\max}$ 后，收缩走廊为空。

**证明**：由推论 2，走廊非空要求 $\ln\kappa + 1/l^*_0 \leq \ln\rho / l$，即 $l \leq \ln\rho / (\ln\kappa + 1/l^*_0)$。$\square$

> **注（$l_{\max}$ 的两态极限）**：
> - **高精度系统**（$l^*_0$ 大，$1/l^*_0 \ll \ln\kappa$）：$l_{\max} \approx \ln\rho / \ln\kappa = \log_\kappa \rho$。最大链深仅取决于非均匀性 $\kappa$ 和压缩比 $\rho$，与系统精度无关。
> - **低非均匀系统**（$\kappa \to 1$，$\ln\kappa \ll 1/l^*_0$）：$l_{\max} \approx l^*_0 \ln\rho$。恢复均匀极限。
>
> 链深对压缩比始终仅有**对数依赖**。

#### 推论 4（渐近等距极限，Asymptotic Isometry）

**推论**：由推论 2 的走廊上界，在 $l^*_0 \to \infty$（系统精度趋于完美）且 $\kappa$ 有界的极限下，最优 $\bar{L}^* \to 1/\kappa$——系统趋向**以 $\kappa$ 为尺度的准等距映射**。$\kappa = 1$ 时退化为严格等距。

**证明**：走廊上界 $e^{-1/l^*_0}/\kappa \to 1/\kappa$，下界 $\rho^{-1/l}$ 在 $l$ 适中时趋近 1。最优 $\bar{L}^*$ 在上界处取得。$\square$

> **注（收缩的物理含义）**：长链 IDFS 不可能是扩张的，而必须是轻度收缩的。系统在每一步平均压缩微量空间体积，以换取误差累积的有界性。非均匀性越大（$\kappa$ 越大），系统被迫收缩得越多——因为最"放肆"的步骤（$L_j = \kappa\bar{L}$）决定了误差累积的最坏情况。

> **注（与 CAC 推论 2 三态行为的关系）**：CAC 推论 2 将 $\Theta_{j,l}$ 的行为分为扩张、稳定、饱和三态。本命题表明，在 CAC+CAB 双重约束下，**只有稳定态的轻度收缩子区域是长链极限下唯一可行的工程态**。扩张态因 CAC 爆炸而不可持续，饱和态的过度收缩违反判别性。

### 5.2 IDFS 不可能三元困境

§5.1 的分析建立在完美系统假设上——单条路径同时满足 CAC 与 CAB。本节论证：当系统需要逼近多样化的目标规则集 $R$ 时，完美系统假设在**全路径层面不可同时满足**。

#### 命题（泛化-深度-控制不可能三元组，Generalization-Depth-Control Trilemma）

**定义（目标 Lipschitz 多样性）**：设目标规则集 $R$ 中包含 Lipschitz 常数各异的规则。定义 $R$ 的 **Lipschitz 跨度**为 $\gamma_R = \sup_{r \in R} \mathrm{Lip}(r) \;/\; \inf_{r \in R} \mathrm{Lip}(r)$。$\gamma_R = 1$ 表示所有目标规则具有相同的 Lipschitz 常数，$\gamma_R \gg 1$ 表示 $R$ 包含收缩与扩张行为差异极大的规则。

**命题**：设 IDFS $\mathcal{F} = (F, \sigma)$ 需以容差 $\varepsilon$ 逼近规则集 $R$ 中的所有链。则以下三个性质不可同时满足：

1. **泛化性**（Generalization）：$R$ 具有高 Lipschitz 跨度 $\gamma_R \gg 1$。
2. **链深**（Depth）：系统支持长链推理 $l \gg l^*_0$。
3. **全路径控制**（Full-Path Control）：系统在所有目标链上同时满足 CAC+CAB。

**证明**：

系统 $\Phi$ 是一个**单一映射**，其局部 Lipschitz 常数 $L_j$ 由 $\Phi$ 在中间态 $h_{j-1}$ 处的局部行为决定。不同的目标链 $q$ 经过不同的中间态序列，产生不同的 $\{L_j\}$ 序列。

**泛化性 $\to$ 大 $\kappa$**：若 $R$ 包含 Lipschitz 常数差异极大的规则（$\gamma_R \gg 1$），则 $\Phi$ 在不同区域必须表现出截然不同的局部 Lipschitz 行为——在某些区域近似强收缩规则（$L_j \ll 1$），在另一些区域近似强扩张规则（$L_j \gg 1$）。由 §2.3 命题 6，基函数库的 Lipschitz 跨度 $\kappa_F \geq \gamma_R \gg 1$。因此系统在逼近不同目标时展现出的路径 Lipschitz 分散度 $\kappa$ 同样至少为 $\mathcal{O}(\gamma_R)$。

**大 $\kappa$ $\to$ 短 $l_{\max}$**：由 §5.1 推论 3，$l_{\max} = \ln\rho / (\ln\kappa + 1/l^*_0)$。$\kappa \sim \gamma_R \gg 1$ 时，$l_{\max} \approx \log_{\gamma_R} \rho$，随 $\gamma_R$ 对数衰减——链深被 $R$ 的多样性碾压。

**长链 + 泛化 $\to$ 失控**：若强行要求 $l \gg l_{\max}$，则收缩走廊（§5.1 推论 2）为空，不存在合法的 $\bar{L}$。系统必须在某些路径上违反 CAC（误差爆炸）或违反 CAB（判别力丧失）。$\square$

> **注（等距陷阱）**：一个自然的逃逸尝试是令 $\Phi$ 为全局等距映射（$L_j \equiv 1$，$\kappa = 1$），从而获得最大链深 $l_{\max} = l^*_0 \ln\rho$。然而，等距 $\Phi$ 只能精确逼近**同样是等距的**目标规则。对于 $\mathrm{Lip}(r) \neq 1$ 的规则，逼近误差 $\varepsilon_r$ 至少为 $|\mathrm{Lip}(r) - 1| \cdot \mathrm{diam}(\mathcal{X}_r)$ 量级——即等距消灭了 $\kappa$，但代价是 $\varepsilon_{\max}$ 的飙升，同样通过 CAC 压缩了有效链深。泛化能力与链深的张力是**内禀的**、不可通过任何单一策略规避的。

> **注（三选二的工程态）**：
> - **放弃泛化性**（小 $\gamma_R$）：系统专注于 Lipschitz 常数相近的规则子集（"专家系统"）。$\kappa$ 小，链深大。
> - **放弃链深**（短链推理）：系统容忍 $l$ 较短，通过外部机制（如搜索、回溯、分而治之）弥补深度不足。
> - **放弃全路径控制**（容忍部分失控）：系统接受在高 $\kappa$ 路径上 CAC 或 CAB 被违反。$\sigma$ 可选择性地将困难输入路由到短链路径上，以路径感知的方式在全局层面做最优分配。这是现实系统的典型选择。
