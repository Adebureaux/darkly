#!/bin/bash

# Directory containing downloaded files
OUTPUT_DIR="./downloaded_files"

# File to store results
RESULTS_FILE="search_results.txt"
> "$RESULTS_FILE" # Clear the file on each run

# Search for "flag" or digits in README files
echo "Searching for 'flag' or digits in README files..."
for file in "$OUTPUT_DIR"/README*; do
    if grep -Eiq "flag|[0-9]" "$file"; then
        echo "Match found in $file:" >> "$RESULTS_FILE"
        grep -Eio "flag|[0-9]+" "$file" >> "$RESULTS_FILE"
        echo "----" >> "$RESULTS_FILE"
    fi
done

# Display results
if [[ -s "$RESULTS_FILE" ]]; then
    echo "Search completed. Results saved to $RESULTS_FILE."
    cat "$RESULTS_FILE"
else
    echo "No matches found."
fi
