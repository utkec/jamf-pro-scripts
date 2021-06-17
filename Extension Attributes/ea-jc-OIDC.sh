#!/bin/bash

#Grabs currently logged in user
user=`stat -f%Su /dev/console`

#Returns OIDCProvider
return=`dscl . read /Users/$user dsAttrTypeStandard:OIDCProvider | awk '{print $2}'`

echo "<result>$return</result>"