#!/bin/bash

# This shell script prints all the IP addresses in the Raspberry Pi interfaces.
# By Arul John <https://aruljohn.com>

# Find local IP address(es)
ip=`ifconfig | awk '/inet /{print $2}'`
body=$ip

# Find external IP address
external_ip=`curl --silent https://ipecho.net/plain`
body="$body $external_ip"

echo $body
