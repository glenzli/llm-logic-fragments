# 输入驱动函数复合（IDFC）：大语言模型的数学理论

> **核心主张**：LLM 在固定权重下，由输入通过激活函数 / 注意力机制动态组装一条输入特化的函数链路（$f$-chain）完成推理。一切已观测到的模型行为——涌现、顿悟、CoT 有效性、上下文学习、幻觉机制、对齐脆弱性——都是这个计算框架的自然推论。

如果这些推论与现实吻合，即为理论成立的证据。

---

## 文档地图

| 文件 | 内容 | 状态 |
|---|---|---|
| [**part1-model.md**](./part1-model.md) | 数学模型构造：$\mathcal{X}$、$\Omega$、$F$、CAC 定理、误差分析 | 核心理论 |
| [**part2-deductions.md**](./part2-deductions.md) | 行为推论：涌现、顿悟、CoT、能力聚簇、Scaling Law | 第一阶推论 |
| [**part3-extensions.md**](./part3-extensions.md) | CAC 扩展推论：能力上界、不可约性、对齐脆弱性、逆定理猜想 | 深层推论 |
| [**part4-attention.md**](./part4-attention.md) | Attention 泛函界：LiM 定义、最优检索保真度、$n_{\max}$ | **可观测接口** |

阅读顺序：`part1` → `part2` → `part3` → `part4`。

---

## 核心定理（CAC）

> 设 $F$ 为训练后模型的有效函数集，$R_{\text{tr}}$ 为训练中覆盖的逻辑原语，单步误差 $\varepsilon_{\max}$，Lipschitz 常数 $L$。对任意由 $R_{\text{tr}}$ 的 $l$ 步复合构成的未见任务 $q$：
>
> $$\|\hat{h}_l - q(x)\| \leq \varepsilon_{\max} \cdot \frac{L^l - 1}{L - 1}$$
>
> **组合是免费的，代价仅在误差随链长 $l$ 和 Lipschitz 常数 $L$ 增长。**

---

## 关键可观测预测（part4 的角色）

`part4-attention.md` 推导出：

- **最优检索保真度** $\mathcal{F}^*(n, d_k, B)$：注意力机制在 $n$ 个竞争位置中提取单个目标的信息论上界
- **最大可靠序列长度** $n_{\max}$：超过此长度后，注意力在信息论上无法达到精度要求 $\delta$
- **LiM 的算子定义**：Lost in the Middle 是 $f$-链路组装的局部失效，而非工程缺陷

这些预测原则上可通过实验验证，是理论与现实接轨的关键节点。

---

## 与其他模块的关系

- [`behavioral-attractors/`](../behavioral-attractors/) — IDFC 为行为吸引子的**存在性**提供基础；吸引子理论描述这些构型的**拓扑结构**
- [`hallucination/`](../hallucination/) — IV-a/IV-b 的现象级分析；`part4-attention.md` 提供其第一性原理基础
