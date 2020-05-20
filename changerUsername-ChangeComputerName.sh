#!/usr/bin/env bash

## CHANGER USERNAME IN JAMF PRO

# prompt "Question" "Default value"
function prompt() {
  osascript <<EOT
    tell app "System Events"
      text returned of (display dialog "$1" default answer "$2" buttons {"OK"} default button 1 with title "$(basename $0)")
    end tell
EOT
}

value="$(prompt 'Enter Username' ' ')"


## CHANGE COMPUTERNAME

## Enter the API Username, API Password and JSS URL here
apiuser="USERNAME"
apipass="PASSWORD"
jssURL="https://YourJamfProURL.jamfcloud.com"

## Get the Mac's UUID string
UUID=$(ioreg -rd1 -c IOPlatformExpertDevice | awk -F'"' '/IOPlatformUUID/{print $4}')

## Pull the Asset Tag by accessing the computer records "general" subsection
assetTag=$(curl -H "Accept: text/xml" -sfku "${apiuser}:${apipass}" "${jssURL}/JSSResource/computers/udid/${UUID}/subset/general" | xmllint --format - 2>/dev/null | awk -F'>|<' '/<asset_tag>/{print $3}')

#gets current logged in user
getUser=$(ls -l /dev/console | awk '{ print $3 }')

#gets first name and grabs 1 char, gets last name and grabs 1,2,3 char, sets to 
firstInitial=$(finger -s $getUser | head -2 | tail -n 1 | awk '{print toupper($2)}' | cut -c 1)
lastName=$(finger -s $getUser | head -2 | tail -n 1 | awk '{print toupper($3)}' | cut -c 1,2,3)
computerName=$firstInitial$lastName"-ML-"$assetTag

scutil --set ComputerName "$computerName"
scutil --set LocalHostName "$computerName"
scutil --set HostName "$computerName"

jamf recon -endUsername $value
