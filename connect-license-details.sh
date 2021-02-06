#!/bin/bash

# Created by Casey Utke, Customer Success Manager, on Thursday, February 4 2021.
# Last edited on Thursday, February 4 2021

# To use, run script in terminal and drag and drop the .mobileconfig as the input to script
# or write the entire path by hand.

# Makes Temporary File
tempFile=$( mktemp )

file=$1
# Reads .mobileconfig license and decodes then outputs to the temporary file previously created
jcl=`/usr/libexec/PlistBuddy -c "Print :PayloadContent:1:PayloadContent:com.jamf.connect.login:Forced:0:mcx_preference_settings:LicenseFile" "$file" `
echo $jcl > ${tempFile}

# Grabs data from temporary file (temporary file is technically a plist)
date=$( /usr/libexec/PlistBuddy -c "Print :ExpirationDate" ${tempFile} | awk '{print $1}' )
name=$( /usr/libexec/PlistBuddy -c "Print :Name" ${tempFile} )
num=$( /usr/libexec/PlistBuddy -c "Print :NumberOfClients" ${tempFile} )

# Outputs account name, expiration date, and number of Jamf Connect licenses.
echo "--------Account:" $name
echo "Expiration Date:" $date
echo "Number of Seats:" $num

# Clean Up
rm ${tempFile}
