## 基础

### 1.1 度量空间与算子空间

设 $(\mathcal{X}, d)$ 为**度量空间**。指定**吸收元** $\bot \in \mathcal{X}$，将偏函数全函数化：$\phi(x) = \bot$ 表示 $\phi$ 在 $x$ 处未定义。

定义**算子空间**：

$$\Omega = \{\, \phi : \mathcal{X} \to \mathcal{X} \;\big|\; \phi(\bot) = \bot \,\}$$

即 $\Omega$ 由所有**基点保持映射**（pointed maps）构成。$\phi \in \Omega$ 称为 $\mathcal{X}$ 上的一个**算子**（operator）。对 $\phi \in \Omega$，定义其**定义域**为 $\phi$ 产生非 $\bot$ 值的全部输入：

$$\mathrm{dom}(\phi) \;\triangleq\; \bigl\{\, x \in \mathcal{X} \;\big|\; \phi(x) \neq \bot \,\bigr\}$$

由 $\phi(\bot) = \bot$，复合链的定义域单调不增：$\mathrm{dom}(\phi_2 \circ \phi_1) = \{x \in \mathrm{dom}(\phi_1) \mid \phi_1(x) \in \mathrm{dom}(\phi_2)\} \subseteq \mathrm{dom}(\phi_1)$。

$\Omega$ 在函数复合下构成**幺半群**：$\phi_2 \circ \phi_1 \in \Omega$，$\mathrm{id}_{\mathcal{X}} \in \Omega$。

### 1.2 规范结构

**定义（规范结构，Gauge Structure）**：$(\mathcal{X}, d)$ 上的一个**规范结构** $\mathcal{G} = \{d_i\}_{i \in I}$ 是一族**伪度量**（pseudometric），满足：

1. 每个 $d_i: \mathcal{X} \times \mathcal{X} \to [0, \infty)$ 满足 $d_i(x, x) = 0$、$d_i(x, y) = d_i(y, x)$、$d_i(x, z) \leq d_i(x, y) + d_i(y, z)$，但允许 $d_i(x, y) = 0$ 而 $x \neq y$。
2. **度量相容性**：$\mathcal{G}$ 生成的拓扑不弱于 $d$ 生成的拓扑——即 $d$ 中的每个开球包含某个由有限个 $d_i$-球交集构成的开集。

称 $(\mathcal{X}, d, \mathcal{G})$ 为**规范度量空间**（gauged metric space）。每个 $d_i$ 称为 $\mathcal{G}$ 的一个**分量伪度量**。

**定义（族分离性，Family Separation）**：

- **分离规范**（separating gauge）：$\forall x, y \in \mathcal{X}$，$(\forall i \in I:\; d_i(x, y) = 0) \;\Rightarrow\; x = y$。
- **非分离规范**（non-separating gauge）：$\exists\, x \neq y$ 使得 $\forall i \in I:\; d_i(x, y) = 0$。此时 $\mathcal{G}$ 在 $\mathcal{X}$ 上诱导等价关系 $x \sim_\mathcal{G} y \;\Leftrightarrow\; \forall i:\; d_i(x, y) = 0$，$\mathcal{G}$ 在商空间 $\mathcal{X}/{\sim_\mathcal{G}}$ 上成为分离规范。

规范结构是 $(\mathcal{X}, d)$ 上的一种**可选结构**。不指定时，等价于退化规范 $\mathcal{G} = \{d\}$（$|I| = 1$，分离）。后续定义与命题均以 $d$ 为默认；凡涉及逐分量分析的场合，显式引入 $\mathcal{G}$。

### 1.3 算子空间的度量

对 $\mathcal{X}$ 上的伪度量 $d'$ 与子集 $S \subseteq \mathcal{X}$，定义 $\Omega$ 上的 **sup-范数距离**：

$$d_{\Omega, d'}(\phi, \psi)\big|_S \;\triangleq\; \sup_{x \in S} d'(\phi(x), \psi(x))$$

取 $S = \mathcal{X}$ 时简记 $d_{\Omega, d'}(\phi, \psi) \triangleq d_{\Omega, d'}(\phi, \psi)\big|_\mathcal{X}$。取 $d' = d$ 时简记 $d_\Omega \triangleq d_{\Omega, d}$。$(\Omega, d_\Omega)$ 构成度量空间；当 $d'$ 为伪度量时，$d_{\Omega, d'}$ 为 $\Omega$ 上的伪度量。

### 1.4 度量熵

**定义（度量熵，Metric Entropy）**：对给定精度 $\epsilon > 0$、$\mathcal{X}$ 上的伪度量 $d'$ 与子集 $A \subseteq \mathcal{X}$，定义 $A$ 在 $d'$ 下的**度量熵**为：

$$I_{\epsilon, d'}(A) \;\triangleq\; \log \mathcal{N}_{d'}\bigl(\epsilon,\, A\bigr)$$

其中 $\mathcal{N}_{d'}(\epsilon, A)$ 为在伪度量 $d'$ 下覆盖 $A$ 所需的最小 $\epsilon$-球数量。取 $d' = d$ 时简记 $I_\epsilon(A) \triangleq I_{\epsilon, d}(A)$。设 $\mathcal{G} = \{d_i\}_{i \in I}$ 为规范结构，则 $I_{\epsilon, d_i}(A)$ 为 $A$ 在分量 $d_i$ 下的 $\epsilon$-覆盖数对数。

### 1.5 算子广义 Lipschitz 常数

**定义（广义 Lipschitz 常数，Generalized Lipschitz Constant）**：对 $\phi \in \Omega$ 与 $\mathcal{X}$ 上的伪度量 $d'$，定义 $\phi$ 在 $d'$ 下的**广义 Lipschitz 常数**为：

$$L_{\phi, d'} \;\triangleq\; \sup_{\substack{x, y \in \mathrm{dom}(\phi) \\ d'(x,y) > 0}} \frac{d'(\phi(x),\, \phi(y))}{d'(x, y)} \;\in\; \bar{\mathbb{R}}_+ \;=\; [0, +\infty]$$

取 $d' = d$ 时简记 $L_\phi \triangleq L_{\phi, d}$。$L_\phi < \infty$ 时 $\phi$ 满足标准 Lipschitz 连续性。设 $\mathcal{G} = \{d_i\}_{i \in I}$ 为规范结构，则 $L_{\phi, d_i}$ 度量 $\phi$ 沿分量 $d_i$ 的拉伸率。

> **约定**：后续凡提及 $L$ 或 Lipschitz 常数，均指此广义定义（取值于 $\bar{\mathbb{R}}_+$），不隐含 $L < \infty$。需要有限性时显式标注。

### 1.6 算子链与复合度量

$\Omega$ 中有限个算子的复合 $c_\phi = \phi_k \circ \cdots \circ \phi_1$（$\phi_j \in \Omega$，$k \geq 1$）称为**算子链**（operator chain），$k$ 为其**长度**（$k = 0$ 对应幺元 $\mathrm{id}_{\mathcal{X}}$）。由 $\Omega$ 的幺半群封闭性，$c_\phi \in \Omega$，§1.5 的广义 Lip 常数 $L_{c_\phi, d'}$ 直接适用。

设 $c_\phi = \phi_{i_k} \circ \cdots \circ \phi_{i_1}$，记第 $j$ 步算子 $\phi_{i_j}$ 在伪度量 $d'$ 下的 Lipschitz 常数为 $L_{j, d'} \triangleq L_{\phi_{i_j}, d'} \in \bar{\mathbb{R}}_+$（取 $d' = d$ 时简记 $L_j \triangleq L_{j,d}$）。

**定义（尾部乘积，Tail Product）**：定义自第 $j$ 步至第 $l$ 步在伪度量 $d'$ 下的累积截断乘积为：
$$\theta_{j,l,d'} \;\triangleq\; \prod_{k=j}^{l} L_{k,d'} \;\in\; \bar{\mathbb{R}}_+ \qquad \text{（约定 } j > l \text{ 时，空积 } \theta_{j,l,d'} = 1\text{）}$$
取 $d' = d$ 时简记 $\theta_{j,l} \triangleq \theta_{j,l,d}$。当所有 $L_{k,d'} < \infty$ 时：
$$d'\bigl(c_\phi(x),\, c_\phi(y)\bigr) \leq \theta_{1,l,d'} \cdot d'(x, y)$$

----
*[IDFS] ⊢ [GLENZLI] ⊢ [Part 01] ⊢ [01-foundations] ⊢ [2ebbb96f3432846b]*
