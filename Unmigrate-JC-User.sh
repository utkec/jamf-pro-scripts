#!/bin/bash

#Get currently logged in user
getUser=$(ls -l /dev/console | awk '{ print $3 }')
 
#Get alias of currently logged in user ($getUser)
alias=$(dscl . read /Users/$getUser RecordName | awk '{ print $3 }')

# Double check user and alias
echo "$getUser"
echo "$alias"

# Delete all the Jamf Connect mappings
echo "Delete RecordName"
echo "-------------"
dscl . delete /Users/$getUser RecordName $alias
echo "-------------"
echo "Delete NetworkUser"
echo "-------------"
dscl . delete /Users/$getUser dsAttrTypeStandard:NetworkUser
echo "-------------"
echo "Delete OIDCProvider"
echo "-------------"
dscl . delete /Users/$getUser dsAttrTypeStandard:OIDCProvider
echo "-------------"
echo "Delete OktaUser"
echo "-------------"
dscl . delete /Users/$getUser dsAttrTypeStandard:OktaUser
echo "-------------"