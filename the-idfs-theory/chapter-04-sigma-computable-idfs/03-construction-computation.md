## §3 构造与计算的统一

定理 2.3 证明了：对 $\sigma$-可计算系统 $(F, \sigma)$ 施加单次 $F^*$-算子 $\phi$，等效于替换函数库 $F \to F'$。本节将这一结论从单次推广到**任意有限次迭代**，并追问等效系统 $F'$ 的结构约束与极限。

### 3.1 迭代算子的折叠（Operator Folding）

**命题 3.1（算子折叠）**：设 $\phi_1, \phi_2, \dots, \phi_n \in F^*$。由 $F^*$ 对复合的封闭性，$\phi_{1:n} \triangleq \phi_n \circ \dots \circ \phi_1 \in F^*$。因此定理 2.3 直接适用：

**(a)** $(F, \sigma)$ 在 $\phi_{1:n}(x)$ 上的执行等价于 $(F, \sigma'_n)$ 在原始 $x$ 上的执行，其中：

$$\sigma'_n(x) = \sigma(\phi_{1:n}(x)) \circ \phi_{1:n}$$

**(b)** 若 $\mathcal{F}$ 满足 $\sigma$-可计算性，且 $\sigma \succeq \sigma'_n$，则由定理 2.1 进一步等价于 $(F'_n, \sigma)$ 在原始 $x$ 上的执行：

$$\Phi(\phi_{1:n}(x)) = \Phi_{F'_n}(x)$$

即在 $\sigma$-可计算且加细条件满足时，**无论在输入端堆叠多少层 $F^*$-算子，结果都可以被折叠为单一的函数库替换**——时间上的算子序列被空间上的架构变化拉平。

**证明**：$\phi_{1:n} \in F^*$，直接套用定理 2.3。$\square$

---

### 3.2 等效深度膨胀（Equivalent Depth Expansion）

算子折叠在代数上是无障碍的，但等效系统 $F'_n$ 的**内部结构**暴露了一个深刻的代价。

**命题 3.2（等效深度膨胀）**：等效路由 $\sigma'_n(x)$ 中的链深度满足：

$$|\sigma'_n(x)| = |\sigma(\phi_{1:n}(x))| + \sum_{i=1}^{n} |\phi_i|$$

其中 $|\sigma(\phi_{1:n}(x))| \le \mathcal{D}$ 为原始系统的执行深度，$|\phi_i|$ 为第 $i$ 个算子的链长。因此等效系统 $F'_n$ 中链的深度上界为：

$$\mathcal{D}'_n = \mathcal{D} + \sum_{i=1}^{n} |\phi_i|$$

**证明**：$\sigma'_n(x) = \sigma(\phi_{1:n}(x)) \circ \phi_n \circ \dots \circ \phi_1$。链深度为各段深度之和。$\sigma(\phi_{1:n}(x))$ 在原始系统中选出，深度 $\le \mathcal{D}$。$\square$

**推论 3.2.1（虚拟深度增益）**：等效系统 $F'_n$ 的链深度上界为 $\mathcal{D}'_n = \mathcal{D} + \sum|\phi_i|$，超过原始系统的深度预算 $\mathcal{D}$。从外部等效视角看，堆叠 $n$ 个输入算子使**等效系统**的深度预算增大了 $\sum|\phi_i|$。

> **注（内外视角的分裂）**：从系统**内部**看，执行深度始终是 $\mathcal{D}$——$\phi_i$ 是加在输入上的预处理，不消耗系统的内部深度预算。但从**外部等效**看，如果要用一个**没有输入预处理**的系统复现同样的输入-输出行为，所需链深度为 $\mathcal{D}'_n > \mathcal{D}$。两种视角的差值 $\sum|\phi_i|$ 正是输入算子贡献的**虚拟深度增益**。

---

### 3.3 折叠的约束边界

算子折叠与深度膨胀不是无限制可用的。存在三类结构性约束：

**约束 1：加细条件的退化**

定理 2.3(b) 要求 $\sigma \succeq \sigma'_n$。随着 $n$ 增长，$\sigma'_n$ 的分区可能变得比 $\sigma$ 更精细，导致加细条件失败。以下命题给出精确的充要条件。

**命题 3.3（分区相容性，Partition Compatibility）**：$\sigma \succeq \sigma'_n$ 成立当且仅当 $\phi_{1:n}$ 是 $\sigma$-**分区相容的**——即对 $\sigma$ 的每个分区 $X_q = \sigma^{-1}(q)$，$\phi_{1:n}$ 将其**整体**映入某一个分区：

$$\forall q \in \mathrm{Im}(\sigma),\;\exists\, q' \in \mathrm{Im}(\sigma):\; \phi_{1:n}(X_q) \subseteq X_{q'}$$

$q'$ 可以不等于 $q$（整个分区被移动到另一个分区是允许的），但同一分区内的不同点不能被映射到不同分区。

**证明**：$\sigma'_n(x) = \sigma(\phi_{1:n}(x)) \circ \phi_{1:n}$。由于 $\phi_{1:n}$ 固定，$\sigma'_n(x_1) = \sigma'_n(x_2)$ 当且仅当 $\sigma(\phi_{1:n}(x_1)) = \sigma(\phi_{1:n}(x_2))$。

$(\Rightarrow)$ 设 $\sigma \succeq \sigma'_n$，取 $x_1, x_2 \in X_q$（$\sigma(x_1) = \sigma(x_2) = q$）。则 $\sigma(\phi_{1:n}(x_1)) = \sigma(\phi_{1:n}(x_2))$，即 $\phi_{1:n}(x_1)$ 与 $\phi_{1:n}(x_2)$ 在同一分区中。由 $x_1, x_2$ 的任意性，$\phi_{1:n}(X_q)$ 整体落入单一分区。

$(\Leftarrow)$ 设 $\phi_{1:n}$ 分区相容。若 $\sigma(x_1) = \sigma(x_2) = q$，则 $\phi_{1:n}(x_1), \phi_{1:n}(x_2) \in X_{q'}$，因此 $\sigma(\phi_{1:n}(x_1)) = \sigma(\phi_{1:n}(x_2)) = q'$，即 $\sigma'_n(x_1) = \sigma'_n(x_2)$。$\square$

**推论 3.3.1（膨胀导致相容性失败的充分条件）**：设 $\sigma$ 的分区 $\{X_q\}$ 中，最小分区间距为 $\Delta_\sigma = \min_{q \neq q'} d(X_q, X_{q'})$，最大分区直径为 $\delta_\sigma = \max_q \mathrm{diam}(X_q)$。若

$$L_{\phi_{1:n}} \cdot \delta_\sigma > \Delta_\sigma + \delta_\sigma$$

即 $\phi_{1:n}$ 将某分区的像撑大到超过"分区直径 + 分区间距"，则分区相容性**不保证**成立。

反之，若 $\phi_{1:n}$ 为收缩映射（$L_{\phi_{1:n}} < 1$），则 $\phi_{1:n}(X_q)$ 的直径 $\le L_{\phi_{1:n}} \cdot \delta_\sigma < \delta_\sigma$，像的尺寸缩小，分区相容性**更易**但不保证满足（取决于像的位置是否跨越分区边界）。

> **注（分区相容性的几何含义）**：分区相容性的成败不仅取决于 $\phi_{1:n}$ 的 Lipschitz 常数，还取决于 $\sigma$ 的分区几何——分区的大小、形状与间距。在 $\sigma$-可计算系统中，分区边界由 $q_\sigma$ 的水平集决定（§2 定理 2.1 注记），因此分区相容性最终受 $q_\sigma$ 的判别力与 $\phi_{1:n}$ 的变形程度共同约束。

**约束 2：Lipschitz 链的收缩-膨胀平衡**

对每个 $x$，$\sigma'_n(x)$ 是一条确定的 $F^*$-链，其 Lipschitz 常数为：

$$L_{\sigma'_n(x)} = L_{\sigma(\phi_{1:n}(x))} \cdot \prod_{i=1}^{n} L_{\phi_i}$$

取全局上界，设 $L_{\max} = \max_{q \in \mathrm{Im}(\sigma)} L_q$（原始系统中所有可选链的最大 Lipschitz 常数），则：

$$\sup_x L_{\sigma'_n(x)} \le L_{\max} \cdot \prod_{i=1}^{n} L_{\phi_i}$$

**命题 3.4（Lipschitz 平衡约束）**：
- 若 $\phi_i$ 全为收缩映射（$L_{\phi_i} < 1$），则 $\sup_x L_{\sigma'_n(x)} \le L_{\max} \cdot \prod L_{\phi_i} \to 0$，等效链趋向常值映射——**过度收缩使构造退化为常数程序**。
- 若 $\phi_i$ 含膨胀算子（$L_{\phi_i} > 1$），则 $\prod L_{\phi_i}$ 指数增长，等效链对 $x$ 的灵敏度爆炸——**过度膨胀使构造丧失稳定性**。

有效的迭代构造要求 $\prod L_{\phi_i}$ 保持在某个有界区间内。

**约束 3：路由容量的硬性天花板**

无论堆叠多少个 $\phi_i$，等效系统 $(F'_n, \sigma)$ 的路由仍然是同一个 $\sigma$。由第一章的路由容量限制（命题 2.1），$|\mathrm{Im}(\sigma)|$ 有绝对上界。因此，$F'_n$ 中可被路由访问的**不同链的数量**不随 $n$ 增长——等效系统的**程序多样性**被锁死。

但需注意：虽然 $|F'_n| = |\mathrm{Im}(\sigma)|$ 恒定，$F'_n$ 中每条链的**内容**（深度、Lipschitz 行为）随 $n$ 持续变化——$h_n(q) = \sigma(\phi_{1:n}(\cdot)) \circ \phi_{1:n}$ 依赖于 $\phi_{1:n}$。程序的**种类数**不变，但每种程序的**复杂度**在演化。

> **注（深度 vs 多样性的不对称）**：虚拟深度 $\mathcal{D}'_n$ 随 $n$ 线性增长，但程序多样性 $|\mathrm{Im}(\sigma)|$ 恒定。堆叠算子可以使每条等效链更深（更复杂的单次操作），但不能使系统访问更多种类的链。这是构造能力的根本瓶颈。

---

### 3.4 三态形态在等效空间中的表现

第二章定义的三种拟合形态——Fact Fitting（拓扑盆地）、Logic Fitting（复合稳定带）、Verbatim Fitting（Dirac 针）——在等效空间 $F'_n$ 中呈现不同的响应特征。

**Fact Fitting（收缩态，$J \to 0$）**：
$\phi_i$ 为收缩算子时，$\phi_{1:n}(x)$ 趋向不动点。路由 $\sigma(\phi_{1:n}(x))$ 在足够多的迭代后锁定到常值——等效系统 $F'_n$ 坍缩为**单链系统**。虚拟深度虽然增长，但等效链最终趋向一条固定链的延长。这是 Fact Fitting 的代数签名：**算子堆叠的边际效应趋零**。

**Logic Fitting（保距态，$J \approx 1$）**：
$\phi_i$ 为近保距算子时，$\prod L_{\phi_i} \approx 1$，等效链的 Lipschitz 常数稳定。分区内映射条件容易维持（$\phi_{1:n}$ 不大幅移动点的相对位置）。等效系统 $F'_n$ 的结构随 $n$ **平稳演化**——每个 $\phi_i$ 贡献的虚拟深度被有效利用，不浪费在收缩坍缩或膨胀失控上。这是 Logic Fitting 的代数签名：**算子堆叠效率最高的体制**。

**Verbatim Fitting（膨胀态，$J \to \infty$）**：
$\phi_i$ 含高膨胀算子时，$\prod L_{\phi_i}$ 指数增长。$\phi_{1:n}$ 将 $\sigma$-分区内的点剧烈拉散，加细条件迅速失败。等效系统 $(F'_n, \sigma)$ 不再合法存在——定理 2.3(b) 的前提崩塌。这是 Verbatim Fitting 的代数签名：**算子折叠的代数等效性本身被破坏**，系统不得不在每步执行时实时计算路由，不可被任何静态函数库预先吸收。
