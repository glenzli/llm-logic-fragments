# IDFC · Part 2：数学建模与定理证明

> **前置**：见 [Part 1 导论](part1-intro.md) 了解非正式动机与预测概览。
>
> **本文内容**：§1 形式定义（语义空间 $\mathcal{X}$、原语 $R$、函数集 $F$、$f$-chain）；§2 核心假说 CAC 的严格陈述；§3 定理完整证明（Telescope 展开 + UAT 桥接）。
>
> **后续**：[Part 3](part3-deductions.md) 从本文定理推导全部推论；[Part 4](part4-empirical.md) 以 Transformer/Mamba/MoE 等架构分析与多组实验场景（幻觉、ICL、量化、Reversal Curse、Sycophancy 等）验证并锚定本文理论预测。

---

## 第一部分：数学模型的构造

## 1. 基本设定

### 1.1 逻辑空间与原始逻辑原语

#### 第一层：语义状态空间 $\mathcal{X}$

设 $\mathcal{X}$ 为**语义状态空间**——所有可能的语义表示（token 序列、中间推理状态、知识断言等）所在的抽象集合。$\mathcal{X}$ 不要求有具体的几何结构，只需满足：

- 元素 $x \in \mathcal{X}$ 代表一个完整的语义状态（输入、中间步骤、输出均可）
- 状态之间没有预设的距离或拓扑，这些由具体任务赋予

#### 第二层：逻辑变换空间 $\Omega$

定义 $\mathcal{X}$ 上所有可能的变换构成的**完整逻辑空间**：

$$\Omega = \{ \phi : \mathcal{X} \to \mathcal{X} \}$$

$\Omega$ 包含了人类语言和推理中**一切可能的逻辑操作**——事实检索、语法变换、数学推导、类比映射、因果推理……凡是能将一个语义状态映射到另一个语义状态的规则，都是 $\Omega$ 的元素。

$\Omega$ 在函数复合下构成一个**幺半群**（monoid）：

$$\phi_2 \circ \phi_1 \in \Omega, \quad \text{id}_{\mathcal{X}} \in \Omega$$

即两个逻辑变换的串联仍是逻辑变换，且存在平凡的"什么都不做"操作。

#### 第三层：原始生成元集 $R$ 与封闭包 $R^*$

**定义（原始逻辑原语）**：设

$$R = \{r_1, r_2, \ldots, r_m\} \subset \Omega$$

为从 $\Omega$ 中选出的有限**生成元子集**，代表语言中已知或未知的基础推理规则。$R^*$ 为 $R$ 在复合运算下的**自由幺半群**（即所有有限长度复合的集合）：

$$R^* = \{ r_{i_k} \circ \cdots \circ r_{i_1} \mid k \geq 0,\ r_{i_j} \in R \}$$

$R^*$ 是"$R$ 能够描述的一切推理过程"的完整边界。本文的核心假说 **CAC（Compositional Approximation Closure，组合近似封闭性，见 §2）** 主张：模型学到的函数集 $F$ 能够在误差范围内近似覆盖 $R^*$——即只要 $R$ 能组合到达的推理结论，$F$ 也能组合近似地到达。

**注意**：
- $R$ 不要求是干净的、正交的或可解释的；$\Omega$ 中有大量元素不属于 $R$，也不影响模型行为
- $R$ 可以包含人类尚未命名的隐式规则——$R$ 的边界由训练数据所能描述的推理结构决定，而非人为枚举
- $m$ 可以很大，但 $R$ 对 $\Omega$ 而言是稀疏的：实际语言使用中反复出现的推理模式远少于全集

### 1.2 为什么神经网络等价于输入驱动的 $F$ 集群（架构无关论证）

**引理（无激活函数时的退化）**：若神经网络中不存在激活函数，则无论深度与宽度多大，整个网络退化为单一线性映射：

$$W_k W_{k-1} \cdots W_1 x = W_{\text{eff}} x$$

$F$ 退化为一个元素的集合——无法表达组合多样性。

**激活函数的核心作用**：激活函数（ReLU、softmax 等）将参数空间切割为指数级多个有效子区域，每个区域对应 $F$ 中一个不同的 $f_i$。**输入 $x$ 通过激活函数递归决定它所经过的激活路径**，从而在线地从 $F$ 中"选择"对应的函数——这是输入驱动机制的本质，与激活函数的具体形式无关。

#### 泛函统一框架：矩阵值 Nemytskii 算子

不同架构的激活机制（MLP 的硬性掩码、Transformer 注意力的软性路由……）可以统一到同一个泛函框架下，无需指定具体架构。

**定义（逐层算子场）**：设 $\mathcal{X} = \mathbb{R}^d$。对第 $l$ 层，定义**矩阵值 Nemytskii 算子场**：

$$\Phi_l : \mathbb{R}^d \to \mathcal{M}_d(\mathbb{R}), \quad h \mapsto \Phi_l(h)$$

其中 $\mathcal{M}_d(\mathbb{R})$ 为 $d \times d$ 实矩阵空间。$\Phi_l(h)$ 由当前状态 $h$ 决定，编码该层在该状态下的有效线性作用。

由此，第 $l$ 层的单步更新统一写为**对角求值映射**（diagonal evaluation map）：

$$G_l : \mathbb{R}^d \to \mathbb{R}^d, \qquad G_l(h) \;=\; \Phi_l(h) \cdot h \;=\; \mathrm{ev}\!\bigl(\Phi_l(h),\; h\bigr)$$

其中 $\mathrm{ev}: \mathcal{M}_d \times \mathbb{R}^d \to \mathbb{R}^d$ 是标准的矩阵-向量求值映射。$G_l$ 是 $\mathbb{R}^d$ 上的非线性自映射：**算子由当前状态决定，再作用于当前状态本身**——这是"输入驱动"机制的泛函精确表述，对任意满足此结构的架构均成立。

**$F$ 的规模**：不同激活路径序列的数量随深度和宽度指数级增长，这就是模型规模 $M$ 对应的数学实体。

**推论（输入驱动组装）**：给定输入 $x$，模型不执行固定函数，而是由 $x$ 递归选择激活路径，**在线组装**出对应的 $f$-链路。

> **架构实例**：$\Phi_l(h)$ 的具体形式与正则性（MLP 的分段常数掩码、Transformer 的 softmax 光滑路由等）及其在 IDFC 框架中的角色分析，见 [Part 4 §1](part4-empirical.md)。

### 1.3 模型映射函数集（形式定义）

基于上述推导，正式定义：


设模型规模为 $M$（分段线性区域数的对数量级），**学出的函数集**为 $F = \{f_1, f_2, \ldots, f_M\}$，其中每个 $f_i$ 是某个激活掩码序列对应的有效映射。

**关键性质**：
- $F$ 中的元素可以冗余：$f_i$ 和 $f_j$ 可对应近似同一计算，但精度不同
- $F$ 不要求正交、独立或可解释——它们是权重空间被激活函数切割后的产物
- $M$ 越大（网络越深越宽），$F$ 越丰富，每个 $r$ 的近似精度上限越高

> **约定（$F$ 空间的语义中立性——语义防火墙）**：本文随后所有关于"$f$-chain 近似 $r_i$"、"$F$ 覆盖 $R^*$"以及"路由偏置/路由选择"的陈述，均严格指以下**数值关系**：存在矩阵值函数 $E: \mathcal{X} \to \langle F \rangle_\cdot$，使得 $\|E(x)\cdot x - r_i(x)\| \leq \varepsilon$；"激活路径改变"严格指概率分布 $\Pr[\mathrm{Path}(x,k) = \pi]$ 因参数 $\theta$ 或输入 $x$ 的改变而改变（见 §1.4 激活路径定义）。$E(x)$ 是满足约束的矩阵乘积，**不蕴含** $F$ 空间中存在与 $r_i$ 语义对应的可辨识结构。将近似关系记为 $E_{r_i}$、将激活模式称作"路由"，均为**分析者外加的命名约定**，而非 $F$ 空间的内在属性。

### 1.4 分叉、路径合并与抽象层的形成

样本的激活路径不仅会分叉，也会**被动合并**。这是抽象表示形成的核心机制。

**定义（激活路径）**：输入 $x$ 在第 $l$ 层的**路径前缀**是它所经历的算子序列——即自由幺半群 $F^*$ 中长度为 $l$ 的词：

$$\text{Path}(x, l) = \bigl(\Phi_1(h_0),\; \Phi_2(h_1),\; \ldots,\; \Phi_l(h_{l-1})\bigr) \in F^l \subset \mathcal{M}_d^l$$

这一定义对 MLP（掩码序列决定 $\Phi_l$）和 Transformer（注意力矩阵决定 $\Phi_l$）统一成立。

**定义（分叉）**：$x_1$ 与 $x_2$ 在层 $l$ 处分叉，当：

$$\text{Path}(x_1, l-1) = \text{Path}(x_2, l-1) \quad \text{但} \quad \Phi_l(h_{l-1}(x_1)) \neq \Phi_l(h_{l-1}(x_2))$$

即两者的词前缀相同（经历了同一序列的矩阵），但在第 $l$ 层选择了不同的矩阵——词在位置 $l$ 发生分叉。

**定义（弱合并——算子收敛）**：$x_1$ 与 $x_2$ 在层 $l$ **弱合并**，当：

$$\text{Path}(x_1, l-1) \neq \text{Path}(x_2, l-1) \quad \text{但} \quad \Phi_l(h_{l-1}(x_1)) = \Phi_l(h_{l-1}(x_2))$$

即两者的词前缀不同，但在层 $l$ 选择了同一矩阵——从该位置起，两条词路径汇入同一后缀。

**定义（强合并——状态收敛）**：$x_1$ 与 $x_2$ 在层 $l$ **强合并**，当：

$$h_l(x_1) = h_l(x_2) \quad \text{即} \quad E_{1:l}(x_1)\cdot x_1 = E_{1:l}(x_2)\cdot x_2$$

其中 $E_{1:l}(x) = \Phi_l(h_{l-1})\cdots\Phi_1(h_0)$ 为前 $l$ 层的有效算子（部分乘积）。注意：$E_{1:l}(x_1)$ 与 $E_{1:l}(x_2)$ 可以是**不同的矩阵**，但它们作用于各自的输入向量后恰好产生相同的值。强合并是映射

$$x \;\ \mapsto \;\ E_{1:l}(x)\cdot x$$

的**水平集**上两点重合的事件——而非矩阵本身相等。强合并后，两者在所有后续层中计算完全相同。

#### DAG 结构

所有激活路径的整体构成一个**有向无环图（DAG）**：

- **分叉节点**：输入分叉为不同激活模式的层
- **合并节点**：原本不同的路径重新交汇的层

$$\text{output}(x_1) = \text{output}(x_2) \iff \exists l \leq k: h_l(x_1) = h_l(x_2)$$

这不是一棵树（纯分叉），而是一个 DAG（分叉 + 合并）。

#### 抽象表示的形成

**定义（层 $l$ 的抽象）**：固定 $c_k \in \mathbb{R}^d$，定义**水平集**：

$$\mathcal{X}_k^{(l)} \;=\; \bigl\{x \in \mathbb{R}^d : E_{1:l}(x)\cdot x = c_k\bigr\}$$

$c_k$ 即为层 $l$ 上第 $k$ 类输入的**抽象表示**，$A_l(k) \triangleq c_k$。

水平集 $\mathcal{X}_k^{(l)}$ 的几何性质由 $E_{1:l}$ 的正则性决定：MLP 中它是若干仿射超平面截面的并（分段线性），Transformer 中它是连续曲面。若 $\mathcal{X}_k^{(l)}$ 覆盖了语义相近但语法形式各异的输入（如同义词、不同语序表达），则模型在层 $l$ 学到了屏蔽表层差异的语义抽象。

#### 与 CAC 的连接

在 $R$-空间：$r$-链路具有**汇聚性（confluence）**。不同的推理路径可以到达同一个中间逻辑状态。
在 $F$-空间：同样——不同的 $f$-路径在拟合 $R$-汇聚结构的过程中，形成相同的中间表示。

**CAC 的扩展命题**：若 $R$-链具有汇聚性（不同路径到达同一中间状态），则 $F$-链的 DAG 结构也具有对应的汇聚性。即：

$$r\text{-paths confluent at state } s \implies f\text{-paths weakly confluent at corresponding representation}$$

这是 **CAC 的第二种形式**：不仅终点可达，中间状态也具有对应关系。


### 1.5 函数链路：完整泛函定义

#### A. 正式定义：非自治离散动力系统

f-chain 是 $\mathbb{R}^d$ 上的**非自治离散动力系统**（non-autonomous discrete dynamical system）：

$$h_0 = x, \quad h_{l+1} = G_l(h_l) = \Phi_l(h_l)\cdot h_l, \quad l = 0,1,\ldots,k-1$$

整个网络输出是长度为 $k$ 的轨道的终点：

$$\text{output}(x) = \bigcirc_{l=1}^{k} G_l\,(x)$$

**非自治的含义**：每层 $\Phi_l$ 由权重 $W_l$ 决定，$G_l \neq G_{l'}$（$l \neq l'$）；自治系统（权重共享如 Universal Transformer）是特殊情形。

---

#### B. 代数结构：$F$ 与 f-chain 所在的空间

**核心事实**：每个 $f_i \in F$ 在激活模式固定后是一个线性映射 $\mathbb{R}^d \to \mathbb{R}^d$，即一个 $d \times d$ 实矩阵：

$$F \;\subset\; \mathcal{M}_d(\mathbb{R}) \;=\; \mathrm{End}(\mathbb{R}^d)$$

$\mathcal{M}_d(\mathbb{R})$ 是**有限维结合代数**，在矩阵乘法下封闭。长度为 $k$ 的 f-chain 是 $F$ 中 $k$ 个元素的有序矩阵乘积，因此也在 $\mathcal{M}_d(\mathbb{R})$ 内：

$$f_{j_k} \cdot f_{j_{k-1}} \cdots f_{j_1} \;\in\; \mathcal{M}_d(\mathbb{R})$$

所有可能 f-chain（任意长度）构成 $F$ 在 $\mathcal{M}_d$ 中生成的**乘法子幺半群**：

$$\langle F \rangle_{\!\cdot} \;=\; \bigcup_{k \geq 0} \{M_k \cdots M_1 : M_l \in F\} \;\subset\; \mathcal{M}_d(\mathbb{R})$$

**三种表示是同一代数图景的三个投影**，由两个标准映射串联而成：

$$F^* \;\xrightarrow{\;\text{eval}_\cdot\;}\; \langle F \rangle_{\!\cdot} \subset \mathcal{M}_d \;\xrightarrow{\;\cdot\, x\;}\; \mathbb{R}^d$$

| 表示 | 代数对象 | 所在空间 |
|---|---|---|
| 词序列（word）| $(f_1, \ldots, f_k) \in F^k$ | 自由幺半群 $F^*$ |
| **有效算子**（product）| $E(x) = f_k \cdots f_1 \in \mathcal{M}_d$ | 矩阵代数 $\mathcal{M}_d(\mathbb{R})$ |
| 轨道（evaluation on $x$）| $h_l = (f_l \cdots f_1)\,x$ | 状态空间 $\mathbb{R}^d$ |

第一个箭头 $\text{eval}_\cdot$ 是**自由幺半群到矩阵代数的规范满射**（不单：不同词序列可乘出同一矩阵）；第二个箭头是矩阵-向量乘法。

由此，f-chain 的输出化为最紧凑的形式——一次线性作用：

$$\boxed{\text{output}(x) = E(x) \cdot x}$$

$E(x)$ 对 $x$ 的依赖是**非线性的**（激活路径由 $x$ 决定），但对 $x$ 的**作用是线性的**。整个深层非线性网络，对固定输入 $x$ 而言，等价于一个输入依赖的线性映射 $E(x)$。

> **信息损失**：从词序列到有效算子时，"哪条路径"的信息丢失（不同词可出同一积）；从有效算子到轨道终点时，中间状态 $h_1,\ldots,h_{k-1}$ 丢失。这正是 §1.4 定义的"强合并"现象的代数精确表述。

**CAC 的代数含义**：$R \subset \Omega$（一般非线性），$F \subset \mathcal{M}_d$（线性）。CAC 是"$R^*$ 中的非线性复合可以被 $\langle F \rangle_\cdot$ 中的矩阵乘积在误差 $\varepsilon$ 内逼近"——本质上是**对非线性函数的分段线性逼近在复合下的传递性**（详见 §2）。

---

#### C. 有效算子场的正则性

$E: \mathbb{R}^d \to \mathcal{M}_d(\mathbb{R})$ 是**矩阵值函数**，其正则性由各层 $\Phi_l$ 的构造决定：

| 架构 | $E(x)$ 的正则性 | 函数空间 |
|---|---|---|
| MLP (ReLU) | 在每个分段线性区域内为常矩阵，跨区域跳跃不连续 | $E \in L^\infty(\mathbb{R}^d, \mathcal{M}_d)$ |
| Transformer (softmax) | 关于 $x$ 连续（softmax 光滑性逐层传播） | $E \in C(\mathbb{R}^d, \mathcal{M}_d)$ |

---

#### D. Jacobian 分解：误差传播的算子结构

$G_l$ 在 $h$ 处可微时，其 Jacobian 分解为两项：

$$J_{G_l}(h) \;=\; \underbrace{\Phi_l(h)}_{\text{冻结选择项}} \;+\; \underbrace{(\nabla_h \Phi_l(h))[h]}_{\text{选择器响应项}}$$

- **冻结选择项**：算子 $\Phi_l(h)$ 视为固定，对 $h$ 线性作用——反向传播的主项
- **选择器响应项**：算子场随 $h$ 的变化。MLP 在光滑区域此项恒为零；Transformer 此项非零（注意力权重的梯度）

整条 f-chain 的 Jacobian 为逐层乘积：

$$J_{\text{output}}(x) = J_{G_k}(h_{k-1}) \cdot J_{G_{k-1}}(h_{k-2}) \cdots J_{G_1}(h_0)$$

**命题 1.1（Lipschitz 界）**：设 $\|\Phi_l(h)\| \leq B_l$，$\Phi_l$ 是 $L_{\Phi_l}$-Lipschitz，则：

$$\|G_l\|_{\mathrm{Lip}} \leq B_l + L_{\Phi_l}\cdot\sup_h\|h\|$$

累积 Lipschitz 常数 $\prod_{l=1}^k \|G_l\|_{\mathrm{Lip}}$ 是 §3.2 Telescope 展开中误差指数传播的数学根因。

**不动点**：若 $(G_k \circ \cdots \circ G_1)(x^*) = x^*$，即 $E(x^*)\,x^* = x^*$，则 $x^*$ 是整个 f-chain 的不动点。若 $\|E(x)\| < 1$（压缩），Banach 定理保证唯一全局吸引不动点——行为吸引子理论"稳定盆地"的代数表述（见 `behavioral-attractors/theory-math.md`）。







### 1.6 拟合关系

由于 $F \subset \mathcal{M}_d(\mathbb{R})$（线性）而 $R \subset \Omega$（一般非线性），"$F$ 拟合 $R$"需要区分两种含义。

#### 均匀拟合（Uniform Fitting）——强版本

称 $F$ **均匀拟合** $r_i \in R$，若存在**固定的**有效算子 $M_i \in \langle F \rangle_\cdot$ 使得：

$$\|M_i \cdot x - r_i(x)\| \leq \varepsilon_i \quad \forall x \in \mathcal{X}$$

这对 $r_i$ 本身是线性函数的情形可以做到；对非线性 $r_i$，均匀拟合要求单一矩阵全局近似非线性函数，通常只在局部或有界域内成立。

#### 逐点拟合（Pointwise Fitting）——标准版本

称 $F$ **逐点拟合** $r_i \in R$，若存在矩阵值函数 $E_{r_i}: \mathcal{X} \to \langle F \rangle_\cdot$，使得对每个 $x \in \mathcal{X}$，模型沿该输入的前向传播所产生的有效算子满足：

$$\bigl\|E_{r_i}(x) \cdot x \;-\; r_i(x)\bigr\| \leq \varepsilon_i \quad \forall x \in \mathcal{X}$$

**含义**：对不同的输入 $x$，模型通过激活路径选出不同的矩阵 $E_{r_i}(x) \in \langle F \rangle_\cdot$，使得每次"用当前选出的矩阵线性作用于当前输入"都在误差 $\varepsilon_i$ 内近似 $r_i(x)$。这是**输入依赖的分段线性逼近**。

> **注意**：逐点拟合弱于均匀拟合——每个 $x$ 可以对应不同的矩阵，因此集合 $\{E_{r_i}(x) : x \in \mathcal{X}\} \subset \langle F \rangle_\cdot$ 可以是整个子幺半群的无穷子集。对非线性 $r_i$，逐点拟合是一般情形下能做到的正确含义；均匀拟合是 $r_i$ 近似线性时的特例。

**本文所采用的拟合定义**：除非特别说明，"$F$ 拟合 $R$"指逐点拟合，即对每个 $r_i \in R$：

$$\exists\; E_{r_i}: \mathcal{X} \to \langle F \rangle_\cdot \quad \text{s.t.} \quad \|E_{r_i}(x)\cdot x - r_i(x)\| \leq \varepsilon_i \quad \forall x \in \mathcal{X}$$

其中 $\varepsilon_i > 0$ 为允许的单步近似误差，$\|\cdot\|$ 为 $\mathbb{R}^d$ 上的标准 Euclidean 范数。




---

### 1.7 生成过程的形式化：离散化与自回归展开

§1.5 定义了 $f$-chain 作为**连续状态空间 $\mathbb{R}^d$ 上的动力系统**，其输出 $\text{output}(x) = E(x) \cdot x \in \mathbb{R}^d$ 是连续向量。实际语言模型输出的是离散 token——本节形式化这一"连续→离散"的转换，并由此导出自回归展开的完整数学定义。

#### A. 离散化步骤与 $\varepsilon_{\text{tok}}$

**定义（语言模型头与离散化）**：设词表 $\mathcal{V}$，$|\mathcal{V}| = V$。语言模型头（LM head）是线性映射 $W_{\text{LM}} \in \mathbb{R}^{V \times d}$，将 $f$-chain 的输出映射为 logit 向量：

$$z = W_{\text{LM}} \cdot h_k \in \mathbb{R}^V$$

给定温度参数 $T > 0$，定义输出分布：

$$p_T(w \mid x) = \frac{\exp(z_w / T)}{\sum_{w'} \exp(z_{w'} / T)}, \quad w \in \mathcal{V}$$

采样 $\hat{w} \sim p_T(\cdot \mid x)$ 得到输出 token $\hat{w} \in \mathcal{V}$，对应嵌入向量 $e_{\hat{w}} \in \mathbb{R}^d$。

**定义（令牌化误差 $\varepsilon_{\text{tok}}$）**：对目标语义状态 $h^* \in \mathbb{R}^d$，离散化步骤引入的**令牌化误差**为：

$$\varepsilon_{\text{tok}} \triangleq \mathbb{E}_{\hat{w} \sim p_T}\!\left[\|e_{\hat{w}} - h^*\|\right]$$

$\varepsilon_{\text{tok}}$ 是**连续 $f$-chain 输出物化为离散 token 时的信息损失**，是温度 $T$ 的单调函数：

$$T \to 0 \implies p_T \to \delta_{\arg\max_w z_w} \implies \varepsilon_{\text{tok}} = \|e_{\hat{w}^{\text{greedy}}} - h^*\|$$
$$T \to \infty \implies p_T \to \text{Uniform}(\mathcal{V}) \implies \varepsilon_{\text{tok}} \to \mathbb{E}_{w \sim \text{Unif}}[\|e_w - h^*\|]$$

---

#### B. $T$ 步自回归展开

**定义（自回归展开）**：设初始输入 $x^{(0)} = x$，$T$ 步自回归展开定义如下迭代过程：

对 $t = 0, 1, \ldots, T-1$：

$$h_k^{(t)} = \text{f-chain}(x^{(t)}), \qquad \hat{w}^{(t+1)} \sim p_{T_t}\!\left(\cdot \mid x^{(t)}\right), \qquad x^{(t+1)} = \left(x^{(t)},\, e_{\hat{w}^{(t+1)}}\right)$$

其中 $(x^{(t)}, e_{\hat{w}^{(t+1)}})$ 表示将新 token 的嵌入追加至上下文序列。最终输出序列为 $(\hat{w}^{(1)}, \ldots, \hat{w}^{(T)})$。

**结构观察**：每步迭代由**一次 $f$-chain 前向传播**和**一次离散化采样**交替构成。$T$ 步展开将有效计算深度从 $k$（单次 $f$-chain 层数）扩展至 $k \cdot T$——与命题 11.1a 的 CoT 扩展完全对应。

---

#### C. 自回归展开与 CoT 的同构定理

**定理 1.7（自回归展开 $\cong$ CoT，严格版本）**：

设 $T$ 步自回归展开产生 token 序列 $(\hat{w}^{(1)}, \ldots, \hat{w}^{(T)})$，$k$ 步 CoT 定义为（命题 4.3）：将目标 $r$-chain 分为 $k$ 段，每段对应一个中间 token。

则两者是**同一个数学结构**的两种描述：

$$\text{自回归展开} \equiv \text{CoT}, \quad \text{当且仅当} \quad \hat{w}^{(t)} \approx r_{i_t}(h^{(t-1)}) \text{ 对所有 } t \text{ 成立}$$

更精确地，令 $r$-chain 的目标为 $q = r_{i_T} \circ \cdots \circ r_{i_1}$，定义第 $t$ 步的**对齐误差**为：

$$\varepsilon_{\text{tok}}^{(t)} = \|e_{\hat{w}^{(t)}} - r_{i_t}(h^{(t-1)})\|$$

则自回归过程的总误差界与命题 5.3（CoT 完整误差界）完全相同：

$$\text{Err}_{\text{AR}}(T) \leq \sum_{t=1}^{T} L^{T-t} \cdot \varepsilon_{\text{tok}}^{(t)} \leq T \cdot \varepsilon_{\text{tok}}^{\max} \cdot \frac{L^T - 1}{L - 1}$$

**推论 1.7a（两种范式的统一解释）**：

| 生成模式 | $\varepsilon_{\text{tok}}^{(t)}$ 的语义 | IDFC 含义 |
|---|---|---|
| 普通自回归（无 CoT） | token 不对应语义 $r$-chain 步，$\varepsilon_{\text{tok}}^{(t)}$ 大 | $f$-chain 有效链路被短截，每步误差大 |
| 理想 CoT | token 精确对应某个 $r_i$ 的物化，$\varepsilon_{\text{tok}}^{(t)} \to 0$ | 自回归等价于逐步执行 $r$-chain |
| 退化 CoT（$\varepsilon_{\text{tok}}^{(t)} > \varepsilon_{\max}$） | 中间 token 反而引入更大误差 | 命题 5.3b 失效条件：CoT 有害 |

> **核心命题**：一切自回归语言模型的生成过程本质上都是 CoT——区别仅在于中间 token 对目标 $r$-chain 步骤的**对齐质量** $\varepsilon_{\text{tok}}^{(t)}$。"Chain-of-Thought"是对这个对齐质量从低到高的一端的工程描述，不是一种独立的计算机制。

---

#### D. 温度 $T$ 在 IDFC 中的精确角色

温度 $T$ 是**离散化步骤的锐利度参数**，控制 $\varepsilon_{\text{tok}}$ 的大小：

- $T$（温度）↑ → $p_T$ 分布更平 → $\varepsilon_{\text{tok}}$ ↑ → 自回归每步引入更大扰动
- $T$ ↓ → 趋向 argmax → $\varepsilon_{\text{tok}}$ 最小化（但 greedy 可能非最优路径）

> **注意**：$T$（输出温度，本节）与 Attention 内的缩放 $\sqrt{d_k}$（Part 4 §1.2）是两个不同的 softmax，前者在 $f$-chain 出口控制离散化，后者在 $f$-chain 内部控制路由锐利度。

---

> [!NOTE]
> §1.7 定义的形式框架供 Part 3 §4.4、§5.3 的 CoT 分析引用（$\varepsilon_{\text{tok}}$ 的正式来源），并为 Part 4 §8 的 Diffusion 范式对比提供基准。Diffusion 的区别在于：整条去噪轨迹取消了逐步离散化，$\varepsilon_{\text{tok}}$ 仅在最终步骤一次性产生（见 Part 4 §8）。

---

## 2. 核心假说：组合近似封闭性

#### 前提设定

设训练原语集为：

$$R_{\text{tr}} \;=\; \{r_1, r_2, \ldots, r_m\} \;\subset\; R \;\subset\; \Omega$$

**定义（单步拟合误差）**：对每个 $r_i \in R_{\text{tr}}$，训练后的网络 $F$ 对应的有效算子场 $E_{r_i}: \mathcal{X} \to \langle F \rangle_\cdot$ 的**实际逐点误差**定义为：

$$\varepsilon_i \;\triangleq\; \sup_{x \in \mathcal{X}} \|E_{r_i}(x)\cdot x - r_i(x)\|$$

$\varepsilon_i$ 是**定义量**，不是假设——对任意 $F$ 和任意 $r_i$，此上确界总是存在的。**万能逼近定理（UAT）** 保证：对 $\mathcal{X}$ 上的任意连续函数 $r_i$，当模型规模 $M$ 充分大时，$\varepsilon_i$ 可以被压制到任意小（存在性 + 精度控制，详见 §3.3）。

设 $\varepsilon_{\max} = \max_i \varepsilon_i$，$L = \max_i \|G_i\|_{\mathrm{Lip}}$（最大逐层 Lipschitz 常数，由 §1.5.D）。

**未见任务集**：由 $R_{\text{tr}}$ 的有限复合可以描述但未在训练分布中出现的任务：

$$Q_{\text{unseen}} \;=\; \bigl\{q = r_{i_l}\!\circ\!\cdots\!\circ\! r_{i_1} \;\big|\; \mathbf{r} \in R_{\text{tr}}^{\,l},\; l \geq 2,\; q \notin R_{\text{tr}}\bigr\} \;\subset\; R^* \setminus R_{\text{tr}}$$

#### 定理（CAC 误差界）——严格版本

> **定理（CAC）**：设 $\varepsilon_i$ 为训练后 $F$ 对 $r_i \in R_{\text{tr}}$ 的实际单步误差（如上定义），$L$ 为链路最大 Lipschitz 常数。则对任意长度为 $l$ 的未见任务 $q = r_{i_l}\!\circ\!\cdots\!\circ\! r_{i_1} \in Q_{\text{unseen}}$，以各层拟合算子场逐步复合的 $F$-链：
>
> $$\hat{h}_0 = x, \quad \hat{h}_j = E_{r_{i_j}}(\hat{h}_{j-1})\cdot\hat{h}_{j-1}$$
>
> 严格满足：
>
> $$\forall x \in \mathcal{X}: \quad \left\| \hat{h}_l \;-\; q(x) \right\| \;\leq\; \varepsilon_{\max} \cdot \frac{L^l - 1}{L - 1}$$
>
> 此界由 Lipschitz 望远镜展开严格推导（见 §3.2），不依赖任何额外假设——$\varepsilon_i$ 和 $L$ 均为训练后网络的**可测定义量**。
>
> **推论**：UAT（§3.3）保证 $\varepsilon_{\max} \to 0$ 当 $M \to \infty$，此时对固定链长 $l$ 和 $L$，误差界趋于零。

#### 代数含义

CAC 断言**逐点拟合关系在复合运算下近似传递**：映射

$$\rho: R_{\text{tr}} \to \mathrm{Map}\!\bigl(\mathcal{X},\, \langle F \rangle_\cdot\bigr), \quad r_i \mapsto E_{r_i}$$

> **注（$\rho$ 的纯数值语义）**：$\rho$ 是**数值配对映射**，将 $r_i \in R_{\text{tr}}$ 与满足逐点拟合约束 $\|E_{r_i}(x)\cdot x - r_i(x)\| \leq \varepsilon_i$（§1.6）的矩阵值函数 $E_{r_i}$ 配对。$\rho$ 不蕴含因果、语义等价或功能对应——$E_{r_i}(x)$ 是满足数值不等式的矩阵乘积，下标 $r_i$ 为分析者外加的命名约定（§1.3 语义防火墙）。

在复合意义下，$\rho$ 构成从自由幺半群 $R_{\text{tr}}^*$ 到 $\langle F \rangle_\cdot$-值函数链的**近似幺半群同态**：

$$\rho(r_l \circ \cdots \circ r_1) \;\approx\; \rho(r_l) \cdot_{\text{chain}} \cdots \cdot_{\text{chain}} \rho(r_1) \quad \text{（误差 }\leq \varepsilon_{\max}(L^l-1)/(L-1)\text{）}$$

精确叙述：对 $q = r_l \circ \cdots \circ r_1 \in Q_{\text{unseen}}$，存在矩阵乘积链 $E_{r_l}(\hat{h}_{l-1})\cdots E_{r_1}(x)$，使得其在 $x$ 上的作用结果与 $q(x)$ 的偏差 $\leq \varepsilon_{\max}(L^l-1)/(L-1)$——**组合是免费的，代价仅在误差随 $l$ 和 $L$ 增长**。对比原语的单步情形：对每个 $r_i \in R_{\text{tr}}$，训练后存在 $E_{r_i}: \mathcal{X} \to \langle F \rangle_\cdot$ 满足 $\|E_{r_i}(x)\cdot x - r_i(x)\| \leq \varepsilon_i$；训练的作用是使这些矩阵值函数的上确界误差 $\varepsilon_i$ 足够小，而非使 $F$ 中出现具有 $r_i$ 语义的功能单元。

> [!IMPORTANT]
> **CAC 误差界本身是严格定理**，无经验性前提——$\varepsilon_i$ 由定义给出，误差界是代数推论。§3.4 定理 3.3 证明训练过程将 $\bar{L}$ 锁定在 $1 + \epsilon$（Edge of Chaos），$\epsilon \leq \ln C_{\text{train}}/k$，有效推理链长上界 $l^* \approx k\ln(1/\varepsilon_{\max})/\ln C_{\text{train}}$。
>
> **开放问题**：**覆盖性**——目标任务是否真的在 $Q_{\text{unseen}}$（即可分解为 $R_{\text{tr}}$ 的有限复合），这取决于 $R_\text{tr}$ 对自然语言推理原语的覆盖度，目前无法形式化。



---

## 3. 误差分析：CAC 定理的完整证明

本节给出 §2 中 CAC 定理的严格证明，并分析模型规模 $M$ 对误差的控制作用。

### 3.1 符号统一与单步误差

**符号对齐**：§1.6 定义了逐点拟合：对 $r_i \in R_{\text{tr}}$，存在矩阵值函数 $E_{r_i}: \mathcal{X} \to \langle F \rangle_\cdot$ 使得：

$$\hat{f}_i(x) \triangleq E_{r_i}(x) \cdot x, \qquad \|\hat{f}_i(x) - r_i(x)\| \leq \varepsilon_i \quad \forall x \in \mathcal{X}$$

其中 $\varepsilon_i \triangleq \sup_{x \in \mathcal{X}} \|E_{r_i}(x) \cdot x - r_i(x)\|$（§2 的定义量）。$\hat{f}_i$ 是"用当前输入选出的矩阵作用于当前输入"，不是固定矩阵。

为简洁，以下记 $\hat{f}_j \equiv \hat{f}_{r_{i_j}}$（第 $j$ 步对应的近似函数），$\varepsilon_j \equiv \varepsilon_{i_j}$。

---

### 3.2 链路误差的 Telescope 展开（CAC 定理的完整证明）

**定理（CAC 误差界，完整证明）**：设 $q = r_{i_l} \circ \cdots \circ r_{i_1}$ 为长度 $l$ 的 $r$-链，$f$-链递推定义为：

$$\hat{h}_0 = x, \qquad \hat{h}_j = \hat{f}_j(\hat{h}_{j-1}) = E_{r_{i_j}}(\hat{h}_{j-1}) \cdot \hat{h}_{j-1}$$

设真实 $r$-链的中间状态为 $h_0^* = x$，$h_j^* = r_{i_j}(h_{j-1}^*)$。则：

$$\|\hat{h}_l - h_l^*\| \leq \varepsilon_{\max} \cdot \frac{L^l - 1}{L - 1}$$

**证明**：

定义第 $j$ 步的累积误差 $e_j = \|\hat{h}_j - h_j^*\|$。

**初始条件**：$e_0 = \|\hat{h}_0 - h_0^*\| = \|x - x\| = 0$。

**第 $j$ 步的递推不等式**：

$$e_j = \|\hat{h}_j - h_j^*\| = \|\hat{f}_j(\hat{h}_{j-1}) - r_{i_j}(h_{j-1}^*)\|$$

插入中间量 $r_{i_j}(\hat{h}_{j-1})$，应用三角不等式：

$$e_j \leq \underbrace{\|\hat{f}_j(\hat{h}_{j-1}) - r_{i_j}(\hat{h}_{j-1})\|}_{\text{（A）单步拟合误差}} + \underbrace{\|r_{i_j}(\hat{h}_{j-1}) - r_{i_j}(h_{j-1}^*)\|}_{\text{（B）$r_{i_j}$ 的 Lipschitz 传播}}$$

- **项（A）**：由逐点拟合定义，$\|\hat{f}_j(y) - r_{i_j}(y)\| \leq \varepsilon_{i_j} \leq \varepsilon_{\max}$，对任意 $y$ 成立，故取 $y = \hat{h}_{j-1}$ 得 $\text{(A)} \leq \varepsilon_{\max}$。

- **项（B）**：$r_{i_j}$ 是 $L$-Lipschitz 函数（$L$ 为全局最大逐层 Lipschitz 常数，由 §1.5.D 命题 1.1），故 $\text{(B)} \leq L \cdot \|\hat{h}_{j-1} - h_{j-1}^*\| = L \cdot e_{j-1}$。

得递推关系：

$$e_j \leq \varepsilon_{\max} + L \cdot e_{j-1}, \qquad e_0 = 0$$

**展开递推**（Telescope 展开）：

$$e_1 \leq \varepsilon_{\max}$$
$$e_2 \leq \varepsilon_{\max} + L\varepsilon_{\max} = \varepsilon_{\max}(1 + L)$$
$$e_3 \leq \varepsilon_{\max} + L \cdot \varepsilon_{\max}(1 + L) = \varepsilon_{\max}(1 + L + L^2)$$
$$\vdots$$
$$e_l \leq \varepsilon_{\max}(1 + L + L^2 + \cdots + L^{l-1}) = \varepsilon_{\max} \cdot \frac{L^l - 1}{L - 1}$$

（$L = 1$ 时几何级数退化为 $l$，即 $e_l \leq l \cdot \varepsilon_{\max}$。）$\square$

> **注（$L$ 的来源）**：项（B）使用 $r_{i_j}$ 是 $L$-Lipschitz。$r_{i_j} \in \Omega$ 是语义空间上的变换，其 Lipschitz 常数原则上由训练数据决定。在 IDFC 框架中，$L$ 取的是所有步骤中最大的 Lipschitz 常数，即 $L = \max_j \|G_{i_j}\|_{\text{Lip}}$（由 §1.5.D 命题 1.1 给出的累积 Lipschitz 常数的单步版本）。精确地，$L$ 应是 $r_{i_j}$ 的 Lipschitz 常数，此处以网络层的 Lipschitz 常数代理。

> **注（证明的保守性）**：Telescope 展开对 $j$ 步的误差均取上界 $\varepsilon_{\max}$（而非各步实际的 $\varepsilon_{i_j}$），并对 Lipschitz 传播取全局最大 $L$。当各步误差和 Lipschitz 常数差异显著时，实际误差远低于此界。

> **注（Telescope 界的紧性——存在性下界）**：上界在最坏情形下可达，与训练机制无关。构造：选取目标链 $q = r_{i_l} \circ \cdots \circ r_{i_1}$ 使每步近似误差向量 $\delta_j \triangleq \hat{f}_j(\hat{h}_{j-1}) - r_{i_j}(\hat{h}_{j-1})$ 与累积误差 $(\hat{h}_{j-1} - h_{j-1}^*)$ 方向一致（无抵消）。则 Telescope 递推中每个 $\leq$ 均取等，给出存在性下界：
>
> $$\exists\, x,\, q:\quad e_l \;\geq\; \varepsilon_{\min} \cdot \frac{L^l - 1}{L - 1}$$
>
> 此界仅依赖 $\varepsilon_{\min} > 0$（最小单步误差）和任意 $L > 0$，不涉及训练假设。TSC 对 $L$ 的约束（§3.4）决定了该下界的具体增长速率。

---

### 3.3 万能逼近定理（UAT）与误差收敛

**命题 3.1（逐点拟合的 UAT 保证）**：设 $r_i : \mathcal{X} \to \mathcal{X}$ 在有界域 $\mathcal{X} \subset \mathbb{R}^d$ 上是连续函数。则对任意 $\varepsilon > 0$，存在规模 $M_0(\varepsilon, r_i)$ 使得：当 $M \geq M_0$ 时，训练后的 $F$ 存在 $E_{r_i}: \mathcal{X} \to \langle F \rangle_\cdot$ 满足：

$$\sup_{x \in \mathcal{X}} \|E_{r_i}(x) \cdot x - r_i(x)\| \leq \varepsilon$$

**证明思路（UAT 到逐点拟合的桥接）**：

UAT（Cybenko 1989; Hornik 1991）经典陈述为：对 $\mathcal{X}$ 上的任意连续函数 $g: \mathbb{R}^d \to \mathbb{R}^d$ 和 $\varepsilon > 0$，存在有限宽度的浅层 MLP 使得均匀逼近误差 $< \varepsilon$。

从 UAT 到本文设定需要以下桥接：

**步骤 1（连续性保证）**：$r_i: \mathcal{X} \to \mathcal{X}$ 的连续性满足 UAT 前提（IDFC 框架中 $r_i$ 是语义变换，自然连续性在 $\mathcal{X} = \mathbb{R}^d$ 上的有界子集成立）。

**步骤 2（逼近目标的重写）**：目标逼近 $r_i(x)$ 等价于逼近函数 $g_i: x \mapsto r_i(x)$。UAT 保证存在一个 MLP $\tilde{f}_i$ 使得 $\|\tilde{f}_i(x) - r_i(x)\| \leq \varepsilon/2$。

**步骤 3（逐点拟合的 IDFC 实现）**：$\tilde{f}_i(x)$ 是一个标准 MLP。在 IDFC 框架中，该 MLP 的计算等价于：对输入 $x$，激活路径选出某个 $E(x) \in \langle F \rangle_\cdot$，使得 $E(x) \cdot x = \tilde{f}_i(x)$（由 §1.5.B 的代数结构，任意 MLP 输出均可写成此形式）。故 $E_{r_i}(x) \triangleq E(x)$ 满足逐点拟合定义。

**步骤 4（规模关系）**：UAT 只保证存在性，不给出 $M_0$ 的显式公式。但命题保证随 $M \to \infty$，$F$ 的近似能力单调增强，$\varepsilon_i^* = \inf_{\text{valid } E_{r_i}} \sup_x \|E_{r_i}(x) \cdot x - r_i(x)\|$ 趋于 $0$。$\square$

**推论 3.2（链路误差的渐近收敛）**：对固定链长 $l$ 和固定 $L$，当 $M \to \infty$：

$$\varepsilon_{\max} \cdot \frac{L^l - 1}{L - 1} \xrightarrow{M \to \infty} 0$$

即：对任意有限复合长度的未见任务，充分大的模型可以将 CAC 误差压制到任意小的 $\delta > 0$。

---

### 3.4 训练-推理对偶性：有效链长上界

本节给出 CAC 误差界的完整严格形式，并说明 $\bar{L}$ 的约束来源。论证分三层：先建立抽象接口（TSC），再在接口条件下推导定理，最后证明反向传播满足该接口。

#### 定义（训练稳定性契约，TSC）

称一种训练方法满足**训练稳定性契约（Training Stability Contract，TSC）**，若其产生的模型参数使得逐层 Lipschitz 常数的几何均值：

$$\bar{L} \;\triangleq\; \left(\prod_{l=1}^{k} \|G_l\|_{\mathrm{Lip}}\right)^{1/k}$$

满足存在有界常数 $C > 1$，使得：

$$1 \;<\; \bar{L} \;\leq\; C^{1/k}$$

同时，以 $\|G_j\|_{\mathrm{Lip}}$ 代理 $r_j$ 的 Lipschitz 常数时，对任意尺度 $R = \|h-h'\| > 0$，局部 Lipschitz 比满足：$\frac{\|r_j(h)-r_j(h')\|}{R} \leq \|G_j\|_{\mathrm{Lip}} + \frac{2\varepsilon_j}{R}$（见命题 3.4 步骤 3）。在 CAC 链路中取 $R = e_{j-1}$（当步累积误差），代理在 $e_{j-1} \gg \varepsilon_j$ 时自动收紧，无需全局最小间距 $s > 0$。

> TSC 是对训练结果的**可观测约束**，不依赖具体的优化算法。任何产生满足上述不等式的模型参数的训练方法——无论是梯度下降、进化策略还是其他机制——均满足 TSC。

---

#### 定理 3.3（训练-推理对偶性）

**设训练方法满足 TSC，常数为 $C$，网络深度为 $k$。** 令 $\epsilon \triangleq \bar{L} - 1$，则由 TSC 知 $0 < \epsilon \leq \frac{\ln C}{k}$。

代入 CAC 误差界（§3.2，以 $\bar{L}$ 代入 $L$，TSC 的代理条件保证合法），得**严格完整形式**：

$$\boxed{e_l \;\leq\; \varepsilon_{\max} \cdot \frac{(1+\epsilon)^l - 1}{\epsilon}, \qquad 0 \;<\; \epsilon \;\leq\; \frac{\ln C}{k}}$$

**推论 3.3a（有效链长上界）**：定义**临界链长** $l^*$ 为误差界首次超过 $1/\varepsilon_{\max}$ 倍的链长：

$$l^* \;\triangleq\; \left\lfloor\frac{\ln(1/\varepsilon_{\max})}{\ln(1+\epsilon)}\right\rfloor \;\approx\; \frac{k \cdot \ln(1/\varepsilon_{\max})}{\ln C}$$

当 $l > l^*$ 时，CAC 误差界超出 $\varepsilon_{\max}$ 的可控范围，推理链路的累积误差无法被单步精度吸收。

> $l^*$ 由两个量决定：模型深度 $k$（越深 $l^*$ 越大）和训练常数 $C$（越小越好）。不同的训练方法通过影响 $C$ 来影响最大可靠推理深度。

**推论 3.3b（TSC 推理深度不可能性——测度论下界）**：设训练方法满足 TSC，从而 $\bar{L} > 1$。设 $\mathcal{X} = \mathbb{R}^d$，目标 $r$-链从自然语言任务中随机选取（服从任意绝对连续分布，不对齐到网络某个固定子空间）。则对几乎所有（Lebesgue 测度意义下）的目标链：

$$\Pr\!\left[e_l \xrightarrow{l \to \infty} +\infty\right] = 1$$

**证明**：

**步骤 1（奇异值分析）**：对每层 $G_j$，最大奇异值 $\sigma_{\max,j} = \|G_j\|_{\mathrm{Lip}}$。由 TSC 几何均值下界 $\bar{L} > 1$，至少一半层满足 $\sigma_{\max,j} > 1$（否则几何均值 $\leq 1$，矛盾）。

**步骤 2（误差投影递推）**：设累积误差向量 $\mathbf{e}_l = \hat{h}_l - h_l^*$，$v_j$ 为第 $j$ 层最大奇异值对应的右奇异向量。沿 $v_j$ 方向投影：

$$\langle \mathbf{e}_l,\, v_j \rangle \;\geq\; \sigma_{\max,j} \cdot \langle \mathbf{e}_{l-1},\, v_j \rangle - \varepsilon_j$$

当投影超过阈值 $\varepsilon_j / (\sigma_{\max,j} - 1)$ 后，误差分量单调递增。

**步骤 3（一般位置论证）**：使单步误差 $\delta_j$ 在所有扩张方向投影恒为零（$\langle \delta_j, v_j \rangle = 0$ 对所有步成立）的任务链集合，是 $\mathbb{R}^d$ 中余维度 $\geq 1$ 的代数流形，Lebesgue 测度为零。

**步骤 4（结论）**：绝对连续分布的 $r$-链以概率 $1$ 不落在此零测集，故以概率 $1$ 存在某步 $j_0$ 使投影超过阈值，此后误差以 $\sigma_{\max}^{l - j_0}$ 指数增长趋于无穷。$\square$

> **下界层级总结**：
>
> | 强度 | 陈述 | 位置 | 依赖 |
> |---|---|---|---|
> | 存在性 | $\exists$ 输入使 $e_l \to \infty$ | §3.2 紧性注 | $\varepsilon_{\min} > 0$，与训练无关 |
> | **测度论** | **几乎所有任务 $e_l \to \infty$（概率 1）** | **推论 3.3b** | **TSC（$\bar{L} > 1$）** |
> | 普遍性 | 所有输入 $e_l \to \infty$ | — | ❌ 不可证（零测集任务可规避）|
>
> TSC 通过测度论将不可能性从"最坏情形存在"升级为"几乎所有真实任务均受限"。能让误差有界的任务集合是零测集，实践中无法系统性构造。




---

#### 命题 3.4（反向传播满足 TSC）

当前主流的梯度下降训练满足 TSC，常数 $C = \sqrt{2/(\eta\beta_0)}$（其中 $\eta$ 为学习率，$\beta_0$ 为损失光滑参数）。

**证明**（三步）：

**步骤 1（$\bar{L} > 1$，数据下界）**：设训练集 $\mathcal{D}$ 中存在样本对 $(x_i, y_i), (x_j, y_j)$ 满足 $C_\mathcal{D} = \frac{\|y_i - y_j\|}{\|x_i - x_j\|} > 1$。对训练误差 $< \delta$ 的模型，三角不等式给出：

$$\|F_\theta(x_i) - F_\theta(x_j)\| \;\geq\; C_\mathcal{D}\|x_i - x_j\| - 2\delta \;\implies\; L_{\text{local}} \;\geq\; C_\mathcal{D} - \frac{2\delta}{\|x_i - x_j\|} \;>\; 1$$

自然语言训练集必然包含 $C_\mathcal{D} > 1$ 的样本对（同义句对应不同事实等），故此为数据的固有性质。由此得 $\bar{L} \geq L_{\text{local}} > 1$。

**步骤 2（$\bar{L} \leq C^{1/k}$，稳定性上界）**：端到端 Jacobian 满足 $\|J_{\text{output}}\| \leq \bar{L}^k$（§1.5.D 链式不等式）。GD 收敛要求 $\eta \leq 2/\beta$，有效曲率 $\beta \leq \beta_0 \cdot \bar{L}^{2k}$，整理得：

$$\bar{L}^{2k} \;\leq\; \frac{2}{\eta\beta_0} \;\triangleq\; C^2 \;\implies\; \bar{L} \;\leq\; C^{1/k}$$

**步骤 3（代理合法性——尺度局部）**：对任意 $h, h'$ 满足 $R = \|h-h'\| > 0$，由三角不等式：

$$\|r_j(h) - r_j(h')\| \;\leq\; \|\hat{f}_j(h) - \hat{f}_j(h')\| + 2\varepsilon_j \;\leq\; \|G_j\|_{\mathrm{Lip}} \cdot R + 2\varepsilon_j$$

除以 $R$：$\frac{\|r_j(h)-r_j(h')\|}{R} \leq \|G_j\|_{\mathrm{Lip}} + \frac{2\varepsilon_j}{R}$。在 CAC Telescope 展开中取 $R = e_{j-1}$（当步累积误差）：误差 $= 2\varepsilon_j/e_{j-1} \to 0$ 当 $e_{j-1} \gg \varepsilon_j$（UAT 保证 $\varepsilon_j \to 0$）。无需全局最小间距 $s > 0$，代理在 CAC 分析的关键尺度（大误差阶段）自动收紧。$\square$

> **TSC 的普适性**：定理 3.3 仅依赖 TSC，不依赖命题 3.4 的具体推导。若未来出现不基于梯度下降的训练方法（进化策略、前向-前向算法、生物 STDP 等），只要其模型参数满足 $1 < \bar{L} \leq C^{1/k}$，定理 3.3 和推论 3.3a 自动成立，$l^*$ 的公式保持不变。

> [!IMPORTANT]
> **§3 的证明状态总结**：
>
> | 命题 | 状态 | 依赖 |
> |---|---|---|
> | Telescope 展开（§3.2） | ✅ 严格 | 三角不等式 + $r_i$ 的 Lipschitz 性 |
> | UAT 存在性（§3.3 命题 3.1） | ✅ 严格（模 UAT） | Cybenko/Hornik UAT，$r_i$ 连续性 |
> | $\varepsilon_i^* \to 0$（推论 3.2） | ✅ 严格（模 UAT） | 命题 3.1 的直接推论 |
> | 定理 3.3（TSC → $l^*$） | ✅ 严格（模 TSC） | TSC 定义；代理条件 $\varepsilon_j \ll s$ |
> | 命题 3.4（BP 满足 TSC） | ✅ 条件严格 | 数据固有 $C_\mathcal{D}>1$ + GD 收敛 + UAT |
> | $r_i$ 的连续性假设 | ⚠️ 语义假设 | 语义变换的拓扑性质，依赖 $\mathcal{X}$ 的结构 |



