

# Hostfilewrapper

Creates Dnsmasq Wrapper to Include /etc/hosts for DNS resolution for NetworkManager Implementation for ubuntu versions 12.04, 14.02, 16.04, 17.04,  18.04


## Background:

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

## Implemtation

This script will rename the dnsmasq binary and then create a bash script in its place, that will call the replaced binary in it, but first stripping out the --no-hosts argument.

The script then corrects the permissions needed for the new file created and restarts network manager.

This idea was taken and expanded from this forum post https://askubuntu.com/questions/117899/configure-networkmanagers-dnsmasq-to-use-etc-hosts , credit to kbenoit!

## Install instructions

- git-clone this repo onto your system 
- set the correct file permssions for the script 
- execute the script 
	
	```console foo@bar:~$ sudo git-clone https://www.github.com/haydn-j-evans/hostfilewrapper /var/git/hostfilewrapper```  
	```console foo@bar:~$ sudo chmod +x /var/git/hostfilewrapper/hostfilewrapper.sh```  
	```console foo@bar:~$ sudo ./hostfilewrapper.sh```  

## Script Contents

```sh  
  
#!/bin/bash -e  
  
systemctl stop NetworkManager  
  
#The first command copies the dnsmasq binary to "dnsmasq.bin" (basically the same)  
  
mv /usr/sbin/dnsmasq /usr/sbin/dnsmasq.bin  
  
#We then create a brand new "dnsmasq" which is actually a bash script  
  
bash -c 'cat > /usr/sbin/dnsmasq' << EOF  
DNSMASQ_BIN="/usr/sbin/dnsmasq.bin"  
  
# strip --no-hosts switch so /etc/hosts is read  
DNSMasqParameters=$(echo -n "$@" | sed --regexp-extended "s/ --no-hosts( |$)/ /")  
  
exec $DNSMASQ_BIN $DNSMasqParameters  
  
EOF  

#Set the correct permissions for the script

chmod +x /usr/sbin/dnsmasq  
  
systemctl start NetworkManager  
```

##Contact 

Any questions or suggestions, email me at haydn_j_evans@hotmail.com
