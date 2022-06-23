#!/bin/bash

#Installing lxd if it is not installed.

if [ ! -f /snap/bin/lxd ]
then
	sudo snap install lxd
else
	echo "lxd found"
fi
cat <<EOF 



EOF

#Creating lxdbr0 interface if it is not found.

ip a | grep -q lxdbr0 && echo "Interface found" || lxd init –auto

cat <<EOF 



EOF


#Launching a container running Ubuntu server named COMP2101-S22 if it is not found.
lxc list type=container | grep -q COMP2101-S22 && echo "Container COMP2101-S22 found" || lxc launch images:ubuntu/22.04 COMP2101-S22

cat <<EOF 



EOF

#Adding the name COMP2101-S22 with the container’s IP address in /etc/hosts if it is not there.
  cat /etc/hosts | grep -q COMP2101-S22 && echo "Container name and IP address is already there" || lxc list | grep COMP2101-S22 | awk '{print $2,$6}' >/etc/hosts


 cat <<EOF 



EOF

#Installing curl if it is not there.
if [ ! -f /usr/bin/curl ]
then
        sudo apt install curl
else
        echo "curl already exist"
fi

cat <<EOF 



EOF

#Installing Apache2 in container if it is not installed.
ip=$(lxc list | grep COMP2101-S22 | awk '{print $6}')
name=$(lxc list | grep COMP2101-S22 | awk '{print $2}')
curl $ip | grep -q Apache2 && echo "Apache already exist" ||lxc exec $name -- apt install apache2


cat <<EOF 





EOF

#Retrieving information from web service and notyfying the user about success or failure.

curl $ip && echo "Web page retrieved successfully" || "Failed to retrieve webpage"
