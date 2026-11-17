# A0 portrait poster (LuaLaTeX + beamerposter + biblatex)

Windows + Git + VS Code + TeX Live 向けの英語の研究ポスター用プロジェクトです．添付されたポスターの**左側の番号＋大学ロゴ欄（約23%），右側の中央揃えタイトル・著者・所属欄（約77%），その直下の細い主要論文帯**という配置・寸法を参考にしています．配色の全面的な模倣ではなく配置を優先し，Section区切り線は通常・強調セクションで同じテーマ色に統一します．大学ロゴにはユーザー提供の背景透過PNGを使用しています．本文40 pt，A0縦長（841 × 1189 mm）です．

## 前提環境

- Windows 10/11，TeX Live（LuaLaTeX，beamerposter，biblatex，Biber，latexmk，fontspec，TikZ，Latin Modern）
- `latexmk` の実行に必要なPerl（通常はTeX Live Windows版に付属）
- Git，VS Code，LaTeX Workshop（推奨）

PowerShellで `where.exe lualatex`，`where.exe biber`，`where.exe latexmk` を確認します．フォントファイルは同梱していません．

## コンパイル

VS Codeでフォルダ全体を開いて `main.tex` をビルドします．LaTeX Workshopのレシピ `latexmk (LuaLaTeX + Biber)` が設定されています．PowerShellなら，プロジェクトルートで：

```powershell
latexmk -cd -lualatex -outdir=build main.tex
```

生成先は `build/main.pdf` です．同じ場所に `main.log`，`main.bcf`，`main.bbl` なども保存されます．VS Code の `LaTeX Workshop` では `latexmk (LuaLaTeX + Biber)` レシピを選択してください．レシピも `-outdir=%OUTDIR%` を明示しています．

**PDFが生成されないとき**：`latexmk -cd -lualatex -outdir=build main.tex` をルートで実行し，最初に表示される `!` または `Error` の内容を確認してください．コンパイルエラーの場合はPDFが生成されません．ログがあれば `build/main.log` を確認し，ファイルが存在しない場合は TeX Live の `latexmk`，`lualatex`，`biber`，`beamerposter`，`biblatex` が利用可能か確認してください．Windows PowerShellでは `where.exe latexmk`，`where.exe lualatex`，`where.exe biber` で実行ファイルを検査できます．GitHub上の既存の `main.pdf` があっても，最新のビルド結果ではありません．

完成PDFは `build/main.pdf`．中間ファイルの削除は `latexmk -c main.tex`．`.latexmkrc` がLuaLaTeXとBiberの再実行を制御します．

## ディレクトリ

```text
A0_Portrait_Poster/
├── main.tex                   # 全体レイアウトとセクションのinput順序
├── poster-config.tex          # 配色・文字サイズ・著者情報・余白等
├── posterstyle.sty            # 共通テーマとヘッダ・フッタ・引用
├── references.bib             # Biber用文献データ
├── .latexmkrc                 # Windows対応latexmk設定
├── .gitignore
├── .vscode/
│   ├── settings.json
│   └── extensions.json
├── documents/
│   ├── abstract.tex           # 全幅１段
│   ├── background.tex         # 左カラム
│   ├── methods.tex            # 左カラム
│   ├── results.tex            # 右カラム，淡色強調
│   └── conclusions.tex        # 右カラム
├── logos/
│   └── fukushima-university-logo.png  # 大学ロゴ
└── build/                    # コンパイル時に生成（Git管理外）
```

`build/` はコンパイル時に生成され，`.gitignore` で除外されます．既にリポジトリにあるルート直下の `main.pdf` はビルド生成物と区別してください．

## ヘッダ・主要論文・Section区切りの設定

- A0縦長（841 × 1189 mm）．全幅ヘッダのうち，主ヘッダ高さ **150 mm**，主要論文帯高さ **18 mm**，フッタ高さ **28 mm**．
- 主ヘッダは左約23%（ポスター番号の下に大学ロゴ），右約77%（タイトル，発表者，共著者，所属を中央揃え）の二領域．写真の**配置と相対寸法**を参考にしています．
- 主要論文帯は主ヘッダの直下に配置．`poster-config.tex` の `\\PosterFeaturedPaperKey` に `references.bib` の文献キーを設定します．引用書式は共通の `\\posterciteinline` を再利用し，`et al.`・雑誌名はイタリック，巻番号は太字とします．
- 本文は標準 **40 pt**，タイトル58 pt，発表者39 pt，共著者27 pt，所属24 pt．Section見出し44 pt．
- Section区切り線は通常の `block` と強調 `alertblock` の両方で `PosterAccent` を使用し，選択したカラーテーマに応じて統一します．
- 配色・文字サイズ・余白・各帯の高さは `poster-config.tex` で変更できます．既存の本文二段組・引用・フッタ形式は維持しています．

## 編集

1. **配色**：`poster-config.tex` の `\PosterColorTheme` を `navy`（添付見本に近い），`forest`，`slate` から選択．色定義は `posterstyle.sty` にあります．
2. **文字サイズ**：`\PosterFontLevel` は `compact`（36 pt），`standard`（40 pt），`large`（44 pt）．`\PosterTitlePt`，`\PosterBlockTitlePt` 等は同じ設定ファイル内で個別変更できます．
3. **タイトル・著者・主要論文**：`poster-config.tex`．ポスター番号は左側の明るい領域で大学ロゴの上，タイトルと著者・所属は右側の暗い領域で中央揃えです．その下の主要論文帯には `\\PosterFeaturedPaperKey` で指定した文献を表示します．
4. **本文**：`documents/*.tex`．**新しいセクションを追加した場合だけ**，`main.tex` の該当するカラム内に `\input{documents/new-section.tex}` を追加します．
5. **図**：必要に応じて `figures/` を作成して配置し，たとえば `\includegraphics[width=\linewidth]{figures/myplot.pdf}`．TeXの相対パスは常にルートの `main.tex` 基準です．
6. **セクション区切り**：`block` = 白地＋中央タイトル＋水平線，`alertblock` = 淡色背景の同形式．アクセント色はテーマで連動します．
7. **フッタ**：学会名・会場・日付・連絡先を `poster-config.tex` で設定．

## 引用

各セクションの本文の直後に `\postercite{aghanim2020}` と書きます．参考文献は `references.bib` に登録します．タイトルを除き，右寄せ・淡色・小さめで以下の表記になります：

`[Aghanim et al., A&A 641, A6 (2020)]`

`et al.` と雑誌名は *italic*，巻番号は **bold** です．`shortjournal` があれば雑誌略称として優先使用します．出版年は丸括弧，ページや論文番号は `eid` を優先します．書籍などの引用はこの形式に必ずしも適しません．

## ビルド前後の注意

- A0縦長1ページとして出力されることを `pdfinfo build/main.pdf` 等で確認してください．
- 大判beamerポスターは本文量に応じて自動的に縮小・改ページされません．**本文や図を追加したらフッタとの重複，文字のはみ出し，フォント埋め込みを確認**してください．
- 1行に入らないほど長い所属は自動で折り返す可能性があります．必要なら所属文字サイズか右カラムの幅を調整してください．
- Gitの初期化は `git init -b main`，`git add .`，`git commit -m "Initialize A0 poster"` です．既存リポジトリ内で使う場合は再初期化しません．
- 添付されたロゴの使用許諾・学会提出要件は使用者側で確認してください．
