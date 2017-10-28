# Ping to the router
ping -c2 192.168.1.1 > /dev/null

# If the return code from ping ($?) is not 0 (meaning there was an error)
if [ $? != 0 ]; then
    # Restart the wireless interface
    ifdown --force wlan0
    sleep 5
    ifup wlan0
    echo "wlan0 reconnected at `date`"
fi
