# Perry Hartono 2019-02-04
# This Python script generates a list of all possible glyph pairs.
# Useful for Quikscript font development.

chars = ["","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""]
output = ""

for i in range(0, len(chars)):
    # letter pairing a-b-a
    for j in range(0, len(chars)):
        output = output + chars[i] + chars[j] + chars[i] + ' '
    output = output + '\n'

print(output)
