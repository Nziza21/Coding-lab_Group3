#!/bin/bash

ACTIVE_DIR="hospital_data/active_logs"
HEART_ARCHIVE="archive/heart_data_archive"
TEMP_ARCHIVE="archive/temp_data_archive"
WATER_ARCHIVE="archive/water_data_archive"

mkdir -p "$HEART_ARCHIVE" "$TEMP_ARCHIVE" "$WATER_ARCHIVE"

echo ""
echo "Select log to archive:"
echo "1) Heart Rate (heart_rate.log)"
echo "2) Temperature (temperature.log)"
echo "3) Water Usage (water_usage.log)"
read -p "Enter choice (1-3): " choice

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")

case "$choice" in
  1)
    SRC="$ACTIVE_DIR/heart_rate.log"
    DEST="$HEART_ARCHIVE/heart_rate_$TIMESTAMP.log"
    ;;
  2)
    SRC="$ACTIVE_DIR/temperature.log"
    DEST="$TEMP_ARCHIVE/temperature_$TIMESTAMP.log"
    ;;
  3)
    SRC="$ACTIVE_DIR/water_usage.log"
    DEST="$WATER_ARCHIVE/water_usage_$TIMESTAMP.log"
    ;;
  *)
    echo " Invalid choice. Please run again and enter 1, 2, or 3."
    exit 1
    ;;
esac

if [ -f "$SRC" ]; then
  echo "Archiving $SRC ..."
  mv "$SRC" "$DEST" || { echo " Failed to move file."; exit 1; }
  touch "$SRC" || { echo " Failed to create new log file."; exit 1; }
  echo " Successfully archived to: $DEST"
else
  echo " Error: Active log not found at $SRC"
  exit 1
fi
