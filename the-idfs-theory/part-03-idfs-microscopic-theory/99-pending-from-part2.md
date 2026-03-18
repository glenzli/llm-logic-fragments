## 待整合内容（从 Part 2 §5 迁入）

> 以下内容原为 Part 2 §5.2 推论 5.5，因依赖 f-链正交性（Part 3 微观概念），迁至 Part 3 待整合。

**推论（变分正交对邻域劫持的缓解，Mitigation of Neighborhood Hijacking via Variational Orthogonality）**：

命题 5.3 中劫持灾难的硬核条件是：中间态 $h_1$ **落入** $r_B$ 的采样域 $\mathcal{X}(r_B)$ 内——此时 $\Phi(h_1)$ 被采样约束硬性锁定，与 $\sigma$ 的路由选择无关（因为无论 $\sigma$ 选择哪条 $f$-链来计算 $\Phi(h_1)$，最终输出都是唯一的，且必须满足 $d(\Phi(h_1), r_B(h_1)) \leq \varepsilon_B$）。**在采样域绝对重合的情形下，变分正交无法提供任何拯救。**

但在实际系统中，命题 5.3 示例构造的精确重合是一个**零测度事件**。更常见的情形是：$h_1$ 落在 $\mathcal{X}(r_B)$ 的 $\varepsilon$-**邻域**中，但 $h_1 \notin \mathcal{X}(r_B)$。此时 $\Phi(h_1)$ 不直接受 $r_B$ 的采样约束控制——$\sigma$ 在 $h_1$ 处拥有**路由自由度**。劫持此时退化为**间接劫持**：由 Lipschitz 连续性，$\Phi(h_1)$ 被 $\Phi$ 在 $\mathcal{X}(r_B)$ 上的行为拉偏，拉偏幅度受限于 $L \cdot d(h_1, \mathcal{X}(r_B))$。

在此间隙中，$f$-链正交性提供了**结构性的侧向逃逸**：若 $\sigma$ 在 $h_1$ 处选择的 $f$-链 $q_{transit}$ 与 $r_B$ 在 $\mathcal{X}(r_B)$ 上所激活的 $f$-链 $q_{local}$ **变分正交**（$\mathrm{Cov}_{var}(q_{transit}, q_{local}) = 0$），则 $q_{local}$ 为拟合 $r_B$ 而产生的局部形变，在 $q_{transit}$ 的输出方向上**不产生系统性偏移**。途经链的误差从命题 5.3 的 $O(\Delta)$（绝对劫持）降至 $O(L\varepsilon)$（Lipschitz 自然传播），劫持被**从灾难性降级为常规误差积累**。

> **注（逃逸的条件与代价）**：侧向逃逸依赖两个前提：(i) $h_1$ 与 $\mathcal{X}(r_B)$ 之间存在非零间距（$\delta > 0$），为 $\sigma$ 的路由切分提供物理空间；(ii) $Im(\sigma)$ 中存在足够多的变分正交 $f$-链可供分配。前者由系统的单步近似精度 $\varepsilon$ 和链路的几何构型决定；后者由 $|F| = M$ 的函数集规模和路径 Lipschitz 跨度 $\kappa_\Phi$（§1.2）共同决定——$M$ 越大、$\kappa_\Phi$ 越高，$F^*$ 中可供动员的变分正交方向越多，系统在邻域间隙中实施"错峰路由"的能力越强。但当 $h_1$ 精确落入采样域（$\delta = 0$）时，逃逸空间归零，命题 5.3 的绝对劫持不可避免。
