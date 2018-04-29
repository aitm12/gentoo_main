#! /bin/bash

# clear the rules
iptables -F
iptables -X
iptables -Z

# close off POLICY
iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP

# accept established inbound
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT

# Allow all outbound
iptables -A OUTPUT -j ACCEPT

# all outbound from container
iptables -A FORWARD -i br0 -j ACCEPT

# allow http traffic forwarded to container
iptables -A INPUT -i eno1 -p tcp --dport 80  -j ACCEPT
iptables -A FORWARD -i eno1 -p tcp --dport 80 -j ACCEPT

# allow ping
iptables -A INPUT -p icmp -m icmp --icmp-type 8 -j ACCEPT

# reject all other
iptables -A INPUT -j DROP
iptables -A FORWARD -j DROP

## nat
# forward http to container server?
#iptables -A PREROUTING -i eno1 -p tcp -m tcp --dport 80 -j DNAT --to-destination 192.168.1.16:80

# allow lxc subnet access
# doesnt work
#iptables -A POSTROUTING -s 192.168.1.1/24 -j MASQUERADE
