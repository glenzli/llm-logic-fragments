# IDFC · Part 2：数学建模与定理证明

> **前置**：见 [Part 1 导论](part1-intro.md) 了解非正式动机与预测概览。
>
> **本文内容**：§1 形式定义（语义空间 $\mathcal{X}$、原语 $R$、函数集 $F$、$f$-chain）；§2 核心假说 CAC 的严格陈述；§3 定理完整证明（Telescope 展开 + UAT 桥接）。
>
> **后续**：[Part 3](part3-deductions.md) 从本文定理推导全部推论；[Part 4](part4-empirical.md) 用 Attention 泛函界验证理论预测。

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

> [!IMPORTANT]
> **§3 的证明状态总结**：
>
> | 命题 | 状态 | 依赖 |
> |---|---|---|
> | Telescope 展开（§3.2） | ✅ 严格 | 三角不等式 + $r_i$ 的 Lipschitz 性 |
> | UAT 存在性（§3.3 命题 3.1） | ✅ 严格（模 UAT） | Cybenko/Hornik UAT，$r_i$ 连续性 |
> | $\varepsilon_i^* \to 0$（推论 3.2） | ✅ 严格（模 UAT） | 命题 3.1 的直接推论 |
> | $L$ 的无条件上界 | ❌ 开放 | 见 §2 IMPORTANT 注释 |
> | $r_i$ 的连续性假设 | ⚠️ 语义假设 | 语义变换的拓扑性质，依赖 $\mathcal{X}$ 的结构 |

