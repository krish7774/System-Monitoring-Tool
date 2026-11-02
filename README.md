
# System Monitoring Tool Using Shell Scripting

## Project Details
- Name: Krish Arora
- UID: 25BCA10278
- Class: BCA-1(A)
- University: Chandigarh University

## Introduction
The System Monitoring Tool is a menu-driven project developed using Bash Shell Scripting in Ubuntu Linux. It helps users monitor CPU, memory, disk space, system uptime, running processes and network information.

## Features
1. System Information
2. CPU Usage
3. Memory Usage
4. Disk Usage
5. System Uptime
6. Logged-in Users
7. Running Processes
8. Network Information
9. Generate System Report
10. View Activity Log
11. Exit

## Technologies Used
- Ubuntu Linux
- Bash Shell Scripting
- GNU Nano
- Git and GitHub

## Project Files
- monitor.sh - Main Bash script
- monitor.log - Activity log
- system_report.txt - Generated system report
- README.md - Project documentation

## How to Run

1. Open the project directory.
2. Give execution permission:

   chmod +x monitor.sh

3. Run the program:

   ./monitor.sh

## Commands Used
- free -h : Displays memory usage.
- df -h : Displays disk usage.
- uptime -p : Displays system uptime.
- ps : Displays running processes.
- who : Displays logged-in users.
- uname : Displays kernel information.
- ip -brief address : Displays network information.

## Conclusion
This project provides a simple way to monitor important system resources using Bash Shell Scripting. It helped in understanding Linux commands, system monitoring and automation.
