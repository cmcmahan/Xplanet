#!/bin/sh
###!/usr/bin/env bash

#============================================================
# Cloud sources
# http://user.chol.com/~winxplanet/cloud_data/clouds_2048.jpg
# http://xplanetclouds.com/free/local/clouds_2048.jpg (2 d/l per day limit)
# http://xplanet.sourceforge.net/clouds/clouds_2048.jpg
# http://xplanetclouds.com/free/coral/clouds_2048.jpg (created once per day)
# http://xplanet.dyndns.org/clouds/clouds_2048.jpg, (older 1x/day?)
# http://home.megapass.co.kr/~gitto88/cloud_data/clouds_2048.jpg
# ftp://ftp.iastate.edu/pub/xplanet/clouds_2048.jpg
# http://taint.org/xplanet/day_clouds_2048x1024.png (completed xplanet rendering, updated hourly)


# Map sources
# http://www.evl.uic.edu/pape/data/Earth/ (includes specular, political and bump maps)
# http://www.radcyberzine.com/xglobe/
# http://flatplanet.sourceforge.net/maps/natural.html (references other sources as well)
# http://www.mmedia.is/~bjj/index.html (planetary renderings and maps)
# http://planetpixelemporium.com/earth.html (includes other planetary maps as well)
# http://www.johnstonsarchive.net/spaceart/planetcylmaps.html (excellent collection of sources for earth and celestial)
# http://maps.jpl.nasa.gov/ (JPL planetary maps)


#============================================================
## contents for /Library/LaunchAgents/com.mcmahan.xplanet.plist
#<?xml version="1.0" encoding="UTF-8"?>
#<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
#<plist version="1.0">
#  <dict>
#    <key>Label</key>
#    <string>com.mcmahan.xplanet</string>
#    <key>ProgramArguments</key>
#    <array>
#      <string>/Users/cmcmahan/Xplanet/xplanet.sh</string>
#    </array>
#    <key>StartInterval</key>
#    <integer>300</integer>
#  </dict>
#</plist>

#============================================================
# Set up default values
user=cmcmahan
home=/Users/${user}
xplanetdir=${home}/Xplanet
configfile=${xplanetdir}/configs/config.subdued

outputdir=${home}/Pictures/Xplanet
NOW=$(date "+%Y%j%H%M%S")
outputfile=${outputdir}/${NOW}.jpg

cloudmap=${xplanetdir}/clouds.jpg
issfile=${xplanetdir}/satellites/iss

cloudsite=http://xplanet.sourceforge.net/clouds/clouds_2048.jpg
isssite=http://www.celestrak.com/NORAD/elements/stations.txt
refresh=30

font=ArialRoundedBold.ttf
fontsize=15

#============================================================
# clear any command-line args
cloudflag=0
orbitflag=0
startflag=0
verboseflag=0

##============================================================
## Parse the command-line arguments
while getopts 'cmos' OPTION
  do
    case $OPTION in
      c) cloudflag=1 ;;
      o) orbitflag=1 ;;
      s) startflag=1 ;;
    esac
  done
shift $(($OPTIND - 1))

#============================================================
# change to the appropriate directory
pushd $xplanetdir > /dev/null

#============================================================
# Download updated cloud map overlaid on the day and night images.
# The -make-clouds switch defaults to generating two images in the
# current directory named day_clouds.jpg and night_clouds.jpg.
if [ "$cloudflag" ]
then
    mv $cloudmap ${cloudmap}.bak
    curl -s -L ${cloudsite} -o ${cloudmap}

   # check to ensure the cloud image was downloaded successfully and is > 0 bytes
   if(test -s $cloudmap) then
      rm ${cloudmap}.bak
   else
      mv ${cloudmap}.bak $cloudmap
   fi
   # incorporate the new cloud map into the xplanet day and night images
   # creating day_clouds.jpg and night_clouds.jpg
   xplanet -searchdir ${xplanetdir} -tmpdir ${xplanetdir} -config ${configfile} -make_cloud_maps
fi

#============================================================
# Download the latest the ISS orbital data
if [ "$orbitflag" ]
then
   mv ${issfile}.tle ${issfile}.bak
   curl -s -L ${isssite} -o ${issfile}.tle 

   # check to ensure the ISS file was downloaded successfully and is > 0 bytes
   if(test -s ${issfile}.tle) then
      rm ${issfile}.bak
   else
      mv ${issfile}.bak ${issfile}.tle
   fi
fi

#============================================================
# Start the xplanet program
if [ "$startflag" ]
then
    rm -f ${outputdir}/*

    # start xplanet 
    xplanet \
	-searchdir ${xplanetdir} \
	-config ${configfile} \
	-font ${font} \
	-fontsize ${fontsize} \
	-color gray50 \
	-geometry 1920x1200 \
	-projection rectangular \
	-date_format "%d %b %y %R" \
	-label -labelpos "-10-10" -label_string "." \
	-wait ${refresh}
#	-num_times 1 
fi

#============================================================
# Cleanup
popd > /dev/null

# echo the PID of xplanet
#echo $!

exit 0

