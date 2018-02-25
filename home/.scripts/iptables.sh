#!/bin/bash

## flush current iptables rules &&
## set default rules

# flush iptables & ip6tables
sudo iptables -F && sudo iptables -X
sudo ip6tables -F && sudo iptables -X

# set default rules
sudo iptables-restore < Documents/iptables
sleep 6
sudo ip6tables-restore < Documents/ip6tables
sleep 6

# save iptables rules
sudo /sbin/iptables-save
sleep 2
sudo /sbin/ip6tables-save
