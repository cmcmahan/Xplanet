#!/usr/bin/perl
# This script uses moon images numbered from 1-28 to reflect the
# current phase of the moon. Image names are moonxx.png where xx is
# the current age of the moon as determined by the MoonPhase code.

# Calculates phase and illumination of the moon and creates a
# moonphase marker file in the user's markers_directory.

# The location of the text and image can be manipulated by modifying
# the variables starting_pos_y and starting_pos_x.

# The location of the directories can be set my modifying the
# variables xplanet_dir, xplanet_markers_dir and moonphase_images_dir.

# The images directory can be any directory that contains the 28 moon
# phase images

# get information about the current state of the moon.
use Astro::MoonPhase;
use File::Spec;

#==========================
# User specified values 
#==========================
# x coordinate for upper-left corner of output text. Negative values
# place the text relative to the right (x) or bottom edge (y)
# sample text output looks like this:
#    Last New Moon: Fri Nov 9
#    First Quarter: Sat Nov 17
#        Full Moon: Sat Nov 24
#     Last Quarter: Sat Dec 1
#    Next New Moon: Sun Dec 9
#   Current Illlum: 87%  /  \
#      Current Age: 18   \__/

my $starting_pos_y = 50; # vertical starting position
my $starting_pos_x = 170; # horizontal starting position of 

#font size
my $font_size = 18;

# space between the left and right columns of the output
my $horizontal_linespace = 12;
my $label_color = "white";
my $data_color  = "cyan";

# space between lines of text
my $vertical_linespace   = 25;

# set up the directories for xplanet configuration, markers and moon phase images.
my $xplanet_dir          = '/Users/cmcmahan/.xplanet';
my $xplanet_markers_dir  = File::Spec->catdir($xplanet_dir,"markers");
my $moonphase_images_dir = File::Spec->catdir($xplanet_dir,"images/moonphases");
my $mphase_marker_file   = File::Spec->catfile($xplanet_markers_dir,"moonphase");

my $last_new_moon_label  = "Last New Moon:";
my $first_quarter_label  = "First Quarter:";
my $full_moon_label      = "Full Moon:";
my $last_quarter_label   = "Last Quarter:";
my $next_new_moon_label  = "Next New Moon:";
my $moon_age_label       = "Current Age:";
my $moon_illum_label     = "Current Illum:";

#==========================
# End User specified values 
#==========================
# There should be no need to modify any values below this point. 

# set up the date-time stamp yyyy-mm-dd hh:mm:ss
($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);
sub datetime {
    return (sprintf "%4d-%02d-%02d %02d:%02d:%02d",$year+1900,$mon+1,$mday,$hour,$min,$sec);
} 
my $date_time_stamp = datetime();


# ensure the directories are there and with appropriate permissions
-d $xplanet_dir          || die("Could not find xplanet installation directory $xplanet_dir\n");
-r $xplanet_dir          || die("Could not read xplanet installation directory $xplanet_dir\n");
                         
-d $xplanet_markers_dir  || die("Could not find xplanet markers directory $xplanet_markers_dir\n");
-r $xplanet_markers_dir  || die("Could not read xplanet markers directory $xplanet_markers_dir\n");
-w $xplanet_markers_dir  || die("Could not write xplanet markers directory $xplanet_markers_dir\n");

-d $moonphase_images_dir || die("Could not find xplanet images directory $moonphase_images_dir\n");
-r $moonphase_images_dir || die("Could not read xplanet images directory $moonphase_images_dir\n");
-w $moonphase_images_dir || die("Could not write xplanet images directory $moonphase_images_dir\n");

# populate the variables from the moonphase package
( $moon_phase,
  $moon_illum,
  $moon_age,
  $moon_dist,
  $moon_ang,
  $sun_dist,
  $sun_ang ) = phase();

# get the moon phase dates
@phases = phasehunt();
my $last_new_moon_date = substr(scalar(localtime($phases[0])),0,10);
my $first_quarter_date = substr(scalar(localtime($phases[1])),0,10);
my $full_moon_date     = substr(scalar(localtime($phases[2])),0,10);
my $last_quarter_date  = substr(scalar(localtime($phases[3])),0,10);
my $next_new_moon_date = substr(scalar(localtime($phases[4])),0,10);

# format the moon illum and phase data
my $moon_illum_data = sprintf "%2d", $moon_illum*100;

# account for the odd exception where moon age can be > 28
my $moon_age_data;
if ($moon_age > 28)  
  { $moon_age_data = 28 }
else { $moon_age_data = sprintf "%2d", $moon_age }
my $moon_age_img    = sprintf "%02d",$moon_age_data;

# get the appropriate moon phase image to use
my $current_phase_img = "moon".$moon_age_img.".png";
my $moon_img = File::Spec->catfile($moonphase_images_dir,$current_phase_img);

# Build the output elements
my $align_left_params  = "position=pixel image=none align=left  fontsize=".$font_size." color=".$label_color;
my $align_right_params = "position=pixel image=none align=right fontsize=".$font_size." color=".$data_color;

my @pos_y = (
    $starting_pos_y,
    $starting_pos_y + ($vertical_linespace*1),
    $starting_pos_y + ($vertical_linespace*2),
    $starting_pos_y + ($vertical_linespace*3),
    $starting_pos_y + ($vertical_linespace*4),
    $starting_pos_y + ($vertical_linespace*5),
    $starting_pos_y + ($vertical_linespace*6));

my $pos_x = $starting_pos_x;
my $hls = $horizontal_linespace;

# output to the moonphase marker file
local *MP;
open(MP,">$mphase_marker_file") || die("Could not open moonphase markers $mphase_marker_file for writing: $!\n");
print MP "# Moonphase marker file created by moon.pl\n";
print MP "# Last updated on $date_time_stamp\n\n";
print MP "# Raw Data from the Astro::Moonphase package\n";
print MP "# moon_phase: ",$moon_phase,"\n";
print MP "# moon_illum: ",$moon_illum,"\n";
print MP "# moon_age:   ",$moon_age,"\n";
print MP "# moon_dist:  ",$moon_dist,"\n";
print MP "# moon_ang:   ",$moon_ang,"\n";
print MP "# sun_dist:   ",$sun_dist,"\n";
print MP "# sun_ang:    ",$sun_ang,"\n\n";

# Last New Moon
print MP $pos_y[0]," ",$pos_x,     " ",$align_left_params, " \"",$last_new_moon_label,"\"\n";
print MP $pos_y[0]," ",$pos_x+$hls," ",$align_right_params," \"",$last_new_moon_date, "\"\n";

# First Quarter Moon
print MP $pos_y[1]," ",$pos_x,     " ",$align_left_params, " \"",$first_quarter_label,"\"\n";
print MP $pos_y[1]," ",$pos_x+$hls," ",$align_right_params," \"",$first_quarter_date, "\"\n";

# Full Moon
print MP $pos_y[2]," ",$pos_x,     " ",$align_left_params, " \"",$full_moon_label,    "\"\n";
print MP $pos_y[2]," ",$pos_x+$hls," ",$align_right_params," \"",$full_moon_date,     "\"\n";

# Last Quarter Moon
print MP $pos_y[3]," ",$pos_x,     " ",$align_left_params, " \"",$last_quarter_label, "\"\n";
print MP $pos_y[3]," ",$pos_x+$hls," ",$align_right_params," \"",$last_quarter_date,  "\"\n";

# Next New Moon
print MP $pos_y[4]," ",$pos_x,     " ",$align_left_params, " \"",$next_new_moon_label,"\"\n";
print MP $pos_y[4]," ",$pos_x+$hls," ",$align_right_params," \"",$next_new_moon_date, "\"\n";

# Current Illumination
print MP $pos_y[5]," ",$pos_x,     " ",$align_left_params, " \"",$moon_illum_label,   "\"\n";
print MP $pos_y[5]," ",$pos_x+$hls," ",$align_right_params," \"",$moon_illum_data,   "%\"\n";

# Current Age
print MP $pos_y[6]," ",$pos_x,     " ",$align_left_params, " \"",$moon_age_label,     "\"\n";
print MP $pos_y[6]," ",$pos_x+$hls," ",$align_right_params," \"",$moon_age_data,      "\"\n";

# print the moon image
print MP $pos_y[5]+15," ", $pos_x+90, " position=pixel image=", $moon_img, " transparent={0,0,0}\n";
