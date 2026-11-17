# A0 portrait poster (LuaLaTeX + beamerposter + biblatex)

Windows + Git + VS Code + TeX Live 向けの英語の研究ポスター用プロジェクトです．添付されたポスターの**全面濃紺のコンパクトなヘッダ（左ロゴ＋中央揃え番号，右タイトル・著者・所属）と淡い紺色のReference帯**という配置・寸法を参考にしています．Section区切り線は通常・強調セクションで同じテーマ色に統一します．大学ロゴにはユーザー提供の背景透過PNGを使用しています．本文40 pt，A0縦長（841 × 1189 mm）です．

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

`build/` はコンパイル時に生成され，`.gitignore` で除外されます．旧来のルート直下の `main.pdf` はGit追跡対象から取り除いています．

## ヘッダ・Reference帯・Sectionの設定

- A0縦長（841 × 1189 mm），**主ヘッダ116 mm**，Reference帯16 mm，フッタ28 mm．
- 主ヘッダ全域を濃紺に統一．左約23%のロゴ領域で**ポスター番号を中央揃え**，右約77%にタイトル・著者・所属を中央揃え．ヘッダ内の文字・ロゴは上端寄せ．
- 番号51 pt，タイトル58 pt，発表者46 pt，共著者46 pt，所属40 pt，本文40 pt（標準レベル）．色・サイズ・間隔は `poster-config.tex` で変更可能．
- Reference帯は**淡い紺色**．この帯では引用全体の角括弧を省略し，`.bib` の `author`・`shortjournal`/`journaltitle`・`volume`・`eid`/`pages`・`year`・`archivePrefix`・`eprint` から生成します．例：`Reference: Yuki Hashimoto, Kazuharu Bamba, and Sanjay Mandal, JCAP 09, 146 (2026) [arXiv:2604.22372].` 著者は名→姓ですべて表示し，雑誌名はイタリック，巻は太字，末尾にはピリオドを付けます．`eprint` がなければ識別子部分は省略します．本文内の引用は従来どおり短縮形・角括弧付きです．本文の引用には標準の `\cite{...}` のみを使用します．
- 従来の2段組，Section見出し・区切り線，`documents/*.tex` の分割管理は維持．主要文献 `Hashimoto:2026zcr` と `references.bib` の既存エントリを保持．

## 編集

1. **配色**：`poster-config.tex` の `\PosterColorTheme` を `navy`（添付見本に近い），`forest`，`slate` から選択．色定義は `posterstyle.sty` にあります．
2. **文字サイズ**：`\PosterFontLevel` は `compact`（36 pt），`standard`（40 pt），`large`（44 pt）．`\PosterTitlePt`，`\PosterBlockTitlePt` 等は同じ設定ファイル内で個別変更できます．
3. **タイトル・著者・主要論文**：`poster-config.tex`．ポスター番号は左側の濃紺領域で大学ロゴの上に中央揃え，タイトルと著者・所属は右側の暗い領域で中央揃えです．その下の淡い紺色の主要論文帯には `\\PosterFeaturedPaperKey` で指定した文献を表示します．
4. **本文**：`documents/*.tex`．**新しいセクションを追加した場合だけ**，`main.tex` の該当するカラム内に `\input{documents/new-section.tex}` を追加します．
5. **図**：必要に応じて `figures/` を作成して配置し，たとえば `\includegraphics[width=\linewidth]{figures/myplot.pdf}`．TeXの相対パスは常にルートの `main.tex` 基準です．
6. **セクション区切り**：`block` = 白地＋中央タイトル＋水平線，`alertblock` = 淡色背景の同形式．アクセント色はテーマで連動します．
7. **フッタ**：学会名・会場・日付・連絡先を `poster-config.tex` で設定．

## 引用

各セクションの本文の直後に `\cite{aghanim2020}` と書きます．標準の `\cite` なので VS Code の文献キー補完を使えます．専用の `\postercite` エイリアスは廃止しました．参考文献は `references.bib` に登録します．本文引用はタイトルを除き，右寄せ・淡色・小さめで以下の表記になります：

`[Aghanim et al., A&A 641, A6 (2020)]`

`et al.` と雑誌名は *italic*，巻番号は **bold** です．`shortjournal` があれば雑誌略称として優先使用します．出版年は丸括弧，ページや論文番号は `eid` を優先します．書籍などの引用はこの形式に必ずしも適しません．

## ビルド前後の注意

- A0縦長1ページとして出力されることを `pdfinfo build/main.pdf` 等で確認してください．
- 大判beamerポスターは本文量に応じて自動的に縮小・改ページされません．**本文や図を追加したらフッタとの重複，文字のはみ出し，フォント埋め込みを確認**してください．
- 1行に入らないほど長い所属は自動で折り返す可能性があります．必要なら所属文字サイズか右カラムの幅を調整してください．
- Gitの初期化は `git init -b main`，`git add .`，`git commit -m "Initialize A0 poster"` です．既存リポジトリ内で使う場合は再初期化しません．
- 添付されたロゴの使用許諾・学会提出要件は使用者側で確認してください．

## 生成ファイルの配置

`.vscode/settings.json` と `.latexmkrc` はともに `build/` を指定します．VS CodeまたはPowerShellからのビルド結果は `build/main.pdf`，中間ファイルも `build/` に保存します．Git管理対象はソース（図表PDFを含む）だけとします．

## ヘッダとAbstractの微調整（2026-11-18）
- **主ヘッダ116 mm・Reference帯16 mm・フォントサイズのpt値は変更なし**．2行タイトル時の所属の重なりを避けるため，右側のタイトル・発表者・共同研究者・所属を `\\PosterRightContentRaise` (14 mm) で上に移動し，各行の行送り比率と行間だけを縮小しました．
- 発表者に下線を追加，共同研究者欄に `Collaboration with:` を表示します．個人名と所属は従来どおり `poster-config.tex` で設定します．
- ポスター番号は**ロゴ列の幅と等しい白背景のボックス**へ変更し，黒文字・中央揃えにしました．ボックスの高さは `\\PosterNumberBoxHeight` で調整できます．
- Abstractは `\\PosterAbstractFrameRule` と `\\PosterAbstractFramePadding` に従うnavy枠で囲み，`\\PosterAbstractRaise` (26 mm) により上へ移動しました．他のSectionブロックは変更していません．

## build/ に保存されない場合の切り分け
- `.latexmkrc` は **latexmk を起動した場合のみ**読み込まれます．`lualatex main.tex` を直接実行すると通常はプロジェクト直下に出力されます．
- VS Codeの **LaTeX Workshop: View LaTeX compiler log** で起動コマンドを確認し，`latexmk -cd -lualatex -outdir=...` のレシピを使用してください．Auto Build で別レシピが選択されていた場合は `Build with recipe` で指定し直します．
- PowerShell（プロジェクトルート）では `latexmk -cd -lualatex -outdir=build main.tex`．正常ならPDFと補助ファイルは `build/` に作成されます．
- `build/main.log` 内の `Output written on main.pdf` だけではルート直下に生成されたとは判定できません．`build/main.pdf` の実在と更新日時を確認します．
- 以前のビルドでルートに残っている `main.aux` や `main.log` は自動移動されません．不要と確認してから削除してください．

## 表示切替・Figure・ビルドの設定（2026-11-18）

- **Poster No.**: `poster-config.tex` の `\PosterShowNumbertrue` / `\PosterShowNumberfalse` で切り替えます．非表示の場合は白いボックスごと消し，navy領域左側で大学ロゴが上下左右中央に位置します．表示の場合，白い番号ボックスの下端はそのままで上端を12 mm延長します．
- **Reference**: `\PosterShowReferencetrue` / `\PosterShowReferencefalse` を切り替えます．非表示ならReference帯を消し，Abstract以降の本文を**16 mm**上に移動します．主ヘッダとフッタ位置は不変です．番号表示とは独立しています．
- **Affiliations**: 全員同一所属なら `\PosterMultipleAffiliationsfalse` とし，上付き番号を省略します．複数所属なら `\PosterMultipleAffiliationstrue` にして，`\PosterAffiliationMark{1}` などで著者・所属を対応付けます．
- **Abstract**: `documents/abstract.tex` に本文だけを記述します．`main.tex` 側のnavyの枠線は残し，Section名と区切り線は表示しません．
- **Figures**: Beamerの標準 `figure`，`\centering`，`\includegraphics`，`\caption` を使用します．番号付きキャプションはBeamer標準設定です．
- **VS Code**: ワークスペースの `settings.json` で最初のlatexmkレシピを標準指定し，magic commentビルドと外部ビルドコマンドを無効化しています．通常のLaTeX Workshopビルドは `build/` に出力します．手動の `lualatex` や別の拡張機能によるコンパイルまでは制御しません．


## Sectionの自動付番とTableの表示（2026-11-18）

- 本文のSectionは `posterblock` と `posteralertblock` 環境で記述します．見出しには番号を含めず，左列→右列の `main.tex` 読込順に `I.`，`II.`，`III.`，`IV.` が自動付番されます．例：`\\begin{posterblock}{Background and Motivation}`．本文ファイルごとに番号を手書きする必要はありません．
- 引用は **`\\cite{文献キー}` だけ**を使用します．`\\postercite` のエイリアスと使われていない `\\posterciteinline` を削除しました．Reference帯の全著者名等の専用書誌処理は維持します．
- TableはAPSの[Style Basics](https://journals.aps.org/authors/style-basics)に基づき，**TABLE I.** の大文字ローマ数字，表の上の `\\caption`，見出し下の1本の水平線，縦罫線なし，単位を付した列名を標準の `table`・`tabular`・`\\hline` で表現します．`documents/results.tex` は測定値ではない例示データを使用しています．
- 図と表のキャプションは同じBeamerの標準 `\\caption` を使い，列幅内で中央揃えします．TableとFigureの番号カウンタは独立しています．
- ポスター形式の例示であり，PRD誌面そのもののREVTeXクラスへ変更したわけではありません．
