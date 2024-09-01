#!/bin/bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

output_file="$CURRENT_DIR/output.txt"
echo "" >"$output_file"

for file in "$CURRENT_DIR"/*.sh; do
	if [ "$file" != "$CURRENT_DIR/temp.sh" ]; then
		base=${file##*/}
		{
			echo "Filename: $base"
			echo -e "Content:\n"
			cat "$file"
			echo ""
		} >>"$output_file"
	fi
done

echo "Output file: $output_file created"
