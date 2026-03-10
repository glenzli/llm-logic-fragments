# IDFC · Part 3：推论

> **前置**：本文建立在 [Part 2](part2-foundations.md) 和 [Part 2b](part2b-fspace-morphology.md) 的建模层之上。
> [Part 2b](part2b-fspace-morphology.md) 定义了 $F$-空间的三态形态学，是理解部分推论的必要背景。

> **前置**：本文建立在 [Part 2](part2-foundations.md) 的 CAC 定理之上（§2–3 的严格证明）。每个命题明确标注证明状态：
> - **严格推论**：从 CAC 定义直接可证，无额外假设
> - **条件性命题**：需要额外假设（已明确标注）
> - **开放猜想**：目前无证明路径
>
> **后续**：[Part 4](part4-empirical.md) 以多架构分析（Transformer、Mamba、MoE）与多组实验场景（幻觉分类、ICL 曲线、Reversal Curse、Sycophancy 等）验证并锚定本文推论。

---

## 文档索引

本文内容已按语义拆分为以下子文件：

| 文件 | 内容范围 | 主要节 |
|---|---|---|
| [**part3a-core-deductions.md**](./part3a-core-deductions.md) | 核心推论 | §4 行为推论 · §5 CAC 扩展严格推论 · §6 对齐脆弱性 · §7 条件性命题 · §8 框架边界 · §9 行为吸引子关系 · §10 开放问题 |
| [**part3b-hallucination.md**](./part3b-hallucination.md) | 幻觉分类 | §11 幻觉 CAC 统一分类（Type I/II/III）· §12 反思与自我精炼 |
| [**part3c-training-methods.md**](./part3c-training-methods.md) | 训练方法分析 | §13 知识蒸馏 · §14 RLHF / DPO · §15 量化（INT8/INT4/GPTQ）· §16 LoRA / PEFT |
| [**part3d-techniques.md**](./part3d-techniques.md) | 技术专题分析 | §17–§24：Tool Use、TTC / o1、RAG、Speculative Decoding、多模态、持续学习、ICL、Model Collapse |
