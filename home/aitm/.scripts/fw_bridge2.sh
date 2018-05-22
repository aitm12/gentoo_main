#! /bin/bash
## script for bridged network firewall

# define variables
ipt="/sbin/iptables"


# clear the rules
$ipt -F
$ipt -X
$ipt -Z
$ipt -t nat -F
$ipt -t nat -X
$ipt -t nat -Z

# close off POLICY
$ipt -P INPUT DROP
$ipt -P OUTPUT ACCEPT
$ipt -P FORWARD DROP
$ipt -t nat -P OUTPUT ACCEPT
$ipt -t nat -P PREROUTING ACCEPT
$ipt -t nat -P POSTROUTING ACCEPT
$ipt -t mangle -P PREROUTNG ACCEPT
$ipt -t mangle -P POSTROUTING ACCEPT

# necessary for loopback interface
$ipt -A INPUT -i lo -j ACCEPT

# enable ip masquerade
$ipt -t nat -A POSTROUTING -o eno1 -j MASQUERADE

# restrict lxc guest005 & guest007 from accessing each other
$ipt -A FORWARD -s 192.168.1.16 -d 192.168.1.11 -j DROP
$ipt -A FORWARD -s 192.168.1.11 -d 192.168.1.16 -j DROP

# enable unrestricted outgoing traffic, incoming is
# restricted to locally-initiated sessions only
$ipt -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
$ipt -A FORWARD -i eno1 -o br0 -m state --state ESTABLISHED,RELATED -j ACCEPT
$ipt -A FORWARD -i br0 -o eno1 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT

# Allow all outbound
$ipt -A OUTPUT -j ACCEPT

# all outbound from container
$ipt -A FORWARD -i br0 -j ACCEPT

# allow http traffic forwarded to container
#$ipt -A INPUT -i eno1 -p tcp --dport 80  -j ACCEPT
#$ipt -A FORWARD -i eno1 -p tcp --dport 80 -j ACCEPT

# allow keyserver traffic forwarded
#$ipt -A INPUT -i eno1 -p tcp --dport 11371 -j ACCEPT
#$ipt -A FORWARD -i eno1 -p tcp --dport 11371 -j ACCEPT

# accept important icmp
$ipt -A INPUT -p icmp --icmp-type echo-request -j ACCEPT
$ipt -A INPUT -p icmp --icmp-type time-exceeded -j ACCEPT
$ipt -A INPUT -p icmp --icmp-type destination-unreachable -j ACCEPT

# forward to container
$ipt -A FORWARD -i eno1 -p tcp --dport 56881:56889 -j ACCEPT
$ipt -A FORWARD -i eno1 -p udp --dport 56881:56889 -j ACCEPT

# reject connection not initiated from inside
$ipt -A INPUT -p tcp --syn -j DROP
# reject all other
$ipt -A INPUT -j DROP
$ipt -A FORWARD -j DROP
