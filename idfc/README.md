# 输入驱动函数复合（IDFC）：大语言模型的数学理论

> **核心主张**：LLM 在固定权重下，由输入通过激活函数 / 注意力机制动态组装一条输入特化的函数链路（$f$-chain）完成推理。一切已观测到的模型行为——涌现、顿悟、CoT 有效性、上下文学习、幻觉机制、对齐脆弱性——都是这个计算框架的自然推论。

如果这些推论与现实吻合，即为理论成立的证据。

---

## 文档结构（数学定理格式）

| 文件 | 角色 | 内容 |
|---|---|---|
| [**part1-intro.md**](./part1-intro.md) | **导论** | 问题动机、IDFC 主张（非正式）、理论预测一览、文档地图 |
| [**part2-model-proof.md**](./part2-model-proof.md) | **数学建模 + 定理证明** | 形式定义（$\mathcal{X}$、$\Omega$、$F$、$f$-chain）、CAC 定理严格陈述、完整证明 |
| **Part 3 推论**（按主题拆分） | | |
| ↳ [**part3a-core-deductions.md**](./part3a-core-deductions.md) | 核心推论 | §4–§10：行为推论、CAC 扩展推论、对齐脆弱性、条件性命题、框架边界、开放问题 |
| ↳ [**part3b-hallucination.md**](./part3b-hallucination.md) | 幻觉分类 | §11–§12：架构无关幻觉统一分类（Type I/II/III）、反思与自我精炼分析 |
| ↳ [**part3c-training-methods.md**](./part3c-training-methods.md) | 训练方法分析 | §13–§16：知识蒸馏、RLHF / DPO、量化（INT8/INT4/GPTQ）、LoRA / PEFT |
| ↳ [**part3d-techniques.md**](./part3d-techniques.md) | 技术专题分析 | §17–§25：Tool Use、TTC / o1、RAG、Speculative Decoding、多模态、持续学习、ICL、Model Collapse、F-空间三态分类 |
| **Part 4 理论验证**（按主题拆分） | | |
| ↳ [**part4a-transformer.md**](./part4a-transformer.md) | Transformer 实例化 | §1–§7：Transformer 组件的 IDFC 角色、Attention 泛函分析、LiM、$n_{\max}$、幻觉 Type IV |
| ↳ [**part4b-architectures.md**](./part4b-architectures.md) | 对比架构分析 | §8–§10：Diffusion、Mamba（SSM）、MoE 的 IDFC 解读与架构对比 |
| ↳ [**part4c-experiments.md**](./part4c-experiments.md) | 实验验证 | §11–§18：1.58-bit、整数加法、Reversal Curse、Needle、Grokking、GSM8K、Inverse Scaling、验证体系总览 |
| ↳ [**part4d-phenomena.md**](./part4d-phenomena.md) | 现象分析 | §19–§24：Sycophancy、Many-shot ICL、Activation Steering、角色漂移、随机标签 ICL、Mechanistic Interpretability |

> **原始文件保留**：`part3-deductions.md` 和 `part4-empirical.md` 继续保留为完整版本，各子文件为其语义分区的镜像拆分。

阅读顺序：`part1` → `part2` → `part3a` → `part3b` → `part3c` → `part3d` → `part4a` → `part4b` → `part4c` → `part4d`。

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
