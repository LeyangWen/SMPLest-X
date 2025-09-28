
#!/usr/bin/env bash
# Run inference on all imitation_motions/Lift/good/clips mp4 files
# Default checkpoint: smplest_x_h
# Default FPS: 20
# Note: more control, so it don't crash out

CKPT="smplest_x_h"
FPS=20

# --- Bag01.51470934.20250919201429 ---
sh scripts/inference.sh $CKPT imitation_motions/Lift/good/clips/bag01.51470934.20250919201429/clip_01.mp4 $FPS
sh scripts/inference.sh $CKPT imitation_motions/Lift/good/clips/bag01.51470934.20250919201429/clip_02.mp4 $FPS
sh scripts/inference.sh $CKPT imitation_motions/Lift/good/clips/bag01.51470934.20250919201429/clip_03.mp4 $FPS

# --- Bag01.66920734.20250919201429 ---
sh scripts/inference.sh $CKPT imitation_motions/Lift/good/clips/bag01.66920734.20250919201429/clip_01.mp4 $FPS
sh scripts/inference.sh $CKPT imitation_motions/Lift/good/clips/bag01.66920734.20250919201429/clip_02.mp4 $FPS
sh scripts/inference.sh $CKPT imitation_motions/Lift/good/clips/bag01.66920734.20250919201429/clip_03.mp4 $FPS

# --- Bag01.66920758.20250919201429 ---
sh scripts/inference.sh $CKPT imitation_motions/Lift/good/clips/bag01.66920758.20250919201429/clip_01.mp4 $FPS
sh scripts/inference.sh $CKPT imitation_motions/Lift/good/clips/bag01.66920758.20250919201429/clip_02.mp4 $FPS
sh scripts/inference.sh $CKPT imitation_motions/Lift/good/clips/bag01.66920758.20250919201429/clip_03.mp4 $FPS

# --- Box01.51470934.20250919201305 ---
sh scripts/inference.sh $CKPT imitation_motions/Lift/good/clips/box01.51470934.20250919201305/clip_01.mp4 $FPS >> output.log
sh scripts/inference.sh $CKPT imitation_motions/Lift/good/clips/box01.51470934.20250919201305/clip_02.mp4 $FPS
sh scripts/inference.sh $CKPT imitation_motions/Lift/good/clips/box01.51470934.20250919201305/clip_03.mp4 $FPS

# --- Box01.66920734.20250919201305 ---
sh scripts/inference.sh $CKPT imitation_motions/Lift/good/clips/box01.66920734.20250919201305/clip_01.mp4 $FPS
sh scripts/inference.sh $CKPT imitation_motions/Lift/good/clips/box01.66920734.20250919201305/clip_02.mp4 $FPS
sh scripts/inference.sh $CKPT imitation_motions/Lift/good/clips/box01.66920734.20250919201305/clip_03.mp4 $FPS

# --- Box01.66920758.20250919201305 ---
sh scripts/inference.sh $CKPT imitation_motions/Lift/good/clips/box01.66920758.20250919201305/clip_01.mp4 $FPS
sh scripts/inference.sh $CKPT imitation_motions/Lift/good/clips/box01.66920758.20250919201305/clip_02.mp4 $FPS
sh scripts/inference.sh $CKPT imitation_motions/Lift/good/clips/box01.66920758.20250919201305/clip_03.mp4 $FPS

# --- Handle01.51470934.20250919200241 ---
sh scripts/inference.sh $CKPT imitation_motions/Lift/good/clips/handle01.51470934.20250919200241/clip_01.mp4 $FPS
sh scripts/inference.sh $CKPT imitation_motions/Lift/good/clips/handle01.51470934.20250919200241/clip_02.mp4 $FPS
sh scripts/inference.sh $CKPT imitation_motions/Lift/good/clips/handle01.51470934.20250919200241/clip_03.mp4 $FPS

# --- Handle01.66920734.20250919200241 ---
sh scripts/inference.sh $CKPT imitation_motions/Lift/good/clips/handle01.66920734.20250919200241/clip_01.mp4 $FPS
sh scripts/inference.sh $CKPT imitation_motions/Lift/good/clips/handle01.66920734.20250919200241/clip_02.mp4 $FPS
sh scripts/inference.sh $CKPT imitation_motions/Lift/good/clips/handle01.66920734.20250919200241/clip_03.mp4 $FPS

# --- Handle01.66920758.20250919200241 ---
sh scripts/inference.sh $CKPT imitation_motions/Lift/good/clips/handle01.66920758.20250919200241/clip_01.mp4 $FPS
sh scripts/inference.sh $CKPT imitation_motions/Lift/good/clips/handle01.66920758.20250919200241/clip_02.mp4 $FPS
sh scripts/inference.sh $CKPT imitation_motions/Lift/good/clips/handle01.66920758.20250919200241/clip_03.mp4 $FPS

# --- Timber01.51470934.20250919201355 ---
sh scripts/inference.sh $CKPT imitation_motions/Lift/good/clips/timber01.51470934.20250919201355/clip_01.mp4 $FPS
sh scripts/inference.sh $CKPT imitation_motions/Lift/good/clips/timber01.51470934.20250919201355/clip_02.mp4 $FPS
sh scripts/inference.sh $CKPT imitation_motions/Lift/good/clips/timber01.51470934.20250919201355/clip_03.mp4 $FPS

# --- Timber01.66920734.20250919201355 ---
sh scripts/inference.sh $CKPT imitation_motions/Lift/good/clips/timber01.66920734.20250919201355/clip_01.mp4 $FPS
sh scripts/inference.sh $CKPT imitation_motions/Lift/good/clips/timber01.66920734.20250919201355/clip_02.mp4 $FPS
sh scripts/inference.sh $CKPT imitation_motions/Lift/good/clips/timber01.66920734.20250919201355/clip_03.mp4 $FPS

# --- Timber01.66920758.20250919201355 ---
sh scripts/inference.sh $CKPT imitation_motions/Lift/good/clips/timber01.66920758.20250919201355/clip_01.mp4 $FPS
sh scripts/inference.sh $CKPT imitation_motions/Lift/good/clips/timber01.66920758.20250919201355/clip_02.mp4 $FPS
sh scripts/inference.sh $CKPT imitation_motions/Lift/good/clips/timber01.66920758.20250919201355/clip_03.mp4 $FPS



