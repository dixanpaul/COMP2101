#This is the system information of this device.


#This displays the hostname of the device.
echo "Hostname: $(hostname)"


#This displays the name and verson of operating system.
#We use grep command to retrieve  one line from the whole data provided in the file /etc/os-release.
echo "Operating system name and version: $(grep PRETTY_NAME /etc/os-release)"


#This displays ip address of the device.
#We used grep command to select the line containing ip address and awk command to select the word from the line by passing it through the pipeline.
echo "IP Address: $(ip a s ens33 | grep -w inet | awk '{print $2}')"


#This displays the amount of space available in root filesystem.
#We used df command to display the disc usage and the option -h to display it in human friendly form.
#Since /dev/sda3 is my root filesystem, I captured that details.
echo "Root Filesystem Status:"
df -h /dev/sda3
