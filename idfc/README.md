# 输入驱动函数复合（IDFC）：大语言模型的数学理论

> **核心主张**：LLM 在固定权重下，由输入通过激活函数 / 注意力机制动态组装一条输入特化的函数链路（$f$-chain）完成推理。一切已观测到的模型行为——涌现、顿悟、CoT 有效性、上下文学习、幻觉机制、对齐脆弱性——都是这个计算框架的自然推论。

如果这些推论与现实吻合，即为理论成立的证据。

---

## 文档结构（数学定理格式）

| 文件 | 角色 | 内容 |
|---|---|---|
| [**part1-intro.md**](./part1-intro.md) | **导论** | 问题动机、IDFC 主张（非正式）、理论预测一览、文档地图 |
| [**part2-model-proof.md**](./part2-model-proof.md) | **数学建模 + 定理证明** | 形式定义（$\mathcal{X}$、$\Omega$、$F$、$f$-chain）、CAC 定理严格陈述、完整证明 |
| [**part3-deductions.md**](./part3-deductions.md) | **推论** | 全部 CAC 推论（严格推论 → 条件性命题 → 开放猜想） |
| [**part4-empirical.md**](./part4-empirical.md) | **理论验证** | 理论预测的实证推导（当前：Attention 泛函界、LiM、$n_{\max}$） |

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

`part4-empirical.md` 是理论预测的**实证验证层**——将 Part 3 的抽象推论推导为可实验验证的可观测量。

当前验证案例（Attention 泛函界）给出：
- **最优检索保真度** $\mathcal{F}^*(n, d_k, B)$：注意力机制信息提取的信息论上界
- **最大可靠序列长度** $n_{\max}$：超过此长度后，注意力在信息论上无法达到精度要求 $\delta$
- **LiM 的算子定义**：Lost in the Middle 是 $f$-链路组装的局部失效，而非工程缺陷

---

## 与其他模块的关系

- [`behavioral-attractors/`](../behavioral-attractors/) — IDFC 为行为吸引子的**存在性**提供基础；吸引子理论描述这些构型的**拓扑结构**
- [`hallucination/`](../hallucination/) — IV-a/IV-b 的现象级分析；`part4-empirical.md` 的 Attention 分析提供其第一性原理基础
