#!/bin/bash

# Configuration variables
source_directory="/path/to/source_directory"  # Replace with your source directory path
remote_host="user@remote_host"  # Replace with your remote server SSH username and hostname/IP
remote_directory="/path/to/remote_directory"  # Replace with your remote directory path

# Backup log file
log_file="backup_report.txt"

# Function to log messages with timestamp
log_message() {
    local log_content="$1"
    echo "$(date +'%Y-%m-%d %H:%M:%S') - $log_content" >> "$log_file"
}

# Perform backup using rsync
log_message "Starting backup process..."

rsync -avz --delete --exclude='*.tmp' "$source_directory" "$remote_host:$remote_directory" >> "$log_file" 2>&1

# Check rsync exit status
rsync_exit_status=$?

# Check if rsync operation was successful
if [ $rsync_exit_status -eq 0 ]; then
    log_message "Backup completed successfully."
else
    log_message "Backup failed with error code $rsync_exit_status."
fi

# End of script
log_message "Backup process completed."

# Display backup report
echo "Backup report:"
echo "--------------"
cat "$log_file"
