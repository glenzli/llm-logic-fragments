## 分量分析

### 2.1 算子的分量分划

**定义（分量分划，Component Decomposition）**：设 $\phi \in \Omega$，$\mathcal{G} = \{d_i\}_{i \in I}$ 为 $(\mathcal{X}, d)$ 上的规范结构。定义：

- **恒等分量** $I_{\mathrm{id}}(\phi) = \{i \in I : \forall x \in \mathrm{dom}(\phi),\; d_i(\phi(x), x) = 0\}$。
- **常值分量** $I_{\mathrm{const}}(\phi) = \{i \in I \setminus I_{\mathrm{id}}(\phi) : \forall x, y \in \mathrm{dom}(\phi),\; d_i(\phi(x), \phi(y)) = 0\}$。
- **活跃分量** $I_{\mathrm{act}}(\phi) = I \setminus (I_{\mathrm{id}}(\phi) \cup I_{\mathrm{const}}(\phi))$。

三者互斥且穷尽：$I = I_{\mathrm{id}} \sqcup I_{\mathrm{const}} \sqcup I_{\mathrm{act}}$。若 $i$ 同时满足恒等与常值条件（$\mathrm{dom}(\phi)$ 中所有点在 $d_i$ 下不可区分且 $\phi$ 在 $d_i$ 上为恒等），优先归入 $I_{\mathrm{id}}$。$\mathcal{G} = \{d\}$ 时，分划退化为 $I_{\mathrm{act}} = \{d\}$（除非 $\phi = \mathrm{id}$ 或 $\phi$ 为常值映射）。

分量分划对应算子 $\phi$ 在每个分量伪度量上的三种行为模式：
- $i \in I_{\mathrm{id}}$：$\phi$ 在分量 $d_i$ 上**透明**——$d_i(\phi(x), x) = 0$ 对所有 $x$，输入的 $d_i$-结构被原封保持。
- $i \in I_{\mathrm{const}}$：$\phi$ 在分量 $d_i$ 上**遮蔽**——$d_i(\phi(x), \phi(y)) = 0$ 对所有 $x, y$，所有输出在 $d_i$ 下不可区分，$d_i$-信息被完全擦除。
- $i \in I_{\mathrm{act}}$：$\phi$ 在分量 $d_i$ 上**活跃**——$\phi$ 在 $d_i$ 下既非恒等亦非常值，输入的 $d_i$-差异被非平凡变换。

> **注（分量分划的 Lip 特征化）**：恒等分量的条件是 $d_i(\phi(x), x) = 0$ 对所有 $x$——这是对**位移**的约束，而非对 Lip 常数的约束。常值分量等价于 $L_{\phi, d_i} = 0$。活跃分量满足 $L_{\phi, d_i} > 0$ 且 $\phi$ 在 $d_i$ 下非恒等。

### 2.2 跨分量 Lipschitz 矩阵

单一伪度量下的 Lipschitz 常数 $L_{\phi, d_i}$ 刻画了 $d_i$-输入扰动对 $d_i$-输出差异的放大率。在规范结构下，一个分量上的输入扰动可能影响另一个分量上的输出差异。

**定义（跨分量 Lipschitz 常数，Cross-Component Lipschitz Constant）**：对 $\phi \in \Omega$ 和 $\mathcal{G}$ 中的两个分量伪度量 $d_i, d_j$，定义 $\phi$ 的 **$(d_i \to d_j)$-Lipschitz 常数**：

$$L_{\phi, d_i \to d_j} \;\triangleq\; \sup_{\substack{x, y \in \mathrm{dom}(\phi) \\ d_i(x,y) > 0}} \frac{d_j(\phi(x),\, \phi(y))}{d_i(x, y)} \;\in\; \bar{\mathbb{R}}_+$$

$L_{\phi, d_i \to d_j}$ 度量输入在分量 $d_i$ 上的扰动对输出在分量 $d_j$ 上的最大放大率。对角元 $L_{\phi, d_i \to d_i} = L_{\phi, d_i}$ 退化为 §1.5 的标准定义。

**定义（Lipschitz 矩阵，Lipschitz Matrix）**：当 $|I| < \infty$ 时，$\phi$ 的所有跨分量 Lip 常数构成一个 $|I| \times |I|$ 矩阵：

$$\mathbf{L}_\phi \;\triangleq\; \bigl(L_{\phi, d_i \to d_j}\bigr)_{i, j \in I}$$

#### 分量正交性

**定义（分量正交，Component Orthogonality）**：称 $\phi$ 在分量对 $(d_i, d_j)$ 上**正交**，若 $L_{\phi, d_i \to d_j} = 0$——输入在 $d_i$ 上的任意扰动不影响输出在 $d_j$ 上的差异。

当 $\mathbf{L}_\phi$ 为对角矩阵时，$\phi$ 的所有分量**彼此正交**——各分量独立演化，无跨分量耦合。这是**分量完全解耦**的算子结构。非对角元 $L_{\phi, d_i \to d_j} > 0$ 表示分量间存在**耦合**。

#### Lip 矩阵的复合律

**命题 2.1（Lip 矩阵的热带次乘性）**：对 $\phi_2 \circ \phi_1 \in \Omega$，复合算子的跨分量 Lip 常数满足：

$$L_{\phi_2 \circ \phi_1,\, d_i \to d_j} \;\leq\; \inf_{k \in I} \bigl\{ L_{\phi_2,\, d_k \to d_j} \;\cdot\; L_{\phi_1,\, d_i \to d_k} \bigr\}$$

即 $\mathbf{L}_{\phi_2 \circ \phi_1} \leq \mathbf{L}_{\phi_2} \otimes_{\min} \mathbf{L}_{\phi_1}$，其中 $\otimes_{\min}$ 为 $(\min, \times)$-热带半环下的矩阵乘积。

**证明**：对任意 $x, y \in \mathrm{dom}(\phi_2 \circ \phi_1)$ 且 $d_i(x,y) > 0$，选取任意中间分量 $d_k$。若 $d_k(\phi_1(x), \phi_1(y)) > 0$，则：

$$\frac{d_j((\phi_2 \circ \phi_1)(x),\, (\phi_2 \circ \phi_1)(y))}{d_i(x, y)} \;=\; \frac{d_j(\phi_2(\phi_1(x)),\, \phi_2(\phi_1(y)))}{d_k(\phi_1(x),\, \phi_1(y))} \;\cdot\; \frac{d_k(\phi_1(x),\, \phi_1(y))}{d_i(x, y)} \;\leq\; L_{\phi_2, d_k \to d_j} \cdot L_{\phi_1, d_i \to d_k}$$

若 $d_k(\phi_1(x), \phi_1(y)) = 0$，则 $\phi_1(x)$ 与 $\phi_1(y)$ 在 $d_k$ 下不可区分。由 $L_{\phi_2, d_k \to d_j}$ 的定义，$d_j(\phi_2(\phi_1(x)), \phi_2(\phi_1(y))) \leq L_{\phi_2, d_k \to d_j} \cdot 0 = 0$（当 $L_{\phi_2, d_k \to d_j} < \infty$；当 $L_{\phi_2, d_k \to d_j} = +\infty$ 时，约定 $+\infty \cdot 0 = 0$），左端为零，不等式平凡成立。对所有 $x, y$ 取 $\sup$，再对所有 $k$ 取 $\inf$ 即得。$\square$

> **注（最佳中间通道）**：输入在 $d_i$ 上的扰动传播到输出在 $d_j$ 上的差异，需经过某个中间分量 $d_k$ 作为传导通道。总放大率受**最优通道**约束——选取使乘积 $L_{\phi_2, d_k \to d_j} \cdot L_{\phi_1, d_i \to d_k}$ 最小的 $d_k$。

**推论 2.2（正交性在复合下封闭）**：若 $\mathbf{L}_{\phi_1}$ 和 $\mathbf{L}_{\phi_2}$ 均为对角矩阵，则 $\mathbf{L}_{\phi_2 \circ \phi_1}$ 也为对角矩阵。

**证明**：对 $i \neq j$，考查 $\inf_k \{ L_{\phi_2, d_k \to d_j} \cdot L_{\phi_1, d_i \to d_k} \}$。当 $k = i$ 时，$L_{\phi_2, d_i \to d_j} = 0$（$\mathbf{L}_{\phi_2}$ 对角，$i \neq j$）；当 $k \neq i$ 时，$L_{\phi_1, d_i \to d_k} = 0$（$\mathbf{L}_{\phi_1}$ 对角）。故乘积对所有 $k$ 为零。$\square$

**推论 2.3（信息擦除不可逆）**：若 $L_{\phi_1, d_i \to d_k} = 0$ 对所有 $k \in I$（即 $\phi_1$ 在分量 $d_i$ 上为常值且不向任何分量传导），则 $L_{\phi_2 \circ \phi_1, d_i \to d_j} = 0$ 对所有 $j \in I$。

**推论 2.4（$k$-步链的 Lip 矩阵）**：对算子链 $c_\phi = \phi_k \circ \cdots \circ \phi_1$：

$$\mathbf{L}_{c_\phi} \;\leq\; \mathbf{L}_{\phi_k} \otimes_{\min} \cdots \otimes_{\min} \mathbf{L}_{\phi_1}$$

### 2.3 算子链的分量传递

算子链 $c_\phi = \phi_k \circ \cdots \circ \phi_1$ 中，分量分划如何在逐步复合中演化？

**命题 2.5（复合的活跃分量包含）**：对 $\phi_2 \circ \phi_1 \in \Omega$：

$$I_{\mathrm{act}}(\phi_2 \circ \phi_1) \;\subseteq\; I_{\mathrm{act}}(\phi_1) \cup I_{\mathrm{act}}(\phi_2)$$

**证明**：取逆否：设 $i \notin I_{\mathrm{act}}(\phi_1) \cup I_{\mathrm{act}}(\phi_2)$，即 $\phi_1$ 和 $\phi_2$ 在 $d_i$ 上各自为恒等或常值。需证 $\phi_2 \circ \phi_1$ 在 $d_i$ 上仍为恒等或常值（即 $i \notin I_{\mathrm{act}}(\phi_2 \circ \phi_1)$）。分四种情况：

**(a)** $i \in I_{\mathrm{id}}(\phi_1)$ 且 $i \in I_{\mathrm{id}}(\phi_2)$：$d_i((\phi_2 \circ \phi_1)(x), x) \leq d_i(\phi_2(\phi_1(x)), \phi_1(x)) + d_i(\phi_1(x), x) = 0 + 0 = 0$。故 $i \in I_{\mathrm{id}}(\phi_2 \circ \phi_1)$。

**(b)** $i \in I_{\mathrm{id}}(\phi_1)$ 且 $i \in I_{\mathrm{const}}(\phi_2)$：$d_i((\phi_2 \circ \phi_1)(x), (\phi_2 \circ \phi_1)(y)) = d_i(\phi_2(\phi_1(x)), \phi_2(\phi_1(y))) = 0$（$\phi_2$ 在 $d_i$ 上为常值）。故复合在 $d_i$ 上为恒等或常值。

**(c)** $i \in I_{\mathrm{const}}(\phi_1)$ 且 $i \in I_{\mathrm{id}}(\phi_2)$：$\phi_1$ 在 $d_i$ 上为常值，故 $d_i(\phi_1(x), \phi_1(y)) = 0$ 对所有 $x, y$。$\phi_2$ 在 $d_i$ 上为恒等，故 $d_i(\phi_2(u), u) = 0$ 对所有 $u$。由三角不等式：$d_i(\phi_2(\phi_1(x)), \phi_2(\phi_1(y))) \leq d_i(\phi_2(\phi_1(x)), \phi_1(x)) + d_i(\phi_1(x), \phi_1(y)) + d_i(\phi_1(y), \phi_2(\phi_1(y))) = 0 + 0 + 0 = 0$。故复合在 $d_i$ 上为恒等或常值。

**(d)** $i \in I_{\mathrm{const}}(\phi_1)$ 且 $i \in I_{\mathrm{const}}(\phi_2)$：$d_i(\phi_2(\phi_1(x)), \phi_2(\phi_1(y))) = 0$（$\phi_2$ 在 $d_i$ 上为常值）。故复合在 $d_i$ 上为恒等或常值。

四种情况下 $\phi_2 \circ \phi_1$ 在 $d_i$ 上均非活跃。$\square$

> **注（包含可能严格）**：即使 $i \in I_{\mathrm{act}}(\phi_1) \cap I_{\mathrm{act}}(\phi_2)$，复合后 $\phi_2 \circ \phi_1$ 在 $d_i$ 上也可能退化为恒等或常值——两步活跃变换可能互相抵消。

**命题 2.6（恒等分量的保持条件）**：$i \in I_{\mathrm{id}}(\phi_2 \circ \phi_1)$ 当且仅当 $i \in I_{\mathrm{id}}(\phi_1)$ 且 $i \in I_{\mathrm{id}}(\phi_2|_{\mathrm{Im}(\phi_1)})$。

**证明**：$d_i((\phi_2 \circ \phi_1)(x), x) = 0$ 对所有 $x$ 要求 (1) $d_i(\phi_1(x), x) = 0$（即 $i \in I_{\mathrm{id}}(\phi_1)$），(2) $d_i(\phi_2(\phi_1(x)), \phi_1(x)) = 0$（即 $\phi_2$ 在 $\mathrm{Im}(\phi_1)$ 上关于 $d_i$ 为恒等）。三角不等式：$d_i(\phi_2(\phi_1(x)), x) \leq d_i(\phi_2(\phi_1(x)), \phi_1(x)) + d_i(\phi_1(x), x) = 0$。反之，若 $d_i(\phi_2(\phi_1(x)), x) = 0$，由 $d_i(\phi_1(x), x) \geq d_i(\phi_2(\phi_1(x)), x) - d_i(\phi_2(\phi_1(x)), \phi_1(x)) \geq 0$，两项均须为零。$\square$

> **注（恒等分量只减不增）**：$I_{\mathrm{id}}(\phi_2 \circ \phi_1) \subseteq I_{\mathrm{id}}(\phi_1) \cap I_{\mathrm{id}}(\phi_2|_{\mathrm{Im}(\phi_1)})$。链越长，恒等分量集合单调不增。一旦某步 $\phi_m$ 在分量 $d_i$ 上非恒等，后续链即使全部在 $d_i$ 上恒等，复合结果仍在 $d_i$ 上非恒等。

**命题 2.7（常值分量的累积单调性）**：若 $i \in I_{\mathrm{const}}(\phi_m)$ 对某步 $m$，则 $i \in I_{\mathrm{const}}(\phi_k \circ \cdots \circ \phi_1)$ 或 $i \in I_{\mathrm{id}}(\phi_k \circ \cdots \circ \phi_1)$。

**证明**：$\phi_m$ 在 $d_i$ 上为常值，故对所有 $x, y \in \mathrm{dom}(\phi_m)$，$d_i(\phi_m(x), \phi_m(y)) = 0$。后续步 $\phi_{m+1}, \ldots, \phi_k$ 接收到的输入在 $d_i$ 下均不可区分，输出亦然：$d_i((\phi_k \circ \cdots \circ \phi_1)(x), (\phi_k \circ \cdots \circ \phi_1)(y)) = 0$。故复合在 $d_i$ 上为恒等或常值。$\square$

> **注（常值分量的不可逆性）**：一旦链中某步在分量 $d_i$ 上为常值——即 $d_i$-信息被擦除——后续步无法恢复该信息。$d_i$ 通道被永久关闭。

### 2.4 算子空间的复合几何

在算子空间 $(\Omega, d_{\Omega, d'})$（§1.3）上，函数复合作用于算子间距离的性质。左复合与右复合具有根本不同的几何行为。

#### 左复合

**命题 2.8（左复合的 Lipschitz 性）**：对 $\psi, \phi_1, \phi_2 \in \Omega$ 和伪度量 $d'$：

$$d_{\Omega, d'}(\psi \circ \phi_1,\; \psi \circ \phi_2) \;\leq\; L_{\psi, d'} \cdot d_{\Omega, d'}(\phi_1, \phi_2)$$

即左复合 $\ell_\psi: \phi \mapsto \psi \circ \phi$ 是 $(\Omega, d_{\Omega, d'})$ 上的 $L_{\psi, d'}$-广义 Lipschitz 映射。

**证明**：对任意 $x \in \mathcal{X}$，$d'(\psi(\phi_1(x)), \psi(\phi_2(x))) \leq L_{\psi, d'} \cdot d'(\phi_1(x), \phi_2(x))$。取 $\sup_x$ 即得。$\square$

#### 右复合

**命题 2.9（右复合收缩）**：对 $\psi, \phi_1, \phi_2 \in \Omega$ 和伪度量 $d'$：

$$d_{\Omega, d'}(\phi_1 \circ \psi,\; \phi_2 \circ \psi) \;=\; d_{\Omega, d'}(\phi_1, \phi_2)\big|_{\mathrm{Im}(\psi)} \;\leq\; d_{\Omega, d'}(\phi_1, \phi_2)$$

即右乘 $r_\psi: \phi \mapsto \phi \circ \psi$ 是 $(\Omega, d_{\Omega, d'})$ 上的 **1-Lipschitz** 映射——从不放大。当 $\mathrm{Im}(\psi) = \mathcal{X}$ 时取等。

**证明**：$d_{\Omega, d'}(\phi_1 \circ \psi, \phi_2 \circ \psi) = \sup_x d'(\phi_1(\psi(x)), \phi_2(\psi(x)))$。令 $y = \psi(x)$，$x$ 遍历 $\mathcal{X}$ 时 $y$ 遍历 $\mathrm{Im}(\psi) \subseteq \mathcal{X}$，故 $\sup$ 限制到 $\mathrm{Im}(\psi)$ 上，不超过对全空间的 $\sup$。$\square$

> **注（信息限制）**：右复合将比较域从 $\mathcal{X}$ **限制到** $\mathrm{Im}(\psi)$。$\phi_1, \phi_2$ 在 $\mathcal{X} \setminus \mathrm{Im}(\psi)$ 上的差异对 $\phi_1 \circ \psi$ 与 $\phi_2 \circ \psi$ 不可见——$\psi$ 对信息进行了不可逆过滤。

#### 结构性非交换性

**命题 2.10（复合的结构性非交换性）**：在 $(\Omega, \circ, d_{\Omega, d'})$ 中：

**(i)** 左乘 $\ell_\psi: \phi \mapsto \psi \circ \phi$ 是 $L_{\psi, d'}$-Lipschitz 映射（命题 2.8）。当 $L_{\psi, d'} > 1$ 时放大差异。

**(ii)** 右乘 $r_\psi: \phi \mapsto \phi \circ \psi$ 是 $1$-Lipschitz 映射（命题 2.9）。从不放大差异，但将比较域限制到 $\mathrm{Im}(\psi)$，产生不可逆的信息丢失。

> **注（算子链中每一步的双重角色）**：在链 $c_\phi = \phi_k \circ \cdots \circ \phi_1$ 中，步 $\phi_m$（$1 < m < k$）同时扮演两个角色：作为 $\phi_{m-1} \circ \cdots \circ \phi_1$ 的**左因子**，其 Lip 常数决定上游差异的放大率；作为 $\phi_{m+1}$ 的**右因子**，$\mathrm{Im}(\phi_m \circ \cdots \circ \phi_1)$ 决定下游的有效比较域。

----
*[IDFS] ⊢ [GLENZLI] ⊢ [Part 01] ⊢ [02-component-analysis] ⊢ [85faf40ff0286a41]*
