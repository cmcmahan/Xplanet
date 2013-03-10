Get the latest orbital elements from celestrak.com:
wget -O stations.tle http://www.celestrak.com/NORAD/elements/stations.txt

The tle file should match the file name for the configuration (eg
stations is the config file, so stations.tle is the orbital elements
file)

A sample TLE entry for the International Space Station looks like
this:

ISS (ZARYA)             
1 25544U 98067A   01286.44085648  .00059265  00000-0  81723-3 0  5959
2 25544  51.6394 213.7002 0007838 194.2620 314.2054 15.56596996165535

Each line in satfile must begin with a satellite ID number (e.g. 25544
for the ISS).  Each ID must exist in the associated TLE file. 

Valid additional keywords are "align", "altcirc", "color", "font",
"fontsize", "image", "position", "spacing", "trail", and
"transparent".  The usage for most of these is identical to the usage
for the -greatarcfile and -markerfile options.  In addition, a string
to be plotted with the marker may be enclosed in either double quotes
(""), or braces ({}).  If a string is not supplied, the marker will
take the name of the satellite supplied in the TLE file.

The "altcirc" keyword draws altitude circles on the surface of the
earth.  The format is "altcirc=angle", where a circle is drawn
bounding the area where the satellite is greater than angle degrees
above the horizon.  For example, altcirc=0 draws a circle bounding the
region where the satellite is above the horizon, while altcirc=45
draws a circle bounding the region where the satellite is more than 45
degrees above the horizon.  This may be specified more than once.

The "trail" keyword is used to specify an orbit trail.  The format
must be "trail={ground|orbit,start_time,end_time,interval}", where the
start and end times and interval are each in minutes.  The start and
end times are relative to the time of the calculation.  When using the
-projection option, trail will always be "ground".

A few sample entries are given below:

25544
This draws a marker with the string "ISS (ZARYA)" for the
International Space Station. 

25544 "The Space Station"
This draws a marker with the string "The Space Station" for the
International Space Station. 

25544 "" image=iss.png transparent={0,0,0} altcirc=0 
This draws iss.png at the current position of the International Space
Station.  No text string is drawn.  A curve containing the area where
the International Space Station is above the horizon is drawn.

25544 "" image=iss.png transparent={0,0,0} altcirc=0 altcirc=45 trail={orbit,-5,10,2}
As the previous example, but also draw the orbit trail from five
minutes before to ten minutes past the current time, calculated every
two minutes.  A second altitude circle bounding the region where the
International Space Station is more than 45 degrees above the horizon
is also drawn.

