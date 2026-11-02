
#!/bin/bash

# System Monitoring Tool
# Developed by: Krish Arora
# UID: 25BCA10278

LOG_FILE="monitor.log"
REPORT_FILE="system_report.txt"

log_action() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

system_info() {
    echo "----- SYSTEM INFORMATION -----"
    echo "Hostname: $(hostname)"
    echo "Operating System: $(grep PRETTY_NAME /etc/os-release | cut -d '"' -f 2)"
    echo "Kernel: $(uname -r)"
    echo "Architecture: $(uname -m)"
}

cpu_usage() {
    echo "----- CPU USAGE -----"
    read -r cpu user nice system idle rest < /proc/stat
    total1=$((user + nice + system + idle))
    idle1=$idle
    sleep 1
    read -r cpu user nice system idle rest < /proc/stat
    total2=$((user + nice + system + idle))
    idle2=$idle
    total_diff=$((total2 - total1))
    idle_diff=$((idle2 - idle1))

    if [ "$total_diff" -gt 0 ]; then
        usage=$(( (total_diff - idle_diff) * 100 / total_diff ))
        echo "CPU Usage: $usage%"
    else
        echo "CPU usage could not be calculated."
    fi
}

memory_usage() {
    echo "----- MEMORY USAGE -----"
    free -h
    total=$(awk '/MemTotal/ {print $2}' /proc/meminfo)
    available=$(awk '/MemAvailable/ {print $2}' /proc/meminfo)
    used=$((total - available))
    percentage=$((used * 100 / total))
    echo "Memory Usage: $percentage%"
}

disk_usage() {
    echo "----- DISK USAGE -----"
    df -h /
}

system_uptime() {
    echo "----- SYSTEM UPTIME -----"
    uptime -p
}

logged_users() {
    echo "----- LOGGED-IN USERS -----"
    who
}

running_processes() {
    echo "----- TOP RUNNING PROCESSES -----"
    ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -n 11
}

network_info() {
    echo "----- NETWORK INFORMATION -----"
    ip -brief address
}

generate_report() {
    {
        echo "SYSTEM MONITORING REPORT"
        echo "Generated: $(date)"
        echo "=============================="
        system_info
        echo
        cpu_usage
        echo
        memory_usage
        echo
        disk_usage
        echo
        system_uptime
        echo
        logged_users
        echo
        running_processes
        echo
        network_info
    } > "$REPORT_FILE"

    echo "Report saved successfully in $REPORT_FILE"
    log_action "System report generated"
}

view_log() {
    echo "----- ACTIVITY LOG -----"
    if [ -f "$LOG_FILE" ]; then
        cat "$LOG_FILE"
    else
        echo "No activity recorded yet."
    fi
}

while true
do
    echo
    echo "=================================="
    echo "      SYSTEM MONITORING TOOL"
    echo "=================================="
    echo "1. System Information"
    echo "2. CPU Usage"
    echo "3. Memory Usage"
    echo "4. Disk Usage"
    echo "5. System Uptime"
    echo "6. Logged-in Users"
    echo "7. Running Processes"
    echo "8. Network Information"
    echo "9. Generate System Report"
    echo "10. View Activity Log"
    echo "11. Exit"
    echo "=================================="

    read -p "Enter your choice: " choice

    case $choice in
        1) system_info; log_action "Viewed system information" ;;
        2) cpu_usage; log_action "Checked CPU usage" ;;
        3) memory_usage; log_action "Checked memory usage" ;;
        4) disk_usage; log_action "Checked disk usage" ;;
        5) system_uptime; log_action "Checked system uptime" ;;
        6) logged_users; log_action "Viewed logged-in users" ;;
        7) running_processes; log_action "Viewed running processes" ;;
        8) network_info; log_action "Viewed network information" ;;
        9) generate_report ;;
        10) view_log ;;
        11)
            echo "Thank you for using System Monitoring Tool!"
            log_action "Exited program"
            break
            ;;
        *) echo "Invalid choice! Please try again." ;;
    esac
done
