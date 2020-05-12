#!/bin/bash
# generate_dotsies.sh
# Systematically generate Dotsies glyph files for font import.

## dbg message
# print debug message to stderr
dbg() {
    [ -n "$DEBUG" ] &&
        echo "$*" >&2
}

## name-of char
# return the given character's name, usually itself
name-of() {
    case "$1" in
        ' ')
            echo space
            ;;
        *)
            echo "$1"
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
    # 7. add to namelist.txt
    local i char name image dots pos n=$'\n' hex
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
        name="$(name-of "$char")"
        dbg "char '$char' has name '$name'"
        echo "$image" > "$name.svg"
        hex="$(echo -n "$1" | hexdump --format '/1 "%02x"')"
        printf '0x%s %s\n' "$hex" "$name" >> "$NAMELIST"
    done
}

## get-svg feature
# Returns SVG code for the given feature. Valid codes are as follows:
# - head   SVG header
# - 1-5    dot positions, counting from bottom
# - cap    capitalization dot
# - foot   SVG footer
get-svg() {
    local height=1000
    #local baseline=800 # TODO: actually use this?
    local width=$((height/6))
    case "$1" in
        "head")
            # viewbox="xmin ymin xmax ymax"
            printf '<svg viewBox="0 0 %s %s">' $width $height
            ;;
        1|2|3|4|5)
            printf $'\t''<rect width="%s" height="%s" fill="black" x="%s" y="%s" />' \
                   $width $width 0 $((height-width*$1))
            ;;
        "cap")
            printf $'\t''<rect width="%s" height="%s" fill="black" x="%s" y="%s" />' \
                   $((width/3)) $((2*width/3)) $((width/3)) 0
            ;;
        "foot")
            echo '</svg>'
            ;;
    esac
}

## main "$@"
# run the script
main() {
    if [ "$1" = "debug" ]; then
        declare -g DEBUG=true
        dbg "debug mode active"
    else
        echo "(use '$0 debug' for debug output)"
    fi

    # Be here now, because absolute coordinates are a pain.
    cd "$(dirname "$(readlink -f "$0")")/dotsies" ||
        exit 1

    declare -g NAMELIST=namelist.txt

    rm "$NAMELIST"
    touch "$NAMELIST"
    rm ./*.svg
    generate " ediclhvbnkugtsøaomyjxræfwqzpÆØß"
    generate " EDICLHVBNKUGTS AOMYJXR FWQZP  ẞ" caps
}

main "$@"
