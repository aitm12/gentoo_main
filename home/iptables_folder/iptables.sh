#! /bin/bash

##iptables

# clear tables
iptables -F
iptables -X
iptables -Z

# default policy chain
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT DROP

# loop back
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

# outbound dns
iptables -A OUTPUT -o eno1 -p udp --dport 53 -j ACCEPT
iptables -A INPUT -i eno1 -p udp --sport 53 -j ACCEPT

# outbound ping
iptables -A OUTPUT -o eno1 -p icmp --icmp-type echo-request -j ACCEPT
iptables -A INPUT -i eno1 -p icmp --icmp-type echo-reply -j ACCEPT

# outbound ntp clock
iptables -A OUTPUT -o eno1 -p udp --dport 123 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A INPUT  -i eno1 -p udp --sport 123 -m state --state ESTABLISHED -j ACCEPT

# outbound rsync
iptables -A OUTPUT -o eno1 -p tcp -d rsync.gentoo.org --dport 873 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A INPUT -i eno1 -p tcp --sport 873 -m state --state ESTABLISHED -j ACCEPT

# outbound portage mirrors
# inbound rule is at http
iptables -A OUTPUT -o eno1 -p tcp -d gentoo.mirrors.easynew.com --dport 80 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -o eno1 -p tcp -d www.gtlib.gatech.edu --dport 80 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -o eno1 -p tcp -d gentoo.cs.utah.edu --dport 80 -m state --state NEW,ESTABLISHED -j ACCEPT

# outbound HTTP
iptables -A OUTPUT -o eno1 -p tcp --dport 80 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A INPUT -i eno1 -p tcp --sport 80 -m state --state ESTABLISHED -j ACCEPT

# outbound HTTPS
iptables -A OUTPUT -o eno1 -p tcp --dport 443 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A INPUT -i eno1 -p tcp --sport 443 -m state --state ESTABLISHED -j ACCEPT

# keyserver
#iptables -A OUTPUT -o eno1 -p tcp --dport 11371 -m state --state NEW,ESTABLISHED -j ACCEPT
#iptables -A INPUT -i eno1 -p tcp --sport 11371 -m state --state ESTABLISHED -j ACCEPT

## MAIL

# SMTP
iptables -A OUTPUT -o eno1 -p tcp --dport 25 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A INPUT -i eno1 -p tcp --sport 25 -m state --state ESTABLISHED -j ACCEPT

# IMAP IMAPS
iptables -A OUTPUT -o eno1 -p tcp --dport 143 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A INPUT -i eno1 -p tcp --sport 143 -m state --state ESTABLISHED -j ACCEPT

iptables -A OUTPUT -o eno1 -p tcp --dport 993 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A INPUT -i eno1 -p tcp --sport 993 -m state --state ESTABLISHED -j ACCEPT

# pop3 pop3s
iptables -A OUTPUT -o eno1 -p tcp --dport 110 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A INPUT -i eno1 -p tcp --sport 110 -m state --state ESTABLISHED -j ACCEPT

iptables -A OUTPUT -o eno1 -p tcp --dport 995 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A INPUT -i eno1 -p tcp --sport 995 -m state --state ESTABLISHED -j ACCEPT

# */MAIL

# TOR
iptables -A OUTPUT -o eno1 -p tcp --dport 9150 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A INPUT -i eno1 -p tcp --sport 9150 -m state --state ESTABLISHED -j ACCEPT

# Prevent DDOS
iptables -A INPUT -p tcp --dport 80 -m limit --limit 25/minute --limit-burst 100 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -m limit --limit 25/minute --limit-burst 100 -j ACCEPT

# Dropping all other
iptables -A INPUT -j DROP
iptables -A FORWARD -j DROP
iptables -A OUTPUT -j DROP

# list rules
iptables -L
iptables -S
