#!/bin/bash
#Please change to fit your instance
APIname="ADMIN"
APIpass="PASS"
jamfURL="https://INSTANCENAME.jamfcloud.com"
echo "Please enter username you wish to look up:"
read user
#Grabs the id of the a computer tied to the user.
computerIDs=($( /usr/bin/curl -X  GET -u "$APIname":"$APIpass" "$jamfURL/JSSResource/users/name/$user" -H "accept: application/xml" -s | xmllint --xpath '/user/links/computers/computer/id' - | sed -Ee 's/<.?id><id>/ /g' -Ee 's/<.?id>//g'))
for compID in ${computerIDs[@]}
do
	#Grabs Computer Info
	compData=$( /usr/bin/curl -X  GET -u "$APIname":"$APIpass" "$jamfURL/JSSResource/computers/id/$compID" -H "accept: application/xml" -s )
	#Displays Device info based on user
	#Displays Device info based on user
        echo "-----------"
        echo "Device Model: " | tr -d '\n'
        echo $compData| xmllint --xpath '/computer/hardware/model/text()' - | sed 's,%,,g'
        echo "Device Name: " | tr -d '\n'
        echo $compData | xmllint --xpath '/computer/general/name/text()' - | sed 's,%,,g'
        echo "Device Serial Number: " | tr -d '\n'
        echo $compData| xmllint --xpath '/computer/general/serial_number/text()' - | sed 's,%,,g'
done
#API Calls: 2