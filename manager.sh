
#!/bin/bash

echo "=== MY FIRST BASH FILE MANAGER ==="

read -r -p "What is your name? " username
echo "Hello, $username!"

pause() {
    echo
    read -r -p "Press Enter to continue..."
}

while true; do
    echo
    echo "================================"
    echo "         FILE MANAGER"
    echo "================================"
    echo "Current directory: $PWD"
    echo
    echo "1. Create file"
    echo "2. Create directory"
    echo "3. Show current directory"
    echo "4. Show files"
    echo "5. Change directory"
    echo "6. Delete file"
    echo "7. Delete directory"
    echo "8. Rename file or directory"
    echo "9. Copy file"
    echo "10. Move file or directory"
    echo "11. Show hidden files"
    echo "0. Exit"
    echo "================================"

    read -r -p "Choose an option: " choice

    case "$choice" in

        1)
            read -r -p "Enter file name: " filename

            if [[ -z "$filename" ]]; then
                echo "Error: Empty file name!"
            elif [[ -e "$filename" ]]; then
                echo "Error: File already exists!"
            elif touch -- "$filename"; then
                echo "File created successfully!"
            else
                echo "Error: Failed to create file."
            fi
            ;;

        2)
            read -r -p "Enter directory name: " dirname

            if [[ -z "$dirname" ]]; then
                echo "Error: Empty directory name!"
            elif mkdir -- "$dirname"; then
                echo "Directory created successfully!"
            else
                echo "Error: Failed to create directory."
            fi
            ;;

        3)
            echo "Current directory:"
            pwd
            ;;

        4)
            echo "Files and directories:"
            ls -lh --color=auto
            ;;

        5)
            read -r -p "Enter directory path: " path

            if [[ -d "$path" ]]; then
                if cd -- "$path"; then
                    echo "Directory changed successfully!"
                else
                    echo "Error: Access denied!"
                fi
            else
                echo "Error: Directory not found!"
            fi
            ;;

        6)
            read -r -p "Enter file name to delete: " filename

            if [[ -f "$filename" || -L "$filename" ]]; then
                read -r -p "Are you sure? (y/n): " confirm

                if [[ "$confirm" == "y" ]]; then
                    if rm -- "$filename"; then
                        echo "File deleted successfully!"
                    else
                        echo "Error: Failed to delete file."
                    fi
                else
                    echo "Deletion cancelled."
                fi
            else
                echo "Error: File not found!"
            fi
            ;;

        7)
            read -r -p "Enter directory name to delete: " dirname

            if [[ -d "$dirname" && ! -L "$dirname" ]]; then
                read -r -p "Delete directory and ALL its contents? (y/n): " confirm

                if [[ "$confirm" == "y" ]]; then
                    if rm -rI -- "$dirname"; then
                        echo "Directory deletion completed!"
                    else
                        echo "Error: Failed to delete directory."
                    fi
                else
                    echo "Deletion cancelled."
                fi
            else
                echo "Error: Directory not found!"
            fi
            ;;

        8)
            read -r -p "Enter current name: " oldname
            read -r -p "Enter new name: " newname

            if [[ -z "$oldname" || -z "$newname" ]]; then
                echo "Error: Name cannot be empty!"
            elif [[ ! -e "$oldname" && ! -L "$oldname" ]]; then
                echo "Error: File or directory not found!"
            elif mv -n -- "$oldname" "$newname"; then
                echo "Rename operation completed!"
            else
                echo "Error: Rename failed!"
            fi
            ;;

        9)
            read -r -p "Enter source file: " source
            read -r -p "Enter destination: " destination

            if [[ -f "$source" ]]; then
                if cp -in -- "$source" "$destination"; then
                    echo "Copy operation completed!"
                else
                    echo "Error: Copy failed!"
                fi
            else
                echo "Error: Source file not found!"
            fi
            ;;

        10)
            read -r -p "Enter source: " source
            read -r -p "Enter destination: " destination

            if [[ -e "$source" || -L "$source" ]]; then
                if mv -in -- "$source" "$destination"; then
                    echo "Move operation completed!"
                else
                    echo "Error: Move failed!"
                fi
            else
                echo "Error: Source not found!"
            fi
            ;;

        11)
            echo "All files (including hidden):"
            ls -lah --color=auto
            ;;

        0)
            echo "Goodbye, $username!"
            exit 0
            ;;

        *)
            echo "Error: Invalid option!"
            ;;
    esac

    pause
done
