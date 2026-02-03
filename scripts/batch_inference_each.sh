
#!/usr/bin/env bash
# Run inference on all imitation_motions/Lift/good/clips mp4 files
# Default checkpoint: smplest_x_h
# Default FPS: 20
# Note: more control, so it don't crash out

CKPT="smplest_x_h"
FPS=20

# --- Box02.high ---
sh scripts/inference.sh $CKPT imitation_motions/Lift/good/clips/box02.high/2.mov $FPS
sh scripts/inference.sh $CKPT imitation_motions/Lift/good/clips/box02.high/3.mov $FPS



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

# --- Handle02.high ---
sh scripts/inference.sh $CKPT imitation_motions/Lift/good/clips/handle02.high/1.mov $FPS
sh scripts/inference.sh $CKPT imitation_motions/Lift/good/clips/handle02.high/4.mov $FPS

# --- Handle_2 Lift---
sh scripts/inference.sh $CKPT imitation_motions/Lift/good/clips/handle_2/handle_lift_1.mp4 $FPS
sh scripts/inference.sh $CKPT imitation_motions/Lift/good/clips/handle_2/handle_lift_2.mp4 $FPS
sh scripts/inference.sh $CKPT imitation_motions/Lift/good/clips/handle_2/handle_lift_3.mp4 $FPS
sh scripts/inference.sh $CKPT imitation_motions/Lift/good/clips/handle_2/handle_lift_4.mp4 $FPS
sh scripts/inference.sh $CKPT imitation_motions/Lift/good/clips/handle_2/handle_lift_5.mp4 $FPS
sh scripts/inference.sh $CKPT imitation_motions/Lift/good/clips/handle_2/handle_lift_6.mp4 $FPS
sh scripts/inference.sh $CKPT imitation_motions/Lift/good/clips/handle_2/handle_lift_7.mp4 $FPS
sh scripts/inference.sh $CKPT imitation_motions/Lift/good/clips/handle_2/handle_lift_8.mp4 $FPS
sh scripts/inference.sh $CKPT imitation_motions/Lift/good/clips/handle_2/handle_lift_9.mp4 $FPS
sh scripts/inference.sh $CKPT imitation_motions/Lift/good/clips/handle_2/handle_lift_10.mp4 $FPS

# --- Handle_2 Carry---
sh scripts/inference.sh $CKPT imitation_motions/Carry/handle/handle_carry_1.mp4 $FPS
sh scripts/inference.sh $CKPT imitation_motions/Carry/handle/handle_carry_2.mp4 $FPS
sh scripts/inference.sh $CKPT imitation_motions/Carry/handle/handle_carry_3.mp4 $FPS
sh scripts/inference.sh $CKPT imitation_motions/Carry/handle/handle_carry_4.mp4 $FPS
sh scripts/inference.sh $CKPT imitation_motions/Carry/handle/handle_carry_5.mp4 $FPS
sh scripts/inference.sh $CKPT imitation_motions/Carry/handle/handle_carry_6.mp4 $FPS
sh scripts/inference.sh $CKPT imitation_motions/Carry/handle/handle_carry_7.mp4 $FPS




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

# --- timber_lift_1.mp4 ---
sh scripts/inference.sh $CKPT imitation_motions/Lift/good/clips/timber/timber_lift_1.mp4 $FPS
sh scripts/inference.sh $CKPT imitation_motions/Lift/good/clips/timber/timber_lift_2.mp4 $FPS
sh scripts/inference.sh $CKPT imitation_motions/Lift/good/clips/timber/timber_lift_3.mp4 $FPS
sh scripts/inference.sh $CKPT imitation_motions/Lift/good/clips/timber/timber_lift_4.mp4 $FPS
sh scripts/inference.sh $CKPT imitation_motions/Lift/good/clips/timber/timber_lift_5.mp4 $FPS
sh scripts/inference.sh $CKPT imitation_motions/Lift/good/clips/timber/timber_lift_6.mp4 $FPS
sh scripts/inference.sh $CKPT imitation_motions/Lift/good/clips/timber/timber_lift_7.mp4 $FPS
sh scripts/inference.sh $CKPT imitation_motions/Lift/good/clips/timber/timber_lift_8.mp4 $FPS
sh scripts/inference.sh $CKPT imitation_motions/Lift/good/clips/timber/timber_lift_9.mp4 $FPS
sh scripts/inference.sh $CKPT imitation_motions/Lift/good/clips/timber/timber_lift_10.mp4 $FPS
sh scripts/inference.sh $CKPT imitation_motions/Lift/good/clips/timber/timber_lift_12.mp4 $FPS
sh scripts/inference.sh $CKPT imitation_motions/Lift/good/clips/timber/timber_lift_13.mp4 $FPS


# --- timber_carry_1.mp4 ---
sh scripts/inference.sh $CKPT imitation_motions/Carry/timber/timber_carry_1.mp4 $FPS
sh scripts/inference.sh $CKPT imitation_motions/Carry/timber/timber_carry_2.mp4 $FPS
sh scripts/inference.sh $CKPT imitation_motions/Carry/timber/timber_carry_3.mp4 $FPS
sh scripts/inference.sh $CKPT imitation_motions/Carry/timber/timber_carry_4.mp4 $FPS
sh scripts/inference.sh $CKPT imitation_motions/Carry/timber/timber_carry_5.mp4 $FPS

# --- timber_lower_1.mp4 ---
sh scripts/inference.sh $CKPT imitation_motions/Lower/timber/timber_lower_1.mp4 $FPS
sh scripts/inference.sh $CKPT imitation_motions/Lower/timber/timber_lower_2.mp4 $FPS
sh scripts/inference.sh $CKPT imitation_motions/Lower/timber/timber_lower_3.mp4 $FPS
sh scripts/inference.sh $CKPT imitation_motions/Lower/timber/timber_lower_4.mp4 $FPS
sh scripts/inference.sh $CKPT imitation_motions/Lower/timber/timber_lower_12.mp4 $FPS



# 
# --- slide01.51470934.20250919202325 ---
sh scripts/inference.sh $CKPT imitation_motions/Terrain_lift/good/clips/slide01.51470934.20250919202325/clip_01.mp4 $FPS
sh scripts/inference.sh $CKPT imitation_motions/Terrain_lift/good/clips/slide01.51470934.20250919202325/clip_02.mp4 $FPS


# --- slide01.66920734.20250919202325 ---
sh scripts/inference.sh $CKPT imitation_motions/Terrain_lift/good/clips/slide01.66920734.20250919202325/clip_01.mp4 $FPS
sh scripts/inference.sh $CKPT imitation_motions/Terrain_lift/good/clips/slide01.66920734.20250919202325/clip_02.mp4 $FPS


# --- slide01.66920758.20250919202325 ---
sh scripts/inference.sh $CKPT imitation_motions/Terrain_lift/good/clips/slide01.66920758.20250919202325/clip_01.mp4 $FPS
sh scripts/inference.sh $CKPT imitation_motions/Terrain_lift/good/clips/slide01.66920758.20250919202325/clip_02.mp4 $FPS


# --- step01.51470934.20250919202352 ---
sh scripts/inference.sh $CKPT imitation_motions/Terrain_lift/good/clips/step01.51470934.20250919202352/clip_01.mp4 $FPS
sh scripts/inference.sh $CKPT imitation_motions/Terrain_lift/good/clips/step01.51470934.20250919202352/clip_02.mp4 $FPS


# --- step01.66920734.20250919202352 ---
sh scripts/inference.sh $CKPT imitation_motions/Terrain_lift/good/clips/step01.66920734.20250919202352/clip_01.mp4 $FPS
sh scripts/inference.sh $CKPT imitation_motions/Terrain_lift/good/clips/step01.66920734.20250919202352/clip_02.mp4 $FPS

# --- step01.66920758.20250919202352 ---
sh scripts/inference.sh $CKPT imitation_motions/Terrain_lift/good/clips/step01.66920758.20250919202352/clip_01.mp4 $FPS
sh scripts/inference.sh $CKPT imitation_motions/Terrain_lift/good/clips/step01.66920758.20250919202352/clip_02.mp4 $FPS


# --- slide02.51470934.20250919202344 ---
sh scripts/inference.sh $CKPT imitation_motions/Terrain_lift/bad/clips/slide02.51470934.20250919202344/clip_01.mp4 $FPS
sh scripts/inference.sh $CKPT imitation_motions/Terrain_lift/bad/clips/slide02.51470934.20250919202344/clip_02.mp4 $FPS
sh scripts/inference.sh $CKPT imitation_motions/Terrain_lift/bad/clips/slide02.51470934.20250919202344/clip_03.mp4 $FPS

# --- slide02.66920734.20250919202344 ---
sh scripts/inference.sh $CKPT imitation_motions/Terrain_lift/bad/clips/slide02.66920734.20250919202344/clip_01.mp4 $FPS
sh scripts/inference.sh $CKPT imitation_motions/Terrain_lift/bad/clips/slide02.66920734.20250919202344/clip_02.mp4 $FPS
sh scripts/inference.sh $CKPT imitation_motions/Terrain_lift/bad/clips/slide02.66920734.20250919202344/clip_03.mp4 $FPS

# --- slide02.66920758.20250919202344 ---
sh scripts/inference.sh $CKPT imitation_motions/Terrain_lift/bad/clips/slide02.66920758.20250919202344/clip_01.mp4 $FPS
sh scripts/inference.sh $CKPT imitation_motions/Terrain_lift/bad/clips/slide02.66920758.20250919202344/clip_02.mp4 $FPS
sh scripts/inference.sh $CKPT imitation_motions/Terrain_lift/bad/clips/slide02.66920758.20250919202344/clip_03.mp4 $FPS






CKPT="smplest_x_h"
FPS=30
# --- Dashboard ---
sh scripts/inference.sh $CKPT imitation_motions/Terrain_lift/dashboard/bad/bad.mov $FPS
sh scripts/inference.sh $CKPT imitation_motions/Terrain_lift/dashboard/good/good.mov $FPS


# bad examples:
sh scripts/inference.sh $CKPT imitation_motions/Lift/bad/clips/bag_bad_1.mp4 $FPS
sh scripts/inference.sh $CKPT imitation_motions/Lift/bad/clips/box_bad_1.mp4 $FPS
sh scripts/inference.sh $CKPT imitation_motions/Lift/bad/clips/box_okay_1.mp4 $FPS
sh scripts/inference.sh $CKPT imitation_motions/Lift/bad/clips/handle_bad_1.mp4 $FPS
sh scripts/inference.sh $CKPT imitation_motions/Lift/bad/clips/handle_okay_1.mp4 $FPS
sh scripts/inference.sh $CKPT imitation_motions/Lift/bad/clips/timber_bad_1.mp4 $FPS


sh scripts/inference.sh $CKPT imitation_motions/Lift/bad/clips/timber_bad_1.mp4 $FPS true