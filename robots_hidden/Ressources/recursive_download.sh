#!/bin/bash

# Base URL of the hidden directory
BASE_URL="http://192.168.1.33/.hidden"

# Directory to store all files
OUTPUT_DIR="./downloaded_files"

# Create the output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# File to track visited directories
VISITED="./visited_dirs.txt"
> "$VISITED" # Clear the file on each run

# Counter for unique README filenames
readme_counter=0

# Function to recursively download files
fetch_files() {
    local current_url=$1

    # Check if this directory has already been visited
    if grep -Fxq "$current_url" "$VISITED"; then
        echo "Already visited: $current_url"
        return
    fi

    # Mark the current directory as visited
    echo "$current_url" >> "$VISITED"

    # Fetch the list of links in the current directory
    links=$(curl -s "$current_url/" | grep href | cut -d'"' -f2)

    for link in $links; do
        if [[ "$link" == "../" ]]; then
            continue
        elif [[ "$link" == */ ]]; then
            # If the link is a directory, recurse into it
            fetch_files "$current_url/$link"
        else
            # Process files
            if [[ "$link" =~ README ]]; then
                # Unique naming for README files
                ((readme_counter++))
                output_file="README$readme_counter"
            else
                # Preserve the original filename for non-README files
                output_file="$link"
            fi

            # Download the file
            echo "Downloading $current_url/$link as $output_file"
            curl -s -o "$OUTPUT_DIR/$output_file" "$current_url/$link"
        fi
    done
}

# Start the recursive fetch from the base URL
echo "Fetching files from $BASE_URL..."
fetch_files "$BASE_URL"

echo "All files are stored in $OUTPUT_DIR"
