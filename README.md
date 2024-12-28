# sysopctl

## Version and Help
### VERSION="v0.1.0": Defines the version of the script.
### show_help: Displays a help menu with a list of supported commands and their descriptions.
### It uses cat << EOF to display a multi-line text block for easy readability.

## Command Categories
### The script supports various commands categorized under service management, system monitoring, logs analysis, disk usage, and file backup.

## Service Management
### list_services:
### Executes systemctl list-units --type=service to list all active services.
### manage_service:
### Accepts start or stop as the first argument and a service name as the second argument.
### Uses systemctl start <name> and systemctl stop <name> to manage services.
System Monitoring
show_system_load:
Executes uptime to display the system's current load and uptime information.
monitor_processes:
Launches top for real-time process monitoring.
Disk Management
show_disk_usage:
Executes df -h to display disk usage for all partitions in a human-readable format.
Logs Analysis
analyze_logs:
Uses journalctl -p crit -n 10 to retrieve the last 10 critical logs.
Backup
backup_files:
Uses rsync -av --progress to back up files from a user-specified path to /backup/.
3. Command-Line Parsing
The script uses a case statement to parse and handle commands based on the first argument ($1):

--help:
Displays the help menu using show_help.
--version:
Displays the version using show_version.
service:
Handles subcommands (list, start, or stop) for managing services.
system:
Handles load to show system load.
disk:
Handles usage to display disk usage.
process:
Handles monitor to start real-time process monitoring.
logs:
Handles analyze to analyze logs.
backup:
Handles backup functionality using rsync.
Default:
Displays an error message for invalid commands.
4. Key Highlights
Error Handling:
The script checks for missing arguments (e.g., in manage_service and backup_files) and provides meaningful error messages.
Command Abstraction:
Each functionality is modularized into its own function, improving code readability and maintainability.
Disk and Log Management:
Simplifies disk usage monitoring and critical log analysis, tasks often needed by sysadmins.
5. Example Usage
Help and Version:

bash
Copy code
./sysopctl --help
./sysopctl --version
Service Management:

bash
Copy code
./sysopctl service list
./sysopctl service start nginx
./sysopctl service stop apache2
System Load and Disk Usage:

bash
Copy code
./sysopctl system load
./sysopctl disk usage
Process Monitoring:

bash
Copy code
./sysopctl process monitor
Logs Analysis:

bash
Copy code
./sysopctl logs analyze
Backup:

bash
Copy code
./sysopctl backup /var/www
Potential Enhancements
Input Validation:
Validate the existence of directories in the backup function.
Check if the provided service name is valid.
Error Handling:
Capture errors for commands like systemctl and rsync and display helpful messages.
Extend Logging:
Allow users to specify log severity or fetch logs from a specific time range.
Colorized Output:
Use tools like tput for enhanced readability in the terminal.
