# QuikDot Sans / · 

QuikDot Sans is a modified [Quikscript
Sans](https://bitbucket.org/pcdandy/quikscript-sans) (see
[`README-upstream.md`](README-upstream.md)) which replaces the Latin
alphabetic characters a-z, A-Z, ø, æ, Æ, Ø, and ß, and ẞ with
[Dotsies](https://dotsies.org). In particular, with the 5 dot
positions interpreted as binary digits, characters "0" thru "31" are `
ediclhvbnkugtsøaomyjxræfwqzpÆØß`, matching `Dotsies.ttf`'s
values. Capital letters A-Z and ẞ have tiny capitalization indication
dots above their minuscule forms.


# Metrics

<!-- Based on side-by-side in-line visual comparison in Emacs on my system,
I'm aiming for minuscule Dotsies `x` height to take the vertical space
of a "tall" Quikscript letter. Dots will then each take 1/5 of this
space and be perfectly square. Dotsies' tiny capitalization dots will
be above Quikscript's tall letter height, where accents go. Dotsies is
completely devoid of descenders.

In terms of [`guides.svg`](letters/guides.svg) from Quikscript Sans'
source, Dotsies letters go from the lower horizontal red line to the
top of the box. Capitalization dots are roughly the middle half of the
vertical red line's above-box height and about a 1/3 the width of
letter dots. -->

In order to satisfy FontForge according to [the first search result
DuckDuckGo gave
me](http://designwithfontforge.com/en-US/Importing_Glyphs_from_Other_Programs.html),
metrics are `y=0` at the top, `y=1000` at the bottom, and `y=800` as
the baseline. In Dotsies terms, this means 800/6 = 133⅓ SVG units per
dot. So I'm rounding to 134, units each, including for the
capitalization dot. Thus all characters will go 4 units below
baseline, a nominal error of 0.4%. Capitalization dots will occupy
(44, 0) thru (90, 90).

<-- TODO: adjust `generate_dotsies.sh` accordingly. It needs
`viewBox="0 0 134 1000"`, and new coordinates calculated for all
rectangles. -->


# Building

For the Dotsies version, every glyph is systematically constructed
from the magic strings ` ediclhvbnkugtsøaomyjxræfwqzpÆØß` (minuscule)
and ` EDICLHVBNKUGTS AOMYJXR FWQZP ẞ` (capital). Just run
`./generate_dotsies.sh` and it will generate corresponding `.svg`
images to import into Fontforge.

For everything else, please see
[`README-upstream.md`](README-upstream.md).


# License

QuikDot Sans is licensed under [the SIL Open Font License, Version
1.1](LICENSE), just like upstream Quikscript Sans.


# Other information

See [`README-upstream.md`](README-upstream.md) for all the useful use
information. This `README.md` only covers the changes.
