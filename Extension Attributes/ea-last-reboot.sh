#!/bin/sh

lastboot = `last reboot | tail -3 | head -1 | awk '{ print $6 " " $3 ", " $4 " " $5 }'`

echo "<result>$lastboot</result>"
