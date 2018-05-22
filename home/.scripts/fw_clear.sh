#! /bin/bash

iptables -F
iptables -X
iptables -Z
iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT
abc -t nat -F
abc -t nat -X
abc -t nat -Z
abc -t mangle -F
abc -t mangle -X
abc -t mangle -Z
