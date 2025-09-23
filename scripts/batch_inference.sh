####################################################
#
# Importatnt: This runs, but can crash your linux, use individual scripts instead!!!!!!!!
#
########################################

#!/usr/bin/env bash
# One-pass batch pipeline: discover -> frames -> inference -> encode
# Run with bash, from repo root.
set -euo pipefail

###############################################################################
# Usage:
#   bash scripts/batch_inference.sh <ckpt_name> <root_folder> [fps]
#
# Example:
#   bash scripts/batch_inference.sh smplest_x_h demo/imitation_motions/Lift/good/clips 20
#
# Notes:
# - Recursively finds *.mp4 under <root_folder>
# - Skips macOS junk (.?_*, ._*, and paths under ._*/ )
# - Intermediates:
#     ./demo/input_frames/<relative-without-ext>/%06d.jpg
#     ./demo/output_frames/<relative-without-ext>/%06d.jpg
# - Results:
#     ./demo/result_<relative-dir>/<stem>.pkl
#     ./demo/result_<relative-dir>/<stem>.mp4
# - Comment out STEP blocks to reuse intermediates.
###############################################################################

if [[ $# -lt 2 ]]; then
  echo "Usage: $0 <ckpt_name> <root_folder> [fps]" >&2
  exit 1
fi

CKPT_NAME="$1"
ROOT_DIR="$2"                 # e.g., demo/imitation_motions/... or imitation_motions/...
FPS="${3:-20}"

# ---- STEP 1: Discover targets -------------------------------------------------
# Null-delimited, sorted, recursive find for *.mp4, skipping macOS junk.
mapfile -d '' FILES < <(
  find "$ROOT_DIR" -type f -iname '*.mp4' \
    ! -name '._*' \
    ! -name '.?_*' \
    ! -path '*/._*/*' \
    -print0 | sort -z
)

if ((${#FILES[@]} == 0)); then
  echo "No .mp4 files found under: $ROOT_DIR" >&2
  exit 2
fi

echo "Found ${#FILES[@]} mp4 file(s) under: $ROOT_DIR"
echo

idx=0
for FILEPATH in "${FILES[@]}"; do
  ((idx++)) || true

  # Keep the path exactly as find returns it (no stripping).
  REL="${FILEPATH#./}"             # only remove a leading "./" if present
  REL_NO_DEMO="${REL#demo/}"       # if user passed demo/..., internal layout still uses no-demo relative
  STEM_NOEXT="${REL_NO_DEMO%.*}"   # path without extension

  # Layout
  IMG_DIR="./demo/input_frames/$STEM_NOEXT"
  OUT_DIR="./demo/output_frames/$STEM_NOEXT"
  RES_DIR="./demo/result_${STEM_NOEXT%/*}"
  RES_STEM="${STEM_NOEXT##*/}"
  RES_PKL="$RES_DIR/$RES_STEM.pkl"
  RES_MP4="$RES_DIR/$RES_STEM.mp4"

  echo "[$idx/${#FILES[@]}] >>> $FILEPATH"
  echo "    IMG_DIR=$IMG_DIR"
  echo "    OUT_DIR=$OUT_DIR"
  echo "    RES_PKL=$RES_PKL"
  echo "    RES_MP4=$RES_MP4"
  echo

  mkdir -p "$IMG_DIR" "$OUT_DIR" "$RES_DIR"

  # ---- STEP 2: Video -> Frames ----------------------------------------------
  # Comment this block to reuse previously extracted frames in $IMG_DIR.
  ffmpeg -y -i "$FILEPATH" \
         -f image2 -vf "fps=${FPS}/1" \
         -q:v 2 \
         "$IMG_DIR/%06d.jpg"

  # Count frames for inference end index
  END_COUNT=$(find "$IMG_DIR" -type f -name '*.jpg' | wc -l | tr -d ' ')
  if [[ "$END_COUNT" == "0" ]]; then
    echo "WARN: No frames extracted for $FILEPATH, skipping."
    echo "----------------------------------------------------------------------------"
    continue
  fi

  # ---- STEP 3: Inference -----------------------------------------------------
  # Comment this block to reuse an existing $RES_PKL and/or OUT_DIR frames.
  # Use ${PYTHONPATH-} so set -u doesn't error when PYTHONPATH is unset.
  PYTHONPATH="../:${PYTHONPATH-}" \
  python main/inference.py \
      --num_gpus 1 \
      --file_name "$STEM_NOEXT" \
      --ckpt_name "$CKPT_NAME" \
      --end "$END_COUNT" \
      --fps "$FPS" \
      --output_path "$RES_PKL"

  # ---- STEP 4: Frames -> MP4 -------------------------------------------------
  # Comment this block if you only need the .pkl or already encoded the video.
  ffmpeg -y -r "$FPS" -i "$OUT_DIR/%06d.jpg" \
         -vf "scale=in_range=pc:out_range=tv,format=yuv420p" \
         -c:v libx264 -profile:v high -pix_fmt yuv420p -crf 18 -preset veryfast \
         -movflags +faststart \
         "$RES_MP4"

  echo "----------------------------------------------------------------------------"
done

echo "Done. Processed $idx file(s)."
