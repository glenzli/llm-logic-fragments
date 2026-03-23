# 离散码本重置（Draft）

> 本节内容原位于 part-02 §8.2，后因 §8.2 抽象化为通用外部干预算子 $\psi$ 而迁出。当 $\mathcal{X}$ 具有离散/token 结构时，$\psi$ 的自然实例化即为码本投影——本节形式化这一具体实现。

---

## 定义（重置码本与量化映射）

设 $\mathcal{C} \subset \mathcal{X}$ 为有限集，称为**重置码本（Reset Codebook）**，$\lvert\mathcal{C}\rvert < \infty$。定义码本的**最小间距（Minimum Spacing）**为：

$$\Delta_{\mathcal{C}} \;\triangleq\; \min_{c, c' \in \mathcal{C},\, c \neq c'} d(c, c')$$

定义**量化映射（Quantization Map）** $\pi: \mathcal{X} \to \mathcal{C}$ 为最近邻投影：

$$\pi(x) \;\triangleq\; \arg\min_{c \in \mathcal{C}}\; d(x, c)$$

（歧义时取任意一个最近邻。）定义**量化残差（Quantization Residual）**：

$$\delta_\pi \;\triangleq\; \sup_{x \in \mathcal{X}}\; d(x, \pi(x))$$

> **注（码本的度量空间定义）**：$\mathcal{C}$、$\Delta_{\mathcal{C}}$、$\pi$、$\delta_\pi$ 的定义完全基于度量空间 $(\mathcal{X}, d)$，不引入任何向量空间结构、概率测度或维度假设。

> **注（码本作为 $\psi$ 的实例化）**：在 §8.2 的抽象框架中，外部干预算子 $\psi: \mathcal{X} \to \mathcal{X}$ 的缩减质量由残余误差上界 $\delta_\psi$ 刻画。码本投影 $\pi$ 是 $\psi$ 的一个具体实例，其 $\delta_\psi = \delta_\pi$（量化残差）。

---

## 误差隔绝定理（码本特化版）

**定理（误差隔绝，Error Isolation）**：设 Type II 系统 $\Phi$ 的段内误差满足 $\varepsilon^*_{q^{(k)}} \le \tau$（对所有段 $k$ 和所有段内起点 $c \in \mathcal{C}$ 成立）。若码本 $\mathcal{C}$ 满足以下**信道编码条件（Channel Coding Condition）**：

$$\tau \;<\; \frac{\Delta_{\mathcal{C}}}{2}$$

且理想目标链的每段终点落在码本元素的 $\Delta_{\mathcal{C}}/2$-邻域内（即 $\forall k,\; d(q^{(k)}(x^*_k),\, \mathcal{C}) < \Delta_{\mathcal{C}}/2 - \tau$），则量化映射 $\pi$ 在每段终点处**必然正确解码**：

$$\pi(\hat{h}^{(k)}) \;=\; \pi(q^{(k)}(x^*_k)) \;=\; c^*_k$$

其中 $c^*_k \in \mathcal{C}$ 为理想目标链第 $k$ 段终点的最近码本元素。从而：

1. **段间误差精确归零**：第 $k+1$ 段的实际起点 $\tilde{x}_k = c^*_k$ 与理想起点 $x^*_{k+1}$ 均为同一码本元素，初始偏差为零。
2. **多段误差常界**：对任意段数 $n$，每段的端到端误差恒满足 $d(\hat{h}^{(k)}, q^{(k)}(x^*_k)) \le \tau$，与 $n$ 无关。

**证明**：

对第 $k$ 段，系统从码本点 $\tilde{x}_{k-1} = c^*_{k-1}$ 出发（第 1 段从 $x_0 \in \mathcal{C}$ 出发）。由归纳假设，$\tilde{x}_{k-1} = x^*_k$（实际起点等于理想起点的码本投影）。

段内误差由 Type II 保证：
$$d(\hat{h}^{(k)}, q^{(k)}(x^*_k)) \;\le\; \tau$$

记 $c^*_k = \pi(q^{(k)}(x^*_k))$ 为理想终点的最近码本元素。由前提条件：
$$d(q^{(k)}(x^*_k),\, c^*_k) \;<\; \frac{\Delta_{\mathcal{C}}}{2} - \tau$$

由三角不等式：
$$d(\hat{h}^{(k)},\, c^*_k) \;\le\; d(\hat{h}^{(k)},\, q^{(k)}(x^*_k)) + d(q^{(k)}(x^*_k),\, c^*_k) \;<\; \tau + \frac{\Delta_{\mathcal{C}}}{2} - \tau \;=\; \frac{\Delta_{\mathcal{C}}}{2}$$

现考察任意其他码本元素 $c' \in \mathcal{C}$，$c' \neq c^*_k$。由码本间距定义和三角不等式：
$$d(\hat{h}^{(k)},\, c') \;\ge\; d(c^*_k,\, c') - d(\hat{h}^{(k)},\, c^*_k) \;\ge\; \Delta_{\mathcal{C}} - \frac{\Delta_{\mathcal{C}}}{2} \;=\; \frac{\Delta_{\mathcal{C}}}{2}$$

因此 $d(\hat{h}^{(k)}, c^*_k) < \Delta_{\mathcal{C}}/2 \le d(\hat{h}^{(k)}, c')$，即 $\pi(\hat{h}^{(k)}) = c^*_k$。量化映射正确解码。

由此，$\tilde{x}_k = c^*_k = x^*_{k+1}$，第 $k+1$ 段从正确的码本点出发，归纳假设对 $k+1$ 成立。$\square$

**推论（等效无限深度）**：在误差隔绝定理的条件下，分段复合链可执行任意段数 $n$（等效链深 $l_{eff} = n \cdot l_0$ 任意大），每段误差恒 $\le \tau$。

---

## 注记

> **注（信道编码的类比）**：误差隔绝条件 $\tau < \Delta_{\mathcal{C}}/2$ 在结构上与 Shannon 信道编码理论中的**最小距离解码条件**完全对应。码本 $\mathcal{C}$ 扮演"信道码"的角色，$\tau$ 为"信道噪声"，$\Delta_{\mathcal{C}}/2$ 为"纠错半径"。只要噪声不超过纠错半径，解码器（量化映射 $\pi$）必然正确还原发送方（理想链 $q$）的意图。

> **注（码本的双重正当性：代数截断与反劫持锚点）**：码本 $\mathcal{C}$ 通过在每段终点将中间态投影回码本元素来**强制阻止链路穿越劫持域的边界**。因此，误差隔绝定理在度量空间层面保证了"误差被截断"，在 $\Phi$ 的行为空间层面保证了"轨线被拉回安全领地"——前者是定量的（误差界），后者是定性的（行为安全性）。

> **注（码本覆盖缺口与隔绝失效）**：误差隔绝定理的信道编码条件 $\tau < \Delta_{\mathcal{C}}/2$ 虽引人注目，但其证明中还隐含了一个同等致命的**覆盖条件**——理想终点 $q^{(k)}(x^*_k)$ 到最近码本元素 $c^*_k$ 的距离必须严格满足 $d(q^{(k)}(x^*_k), c^*_k) < \Delta_{\mathcal{C}}/2 - \tau$。一旦目标流形上出现**覆盖缺口**，量化映射 $\pi$ 可能将 $\hat{h}^{(k)}$ 投射至错误的码本元素——段间误差从精确归零跳变为 $\Omega(\Delta_{\mathcal{C}})$ 量级的灾难性错位。

---

## 码本规模下界

**推论（码本规模的分辨率下界）**：若理想链的终点集在 $\mathcal{X}$ 中的分布需要 $\mathcal{N}(\tau, \mathcal{X})$ 个 $\tau$-球覆盖，则为使隔绝约束的"覆盖条件"成立，码本规模必须满足：

$$|\mathcal{C}| \;\ge\; \mathcal{N}\!\left(\frac{\Delta_{\mathcal{C}}}{2} - \tau,\; \mathcal{X}_{target}\right)$$

其中 $\mathcal{X}_{target}$ 为理想链终点的值域。联合隔绝约束 $\Delta_{\mathcal{C}} > 2\tau$，取 $\Delta_{\mathcal{C}} = 2\tau + \eta$（$\eta > 0$ 为裕量），覆盖半径为 $\eta/2$，故：

$$|\mathcal{C}| \;\ge\; \mathcal{N}\!\left(\frac{\eta}{2},\; \mathcal{X}_{target}\right)$$

裕量 $\eta \to 0$ 时码本规模发散，$\eta \gg 0$ 时码本稀疏但覆盖粗糙。这是**离散化精度与码本开销**之间的基本权衡。
