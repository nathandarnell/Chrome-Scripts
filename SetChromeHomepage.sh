#!/bin/sh

# SetHomepages.sh
#  Change Chrome and Safari Homepage

# This script assumes that default preference files for all three browsers have been installed
# with FUT/FEU options in Casper.

# Define homepage

homepage='https://www.yourhomepage.com'

# Stop all open browsers so settings are not over written by Coogle Chrome's open session (it re-writes every 1 min from memory)

sudo killall -z -m "Google Chrome"
Sudo killall -z -m "Safari" -signal

# Loop through each user to set homepage prefs
for user in $(ls /Users | grep -v Shared | grep -v npsparcc | grep -v ".localized"); do

### Safari ###

# Use defaults command to set Safari homepage
su - "$user" -c "defaults write com.apple.Safari HomePage $homepage"
su - "$user" -c "defaults write com.apple.Safari NewWindowBehavior -int 0"
su - "$user" -c "defaults write com.apple.Safari NewTabBehavior -int 0"
su - "users" -c "defaults read com.apple.Safari"
echo "Set new Safari homepage to $homepage for $user."


### Chrome ###

# Define Chrome Preference variable
chromePrefs="/Users/$user/Library/Application Support/Google/Chrome/Default/Preferences"

#Parse the Preferences json file to set the homepage
sed -i '' 's|"startup_urls":"[A-F0-9]*"|"startup_urls":""|' $chromePrefs
sed -i '' 's|"startup_urls":[[]"http[^"]*"[]]|"startup_urls":["$homepage"]|' $chromePrefs
sed -i '' 's|"homepage":"http[^"]*"|"homepage":"$homepage"|' $chromePrefs


done

# Set homepages in user template for future users

# Safari
cp "/Users/$adminUser/Library/Preferences/com.apple.Safari.plist" "/System/Library/User Template/English.lproj/Library/Preferences/com.apple.Safari.plist"

# Chrome
cp "/Users/$adminUser/Library/Application Support/Google/Chrome/Default/Preferences" "/System/Library/User Template/English.lproj/Library/Application Support/Google/Chrome/Default/Preferences"
