# IDFC · Part 4：理论验证

> **定位**：本文是 IDFC 理论的**验证层**。[Part 2](part2-model-proof.md) 建立了 CAC 定理，[Part 3](part3-deductions.md) 推导了全部推论。本文以多种架构和实验场景为验证对象，将理论预测落地为可实验验证的可观测量。
>
> **可观测接口**：本文的结论（$\mathcal{F}^*$、$n_{\max}$、功能阈值 $\alpha^*$ 等）均可通过实验直接验证，是 IDFC 理论与现实接轨的关键节点。本文也是 [`../hallucination/type-iv-attention-dilution.md`](../hallucination/type-iv-attention-dilution.md) 现象级分析的第一性原理基础层。

---

## 文档索引

本文内容已按语义拆分为以下子文件：

| 文件 | 内容范围 | 主要节 |
|---|---|---|
| [**part4a-transformer.md**](./part4a-transformer.md) | Transformer 实例化 | §1 Transformer 组件 IDFC 角色 · §2 Attention 泛函基础设定 · §3 LiM 公式化 · §4–§5 最优信息提取界 · §6 与 type-iv 的连接 · §7 幻觉 Type IV（Transformer 专有） |
| [**part4b-architectures.md**](./part4b-architectures.md) | 对比架构分析 | §8 Diffusion · §9 Mamba（SSM）· §10 MoE |
| [**part4c-experiments.md**](./part4c-experiments.md) | 实验验证 | §11 1.58-bit 实验接口 · §12 整数加法长度泛化 · §13 Reversal Curse · §14 Needle in a Haystack · §15 Grokking · §16 GSM8K/MATH 分层 · §17 Inverse Scaling · §18 验证体系总览 |
| [**part4d-phenomena.md**](./part4d-phenomena.md) | 现象分析 | §19 Sycophancy · §20 Many-shot ICL · §21 Activation Steering · §22 长对话角色漂移 · §23 随机标签 ICL · §24 Mechanistic Interpretability 与 IDFC |
