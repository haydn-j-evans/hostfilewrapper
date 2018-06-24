# hostfilewrapper

Creates Dnsmasq Wrapper to Include /etc/hosts for DNS resolution for NetworkManager Implementation


Background:

For whatever reason, NetworkManager runs its dnsmasq-base implementation with the following hard coded options:

--conf-file
--no-hosts
--keep-in-foreground
--bind-interfaces
--except-interface
--clear-on-reload

The code for this startup can be found here under the file "nm-dnsmasq-manager.c": (if you want to try and get the actual code fixed)

https://github.com/NetworkManager/NetworkManager/tree/master/src/dnsmasq


