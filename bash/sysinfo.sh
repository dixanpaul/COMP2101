#!/bin/bash

#This is the system information of this device.


#This command store the hostname of the device.
hn=$(hostname)


# This command store domain name if it have one.
dn=$(dnsdomainname)


#This command store the name and verson of operating system.
#We use 2 options with the command to get the precise reading.
os=$(lsb_release -d -s)


#This command store ip address of the device.
#We used grep command to select the line containing ip address and awk command to select the word from the line by passing it through the pipeline.
ip=$(ip a s ens33 | grep -w inet | awk '{print $2}')


#This command stores the amount of free space available in root filesystem.
#We used df command to display the disc usage, tail to select the last line, and awk to get only the required data.
freespace=$(df -h /dev/sda3 | tail -1 | awk '{print $4}')


#We are calling all variables to display the result.
cat <<EOF


 Report for $hn
 ======================================================================

 FQDN: $dn
 Operating System name and version: $os 
 IP Address: $ip
 Root Filesystem Free Space: $freespace

 ======================================================================
EOF
