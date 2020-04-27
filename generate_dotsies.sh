#!/bin/bash
# generate_dotsies.sh
# Systematically generate Dotsies glyph files for font import.

here="$(dirname "$(readlink -f "$0")")"
# Be here now, because absolute coordinates are a pain.
cd "$here" || exit 1

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
    return 1 # TODO

    # Expected basic logic:
    # 1. add header
    # 2. determine dot positions from index
    # 3. add each applicable dot (dot template with offset info)
    # 4. add caps dot if applicable
    # 5. add footer
    # 6. write to file

    for i in {0..31}; do
        echo "$i: ${1:$i:1}"
    done
}

generate " ediclhvbnkugtsøaomyjxræfwqzpÆØß"
generate " EDICLHVBNKUGTS AOMYJXR FWQZP  ẞ" caps
