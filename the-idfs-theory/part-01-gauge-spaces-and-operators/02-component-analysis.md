## 分量分析

### 2.1 算子的分量分划

**定义（分量分划，Component Decomposition）**：设 $\phi \in \Omega$，$\mathcal{G} = \{d_i\}_{i \in I}$ 为规范结构。定义：

- **恒等分量** $I_{\mathrm{id}}(\phi) = \{i \in I : \forall x \in \mathrm{dom}(\phi),\; d_i(\phi(x), x) = 0\}$。
- **常值分量** $I_{\mathrm{const}}(\phi) = \{i \in I \setminus I_{\mathrm{id}}(\phi) : \forall x, y \in \mathrm{dom}(\phi),\; d_i(\phi(x), \phi(y)) = 0\}$。
- **活跃分量** $I_{\mathrm{act}}(\phi) = I \setminus (I_{\mathrm{id}}(\phi) \cup I_{\mathrm{const}}(\phi))$。

三者互斥且穷尽：$I = I_{\mathrm{id}} \sqcup I_{\mathrm{const}} \sqcup I_{\mathrm{act}}$。若 $i$ 同时满足恒等与常值条件（$\mathrm{dom}(\phi)$ 中所有点在 $d_i$ 下不可区分且 $\phi$ 在 $d_i$ 上为恒等），优先归入 $I_{\mathrm{id}}$。$|I| = 1$ 时，分划退化为 $I_{\mathrm{act}} = I$（除非 $\phi = \mathrm{id}$ 或 $\phi$ 为常值映射）。

分量分划对应算子 $\phi$ 在每个分量伪度量上的三种行为模式：
- $i \in I_{\mathrm{id}}$：$\phi$ 在分量 $d_i$ 上**透明**——$d_i(\phi(x), x) = 0$ 对所有 $x$，输入的 $d_i$-结构被原封保持。
- $i \in I_{\mathrm{const}}$：$\phi$ 在分量 $d_i$ 上**遮蔽**——$d_i(\phi(x), \phi(y)) = 0$ 对所有 $x, y$，所有输出在 $d_i$ 下不可区分，$d_i$-信息被完全擦除。
- $i \in I_{\mathrm{act}}$：$\phi$ 在分量 $d_i$ 上**活跃**——$\phi$ 在 $d_i$ 下既非恒等亦非常值，输入的 $d_i$-差异被非平凡变换。

> **注（分量分划与 Lip 矩阵）**：设 $\mathbf{L} \in \mathscr{L}(\phi)$ 为任一合法 Lip 矩阵。$i \in I_{\mathrm{const}}(\phi)$ 蕴含对所有 $j$，$L_{i \to j}$ 的约束可以弱化（因为 $\phi$ 在 $d_i$ 上不产生变化，$d_i$ 的输入对任何输出的贡献为零态）。反之，$i \in I_{\mathrm{act}}(\phi)$ 意味着 $\phi$ 在 $d_i$ 下的行为非平凡，Lip 矩阵中涉及 $i$ 的条目携带实质信息。

### 2.2 分量正交性

**定义（分量正交，Component Orthogonality）**：设 $\mathbf{L} \in \mathscr{L}(\phi)$。称 $\phi$ 在 $\mathbf{L}$ 下于分量对 $(d_i, d_j)$（$i \neq j$）上**正交**，若 $L_{i \to j} = 0$——在此归因方式下，$d_i$-输入对 $d_j$-输出无贡献。

当 $\mathbf{L}$ 为对角矩阵时，$\phi$ 在该 Lip 矩阵下**分量完全解耦**——各分量独立演化，无跨分量耦合。非对角元 $L_{i \to j} > 0$ 表示 $d_i$-输入在此归因下对 $d_j$-输出有贡献。

> **注（正交性依赖于 Lip 矩阵的选取）**：由于 $\mathscr{L}(\phi)$ 一般不唯一，同一个 $\phi$ 可能存在一个对角 Lip 矩阵和一个非对角 Lip 矩阵。对角 Lip 矩阵存在时，表明 $\phi$ 的跨分量效应**可以**被消解为逐分量独立行为。

### 2.3 算子链的分量传递

算子链 $c_\phi = \phi_k \circ \cdots \circ \phi_1$ 中，分量分划如何在逐步复合中演化？

**命题 2.1（复合的活跃分量包含）**：对 $\phi_2 \circ \phi_1 \in \Omega$：

$$I_{\mathrm{act}}(\phi_2 \circ \phi_1) \;\subseteq\; I_{\mathrm{act}}(\phi_1) \cup I_{\mathrm{act}}(\phi_2)$$

**证明**：取逆否：设 $i \notin I_{\mathrm{act}}(\phi_1) \cup I_{\mathrm{act}}(\phi_2)$，即 $\phi_1$ 和 $\phi_2$ 在 $d_i$ 上各自为恒等或常值。需证 $\phi_2 \circ \phi_1$ 在 $d_i$ 上仍为恒等或常值（即 $i \notin I_{\mathrm{act}}(\phi_2 \circ \phi_1)$）。分四种情况：

**(a)** $i \in I_{\mathrm{id}}(\phi_1)$ 且 $i \in I_{\mathrm{id}}(\phi_2)$：$d_i((\phi_2 \circ \phi_1)(x), x) \leq d_i(\phi_2(\phi_1(x)), \phi_1(x)) + d_i(\phi_1(x), x) = 0 + 0 = 0$。故 $i \in I_{\mathrm{id}}(\phi_2 \circ \phi_1)$。

**(b)** $i \in I_{\mathrm{id}}(\phi_1)$ 且 $i \in I_{\mathrm{const}}(\phi_2)$：$d_i((\phi_2 \circ \phi_1)(x), (\phi_2 \circ \phi_1)(y)) = d_i(\phi_2(\phi_1(x)), \phi_2(\phi_1(y))) = 0$（$\phi_2$ 在 $d_i$ 上为常值）。故复合在 $d_i$ 上为恒等或常值。

**(c)** $i \in I_{\mathrm{const}}(\phi_1)$ 且 $i \in I_{\mathrm{id}}(\phi_2)$：$\phi_1$ 在 $d_i$ 上为常值，故 $d_i(\phi_1(x), \phi_1(y)) = 0$ 对所有 $x, y$。$\phi_2$ 在 $d_i$ 上为恒等，故 $d_i(\phi_2(u), u) = 0$ 对所有 $u$。由三角不等式：$d_i(\phi_2(\phi_1(x)), \phi_2(\phi_1(y))) \leq d_i(\phi_2(\phi_1(x)), \phi_1(x)) + d_i(\phi_1(x), \phi_1(y)) + d_i(\phi_1(y), \phi_2(\phi_1(y))) = 0 + 0 + 0 = 0$。故复合在 $d_i$ 上为恒等或常值。

**(d)** $i \in I_{\mathrm{const}}(\phi_1)$ 且 $i \in I_{\mathrm{const}}(\phi_2)$：$d_i(\phi_2(\phi_1(x)), \phi_2(\phi_1(y))) = 0$（$\phi_2$ 在 $d_i$ 上为常值）。故复合在 $d_i$ 上为恒等或常值。

四种情况下 $\phi_2 \circ \phi_1$ 在 $d_i$ 上均非活跃。$\square$

> **注（包含可能严格）**：即使 $i \in I_{\mathrm{act}}(\phi_1) \cap I_{\mathrm{act}}(\phi_2)$，复合后 $\phi_2 \circ \phi_1$ 在 $d_i$ 上也可能退化为恒等或常值——两步活跃变换可能互相抵消。

**命题 2.2（恒等分量的保持条件）**：$i \in I_{\mathrm{id}}(\phi_2 \circ \phi_1)$ 当且仅当 $i \in I_{\mathrm{id}}(\phi_1)$ 且 $i \in I_{\mathrm{id}}(\phi_2|_{\mathrm{Im}(\phi_1)})$。

**证明**：$d_i((\phi_2 \circ \phi_1)(x), x) = 0$ 对所有 $x$ 要求 (1) $d_i(\phi_1(x), x) = 0$（即 $i \in I_{\mathrm{id}}(\phi_1)$），(2) $d_i(\phi_2(\phi_1(x)), \phi_1(x)) = 0$（即 $\phi_2$ 在 $\mathrm{Im}(\phi_1)$ 上关于 $d_i$ 为恒等）。三角不等式：$d_i(\phi_2(\phi_1(x)), x) \leq d_i(\phi_2(\phi_1(x)), \phi_1(x)) + d_i(\phi_1(x), x) = 0$。反之，若 $d_i(\phi_2(\phi_1(x)), x) = 0$，由 $d_i(\phi_1(x), x) \geq d_i(\phi_2(\phi_1(x)), x) - d_i(\phi_2(\phi_1(x)), \phi_1(x)) \geq 0$，两项均须为零。$\square$

> **注（恒等分量只减不增）**：$I_{\mathrm{id}}(\phi_2 \circ \phi_1) \subseteq I_{\mathrm{id}}(\phi_1) \cap I_{\mathrm{id}}(\phi_2|_{\mathrm{Im}(\phi_1)})$。链越长，恒等分量集合单调不增。一旦某步 $\phi_m$ 在分量 $d_i$ 上非恒等，后续链即使全部在 $d_i$ 上恒等，复合结果仍在 $d_i$ 上非恒等。

**命题 2.3（常值分量的累积单调性）**：若 $i \in I_{\mathrm{const}}(\phi_m)$ 对某步 $m$，则 $i \in I_{\mathrm{const}}(\phi_k \circ \cdots \circ \phi_1)$ 或 $i \in I_{\mathrm{id}}(\phi_k \circ \cdots \circ \phi_1)$。

**证明**：$\phi_m$ 在 $d_i$ 上为常值，故对所有 $x, y \in \mathrm{dom}(\phi_m)$，$d_i(\phi_m(x), \phi_m(y)) = 0$。后续步 $\phi_{m+1}, \ldots, \phi_k$ 接收到的输入在 $d_i$ 下均不可区分，输出亦然：$d_i((\phi_k \circ \cdots \circ \phi_1)(x), (\phi_k \circ \cdots \circ \phi_1)(y)) = 0$。故复合在 $d_i$ 上为恒等或常值。$\square$

> **注（常值分量的不可逆性）**：一旦链中某步在分量 $d_i$ 上为常值——即 $d_i$-信息被擦除——后续步无法恢复该信息。$d_i$ 通道被永久关闭。

### 2.4 算子空间的复合几何

在算子空间 $(\Omega, d_{\Omega, d_i})$（§1.2）上，函数复合作用于算子间距离的性质。左复合与右复合具有根本不同的几何行为。

#### 左复合

**命题 2.4（左复合的 Lipschitz 性）**：设 $\mathbf{L} \in \mathscr{L}(\psi)$。对 $\phi_1, \phi_2 \in \Omega$ 和 $j \in I$：

$$d_{\Omega, d_j}(\psi \circ \phi_1,\; \psi \circ \phi_2) \;\leq\; \sum_{i \in I} L_{i \to j} \cdot d_{\Omega, d_i}(\phi_1, \phi_2)$$

即左复合 $\ell_\psi: \phi \mapsto \psi \circ \phi$ 关于 $\mathcal{G}_\Omega$ 的距离向量满足线性放大。

**证明**：对任意 $x \in \mathcal{X}$，$d_j(\psi(\phi_1(x)), \psi(\phi_2(x))) \leq \sum_i L_{i \to j} \cdot d_i(\phi_1(x), \phi_2(x))$。取 $\sup_x$，由 $\sup$ 的次可加性：$\leq \sum_i L_{i \to j} \cdot \sup_x d_i(\phi_1(x), \phi_2(x)) = \sum_i L_{i \to j} \cdot d_{\Omega, d_i}(\phi_1, \phi_2)$。$\square$

#### 右复合

**命题 2.5（右复合收缩）**：对 $\psi, \phi_1, \phi_2 \in \Omega$ 和 $d_i \in \mathcal{G}$：

$$d_{\Omega, d_i}(\phi_1 \circ \psi,\; \phi_2 \circ \psi) \;=\; d_{\Omega, d_i}(\phi_1, \phi_2)\big|_{\mathrm{Im}(\psi)} \;\leq\; d_{\Omega, d_i}(\phi_1, \phi_2)$$

即右乘 $r_\psi: \phi \mapsto \phi \circ \psi$ 在每个分量 $d_{\Omega, d_i}$ 上是 **1-Lipschitz** 映射——从不放大。当 $\mathrm{Im}(\psi) = \mathcal{X}$ 时取等。

**证明**：$d_{\Omega, d_i}(\phi_1 \circ \psi, \phi_2 \circ \psi) = \sup_x d_i(\phi_1(\psi(x)), \phi_2(\psi(x)))$。令 $y = \psi(x)$，$x$ 遍历 $\mathcal{X}$ 时 $y$ 遍历 $\mathrm{Im}(\psi) \subseteq \mathcal{X}$，故 $\sup$ 限制到 $\mathrm{Im}(\psi)$。$\square$

> **注（信息限制）**：右复合将比较域从 $\mathcal{X}$ **限制到** $\mathrm{Im}(\psi)$。$\phi_1, \phi_2$ 在 $\mathcal{X} \setminus \mathrm{Im}(\psi)$ 上的差异对 $\phi_1 \circ \psi$ 与 $\phi_2 \circ \psi$ 不可见——$\psi$ 对信息进行了不可逆过滤。

#### 结构性非交换性

**命题 2.6（复合的结构性非交换性）**：在 $(\Omega, \circ, \mathcal{G}_\Omega)$ 中：

**(i)** 左乘 $\ell_\psi: \phi \mapsto \psi \circ \phi$ 的距离向量受 Lip 矩阵 $\mathbf{L} \in \mathscr{L}(\psi)$ 线性放大（命题 2.4）。

**(ii)** 右乘 $r_\psi: \phi \mapsto \phi \circ \psi$ 在每个分量上是 $1$-Lipschitz 映射（命题 2.5）。从不放大差异，但将比较域限制到 $\mathrm{Im}(\psi)$，产生不可逆的信息丢失。

> **注（算子链中每一步的双重角色）**：在链 $c_\phi = \phi_k \circ \cdots \circ \phi_1$ 中，步 $\phi_m$（$1 < m < k$）同时扮演两个角色：作为 $\phi_{m-1} \circ \cdots \circ \phi_1$ 的**左因子**，其 Lip 常数决定上游差异的放大率；作为 $\phi_{m+1}$ 的**右因子**，$\mathrm{Im}(\phi_m \circ \cdots \circ \phi_1)$ 决定下游的有效比较域。

----
*[IDFS] ⊢ [GLENZLI] ⊢ [Part 01] ⊢ [02-component-analysis]*
