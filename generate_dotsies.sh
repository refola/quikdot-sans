#!/bin/bash
# generate_dotsies.sh
# Systematically generate Dotsies glyph files for font import.

here="$(dirname "$(readlink -f "$0")")"
# Be here now, because absolute coordinates are a pain.
cd "$here" || exit 1

## get-svg feature
# Returns SVG code for the given feature. Valid codes are as follows:
# - head   SVG header
# - 1-5    dot positions, counting from bottom
# - cap    capitalization dot
# - foot   SVG footer
get-svg() {
    case "$1" in
        "head")
            echo '<svg width="3" height="18">'
            ;;
        1|2|3|4|5)
            printf $'\t''<rect width="3" height="3" fill="black" x="0" y="%s" />' \
                   $((18-3*$1))
            ;;
        "cap")
            echo $'\t''<rect width="1" height="2" fill="black" x="1" y="0" />'
            ;;
        "foot")
            echo '</svg>'
            ;;
        esac
}

## generate magic_string [caps]
# Generate font glyphs in ./dotsies/ according to the given magic
# string, optionally with capitalization dots. Magic string positions
# indicate which dots to include by counting up in binary, with "upper
# big endian" encoding. For example, position 0 is no dots, 1 is the
# bottom dot, 16 is the top dot, and 31 is all 5 dots. Spaces indicate
# skipped characters.
## Examples (only valid examples for canonical Dotsies; change for
## your own permutation):
# generate " ediclhvbnkugtsøaomyjxræfwqzpÆØß"
# generate " EDICLHVBNKUGTS AOMYJXR FWQZP  ẞ" caps
generate() {
    # 1. add header
    # 2. determine dot positions from index
    # 3. add each applicable dot (dot template with offset info)
    # 4. add caps dot if applicabple
    # 5. add footer
    # 6. write to file
    local i char image dots pos n=$'\n'
    for i in {0..31}; do
        char="${1:$i:1}"
        if [ "$char" = " " ] && ([ "$i" != 0 ] || [ -n "$2" ]); then
            continue
        fi
        image="$(get-svg head)$n"
        dots=$i
        for pos in {1..5}; do
            if [ $((dots%2)) -eq 1 ]; then
                image+="$(get-svg $pos)$n"
            fi
            dots=$((dots/2))
        done
        if [ "$2" = "caps" ]; then
            image+="$(get-svg cap)$n"
        fi
        image+="$(get-svg foot)"
        echo "$image" > "./dotsies/$char.svg"
    done
}

generate " ediclhvbnkugtsøaomyjxræfwqzpÆØß"
generate " EDICLHVBNKUGTS AOMYJXR FWQZP  ẞ" caps
