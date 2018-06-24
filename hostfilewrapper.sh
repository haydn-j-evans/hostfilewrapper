#!/bin/bash -e  
  
systemctl stop NetworkManager  
  
#The first command copies the dnsmasq binary to "dnsmasq.bin" (basically the same)  
  
mv /usr/sbin/dnsmasq /usr/sbin/dnsmasq.bin  
  
#We then create a brand new "dnsmasq" which is actually a bash script  

/bin/cat > /usr/sbin/dnsmasq' <<EOF  
	
	DNSMASQ_BIN="/usr/sbin/dnsmasq.bin"  
	# strip --no-hosts switch so /etc/hosts is read  
	DNSMasqParameters=$(echo -n "$@" | sed --regexp-extended "s/ --no-hosts( |$)/ /")  
	exec $DNSMASQ_BIN $DNSMasqParameters  
EOF  

#Set the correct permissions for the script

chmod +x /usr/sbin/dnsmasq  
  
systemctl start NetworkManager  