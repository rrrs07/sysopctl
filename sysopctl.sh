#!/bin/bash

VERSION="v0.1.0"

# Display Help
function show_help() {
    cat << EOF
Usage: sysopctl [command] [options]

Commands:
  --help                 Show this help message
  --version              Show command version
  service list           List all active services
  service start <name>   Start a specified service
  service stop <name>    Stop a specified service
  system load            Show current system load
  disk usage             Display disk usage by partition
  process monitor        Monitor real-time system processes
  logs analyze           Analyze and summarize critical logs
  backup <path>          Backup system files from the specified path

EOF
}

# Display Version
function show_version() {
    echo "sysopctl version $VERSION"
}

# List Active Services
function list_services() {
    echo "Listing active services..."
    systemctl list-units --type=service
}

# Manage Services
function manage_service() {
    if [ "$1" == "start" ]; then
        echo "Starting service $2..."
        systemctl start "$2"
    elif [ "$1" == "stop" ]; then
        echo "Stopping service $2..."
        systemctl stop "$2"
    else
        echo "Invalid service command. Use start or stop."
    fi
}

# Display System Load
function show_system_load() {
    echo "Current system load:"
    uptime
}

# Display Disk Usage
function show_disk_usage() {
    echo "Disk usage by partition:"
    df -h
}

# Monitor Processes
function monitor_processes() {
    echo "Real-time process monitoring (press Ctrl+C to exit):"
    top
}

# Analyze Logs
function analyze_logs() {
    echo "Analyzing system logs..."
    journalctl -p crit -n 10
}

# Backup System Files
function backup_files() {
    if [ -z "$1" ]; then
        echo "Please specify a path to backup."
        return
    fi
    echo "Backing up files from $1..."
    rsync -av --progress "$1" /backup/
}

# Main Command Handling
case $1 in
    --help)
        show_help
        ;;
    --version)
        show_version
        ;;
    service)
        if [ "$2" == "list" ]; then
            list_services
        else
            manage_service "$2" "$3"
        fi
        ;;
    system)
        if [ "$2" == "load" ]; then
            show_system_load
        else
            echo "Unknown system command."
        fi
        ;;
    disk)
        if [ "$2" == "usage" ]; then
            show_disk_usage
        else
            echo "Unknown disk command."
        fi
        ;;
    process)
        if [ "$2" == "monitor" ]; then
            monitor_processes
        else
            echo "Unknown process command."
        fi
        ;;
    logs)
        if [ "$2" == "analyze" ]; then
            analyze_logs
        else
            echo "Unknown logs command."
        fi
        ;;
    backup)
        backup_files "$2"
        ;;
    *)
        echo "Invalid command. Use --help for usage."
        ;;
esac