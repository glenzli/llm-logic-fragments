## §2 架构等效性与代数变换


§1 定义了 $\sigma$-可计算性——路由映射 $\sigma$ 可由系统自身的 $f$-链精确实现（$\sigma = \psi \circ q_\sigma$）。本节推导这一单一条件蕴含的结构性定理。

### 2.1 计算-控制互换定理

$\sigma$-可计算性的核心结构性后果是：在特定条件下，**路由映射的变更可以被函数库的变更吸收**。但这一互换性不是无条件的——它受限于 $\sigma$ 对输入空间的区划分辨率。

**定义（分区加细，Partition Refinement）**：设 $\sigma, \sigma': \mathcal{X} \to F^*$ 为两个路由映射。称 $\sigma$ 的分区是 $\sigma'$ 的分区的**加细**（记作 $\sigma \succeq \sigma'$），若：

$$\forall x_1, x_2 \in \mathcal{X}:\; \sigma(x_1) = \sigma(x_2) \;\Longrightarrow\; \sigma'(x_1) = \sigma'(x_2)$$

等价地，$\sigma'$ 可分解为 $\sigma' = g \circ \sigma$，其中 $g: \mathrm{Im}(\sigma) \to F^*$。

加细的含义是：$\sigma$ 的分区不粗于 $\sigma'$ 的分区——凡是 $\sigma'$ 需要区分的输入对，$\sigma$ 一定也能区分。在路由容量充裕的系统中，此条件通常容易满足。

**定理 2.1（计算-控制互换，Computation-Control Interchange）**：设 IDFS $\mathcal{F} = (F, \sigma)$ 满足 $\sigma$-可计算性，$\sigma': \mathcal{X} \to F^*$ 为另一路由映射。若 $\sigma \succeq \sigma'$（$\sigma$ 的分区是 $\sigma'$ 的加细），则存在 $F' \subseteq F^*$，使得 $(F, \sigma')$ 与 $(F', \sigma)$ 在全局映射层面等价：

$$\forall x \in \mathcal{X}:\; \sigma'(x)(x) \;=\; h(\sigma(x))(x)$$

其中 $h: \mathrm{Im}(\sigma) \to F^*$ 为重映射，$F' = \mathrm{Im}(h)$。

**证明**：

由分区加细 $\sigma \succeq \sigma'$，在 $\sigma$ 的每个分区 $X_q = \sigma^{-1}(q)$ 上，$\sigma'$ 取**常值**——即 $\exists\, q'_q \in F^*$ 使得 $\sigma'(x) = q'_q$ 对所有 $x \in X_q$ 成立。

定义重映射 $h: \mathrm{Im}(\sigma) \to F^*$，$h(q) = q'_q$。则对任意 $x \in X_q$：

$$h(\sigma(x))(x) = h(q)(x) = q'_q(x) = \sigma'(x)(x)$$

令 $F' = \{h(q) : q \in \mathrm{Im}(\sigma)\} \subseteq F^*$。$(F', \sigma)$ 的全局映射即为 $\Phi_{F'}(x) = h(\sigma(x))(x) = \sigma'(x)(x) = \Phi'(x)$。$\square$

> **注（加细条件的必要性）**：若 $\sigma \not\succeq \sigma'$（即存在 $x_1, x_2$ 使得 $\sigma(x_1) = \sigma(x_2)$ 但 $\sigma'(x_1) \neq \sigma'(x_2)$），则在 $X_q$ 上 $\sigma'$ 不取常值——$\sigma'(x_1)(x_1)$ 与 $\sigma'(x_2)(x_2)$ 执行不同的链。此时要求**单个** $h(q)$ 同时满足 $h(q)(x_1) = \sigma'(x_1)(x_1)$ 和 $h(q)(x_2) = \sigma'(x_2)(x_2)$，等价于要求 $h(q) \in F^*$ 逼近一个在 $X_q$ 内部的**分段映射**——这在一般度量空间上不可能精确达成（因为 $h(q)$ 作为连续算子的有限复合必须是 Lipschitz 的，但分段映射可以在 $X_q$ 内部为不连续的）。因此分区加细是互换性的**必要条件**，不可削弱。

> **注（$\sigma$-可计算性的角色）**：定理 2.1 的证明中，$\sigma$-可计算性保证了分区 $\{X_q\}$ 的边界由 $q_\sigma$ 的水平集确定（$F^*$-可计算的结构），使得重映射 $h$ 的构造在系统内部有明确的代数意义——这不是外部强加的分区，而是系统自身计算所决定的分区。若 $\sigma$ 不是 $F$-可计算的，分区的边界可能是"超越" $F^*$ 的结构，$h$ 的构造虽然形式上相同，但在系统内部无法实现。

---

### 2.2 自模拟间隙

$\sigma$-可计算性将 $\Phi$ 的执行分解为三阶段：$q_\sigma$（$F^*$-计算）→ $\psi$（选择）→ 链执行（$F^*$-计算）。一个自然的问题是：$\psi$ 是否也可以被 $F^*$ 内化——使系统完全用自身的算子模拟自身的执行？

**定理 2.2（$\psi$-不可消除性）**：设 IDFS $\mathcal{F} = (F, \sigma)$ 满足 $\sigma$-可计算性。则对 $\sigma$ 的**任意** $F$-可计算分解 $\sigma = \psi' \circ q'_\sigma$（$q'_\sigma \in F^*$），选择映射 $\psi': q'_\sigma(\mathcal{X}) \to F^*$ 不可由 $F^*$-链替代。

**证明**：

$F^*$-链的值域在 $\mathcal{X}$ 中：对任意 $q \in F^*$，$q: \mathcal{X} \to \mathcal{X}$。而 $\psi'$ 的值域在 $F^*$ 中：$\psi': q'_\sigma(\mathcal{X}) \to F^*$。若 $\psi'$ 可由某 $F^*$-链 $q_\psi$ 替代，则 $q_\psi$ 的值域同时在 $\mathcal{X}$ 和 $F^*$ 中——这要求 $F^*$ 的元素同时是 $\mathcal{X}$ 中的点。

即使通过编码 $\iota: F^* \hookrightarrow \mathcal{X}$ 将链嵌入度量空间，使得 $q_\psi$ 可以输出"链的编码值"$\iota(q) \in \mathcal{X}$，仍需一个**解码步骤** $\iota^{-1}: \iota(F^*) \to F^*$ 将编码值恢复为实际链。此解码步骤 $\iota^{-1}$ 映射 $\mathcal{X} \to F^*$，本身不是 $F^*$-链（$F^*$-链映射 $\mathcal{X} \to \mathcal{X}$）。因此编码仅将 $\psi'$ 分解为 $\psi' = \iota^{-1} \circ q_\psi$——将一个非 $F^*$ 映射替换为另一个非 $F^*$ 映射（$\iota^{-1}$），选择映射的非 $F^*$ 成分不可消除。$\square$

> **注（间隙的精确定位）**：$\sigma$-可计算性最大化了系统的自知能力——$q_\sigma$ 使系统能够用自己的算子计算路由决策所需的**全部信息**（$q_\sigma(x) \in \mathcal{X}$）。不可消除的间隙仅在最后一步：从 $\mathcal{X}$ 中的信息值到 $F^*$ 中的可执行链的**跳跃**。这一跳跃跨越了值空间（$\mathcal{X}$）与程序空间（$F^*$）之间的边界，任何 $F^*$ 内部的运算都无法完成。

> **注（与非图灵完备性的关系）**：IDFS 的非图灵完备性已由第一章定理 2.17 确立——源于 $F$ 有限与链深有界的基本约束。$\psi$-不可消除性提供了这一结论的**结构性解释**：图灵机之所以能自模拟，是因为程序与数据共享同一个表示空间（符号串）；IDFS 中路由决策（$F^*$）与计算值（$\mathcal{X}$）处于不同的数学结构中，这一分离是非图灵完备性在 $\sigma$-可计算语境下的具体表现。

### 2.3 算子诱导等效定理

$\sigma$-可计算性使得对输入施加 $F^*$-变换可以被完全吸收到系统的结构参数中——**变换输入等效于变换系统**。

**定理 2.3（算子诱导等效，Operator-Induced Equivalence）**：设 IDFS $\mathcal{F} = (F, \sigma)$，$\phi \in F^*$。定义 $\sigma'(x) = \sigma(\phi(x)) \circ \phi$。则：

**(a)** $(F, \sigma)$ 在 $\phi(x)$ 上的执行等价于 $(F, \sigma')$ 在原始输入 $x$ 上的执行：

$$\Phi(\phi(x)) = \sigma'(x)(x)$$

**(b)** 若 $\mathcal{F}$ 满足 $\sigma$-可计算性，且 $\sigma \succeq \sigma'$（$\sigma$ 的分区是 $\sigma'$ 的分区的加细），则由定理 2.1，$(F, \sigma)$ 在 $\phi(x)$ 上的执行进一步等价于 $(F', \sigma)$ 在原始 $x$ 上的执行：

$$\Phi(\phi(x)) = \Phi_{F'}(x)$$

其中 $F' = \mathrm{Im}(h)$，$h: \mathrm{Im}(\sigma) \to F^*$ 为定理 2.1 中的重映射。即**变换输入等效于变换函数库**——路由 $\sigma$ 不变，$\phi$ 的效果被完全吸收到 $F'$ 中。

**证明**：

**(a)** 对任意 $x$，$\sigma(\phi(x)) \in F^*$ 为选出的链。由 $\phi \in F^*$，复合 $\sigma(\phi(x)) \circ \phi \in F^*$，且 $(\sigma(\phi(x)) \circ \phi)(x) = \sigma(\phi(x))(\phi(x)) = \Phi(\phi(x))$。故 $\sigma'(x)(x) = \Phi(\phi(x))$。

**(b)** 由 $\sigma \succeq \sigma'$，在 $\sigma$ 的每个分区 $X_q = \sigma^{-1}(q)$ 上 $\sigma'$ 取常值 $q'_q$。定义 $h(q) = q'_q$。由于 $\mathcal{F}$ 是 $\sigma$-可计算的，可合法地应用定理 2.1，得 $\sigma'(x)(x) = h(\sigma(x))(x) = \Phi_{F'}(x)$。$\square$

> **注（$\sigma$-可计算性的结构性角色）**：定理 2.3(a) 的代数变换 $\Phi(\phi(x)) = \sigma'(x)(x)$ 仅依赖 IDFS 的基本定义，无需 $\sigma$-可计算性。但要在 (b) 中将路由变化 $\sigma \to \sigma'$ 转化为函数库变化 $F \to F'$，必须调用定理 2.1。正如定理 2.1 的注记所言，只有系统是 $\sigma$-可计算的，重映射 $h$ 依赖的分区边界（由 $q_\sigma$ 的水平集划定）才具有内部代数意义。此外，在 $\sigma$-可计算前提下，诱导的 $\sigma'$ 自然继承了 $F$-可计算性（$q_{\sigma'} = q_\sigma \circ \phi$），使得变换后的系统在架构上并未退化。

> **注（精度约束）**：$\phi$ 诱导的系统等效变换的精细程度受限于 $\sigma$ 的分区数 $|\mathrm{Im}(\sigma)|$，由第一章的路由容量限制（命题 2.1）封顶。$\phi$ 只有在将 $x$ 移动至跨越分区边界时才引起路由跳变；在分区内部的移动仅引起链的 Lipschitz 连续响应。

> **注（与第三章的代数闭环：链固化的执行期底座）**：第三章 §3 从**演化动力学**（发生学）角度指出，系统会将高频复用的序列长链压缩凝固为单步算子加入 $F$ 中，即**链固化**。本定理 2.3 从**架构**（执行期）角度为这一机制提供了严密的代数空间：在 $\sigma$-可计算系统中，输入端由算子序列 $\phi$ 构筑的上下文堆叠，在执行时**不可区分地**等效于将系统替换为包含固化后算子的新库 $F'$。时间上的算子序列被空间上的架构变化拉平——算子吸收保证了被演化固化的经验可以被路由机制无缝提取。


