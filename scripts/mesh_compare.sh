#!/usr/bin/env bash
# Run this to generate mesh for mesh compare project, output is in demo folder, logs are used to track progress and resume
# bash scripts/mesh_compare.sh

# cp "/media/leyang/My Book3/VEHS/VEHS data collection round 3/processed/S01/FullCollection/"*.avi "/home/leyang/Documents/SMPLest-X/demo/VEHSR3R4/S01/"
# cp "/media/leyang/My Book3/VEHS/VEHS data collection round 3/processed/S05/FullCollection/"*.avi "/home/leyang/Documents/SMPLest-X/demo/VEHSR3R4/S05/"

CKPT="smplest_x_h"
FPS=20
SKIP_RENDER=true

# Create log directory
LOG_DIR="./logs"
mkdir -p "$LOG_DIR"
LOG_FILE="$LOG_DIR/inference_progress.log"

# Function to check if a video was already successfully processed
is_completed() {
    local video=$1
    grep -q "✓ SUCCESS.*$video" "$LOG_FILE" 2>/dev/null
    return $?
}

# Initialize log if it doesn't exist
if [ ! -f "$LOG_FILE" ]; then
    echo "Starting inference pipeline at $(date)" > "$LOG_FILE"
    echo "===========================================" >> "$LOG_FILE"
else
    echo "" >> "$LOG_FILE"
    echo "Resuming pipeline at $(date)" >> "$LOG_FILE"
    echo "===========================================" >> "$LOG_FILE"
fi

echo "Log file: $LOG_FILE"

# Get all .avi files from both directories
FILES=(
    demo/VEHSR3R4/S01/*.avi
    demo/VEHSR3R4/S05/*.avi
)

# Expand the glob patterns
AVI_FILES=()
for pattern in "${FILES[@]}"; do
    for file in $pattern; do
        if [ -f "$file" ]; then
            AVI_FILES+=("$file")
        fi
    done
done

TOTAL=${#AVI_FILES[@]}
CURRENT=0
SKIPPED=0

for VIDEO in "${AVI_FILES[@]}"; do
    CURRENT=$((CURRENT + 1))
    
    # Skip if already completed
    if is_completed "$VIDEO"; then
        echo "[$CURRENT/$TOTAL] SKIPPING (already completed): $VIDEO" | tee -a "$LOG_FILE"
        SKIPPED=$((SKIPPED + 1))
        continue
    fi
    
    echo "" | tee -a "$LOG_FILE"
    echo "[$CURRENT/$TOTAL] $VIDEO" | tee -a "$LOG_FILE"
    
    START_TIME=$(date +%s)
    START_DISPLAY=$(date +"%Y-%m-%d %H:%M:%S")
    echo "  Started:  $START_DISPLAY" | tee -a "$LOG_FILE"
    
    # Remove the first directory component from VIDEO path
    VIDEO_BASE="${VIDEO#*/}"  # Removes everything up to and including the first /

    # Run inference
    sh scripts/inference.sh "$CKPT" "$VIDEO_BASE" "$FPS" "$SKIP_RENDER" #> /dev/null 2>&1
    
    EXIT_CODE=$?
    END_TIME=$(date +%s)
    END_DISPLAY=$(date +"%Y-%m-%d %H:%M:%S")
    DURATION=$((END_TIME - START_TIME))
    
    echo "  Ended:    $END_DISPLAY" | tee -a "$LOG_FILE"
    echo "  Duration: ${DURATION}s" | tee -a "$LOG_FILE"
    
    if [ $EXIT_CODE -eq 0 ]; then
        echo "  Status:   ✓ SUCCESS - $VIDEO" | tee -a "$LOG_FILE"
    else
        echo "  Status:   ✗ FAILED (exit code: $EXIT_CODE) - $VIDEO" | tee -a "$LOG_FILE"
    fi
    
    # Cooldown period between videos
    if [ $CURRENT -lt $TOTAL ]; then
        echo "  Waiting 15s..." | tee -a "$LOG_FILE"
        sleep 15
    fi
done

echo "" | tee -a "$LOG_FILE"
echo "===========================================" | tee -a "$LOG_FILE"
echo "Pipeline completed at $(date)" | tee -a "$LOG_FILE"
echo "Total videos: $TOTAL | Processed: $((TOTAL - SKIPPED)) | Skipped: $SKIPPED" | tee -a "$LOG_FILE"
echo "Log saved to: $LOG_FILE" | tee -a "$LOG_FILE"