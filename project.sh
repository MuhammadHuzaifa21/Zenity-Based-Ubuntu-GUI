============================

#!/bin/bash

# Function to show Ubuntu system information
function show_system_info {
    info=$(lsb_release -ds)
    zenity --info --title "System Information" --text "Ubuntu System Information:\n$info"
    show_menu
}

# Function to create a new directory
function create_directory {
    directory=$(zenity --file-selection --directory --title "Select Directory to Create New Folder")
    if [ -n "$directory" ]; then
        new_folder=$(zenity --entry --title "Create Directory" --text "Enter the name of the new directory:")
        if [ -n "$new_folder" ]; then
            mkdir "$directory/$new_folder"
            zenity --info --title "Directory Created" --text "New directory '$new_folder' created successfully."
        else
            zenity --warning --title "Invalid Input" --text "No directory name entered."
        fi
    fi
    show_menu
}

# Function to delete a directory
function delete_directory {
    directory=$(zenity --file-selection --directory --title "Select Directory to Delete")
    if [ -n "$directory" ]; then
        rm -r "$directory"
        zenity --info --title "Directory Deleted" --text "Directory deleted successfully."
    fi
    show_menu
}

# Function to open a file explorer
function open_file_explorer {
    zenity --file-selection --title "File Explorer"
    show_menu
}

# Function to add a file
function add_file {
    directory=$(zenity --file-selection --directory --title "Select Directory to Add File")
    if [ -n "$directory" ]; then
        file=$(zenity --file-selection --title "Select File to Add")
        if [ -n "$file" ]; then
            cp "$file" "$directory"
            zenity --info --title "File Added" --text "File added to directory successfully."
        fi
    fi
    show_menu
}

# Function to delete a file
function delete_file {
    file=$(zenity --file-selection --title "Select File to Delete")
    if [ -n "$file" ]; then
        rm "$file"
        zenity --info --title "File Deleted" --text "File deleted successfully."
    fi
    show_menu
}

# Function to update a file
function update_file {
    file=$(zenity --file-selection --title "Select File to Update")
    if [ -n "$file" ]; then
        text=$(zenity --text-info --editable --title "Update File" --filename "$file")
        if [ -n "$text" ]; then
            echo "$text" > "$file"
            zenity --info --title "File Updated" --text "File updated successfully."
        fi
    fi
    show_menu
}

# Function to copy and paste a file
function copy_paste_file {
    source=$(zenity --file-selection --title "Select File to Copy")
    if [ -n "$source" ]; then
        destination=$(zenity --file-selection --directory --title "Select Destination Directory")
        if [ -n "$destination" ]; then
            cp "$source" "$destination"
            zenity --info --title "File Copied" --text "File copied successfully."
        fi
    fi
    show_menu
}

# Function to list processes
function list_processes {
    processes=$(ps aux)
    zenity --text-info --title "Processes" --width 800 --height 600 --filename=/dev/stdin <<< "$processes"
   
    show_menu
}

# Function to shut down the system
function shut_down {
    zenity --question --title "Shutdown" --text "Are you sure you want to shut down the system?"
    if [ $? = 0 ]; then
        shutdown -h now
    fi
}

# Function to display the main menu
# Function to display the main menu
# Function to display the main menu
function show_menu {
    choice=$(zenity --list --title "MICRO-OS" --text "Choose option:" --column "Option" \
    "Show Ubuntu System Information" "Create a New Directory" "Delete Directory" \
    "File Explorer" "Add File" "Delete File" "Update File" \
    "Copy and Paste File" "List Processes" "Shutdown" "Exit" \
    --height 400 --width 400)

    # Check if cancel button or close button is clicked
    if [ -z "$choice" ]; then
        exit 0  # Close the GUI
    fi

    case "$choice" in
        "Show Ubuntu System Information")
            show_system_info
            ;;
        "Create a New Directory")
            create_directory
            ;;
        "Delete Directory")
            delete_directory
            ;;
        "File Explorer")
            open_file_explorer
            ;;
        "Add File")
            add_file
            ;;
        "Delete File")
            delete_file
            ;;
        "Update File")
            update_file
            ;;
        "Copy and Paste File")
            copy_paste_file
            ;;
        "List Processes")
            list_processes
            ;;
        "Shutdown")
            shut_down
            ;;
        "Exit")
            exit 0  # Close the GUI
            ;;
        *)
            zenity --error --title "Invalid Option" --text "Invalid option selected."
            show_menu
            ;;
    esac
}

# Display the initial menu
show_menu
