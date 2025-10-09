#!/bin/bash
echo "Select log file to analyze:"
echo "1) Heart Rate (heart_rate.log)"
echo "2) Temperature (temperature.log)"
echo "3) Water Usage (water_usage.log)"
read -p "Enter choice (1-3): " choice

case $choice in
    1) logfile="hospital_data/active_logs/heart_rate.log" ;;
    2) logfile="hospital_data/active_logs/temperature.log" ;;
    3) logfile="hospital_data/active_logs/water_usage.log" ;;
    *) echo "Invalid choice! Exiting..."; exit 1 ;;
esac

if [ ! -f "$logfile" ]; then
    echo "Log file not found! Exiting..."
    exit 1
fi

echo "Analysis for $logfile" >> reports/analysis_report.txt
echo "Analysis run on $(date)" >> reports/analysis_report.txt

awk '{print $2}' "$logfile" | sort | uniq -c >> reports/analysis_report.txt

first=$(head -n 1 "$logfile" | awk '{print $1}')
last=$(tail -n 1 "$logfile" | awk '{print $1}')
echo "First entry: $first" >> reports/analysis_report.txt
echo "Last entry: $last" >> reports/analysis_report.txt

echo "----------------------------------------" >> reports/analysis_report.txt
echo "Analysis completed! Check reports/analysis_report.txt"

