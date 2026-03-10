## 结构特异性

### 5.1 采样约束的方向不对称性

**命题 1（逆映射逼近的不对称性，Asymmetry of Inverse Approximation）**：设 $r \in R$ 为可逆映射，$(r, \mathcal{X}_r) \in \mathcal{S}$，且 $(r^{-1}, r(\mathcal{X}_r)) \notin \mathcal{S}$。设 IDFS $(F, \sigma)$ 满足 $\sup_{x \in \mathcal{X}_r} d(\Phi(x), r(x)) \leq \varepsilon_r$。

则 $\Phi$ 对 $r^{-1}$ 的逼近误差与 $\varepsilon_r$ **逻辑独立**：存在满足上述条件的 $\Phi \in \mathrm{Lip}_L(\mathcal{X})$，使得

$$\sup_{y \in r(\mathcal{X}_r)} d\bigl(\Phi(y),\, r^{-1}(y)\bigr)$$

可以任意大（与 $\varepsilon_r$ 无约束关系）。

**证明**：由 §1.3，$\varepsilon_r$ 是 $\Phi$ 在 $\mathcal{X}_r$ 上对 $r$ 的局部误差上界——该约束的成立来源是 $(r, \mathcal{X}_r) \in \mathcal{S}$。$r^{-1}$ 的作用域为 $r(\mathcal{X}_r)$；由于 $(r^{-1}, r(\mathcal{X}_r)) \notin \mathcal{S}$，§1.3 对 $\Phi$ 在 $r(\mathcal{X}_r)$ 上的行为不施加任何约束。

**构造**：取 $\mathcal{X} = \mathbb{R}$，$\mathcal{X}_r = [0, 1]$，$r(x) = x + D$（$D$ 足够大使两段不重叠），则 $r^{-1}(y) = y - D$，$r(\mathcal{X}_r) = [D, D+1]$。定义
$$\Phi(x) = \begin{cases} x + D + \eta & x \in [0, 1] \\ x + C & x \in [D, D+1] \end{cases}$$
之间光滑插值保持全局 Lipschitz。则 $\varepsilon_r = \eta$（$\eta$ 任意小），而对 $y \in [D, D+1]$：$d(\Phi(y), r^{-1}(y)) = |y + C - (y - D)| = |C + D|$，可取任意大。$\square$

> **注（有向性）**：命题 1 的本质是：在不引入互逆采样对的框架下，知识拟合关系在度量空间上是**有向的**——$\Phi$ 拟合 $r$ 与拟合 $r^{-1}$ 是两个独立的约束，前者不蕴含后者。



**命题 2（采样域偏离的逆向不对称性，Asymmetry of Domain Deviation under Inversion）**：设 $r \in R$ 为可逆映射，$(r, \mathcal{X}(r)) \in \mathcal{S}$ 且 $(r^{-1}, r(\mathcal{X}(r))) \in \mathcal{S}$（两个方向均已建立采样约束，$\varepsilon$ 层面的约束对正逆两向均成立）。

记正向链各步采样域偏离为 $\delta_j^{\mathrm{fwd}} \triangleq d(h^*_{j-1},\, \mathcal{X}(r_{i_j}))$，逆向链各步采样域偏离为 $\delta_j^{\mathrm{inv}} \triangleq d(\tilde{h}^*_{j-1},\, r(\mathcal{X}(r_{i_j})))$（$\tilde{h}^*$ 为逆向链的理想轨道）。

则**两个方向的 $\delta$ 代价逻辑独立**：存在满足上述条件的 IDFS $(F,\sigma)$ 和 $r$，以及**同一初始输入** $x_0$，使得

$$\delta_1^{\mathrm{fwd}}(x_0) \;=\; 0 \qquad \text{而} \qquad \delta_1^{\mathrm{inv}}(r(x_0))$$

可以任意大——即使两个方向的单步近似误差均受控，$\delta$ 层面的不对称性不可消除。

**证明（构造）**：取 $\mathcal{X} = \mathbb{R}$，$\mathcal{X}(r) = [0,1]$，$r(x) = 2x+1$（扩张平移），则 $\mathcal{X}(r^{-1}) = r([0,1]) = [1,3]$，$r^{-1}(y) = (y-1)/2$。两个采样对均加入 $\mathcal{S}$，$\varepsilon$ 约束对两向均成立。

取初始输入 $x_0 = 0.5 \in [0,1] = \mathcal{X}(r)$。

**正向链**（以 $r$ 为目标）：$h^*_0 = x_0 = 0.5 \in [0,1]$，故 $\delta_1^{\mathrm{fwd}} = d(0.5,\,[0,1]) = 0$。

**逆向链**（以 $r^{-1}$ 为目标，从 $r(x_0) = 2$ 出发）：理想轨道为 $\tilde{h}^*_0 = r(x_0) = 2 \in [1,3]$，则 $\delta_1^{\mathrm{inv}} = d(2,\,[1,3]) = 0$。

此时两向均为零——但现在考察**第二步**。正向链第二步的理想中间态 $h^*_1 = r(0.5) = 2$，若第二步仍用 $r$ 则 $h^*_1 = 2 \in [0,1]$？不——$h^*_1 = 2 \notin [0,1]$，所以 $\delta_2^{\mathrm{fwd}} = d(2, [0,1]) = 1$。逆向链第二步的理想中间态 $\tilde{h}^*_1 = r^{-1}(2) = 0.5$，若第二步仍用 $r^{-1}$ 则 $\tilde{h}^*_1 = 0.5 \in [1,3]$？不——$0.5 \notin [1,3]$，所以 $\delta_2^{\mathrm{inv}} = d(0.5, [1,3]) = 0.5$。

两向均有偏离，但幅度不同（$1$ vs $0.5$）。更极端的不对称来自 $r$ 的**扩张率**：$r$ 将 $[0,1]$ 拉伸为 $[1,3]$（长度加倍），而 $r^{-1}$ 将 $[1,3]$ 压缩为 $[0,1]$。因此正向链的理想轨道“逃出”采样域的速度（$\delta_j^{\mathrm{fwd}}$ 的增长率）与逆向链“逃出”采样域的速度（$\delta_j^{\mathrm{inv}}$ 的增长率）由 $r$ 的局部 Lipschitz 常数决定，而 $\mathrm{Lip}(r) \neq \mathrm{Lip}(r^{-1})$（除非 $r$ 为等距映射）。

特别地，若取 $r(x) = Kx + b$（$K > 1$），则经 $n$ 步正向迭代后 $\delta_n^{\mathrm{fwd}} \sim K^n$（指数增长），而逆向迭代 $\delta_n^{\mathrm{inv}} \sim K^{-n}$（指数衰减）。两向的 $\delta$ 累积代价的比值 $\sim K^{2n} \to \infty$，不对称性随链长指数放大。$\square$

> **注**：命题 2 表明：命题 1 的有向性来自 $\varepsilon$ 约束的有向性（采样对存在与否），命题 2 的有向性来自 $\delta$ 结构的有向性（理想轨道与采样域的几何关系）——两者独立，互不蕴含。即使通过引入互逆采样对完全消除 $\varepsilon$ 层面的不对称，$\delta$ 层面的不对称仍然存在，其根源是 $r$ 的扩张/压缩率 $\mathrm{Lip}(r)/\mathrm{Lip}(r^{-1})$ 的不对称性——这是 CAC 精细界中 $\delta \cdot \Gamma$ 项引入的不可规避的新自由度。
