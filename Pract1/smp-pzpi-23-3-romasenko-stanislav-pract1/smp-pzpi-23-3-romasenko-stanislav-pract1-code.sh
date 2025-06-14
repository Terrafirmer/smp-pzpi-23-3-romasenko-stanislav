#!/bin/bash

print_centered() {
    local content="$1"
    local width="$2"
    local padding=$(( (width - ${#content}) / 2 ))
    local line=""
    for ((i = 0; i < padding; i++)); do
        line+=" "
    done
    line+="$content"
    echo "$line"
}
if [ $# -ne 2 ]; then
    echo "Помилка: потрібно ввести два параметри: висоту і ширину." >&2
    exit 1
fi
H=$(($1 / 1))
W=$(($2 / 1))
TRUNK_HEIGHT=2
SNOW_HEIGHT=1
TRUNK_WIDTH=3
LAYER_WIDTH=$((W - 2))
TOTAL_BRANCH_LINES=$((H - TRUNK_HEIGHT - SNOW_HEIGHT))
if [ "$TOTAL_BRANCH_LINES" -lt 6 ] || [ "$LAYER_WIDTH" -lt 5 ]; then
    echo "Помилка: неможливо побудувати ялинку з такими параметрами." >&2
    exit 2
fi
LINES_PER_LAYER=$((TOTAL_BRANCH_LINES / 2))
draw_layer() {
    local lines=$1
    local max_width=$2
    local width=1
    local i=0
    while [ $i -lt $lines ]; do
        if (( i % 2 == 0 )); then
            char="*"
        else
            char="#"
        fi
        if [ $width -gt $max_width ]; then
            break
        fi
        line=""
        for ((j = 0; j < width; j++)); do
            line+="$char"
        done
        print_centered "$line" "$W"
        i=$((i + 1))
        width=$((width + 2))
    done
}
for round in 1 2; do
    draw_layer "$LINES_PER_LAYER" "$LAYER_WIDTH"
done
count=0
while [ $count -lt $TRUNK_HEIGHT ]; do
    print_centered "###" "$W"
    count=$((count + 1))
done
for ((i=0; i<W; i++)); do
    echo -n "*"
done
echo
