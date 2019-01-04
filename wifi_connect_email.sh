#!/bin/bash

# This shell script runs as a cron and automatically reconnects
# the Raspberry Pi to the Internet if it detects there's no Internet connection.
# It also sends an email with all the IP addresses.
# By Arul John <https://aruljohn.com>

# Ping to the router
ping -c2 192.168.1.1 > /dev/null

# If you cannot get a connection to the router, restart wlan0
if [ $? != 0 ]; then
    ifdown --force wlan0
    sleep 5
    ifup wlan0

    # Find local IP address(es)
    ip=`ifconfig | awk '/inet /{print $2}'`
    body=$ip

    # Find external IP address
    external_ip=`curl --silent https://ipecho.net/plain`
    body="$body $external_ip"

    EMAIL='youremailaddress@yourdomain.com'
    echo "$body" | mailx -s "IP Addresses" $EMAIL
fi
