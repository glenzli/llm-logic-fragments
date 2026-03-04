# 理论：行为吸引子与伴生协同训练

> **文档结构**：本文为**概念与假说层**，负责建立核心假说（H1、H2、P1）、直觉解释与实验设计。所有形式证明与数学推导见 [`theory-math.md`](./theory-math.md)。

## 1. 问题建模

设 $\theta \in \mathbb{R}^d$ 为基座语言模型 $M_\theta$ 的完整参数空间。

对于输入 $x$，定义：
- $h_\theta(x) \in \mathbb{R}^k$ — 内部表示（如最终隐层状态）
- $M_\theta(x)$ — 词元上的输出分布

标准训练最小化单一目标：

$$\theta^* = \arg\min_\theta \mathcal{L}_A(\theta)$$

这会产生一个单一的（或弱多峰的）吸引子盆地，收敛至 $\theta^*$。

---

## 2. 伴生协同训练

引入伴生模型 $C_\phi$，参数为 $\phi \in \mathbb{R}^m$，其中 $m \ll d$。

伴生模型观察 $M_\theta$ 的内部表示，并提供编码了另一个行为目标 $\mathcal{L}_B$ 的第二梯度信号。

耦合训练目标：

$$\min_{\theta, \phi} \; \mathcal{L}_A(M_\theta(x)) + \lambda \cdot \mathcal{L}_B(C_\phi(h_\theta(x)))$$

**关键结构性质**：与标准多任务学习（对输入求和损失）不同，伴生模型通过 $h_\theta(x)$（表示空间）进行耦合。这意味着：

1. 两个目标约束的是**同一内部几何结构**，而非仅仅是输出分布。
2. 伴生模型的梯度 $\nabla_\theta \mathcal{L}_B(C_\phi(h_\theta(x)))$ 通过 Jacobian $\frac{\partial h_\theta}{\partial \theta}$ 作用，直接塑造表示流形。

### 2.1 更新动力学

在第 $t$ 步：

$$\theta_{t+1} = \theta_t - \alpha \left( \nabla_\theta \mathcal{L}_A + \lambda \nabla_\theta \mathcal{L}_B \circ C_\phi \right)$$
$$\phi_{t+1} = \phi_t - \beta \nabla_\phi \mathcal{L}_B(C_\phi(h_{\theta_t}(x)))$$

当 $\mathcal{L}_A$ 与 $\mathcal{L}_B$ 编码**足够正交的行为目标**时，梯度场不会相互抵消，而是形成竞争张力，使权重几何结构发生极化。

### 2.2 吸引子盆地分离假说

> **假说（H1）**：在正交目标 $\mathcal{L}_A \perp \mathcal{L}_B$ 的伴生协同训练下，所产生的损失曲面将形成至少两个局部极小值 $\theta_A^*$ 与 $\theta_B^*$，满足：
>
> $$\| \theta_A^* - \theta_B^* \|_2 > \| \theta^*_{\text{标准}} - \theta^*_{\text{偏置}} \|_2$$
>
> 其中 $\theta^*_\text{偏置}$ 是从 $\theta^*_\text{标准}$ 出发进行事后 LoRA 微调所得。

即：伴生训练产生**更深、更分离**的吸引子盆地，而非事后适配所能达到的浅层偏移。

**与已知理论的关联**：这与对比学习文献一致——负样本对训练在表示空间中产生更尖锐的分离（Chen et al., 2020）。伴生训练可理解为**在参数空间中执行的对比学习**。

**H1 与 Adapter 的关联**：正是因为 H1 所预期的盆地深度分离，低秩的 adapter 扰动才能稳定地跨越盆地边界。如果盆地浅且模糊， adapter 导航将会不稳定且容易溢出。

→ *H1 的形式条件与盆地间距下界见 [theory-math.md §1](./theory-math.md#1-盆地分离的形式条件)；训练系统收敛保证见 [§2](./theory-math.md#2-伴生动力学的收敛性)。*

---

## 3. Adapter 作为盆地导航器

伴生协同训练完成后，引入小型 adapter $\delta \in \mathbb{R}^r$（LoRA 风格），其中 $r \ll d$。

Adapter 通过以下方式修改有效参数：

$$\tilde{\theta} = \theta + \Delta(\delta)$$

其中 $\Delta: \mathbb{R}^r \to \mathbb{R}^d$ 是低秩投影。

> **定义**：若对于给定基座 $\theta$（伴生训练所得模型），存在 adapter 配置 $\delta_A$ 和 $\delta_B$ 使得：
>
> $$M_{\tilde{\theta}_A} \in \text{盆地}(A), \quad M_{\tilde{\theta}_B} \in \text{盆地}(B)$$
>
> 且 $\| \delta_A - \delta_B \|_2 < \| \theta_A^* - \theta_B^* \|_2$（导航代价远小于盆地间距），则称该 adapter 为**盆地导航器**。

这正是该方法相较于训练两个独立模型的优势所在：**一个基座，两个可达盆地，极小的导航代价**。

→ *Adapter 导航的必要条件与充分条件见 [theory-math.md §3](./theory-math.md#3-adapter-可导航定理)。*

---

## 4. 稳定吸引子假说

> **设计盘地 vs 自然盘地**：以上 §2–3 描述的是*主动设计*的盆地。H2 的更强主张是：即便没有伴生训练，自然训练的 LLM 中也天然存在类似的稳定吸引子结构。伴生训练只是提供了研究这种结构的可控参照。这一主张由 §5 的 P1 支撑。

### 4.1 核心命题

> **假说（H2）**：已训练 LLM 的行为空间 $\mathcal{B}$ 可分解为有限个稳定吸引子盆地 $\{B_1, \ldots, B_K\}$，满足：
>
> 1. 引发相似行为偏移的 prompt $p_1, p_2$ 在表示空间抵达同一盆地 $B_k$（盆地层面的 prompt 不变性）。
> 2. 导航至设计盆地 $B_k$ 的 adapter 激活，与自然 prompt 引发的行为相似偏移在表示空间中收敛至同一区域。

### 4.2 为什么重要

若 H2 成立：

- **越狱（Jailbreak）** = 对非预期吸引子盆地 $B_j$ 的无控制导航
- **人格 Prompt** = 经由 prompt 对目标盆地进行有控制但脆弱的导航
- **Adapter 激活** = 对设计盆地的工程化、稳定导航
- **上下文学习（ICL）** = 临时的盆地扰动，上下文重置后恢复

上述四种现象统一为同一个问题：*prompt 与权重扰动如何在行为空间的吸引子盆地中导航？*

### 4.3 稳定性条件

盆地 $B_k$ 在扰动 $\epsilon$ 下稳定，当且仅当：

$$\forall \delta : \|\delta\| < \epsilon, \quad M_{\theta + \delta} \in \text{盆地}(B_k)$$

可通过以下实验测量：
1. 选取名义上处于 $B_k$ 中的基准表示 $h^*$。
2. 施加对抗性 prompt 扰动，追踪内部表示是否保持在 $h^*$ 的邻域内。

→ *H2 的信息论容量上界（$K$ 个模式最多能存多少）见 [theory-math.md §4](./theory-math.md#4-信息论行为模式容量上界)。*

---

## 5. 共享签名论证

设计激活（adapter）与涌现激活（prompt）之间的关键桥梁。

**定义**：对于模式 $k$，定义*激活签名* $S_k$ 为内部表示上的分布：

$$S_k = \{ h_\theta(x) \mid M_\theta \in B_k \}$$

> **可证伪预测（P1）**：对于具有设计模式 $A$ 和 $B$ 的伴生训练模型：
>
> $$\text{sim}(S^{\text{adapter}}_A, S^{\text{prompt}}_A) > \text{sim}(S^{\text{adapter}}_A, S^{\text{prompt}}_B)$$
>
> 其中 $\text{sim}$ 为分布相似性度量（如 MMD 或均值表示的余弦相似度），$S^{\text{prompt}}_A$ 从标准（非伴生训练）模型中、在引发行为相似偏移的 prompt 下采集。

若 P1 成立，则表明：
- 设计吸引子与自然涌现吸引子在几何上共享同一位置
- 激活机制（adapter vs. prompt）收敛于同一不动点
- **行为模式激活存在稳定解**，且独立于访问路径

**P1 → H2 的推论链**：若 P1 成立，则伴生和 prompt 访问的是同一个几何区域。这意味着伴生训练所「设计」的吸引子，并非被创造出来的，而是原本就存在于自然模型的权重空间中。因此 **H2 得到支撑**：Jailbreak、persona prompt 等现象，本质上都是对这些预存结构的访问，而非任意创造。

→ *P1 的不动点形式化与激活函数类的推广见 [theory-math.md §5](./theory-math.md#5-共享签名定理的形式化)。*

---

## 6. 可证明性总览

→ *完整的可证明性分析、定理列表与开放边界见 [theory-math.md §6](./theory-math.md#6-本框架当前的理论极限与开放边界)。*

---

## 7. 最小可行实验

为验证核心链（H1 → P1 → H2），最小实验配置如下：

1. **模型**：1B–7B 参数模型（如 Llama-3 8B 或 Mistral 7B），足够小以训练两次。
2. **伴生配置**：训练两个行为目标，$A$（简洁、事实型）与 $B$（冗长、探索型）。伴生模型 $C_\phi$ 将表示分类为 $A$ 或 $B$ 模式。
3. **基线**：从同一基座出发，用相同行为目标做事后 LoRA 微调。
4. **测量**：
   - $\|h_A^{\text{comp}} - h_B^{\text{comp}}\|$ vs. $\|h_A^{\text{LoRA}} - h_B^{\text{LoRA}}\|$ — 验证 H1（comp = 伴生训练）
   - $\text{MMD}(S^{\text{adapter}}_A, S^{\text{prompt}}_A)$ — 验证 P1
   - 对 $A$ 模式施加对抗性 prompt 扰动，追踪表示是否保持在 $h^*$ 邻域内 — 验证 H2 稳定性条件

预估算力：7B 模型约需 10–40 GPU 小时。

---

## 8. 开放问题

1. **正交性条件**：$\mathcal{L}_A$ 与 $\mathcal{L}_B$ 产生有效盆地分离的精确条件是什么？能否在训练前量化？

2. **伴生规模**：伴生模型的表示容量是否需要与 $\mathcal{L}_B$ 的行为复杂度成比例？最小伴生模型规模是多少？

3. **无设计的盆地发现**：伴生训练方法能否反向使用——用于*发现*已训练模型中的潜在吸引子盆地，而非*创造*新盆地？

4. **吸引子普遍性**：吸引子盆地是否与模型架构无关，还是依赖特定的归纳偏置（如注意力机制）？
