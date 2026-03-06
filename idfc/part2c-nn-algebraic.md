# IDFC · Part 2c：神经网络代数化

> **前置**：[Part 2a](part2a-model-proof.md) 建立了抽象 IDFS/CAC 理论框架（$(F,\sigma)$ 定义与 CAC 定理）。
>
> **本文内容**：将 §1.2 的抽象 IDFS 实例化到**标准神经网络**（矩阵 + 激活函数结构），依次推导：函数集 $F$ 的矩阵代数结构（§1）、$F$ 的形式定义（§2）、激活路径与 DAG（§3）、$f$-chain 完整泛函定义（§4）、拟合关系（§5）、生成过程形式化（§6）、可操作化条件 OC（§7）、训练-推理对偶性 TSC/AdamW（§8）。
>
> **后续**：[Part 2c-alg](part2c-algebraic-instance.md) 进一步将代数层精化到 Transformer 具体结构；[Part 3](part3-deductions.md) 从 CAC 定理推导全部推论；[Part 4](part4-empirical.md) 实证验证。

---

## 第一部分：神经网络作为 IDFS 的代数实例

### §1 定理：神经网络等价于输入驱动的矩阵族（架构无关推导）

> **特化声明**：本节将 §1.2 的抽象框架实例化到标准神经网络。此处令 $\mathcal{X} = \mathbb{R}^d$，度量取 Euclidean 范数 $d(x, y) = \|x - y\|_2$——这是矩阵-向量乘法 $\Phi_l(h) \cdot h \in \mathbb{R}^d$ 的自然度量。§1.2 的全部论证在任意度量空间 $(\mathcal{X}, d)$ 上均成立；Euclidean 结构仅在本节（以及后续 §1.6 的算子分析）中使用。

本节从网络架构的基本事实出发，证明神经网络诱导的 $(F, \sigma)$ 满足 $F \subset \mathcal{M}_d(\mathbb{R})$。这是关于神经网络实例的**定理**，不是 §1.2 抽象定义的前提。

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

**定理 1.3（$F$ 的矩阵代数结构）**：对任意激活路径 $\pi = (\Phi_1^\pi, \ldots, \Phi_k^\pi)$（各层在该路径下的算子场取值；激活路径的精确集合论定义见 §1.5），路径所对应的有效变换为：

$$f_\pi(x) = \Phi_k^\pi(h_{k-1}) \cdots \Phi_1^\pi(h_0) \cdot x$$

当激活路径固定后，每层 $\Phi_l^\pi(h_{l-1})$ 退化为一个**确定的 $d \times d$ 实矩阵**（MLP 中由掩码决定的常矩阵；Transformer 中由注意力权重决定的矩阵）。因此，固定激活路径下，$f_\pi$ 是线性映射 $\mathbb{R}^d \to \mathbb{R}^d$，即

$$f_\pi \in \mathcal{M}_d(\mathbb{R}) = \mathrm{End}(\mathbb{R}^d)$$

由于 $F$ 的每个元素 $f_i$ 对应某条固定激活路径，故：

$$\boxed{F \subset \mathcal{M}_d(\mathbb{R})}$$

**$F$ 的规模**：不同激活路径序列的数量随深度和宽度指数级增长，这就是模型规模 $M$ 对应的数学实体。

**推论（输入驱动组装）**：给定输入 $x$，模型不执行固定函数，而是由 $x$ 递归选择激活路径，**在线组装**出对应的 $f$-链路。

**推论 1.3a（神经网络满足 Part 2a §1.2 的 IDFS 两个定义条件，并具有特有代数结构）**：设 $\mathcal{X} = \mathbb{R}^d$，网络参数固定为 $\theta$。对第 $l$ 层，令：

$$\sigma_l : \mathbb{R}^d \to F_l, \qquad h \mapsto \Phi_l(h)$$

则 $(F, \sigma_l)$ 满足 Part 2a §1.2 IDFS 定义的两个结构条件，并额外具有神经网络特有的矩阵代数性质。

**IDFS 条件 1（选择映射存在，对应 Part 2a §1.2 定义第 2 条）**：$\sigma_l$ 由 Nemytskii 算子场 $\Phi_l$ 直接给出，对每个 $h \in \mathbb{R}^d$ 有定义。单步递推为：

$$h_{l+1} = \sigma_l(h_l)(h_l) = \Phi_l(h_l) \cdot h_l = G_l(h_l)$$

与 §1.2 的 $x_{l+1} = \sigma(x_l)(x_l)$ 字面对应，$\sigma_l$ 即为该层的选择映射。$\square$

**IDFS 条件 2（Lipschitz 一致性，对应 Part 2a §1.2 定义第 1 条）**：需证 $h \mapsto G_l(h) = \sigma_l(h)(h)$ 是 $L_l$-Lipschitz。分两种架构：

*情形 A（MLP-ReLU）*：在每个分段线性区域 $\mathcal{X}_j$ 内，$\sigma_l(h) = M_j$（常矩阵，由掩码固定）。对任意 $h, h' \in \mathcal{X}_j$：

$$\|G_l(h) - G_l(h')\| = \|M_j(h - h')\| \leq \|M_j\|_{\mathrm{op}} \cdot \|h - h'\|$$

故在每个区域内 $G_l$ 是 $\|M_j\|_{\mathrm{op}}$-Lipschitz（最大奇异值 $= \sigma_{\max}(M_j)$）。跨区域时 $G_l$ 在边界连续（激活切换为测度零事件），整体 Lipschitz 常数为 $\|G_l\|_{\mathrm{Lip}} \leq \max_j \sigma_{\max}(M_j)$。

*情形 B（Transformer，softmax 路由）*：$\sigma_l(h) = \Phi_l(h)$ 连续依赖 $h$，$G_l$ 可微。Jacobian 分解（§1.6D）给出：

$$\|J_{G_l}(h)\| \leq \underbrace{\|\Phi_l(h)\|_{\mathrm{op}}}_{\text{冻结项}} + \underbrace{\|(\nabla_h \Phi_l(h))[h]\|_{\mathrm{op}}}_{\text{选择器响应项}} \leq B_l + L_{\Phi_l} \cdot \|h\|$$

其中 $B_l = \sup_h \|\Phi_l(h)\|_{\mathrm{op}}$，$L_{\Phi_l}$ 为 $\Phi_l$ 的 Lipschitz 常数（由 softmax 光滑性有界）。在有界域 $\|h\| \leq R$ 上，$G_l$ 是 $(B_l + L_{\Phi_l} R)$-Lipschitz。

两种情形下 $F \subset \mathrm{Lip}_{L}(\mathcal{X})$ 均成立，$L = \max_l \|G_l\|_{\mathrm{Lip}}$（在 AdamW 训练下由 §3.4 命题 3.4 给出显式上界）。$\square$

**神经网络特有代数性质（$F \subset \mathcal{M}_d(\mathbb{R})$）**：此性质超出 Part 2a §1.2 的 IDFS 定义要求——它是矩阵 + 激活函数结构的具体推论，由定理 1.3 直接给出。一般 IDFS 不要求 $F$ 有此矩阵结构。$\square$

> **综合**：神经网络（矩阵 + 激活函数结构）诱导的 $(F, \sigma_l)$ 是 Part 2a §1.2 所定义的输入驱动函数系统的一个**具体实例**，所有三个条件均严格满足。CAC 定理（§2–§3）的全部论证在 §1.2 的一般 $(F, \sigma)$ 层面成立，神经网络的矩阵结构不是逻辑前提。

> **架构实例**：$\Phi_l(h)$ 的具体形式与正则性（MLP 的分段常数掩码、Transformer 的 softmax 光滑路由等）及其在 IDFC 框架中的角色分析，见 [Part 4 §1](part4-empirical.md)。

> **逻辑地位**：定理 1.3 将"$F$ 具有矩阵代数结构"从前提变为推论——它是从激活函数原理出发的推导结果，而非 $F$ 定义的一部分。§1.4 在此基础上给出 $F$ 的完整形式定义，§1.6B 严格建立其幺半群代数结构。

### §2 模型映射函数集（形式定义）

基于 §1.3 的推导，正式给出 $F$ 的完整定义：

设模型规模为 $M$（分段线性区域数的对数量级），**学出的函数集**为 $F = \{f_1, f_2, \ldots, f_M\}$，其中每个 $f_i$ 是某个激活掩码序列对应的有效映射，且由定理 1.3 知 $F \subset \mathcal{M}_d(\mathbb{R})$。

**关键性质**：
- $F \subset \mathcal{M}_d(\mathbb{R})$：每个 $f_i$ 在其激活路径固定后是一个 $d \times d$ 实矩阵（定理 1.3）
- $F$ 中的元素可以冗余：$f_i$ 和 $f_j$ 可对应近似同一计算，但精度不同
- $F$ 不要求正交、独立或可解释——它们是权重空间被激活函数切割后的产物
- $M$ 越大（网络越深越宽），$F$ 越丰富，每个 $r$ 的近似精度上限越高

> **约定（$F$ 空间的语义中立性——语义防火墙）**
>
> **$E_{r_i}$ 的精确含义**：对固定参数 $\theta$ 的网络，每个输入 $x$ 的前向传播产生各层矩阵的有序乘积，即**有效算子**（见 §1.6B）：
>
> $$E(x) \;=\; \Phi_k(h_{k-1};\theta)\cdots\Phi_1(h_0;\theta) \;\in\; \langle F \rangle_\cdot$$
>
> 若分析者观察到对某个 $r_i$，该有效算子满足 $\|E(x)\cdot x - r_i(x)\| \leq \varepsilon_i$，则将此输入上的有效算子标记为 $E_{r_i}(x) \triangleq E(x)$。因此 $E_{r_i}$ 是一个**矩阵值函数**（matrix-valued function）：
>
> $$E_{r_i}: \mathcal{X} \to \langle F \rangle_\cdot, \quad x \mapsto E_{r_i}(x)$$
>
> 对不同的 $x$，$E_{r_i}(x)$ 一般是不同的 $d\times d$ 矩阵——$\{E_{r_i}(x) : x \in \mathcal{X}\}$ 是以 $x$ 为索引的**矩阵族**，不要求收敛到 $\mathbb{R}^d$ 中某个固定向量或方向。拟合条件 $\|E_{r_i}(x)\cdot x - r_i(x)\| \leq \varepsilon_i$（§1.7 逐点拟合）对族中每个矩阵分别独立成立。
>
> **命名约定**：下标 $r_i$ 是分析者事后贴上的标签（观察到数值近似成立后命名），**不蕴含** $F$ 空间中存在与 $r_i$ 语义对应的可辨识专用结构，也不蕴含该矩阵族存在固定的几何方向或可辨识的神经回路。"激活路径改变"严格指分布 $\Pr[\mathrm{Path}(x,k)=\pi]$ 随 $\theta$ 或 $x$ 的改变；将激活模式称作"路由"同样是分析者的命名约定，而非 $F$ 空间的内在属性。

### §3 分叉、路径合并与抽象层的形成

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


### §4 函数链路：完整泛函定义

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

> **信息损失**：从词序列到有效算子时，"哪条路径"的信息丢失（不同词可出同一积）；从有效算子到轨道终点时，中间状态 $h_1,\ldots,h_{k-1}$ 丢失。这正是 §1.5 定义的"强合并"现象的代数精确表述。

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

累积 Lipschitz 常数 $\prod_{l=1}^k \|G_l\|_{\mathrm{Lip}}$ 是 Part 2a §3.2 Telescope 展开中误差指数传播的数学根因。

**不动点**：若 $(G_k \circ \cdots \circ G_1)(x^*) = x^*$，即 $E(x^*)\,x^* = x^*$，则 $x^*$ 是整个 f-chain 的不动点。若 $\|E(x)\| < 1$（压缩），Banach 定理保证唯一全局吸引不动点——行为吸引子理论"稳定盆地"的代数表述（见 `behavioral-attractors/theory-math.md`）。







### §5 拟合关系

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

**本文所采用的拟合定义**：除非特别说明，"$F$ 拟合 $R$"指逐点拟合，即对每个 $r_i \in R$，**同时满足以下两个条件**：

$$\text{（数值逼近）}\quad \exists\; E_{r_i}: \mathcal{X} \to \langle F \rangle_\cdot \quad \text{s.t.} \quad \|E_{r_i}(x)\cdot x - r_i(x)\| \leq \varepsilon_i \quad \forall x \in \mathcal{X}$$

$$\text{（Lipschitz 一致性）}\quad x \mapsto E_{r_i}(x)\cdot x \text{ 是 } L\text{-Lipschitz 函数，其中 } L = \max_j \|G_j\|_{\mathrm{Lip}}$$

其中 $\varepsilon_i > 0$ 为允许的单步近似误差，$\|\cdot\|$ 为 $\mathbb{R}^d$ 上的标准 Euclidean 范数，$L$ 为§1.6.D 命题 1.1 定义的全局逐层 Lipschitz 上界。

> **为何需要 Lipschitz 一致性**：Part 2a §3.2 Telescope 展开的项（B）依赖 $r_{i_j}$ 是 $L$-Lipschitz（分析者视角）并由 $E_{r_i}$ 的 Lipschitz 常数代理（命题 3.4 步骤 3）。若某个 $E_c$ 的 Lipschitz 常数 $L_c \gg L$，则将其插入 f-chain 后误差传播速率变为 $L_c$ 而非 $L$，CAC 误差界中的 $L^l$ 项膨胀为 $L_c^l$，$l_{\max}$ 的 TSC 约束完全失效。**Lipschitz 一致性是 CAC 定理在 f-chain 复合下成立的必要条件，不是推论。**




---

### §6 生成过程的形式化：离散化与自回归展开

§1.6 定义了 $f$-chain 作为**连续状态空间 $\mathbb{R}^d$ 上的动力系统**，其输出 $\text{output}(x) = E(x) \cdot x \in \mathbb{R}^d$ 是连续向量。实际语言模型输出的是离散 token——本节形式化这一"连续→离散"的转换，并由此导出自回归展开的完整数学定义。

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
> §1.8 定义的形式框架供 Part 3 §4.4、§5.3 的 CoT 分析引用（$\varepsilon_{\text{tok}}$ 的正式来源），并为 Part 4 §8 的 Diffusion 范式对比提供基准。Diffusion 的区别在于：整条去噪轨迹取消了逐步离散化，$\varepsilon_{\text{tok}}$ 仅在最终步骤一次性产生（见 Part 4 §8）。

---

### §7 可操作化条件（Operationalizability Condition，OC）

> **本节的逻辑地位**：§1—§1.8 建立的全部数学结构（$f$-chain、$E_{r_i}(x)$、$\varepsilon_i$、激活路径等）在**数学层面无条件成立**——它们是对任意神经网络的代数描述，不依赖任何语义主张。本节定义一个额外条件，区分"数学推论"与"需要经验桥接的实践建议"。

**定义（可操作化条件，OC）**：称任务 $q$ 对模型 $F$ **满足可操作化条件**，若满足以下两条：

1. **r-链路可分解性**：存在 $R_{\text{tr}}$-链路 $r_{i_l} \circ \cdots \circ r_{i_1}$ 使得 $q \approx r_{i_l} \circ \cdots \circ r_{i_1}$（在 $\varepsilon_{\\max}$ 精度内）；
2. **步骤可区分性**：对每步 $r_{i_j}$，存在可经验验证的方式（如激活分析、因果干预、MI 实验），确认模型在对应输入阶段的有效算子 $E(x)$ 满足 $\|E(x)\cdot x - r_{i_j}(x)\| \leq \varepsilon_{i_j}$。

> **OC 与 $\varepsilon_{\max}$ 的关系**：若 OC 成立，§2 定义的 $\varepsilon_i$ 就不仅是抽象定义量，而是可与具体模型行为对应的可测量量。OC **不影响**任何数学定理的逻辑有效性；它只决定定理的实践建议能否被操作化为具体的工程指导。

**标注约定（贯穿全文）**：
- ✅ **纯数学推论**：对任意满足 CAC 前提的 $F$ 无条件成立，与 OC 无关。
- ⚠️ (OC) **需要 OC**：数学结论为真，但将其转化为具体模型的工程建议时，需要能识别该模型上的 r-chain 分解。Part 4 的实证分析提供 OC 的经验证据。

> **与 Mechanistic Interpretability 的关系**：MI 研究发现的叠加（superposition）和多义性（polysemanticity）现象表明，一般 Transformer 中 OC 不是自动成立的——同一组神经元可执行多个不同"原语"。在叠加显著的层/头，OC 条件 2 可能很难满足。这是实证约束，不是框架的数学缺陷；Part 4 讨论了在不同程度叠加下框架预测力的变化。

---

---

## 第二部分：训练-推理对偶性

### §8 训练-推理对偶性：有效链长上界（TSC/AdamW）

本节给出 CAC 误差界的完整严格形式，并说明 $L_{\max}$ 的约束来源。论证分三层：先建立抽象接口（TSC），再在接口条件下推导定理，最后证明 AdamW 训练满足该接口。

#### 定义（训练稳定性契约，TSC）

称一种训练方法满足**训练稳定性契约（Training Stability Contract，TSC）**，若其产生的模型参数使得逐层 Lipschitz 常数的**全局最大值**：

$$L_{\max} \;\triangleq\; \max_{1 \leq l \leq k} \|G_l\|_{\mathrm{Lip}}$$

满足存在有界常数 $C > 1$，使得：

$$1 \;<\; L_{\max} \;\leq\; C$$

同时，以 $\|G_j\|_{\mathrm{Lip}}$ 代理 $r_j$ 的 Lipschitz 常数时，对任意尺度 $R = \|h-h'\| > 0$，局部 Lipschitz 比满足：$\frac{\|r_j(h)-r_j(h')\|}{R} \leq \|G_j\|_{\mathrm{Lip}} + \frac{2\varepsilon_j}{R}$（见命题 3.4 步骤 3）。在 CAC 链路中取 $R = e_{j-1}$（当步累积误差），代理在 $e_{j-1} \gg \varepsilon_j$ 时自动收紧，无需全局最小间距 $s > 0$。

> **为何用 $L_{\max}$ 而非几何均值 $\bar{L}$**：CAC 望远镜展开（§3.2）中，项（B）的 Lipschitz 传播使用每步最坏情形——各步 Lipschitz 乘积的上界依赖 $\max_j \|G_j\|_{\mathrm{Lip}} = L_{\max}$，而非几何均值。用几何均值代入封闭公式在各层 Lipschitz 差异较大时可给出低于真实误差的假紧界，构成逻辑跳跃。$L_{\max}$ 是在 Telescope 公式中合法使用的最小上界量。

> TSC 是对训练结果的**可观测约束**，不依赖具体的优化算法。任何产生满足上述不等式的模型参数的训练方法——无论是梯度下降、进化策略还是其他机制——均满足 TSC。

---

#### 定理 3.3（训练-推理对偶性）

**设训练方法满足 TSC，常数为 $C$。** 令 $L \triangleq L_{\max}$，则由 TSC 知 $1 < L \leq C$。

直接代入 §3.2 的 CAC 误差界——$L_{\max}$ 即为望远镜展开中项（B）的 Lipschitz 传播常数，无需任何代换，TSC 代理条件保证 $\|G_j\|_{\mathrm{Lip}}$ 代理 $r_j$ 的 Lipschitz 合法（见命题 3.4 步骤 3）——得**严格完整形式**：

$$\boxed{e_l \;\leq\; \varepsilon_{\max} \cdot \frac{L^l - 1}{L - 1}, \qquad 1 < L \leq C}$$

**推论 3.3a（有效链长上界）**：定义**临界链长** $l^*$ 为误差界首次超过 $1/\varepsilon_{\max}$ 倍的链长，即解 $\varepsilon_{\max}(L^{l^*}-1)/(L-1) \leq 1$：

$$l^* \;\triangleq\; \left\lfloor\frac{\ln\!\left(1 + \dfrac{L-1}{\varepsilon_{\max}}\right)}{\ln L}\right\rfloor \;\approx\; \frac{\ln(1/\varepsilon_{\max})}{\ln L}$$

当 $l > l^*$ 时，CAC 误差界超出 $\varepsilon_{\max}$ 的可控范围，推理链路的累积误差无法被单步精度吸收。

> $l^*$ 由两个量决定：单步误差 $\varepsilon_{\max}$（越小 $l^*$ 越大）和训练常数 $C$（$L \leq C$；$C$ 越小即各层 Lipschitz 越受约束，$l^*$ 越大）。不同的训练方法通过影响 $C$ 来影响最大可靠推理深度。

**推论 3.3b（TSC 推理深度不可能性——测度论下界）**：设训练方法满足 TSC，从而 $L_{\max} > 1$。设 $\mathcal{X} = \mathbb{R}^d$，目标 $r$-链从自然语言任务中随机选取（服从任意绝对连续分布，不对齐到网络某个固定子空间）。则对几乎所有（Lebesgue 测度意义下）的目标链：

$$\Pr\!\left[e_l \xrightarrow{l \to \infty} +\infty\right] = 1$$

**证明**：

**步骤 1（奇异值分析）**：对每层 $G_j$，最大奇异值 $\sigma_{\max,j} = \|G_j\|_{\mathrm{Lip}}$。由 TSC 最大值下界 $L_{\max} > 1$，至少存在某层 $j_0$ 满足 $\sigma_{\max,j_0} > 1$（否则所有层 Lipschitz $\leq 1$，最大值 $\leq 1$，矛盾）。

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
> | **测度论** | **几乎所有任务 $e_l \to \infty$（概率 1）** | **推论 3.3b** | **TSC（$L_{\max} > 1$）** |
> | 普遍性 | 所有输入 $e_l \to \infty$ | — | ❌ 不可证（零测集任务可规避）|
>
> TSC 通过测度论将不可能性从"最坏情形存在"升级为"几乎所有真实任务均受限"。能让误差有界的任务集合是零测集，实践中无法系统性构造。




---

#### 命题 3.4（AdamW 训练满足 TSC）

现代 LLM 训练的标准配置——**AdamW 优化器 + 权重衰减系数 $\lambda > 0$**（典型值 $\lambda = 0.1$）——满足 TSC，且 TSC 常数 $C$ 由权重衰减系数和网络结构直接决定，与参数空间损失曲率无关。

> **为何 AdamW 而非 Adam+L2**：原版 Adam 对 L2 正则项也会应用二阶矩缩放，使实际衰减效果不均匀。AdamW 将权重衰减从梯度更新中分离（$W_{t+1} = (1-\eta\lambda)W_t - \eta \hat{m}_t/(\sqrt{\hat{v}_t}+\varepsilon_{\text{adam}})$），使每层权重范数的稳态上界严格可控。GPT-3、LLaMA、PaLM 等主流 LLM 均采用 AdamW + $\lambda=0.1$。

**证明**（三步）：

**步骤 1（$\bar{L} > 1$，数据下界，与之前相同）**：设训练集 $\mathcal{D}$ 中存在样本对 $(x_i, y_i), (x_j, y_j)$ 满足 $C_\mathcal{D} = \frac{\|y_i - y_j\|}{\|x_i - x_j\|} > 1$。对训练误差 $< \delta$ 的模型，三角不等式给出：

$$\|F_\theta(x_i) - F_\theta(x_j)\| \;\geq\; C_\mathcal{D}\|x_i - x_j\| - 2\delta \;\implies\; L_{\text{local}} \;\geq\; C_\mathcal{D} - \frac{2\delta}{\|x_i - x_j\|} \;>\; 1$$

自然语言训练集必然包含 $C_\mathcal{D} > 1$ 的样本对（同义句对应不同事实等），故此为数据的固有性质。由此得 $\bar{L} \geq L_{\text{local}} > 1$。

**步骤 2（$\bar{L} \leq C^{1/k}$，AdamW 权重衰减上界）**：

AdamW 的每层更新为：

$$W_l^{(t+1)} = (1 - \eta\lambda)\,W_l^{(t)} \;-\; \eta\,u_l^{(t)}$$

其中 $u_l^{(t)} = \hat{m}_l^{(t)}/(\sqrt{\hat{v}_l^{(t)}} + \varepsilon_{\text{adam}})$ 是 Adam 的归一化更新量。关键性质：Adam 的归一化设计保证每个分量的更新幅度有界：

$$\left|(u_l^{(t)})\right|_{ij} \leq 1 \quad \forall\, i,j,t$$

（因为 $|\hat{m}_{ij}| \leq \sqrt{\hat{v}_{ij}}$ 由矩估计的 AM-GM 不等式成立，分子分母均为同一坐标的一、二阶矩。）

设权重矩阵维度为 $d_{\text{in}} \times d_{\text{out}}$，上确界更新幅度为：

$$\|u_l^{(t)}\|_F \;\leq\; \sqrt{d_{\text{in}} \cdot d_{\text{out}}} \;\triangleq\; D_l$$

由系数 $(1-\eta\lambda) < 1$，权重范数在稳态满足收缩-驱动的不动点方程：

$$\|W_l^{(\infty)}\|_F \;\leq\; \frac{\eta D_l}{\eta\lambda} \;=\; \frac{D_l}{\lambda}$$

**证明（稳态界）**：对任意 $t$，递推 $\|W^{(t+1)}\|_F \leq (1-\eta\lambda)\|W^{(t)}\|_F + \eta D_l$。若 $\|W^{(t)}\|_F > D_l/\lambda$，则 $(1-\eta\lambda)\|W^{(t)}\|_F + \eta D_l < \|W^{(t)}\|_F$，权重范数严格递减。因此稳态值被 $D_l/\lambda$ 吸引，以指数速率 $(1-\eta\lambda)^t$ 收紧。$\square$

由 Frobenius-谱范数不等式 $\sigma_{\max}(W_l) \leq \|W_l\|_F$，得稳态谱范数上界：

$$\sigma_{\max}(W_l^{(\infty)}) \;\leq\; \frac{D_l}{\lambda} \;=\; \frac{\sqrt{d_{\text{in}} \cdot d_{\text{out}}}}{\lambda}$$

对 Transformer 层而言，每层 Lipschitz 常数由注意力子层和 FFN 子层的权重谱范数乘积控制（含残差结构，§1.6.D 命题 1.1）：

$$\|G_l\|_{\mathrm{Lip}} \;\leq\; 1 \;+\; \underbrace{\sigma_{\max}(W_O)\,\sigma_{\max}(W_V)}_{\text{注意力子层}} \;+\; \underbrace{\sigma_{\max}(W_2)\,\sigma_{\max}(W_1)}_{\text{FFN 子层}}$$

代入稳态谱范数上界，令 $B_l(\lambda) \triangleq 1 + 2D_l^2/\lambda^2$ 为第 $l$ 层 Lipschitz 常数的上界（$D_l = \sqrt{d_{\text{in}}^{(l)} \cdot d_{\text{out}}^{(l)}}$），则每层：

$$\|G_l\|_{\mathrm{Lip}} \;\leq\; B_l(\lambda) \quad \forall\, l = 1,\ldots,k$$

由此，TSC 所需的**全局最大值**直接由逐层上界取最大得到：

$$L_{\max} \;=\; \max_{l}\, \|G_l\|_{\mathrm{Lip}} \;\leq\; \max_{l}\, B_l(\lambda) \;\triangleq\; B_{\max}(\lambda)$$

其中：

$$\boxed{B_{\max}(\lambda) \;=\; 1 + \frac{2\,D_{\max}^2}{\lambda^2}, \qquad D_{\max} \;\triangleq\; \max_{l}\,\sqrt{d_{\text{in}}^{(l)} \cdot d_{\text{out}}^{(l)}}}$$

（$D_{\max}$ 是各层中输入输出维度乘积最大的层的几何平均维度，仅由网络结构决定。注意力子层和 FFN 子层各贡献一个 $D_l^2/\lambda^2$ 项；取最大层给出 $B_{\max}$。精确系数可由各层 $W_O, W_V, W_1, W_2$ 维度分别计算。）

TSC 常数 $C \triangleq B_{\max}(\lambda)$，满足 $L_{\max} \leq C$。$C$ **可由网络结构和权重衰减系数直接计算**，不依赖损失曲率假设。权重衰减系数 $\lambda$ 越大，$C$ 越小，$l^*$ 越大（可靠推理链允许更长）。$\square$

**步骤 3（代理合法性——尺度局部，与之前相同）**：对任意 $h, h'$ 满足 $R = \|h-h'\| > 0$，由三角不等式：

$$\|r_j(h) - r_j(h')\| \;\leq\; \|\hat{f}_j(h) - \hat{f}_j(h')\| + 2\varepsilon_j \;\leq\; \|G_j\|_{\mathrm{Lip}} \cdot R + 2\varepsilon_j$$

除以 $R$：$\frac{\|r_j(h)-r_j(h')\|}{R} \leq \|G_j\|_{\mathrm{Lip}} + \frac{2\varepsilon_j}{R}$。在 CAC Telescope 展开中取 $R = e_{j-1}$（当步累积误差）：误差 $= 2\varepsilon_j/e_{j-1} \to 0$ 当 $e_{j-1} \gg \varepsilon_j$（UAT 保证 $\varepsilon_j \to 0$）。无需全局最小间距 $s > 0$，代理在 CAC 分析的关键尺度（大误差阶段）自动收紧。$\square$

> **TSC 的普适性**：定理 3.3 仅依赖 TSC，不依赖命题 3.4 的具体推导。若未来出现不基于 AdamW 的训练方法，只要其产生的模型参数满足 $1 < \bar{L} \leq C^{1/k}$（可由权重谱范数验算），定理 3.3 和推论 3.3a 自动成立，$l^*$ 的公式保持不变。特别地，**$C(\lambda)$ 现在是可从训练后的权重直接计算的量**，使 $l^*$ 从理论预测变为可实测的模型属性。

> [!IMPORTANT]
> **§3 的证明状态总结**：
>
> | 命题 | 状态 | 依赖 |
> |---|---|---|
> | Telescope 展开（§3.2） | ✅ 严格 | 三角不等式 + $r_i$ 的 Lipschitz 性 |
> | UAT 存在性（§3.3 命题 3.1） | ✅ 严格（模 UAT） | Cybenko/Hornik UAT，$r_i$ 连续性 |
> | $\varepsilon_i^* \to 0$（推论 3.2） | ✅ 严格（模 UAT） | 命题 3.1 的直接推论 |
> | 定理 3.3（TSC → $l^*$） | ✅ 严格（模 TSC） | TSC 定义；代理条件 $\varepsilon_j \ll e_{j-1}$ |
> | 命题 3.4 步骤 1（$L_{\max}>1$） | ✅ 严格 | 训练集固有数据多样性 $C_\mathcal{D}>1$ |
> | 命题 3.4 步骤 2（$L_{\max} \leq C$） | ✅ 严格 | AdamW 稳态权重范数界 → 逐层谱范数 → 取最大 |
> | 命题 3.4 步骤 3（代理合法性） | ✅ 严格（模 UAT） | UAT 保证 $\varepsilon_j \to 0$，尺度局部自动收紧 |
> | $r_i$ 的连续性假设 | ⚠️ 语义假设 | 语义变换的拓扑性质，依赖 $\mathcal{X}$ 的结构 |



