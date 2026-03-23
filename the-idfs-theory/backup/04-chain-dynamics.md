## 复合链的信号动力学

§2 分别考察了三态的内部几何——碎裂步的链断裂（命题 2.1）、收缩步的信息不可逆丧失（命题 2.8）、保持步的全方向信号保持（命题 2.9）。但这些结果是逐态陈述的。本节将它们统一为一个关于**多步复合链**的信号传播理论：给定一条链的形态序列，其整体信号容量由什么决定？

---

### 4.1 形态序列与链分类

**定义（形态序列）**：设 $q = r_{i_l} \circ \cdots \circ r_{i_1}$ 为 $l$ 步复合链。定义 $q$ 的**形态序列（Morphological Word）**为：

$$w(q) \;=\; (m_1, m_2, \ldots, m_l) \qquad m_j \in \{P, C, F\}$$

其中 $m_j$ 为步骤 $j$ 在 $(τ, η)$-三态分类下的形态（$P$ = 保持，$C$ = 收缩，$F$ = 碎裂）。

**定义（链分类）**：根据形态序列，将复合链分为三类：

- **$F$-链**：$\exists\, j,\; m_j = F$。链中包含碎裂步。
- **$C$-链**：$\forall\, j,\; m_j \neq F$，且 $\exists\, j,\; m_j = C$。链不含碎裂步但包含收缩步。
- **$P$-链**：$\forall\, j,\; m_j = P$。链中每一步都处于保持态。

**定义（信号覆盖数）**：设集合 $A \subseteq \mathcal{X}$，其 **$\tau$-覆盖数** $\mathcal{N}_\tau(A)$ 为 $A$ 的极大 $\tau$-分离子集的大小（即 $\tau$-分辨率下可区分的点数）。

**定义（洁净路径信号集）**：设 $q = r_{i_l} \circ \cdots \circ r_{i_1}$ 为 $l$ 步复合链，初始输入集 $X_0 \subseteq \mathcal{X}$。定义经过前 $j$ 步后仍在**洁净路径**上的输入子集为：

$$\mathcal{S}_{clean}(q, j) \;\triangleq\; \{x \in X_0 : \Phi^k(x) \in U_{\alpha_k}^{clean} \;\;\forall\, k = 1, \ldots, j\}$$

其中 $\alpha_k$ 为 $\Phi^{k-1}(x)$ 所在路由分区的索引，$U_{\alpha_k}^{clean}$ 为该分区的 $\tau$-洁净集（§2 定义 2.3.1）。$\mathcal{S}_{clean}$ 包含度量拥挤下的 $\sigma$-奇异域不存在洁净集的点则自然被排除。

**命题 4.1（形态信道定理）**：

**(a) 洁净路径保持 $\tau$-分离**：对任意 $x, y \in \mathcal{S}_{clean}(q, l)$，若 $d(x, y) \geq \tau$，则 $d(\Phi^l(x), \Phi^l(y)) \geq \tau$。因此：

$$\mathcal{N}_\tau\!\left(\Phi^l(\mathcal{S}_{clean}(q, l))\right) \;\geq\; \mathcal{N}_\tau\!\left(\mathcal{S}_{clean}(q, l)\right)$$

**(b) 洁净路径的逐步过滤**：$\mathcal{S}_{clean}(q, j) \subseteq \mathcal{S}_{clean}(q, j-1)$（添加一步只可能过滤掉轨迹），且：

- **$F$-步**（$m_j = F$）：碎裂态分区无洁净集（$\mathrm{rad}_\sigma < \tau$，§2 命题 2.1），故 $\mathcal{S}_{clean}(q, j) = \emptyset$。
- **$C$-步**（$m_j = C$）：$\mu(U_{\alpha_j}^{clean}) \leq \eta \cdot \mu(U_{\alpha_j})$（§2 命题 2.7 对偶），故到达步骤 $j$ 的轨迹中**至多 $\eta$ 比例**保留在洁净路径上。
- **$P$-步**（$m_j = P$）：$\mu(U_{\alpha_j}^{clean}) \geq \eta \cdot \mu(U_{\alpha_j})$（§2 命题 2.9），故**至少 $\eta$ 比例**保留在洁净路径上。

**证明**：

(a) 归纳法。$j = 0$ 平凡。设 $d(\Phi^{j-1}(x), \Phi^{j-1}(y)) \geq \tau$ 对 $x, y \in \mathcal{S}_{clean}(q, j)$ 成立。由 $\mathcal{S}_{clean}$ 的定义，$\Phi^{j-1}(x), \Phi^{j-1}(y) \in U_{\alpha_j}^{clean}$。由 $\tau$-洁净性：$d(z_1, z_2) \geq \tau \Rightarrow d(\Phi(z_1), \Phi(z_2)) \geq \tau$。因此 $d(\Phi^j(x), \Phi^j(y)) \geq \tau$。归纳完成。

$\tau$-分离对在映射后保持分离，故像集的覆盖数不低于原集。$\square$

(b) $\mathcal{S}_{clean}(q, j) = \mathcal{S}_{clean}(q, j-1) \cap \{x : \Phi^j(x) \in U_{\alpha_j}^{clean}\}$，交集只能缩小。三类步骤的洁净集比例由 §2 命题 2.1/2.7/2.9 直接给出。$\square$

> **推论（链分类的信号容量瓶颈）**：
>
> - **$F$-链**：$\mathcal{S}_{clean}(q, l) = \emptyset$，有效信号归零。
> - **$C$-链**（$n_C$ 个 $C$-步，$n_P$ 个 $P$-步）：$\mathcal{N}_\tau(\Phi^l(\mathcal{S}_{clean})) \geq \mathcal{N}_\tau(\mathcal{S}_{clean}(q, l))$，但 $\mathcal{S}_{clean}$ 在每个 $C$-步处被过滤至 $\leq \eta$ 比例。在轨迹均匀分布假设下，$\mu(\mathcal{S}_{clean}(q, l)) \leq \eta^{n_C} \cdot \eta^{n_P} \cdot \mu(X_0) \approx \eta^l \cdot \mu(X_0)$——洁净路径**指数衰减**。
> - **$P$-链**（全 $P$-步）：每步至少保留 $\eta$ 比例洁净轨迹，$\mu(\mathcal{S}_{clean}(q, l)) \geq \eta^l \cdot \mu(X_0)$。$P$-链是唯一使洁净路径**以最慢速率衰减**（每步仅损失 $1-\eta$）的链类型，是 $R^*$ 复合中的**最优信道**。

> **注（为何非洁净路径不可计数）**：在洁净路径之外的轨迹（经过坍缩区 $C_\tau$ 的轨迹）并非全部失效——它们中的一部分可能幸运地避开了实际坍缩。但这些轨迹的 $\tau$-分离性**无法被 $\tau$-洁净性定义保证**，因此不能纳入可验证的下界。命题 4.1 提供的是一个**严格的可验证下界**，而非精确计数。

---

### 4.2 保持链的域宽下界

$P$-链是唯一有效的复合信道。那么 $P$-链各步的拟合域宽受什么约束？本小节证明：保持态的有效域宽不是自发的，它被上游流入的信号多样性**从下方定量支撑**。

#### 轨迹可达性假设

旧 §3 的"关联采样性公设"在纯度量框架下需要替换。核心假设是关于 $\Phi$ 的动力学轨迹——不同规则通过 $\Phi$ 的复合流相互耦合。

**假设（轨迹可达性，Trajectory Reachability）**：设 $q = r_{i_l} \circ \cdots \circ r_{i_1}$ 为 $P$-链。称步骤 $j$ 的规则 $r_{i_j}$ 被步骤 $k < j$ 的规则 $r_{i_k}$ **轨迹可达**，若存在 $x \in P_{\tau'}(r_{i_k})$ 使得 $\Phi^{j-k}(x) \in U_\alpha$（$U_\alpha$ 为 $r_{i_j}$ 的路由分区）——即 $\Phi$ 的实际轨迹从 $r_{i_k}$ 的拟合域出发，经 $j - k$ 步后抵达 $r_{i_j}$ 的路由分区。

> **注（与旧"关联采样性"的对比）**：旧公设要求"存在链 $q$ 使 $r_i, r_j$ 在代数串中共现"。轨迹可达性更强也更精确——它要求**$\Phi$ 的实际动力学轨迹**连接两个规则的作用域，而非仅仅代数共现。代数共现不保证几何连通；轨迹可达直接构建在度量空间的动力学上。

#### 域宽下界定理

**定义（信号源像集）**：设 $P$-链 $q$ 中步骤 $j$ 被步骤 $k$ 轨迹可达。定义从步骤 $k$ 流入步骤 $j$ 的**信号源像集**为：

$$S_{k \to j} \;\triangleq\; \Phi^{j-k}(P_{\tau'}(r_{i_k})) \;\cap\; U_\alpha$$

即 $r_{i_k}$ 的拟合域经 $\Phi$ 映射 $j - k$ 步后落入 $r_{i_j}$ 路由分区 $U_\alpha$ 内的部分。

**命题 4.2（保持态域宽的信号源下界）**：设 $S_{k \to j}$ 的所有输入被 $\Phi$ 单步映射拟合 $r_{i_j}$ 的误差存在一致上界 $\varepsilon_j \triangleq \sup_{z \in S_{k \to j}} d(\Phi(z), r_{i_j}(z)) < \tau'$（这由有效复合链的稳定性保证），提供拟合容差裕度 $\Delta \tau = \tau' - \varepsilon_j > 0$。记 $L_r$ 为目标 $r_{i_j}$ 的 Lipschitz 常数，定义**有效裕度半径**：

$$\rho^*_j \;\triangleq\; \frac{\Delta \tau}{L + L_r}$$

若 $S_{k \to j}$ 的 $2\rho^*_j$-覆盖数为 $\mathcal{N}_{2\rho^*_j}(S_{k \to j})$，则 $r_{i_j}$ 的有效拟合域满足严格测度下界：

$$\mu\bigl(P_{\tau'}(r_{i_j})\bigr) \;\geq\; \mathcal{N}_{2\rho^*_j}(S_{k \to j}) \;\cdot\; \mu_{min}\bigl(B(x, \rho^*_j)\bigr)$$

其中 $\mu_{min}(B(x, r)) \triangleq \inf_{x \in \mathcal{X}} \mu(B(x, r))$ 为度量空间中半径 $r$ 球的最小测度。

**证明**：

取 $S_{k \to j}$ 的极大 $2\rho^*_j$-分离子集 $\{z_1, \ldots, z_N\}$，$N = \mathcal{N}_{2\rho^*_j}(S_{k \to j})$。各点彼此间距 $\geq 2\rho^*_j$。

每个 $z_m \in S_{k \to j}$ 是链的轨迹点，满足拟合误差 $d(\Phi(z_m), r_{i_j}(z_m)) \leq \varepsilon_j$。对任意 $z' \in B(z_m, \rho^*_j)$，由 $\Phi$ 和 $r_{i_j}$ 的 Lipschitz 连续性及三角不等式：

$$d(\Phi(z'), r_{i_j}(z')) \;\leq\; d(\Phi(z'), \Phi(z_m)) + d(\Phi(z_m), r_{i_j}(z_m)) + d(r_{i_j}(z_m), r_{i_j}(z'))$$
$$\;\leq\; L\rho^*_j + \varepsilon_j + L_r\rho^*_j \;=\; (L+L_r)\rho^*_j + \varepsilon_j \;=\; \Delta\tau + \varepsilon_j \;=\; \tau'$$

因此整个球域 $B(z_m, \rho^*_j) \subseteq P_{\tau'}(r_{i_j})$。

由于点集是 $2\rho^*_j$-分离的，这 $N$ 个以 $z_m$ 为中心、半径为 $\rho^*_j$ 的球内部两两不交。它们的测度总和构成 $P_{\tau'}(r_{i_j})$ 的子集：
$\mu(P_{\tau'}(r_{i_j})) \geq \sum_{m=1}^N \mu(B(z_m, \rho^*_j)) \geq N \cdot \mu_{min}(B(x, \rho^*_j))$。$\square$

> **注（域宽的因果方向）**：命题 4.2 确立了 $\mu(P_{\tau'}(r_{i_j})) \leftarrow \mathcal{N}_{\tau/(2L)}(S_{k \to j}) \leftarrow \mu(P_{\tau'}(r_{i_k}))$ 的因果连结。上游拟合域越宽、其像集在下游分区中的覆盖数越大，下游的有效域宽就越大。**没有上游信号源的注入，就不可能有下游的宽域拟合**——保持态的域宽不是自发产生的，而是被复合链的动力学轨迹从上游带入的。

> **注（收缩态上游的退化效应）**：若步骤 $k$ 处于收缩态（$C$-链的一部分），则 $\Phi^{j-k}(P_{\tau'}(r_{i_k}))$ 的覆盖数受 $\tau$-纤维坍缩的影响——胖纤维将多个 $\tau/(2L)$-分离的输入映射到不可分离的输出簇中，$\mathcal{N}_{\tau/(2L)}(S_{k \to j})$ 被压缩。这从覆盖数的角度重新证实了收缩态对下游域宽的抑制效应。

----
*[IDFS] ⊢ [GLENZLI] ⊢ [Part XX] ⊢ [04-chain-dynamics] ⊢ [45f2d6a88372c43e]*
