## 生成基约简与零样本泛化（从 §3 CAC 章节迁移）

> **来源**：原 `03-upper-bounds.md` 推论 3.8、3.9 及组合覆盖代价定义。
> **迁移原因**：生成基选择、覆盖代价优化属于目标分解与系统结构设计的范畴，与 CAC 误差上界的主线（定理 → 类紧性 → 安全深度 → 收敛性）正交。建议在微观结构或基扩展章节中展开。
> **注意**：原编号 3.8/3.9 在迁移后需重新分配。

---

**推论（生成基约简与零样本泛化，Generative Basis Reduction and Zero-Shot Generalization）**：取原目标真实法则全集 $R$ 的一个**生成基** $R_0 \subseteq R$，及其对应的微观采样集 $\mathcal{S}_0 \subset \mathcal{S}$。若系统 $\Phi$ 以均匀微观容差集 $\mathcal{E}_0 = \{\varepsilon_0\}$ 局部拟合了该生成基 $\mathcal{S}_0$。

对于任意我们没有显式训练并测试的"未见规则" $r_i \in R \setminus R_0$，只要它能够沿 $R_0$ 逻辑展开为一条分解路径 $r_i = r_{i_{d_i}} \circ \cdots \circ r_{i_1}$，那么由同构物理意义可知：未见规则 $r_i$ 在数学上彻底等价于由微观基集 $\mathcal{S}_0$ 诱导生成的宏观链集 $\mathcal{T}_{d_i}$ 中的某个**宏观链元素** $q_i$。

因此，根据 CAC 定理，系统必定能以由 $\mathcal{E}_0$ 跃迁出的**宏观容差** $\varepsilon^*_{q_i} \in \mathcal{E}^*_0$ 覆盖拟合这个未曾见过的复杂规则 $r_i$。即 $r_i$ 的泛化误差边界被严格锚定为：

$$\sup_{x \in \mathcal{X}(r_{i_1})} d\bigl(\Phi^{d_i}(x),\, r_i(x)\bigr) \;\leq\; \varepsilon^*_{q_i} \;=\; \bigl(\varepsilon_0 + \rho_{\max,i}^{\mathrm{path}} + \Delta_{\max,i}^{\mathrm{path}}\bigr) \cdot \Lambda_{d_i}^{\mathrm{path}} \;+\; \delta_{\max,i}^{\mathrm{path}} \cdot \Gamma_{d_i}^{\mathrm{path}}$$

取所有 $r_i \in R \setminus R_0$ 的上确界：

$$\varepsilon_{\max}^R \;\leq\; \max_{r_i \in R \setminus R_0} \Bigl(\bigl(\varepsilon_0 + \rho_{\max,i}^{\mathrm{path}} + \Delta_{\max,i}^{\mathrm{path}}\bigr) \cdot \Lambda_{d_i}^{\mathrm{path}} + \delta_{\max,i}^{\mathrm{path}} \cdot \Gamma_{d_i}^{\mathrm{path}}\Bigr)$$

**证明**：情形 1（$r \in R_0$）直接由假设满足。情形 2（$r_i \in R \setminus R_0$）见下方证明详展。$\square$

**证明详展（情形 2）**：设分解路径 $r_i = r_{i_{d_i}} \circ \cdots \circ r_{i_1}$，对任意 $x \in \mathcal{X}(r_{i_1})$：

- **$r$-链轨道**：$h_0^* = x$，$h_j^* = r_{i_j}(h_{j-1}^*)$，$h_{d_i}^* = r_i(x)$
- **$\Phi$-轨道**：$\hat{h}_0 = x$，$\hat{h}_j = \Phi(\hat{h}_{j-1})$

$e_j = d(\hat{h}_j,\, h_j^*)$，$e_0 = 0$。对第 $j$ 步，取 $x'_j \in \mathcal{X}(r_{i_j})$ 为距 $h^*_{j-1}$ 最近的采样域点（$d(h^*_{j-1}, x'_j) = \delta_j^{\mathrm{path}}$），套用 CAC 主定理的五项拆分级联即可：

$$e_j \;\leq\; L_j e_{j-1} \;+\; L_j \delta^{\mathrm{path}}_j \;+\; \Delta_{\sigma,j}^{\mathrm{path}} \;+\; \varepsilon_0 \;+\; \rho_j^{\mathrm{path}}$$

递推展开得 $e_{d_i} \leq \bigl(\varepsilon_0 + \rho_{\max,i}^{\mathrm{path}} + \Delta_{\max,i}^{\mathrm{path}}\bigr) \cdot \Lambda_{d_i}^{\mathrm{path}} + \delta_{\max,i}^{\mathrm{path}} \cdot \Gamma_{d_i}^{\mathrm{path}}$。对 $x$ 取上确界即得。$\square$

**含义（剖面策略）**：分解路径同时受到两套正交因子的约束：$\Lambda_{d_i}^{\mathrm{path}}$ 由路径 Lipschitz 结构决定（有效单步误差的级联放大）；$\delta_{\max,i}^{\mathrm{path}} \cdot \Gamma_{d_i}^{\mathrm{path}}$ 由路径的域覆盖质量决定（采样域偏离代价的独立放大）；同时，选择的路径还会切分目标自身的难度（决定 $\rho$）和系统经过该路径时的拓扑稳定性（决定 $\Delta_\sigma$）。
这里存在极其深刻的取舍：路径切得越碎（$d_i$ 很大），单步的目标可能越平缓导致 $\rho$ 和 $\varepsilon_0$ 减小，但 $\Lambda$ 往往随深度指数爆炸，且经过碎片的路由时大 $\Delta_\sigma$ 爆发的概率剧增。选择分解时须在这多维张力下联合优化。

**定义（组合覆盖代价，Compositional Coverage Cost）**：给定生成基 $R_0$，定义 $R$ 在 $R_0$ 下的 **（一般）组合覆盖代价**为：

$$\mathcal{C}^{\mathrm{gen}}(R, R_0) \;\triangleq\; |R_0| \;\times\; \max_{r_i \in R \setminus R_0} \Bigl(\bigl(\varepsilon_0 + \rho_{\max,i}^{\mathrm{path}} + \Delta_{\max,i}^{\mathrm{path}}\bigr) \cdot \Lambda_{d_i}^{\mathrm{path}} \;+\; \delta_{\max,i}^{\mathrm{path}} \cdot \Gamma_{d_i}^{\mathrm{path}}\Bigr)$$

其中两个因子各有明确含义：

- $|R_0|$：**直接拟合宽度**，即 $\Phi$ 须直接近似的基规则数量，决定采样对构造的规模代价；
- $\max_{r_i}(\cdots)$：**最坏派生误差**，即在所有非基规则中，通过分解路径传播后误差最大的那条——同时含有效局部失配的放大项（$(\varepsilon_0+\rho+\Delta_\sigma) \cdot \Lambda$）和采样域偏离代价项（$\delta \cdot \Gamma$）。

两者的乘积刻画了一种**覆盖效率的权衡**：$|R_0|$ 越大，直接近似的规则越多，采样对构造代价越高，但每条分解路径可以更短（$d_i$ 更小），从而 $\Lambda$ 更小、$\Delta_\sigma$ 触发几率更低；$|R_0|$ 越小则反之，派生路径更长，拓扑断裂代价与偏离代价均趋于爆炸。$\mathcal{C}^{\mathrm{gen}}$ 的最小化即在这两者间寻找最优的生成基大小与路径质量的平衡点。

> **理论基准（全纯相容，Holomorphic Compatibility）**：若所有分解路径不仅满足**域链相容**（$\delta_{\max,i}^{\mathrm{path}} = 0$），还满足**拓扑相容**（$\Delta_{\max,i}^{\mathrm{path}} = 0$）与**目标正则**（$\rho_{\max,i}^{\mathrm{path}} = 0$），则代价退化为最纯粹的代数形式：
>
> $$\mathcal{C}(R, R_0) \;\triangleq\; |R_0| \;\times\; \max_{r_i \in R \setminus R_0} \varepsilon_0 \cdot \Lambda_{d_i}^{\mathrm{path}}$$
>
> 此时代价仅由系统拟合底线 $\varepsilon_0$ 和拉伸系数 $\Lambda$ 决定。全纯相容在现实中极难精确满足（零偏离、零跳跃、零断裂），但作为**理论极值下界**，提供一个可量化的乐观基准。在全纯相容下进一步设 $L < \infty$，记 $d_{\max} = \max_i d_i$，保守界退化为：
>
> $$\varepsilon_{\max}^R \;\leq\; \varepsilon_0 \cdot \frac{L^{d_{\max}} - 1}{L - 1}$$

**推论（精度理论下界，Theoretical Precision Floor）**：设 $\Phi$ 对所有 $r_0 \in R_0$ 实现局部精度 $\varepsilon_0$，且分解路径满足上述全纯相容（即理论基准条件）。则任意生成基 $R_0$ 对应的覆盖精度不优于：

$$\varepsilon^* \;=\; \varepsilon_0 \cdot \min_{R_0 \;\text{生成}\; R}\; \max_{r_i \in R \setminus R_0} \Lambda_{d_i}^{\mathrm{path}}(R_0)$$

即 $\varepsilon^*$ 是在全纯相容理想化条件下，遍历所有生成基选择后的**最优精度下界**。在现实场景（含有 $\delta, \rho, \Delta_\sigma$）中，实际覆盖精度总满足 $\varepsilon_{\mathrm{actual}} \geq \varepsilon^*$，$\varepsilon^*$ 一般不可达，仅作为理论参照。

**证明**：直接由生成基约简推论的域链相容特例，对所有可行的 $R_0$ 取最优（最小化误差放大因子）即得。$\square$

----
*[IDFS] ⊢ [GLENZLI] ⊢ [Part XX] ⊢ [_temp_generative_basis] ⊢ [7dd756f91ded6557]*
