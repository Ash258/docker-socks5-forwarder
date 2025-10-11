#!/bin/sh

red_conf='/etc/redsocks.conf'
dante_conf='/etc/danted.conf'
envsubst < "${red_conf}.template" > "${red_conf}"
envsubst < "${dante_conf}.template" > "${dante_conf}"

# Start redsocks
redsocks -c "${red_conf}" &

# Configure iptables to redirect traffic from Dante to redsocks
iptables -t nat -A OUTPUT -p tcp --dport 80 -j REDIRECT --to-ports "${REDSOCKS_PORT}"
iptables -t nat -A OUTPUT -p tcp --dport 443 -j REDIRECT --to-ports "${REDSOCKS_PORT}"

# Start Dante server
exec sockd -f "${dante_conf}"
