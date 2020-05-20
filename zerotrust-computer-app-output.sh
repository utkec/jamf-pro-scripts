#!/bin/bash


echo "Please enter your full Jamf Pro URL:"
read jssurl

echo "Please enter your Jamf Pro Username:"
read  apiUser

echo "Please enter your Jamf Pro password:"
read -s apiPass

#create temp folder
mkdir /tmp/appinventory

#list all computer IDs
curl -ks -H "Accept: text/xml" -u "$apiUser":"$apiPass" "$jssurl"/JSSResource/computers | xmllint --format - | awk -F '[<>]' '/id/{print $3}' > /tmp/allCompsID.txt

#get computer name for computer IDs
while read compID; do
  computerName=$(curl -k -u $apiUser:$apiPass -H "Accept: text/xml" $jssurl/JSSResource/computers/id/${compID} | xmllint --format - | awk -F'>|<' '/<name>/,/<\/name>/{print $3}' | head -n1)

#get macOS version for all computers
  osVersion=$(curl -k -u $apiUser:$apiPass -H "Accept: text/xml" $jssurl/JSSResource/computers/id/${compID} | xmllint --format - | awk -F'>|<' '/<os_version>/,/<\/os_version>/{print $3}')

#get list of applications installed on each computer name and exports to csv per computer with format compName,osVersion,appName,appVersion
  curl -k -u $apiUser:$apiPass -H "Accept: text/xml" $jssurl/JSSResource/computers/id/${compID} | xmllint --format - | awk -F'>|<' '/<applications>/,/<\/applications>/{print $3}' | tail -n+4 | tr '\n' ',' | sed -e $'s/,,,/\\\n/g' | sed 's/,\/.*,/,/g' | sed -e '$ d' | sed '1s;^;'"$computerName"','"$osVersion"',;' | sed 's/^/,,/g' | sed 's/,,'"$computerName"'/'"$computerName"'/g' | cut -f4 > /tmp/appinventory/$computerName.csv
done < /tmp/allCompsID.txt

#combine individual inventories into one file
cat /tmp/appinventory/*.csv > AllMacAppInventory.csv

#remove temp folder
rm -rf /tmp/appinventory
