#!/bin/bash

# Please note that if this setting was pushed via an MDM command that
# the below plist will be located in /Library/ManagedPreferences/
results=$( defaults read /Library/Preferences/com.apple.loginwindow DisableFDEAutoLogin )

if [[ "$results" == "YES" ]]
then
    echo "<result>True</result>"
else
    echo "<result>False</result>"
fi
