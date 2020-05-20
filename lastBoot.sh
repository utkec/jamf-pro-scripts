#!/bin/sh

# set some variables and grab the time
lastBoot=`sysctl kern.boottime | awk -F'} ' '{print $NF}'`

echo "<result>$lastBoot</result>"
