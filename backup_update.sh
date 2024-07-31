#!/bin/bash

# Function to check if a file has changed and update the backup
update_catalog_backup() {
    local default_dir="$1"        # The default directory containing the files
    local filename="$2"           # The name of the file to check
    local backup_dir="$3"         # The directory containing the backup files

    # Construct full paths to the original and backup files
    local file_path="${default_dir}/${filename}"
    local backup_path="${backup_dir}/${filename}"

    # Check if the original file exists
    if [[ ! -f "$file_path" ]]; then
        echo "File $file_path does not exist."
        return 1
    fi

    # Check if the backup file exists
    if [[ ! -f "$backup_path" ]]; then
        echo "Backup file $backup_path does not exist. Creating a new backup."
        cp "$file_path" "$backup_path"
        echo "Backup created."
    else
        # Compare the files and update the backup if there are changes
        if ! diff -q "$file_path" "$backup_path" >/dev/null; then
            echo "Changes detected in $filename. Updating backup."
            cp "$file_path" "$backup_path"
            echo "Backup updated."
        else
            echo "No changes detected in $filename."
        fi
    fi
}

# Example usage:
# update_catalog_backup "/path/to/default/dir" "file.txt" "/path/to/backup/dir"

# Notes:

## make the script executable
## `chmod +x sites_spectral_catalog_backup_update.sh`

## Source the script
## Source the script in your terminal session or add it to your .bashrc or .bash_profile to make it available in all sessions:
## `source /path/to/sites_spectral_catalog_backup_update.sh`


