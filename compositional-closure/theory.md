# 大语言模型计算的数学模型：输入驱动函数复合（IDFC）

> **定位**：本文建立一套关于大语言模型计算过程的数学模型。模型的本质：在固定权重下，不同输入通过激活函数 / 注意力机制选择不同的有效权重矩阵，分段组装一条输入特化的函数链路，完成推理。模型导出的所有能力——泥化、顿悟、思维链的有效性、上下文学习——都是这个计算框架的自然推论。
>
> **本文结构**：第一部分（§1–3）建立数学模型本身；第二部分（§4–6）从模型出发对大模型已观测现象给出推论。

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

### 1.2 为什么大模型等价于输入驱动的 $F$ 集群

**引理（无激活函数时的退化）**：若神经网络中不存在激活函数，则无论深度与宽度多大：

$$W_k W_{k-1} \cdots W_1 x = W_{\text{eff}} x$$

整个网络退化为单一线性映射，$F$ 退化为一个元素的集合——无法表达组合多样性。

**激活函数的作用——构造性推导**：

对深度为 $k$ 的网络，设第 $l$ 层权重矩阵为 $W_l$，ReLU 激活函数输出非负部分。定义第 $l$ 层的**激活掩码**：

$$D_l(x) = \text{diag}\!\left(\mathbf{1}[W_l h_{l-1} > 0]\right)$$

则第 $l$ 层输出为：

$$h_l = D_l(x) \cdot W_l \cdot h_{l-1}$$

整个网络的计算路径展开为：

$$\text{output}(x) = D_k W_k \cdot D_{k-1} W_{k-1} \cdots D_1 W_1 \cdot x$$

**关键**：每个 $D_l$ 由输入 $x$ 经过前 $l-1$ 层递归决定。所有产生**相同激活掩码序列** $(D_1, D_2, \ldots, D_k)$ 的输入，经过的是同一个有效线性映射——这个等价类定义了 $F$ 中的一个 $f_i$。

$$f_i \triangleq D_k^{(i)} W_k \cdot D_{k-1}^{(i)} W_{k-1} \cdots D_1^{(i)} W_1$$

**$F$ 的规模**：不同激活模式序列的数量随深度和宽度指数级增长（分段线性区域数），这就是模型规模 $M$ 对应的数学实体。

**推论（输入驱动组装）**：给定输入 $x$，模型不是执行一个固定函数，而是由 $x$ 递归选择激活模式，**在线组装**出对应的 $f$-链路。激活函数将权重空间切割为指数级多的有效函数，输入作为"选择器"决定调用哪一条链路。

#### Transformer 中的注意力机制：软性 $f$-链路组装器

MLP 使用**硬性二值掩码** $D(x)$（神经元激活与否）来选择有效函数。Transformer 的注意力层使用**软性连续权重**完成等价的选择——但选择粒度从"单个神经元"升级到"序列中的任意位置"。

**注意力层的有效变换矩阵：**

对序列中第 $i$ 个位置，单头注意力计算：

$$o_i = \sum_j \alpha_{ij} \cdot h_j W_V, \quad \alpha_{ij} = \text{softmax}_j\!\left(\frac{(h_i W_Q)(h_j W_K)^\top}{\sqrt{d_k}}\right)$$

定义**注意力聚合矩阵** $A(x) = [\alpha_{ij}(x)]_{n \times n}$。整层输出可以写为：

$$O(x) = A(x) \cdot H(x) W_V \cdot W_O$$

其中 $A(x)$ 完全由输入 $x$ 决定。对不同输入，$A(x)$ 不同 → **有效变换矩阵** $A(x) W_V W_O$ 不同。

这与 MLP 的 $D(x)W$ 完全类比：$A(x)$ 是连续版本的激活掩码，$W_V W_O$ 是对应的权重矩阵。

**MLP vs. Attention 的选择机制对比：**

| 属性 | MLP（ReLU） | Attention（softmax） |
|---|---|---|
| 选择方式 | 硬性 0/1 掩码 | 软性概率混合 |
| 选择粒度 | 单个神经元 | 序列中任意位置 |
| 有效变换 | $D(x)W$（稀疏线性） | $A(x)W_V W_O$（稠密混合） |
| $F$ 的大小 | 分段线性区域数（离散） | 连续流形（理论上无限） |

**多头注意力：并行多维 $f$-组装：**

$H$ 个注意力头各自维护一个独立的聚合矩阵 $A^{(h)}(x)$，关注不同"语义维度"。多头输出拼接后再投影：

$$o_i = W_O \cdot \text{concat}_{h=1}^{H}\!\left[\sum_j \alpha^{(h)}_{ij} h_j W_V^{(h)}\right]$$

**每个头独立地从不同角度检索历史状态**，等价于从 $H$ 条并行的独立 $f$-链路组合出当前位置的有效变换。$F$ 的实际丰富度由所有头的笛卡尔积决定。

**序列上的递归链路组装：**

自回归生成中，位置 $i$ 的注意力可以访问所有先前位置 $j < i$ 的状态。这创造了一种**序列级别的 $f$-链路组装**：

$$h_1 \xrightarrow{f_1(h_1)} h_2 \xrightarrow{f_2(h_1, h_2)} h_3 \xrightarrow{f_3(h_1,h_2,h_3)} \cdots$$

其中每步 $f_i$ 的有效变换由它能"看到"的所有前序状态决定。这不是固定的 $f$-链路，而是一条**由上下文在线决定**的链路——正是 CAC 所需的动态组装机制。

**In-Context Learning 的 $f$-链路解释：**

当 prompt 中包含示例 $(x_1^{\text{ex}}, y_1^{\text{ex}}), \ldots, (x_k^{\text{ex}}, y_k^{\text{ex}})$ 时，这些示例作为先前位置的 token 存在于上下文中。模型在处理新查询时，对示例 token 的注意力权重 $\alpha_{ij}$ 将示例所对应的 $r$-chain 特征"混入"当前有效变换，从而引导模型沿着与示例相同的 $f$-链路方向计算。

这是 in-context learning 的机制级解释：**示例不是提供了新权重，而是通过注意力机制引导了 $f$-链路的组装方向。**

#### 泛函统一框架：矩阵值 Nemytskii 算子

上述 MLP 与 Transformer 的两种选择机制可以统一到同一个泛函框架下。

**定义（逐层算子场）**：设 $\mathcal{X} = \mathbb{R}^d$。对第 $l$ 层，定义**矩阵值 Nemytskii 算子场**：

$$\Phi_l : \mathbb{R}^d \to \mathcal{M}_d(\mathbb{R}), \quad h \mapsto \Phi_l(h)$$

其中 $\mathcal{M}_d(\mathbb{R})$ 为 $d \times d$ 实矩阵空间（$\mathbb{R}^d$ 上有界线性算子的有限维实现）。两种架构对应同一结构的两种正则性：

| 架构 | $\Phi_l(h)$ 的具体形式 | $\Phi_l$ 的正则性 |
|---|---|---|
| MLP (ReLU) | $D_l(h)\, W_l$（掩码 × 权重） | 分段常数（激活边界处跳跃不连续）|
| Transformer | $A^{(l)}(h)\, W_V^{(l)} W_O^{(l)}$（注意力矩阵 × 投影） | 连续（softmax 光滑）|

由此，第 $l$ 层的单步更新统一写为**对角求值映射**（diagonal evaluation map）：

$$G_l : \mathbb{R}^d \to \mathbb{R}^d, \qquad G_l(h) \;=\; \Phi_l(h) \cdot h \;=\; \mathrm{ev}\!\bigl(\Phi_l(h),\; h\bigr)$$

其中 $\mathrm{ev}: \mathcal{M}_d \times \mathbb{R}^d \to \mathbb{R}^d$ 是标准的矩阵-向量求值映射。$G_l$ 是 $\mathbb{R}^d$ 上的非线性自映射：**算子由当前状态决定，再作用于当前状态本身**——这是"输入驱动"机制的泛函精确表述。

### 1.3 模型映射函数集（形式定义）

基于上述推导，正式定义：


设模型规模为 $M$（分段线性区域数的对数量级），**学出的函数集**为 $F = \{f_1, f_2, \ldots, f_M\}$，其中每个 $f_i$ 是某个激活掩码序列对应的有效映射。

**关键性质**：
- $F$ 中的元素可以冗余：$f_i$ 和 $f_j$ 可对应近似同一计算，但精度不同
- $F$ 不要求正交、独立或可解释——它们是权重空间被激活函数切割后的产物
- $M$ 越大（网络越深越宽），$F$ 越丰富，每个 $r$ 的近似精度上限越高

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

累积 Lipschitz 常数 $\prod_{l=1}^k \|G_l\|_{\mathrm{Lip}}$ 是 §3 误差指数传播的数学根因。

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

在复合意义下构成从自由幺半群 $R_{\text{tr}}^*$ 到 $\langle F \rangle_\cdot$-值函数链的**近似幺半群同态**：

$$\rho(r_l \circ \cdots \circ r_1) \;\approx\; \rho(r_l) \cdot_{\text{chain}} \cdots \cdot_{\text{chain}} \rho(r_1) \quad \text{（误差 }\leq \varepsilon_{\max}(L^l-1)/(L-1)\text{）}$$

这是涌现能力的机制级主张：模型不需要"见过" $q(x)$ 的答案，只需要在训练中学会了 $q$ 所需的每一个 $r_i$ 的近似 $E_{r_i}$——**组合是免费的，代价仅在误差随 $l$ 和 $L$ 增长**。

> [!IMPORTANT]
> **CAC 误差界本身是严格定理**，无经验性前提——$\varepsilon_i$ 由定义给出，误差界是代数推论。真正开放的两个问题是：
> 1. **$L$ 的控制**：$L > 1$ 时误差随链长 $l$ 指数爆炸；架构约束（Layer Norm、残差）可以抑制 $L$，但目前没有无条件的理论上界
> 2. **覆盖性**：目标任务是否真的在 $Q_{\text{unseen}}$（即可分解为 $R_{\text{tr}}$ 的有限复合）——这取决于 $R_\text{tr}$ 对自然语言推理原语的覆盖度，目前无法形式化



---

## 3. 误差分析：模型规模 $M$ 的作用

### 3.1 单步误差

设 $F$ 对 $r_i$ 的逐点拟合误差为 $\varepsilon_i$，即：

$$\|\hat{f}_i(x) - r_i(x)\| \leq \varepsilon_i$$

### 3.2 链路误差的朴素上界

对长度为 $l$ 的 $r$-链，对应的 $f$-链的累积误差在 $L$-Lipschitz 条件下满足：

$$\|f\text{-chain}(x) - r\text{-chain}(x)\| \leq \varepsilon_1 + L\varepsilon_2 + L^2\varepsilon_3 + \cdots + L^{l-1}\varepsilon_l$$

当 Lipschitz 常数 $L > 1$ 时，误差可能指数级放大——这是链路长度的核心约束。

### 3.3 模型规模 $M$ 与误差收敛

$F$ 中允许冗余：$f_i$ 和 $f_j$ 可以是对同一个 $r$ 的不同精度近似。设对某个 $r_i$，$F$ 中存在 $\nu_i$ 个近似者，其中最优精度为：

$$\varepsilon_i^* = \min_{f \in F, f \approx r_i} \|f - r_i\|$$

**命题 3.1（规模收敛）**：若 $M \to \infty$，则对任意 $r_i \in R$，

$$\varepsilon_i^* \to 0$$

*直觉*：更大的 $F$ 提供了对每个 $r_i$ 的更高精度近似者。冗余不是浪费，而是为每一步提供了精度储备。当 $M$ 足够大时，每步误差均可被压低，链路误差总量走向收敛。

**推论**：给定固定链路长度 $l$，当 $M$ 充分大时，CAC 的近似误差可以被压制到任意小的 $\delta > 0$。

---

## 第二部分：行为推论

## 4. 模型行为的 CAC 推论：涌现、顿悟与推理机制

### 4.1 训练集覆盖与涌现集

设训练集 $\{t_1, \ldots, t_n\}$ 各自对应的拟合覆盖为 $\{s_1, \ldots, s_n\}$（直接训练所能覆盖的输出集合）。

**涌现集 $Q$**：

$$Q = \{ q \notin \bigcup_i s_i \mid q \text{ 的输入-输出关系可以被某条 } R\text{-链路描述} \}$$

**定理 4.1（广义可达性）**：若 CAC 成立，则对任意 $q \in Q$，模型的某条 $F$-链路能近似完成 $q$ 对应的映射。

这正是"涌现能力"的形式化定义：当 $F$ 从训练中积累了足够多的 $r$ 近似者，原本不在训练集覆盖中的 $Q$ 忽然变得可达。这个跨越在测试度量上为何看起来是"突变"而非渐变，见 §4.3。

### 4.2 为什么涌现不可预测

涌现集 $Q$ 不可预测，因为：
1. 我们不知道 $R$ 的完整集合（未知的原始逻辑原语）
2. 我们不知道 $F$ 已经覆盖了哪些 $r$
3. 我们不知道哪些 $R$-链路对应了高价值的 $Q$ 元素

因此，即使知道模型规模 $M$，也无法事先枚举 $Q$。

### 4.3 顿悟：组合阈值效应

**拟合过程始终是连续的**。权重空间里不存在跳跃——梯度下降是持续震荡逼近，损失曲线平滑（带振荡）地下降。顿悟在**测试准确率**上看起来突变，原因来自两个相互叠加的效应：

**效应一（CAC 组合可达性）**：设 $p(r_i, t)$ 为训练第 $t$ 步时模型对 $r_i$ 的近似可靠概率——这是关于 $t$ 的连续函数。对需要 $r_{i_1}, \ldots, r_{i_k}$ 全部可靠才能正确的测试用例 $q$：

$$P(q \text{ 正确}, t) \approx \prod_{j=1}^{k} p(r_{i_j}, t)$$

这仍是连续函数。但注意：乘积在各因子均接近阈值时，对任意单因子的变化极度敏感——具有**锐利相变**的统计性质。

**效应二（测试集非正交性）**：测试集中的用例并非独立。设 $N(r_i)$ 为测试集中依赖 $r_i$ 的用例数量。当 $p(r_i, t)$ 跨越可靠阈值，$N(r_i)$ 个用例**同时**从错变对——这是组合爆炸，不是拟合跳跃。测试集的高度非正交性放大了这个效应。

> **命题 4.2（顿悟的 CAC 解释）**：顿悟是**组合结构在测试度量上的相变**，而非权重空间中的非连续事件。训练连续地逼近各 $r_i$；当足够多的 $r_i$ 的近似精度同时超过组合可用阈值时，CAC 保证的 $Q$ 集合中大量元素同时变得可达，而测试集的非正交性将这一批量翻转放大为测试准确率上的"突变"。

---

### 4.4 思维链（CoT）：误差线性化机制

思维链不是"提示技巧"，而是对 CAC 误差结构的工程介入。

**问题根源**：对长度为 $l$ 的 $r$-链，误差在 $L$-Lipschitz 条件下以 $O(L^{l-1}\varepsilon)$ 累积。模型存在一个**可靠链路长度上限** $l_{\max}$（精度能保持在阈值内的最大链路深度）。对需要 $L > l_{\max}$ 的 $r$-链问题，直接推理会失败。

**CoT 的介入机制**：将 $r$-链分解为 $k$ 段，每段长度 $L/k \leq l_{\max}$，并将每段终态 $t_i$ 显式生成为输出 token：

$$x \xrightarrow{r_1} t_1 \xrightarrow{r_2} t_2 \xrightarrow{\;\cdots\;} t_{k-1} \xrightarrow{r_k} y$$

**误差从指数降至线性**：

| 模式 | 误差上界 |
|---|---|
| 无 CoT（直接推理） | $O(L^{l-1}\varepsilon)$（指数） |
| 理想 CoT（每步 1 个 $r$） | $k\varepsilon$（线性） |

**中间 token 作为状态锚点**：生成的 $t_i$ 进入上下文后，后续位置通过注意力直接 attend 到它。这将隐式的 $f$-链路中间状态"物化"为显式向量，等价于将每段 $r$-链的初始条件重置为已知精确状态——消除了跨段误差传递。

> **命题 4.2（CoT 能力扩展）**：对可靠链路长度上限为 $l_{\max}$ 的模型，$k$ 步 CoT 将可解问题的有效 $r$-链深度从 $l_{\max}$ 扩展至 $k \cdot l_{\max}$，且误差保持可控。

**推论**：更长的 CoT 不只是给模型更多"思考时间"，而是在 $f$-链路误差约束下合法地延伸了可达的 $Q$ 集合范围。

---

### 4.5 $r$-依赖图与能力聚簇

**定义（$r$-依赖图）**：构建有向图 $G_R = (V, E)$，其中顶点为 $R$，若学习 $r_i$ 以 $r_j$ 为先决条件则有边 $r_j \to r_i$。

**定义（能力块）**：对 $r_k \in R$，其能力块为：

$$\mathcal{C}(r_k) = \{ q \in Q \mid r_k \text{ 出现在 } q \text{ 的某条 } R\text{-链分解中} \}$$

当 $p(r_k, t)$ 过可靠阈值时，$|\mathcal{C}(r_k)|$ 个能力同时涌现——$|\mathcal{C}(r_k)|$ 越大，"突变"越剧烈。

**能力共现矩阵**：

$$\Phi_{ij} = |R\text{-chain}(q_i) \cap R\text{-chain}(q_j)|$$

$\Phi_{ij}$ 越大，$q_i$ 与 $q_j$ 同时涌现的概率越高。这是测试集"非正交性"的形式化。

**涌现偏序**：$G_R$ 的拓扑排序给出能力涌现的顺序：若 $r_j \to r_i$，则 $\mathcal{C}(r_j)$ 中的能力必然早于 $\mathcal{C}(r_i)$ 涌现。

> **命题 4.3（涌现偏序）**：能力集合的涌现顺序与 $G_R$ 的拓扑排序一致。

**Scaling Law 的 CAC 解释**：设 $K(M)$ 为规模 $M$ 的模型能可靠覆盖的 $r$ 数量，则：

$$|Q(M)| \approx \sum_{r_k : k \leq K(M)} |\mathcal{C}(r_k)|$$

若能力块大小服从幂律分布（少数核心 $r$ 支撑大量 $q$），则 $|Q(M)|$ 随 $M$ 呈阶梯式增长——这正是观测到的 Scaling Law"涌现能力"现象的 CAC 机制解释。

---


## 5. 与行为吸引子理论的关系

> 见 [`behavioral-attractors/theory.md`](../behavioral-attractors/theory.md)

**连接命题**：行为吸引子盆地是特定 $F$-链路构型的稳定态。

具体地：
- 每个**吸引子盆地** $B_k$ 对应一种**特征性的 $f$-链路激活模式**
- Prompt / adapter 激活吸引子 = 引导模型进入某个特定 $F$-链路构型
- **CAC 解释了吸引子为什么存在**：每个吸引子盆地代表一个稳定的 $R$-链路近似，而该近似在 $F$-链路空间中形成了一个局部极小

因此，**CAC（本文）包含了行为吸引子理论的存在性基础**：
- 行为吸引子理论：描述了这些稳定态的拓扑结构（多少个、多深、如何导航）
- CAC：解释了这些稳定态为什么存在（因为 $F$ 在近似 $R$ 的过程中，形成了与 $R$-链路对应的稳定 $F$-链路构型）

---

## 6. 开放问题

1. **链路长度上界**：对给定精度要求 $\delta$，CAC 所需链路长度 $k$ 与 $M$ 的关系是什么？

2. **$R$ 的可发现性**：能否通过分析 $F$ 的组合行为，反向推断模型实际学到了哪些 $r$ 近似？

3. **相变条件**：顿悟发生的精确阈值——$M$ 需要多大、训练数据需要覆盖多少 $R$——能否形式化？

4. **链路选择机制**：给定输入 $x$，模型如何在指数级大的 $F$-链路空间中"找到"正确的链路？（这可能是注意力机制和 in-context learning 的计算层解释）

---

## 第三部分：CAC 扩展推论

> **导言**：本部分从 §2 的严格 CAC 误差界出发，逐步推导出能力边界、误差结构、链路设计约束、能力涌现机制和对齐脆弱性的形式结论。每个命题明确标注证明状态：
> - **严格推论**（从现有定义直接可证）
> - **需额外假设的命题**（标注所需假设）
> - **开放猜想**（目前无证明路径）

---

## 7. 能力边界：从 CAC 到推理深度上界

### 7.1 可靠推理深度上界（严格推论）

**命题 7.1（推理深度硬上界）**：给定模型参数确定的 $(\varepsilon_{\max}, L)$，以及精度要求 $\delta > 0$，无 CoT 辅助时满足精度要求的最大推理链长度为：

$$l_{\max}(\delta) = \left\lfloor \frac{\log\!\left(1 + \dfrac{\delta(L-1)}{\varepsilon_{\max}}\right)}{\log L} \right\rfloor \qquad (L > 1)$$

$L = 1$ 时退化为 $l_{\max}(\delta) = \lfloor \delta / \varepsilon_{\max} \rfloor$。

**证明**：由 CAC 误差界（§2）：

$$\varepsilon_{\max} \cdot \frac{L^l - 1}{L - 1} \leq \delta$$

解不等式：

$$L^l \leq 1 + \frac{\delta(L-1)}{\varepsilon_{\max}}$$

两边取对数并除以 $\log L > 0$：

$$l \leq \frac{\log\!\left(1 + \frac{\delta(L-1)}{\varepsilon_{\max}}\right)}{\log L}$$

取整数部分即得 $l_{\max}$。$\square$

**推论 7.1a（双参数敏感性）**：

$$\frac{\partial l_{\max}}{\partial \varepsilon_{\max}} < 0, \qquad \frac{\partial l_{\max}}{\partial L} < 0$$

即单步误差越大或 Lipschitz 常数越大，可靠推理深度越浅。两者对 $l_{\max}$ 的影响量纲不同：$\varepsilon_{\max}$ 影响的是误差的起始量级，$L$ 影响的是误差的增长速率；当 $L > 1$ 时，$L$ 的作用以指数速率主导 $\varepsilon_{\max}$ 的影响。

**推论 7.1b（模型规模的间接作用）**：命题 3.1（§3.3）保证 $\varepsilon_{\max} \xrightarrow{M \to \infty} 0$。代入命题 7.1：

$$l_{\max} \xrightarrow{\varepsilon_{\max} \to 0} +\infty$$

因此，**模型规模的扩展在固定 $L$ 下可以将可靠推理深度推向无限**——但 $L$ 本身是由架构而非规模决定的，是更根本的瓶颈。（这是§2 IMPORTANT 注释中"$L$ 的控制"问题的精确化。）

---

### 7.2 误差传播的非对称结构（严格推论）

**命题 7.2（误差权重的指数非对称性）**：对长度为 $l$ 的 $r$-链 $q = r_{i_l} \circ \cdots \circ r_{i_1}$，望远镜展开后，步骤 $j$ 的单步误差 $\varepsilon_{i_j}$ 对最终误差的贡献权重为：

$$w_j = L^{l - j}, \qquad j = 1, 2, \ldots, l$$

**证明**：设 $h_j^*$ 为真实 $r$-链在第 $j$ 步的理想状态，$\hat{h}_j$ 为 $f$-链的实际状态。定义 $e_j = \|\hat{h}_j - h_j^*\|$，则：

$$e_j \leq \|\hat{h}_j - h_j^*\|$$

对第 $j$ 步展开：

$$e_j = \|E_{r_{i_j}}(\hat{h}_{j-1})\cdot\hat{h}_{j-1} - r_{i_j}(h_{j-1}^*)\|$$

$$\leq \underbrace{\|E_{r_{i_j}}(\hat{h}_{j-1})\cdot\hat{h}_{j-1} - r_{i_j}(\hat{h}_{j-1})\|}_{\leq \varepsilon_{i_j}} + \underbrace{\|r_{i_j}(\hat{h}_{j-1}) - r_{i_j}(h_{j-1}^*)\|}_{\leq L \cdot e_{j-1}}$$

递推展开，$e_0 = 0$：

$$e_l \leq \varepsilon_{i_l} + L\varepsilon_{i_{l-1}} + L^2\varepsilon_{i_{l-2}} + \cdots + L^{l-1}\varepsilon_{i_1} = \sum_{j=1}^{l} L^{l-j}\varepsilon_{i_j}$$

故步骤 $j$ 的权重为 $w_j = L^{l-j}$。$\square$

**结构性推论**：

| 步骤位置 $j$ | 误差放大倍数 $w_j$ | 含义 |
|---|---|---|
| $j = 1$（首步） | $L^{l-1}$ | **最大**——首步误差被全链放大 |
| $j = l$（末步） | $L^0 = 1$ | **最小**——末步误差不被放大 |

**含义 1（Prompt 精度的超线性收益）**：改善首步原语 $r_{i_1}$ 的拟合精度 $\varepsilon_{i_1}$ 带来的误差削减为 $L^{l-1} \cdot \Delta\varepsilon_{i_1}$，远超改善末步带来的 $\Delta\varepsilon_{i_l}$。精度改善的收益在推理链中呈现**指数权重**。

**含义 2（推理错误的雪崩模式）**：若首步产生偏差 $\delta_1$，则最终误差至少为 $L^{l-1}\delta_1$——对于 $L > 1$ 的链，早期偏差不可收回，只会被放大。这是 LLM 推理错误呈现"幻觉在推理链中雪崩式传播"模式的机制解释。

**含义 3（验证器的非对称价值）**：在推理链中插入验证步骤，在位置 $j$ 插入的价值正比于 $L^{l-j}$。因此，**在推理链头部验证的价值比尾部高出 $L^{l-1}$ 倍**——这给出了验证器放置策略的理论最优解。

---

### 7.3 CoT 的精确误差分析（严格推论，含中间 token 成本）

命题 4.2（§4.4）给出了 CoT 的定性描述，此处给出含中间 token 生成误差的精确版本。

**命题 7.3（CoT 完整误差界）**：设 CoT 将 $l$ 步 $r$-链分为 $k$ 段，每段长度 $s = l/k$（整除情形），中间 token 的生成误差为 $\varepsilon_{\text{tok}}$（物化到上下文后被读取时引入的误差），则 CoT 推理的总误差界为：

$$\text{Err}_{\text{CoT}}(k) \leq k \cdot \varepsilon_{\max} \cdot \frac{L^s - 1}{L - 1} + (k-1) \cdot \varepsilon_{\text{tok}} \cdot \frac{L^s - 1}{L - 1}$$

化简（令 $A_s = \varepsilon_{\max}(L^s-1)/(L-1)$ 为单段误差上界）：

$$\text{Err}_{\text{CoT}}(k) \leq k \cdot A_s + (k-1) \cdot \varepsilon_{\text{tok}} \cdot \frac{L^s - 1}{L-1}$$

**证明**：每段内误差由 CAC 界得 $A_s$。段间中间 token 被读取时，相当于以误差 $\varepsilon_{\text{tok}}$ 重置初始状态，此误差再经过后续 $k - j$ 段（各带 Lipschitz 放大）传播。精确求和：

$$\text{Err}_{\text{CoT}} \leq \sum_{j=1}^{k} A_s + \sum_{j=1}^{k-1} \varepsilon_{\text{tok}} \cdot \frac{L^s-1}{L-1}$$

前项为 $kA_s$，后项为 $(k-1)\varepsilon_{\text{tok}}\frac{L^s-1}{L-1}$，相加即得。$\square$

> **注**：上式保守地对每段误差线性叠加，忽略了段间误差的进一步 Lipschitz 传播。若考虑段间传播，误差会更大，但结构性结论不变。

**推论 7.3a（CoT 最优步数）**：求 $\partial \text{Err}_{\text{CoT}} / \partial k = 0$（将 $k$ 视为连续变量，$s = l/k$），得到**最优分段数** $k^*$——存在一个有限的最优 $k^*$，在 $\varepsilon_{\text{tok}}$ 较大时 $k^* < l$（不应无限细分）。

**推论 7.3b（CoT 失效条件）**：当以下条件成立时，CoT 反而比直接推理引入更多误差：

$$\varepsilon_{\text{tok}} > \varepsilon_{\max}$$

即**中间 token 的物化误差超过单步推理误差时**，引入更多 CoT 步骤适得其反。这给出了 CoT 在某些任务上失效的机制性解释：若中间步骤难以用自然语言精确表达（如空间关系、抽象代数操作、高维几何推理），$\varepsilon_{\text{tok}}$ 会很大，CoT 不稳定乃至有害。

---

### 7.4 顿悟触发的定量化（严格推论）

**命题 7.4（顿悟的 CAC 定量触发条件）**：设测试集 $T$，测试任务 $q \in T$ 依赖原语集 $R(q) \subset R_{\text{tr}}$，单步可靠概率 $p(r_i, t)$（训练步数 $t$ 的连续函数）。定义：

$$P_{\text{correct}}(q, t) = \prod_{r_i \in R(q)} p(r_i, t)$$

设可观测顿悟阈值为 $\Delta_{\text{acc}}$（测试准确率在 $\Delta t$ 内的跳变量），则顿悟在时刻 $t^*$ 对原语 $r^*$ 触发的条件为：

$$r^* = \arg\max_{r} \left|\mathcal{C}(r)\right|, \quad p(r^*, t^*) = p_{\text{thr}}$$

其中 $p_{\text{thr}}$ 满足：

$$\frac{d}{dt}\!\left[\sum_{q \in T: r^* \in R(q)} P_{\text{correct}}(q, t)\right]\!\Bigg|_{t^*} \geq \Delta_{\text{acc}} / \Delta t$$

**关键推论 7.4a（规模增大时顿悟趋于平滑）**：随模型规模 $M$ 增大，$K(M)$ 增大（已覆盖的原语数增加），剩余原语的平均能力块大小 $\langle|\mathcal{C}(r)|\rangle$ 下降（核心高价值原语优先被覆盖）。因此：

$$M \uparrow \implies \max_r |\mathcal{C}(r)|_{\text{剩余}} \downarrow \implies \Delta_{\text{acc}}|_{\text{顿悟}} \downarrow$$

**即大模型的新能力涌现幅度趋于平滑、连续化**——这与实验观测（大模型的 Scaling 更平滑，小模型顿悟更剧烈）定量吻合。

---

## 8. 计算不可约性与能力的结构性下界

### 8.1 推理链的不可约性（需额外假设）

**额外假设（R-不可约性）**：称任务 $q \in Q_{\text{unseen}}$ 在 $R_{\text{tr}}$ 上**不可约**，若其最短 $R_{\text{tr}}$-链分解长度 $l^*(q)$ 满足：不存在更短的 $R_{\text{tr}}^*$ 中等价元素，即：

$$l^*(q) = \min\!\left\{l : \exists r_{i_1},\ldots,r_{i_l} \in R_{\text{tr}},\; r_{i_l}\circ\cdots\circ r_{i_1} = q \text{ on } \mathcal{X}\right\}$$

**命题 8.1（计算不可约性——能力深度下界）**：对 $R_{\text{tr}}$ 上不可约的任务 $q$，在精度要求 $\delta$ 下，任何 $F$-链的推理都必须至少使用 $l^*(q)$ 步，即：

$$\forall \text{ $f$-chain of length } l < l^*(q): \quad \sup_{x \in \mathcal{X}} \|\text{f-chain}(x) - q(x)\| \geq \delta_{\min}(q) > 0$$

**直觉**：若 $q$ 的 $R$-分解不能被压缩，则执行 $q$ 的 $F$-链也不能被压缩——这是推理深度的**绝对下界**，与模型规模无关。规模只能降低每步的 $\varepsilon$，不能绕过不可约性。

**推论 8.1a（CoT 步数的必要下界）**：对不可约任务 $q$，CoT 的分段数 $k$ 满足：

$$k \geq \left\lceil \frac{l^*(q)}{l_{\max}(\delta)} \right\rceil$$

即存在**不可规避的 CoT 步数下界**——某些任务无论提示如何设计，都需要至少若干步显式中间推理。

> [!NOTE]
> 判断具体任务是否 $R_{\text{tr}}$-不可约，当前无形式化方法（$R$ 不可枚举）。但此命题的预测性后果可实验验证：对特定任务，系统性地测试不同 CoT 步数，观察是否存在性能陡降的步数下界。

---

### 8.2 幂律 Scaling 的 CAC 机制推导（需额外假设）

**额外假设（能力块幂律分布）**：设 $R_{\text{tr}}$ 上，能力块大小 $|\mathcal{C}(r)|$ 服从幂律分布：

$$P(|\mathcal{C}(r)| \geq c) \propto c^{-(\alpha-1)}, \qquad \alpha > 2$$

此假设与自然语言中词频的 Zipf 定律（$\alpha \approx 2$）及知识依赖图的幂律性质一致，但尚属经验推断。

**命题 8.2（Scaling Law 指数的 CAC 推导）**：设规模 $M$ 的模型能可靠覆盖的原语数为：

$$K(M) \propto M^\beta \qquad (\beta > 0)$$

则模型的总能力集大小满足：

$$|Q(M)| = \sum_{k=1}^{K(M)} |\mathcal{C}(r_k)| \sim K(M)^{2-\alpha+1} \propto M^{\beta(3-\alpha)}$$

**证明思路**：对幂律分布，前 $K$ 个最大的能力块求和（等价于 $K$ 阶统计量之和）：

$$\sum_{k=1}^{K} |\mathcal{C}(r_k)| \sim K \cdot \mathbb{E}\!\left[|\mathcal{C}|^{1}\right] \propto K^{2-\alpha+1} = K^{3-\alpha}$$

其中使用了幂律截断矩的标准结果。$\square$

**含义**：Scaling Law 中"模型能力随规模增长"的幂律指数为 $\beta(3-\alpha)$，由两个可独立测量的量决定：
- $\beta$：规模-覆盖率指数（神经正切核理论等可给出估计）
- $\alpha$：任务依赖图的幂律指数（原则上可由任务依赖分析测量）

**这将 Scaling Law 的幂律从纯经验规律提升为结构性推导。**

---

## 9. 对齐的结构性脆弱性

### 9.1 多步对齐的指数衰减定理（严格推论，结合 §5）

将 CAC 的误差结构与行为吸引子理论（§5）结合，可以得到对齐问题的最强形式结论。

**命题 9.1（对齐稳定性的指数衰减）**：设对齐目标行为 $y^*(x) = q_{\text{align}}(x)$，其对应的 $R_{\text{tr}}$-链长度为 $l_{\text{align}}$，链路 Lipschitz 常数为 $L$。对齐训练将关键原语误差压至 $\varepsilon_{\text{align}}$，对齐失败的输出偏差阈值为 $\delta_{\text{fail}}$，则对齐行为对 Prompt 扰动的稳定半径满足：

$$\rho_{\text{align}} \leq \frac{\delta_{\text{fail}} - \varepsilon_{\text{align}} \cdot \frac{L^{l_{\text{align}}}-1}{L-1}}{\left\|J_{\text{output}}\right\|} \sim \frac{\delta_{\text{fail}}}{L^{l_{\text{align}}}}$$

其中 $J_{\text{output}}$ 为整条链的 Jacobian（见 §1.5.D），分母中的 $L^{l_{\text{align}}}$ 来自 Jacobian 逐层乘积。

**核心推论（对齐脆弱性随推理深度指数衰减）**：

$$\rho_{\text{align}} \propto L^{-l_{\text{align}}}$$

**这是最深刻的结构性结论**：对齐行为所需推理链越长，其对 Prompt 扰动的稳定半径越小，以 $L$ 的指数速率衰减。具体含义：

1. **简单对齐任务（$l_{\text{align}}$ 小）**：如"拒绝有害内容"这种单步判别，稳定半径较大，RLHF 对齐效果持久；

2. **复杂对齐行为（$l_{\text{align}}$ 大）**：如"多步推理中保持价值一致性"、"在长对话中维持角色对齐"，稳定半径以 $L^{-l_{\text{align}}}$ 衰减至极小——对齐会随推理深度退化，Adversarial Prompt 可以利用极小扰动撬动对齐失败；

3. **能力-对齐权衡的 CAC 根源**：若提升能力需要更深的链（更大的 $l_{\text{align}}$），则对齐稳定性必然衰减——这不是 RLHF 的工程缺陷，而是 CAC 误差结构的**不可绕过的数学约束**。

---

### 9.2 能力提升与对齐退化的不相容性（严格推论）

**命题 9.2（能力-对齐不相容性）**：设模型能力由 $l_{\max}(\delta)$ 刻画（命题 7.1），对齐稳定性由 $\rho_{\text{align}}$（命题 9.1）刻画，则在 $L$ 和 $\delta_{\text{fail}}$ 固定的前提下：

$$l_{\max} \uparrow \iff \varepsilon_{\max} \downarrow \iff \rho_{\text{align}} \uparrow / \text{unchanged}$$

$$l_{\text{align}} \uparrow \implies \rho_{\text{align}} \downarrow \text{（指数）}$$

两个箭头说明：
- **提升能力（降低 $\varepsilon_{\max}$ 或增大 $l_{\max}$）**：对对齐稳定性无必然负面影响（$\varepsilon_{\text{align}}$ 可同步下降）；
- **要求对齐行为跨越更长推理链（增大 $l_{\text{align}}$）**：稳定性指数衰减，**不可通过提升规模绕过**。

**结论**：对齐问题的关键不在于模型是否"足够大"，而在于对齐目标行为是否需要长推理链。将对齐约束嵌入短链（单步判别）比要求长链中的价值一致性，在 CAC 框架下有**量级上的稳定性优势**。

---

## 10. CAC 的认识论极限与可证伪性

### 10.1 框架的三个固有边界

**边界 1（$R$ 的不可枚举性）**：CAC 的所有推论均以"$q$ 在 $R_{\text{tr}}^*$ 中可分解"为前提。但 $R_{\text{tr}}$ 本身不可枚举（§1.1 注）——它由训练数据的推理结构隐式决定。因此，CAC 是**条件性框架**：它说明了"如果目标任务可被原语复合描述，则……"，但无法验证这个前提。

**边界 2（$L$ 的无条件控制缺失）**：命题 7.1 依赖 $L$，但 $L$ 没有无条件的架构上界。Layer Norm 和残差连接经验性地抑制 $L$，但对具体模型的具体任务，$L$ 可能大于 1，使误差界随 $l$ 指数增长，在实践中失去意义。

**边界 3（语义合法性的外在性）**：$Q_{\text{unseen}}$ 的组合爆炸（$|R_{\text{tr}}|^l$ 量级）中，绝大多数组合不对应有意义的推理任务。CAC 框架内没有区分"有意义组合"与"随机组合"的结构——意义判断依赖 $\mathcal{X}$ 的语义，而 $\mathcal{X}$ 在 §1.1 中刻意保持为抽象集合，不携带语义结构。

### 10.2 CAC 逆定理（开放猜想）

**猜想（CAC 逆定理）**：若模型在足够大规模和充分训练后仍对任务 $q$ 系统性失败，则 $q$ 不可被 $R_{\text{tr}}^*$ 的有限复合表示：

$$\lim_{M \to \infty} \lim_{t \to \infty} \text{Acc}(M, t, q) < 1 \implies q \notin R_{\text{tr}}^*$$

**意义**：若成立，CAC 体系变为**实验可证伪的**：系统性失败 = $R$-覆盖缺口的证据，而非承载能力不足。这将指导数据策略（增加覆盖 $R$ 的训练样本）而非规模策略（扩张 $M$）。

**目前状态：开放猜想**。逆定理的证明需要 $R_{\text{tr}}$ 的可操作化定义，以及"系统性失败"排除 $L > l_{\max}$ 导致的误差爆炸的条件隔离。

> [!IMPORTANT]
> **§7–10 的推论层次总结**：
>
> | 层次 | 命题 | 状态 | 核心内容 |
> |---|---|---|---|
> | 严格推论 | 7.1 | 已证 | 推理深度硬上界 $l_{\max}$ |
> | 严格推论 | 7.2 | 已证 | 误差权重指数非对称 $w_j = L^{l-j}$ |
> | 严格推论 | 7.3 | 已证 | CoT 完整误差界，含 $\varepsilon_{\text{tok}}$ 成本 |
> | 严格推论 | 7.4 | 已证 | 顿悟定量触发；大模型顿悟趋于平滑 |
> | 需假设 | 8.1 | 条件性 | 推理链不可约性 → CoT 步数下界 |
> | 需假设 | 8.2 | 条件性 | 幂律分布假设 → Scaling Law 指数推导 |
> | 严格推论 | 9.1 | 已证 | 对齐稳定性 $\propto L^{-l_{\text{align}}}$ |
> | 严格推论 | 9.2 | 已证 | 能力-对齐不相容性的结构根因 |
> | 开放猜想 | 10.2 | 待证 | CAC 逆定理 → 失败 = $R$-覆盖缺口 |
