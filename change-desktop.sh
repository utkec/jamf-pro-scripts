#!/usr/bin/env bash

## Will change the desktop backround picture. Note: the start up drive must be named.
## Example of path: {"Macintosh HD:users:user.name:background.png"}
## Terminal may need full access (iTerm asked for full permissions), but running this through Jamf Pro as root should negate that
osascript -e 'tell Application "Finder"' -e 'set the desktop picture to {"NAME OF STARTUP DRIVE:PATH:TO:PICTURE.jpg"} as alias' -e 'end tell'
