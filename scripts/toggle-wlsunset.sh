#! /bin/sh

status=$(systemctl is-active --user wlsunset)

if [ $status = "active" ]; then
  systemctl stop --user wlsunset
  echo -n "stopped"
else
  systemctl start --user wlsunset
  echo -n "started"
fi
