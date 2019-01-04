#!/bin/bash

# This shell script runs as a cron and automatically reconnects
# the Raspberry Pi to the Internet if it detects there's no Internet connection.

# Ping to the router
ping -c2 192.168.1.1 > /dev/null

# If you cannot get a connection to the router, restart wlan0
if [ $? != 0 ]; then
    # Restart the wireless interface
    ifdown --force wlan0
    sleep 5
    ifup wlan0
fi
