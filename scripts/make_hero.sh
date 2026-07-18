#!/usr/bin/env bash
# ============================================================
# make_hero.sh — ヒーロー背景用ループ動画(hero.mp4)を生成する
# ------------------------------------------------------------
# 使い方:
#   ./scripts/make_hero.sh <入力動画のパス> [切り出し秒数(デフォルト12)]
#
# 例:
#   ./scripts/make_hero.sh ~/Movies/sunset.mov
#   ./scripts/make_hero.sh ~/Movies/sunset.mov 8
#
# 処理内容:
#   - 入力動画の先頭N秒を切り出す(デフォルト12秒)
#   - 音声を削除する(演出用ループ動画は無音の方針。CLAUDE.md
#     メディアルール準拠)
#   - 幅1920pxにリサイズする(縦横比は維持、高さは自動)
#   - H.264、目標ファイルサイズ5MB以下になるよう
#     2パスエンコードでビットレートを自動計算する
#   - portfolio/ 直下に hero.mp4 として出力する(上書き)
#
# 実行にはローカルの ffmpeg が必要です(brew install ffmpeg 等)。
# ============================================================

set -euo pipefail

INPUT="${1:?使い方: ./scripts/make_hero.sh <入力動画> [秒数]}"
DURATION="${2:-12}"
TARGET_MB=5

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUTPUT="$SCRIPT_DIR/../hero.mp4"

if [ ! -f "$INPUT" ]; then
  echo "エラー: 入力ファイルが見つかりません: $INPUT" >&2
  exit 1
fi

if ! command -v ffmpeg >/dev/null 2>&1; then
  echo "エラー: ffmpeg が見つかりません。'brew install ffmpeg' 等でインストールしてください。" >&2
  exit 1
fi

# 目標ビットレート(kbps)を目標サイズから逆算(音声トラックは無いので映像のみ)
# コンテナのオーバーヘッド分として8%を差し引く
TARGET_KBIT=$(( TARGET_MB * 8 * 1024 / DURATION ))
VIDEO_KBIT=$(( TARGET_KBIT * 92 / 100 ))

echo "入力       : $INPUT"
echo "切り出し   : 先頭 ${DURATION}秒"
echo "目標サイズ : ${TARGET_MB}MB以下"
echo "映像ビットレート: ${VIDEO_KBIT}kbps"

PASS_DIR="$(mktemp -d)"
PASSLOG="$PASS_DIR/ffmpeg2pass"

# 1パス目: 統計情報のみ収集(出力は捨てる)
ffmpeg -y -i "$INPUT" -t "$DURATION" -an \
  -vf "scale=1920:-2" \
  -c:v libx264 -b:v "${VIDEO_KBIT}k" -pass 1 -passlogfile "$PASSLOG" \
  -f mp4 /dev/null

# 2パス目: 実際の出力
ffmpeg -y -i "$INPUT" -t "$DURATION" -an \
  -vf "scale=1920:-2" \
  -c:v libx264 -b:v "${VIDEO_KBIT}k" -pass 2 -passlogfile "$PASSLOG" \
  -movflags +faststart \
  "$OUTPUT"

rm -rf "$PASS_DIR"

SIZE_KB=$(du -k "$OUTPUT" | cut -f1)
echo "完成: $OUTPUT (${SIZE_KB}KB)"

if [ "$SIZE_KB" -gt $(( TARGET_MB * 1024 )) ]; then
  echo "警告: 目標の${TARGET_MB}MBを超えています。DURATIONを短くするか再実行してください。" >&2
fi
