#!/bin/bash

ACTIVE_LOG_DIR="hospital_data/active_logs"
ARCHIVE_BASE_DIR="hospital_data/archive_logs"


echo "Select a log file to archive:"
echo "  1) Heart Rate (heart_rate_log.log)"
echo "  2) Temperature (temperature_log.log)"
echo "  3) Water Usage (water_usage_log.log)"
read -p "Enter choice (1-3): " choice


case $choice in
  1)
    log_name="heart_rate_log.log"
    archive_subdir="heart_data_archive"
    ;;
  2)
    log_name="temperature_log.log"
    archive_subdir="temp_data_archive"
    ;;
  3)
    log_name="water_usage_log.log"
    archive_subdir="water_data_archive"
    ;;
  *)
    
    echo "Error: Invalid choice. Please enter a number between 1 and 3."
    exit 1
    ;;
esac


source_file="$ACTIVE_LOG_DIR/$log_name"
archive_dir="$ARCHIVE_BASE_DIR/$archive_subdir"

if [ ! -f "$source_file" ]; then
  echo "Error: Log file not found at '$source_file'."
  echo "Please ensure the simulators are running and have created the log files."
  exit 1
fi

echo "Archiving $log_name..."

mkdir -p "$archive_dir"
if [ $? -ne 0 ]; then
    echo "Error: Could not create archive directory '$archive_dir'. Please check permissions."
    exit 1
fi


timestamp=$(date +'%Y-%m-%d_%H:%M:%S')

base_name=$(basename "$log_name" .log)
archive_filename="${base_name}_${timestamp}.log"

mv "$source_file" "$archive_dir/$archive_filename"


if [ $? -eq 0 ]; then
  echo "✔ Successfully archived to $archive_dir/$archive_filename"
else
 
  echo "Error: Failed to move '$source_file'."
  exit 1
fi

touch "$source_file"
echo "✔ New empty log file created at '$source_file'."

exit 0
