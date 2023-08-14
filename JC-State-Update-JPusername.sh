#!/bin/bash

#The goal of this script is to be used in conjuction with Jamf Connect to grab the IdP username after
#they login with Jamf Connect, and then update their device's inventory record with said username
#created by Casey Utke

#Get current signed in user
currentUser=$(ls -l /dev/console | awk '/ / { print $3 }')

#com.jamf.connect.state.plist location
jamfConnectStateLocation=/Users/$currentUser/Library/Preferences/com.jamf.connect.state.plist

DisplayName=$(/usr/libexec/PlistBuddy -c "Print :DisplayName" $jamfConnectStateLocation || echo "Does not exist")
echo $DisplayName
if  [ "$DisplayName" != "Does not exist" ]; then
	/usr/local/bin/jamf recon -endUsername $DisplayName
fi