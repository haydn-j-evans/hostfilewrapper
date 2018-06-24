[TOC]

# Hostfilewrapper

Creates Dnsmasq Wrapper to Include /etc/hosts for DNS resolution for NetworkManager Implementation for ubuntu versions 12.04, 14.02, 16.04, 17.04,  18.04


####Background:

For whatever reason, NetworkManager runs its dnsmasq-base implementation with the following hard coded options:

--conf-file
--no-hosts
--keep-in-foreground
--bind-interfaces
--except-interface
--clear-on-reload

This means that if you run a WIFI hotspot or have a VM on this computer, you cannot create a hostfile based adblocking system, or create an internal hostfile based domain on your network (such as https://github.com/StevenBlack/hosts) ).

The base code for this behavior can be found here under the file "nm-dnsmasq-manager.c" (if you want to try and get the actual code fixed)

https://github.com/NetworkManager/NetworkManager/tree/master/src/dnsmasq

####Implemtation

This script will rename the dnsmasq binary and then create a bash script in its place, that will call the replaced binary in it, but first stripping out the --no-hosts argument.

The script then corrects the permissions needed for the new file created and restarts network manager.



