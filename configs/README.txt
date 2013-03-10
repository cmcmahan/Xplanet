The config file is divided into sections which start with a line like
[body], where body is either default (everything in this section,
which should be at the top, applies to all bodies unless overridden
later), or a body name like saturn.

Be careful to specify options that apply to only one planet under that
planet's section, and not under [default].  For example, a common
mistake is to put cloud_map=clouds.jpg under [default] and not under
[earth].  Overlaying clouds on every planet is a huge waste of time!

I won't explain the format of the config file beyond that; instead
just look at the default supplied with xplanet.  It should be
straightforward.  When making your own config file just modify a copy
of the default config file.  Each option is described below.  The
default values are the values used in the absence of a corresponding
entry in the configuration file.

arc_color
Specify the default color for great arcs.  This color will be
overridden if a color is specified for an arc in the arc file.  The
color may be specified either as a name, a hexadecimal number, or as
an RGB triple.  For example, arc_color=red, arc_color=0xff0000, and
arc_color={255,0,0} all mean the same thing.  The default value is
white.

arc_file
Specify a great arc file for this planet.  This option may be used
more than once.  See the README and sample files in the xplanet/arcs
directory for more information.  The default is no arc files.

arc_thickness
Specify the default thickness for arcs.  This also applies to the
planet's orbit.  This can be overridden in the arc file itself.

bump_map
Specify a bump map to use for relief shading.  This is assumed to be
an greyscale image file representing a digital elevation map with
elevations ranging from 0 to 255.  The default is no bump map.

bump_scale
Exaggerate the vertical relief for computing the shading.  The default
value is 1.

cloud_gamma
Apply a gamma correction to the cloud image before overlaying.  Each
pixel's brightness is adjusted according to:
new_value = 255 * [(old_value/255)^(1/gamma)]
The default is 1 (no gamma correction).

cloud_map
Specify an image to overlay on the planet map.  The default is no
cloud map.

cloud_ssec
If true, assume the cloud map is an image downloaded from the Space
Science and Engineering Center (SSEC) at the University of Wisconsin.
The latest image (updated every three hours) can be obtained from
http://www.ssec.wisc.edu/data/comp/latest_moll.gif. This image is a
640x350 pixel Mollweide composite image with ugly pink coastlines.
Xplanet will reproject and resize the image as well as remove and fill
in the coastlines.

cloud_threshold
Cloud pixel values below threshold will be ignored.  The value for
threshold should be between 0 and 255.  The default is 90.

color
If an image map for the body is not found, use the specified color
instead.  The default is white, although a color is specified for most
bodies in the default configuration file.

draw_orbit
If true, draw the body's orbit about its primary.  The default is
false.  See "orbit" below on how to describe how the orbit is drawn.
The default is to not draw orbits.

grid
Draw a longitude/latitude grid.  The spacing of major grid lines and
dots between major grid lines can be controlled with the grid1 and
grid2 options (see below).  The default is false.

grid1
Specify the spacing of grid lines. Grid lines are drawn with a
90/grid1 degree spacing. The default value for grid1 is 6,
corresponding to 15 degrees between major grid lines. 

grid2
Specify the spacing of dots along grid lines.  Grid dots are drawn
with a 90/(grid1 x grid2) degree spacing.  The default value for grid2
is 15; combined with the default grid1 value of 6, this corresponds to
placing grid dots on a one degree spacing.

image
Specify the image map to use.  The default is body.jpg
(e.g. earth.jpg, neptune.jpg)

magnify
Draw the body as if its radius were magnified by the specified
factor.  This is useful for a lot of moons, as normally they would be
drawn as dots compared to their primary.  The default is 1 (no
magnification).  

map
Same as the image option above.

mapbounds={lat1,lon1,lat2,lon2}
Assume that each map file read in has its northwest corner at
lat1,lon1 and its southeast corner at lat2,lon2.  This is useful if
you have a high-res map but just want to show a small area.

marker_color
Specify the default color for all markers.  This color will be
overridden if a color is specified for a marker in the marker file.
The default is red.

marker_file
Specify a file containing user defined marker data to display on the
map.  This option may be used more than once.  The default is no
marker file.  See the README and sample files in the xplanet/markers
directory for more information.

marker_font
Specify the default font for all markers for this body.  This option
may be overridden inside the marker file.  The default is to use the
value from the command line -font option.

marker_fontsize
Specify the default font size for all markers for this body.  This
option may be overridden inside the marker file.  The default is to
use the value from the command line -fontsize option.

max_radius_for_label
Don't draw a label for the body if its radius is greater than this
value.  The default is 3 pixels.

min_radius_for_label
Don't draw a label for the body if its radius is less than this
value.  The default is 0.01 pixel.

min_radius_for_markers
Don't draw markers on the body if its radius is less than this value.
The default is 40 pixels.

night_map
Use night_file as the night map image.  If this option is not
specified, a default night map will be used for the earth.  If this
file is not found, or for the other planets, the night map will be a
copy of the day map, modified as described under the shade option.

orbit
Specify the start, end, and increment for the orbit.  The units are
orbital period and degrees.  The default is {-0.5,0.5,2}.  Remember to
set "draw_orbit=true".

orbit_color
Specify the color for the orbit.  The default is white.

random_origin 
If false, don't use this body with -origin random, major, or system.
The default is true.

random_target
If false, don't use this body with -target random or major.  The
default is true.

satellite_file
Specify a file containing a list of satellites to display.  A file
containing NORAD two line element (TLE) sets named satfile.tle must
exist along with satfile.  A good source of TLEs is www.celestrak.com.
This option may be used more than once.  The default is no satellite
files.  See the README and sample files in the xplanet/satellites
directory for more information.

shade
If the night image file is not found, set the brightness of the night
map to shade percent of the day map.  If shade is 100, the day and
night maps will be identical.  The default value is 30.

specular_map
Use filename as a specular reflectance file.  Normally it's just a
greyscale image where the oceans are set to 255 and the land masses
are set to 0.  This is used to display the reflection of the sun off
of the oceans.  The default is no specular file.

text_color
Specify the color for the markers and body label.  The default is red.

twilight
Let the day and night hemispheres blend into one another for pixels
within the specified number of degrees of the terminator.  The default
value is 6.
