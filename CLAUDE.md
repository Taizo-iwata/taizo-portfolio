# ポートフォリオサイト(作品集) 開発ルール

## 体制
- 設計役(Claudeチャット)の指示書に従って実装する。
  指示にない変更(勝手なリファクタリング・機能追加)はしない
- 完了報告は必ず3部構成:
  【発注者向け要約】専門用語なしで3行以内
  【確認手順】ブラウザ操作だけで確認できる手順
  【技術的詳細】実装内容・コミット構成

## 完成の定義(7/20公開の条件・発注者合意済み)
1. GitHub Pagesの公開URLでPC/スマホ両方から閲覧できる
2. 4作品すべてに公開許諾済みの実素材(サムネ+本編動画)が入っている
3. ヒーロー背景が実写(静止画または軽量ループ動画)
4. 連絡先が実アドレス/実SNSに差し替え済み
5. iPhone Safari実機でゲート→全章→動画再生まで確認済み

## デザインルール(既存コードのトークンが基準)
- 色: --bg #0b0b0c / --ink #f2f0ec / --accent #d9a464 の3系統のみ。
  新しい色を足さない
- フォント: Oswald(英見出し) / Zen Kaku Gothic New(和文) /
  IBM Plex Mono(タイムコード・ラベル)の3つのみ
- 装飾の基準は「作品より目立たない」。演出追加は設計役の承認制
- UIに触れる変更の前に .claude/skills/design-review/SKILL.md を読む

## メディアルール
- 作品動画: YouTube(限定公開)埋め込み。クリックtoロード方式
  (サムネ画像を表示し、クリック時に初めてiframeを生成)
- 演出用ループ動画: 15秒以内/無音/H.264/5MB以下/
  autoplay muted loop playsinline + poster を必ずセットで
- 画像: 表示サイズに合わせ圧縮(1枚400KB以下目安)、loading="lazy"
- image/ 内の原本は絶対にリネーム・移動・削除しない。
  公開用は圧縮コピーを作る

## 運用
- 区切りごとに git commit(1機能=1コミット)
- 公開手順:
  1. `git push origin main` する
  2. GitHub Pages は main ブランチ / root 直下を自動ビルドする設定済み。
     push 後、数十秒〜数分でビルドされる
     (ビルド状況は `gh api repos/Taizo-iwata/taizo-portfolio/pages/builds/latest` で確認可能)
  3. 公開URL https://taizo-iwata.github.io/taizo-portfolio/ にアクセスし、
     反映されていることを確認する(ブラウザキャッシュに注意、
     反映されない場合はスーパーリロードする)
- リポジトリ: https://github.com/Taizo-iwata/taizo-portfolio (public)
- 触ってはいけないもの: image/ 内原本、.git

## 公開後リスト(今はやらないこと)
- BGM本実装(bgm.mp3の実音源)
- ホバーで動画プレビュー
- PHOTO章のギャラリー化
- 多言語対応
