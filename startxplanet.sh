#!/bin/sh
###!/usr/bin/env bash

##============================================================
# Cloud sources
# http://xplanet.sourceforge.net/clouds/clouds_2048.jpg
# http://xplanetclouds.com/free/coral/clouds_2048.jpg (created once per day)
# http://xplanetclouds.com/free/local/clouds_2048.jpg (2 d/l per day limit)
# http://xplanet.dyndns.org/clouds/clouds_2048.jpg, (older 1x/day?)
# http://user.chol.com/~winxplanet/cloud_data/clouds_2048.jpg
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


##============================================================
# Select the config file you would like to use

config=config.subdued
#config=config.embossed
#config=config.realistic

##============================================================
# Set up default values
home=/Users/cmcmahan
xplanetdir=${home}/Xplanet

configfile=${xplanetdir}/configs/${config}

cloudmap=${xplanetdir}/clouds.jpg
issfile=${xplanetdir}/satellites/iss

cloudsite=http://xplanet.sourceforge.net/clouds/clouds_2048.jpg
isssite=http://www.celestrak.com/NORAD/elements/stations.txt
refresh=30

font=ArialRoundedBold.ttf
fontsize=15

# clear any command-line args
cloudflag=
orbitflag=
startflag=

##============================================================
## Parse the command-line arguments
while getopts 'cmos' OPTION
do
   case $OPTION in
   c) cloudflag=1 ;;
   o) orbitflag=1 ;;
   s) startflag=1 ;;
   ?) printf "Usage: %s: [options]
Options are:
 -c Download latest cloud image
 -o Download latest orbital data
 -s Start (restart) Xplanet
 -h Print this help\n" $(basename $0) >&2
   exit 2        ;;
   esac
done
shift $(($OPTIND - 1))

# change to the appropriate directory
pushd $xplanetdir

##============================================================
## Download updated cloud map overlaid on the day and night images.
## The -make-clouds switch defaults to generating two images in the
## current directory named day_clouds.jpg and night_clouds.jpg.
if [ "$cloudflag" ]
then
    echo ''
    echo ' getting new cloud image'
    mv $cloudmap ${cloudmap}.bak
    wget ${cloudsite} -O ${cloudmap}

   # check to ensure the cloud image was downloaded successfully and is > 0 bytes
   if(test -s $cloudmap) then
      echo ' cloud image download complete '
      rm ${cloudmap}.bak
   else
      echo ' cloud image download failed, reverting to backup '
      mv ${cloudmap}.bak $cloudmap
   fi
   # incorporate the new cloud map into the xplanet day and night images
   # creating day_clouds.jpg and night_clouds.jpg
   #echo 'xplanet -searchdir '${xplanetdir}' -tmpdir '${xplanetdir}' -config '${configfile}' -make_cloud_maps'
   xplanet -searchdir ${xplanetdir} -tmpdir ${xplanetdir} -config ${configfile} -make_cloud_maps
   echo ' Cloud map incorporated '
fi

##============================================================
## Download the latest the ISS orbital data
if [ "$orbitflag" ]
then
   echo ''
   echo ' getting new orbital data'
   mv ${issfile}.tle ${issfile}.bak
   wget ${isssite} -O ${issfile}.tle 

   # check to ensure the ISS file was downloaded successfully and is > 0 bytes
   if(test -s ${issfile}.tle) then
      echo ' orbital data complete '
      rm ${issfile}.bak
   else
      echo ' orbital data download failed, reverting to backup '
      mv ${issfile}.bak ${issfile}.tle
   fi
fi

## This command starts xplanet and uses the cloud maps generated above
if [ "$startflag" ]
then
   echo ''
   echo ' starting xplanet'
   echo ''
   echo ' Killing any existing xplanet instances'
   killall -m xplanet

echo ''
echo \
" xplanet \
-searchdir ${xplanetdir} \
-config ${configfile} \
-font ${font} \
-fontsize ${fontsize} \
-color gray50 \
-geometry 1920x1200 \
-projection rectangular \
-date_format \"%d %b %y %R\" \
-label -labelpos \"-10-10\" -label_string \".\" \
-wait ${refresh}"

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

fi

popd

## echo the PID of xplanet
#echo $!

exit 0

