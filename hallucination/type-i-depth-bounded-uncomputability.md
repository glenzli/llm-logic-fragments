# I. 深度受限的不可计算性 (Depth-Bounded Uncomputability)

**分类坐标**：架构层 × 确定性任务

## 形式化

以下证明展开为三个步骤：**定义计算模型 → 建立上界 → 建立下界 → 推导结论**。

### 前置定义

**定义 1（电路复杂度类 $\text{AC}^0$, $\text{TC}^0$, $\text{NC}^1$）**

设 $\{C_n\}_{n \in \mathbb{N}}$ 为一族布尔电路，其中 $C_n$ 处理 $n$ 位输入。按深度和门类型分层：

| 复杂度类 | 深度 | 电路大小 | 门类型 |
|---|---|---|---|
| $\text{AC}^0$ | $O(1)$（常数） | $\text{poly}(n)$ | 无界扇入 AND, OR, NOT |
| $\text{TC}^0$ | $O(1)$（常数） | $\text{poly}(n)$ | 无界扇入 AND, OR, NOT, **MAJORITY** |
| $\text{NC}^1$ | $O(\log n)$ | $\text{poly}(n)$ | 有界扇入（$\leq 2$）AND, OR, NOT |

其中 MAJORITY 门输出其多数输入的值（即阈值门的特例）。已知包含关系：

$$
\text{AC}^0 \subsetneq \text{TC}^0 \subseteq \text{NC}^1 \subseteq \text{NC}^2 \subseteq \cdots \subseteq \text{P}
$$

$\text{AC}^0 \subsetneq \text{TC}^0$ 已严格证明：$\text{PARITY} \notin \text{AC}^0$ [Furst, Saxe & Sipser, 1984; Ajtai, 1983]，而 $\text{PARITY} \in \text{TC}^0$（MAJORITY 门可以计算奇偶性）。

**定义 2（Transformer 的形式计算模型）**

一个固定深度 Transformer $\mathcal{T}$ 由以下参数确定：层数 $L$（常数）、嵌入维度 $d$（常数）、注意力头数 $H$（常数），在 $p = O(\log n)$ 位精度下处理长度为 $n$ 的输入序列。每一层由以下运算复合：

1. **多头注意力**：$\text{Attn}(Q, K, V) = \text{softmax}(QK^\top / \sqrt{d_k}) \cdot V$
2. **前馈网络**：逐位置 MLP，$\text{FFN}(x) = W_2 \cdot \sigma(W_1 x + b_1) + b_2$
3. **残差连接与层归一化**

所有运算在 $O(\log n)$ 位精度下执行（即每个中间值用 $O(\log n)$ 位表示）。

### 步骤一：上界定理

**定理 1（Transformer 的 $\text{TC}^0$ 上界）** [Merrill & Sabharwal, 2023]

*陈述*：任意固定深度 $L$、$O(\log n)$ 位精度的 Transformer，处理长度为 $n$ 的输入序列时，可被深度为 $O(L)$、大小为 $\text{poly}(n)$ 的一致 $\text{TC}^0$ 电路族模拟。即：

$$
\text{Transformer}(L, d, H, p = O(\log n)) \subseteq \text{uniform-TC}^0
$$

*证明要点*：逐一验证 Transformer 的每个组件均可在常数深度 $\text{TC}^0$ 中实现：

1. **Softmax 注意力**：在 $O(\log n)$ 位精度下，$\exp(\cdot)$ 的值域为 $\text{poly}(n)$ 种离散值，可用查找表实现（属于 $\text{AC}^0$）。加权求和是 $n$ 个 $O(\log n)$ 位数的加法，而多个整数的加法（iterated addition）属于 $\text{TC}^0$（可由 MAJORITY 门在常数深度完成 [Chandra, Stockmeyer & Vishkin, 1984]）。
2. **矩阵乘法**（$d \times d$，$d$ 为常数）：每个输出元素是 $d$ 个乘积之和。$O(\log n)$ 位整数乘法属于 $\text{TC}^0$，常数个乘积的求和亦然。
3. **逐元素非线性激活**（SiLU, GeLU, ReLU）：在 $O(\log n)$ 位精度下，激活函数是 $\text{poly}(n)$ 种输入到输出的映射，可用查找表实现，属于 $\text{AC}^0 \subset \text{TC}^0$。
4. **层间复合**：$L$ 个常数深度电路的级联，总深度 $O(L) = O(1)$（$L$ 为常数）。

综上，每一层是常数深度 $\text{TC}^0$ 电路，$L$ 层的级联仍是常数深度。$\square$

> [!NOTE]
> 精度约束 $p = O(\log n)$ 是该定理的关键假设。若允许 $\text{poly}(n)$ 位精度，则每个中间值本身需要超多项式空间描述，定理不再适用。实际 Transformer 使用 16/32 位浮点数，远小于 $O(\log n)$（对于合理的输入长度），因此该假设是宽松的。

### 步骤二：下界定理

**定理 2（刚性任务的 $\text{NC}^1$ 完备性）** [Barrington, 1989]

*陈述*：以下问题是 $\text{NC}^1$-complete（在 $\text{AC}^0$ 归约下），即它们恰好捕获了 $\text{NC}^1$ 的全部计算能力：

| 问题 | $\text{NC}^1$-completeness 来源 |
|---|---|
| 置换群的迭代复合（Iterated Permutation Composition） | Barrington, 1989 |
| 布尔公式求值（Boolean Formula Evaluation） | Buss, 1987 |

此外，以下确定性计算任务属于 $\text{NC}^1$，且没有任何已知的 $\text{TC}^0$ 算法：

| 问题 | 复杂度状态 | 来源 |
|---|---|---|
| 多位整数乘法 | $\in \text{TC}^1 \cap \text{NC}^1$，无已知 $\text{TC}^0$ 构造 | Hesse, Allender & Barrington, 2002 |
| 有限自动机模拟（$k$ 步） | 需要 $\Omega(\log k)$ 深度的自适应计算 | Barrington, 1989 |

*Barrington 定理的关键洞察*：$\text{NC}^1$ 恰好等价于宽度为 5 的分支程序（width-5 branching programs）所能计算的函数类。宽度 5 的分支程序需要 $\Omega(\log n)$ 层**自适应**计算——即第 $i$ 步的操作依赖于第 $i-1$ 步的结果。这种**顺序依赖性**是 $\text{NC}^1$ 与 $\text{TC}^0$ 的核心区别：

- $\text{TC}^0$ 的计算是**大规模并行**的——常数层内完成所有计算，层数与输入规模无关。
- $\text{NC}^1$ 的计算允许**对数深度的顺序推理**——后续计算可依赖先前计算的结果。

### 步骤三：不可计算性结论

**定理 3（固定深度 Transformer 的不可计算性）**

*陈述*：在标准复杂度假设 $\text{TC}^0 \subsetneq \text{NC}^1$ 下，设 $f: \{0,1\}^n \to \{0,1\}$ 为任意 $\text{NC}^1$-complete 问题的目标函数。则对任意固定深度 $L$ 和任意参数配置 $\theta$ 的 $O(\log n)$ 精度 Transformer $\mathcal{T}_{L,\theta}$：

$$
\forall L \in \mathbb{Z}^+,\ \forall \theta,\quad \exists\, x \in \{0,1\}^n,\quad \mathcal{T}_{L,\theta}(x) \neq f(x)
$$

即：**不存在任何参数配置能使固定深度 Transformer 在所有输入上精确计算 $f$。**

*证明*：

1. 由定理 1，$\mathcal{T}_{L,\theta}$ 对所有参数 $\theta$ 计算的函数均属于 $\text{TC}^0$。
2. 由假设 $\text{TC}^0 \subsetneq \text{NC}^1$ 和 $f$ 的 $\text{NC}^1$-completeness，$f \notin \text{TC}^0$。
3. 结合 (1) 和 (2)：$\mathcal{T}_{L,\theta}$ 计算的函数与 $f$ 不同，故存在输入 $x$ 使 $\mathcal{T}_{L,\theta}(x) \neq f(x)$。$\square$

### 证明的强度评估

此证明的严格性取决于复杂度假设 $\text{TC}^0 \subsetneq \text{NC}^1$ 的地位：

| 维度 | 状态 |
|---|---|
| 定理 1（上界） | ✅ 无条件严格定理 |
| 定理 2（下界分类） | ✅ 无条件严格定理 |
| $\text{TC}^0 \subsetneq \text{NC}^1$（分离假设） | ⚠️ 标准复杂度假设，未无条件证明 |
| 定理 3（最终结论） | ✅ 在标准假设下严格 |

> [!IMPORTANT]
> **$\text{TC}^0 \subsetneq \text{NC}^1$ 的可信度**：此分离是电路复杂度理论的核心猜想之一。佐证包括：
> - 存在相对化的 oracle 分离 [Håstad, 1986 框架]
> - 所有已知 $\text{NC}^1$-complete 问题均无已知 $\text{TC}^0$ 算法（50+ 年的算法研究未能攻破）
> - 若 $\text{TC}^0 = \text{NC}^1$，将导致复杂度类的大规模坍缩，与现有理论体系的全局结构严重矛盾
>
> 此假设的地位类似于 $\text{P} \neq \text{NP}$——学界视为事实但尚无无条件证明。注意：这与 Type II 中推论 4 的"几何概率论证"在**性质上截然不同**——此处是标准复杂度假设（属于数学推测的最高可信级别），而非关于特定系统行为的近似论证。

## 结论

这是一个**架构上界**，不依赖于训练数据量、参数规模或微调策略。在标准复杂度假设下，常数深度网络在数学上**不可能**精确计算需要对数深度顺序推理的函数——这是一个关于计算能力的**不可能性定理**，而非精度或稳定性问题。

## 缓解路径与 CoT 的形式化分析

### 缓解策略

- **Chain-of-Thought (CoT)**：将递归深度从网络层数转移到生成序列的长度，等价于用自回归展开来模拟递归。
- **Tool Use**：将精确计算直接外包给图灵完备的外部系统。

以下对 CoT 突破 $\text{TC}^0$ 上界的机制给出形式化分析。

### CoT 计算模型

**定义 3（自回归 CoT 计算模型）**

设 $\mathcal{T}$ 为固定深度 $L$、$O(\log n)$ 精度的 Transformer。定义其 $T$ 步 CoT 展开 $\mathcal{T}^{(T)}$ 如下：

- 步骤 $0$：输入 $x \in \{0,1\}^n$ → $\mathcal{T}$ → 输出 token $t_1$
- 步骤 $1$：输入 $(x, t_1)$ → $\mathcal{T}$ → 输出 token $t_2$
- $\cdots$
- 步骤 $T{-}1$：输入 $(x, t_1, \ldots, t_{T-1})$ → $\mathcal{T}$ → 输出 token $t_T$

最终输出 $\mathcal{T}^{(T)}(x) = t_T$（或 $t_1, \ldots, t_T$ 的某个确定性函数）。

关键观察：每一步仍是单次前向传播（$\in \text{TC}^0$），但步骤之间存在**顺序依赖**——第 $i$ 步的输入包含所有之前步骤的输出。这为模型引入了 $\text{TC}^0$ 不具备的**自适应深度**。

### 命题 4（CoT 扩展可计算性上界）

*陈述*：设 $\mathcal{T}$ 为任意固定深度 $O(\log n)$ 精度的 Transformer，$\mathcal{T}^{(T)}$ 为其 $T$ 步 CoT 展开。则：

$$
\begin{aligned}
T = O(1) &\implies \mathcal{T}^{(T)} \in \text{TC}^0 \\
T = O(\log n) &\implies \mathcal{T}^{(T)} \text{ 可计算所有 } \text{NC}^1 \text{ 中的函数} \\
T = O(\text{poly}(n)) &\implies \mathcal{T}^{(T)} \text{ 可计算所有 } \text{P} \text{ 中的函数}
\end{aligned}
$$

*证明*：

**第一行**（$T = O(1)$）：常数次 $\text{TC}^0$ 计算的复合仍是常数深度电路，故仍属于 $\text{TC}^0$。平凡。

**第二行**（$T = O(\log n) \implies \supseteq \text{NC}^1$）——电路切片论证：

1. 设 $f \in \text{NC}^1$，即 $f$ 可由深度 $O(\log n)$、大小 $\text{poly}(n)$、扇入 $\leq 2$ 的电路 $C$ 计算。
2. 将 $C$ 沿深度方向切分为 $O(\log n)$ 个**层片（slabs）**，每个层片包含常数层门。
3. 每个层片是常数深度、$\text{poly}(n)$ 大小的电路 $\implies$ 属于 $\text{AC}^0 \subseteq \text{TC}^0$。
4. Transformer 在每个 CoT 步骤中模拟一个层片：
   - 读取前一步的输出（编码为 token 序列中的先前 CoT 输出）
   - 执行一次前向传播（$\text{TC}^0$ 计算，足以模拟该层片）
   - 将结果写入下一个输出 token
5. $O(\log n)$ 个 CoT 步骤完成所有层片的模拟，故 $f$ 被 $\mathcal{T}^{(O(\log n))}$ 计算。

> [!NOTE]
> 步骤 4 需要 Transformer 的参数 $\theta$ 被适当训练以实现"模拟层片"的行为。命题 4 的断言是**存在性**的——存在参数 $\theta$ 使 $\mathcal{T}^{(T)}$ 计算给定的 $\text{NC}^1$ 函数。能否通过 SGD 训练实际找到这样的 $\theta$，是一个独立的（也更困难的）优化问题。

**第三行**（$T = O(\text{poly}(n)) \implies \supseteq \text{P}$）：

同理。$\text{P}$ 中的函数可由 $\text{poly}(n)$ 深度、$\text{poly}(n)$ 大小的电路计算。切分为 $\text{poly}(n)$ 个常数深度层片，每个层片 $\in \text{TC}^0$，由一个 CoT 步骤模拟。$\square$

### 与 Type I 和 Type II 的关系

命题 4 精确解释了 CoT 对 Type I 的缓解机制——**用序列长度换递归深度**：

| | 无 CoT | CoT ($T$ 步) |
|---|---|---|
| 有效计算深度 | $O(L) = O(1)$ | $O(L \cdot T)$ |
| 复杂度类 | $\text{TC}^0$ | $(\text{TC}^0)^T$ |
| $T = O(\log n)$ 时 | — | $\supseteq \text{NC}^1$（突破 Type I 上界） |

但这同时将问题转移到了 **Type II 的领地**：

- CoT 的每个步骤都是一次连续空间中的离散逻辑仿真。
- $T$ 步 CoT = $T$ 次连续-离散转换 = Type II 形式化中的 $k = T$ 步逻辑链。
- 当 $T$ 增大以突破 Type I 限制时，Type II 的累积误差 $\|\text{err}_T\|$ 同步增长。

这正是开放问题 1 中指出的 **Type I–II 对偶性**：CoT 用增加推理链长度的方式突破了深度限制，但代价是在连续空间中仿真更长的离散逻辑链——从而加剧了阻抗失配导致的累积误差。Tool Use 是同时解决 Type I 和 Type II 的唯一缓解路径。
