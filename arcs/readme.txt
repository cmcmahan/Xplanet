Each line should have the following syntax:

lat1 lon1 lat2 lon2

where all values are in degrees.  In addition, the keywords "color"
and "spacing" are supported as in the example below:

33.9 -118.4 52.3 4.8 color=SpringGreen spacing=0.5 # LAX-AMS

Valid values for "color" are the same as for the -color option.  The
value for spacing defines the distance between dots on the great arc.
The default is 0.1 degree.  Delimiters (whitespace, tabs, or commas)
are not permitted in any of these keyword/value pairs.  Anything after
the # character is ignored.  