#!/bin/bash
# Quick script to check task progress in tasks.md

echo "=== Neovim Claude Integration - Task Progress ==="
echo

# Count total tasks and completed tasks
total=$(grep -c "^\s*- \[" tasks.md)
completed=$(grep -c "^\s*- \[x\]" tasks.md)
percentage=$((completed * 100 / total))

echo "Overall Progress: $completed/$total ($percentage%)"
echo

# Show progress by section
echo "Progress by Feature:"
echo "-------------------"

current_section=""
section_total=0
section_completed=0

while IFS= read -r line; do
    # Check for section headers
    if [[ $line =~ ^###[[:space:]]([0-9]+\.[[:space:]].+) ]]; then
        # Print previous section stats if any
        if [[ -n $current_section ]] && (( section_total > 0 )); then
            section_percentage=$((section_completed * 100 / section_total))
            printf "%-40s %3d/%3d (%3d%%)\n" "$current_section" "$section_completed" "$section_total" "$section_percentage"
        fi
        
        # Start new section
        current_section="${BASH_REMATCH[1]}"
        section_total=0
        section_completed=0
    fi
    
    # Count tasks in current section
    if [[ $line =~ ^[[:space:]]*-[[:space:]]\[([[:space:]]|x)\] ]]; then
        ((section_total++))
        if [[ ${BASH_REMATCH[1]} == "x" ]]; then
            ((section_completed++))
        fi
    fi
done < tasks.md

# Print last section
if [[ -n $current_section ]] && (( section_total > 0 )); then
    section_percentage=$((section_completed * 100 / section_total))
    printf "%-40s %3d/%3d (%3d%%)\n" "$current_section" "$section_completed" "$section_total" "$section_percentage"
fi

echo
echo "Next uncompleted tasks:"
echo "----------------------"
grep -n "^\s*- \[ \]" tasks.md | head -5 | while IFS= read -r line; do
    echo "$line"
done 