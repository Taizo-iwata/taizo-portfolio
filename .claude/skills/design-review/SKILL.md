---
name: design-review
description: Use before and after any UI-touching change to this portfolio site. Checks viewport coverage, image sizing/alt, design-token adherence, and animation restraint against CLAUDE.md's rules.
---

# design-review

このサイトのUIに触れる変更(HTML/CSS/JSのレイアウト・見た目・演出)を行う前に必ず読むこと。判断基準は `CLAUDE.md` の「デザインルール」「メディアルール」を基準とする。

## 変更前チェック
- すべてのUI変更は PC幅(1280px)とスマホ幅(375px)の両方で確認する
- 画像は表示サイズを超える原寸貼りを禁止。`<img>` には alt 属性を必ず付ける
- フォント・色・余白は CLAUDE.md 記載の基準値のみを使う。場当たり的な値の指定は禁止
  - 色は `--bg` / `--ink` / `--accent` の3系統のみ
  - フォントは Oswald / Zen Kaku Gothic New / IBM Plex Mono の3つのみ
- アニメーション・演出を追加する場合の採用基準は「作品より目立たないこと」。
  この基準を満たさない演出は設計役の承認を得るまで実装しない

## 公開前チェック(完了報告に含めること)
- 全アンカー遷移(MENU の各リンク)が正しいセクションへ移動すること
- 全画像が表示されていること(壊れた画像・未読み込みがないこと)
- スマホ幅(375px)でレイアウトが崩れていないこと
- `prefers-reduced-motion: reduce` 環境でも操作可能・表示可能であること
