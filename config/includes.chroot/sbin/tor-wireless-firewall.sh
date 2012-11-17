#!/bin/sh

# destinations you don't want routed through Tor
NON_TOR="10.0.2.0/24 10.23.42.0/24 172.16.23.0/24"

# Tor's TransPort
TRANS_PORT="9040"

# your internal interface
INT_IF="uap0"

iptables -F
iptables -t nat -F

for NET in $NON_TOR; do
  iptables -t nat -A PREROUTING -i $INT_IF -d $NET -j RETURN
done
iptables -t nat -A PREROUTING -i $INT_IF -p udp --dport 53 -j REDIRECT --to-ports 5353
#iptables -t nat -A PREROUTING -i $INT_IF -p udp --dport 67 -j REDIRECT --to-ports 67
iptables -t nat -A PREROUTING -i $INT_IF -p tcp --syn -j REDIRECT --to-ports $TRANS_PORT
