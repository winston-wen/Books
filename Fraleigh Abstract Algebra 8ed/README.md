# Fraleigh 第八版 LaTeX 重排

按原书 0–49 编号单元拆为 50 篇，每篇可独立编译。原 PDF 前 17 页放入 front_matter.tex；Notation 与 Index 合并到 notations_and_index.tex。附录、书目、习题答案分别保留，共 55 篇章节及前后文。main.tex 汇总全书，preamble.tex 提供共用排版。

原 PDF 共 449 页，删除 16 页标有“intentionally left blank”的白页，保留 433 个来源页的内容。重排 PDF 共 612 页；原 PDF 保持不变。

## 编译与编辑

在 WSL 中进入此目录，运行：

```bash
bash build.sh
```

单章例如：

```bash
bash build.sh 06_cyclic_groups
```

全书输出为 Fraleigh-retypeset.pdf，单章 PDF 位于 build/。需要 XeLaTeX、TeX Gyre 字体与常用 LaTeX 宏包；本次已在 WSL Linux 中编译验证。

直接编辑相应 tex 文件即可。数学内容为可编辑 LaTeX；assets/ 保留封面、曲线及原书图形，请与源文件一起保存。source-page-map.csv 提供原 PDF 页、印刷页与重排页的对应关系，源文件内也保留来源页注释及定位锚点。

## 排版

- B5 单面，正文左右边距均为 22 mm，上边距 20 mm，下边距 22 mm。
- 页眉移到页脚左侧，页码置于页脚右侧。
- 正文取消旁注悬挂区。Definition、Example、Theorem 等标签从正文左边界开始，与正文留有明确间距；续行回到同一左边界。
- 标题保留正常大小写，不使用小大写。标题、声明、证明、列表与原书图表风格尽量对应。
- 表题与表体、图与图题置于同一个不可拆页的排版块。
- 页脚注绑定到正文中的相应标记；多行计算采用公式自然高度，集合构造条件用关系符号 mid。
- 50 个编号单元各有唯一的习题标题；恢复曾被误识别为标题的习题说明正文。
- 共 55 个全书书签。前言用罗马页码，正文从 1 开始。

- 索引按原书三列顺序读取，符号表按符号与解释两栏对齐。

## 转换与校核

转换仅使用 WSL 的 Linux MinerU CPU 后端，结合 PDF 文字层、嵌入字体字形和坐标逆向数学源代码。缓存包含 14,037 个简单公式候选的原生重建，以及 808 个复杂公式候选的模型识别结果。候选数量不等于人工逐式校对数量。

55 篇独立编译与全书编译均通过；433 个来源页锚点完整，743 个原文声明标签无遗漏。已核对本轮批注与同类结构问题、图表标题同页、脚注位置、公式行距、标题与边距。复杂公式仍宜在使用时借助来源页对应表与原书复核。

## 文件

| 用途 | 文件 |
| --- | --- |
| 全书入口 | main.tex |
| 共用排版 | preamble.tex |
| 原 PDF 前 17 页 | front_matter.tex |
| 编号单元 0–49 | 00_*.tex 至 49_*.tex |
| 矩阵附录 | appendix_matrix_algebra.tex |
| 书目 | bibliography.tex |
| 习题答案 | answers.tex |
| Notation 与 Index | notations_and_index.tex |
| 页码对应 | source-page-map.csv |
| 结果与验证信息 | Fraleigh-retypeset.pdf、conversion-summary.json |
