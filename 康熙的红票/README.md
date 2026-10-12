# 康熙的红票：B5 LaTeX 工程

扫描书的可编辑重排版本。正文按章节维护，不再使用按扫描页拆分的 TeX 文件或逐行坐标排版。原书印刷页码保存在源码注释中，跨页段落标注范围。

## 项目结构

```text
main.tex                 主编译入口
preamble.tex             字体、行距、标题、目录、图表、注释及页脚样式
layout.tex               B5 纸张尺寸
chapters/                19 个部分、章节及附录文件
assets/
  figures/               17 张实际使用的插图
  tables/                4 张可编辑表格的 TeX 源码
  sources/               图片来源、原书页码映射、附录底本及参考资料
qa/                      当前校对记录与验证报告
tools/                   括号检查和项目验证脚本
scanned-version/         393 张原始扫描；仅供校对及扫描对照版使用
reference.tex            可选的扫描对照版入口
build/                   编译输出、本地恢复备份及历史资料，不纳入 Git
```

`assets/tables` 是正文编译依赖；`assets/sources` 保留溯源资料及附录中的本地 PDF 链接。移动文件时须同步修改正文引用和 `assets/sources/figure-inventory.json`。

## 编译

需要 XeLaTeX、xeCJK 和所用中文字体。Windows：

```powershell
./build.ps1
```

Linux / WSL：

```bash
bash build.sh
```

脚本默认只编译正文，运行三遍稳定目录及交叉引用，输出根目录的 `康熙的红票-B5重排.pdf`。需要扫描对照 PDF 时，另加 `-Reference`（PowerShell）或 `--reference`（Bash）；它依赖本地 `scanned-version/` 原图。

## 校对与验证

```text
python tools/check_brackets.py
python tools/verify_project.py
```

括号检查只使用 Python 标准库，覆盖圆括号、方括号、书名号及直角引号，排除 TeX 注释、公式和 URL。项目验证还需要 `pypdf`、`pypdfium2`，在成功编译后运行，检查资源引用、注号对应、文献编号、图表结构、B5 尺寸、页码及目录目标。

- `qa/bracket-corrections.json`：本轮 108 项括号及相关修正，含王颋生卒年、内层书名号和文献编号 218；文献 218 同时恢复独立条目排版。
- `qa/paper-confirmations.json`：用户纸书核对记录，包括第四章注 70。
- `qa/refactor-content-preservation.json`：章节归并前后正文比较记录。
- `qa/assets-organization.json`：资源迁移及文件校验记录。
- `qa/project-verification.json`、`qa/bracket-verification.json`：最近一次检查结果。

当前样式为 ISO B5（176 × 250 mm）、单面等边距、正文 1.5 倍行距；显式章、节编号，章名页脚靠左，连续页码靠右。目录包含节标题及重排页码；表内统一 9 磅，表题与表注随表排版。

正文 591 个语义注号与书后 591 条注释对应。结构和括号检查通过不代表全书文字已逐字校勘。

## 来源与恢复

原始扫描范围为 006–398。扫描 364–368（原书 349–353 页）使用用户指定的附录四替换文本，底本和 SHA-256 分别见 `assets/sources/appendix-four-replacement.md` 与 `assets/sources/conversion.json`。图片来源见 `assets/sources/image-sources.md`，原扫描与印刷页码映射见 `assets/sources/scan-page-map.csv`。

`build/before-project-refactor.zip` 保留重构前源码及图片；`build/legacy/` 保留旧工具、校对中间件和旧 PDF。这些属于历史资料，不是当前编译依赖；其进一步删除仍待用户选择。不要将旧迁移脚本重新用于当前工程。

`.gitignore` 排除编译输出、根目录生成 PDF、原始扫描及缓存；章节、有效资源、来源资料和当前校对记录保留在版本管理范围内。原始扫描继续保存在本地，不因忽略规则而删除。
