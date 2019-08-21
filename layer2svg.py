#! /usr/bin/python3
import xml.etree.ElementTree as ET
import copy
import sys
import os

# SOURCE: https://github.com/james-bird/layer-to-svg
# ULTIMATELY FROM: http://www.inkscapeforum.com/viewtopic.php?t=9516

# example usage: python3 layer2svg.py <nameofsvgfile>.svg <nameofoutputfolder>

tree = ET.parse(sys.argv[1])
root = tree.getroot()
listoflayers=[]

# Create directory to put the layers
folder = sys.argv[2] + '/'
os.makedirs(os.path.dirname(sys.argv[2] + '/'), exist_ok=True)

# Extract the layers from the svg file
for g in root.findall('{http://www.w3.org/2000/svg}g'):
    name = g.get('{http://www.inkscape.org/namespaces/inkscape}label')
    listoflayers.append(name)
print(listoflayers)

# Remove the background layer
try:
    listoflayers.remove('background')
except ValueError:
    print("No background")

# Write the layers to their own svg files
for counter in range(len(listoflayers)):
    james=listoflayers[:]
    temp_tree = copy.deepcopy(tree)
    del james[counter]
    print("JAMES=", james)
    temp_root = temp_tree.getroot()
    for g in temp_root.findall('{http://www.w3.org/2000/svg}g'):
        name = g.get('{http://www.inkscape.org/namespaces/inkscape}label')
        if name in james:
            temp_root.remove(g)
    finaldir = folder + listoflayers[counter]+'.svg'
    print(finaldir)
    temp_tree.write(finaldir)
