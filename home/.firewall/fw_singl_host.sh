#! /bin/bash
## iptables firewall script for single host

## define variables
ipt="/sbin/iptables"

## flush firewalls, delete chains
#ipt -F
$ipt -X
$ipt -Z
$ipt -t nat -F
$ipt -t nat -X
$ipta-t nat -Z
$ipt -t mangle -F
$ipt -t mangle -X
$ipt -t mangle -Z

## set default policies
## incoming deny all
## outgoing restricted
$ipt -P INPUT DROP
$ipt -P FORWARD DROP
$ipt -P OUTPUT ACCEPT
$ipt -t nat -P OUTPUT ACCEPT
$ipt -t nat _P PREROUTING ACCEPT
$ipt -t nat -P POSTROUTING ACCEPT
$ipt -t mangle -P PREROUTING ACCEPT
$ipt -t mangle -P POSTROUTING ACCEPT

# necessary for loopback interface
$ipt -A INPUT -i lo -j ACCEPT

## reject connection attempts not initiated from host
$ipt -A INPUT -p tcp --syn -j DROP
## allow incoming connection like im and bittorrent
## comment above rule and add the appropriate ports
#$ipt -A INPUT -p tcp --destination-port [port range] -j ACCEPT
## and add
### drop new tcp connection that are not SYN-flagged
#$ipt -A INPUT -p tcp | --syn -m state --state NEW -j DROP


## accept return traffic initiated from host
$ipt -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

## accept important icmp packets (ping)
$ipt -A INPUT -p icmp --icmp-type echo-request -j ACCEPT
$ipt -A INPUT -p icmp --icmp-type time-exceeded -j ACCEPT
$ipt -A INPUT -p icmp --icmp-type destination-unreachable -j ACCEPT
