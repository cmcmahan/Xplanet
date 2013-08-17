# http://themindfulbit.com/blog/fun-with-xplanet

RESOLUTION='1920x1200'    # Resolution of the finished image. Should match your screen.
NOW=$(date "+%Y%j%H%M%S") # That's year, julian date, hours, minutes, seconds
BODY='io'                 # The celestial body targeted.
LONGITUDE='180'           # Where over the target body you want to hover
RADIUS='3'                # How big you want the target to look
rm /Users/cmcmahan/Pictures/Xplanet/* ; # Empty the directory
/usr/local/bin/xplanet -body $BODY -longitude $LONGITUDE -radius $RADIUS -center +450+350 -num_times 1 --geometry $RESOLUTION --output /Users/username/Pictures/xplanet/$NOW.jpg ;

# Now we’re going to tell the system to run your spiffy shell script at the same
# interval. Open a text editor and create a file named
# com.themindfulbit.xplanet.plist in ~/Library/LaunchAgents. You may have to make
# the LaunchAgents folder if it’s not already there.
# 
# In the .plist file, put the following code:
# 
# <?xml version="1.0" encoding="UTF-8"?>
# <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
# <plist version="1.0">
# <dict>
#     <key>Label</key>
#     <string>com.themindfulbit.xplanet</string>
#     <key>ProgramArguments</key>
#     <array>
#         <string>/Users/username/Dropbox/scripts/jupiter.sh</string>
#     </array>
#     <key>StartInterval</key>
#     <integer>300</integer>
# </dict>
# </plist>
# 
# Log out, then log back in. The new Launch Agent you created will tell the
# system to run your script every 300 seconds.
