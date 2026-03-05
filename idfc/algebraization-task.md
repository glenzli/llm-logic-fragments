# 代数实例化工作进度（存档/重启用）

> **计划文档**：`idfc/algebraization-plan.md`（包含全部数学基础和写作规范）
> **任务性质**：为 IDFC 框架补充「代数实例化层」——当 f 落地到 Transformer 线性代数时，所有核心量（L/ε/d/R*/语义）的精确精化

---

## 任务总览

```
[x] A-1: part2c §26 — 泛函层→代数层的核心量映射总表
[x] A-2: part2c §27 — CAC 定理的代数紧化（残差结构下 e^{lλ}）
[x] A-3: part2c §28 — Type III 双层 Welch（路由维度 d_k + 表示维度 d）
[x] A-4: part2c §29 — 三态分类的代数可测化（W_V 范数条件）
[x] A-5: part2c §30 — 语义的残差流线性代数表示
[x] A-6: part2c §31 — UAT 的 Transformer 扩展（上下文→图灵完备）
[x] B:   part2b       — 三态定义末增加代数充要条件（推论 B-1/B-2/B-3）
[x] C:   part3a       — §5.1/5.2/7.2 末增加代数精化推论（推论 C-1/C-2/C-3）
[x] D:   part3b       — §11.3 Type III 增加双层 Welch 代数结构（推论 D-1/D-2）
[x] E:   part4a       — Attention/残差分析处增加 Lipschitz 代数计算（推论 E-1/E-2）
[x] F:   part2-foundations — 索引增加 part2c 条目
```

**执行顺序**：F → A（分三个会话）→ B → C → D → E

---

## 进度

| 任务 | 状态 | 完成会话 | 备注 |
|---|---|---|---|
| A-1 | ✅ | f5ab190e（上次）| §26 映射总表 |
| A-2 | ✅ | f5ab190e（上次）| §27 CAC 紧化（残差 e^{lλ}、LayerNorm TSC、ε Zipf）|
| A-3 | ✅ | 474e135d | §28 双层 Welch（命题 28.1/28.2/28.3）|
| A-4 | ✅ | 474e135d | §29 三态 W_V 范数条件（命题 29.1–29.3 + 推论 29.3a）|
| A-5 | ✅ | 474e135d | §30 语义叠加（命题 30.1/30.2 + Zipf 分层表）|
| A-6 | ✅ | 474e135d | §31 UAT 扩展（命题 31.1/31.2 + 推论 31.2a/b/c）|
| B | ✅ | 474e135d | 推论 B-1（三态代数条件）/ B-2（W_V SVD 检测）/ B-3（W_K 共享方向）|
| C | ✅ | 474e135d | 推论 C-1（l_max 紧化）/ C-2（误差权重分解）/ C-3（Zipf→幂律来源）|
| D | ✅ | 474e135d | 推论 D-1（双层 Welch 表格）/ D-2（分层缓解策略）|
| E | ✅ | 474e135d | 推论 E-1（Attention Lipschitz 公式）/ E-2（残差 e^{Kλ} 公式）|
| F | ✅ | f5ab190e（上次）| part2-foundations.md 索引已包含 Part 2c 条目 |

**Commit**: `c059b9a` — 5 files changed, 585 insertions(+)

---

## 重启说明

**所有任务均已完成。** 代数实例化层工作完整结束。

若需继续扩展，可考虑：
- Part 4a §2–§7 处增加更多对 Part 2c 的引用（目前仅在 §1.4/§1.5 增加了推论 E-1/E-2）
- 新建 `part2c-appendix.md` 作为推导细节补充
- 实验验证文档（part4c）中增加 §29 三态 W_V 范数检测的具体实验方案
