The format of each line is generally latitude, longitude, string, as
in the example below:

33.943 -118.408 "Los Angeles" # USA 

Anything after a # is ignored.  

In addition, Xplanet supports the "align", "color", "font",
"fontsize", "image", "position", "radius", and "transparent" keywords.
If used, keywords must follow the text string.

The "align" keyword is used to place the marker string in relation to
the marker itself.  Valid "align" values are "right", "left", "above",
"below", or "center".  If the "align" keyword is not specified,
Xplanet will attempt to place the marker string so as not to overlap
other markers.

Valid values for "color", "font", and "fontsize" are the same as for
the -color, -font, and -fontsize options, respectively.  

Valid values for "image" are either "none" or the name of an image
file.  If the "image" keyword is not specified, Xplanet will draw a
circular marker.  Xplanet looks for image files in the same places it
looks for map files.

Valid values for "position" are "absolute", "pixel", or a body name
(e.g. position=moon).  Using "pixel" means that the given coordinates
are pixel values, where positive values are relative to the top or
left edges, and negative values are relative to the right or bottom
edge.  Using "absolute" means the pixel values are relative to the
upper left corner, so negative values are off of the screen.  If the
"position" keyword is not specified, Xplanet assumes the two
coordinates given in the marker file are latitude and then longitude.

The "radius" keyword is used to place the marker at the specified
distance from the planet's center, in units of the planetary radius.
A radius value of 1 places the marker at the planet's surface.

The "symbolsize" keyword controls the size in pixels of the circular
marker.  The default is 6.

The "timezone" keyword is used to specify a value for the TZ
environment variable when the marker is drawn.  If this keyword is
specified, the marker string is passed through strftime(3) before
being displayed.  See the earth marker file for more details.

The "transparent" keyword is only meaningful in conjunction with
"image".  The format must be "transparent={R,G,B}" where the RGB
values range from 0 to 255.  Any pixels with this color value will be
considered to be transparent.

Delimiters (whitespace or tabs) are not permitted in any of these
keyword/value pairs (except for with "transparent", as shown above).
The text string may be enclosed in either quotes ("") or braces ({}).

Some sample marker file entries are given below:

33.943 -118.408 "Los Angeles" align=below color=blue font=10x20 # USA 
33.943 -118.408 {Los Angeles} align=below color=blue font=10x20 # USA 
Each of these will draw a circular marker at latitude 33.943,
longitude -118.408, with a text label "Los Angeles" below it, colored
blue and using font 10x20.  

20 10 "This is xplanet" image=none position=pixel 
This draws the string "This is xplanet" at pixel coordinates y=20,
x=10, with no marker.  (0,0) is the upper left corner of the screen.
If y or x is negative, it is taken to be the number of pixels from the
bottom or right side of the screen, respectively.

position=sun image=smile.png transparent={255,255,255}
This draws the image "smile.png" at the subsolar point.  Any pixels
with the RGB values {255,255,255} will be considered transparent.
Using "position=moon" will draw the image at the sublunar point.

-1.12479 251.774 radius=1.09261 {HST} 
This draws a circular marker for the Hubble Space Telescope above
latitude -1.12479, longitude 251.774 degrees, at a distance of 1.09261
earth radii from the center of the earth and labels it "HST".

40.70  -74.00 "New York %H:%M %Z" timezone=America/New_York
This draws a marker with "New York" followed by the time in HH:MM ZZZ
where ZZZ is the string for the time zone (either EST or EDT).

