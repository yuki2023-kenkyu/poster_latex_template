# A0縦長・学術ポスター LaTeX テンプレート

LuaLaTeX + Beamer/Beamerposter + BibLaTeX/Biber を使う，**英語の学術ポスター用テンプレート**です．用紙は **A0縦長（841 × 1189 mm）**，ヘッダとフッタ，Abstract，左右2段の本文で構成されています．本文は `documents/` のファイルを編集し，見た目や発表情報は原則として `poster-config.tex` で設定します．

このREADMEは**テンプレート利用者向けの使い方**です．開発履歴ではなく，最初のPDF出力から提出前の確認までを説明します．サンプル本文・図表・氏名・所属・文献は，実際に使用する情報へ置き換えてください．

## 1. 準備するもの

- **TeX Live**：LuaLaTeX，latexmk，Biber，Beamer/Beamerposter，BibLaTeX，fontspec，TikZ，zref-clever などを利用します．必要なパッケージを導入した環境を用意してください．
- **VS Code + LaTeX Workshop**（推奨）．`.vscode/extensions.json` に推奨拡張機能を指定しています．
- **Git**（リポジトリを取得する場合）．WindowsではTeX Live付属のPerlもlatexmkの実行に必要です．

WindowsのPowerShellでは次を実行して，主要なコマンドの利用可否を確認できます．

```powershell
where.exe lualatex
where.exe latexmk
where.exe biber
```

### 最初のPDFを作る

1. リポジトリをクローンするか，ソース一式を取得し，**フォルダ全体**をVS Codeで開きます．
2. `poster-config.tex` のタイトル，著者，所属，ポスター番号，学会情報を編集します．
3. `documents/*.tex` のサンプル本文を自分の内容に置き換えます．
4. VS CodeのLaTeX Workshopで `main.tex` を開き，**latexmk (LuaLaTeX + Biber)** レシピでビルドします．
5. `build/main.pdf` を開き，本文・図・キャプションがページ内に収まっているか確認します．

ターミナルからビルドする場合は，**リポジトリのルート**で次を実行します．

```powershell
latexmk -cd -lualatex -outdir=build main.tex
```

生成物は `build/` に保存されます（`main.pdf`，`main.log`，文献処理の中間ファイルなど）．`.latexmkrc` と `.vscode/settings.json` は，この配置を前提に設定されています．**`lualatex main.tex` を直接実行すると，`build/` を使用しない場合があります**．

## 2. ファイル構成

```text
poster_latex_template/
├── main.tex                   # 1枚のポスター全体，本文ファイルの読み込み順
├── poster-config.tex          # 発表情報，表示切替，色，文字サイズ，余白
├── posterstyle.sty            # 共通デザイン・引用・キャプション
├── references.bib             # 本文引用とヘッダのReference用文献データ
├── .latexmkrc                 # latexmkのビルド設定
├── .vscode/
│   ├── settings.json          # LaTeX Workshopのプロジェクト設定
│   └── extensions.json
├── documents/
│   ├── abstract.tex           # Abstract本文のみ
│   ├── background.tex         # 左列
│   ├── methods.tex            # 左列
│   ├── results.tex            # 右列（強調色の例）
│   └── conclusions.tex        # 右列
├── figures/                   # 自分の図を配置する場所
├── logos/
│   └── fukushima-university-logo.png
└── build/                     # ビルド時に生成・Git管理対象外
```

**普段編集するファイル**は `poster-config.tex`，`documents/*.tex`，`references.bib`，図・ロゴです．`posterstyle.sty` と `main.tex` は，共通レイアウトやセクション配置を変更するとき以外は編集する必要がありません．パスは `main.tex` のあるルートを基準に書きます．

## 3. 発表情報・表示の設定

`poster-config.tex` に各項目がまとめられています．

| 項目 | 設定名 | 使い方 |
| --- | --- | --- |
| 配色 | `\PosterColorTheme` | `navy` / `forest` / `slate` |
| 全体フォント倍率 | `\PosterFontLevel` | `compact`（0.90）/ `standard`（1.00）/ `large`（1.10） |
| Abstract本文 | `\PosterBodyPt` | 44 pt（従来どおり） |
| Section本文 | `\PosterSectionBodyPt` | 40 pt（通常／強調ブロック共通） |
| タイトル | `\PosterTitle` | 長い場合は `\\` で改行できます |
| 発表者・共同研究者 | `\PosterPresenter`，`\PosterCoauthors` | ヘッダに表示する氏名 |
| 所属 | `\PosterAffiliations` | 単一／複数所属の表示を切替可能 |
| ポスター番号 | `\PosterNumber` | 例：`P66`．表示時は `Poster No.: P66` |
| ロゴ | `\PosterLogoFile` | `logos/` 内の画像などを指定 |
| Reference | `\PosterFeaturedPaperKey` | `references.bib` の文献キー |
| フッタ | `\PosterConference` など | 学会名，会場，日付，連絡先 |

### ポスター番号の表示・非表示

```latex
\PosterShowNumbertrue   % 表示
% \PosterShowNumberfalse % 非表示に切り替える場合はこちらを使用
```

非表示時は白い番号ボックスも消え，左側の濃紺ヘッダ内でロゴが上下左右中央に配置されます．ヘッダ高は変わりません．

### Reference帯の表示・非表示

```latex
\PosterShowReferencetrue
% \PosterShowReferencefalse
```

非表示にするとReference帯が消え，**Abstractと本文が帯の高さ（現在16 mm）だけ上に移動**します．フッタ位置は変わりません．ポスター番号の設定とは独立しています．表示する場合は `\PosterFeaturedPaperKey` に `references.bib` のキーを指定してください．書誌情報はBibLaTeX経由で取得されます．

### 著者が全員同一所属の場合

初期設定は `\PosterMultipleAffiliationsfalse` で，上付き所属番号を表示しません．異なる所属がある場合は `\PosterMultipleAffiliationstrue` に変更し，氏名・所属の双方で `\PosterAffiliationMark{1}` などを使って対応付けます．`poster-config.tex` 内に複数所属の記述例があります．**所属の相違は自動判定されず，利用者が設定します**．

## 4. Abstract・Section・2段組の編集

`documents/abstract.tex` には**本文だけ**を書きます．`Abstract` は外枠の上辺中央に自動表示されるため，本文ファイルに見出しを記述しないでください． 箇条書きや数式も，Abstractの本文サイズ（初期値44 pt）と文字色を継承します．上辺のラベルと本文の余白は `poster-config.tex` の `\PosterAbstractLabelInset`（初期値 8 mm）で調整できます．独立したSection見出し・区切り線は表示しません．

本文のSectionには，**Beamerの標準コマンド** `\section`，`block`，`alertblock` を使用します．独自のSection環境は不要です．

```latex
\section{Data and Methods}
\label{sec:methods}

\begin{block}{\thesection.\ \insertsectionhead}
Describe the data, assumptions, and analysis method.
\end{block}
```

Section番号は **I，II，III，IV，…** と自動付番されます．強調背景を付けたい場合は `block` を `alertblock` に置き換えます．

新しいSectionを作るには，`documents/new-section.tex` を作成し，`main.tex` の目的のカラム内に `\input{documents/new-section.tex}` を追加します．**番号は`main.tex`の読み込み順（左列の上から下，次に右列の上から下）**で進みます．一方の列だけ本文が多い場合は，自動で高さをそろえたり，次ページへ送ったりしません．

### 箇条書き・数式の例

Abstractや通常／強調Sectionで `itemize`，`enumerate`，`equation`，`align`，`\bm` をそのまま使用できます．入れ子のリスト本文・`enumerate` の番号ラベルは，その領域の本文サイズに従います（Abstract: 44 pt，Section: 40 pt）．`enumerate` はBeamer標準の数字（`1.`，`1.1` など）で表示し，番号はテーマ色です．数式本体に加え，`equation`／`align` の自動番号も各領域の本文サイズに追従します．数式の文字色は周囲の設定を継承します．

```latex
\begin{itemize}
  \item We reconstruct $\bm{H}(z)$ from the observations.
  \item The parameters satisfy
  \begin{equation}
    \bm{\theta}^{\mathsf T}\bm{\theta} > 0.
  \end{equation}
\end{itemize}
```

## 5. 図・TikZ・Table

### Figure

図のファイルを `figures/` に入れ，標準の `figure`，`\centering`，`\includegraphics`，`\caption` を使用します．

```latex
\begin{figure}
  \centering
  \includegraphics[width=0.9\linewidth]{figures/result.pdf}
  \caption{Reconstructed expansion history from the observations.}
  \label{fig:expansion}
\end{figure}
```

図とキャプションは列幅内で中央揃えになります．現行スタイルではキャプションが **`FIG. 1.`** の形式で図の下に表示されます．ラベルは `\caption` の直後に置いてください．

**TikZ** はすでに読み込み済みです．`documents/*.tex` 内，または `figure` 環境内で標準の `tikzpicture` をそのまま使用できます．

```latex
\begin{figure}
  \centering
  \begin{tikzpicture}
    \draw[->] (0,0) -- (3,0) node[right] {$z$};
    \draw[->] (0,0) -- (0,2) node[above] {$H(z)$};
  \end{tikzpicture}
  \caption{Schematic axes for the expansion rate.}
  \label{fig:schematic}
\end{figure}
```

### Table（APS/PRDに沿った表記）

標準の `table` と `tabular` を使用し，キャプションは表の**上**に配置します．表番号は大文字ローマ数字で **`TABLE I.`** の形式です．簡単な表の罫線は，上下を二重線（`\hline\hline`），見出し直下を単線（`\hline`）とし，縦罫線は使用しません．

```latex
\begin{table}
  \centering
  \caption{Illustrative mock measurements of the expansion rate.}
  \label{tab:mock}
  \begin{tabular}{lcc}
    \hline\hline
    Sample & $z$ & $H$ (km s$^{-1}$ Mpc$^{-1}$) \\
    \hline
    A & 0.20 & 78.0 \\
    B & 0.50 & 91.0 \\
    \hline\hline
  \end{tabular}
\end{table}
```

表の罫線幅は `\PosterTableRuleWidth`（現在 **1.5 pt**），二重線の間隔は `\PosterTableDoubleRuleSep`（現在 **6 pt**）で調整できます．実データを掲載する際は，単位，桁数，列見出し，記号の意味を確認してください．このテンプレートはAPS/PRDの**表記上の慣行**をポスター向けに適用しており，PRD誌面のレイアウト全体を再現するものではありません．

## 6. 相互参照・文献引用

### Section・Figure・Table・Equationの相互参照

標準の `\label{...}` と `zref-clever` の `\zcref{...}` を使います．Sectionのラベルは `\section` の直後，Figure/Tableのラベルは `\caption` の直後に置きます．数式は `equation` 環境内に `\label` を置きます．

```latex
As described in \zcref{sec:methods}, the measurements
are compared in \zcref{fig:expansion} and \zcref{tab:mock}.

% 文頭では省略せず表記する
\zcref[S]{fig:expansion} shows the reconstructed result.
```

| 対象 | 文中の表記例 | 文頭の表記例 |
| --- | --- | --- |
| Section | `Sec. II` | `Section II` |
| Figure | `Fig. 1` | `Figure 1` |
| Table | `Table I` | `Table I` |
| Equation | `Eq. (1)` | `Equation (1)` |

これは **本文中の参照**であり，キャプションの `FIG. 1.`／`TABLE I.` とは別の表記です．未定義参照は再コンパイルにより解決されます．

### 文献引用（BibLaTeX + Biber）

文献は `references.bib` に追加し，本文では**標準の `\cite{key}`** のみを使用します．

```latex
The data are compared with a reference cosmology.
\cite{aghanim2020}
```

現在の `\cite` は，**独立した行・右寄せ・小さめの文字**で，例：`[Aghanim et al., A&A 641, A6 (2020)]` の形式になります．通常のインライン引用ではないため，文章の途中に置くのではなく，引用する説明の直後に配置してください．

ヘッダのReference帯は本文引用と別で，`\PosterFeaturedPaperKey` に指定したキーの**著者全員，雑誌，巻，論文番号，年，登録済みならarXiv番号**を `.bib` 情報から取得します．そのため，`references.bib` の入力内容も確認してください．

## 7. 見た目を調整するとき

まず `poster-config.tex` の設定を変更してください．色・フォントサイズ・カラム間隔・セクション間隔，ヘッダ・フッタの寸法や余白を設定できます．通常は `posterstyle.sty` の内部マクロを直接編集する必要はありません．

特に確認しやすい設定：

- `\PosterColorTheme`：配色．`\PosterFontLevel`：全文字倍率．`\PosterBodyPt`：Abstract本文（44 pt）．`\PosterSectionBodyPt`：Section本文（40 pt）．`\PosterBlockTitlePt`・`\PosterCaptionPt`：見出し・キャプションの基本pt値．
- `\PosterColumnGap`・`\PosterBlockGap`：2段組のカラム間隔・Section間隔．なお，Section見出し直下の `itemize`／`enumerate` は，Beamerのリスト用余白（`\topsep` 等）が通常の文章とは異なるため，最初の行の位置がわずかに異なることがあります．
- `\PosterHeaderMainHeight`・`\PosterHeaderRightBalanceGap` など：ヘッダの寸法・余白．
- `\PosterTableRuleWidth`・`\PosterTableDoubleRuleSep`：表の罫線．

用紙全体は固定1ページです．長文や大きな図を追加しても**自動縮小・改ページされない**ため，本文とフッタの重なり，キャプションの収まり，余白をPDFで確認してください．

## 8. ビルドに失敗したとき／提出前の確認

| 症状 | 確認すること |
| --- | --- |
| `build/main.pdf` が作られない | VS Codeで `main.tex` をルートとして開き，`latexmk (LuaLaTeX + Biber)` レシピを使用しているか．`build/main.log` の最初のエラーを確認 |
| リポジトリ直下にPDF等が生成される | `lualatex` を直接実行していないか．LaTeX Workshopのビルドログで起動コマンドと `-outdir` を確認 |
| `Citation undefined` や文献が `?` になる | `references.bib` のキー，Biberのインストール状況，latexmkの再実行を確認 |
| `\zcref` の参照が `??` になる | 対応する `\label` の有無と位置を確認し，再ビルドする |
| 図が表示されない | `figures/` 以下のファイル名・拡張子・相対パスを確認 |
| 本文や表がフッタに重なる | 段組内の文章量，図の高さ，余白，フォントサイズを調整する |

最終PDFでは，A0縦長・1ページであること，キャプション・文献・相互参照が解決していること，ヘッダやフッタが欠けていないことを確認してください．

参考：<https://journals.aps.org/authors/style-basics>（APSの図表に関する基本スタイル）．
