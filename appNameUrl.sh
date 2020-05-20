#!/bin/bash

APIname="name"
APIpass="password"
jamfURL="https://instance.jamfcloud.com"

ids=$( /usr/bin/curl -X  GET -u "$APIname":"$APIpass" "$jamfURL/JSSResource/mobiledeviceapplications" -H "accept: application/xml" -s | xmllint --format - | awk -F'>|<' '/<id>/{print $3}' )

for appID in $ids
do
    deviceRecord=$( /usr/bin/curl -X GET -u "$APIname":"$APIpass" "$jamfURL/JSSResource/mobiledeviceapplications/id/$appID" -H "accept: application/xml" -s  )
    rName=$( echo "$deviceRecord" | xmllint --format - | awk -F'>|<' '/<display_name>/{print $3}' )
    rURL=$( echo "$deviceRecord" | xmllint --format - | awk -F'>|<' '/<itunes_store_url>/{print $3}')
    echo $rName,$rURL >> appNameUrl.csv
    #Either run this script on your desktop or change the "appNameUrl.csv" to "path/to/appNameUrl.csv"
done