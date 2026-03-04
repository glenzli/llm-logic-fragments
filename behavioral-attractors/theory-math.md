# 数学推论前沿：伴生训练与行为吸引子的极限推导

> 本文是 [`theory.md`](./theory.md) 的数学延伸，目标是将现有假说推至当前可推导的最远端。每一节明确标注：**可证**（形式可推）、**条件可证**（给定额外假设可推）或**暂时开放**。

---

## §1 盆地分离的形式条件

> **分析对象**：[**H1**](./theory.md#22-吸引子盆地分离假说)（盆地分离假说）——在什么条件下，伴生训练能产生比 LoRA 更深的盆地分离？

### 1.1 凸性障碍：一个负面结果

**命题 1.1（无凸分离）**：若 $\mathcal{L}_A$ 与 $\mathcal{L}_B$ 均为凸函数，则 $\mathcal{L}_A + \lambda \mathcal{L}_B$ 也是凸函数，其全局极小值唯一。伴生训练在此情形下**不能产生多峰盆地分离**。

*证明*：凸函数的正线性组合仍为凸函数，凸函数的全局极小值集合为凸集（可能非单点），但不存在分离的局部极小值。$\square$

**推论**：真正的盆地分离要求至少一个目标在参数空间中是非凸的。对于大规模神经网络，这几乎总是满足的——但这意味着分离的**程度和方向**取决于非凸结构，而非目标本身的内容。

---

### 1.2 梯度冲突角：分离的充分刻画

在参数空间某点 $\theta$ 处，定义两个目标的**梯度冲突角**：

$$\cos \alpha(\theta) = \frac{\nabla \mathcal{L}_A(\theta) \cdot \nabla \mathcal{L}_B(\theta)}{\|\nabla \mathcal{L}_A(\theta)\| \cdot \|\nabla \mathcal{L}_B(\theta)\|}$$

- 当 $\alpha < \pi/2$（梯度同向）：两目标协同，权重收敛于同一方向，分离弱
- 当 $\alpha = \pi/2$（梯度正交）：无直接干涉，各自在正交子空间内形成极值
- 当 $\alpha > \pi/2$（梯度对立）：形成鞍点或分叉，**这是盆地分离的来源**

**定理 1.2（梯度对立诱导鞍点）**：设存在点 $\theta_s$ 使得 $\nabla \mathcal{L}_A(\theta_s) = -\lambda \nabla \mathcal{L}_B(\theta_s)$，则 $\theta_s$ 是 $\mathcal{L}_A + \lambda \mathcal{L}_B$ 的临界点（梯度为零）。若 Hessian 在该点有负特征值，则 $\theta_s$ 为鞍点，其稳定流形的两侧各有一个吸引区域。

*条件可证*（给定 $\mathcal{L}_A, \mathcal{L}_B$ 的具体形式可验证 Hessian 条件）。

---

### 1.3 盆地间距的下界

设 $\mathcal{L}_A$ 是 $K_A$-光滑的（Lipschitz 光滑梯度），即 $\|\nabla^2 \mathcal{L}_A\| \leq K_A$。

在两个极小值 $\theta_A^*$ 和 $\theta_B^*$ 处，梯度为零：

$$\nabla \mathcal{L}_A(\theta_A^*) + \lambda \nabla \mathcal{L}_B(\theta_A^*) = 0$$
$$\nabla \mathcal{L}_A(\theta_B^*) + \lambda \nabla \mathcal{L}_B(\theta_B^*) = 0$$

两式相减并利用光滑性条件，可得：

$$\|\nabla \mathcal{L}_A(\theta_A^*) - \nabla \mathcal{L}_A(\theta_B^*)\| \leq K_A \|\theta_A^* - \theta_B^*\|$$

同时左侧等于 $\lambda\|\nabla \mathcal{L}_B(\theta_B^*) - \nabla \mathcal{L}_B(\theta_A^*)\|$。

**因此，若 $\mathcal{L}_B$ 在两点间存在足够大的梯度差异 $\Delta_B$，则：**

$$\|\theta_A^* - \theta_B^*\|_2 \geq \frac{\lambda \Delta_B}{K_A}$$

> **意义**：盆地间距由 $\mathcal{L}_B$ 在两点的梯度差（"行为差异"）与 $\mathcal{L}_A$ 的光滑度比值决定。**增大 $\lambda$（伴生强度）或增大行为目标的差异性，均可线性增大盆地间距。**

*条件可证*（给定光滑度常数的具体值）。$\square$

---

## §2 伴生动力学的收敛性

> **分析对象**：[伴生训练系统](./theory.md#21-更新动力学)的稳定性——系统是否收敛，收敛至哪里？（支撑 H1 的训练可行性）

### 2.1 耦合梯度流

伴生协同训练在连续时间下是以下耦合梯度流：

$$\frac{d\theta}{dt} = -\nabla_\theta \mathcal{L}_A(\theta) - \lambda \nabla_\theta [\mathcal{L}_B(C_\phi(h_\theta(\cdot)))]$$

$$\frac{d\phi}{dt} = -\nabla_\phi \mathcal{L}_B(C_\phi(h_\theta(\cdot)))$$

### 2.2 Lyapunov 分析：系统必然收敛

定义 Lyapunov 函数：

$$V(\theta, \phi) = \mathcal{L}_A(\theta) + \lambda \mathcal{L}_B(C_\phi(h_\theta(\cdot)))$$

沿轨迹求导：

$$\frac{dV}{dt} = \nabla_\theta V \cdot \frac{d\theta}{dt} + \nabla_\phi V \cdot \frac{d\phi}{dt}$$

$$= -\|\nabla_\theta V\|^2 - \|\nabla_\phi V\|^2 \leq 0$$

等号当且仅当 $\nabla_\theta V = 0$ 且 $\nabla_\phi V = 0$ 时成立，即系统到达临界点。

**定理 2.1（伴生训练的收敛保证）**：设 $V(\theta, \phi)$ 有下界（对于有界参数空间显然成立），且梯度流有唯一解，则由 **LaSalle 不变集原理**，轨迹必然收敛至某临界点集合。

**推论**：伴生训练**总是收敛**到某个临界点（局部极小值 or 鞍点）。它不会发散。问题只在于收敛到哪个临界点——这取决于初始化和学习率调度。

> 这是**可正式证明的定理**，无需任何额外假设（除梯度流存在性外）。$\square$

---

### 2.3 收敛至哪个临界点？（条件结论）

**命题 2.2**：若初始参数 $(\theta_0, \phi_0)$ 在某个临界点 $(\theta^*, \phi^*)$ 的吸引域（basin of attraction）内，则梯度流以指数速率收敛至该临界点，收敛速率由 Hessian 在 $(\theta^*, \phi^*)$ 处的最小正特征值 $\mu$ 决定：

$$\|(\theta(t), \phi(t)) - (\theta^*, \phi^*)\| \leq C e^{-\mu t}$$

*条件可证*（在强凸邻域内，由 Łojasiewicz 不等式保证）。

**关键推论**：伴生训练下，不同初始化 $(\theta_0^A, \phi_0^A)$ 和 $(\theta_0^B, \phi_0^B)$ 可以**确定性地**导向不同临界点——这正是"预埋盆地"的机制基础。

---

## §3 Adapter 可导航定理

> **分析对象**：[**Adapter 盆地导航器**](./theory.md#3-adapter-作为盆地导航器)——rank-$r$ adapter 在什么条件下能在两个盆地间导航？

### 3.1 内禀维度假说的形式化

LoRA 文献（Aghajanyan et al., 2021）提出：预训练模型的微调方向集中在参数空间的**低维子空间**中。形式化为：

设 $\mathcal{F}$ 是从 $\theta^*$ 出发的所有有效微调方向的集合。定义**微调内禀维度** $d^*$ 为：

$$d^* = \min \{ r : \exists \text{ rank-}r \text{ 投影 } P_r, \; \mathbb{E}_{\delta \in \mathcal{F}} \|P_r(\delta) - \delta\|^2 / \|\delta\|^2 < \varepsilon \}$$

**条件**：若 $d^* \ll d$，则 rank-$r$ LoRA adapter（其中 $r \geq d^*$）可以近似表达所有有效微调方向。

### 3.2 Adapter 导航的必要条件

**定义**：设 $v = \theta_B^* - \theta_A^*$ 为两盆地极小值之差向量。LoRA adapter 的可表达方向集合为：

$$\mathcal{D}_{\text{LoRA}} = \{ \Delta(\delta) = BA : B \in \mathbb{R}^{d_1 \times r}, A \in \mathbb{R}^{r \times d_2} \}$$

（对每个权重矩阵的低秩分解）

**定理 3.1（Adapter 导航必要条件）**：若存在 rank-$r$ adapter 能从盆地 $A$ 导航至盆地 $B$，则 $v$ 在 $\mathcal{D}_{\text{LoRA}}$ 的正交补 $\mathcal{D}_{\text{LoRA}}^\perp$ 上的投影必须足够小：

$$\|\text{proj}_{\mathcal{D}_{\text{LoRA}}^\perp}(v)\| < \rho$$

其中 $\rho$ 由盆地的吸引半径决定。

**推论**：伴生训练应被设计为**让盆地分离方向 $v$ 尽量落在低秩子空间内**。这是设计 $\mathcal{L}_B$ 时的一个可操作约束。

*条件可证*（给定盆地几何的具体描述）。

---

### 3.3 充分条件的构造

**定理 3.2（Adapter 导航充分条件）**：若满足以下条件：
1. 盆地 $A$ 和 $B$ 均为 $\mu$-强凸邻域
2. $v = \theta_B^* - \theta_A^*$ 位于秩为 $r$ 的子空间 $V_r$ 内（即 $v \in V_r$）
3. LoRA adapter 参数化覆盖 $V_r$（即 $V_r \subseteq \mathcal{D}_{\text{LoRA}}$）

则存在 adapter 配置 $\delta^*$ 使得：

$$M_{\theta_A^* + \Delta(\delta^*)} \in \text{盆地}(B)$$

且 $\|\delta^*\|_F \leq \|v\|_2 / \sigma_{\min}(\text{LoRA投影})$

*条件可证*（在强凸假设下由收缩映射定理给出）。$\square$

---

## §4 信息论：行为模式容量上界

> **分析对象**：[**H2**](./theory.md#41-核心命题)（稳定吸引子假说）——在 Fisher 度量下，单模型最多能容纳多少个可区分行为模式？

### 4.1 Fisher 度量下的行为区分性

在 Fisher 信息度量下，参数空间成为一个 Riemannian 流形。两个参数点 $\theta_A, \theta_B$ 对应的输出分布 $P_A, P_B$ 的**可区分性**由 Fisher 距离给出：

$$d_F(\theta_A, \theta_B) = \int_0^1 \sqrt{\dot{\gamma}(t)^\top I(\gamma(t)) \dot{\gamma}(t)} \, dt$$

其中 $\gamma$ 是连接两点的测地线，$I(\theta)$ 是 Fisher 信息矩阵。

若行为模式 $A$ 和 $B$ 对应可区分的输出分布（$D_{KL}(P_A \| P_B) \geq \varepsilon_0$），则：

$$d_F(\theta_A^*, \theta_B^*) \geq \sqrt{\varepsilon_0}$$

（由 Pinsker 不等式的 Riemannian 推广）

### 4.2 容量上界：\( K \) 个模式的几何约束

**定理 4.1（行为模式容量上界）**：设参数空间的有效维度为 $d$，每两个不同模式之间的最小 Fisher 距离为 $\varepsilon_0$，则在直径为 $D$ 的参数空间内，可稳定区分的行为模式数量满足：

$$K \leq \left( \frac{2D}{\varepsilon_0} \right)^d$$

*证明*：这是度量空间中的 packing number 上界（球堆积），即在直径 $D$ 的空间中，以 $\varepsilon_0/2$ 为半径的不相交球最多能放多少个。$\square$

**注**：这个界在 $d$（参数维度）上是指数级的，因此理论上 $K$ 可以极大——但这是**粗糙上界**而非精确值。真实的有效行为维度远小于 $d$，使得可区分模式数实际上有限。

### 4.3 有效行为维度

定义模型的**有效行为维度** $d_{\text{eff}}$ 为输出分布流形 $\{P_\theta : \theta \in \mathbb{R}^d\}$ 的内禀维度。

**猜想 4.2**：对于大规模语言模型，$d_{\text{eff}} \ll d$，且 $d_{\text{eff}}$ 大致对应模型能够表达的"独立语义维度"数量。

*目前开放*——这是一个活跃的 representation geometry 研究方向。

---

## §5 共享签名定理的形式化

> **分析对象**：[**P1**](./theory.md#5-共享签名论证)（可证伪预测）——若 adapter 与 prompt 激活共享签名，这在数学上意味着什么？

### 5.1 从预测 P1 到可证形式

回顾 P1：若设计激活和 prompt 激活共享签名，则存在稳定解。这可以用不动点语言精确表达：

**定理 5.1（激活路径无关的不动点）**：设存在区域 $R \subset \mathbb{R}^k$（表示空间的子集），使得：

1. 对伴生训练模型在 adapter $\delta_A$ 下：$h_{\theta + \Delta(\delta_A)}(x) \in R$ 对大多数输入 $x$ 成立
2. 对标准训练模型在 prompt $p_A$ 下：$h_\theta([p_A; x]) \in R$ 对大多数输入 $x$ 成立

则 $R$ 是行为模式 $A$ 的**表示不动点区域**，其存在说明模式 $A$ 对应一个与激活路径无关的稳定结构。

> **关键推论**：若 P1 在实验中成立（$\text{MMD}(S^{\text{adapter}}_A, S^{\text{prompt}}_A) \approx 0$），则由上述定义，稳定行为结构在表示空间中已被找到。这不需要证明——它是可观测事实的定义性推论。

---

### 5.2 吸引子的泛化：激活函数类

**定义**：称激活函数类 $\mathcal{A}$ 为**稳定吸引子的激活类**，若其中任一函数 $f \in \mathcal{A}$（包括 adapter、prompt、甚至对抗扰动）施加于基座模型后，模型行为均落入同一盆地 $B_k$。

**命题 5.2**：$\mathcal{A}$ 恰好是以 $B_k$ 为吸引子的盆地的**吸引域**在激活函数空间中的像。

这把盆地导航问题从参数空间转移到了**激活函数空间**——提示了一种通过实验枚举 $\mathcal{A}$ 来推断盆地结构的方法。

---

## §6 本框架当前的理论极限与开放边界

| 命题 | 状态 | 核心障碍 |
|---|---|---|
| 伴生训练总是收敛（定理 2.1） | **可证** | 无 |
| 盆地分离下界（§1.3） | **条件可证** | 需要 $K_A, \Delta_B$ 的估计 |
| Adapter 导航充分条件（定理 3.2） | **条件可证** | 需要强凸性 + 低秩对齐 |
| 行为模式容量上界（定理 4.1） | **可证（粗糙界）** | Fisher 度量计算复杂 |
| 共享签名 → 稳定结构存在 | **定义性推论（P1 成立即得）** | P1 本身需要实验 |
| 有效行为维度 $d_{\text{eff}}$ 的精确刻画 | **开放** | 表示流形内禀维度理论缺失 |
| 稳定吸引子数量 $K$ 的紧下界 | **开放** | 需要新的拓扑工具 |
| 吸引子结构的架构无关性 | **开放** | 无已知框架处理跨架构比较 |

---

## §7 下一步可推进的方向

如果要继续在数学上推进，最有潜力的两条路是：

**路径 A（更精确的盆地几何）**：引入 Morse 理论，用临界点指数（Morse index）对损失曲面的拓扑结构进行系统分类，从而对"能产生多少个稳定盆地"给出拓扑意义上的答案。

**路径 B（有效行为维度的信息论处理）**：把 $d_{\text{eff}}$ 与模型输出的 mutual information 结构联系起来，利用压缩表示理论（如 information bottleneck）给出维度的实用上界。
