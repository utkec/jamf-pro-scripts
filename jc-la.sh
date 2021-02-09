#!/bin/bash

loggedInUser=$( scutil <<< "show State:/Users/ConsoleUser" | awk '/Name :/ && ! /loginwindow/ { print $3 }' )

su "$loggedInUser" -c "launchctl load /Library/LaunchAgents/com.jamf.connect.plist"