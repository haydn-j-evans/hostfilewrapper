#!/bin/bash -e  
 
# Version 1
# Haydn Evans
# 2018
 
# Stops the network manager and unlocks the dnsmasq bin (if needed)
  
systemctl stop NetworkManager  
  
# The first command copies the dnsmasq binary to "dnsmasq.bin" (basically the same)  
  
mv /usr/sbin/dnsmasq /usr/sbin/dnsmasq.bin  
  
# We then create a brand new "dnsmasq" which is actually a bash script we have prepared 

cp /var/git/hostfilewrapper/dnsmasq > /usr/sbin/dnsmasq 

# Set the correct permissions for the dnsmasq script

chmod +x /usr/sbin/dnsmasq  
  
# Restarts the network manager 

systemctl start NetworkManager  