# A0 portrait poster (LuaLaTeX + beamerposter + biblatex)

Windows + Git + VS Code + TeX Live 向けの英語の研究ポスター用プロジェクトです．添付されたポスターの**濃紺のヘッダ・フッタ，中央揃えの見出し＋水平罫線，淡い色の強調セクション**を参考にしています．大学ロゴにはユーザー提供の背景透過PNGを使用しています．本文40 pt，A0縦長（841 × 1189 mm）です．

## 前提環境

- Windows 10/11，TeX Live（LuaLaTeX，beamerposter，biblatex，Biber，latexmk，fontspec，TikZ，Latin Modern）
- `latexmk` の実行に必要なPerl（通常はTeX Live Windows版に付属）
- Git，VS Code，LaTeX Workshop（推奨）

PowerShellで `where.exe lualatex`，`where.exe biber`，`where.exe latexmk` を確認します．フォントファイルは同梱していません．

## コンパイル

VS Codeでフォルダ全体を開いて `main.tex` をビルドします．LaTeX Workshopのレシピ `latexmk (LuaLaTeX + Biber)` が設定されています．PowerShellなら，プロジェクトルートで：

```powershell
latexmk main.tex
```

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
├── .gitattributes
├── .editorconfig
├── .vscode/
│   ├── settings.json
│   └── extensions.json
├── documents/
│   ├── abstract.tex           # 全幅１段
│   ├── background.tex         # 左カラム
│   ├── methods.tex            # 左カラム
│   ├── results.tex            # 右カラム，淡色強調
│   ├── conclusions.tex        # 右カラム
│   └── README.md
└── figures/
    ├── fukushima-university-logo.png  # 添付ロゴ
    └── README.md
```

`build/` はコンパイル時に生成され，`.gitignore` で除外されます．

## 今回の調整：コンパクトなヘッダと統一した見出し余白

- ヘッダ高さ **222 mm (v2) → 142 mm**，フッタ高さ **51 mm (v2) → 28 mm**．帯の横幅はA0用紙の全幅を維持します．
- タイトル **82 pt (v2) → 58 pt**，発表者39 pt，共著者31 pt，所属25 pt．本文は**40 ptのまま**．
- **Poster No. を左側カラムのロゴの上**に配置．ロゴの右側にあるタイトル・著者・所属は中央揃えを維持します．
- 提供された大学ロゴは透明余白のみトリミングして使用（文字・図形は変更なし）．
- Section見出し44 pt，見出し→区切り線3.5 mm，線→本文6 mm，セクション間8 mm，罫線1 pt．通常/強調ブロックで基準を揃えています．
- `poster-config.tex` で各寸法を個別に変更可能．強調ブロックでは `PosterRuleBodyGap = 2 x PosterHighlightPadding` を保つと，通常ブロックと段差が揃います．

## 編集

1. **配色**：`poster-config.tex` の `\PosterColorTheme` を `navy`（添付見本に近い），`forest`，`slate` から選択．色定義は `posterstyle.sty` にあります．
2. **文字サイズ**：`\PosterFontLevel` は `compact`（36 pt），`standard`（40 pt），`large`（44 pt）．`\PosterTitlePt`，`\PosterBlockTitlePt` 等は同じ設定ファイル内で個別変更できます．
3. **タイトルと著者**：`poster-config.tex`．ポスター番号は左側カラムで大学ロゴの上，タイトルと著者・所属は右側で中央揃えです．所属には強制改行を入れず，横並びで設定しています．
4. **本文**：`documents/*.tex`．**新しいセクションを追加した場合だけ**，`main.tex` の該当するカラム内に `\input{documents/new-section.tex}` を追加します．
5. **図**：`figures/` に配置し，たとえば `\includegraphics[width=\linewidth]{figures/myplot.pdf}`．TeXの相対パスは常にルートの `main.tex` 基準です．
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
