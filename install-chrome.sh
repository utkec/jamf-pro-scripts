#!/bin/bash

#Download the pkg to /tmp folder
curl 'https://dl.google.com/chrome/mac/stable/GGRO/googlechrome.dmg' -o /tmp/googlechrome.dmg

#Mount the DMG
hdiutil attach /tmp/googlechrome.dmg

#Copy the app to /Applications
cp -r /Volumes/Google\ Chrome/Google\ Chrome.app /Applications/

#Unmount the DMG
hdiutil detach /Volumes/Google\ Chrome/

#Clean up
rm /tmp/googlechrome.dmg
