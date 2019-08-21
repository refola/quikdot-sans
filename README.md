# Quikscript Sans

Quikscript Sans (formerly Quikscript Geometric) is a sans-serif font for Quikscript, an alternate phonetic alphabet for the English language. Created by 'pcdandy' as part of the [Alternate Script Bureau project](https://alternatescriptbureau.wordpress.com), Quikscript Sans is intended to have a more serious character than the other (few) Quikscript fonts out there, and merge seamlessly with existing sans-serif fonts such as Noto Sans.

This font is based on [Frog Orbits' Private Use Area (PUA) encoding in Unicode](https://www.frogorbits.com/qs/csur/).

# License

Quikscript Sans is distributed under [Version 1.1 of the SIL Open Font License](LICENSE).

# Useful tips for development

## Importing glyphs to Fontforge  

* Go to template.svg, select all glyphs and run 'Stroke to Path'
* Export to template_outline.svg in folder 'letters'
* Run the command: `cp letter_template.svg letter_template_outline.svg && inkscape letter_template_outline.svg --verb=EditSelectAllInAllLayers --verb=StrokeToPath --verb=FileSave --verb=FileQuit && python3 layer2svg.py letter_template_outline.svg letters`
	* Explanation: Makes a new copy of `letter_template.svg`, called `letter_template_outline.svg`. Uses the Inkscape command line utility to transform all strokes in the copy into paths. Run the Python script to extract each individual layer in the copy into their own svg files, each of which has 1 letter glyph.
* Import all of the resulting .svg glyphs into Fontforge one by one
* In Fontforge, go to Element -> Transformations -> Transform..., set the 'Origin' to 'Glyph Origin'. Move the bottom of all glyphs down by the difference between the lowest point of the tall letter and the baseline

## Setting the line spacing

From here: http://benwhitmore.altervista.org/line-spacing-getting-right/

* Go to Element -> Font Info -> OS/2 -> Metrics
* Make sure all the 'IsOffset' fields are not checked
* Set the 'Win Ascent' and 'Win Descent' fields (both positive values) to the highest and lowest part of the glyph respectively (1700 and 440 for my Quikscript Geometric font)
* Set the same values for 'Typo Ascent/Descent' and 'HHead Ascent/Descent', except that the 'descent' must bi negative for these fields. Both 'line gap' fields should bi zero, and ensure 'Really use Typo metrics' is checked

## Alignment

Select all glyphs and go to Metrics -> Set Both Bearings... , set it to 100 for almost all letters

	* For t i w_vowel ou: set both bearings to 150
	* For d h e ei u au ur iu iur: set left bearing to 150 and right bearing to 100
	* For p f y_vowel o oi: set right bearing to 150

For the numerals, set width to 750, and then set the left bearings as following:

	* 0_q 1_q 7_q 8_q 9_q: 100
	* 4_q 6_q: 124
	* 2_q 3_q 5_q: 150

## Hinting

* Hints -> Autohint for better font rendering

## Fixing any lingering errors  
* Select all glyphs
* Element -> Add Extrema
* Element -> Round -> To Int
* For 'x' and 'gz' only: Element -> Overlap -> Remove Overlap

## Ligatures

Note: 'iw', 'iu' and 'iur' have slightly modified outlines from the template to make them easier to read. The points at the sharp 'v' corner were brought down slightly.

* To create a ligature, right click the glyph and then go to Glyph info... -> Ligatures
* [New Ligature] -> New Lookup Subtable...
* In 'Source Glyph Names', put these for the corresponding ligatures:
	* iw: uniE660 uniE67E
	* eir: uniE673 uniE668
	* aar: uniE676 uniE668
	* oor: uniE677 uniE668
	* ur: uniE67A uniE668
	* iu: uniE670 uniE67A
	* iur: uniE670 uniE67A uniE668
* Click 'Ok'
