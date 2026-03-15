# 待审阅：从 §2.4 移出的 CAC 相关命题

> 这些命题原在 §2.4（$f$-链正交性）中，因其依赖 CAC 五项界（§3.1）和 SRB（§3.2），不属于 IDFS 内在性质，故移出。待在 CAC 章节审阅后决定是否保留/重写。
>
> **注意**：其中的"变分正交"概念已被重新定义为"像集正交"（$\mathrm{Im}_\sigma(q_A) \cap \mathrm{Im}_\sigma(q_B) = \varnothing$），原有的 $\mathrm{Cov}_{var}$ 已删除。这些命题的前提和证明可能需要重新审视。

---

**命题（路由跳变代价的正交降阶，Orthogonal De-escalation of Routing Mismatch Penalty）**：§3.1 CAC 五项精细界中的路由失准惩罚 $\Delta^{err}_j = d(\sigma(h_{j-1})(h_{j-1}),\, \sigma(h^*_{j-1})(h_{j-1}))$ 度量的是**两条不同 $f$-链在同一输入处的输出差异**。该罚项在误差界中的累积行为，取决于实际激活链 $\sigma(h_{j-1})$ 与理想激活链 $\sigma(h^*_{j-1})$ 的**变分正交性**。

设系统演化 $l$ 步，前 $l$ 步中存在 $n_{switch}$ 次路由跳变（$\sigma(h_{j-1}) \neq \sigma(h^*_{j-1})$，即实际轨道与理想轨道的路由决策分裂）。记第 $j$ 次跳变时，实际激活链 $q^{act}_j = \sigma(h_{j-1})$，理想激活链 $q^{ideal}_j = \sigma(h^*_{j-1})$，二者的**路由跳变向量**为 $\vec{\Delta}_j = q^{act}_j(h_{j-1}) - q^{ideal}_j(h_{j-1})$（在 $\mathcal{X} \subseteq \mathbb{R}^n$ 的局部切空间中）。则：

(i) **完全同向（最坏情形）**：若所有 $n_{switch}$ 次跳变的跳变向量 $\vec{\Delta}_j$ 均沿同一方向对齐（$\vec{\Delta}_j = |\vec{\Delta}_j| \cdot \vec{v}$），则经尾部乘积放大后的总路由惩罚为：

$$\sum_j \Delta^{err}_j \cdot \Theta_{j+1,l} \;=\; \sum_j |\vec{\Delta}_j| \cdot \Theta_{j+1,l} \;=\; \Delta_{max} \cdot \Lambda_l$$

退化为 CAC 形式 A 的最保守界。此情形与 推论 3.3（同向共线坍缩构造）完全同构——所有误差源坍缩于主特征射线。

(ii) **变分正交（统计改善）**：若各次路由跳变时 $q^{act}_j$ 与 $q^{ideal}_j$ 变分正交（$\mathrm{Cov}_{var}(q^{act}_j, q^{ideal}_j) = 0$），则跳变向量 $\vec{\Delta}_j$ 的方向在切空间中**统计无关**（不同跳变事件的形变方向独立）。由 §3.2 统计精化界（SRB），在 type-$p$ Banach 空间中，路由惩罚的累积总和从最坏的 $\mathcal{O}(\Delta_{max} \cdot \Lambda_l)$ 降阶为：

$$\left\|\sum_j \vec{\Delta}_j \cdot \Theta_{j+1,l}\right\| \;\sim\; \mathcal{O}\!\left(\Delta_{max} \cdot \Lambda_l^{1/p}\right)$$

当 $p = 2$（Hilbert 空间）时，降阶为 $\mathcal{O}(\Delta_{max} \cdot \sqrt{\Lambda_l})$——路由惩罚的有效累积速率从线性降至平方根。

**证明**：

(i) 由三角不等式在一维子空间的退化，同向量的范数之和等于和的范数。尾部乘积放大保持方向不变。

(ii) 路由跳变向量 $\vec{\Delta}_j$ 可视为由路由边界跨越事件引入的"噪声项"。变分正交保证了各跳变向量在切空间中方向独立。将 $\{\vec{\Delta}_j \cdot \Theta_{j+1,l}\}$ 视为零均值独立随机向量（均值为零是因为变分正交意味着形变方向无系统偏置），在 type-$p$ 空间中应用 type-$p$ 不等式（§3.2 定义），总和的 $p$-阶矩满足 $\mathbb{E}[\|\sum \vec{\Delta}_j \Theta_{j+1,l}\|^p] \leq T_p^p \sum \mathbb{E}[\|\vec{\Delta}_j \Theta_{j+1,l}\|^p] \leq T_p^p \Delta_{max}^p \sum \Theta_{j+1,l}^p$。由 Jensen 不等式或直接估计，$\sum \Theta_{j+1,l}^p \leq (\sum \Theta_{j+1,l})^p \cdot n_{switch}^{1-p} = \Lambda_l^p \cdot n_{switch}^{1-p}$，开 $p$ 次根并取 $n_{switch} \leq l$ 即得渐近阶。$\square$

> **注（正交降阶的物理含义与 §3.2 漂移-扩散定律的闭合）**：此命题揭示了路由跳变代价的双重性质——它既是 §3.1 CAC 的**确定性代数项**（最坏情形同向累积），又可以是 §3.2 SRB 的**随机扩散项**（正交散射），取决于系统 $f$-链空间的正交结构。在 §3.2 的漂移-扩散框架中，同向路由跳变对应纯粹的**系统漂移**（$\mu_{bias}$），正交路由跳变对应**随机扩散**（$\eta_{noise}$）。因此，**$f$-链正交性是将路由惩罚从漂移项"降级"为扩散项的精确数学机制**。

> **注（与 推论 5.5 的联动：正交性的反劫持新含义）**：推论 5.5 已证明变分正交在邻域劫持中提供侧向逃逸。当与路由惩罚的正交降阶联合时，正交性具有更深层的功能：在 §5 的劫持场景中，中间态 $h_1$ 进入 $r_B$ 的领地附近，$\Phi$ 在 $h_1$ 处选择的过渡链 $q_{transit}$ 若与 $r_B$ 的局部链 $q_{local}$ 变分正交，则不仅 $q_{local}$ 的形变不产生系统偏移（§5 原有结论），更关键的是，由此引发的路由跳变 $\Delta^{err}$ 在后续链路中以**扩散而非漂移**模式累积——劫持的"余震"不会沿主特征方向相干叠加，而是被正交方向分散。

---

**命题（$\Delta^{sam}$ 的结构正交消去，Structural Orthogonality Elimination of $\Delta^{sam}$）**：§3.1 CAC 五项精细界中的采样域路由失配项 $\Delta^{sam}_j = d(\sigma(h^*_{j-1})(x'_j),\; \sigma(x'_j)(x'_j))$ 度量的是：理想轨道所处位置 $h^*_{j-1}$ 的激活链与最近采样点 $x'_j$ 处的激活链，在 $x'_j$ 处的输出差异。该项在结构正交条件下**自动归零**。

设 $h^*_{j-1}$ 为理想轨道的第 $j-1$ 步中间态，$x'_j = \mathrm{argmin}_{x \in \mathcal{X}(r_{i_j})} d(h^*_{j-1}, x)$ 为其最近采样点，距离为 $\delta_j = d(h^*_{j-1}, x'_j)$。设 $\sigma(h^*_{j-1})$ 激活的 $f$-链 $q_A$ 与 $\sigma(x'_j)$ 激活的 $f$-链 $q_B$ 结构正交（算子集不交），且 $F$ 中各算子的像集在 Hausdorff 距离意义上具有正间距 $d_H > 0$。

则当 $\delta_j < d_H/L$ 时，$\sigma(h^*_{j-1}) = \sigma(x'_j)$——即 $h^*_{j-1}$ 与 $x'_j$ 必然位于同一路由分区内，从而 $\Delta^{sam}_j = 0$。

**证明**：由 §2.3 命题 2.7（路由分辨率极限），路由决策边界两侧的最小输入间距为 $\geq \Delta_{decision}/L$。在结构正交条件下，算子像集的 Hausdorff 正间距 $d_H > 0$ 意味着不同路由分区的输出像集在 $d_H$ 尺度上分离。由此，路由决策产生的宏观行为差异 $\Delta_{decision} \geq d_H$，因此路由边界到 $h^*_{j-1}$ 的最小距离 $\geq d_H/L$。当 $\delta_j = d(h^*_{j-1}, x'_j) < d_H/L$ 时，$h^*_{j-1}$ 与 $x'_j$ 不可能被路由边界分隔（否则违反分辨率极限），故 $\sigma(h^*_{j-1}) = \sigma(x'_j)$，$\Delta^{sam}_j = d(\sigma(h^*_{j-1})(x'_j), \sigma(x'_j)(x'_j)) = 0$。$\square$

> **注（$\Delta^{sam} = 0$ 的实际含义与局限）**：此命题表明，在算子像集充分分离的系统中，只要理想轨道的采样域偏离 $\delta_j$ 足够小（小于 $d_H/L$），采样域路由失配项自动消除。这为 Type B 系统提供了额外的精度优势——短链中 $\delta_j$ 被截断（命题 2.4 (i)），且 Type B 可通过增大 $M$ 来增加算子多样性和像集间距（$d_H$ 随 $M$ 增大趋于增加），两者协同使 $\Delta^{sam}$ 在 Type B 中几乎恒为零。然而在长链系统中，$\delta_j$ 因漂移累积可能远超 $d_H/L$，此消去条件不再成立——长链的采样域路由失配是结构性不可避免的。
