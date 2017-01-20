#!/bin/sh

# ChangeClearBrowsingDataPrefs.sh
# Change Chrome Homepage

# This script assumes that default preference files for all Chrome has been installed
# with FUT/FEU options in Casper.

# Define Preferences

preference='"clear_data":{"browsing_history":true,"cache":true,"content_licenses":true,"cookies":true,"download_history":true,"form_data":true,"hosted_apps_data":true,"passwords":true,"time_period":4},'

# Stop all open browsers so settings are not over written by Coogle Chrome's open session (it re-writes every 1 min from memory)

sudo killall -z -m "Google Chrome"

# Loop through each user to set homepage prefs
for user in $(ls /Users | grep -v Shared | grep -v npsparcc | grep -v ".localized"); do

### Chrome ###

# Define Chrome Preference variable
chromePrefs="/Users/$user/Library/Application Support/Google/Chrome/Default/Preferences"

#Parse the Preferences json file to set the checkboxes to checked and the time period for all time

sed -i '' 's|"homepage":"http[^"]*"|"homepage":"$preference"|' $chromePrefs

done

# Set preferences in user template for future users

# Chrome
cp "/Users/$adminUser/Library/Application Support/Google/Chrome/Default/Preferences" "/System/Library/User Template/English.lproj/Library/Application Support/Google/Chrome/Default/Preferences"
