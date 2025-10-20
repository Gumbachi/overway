#! /bin/sh

status=$(systemctl is-active --user wlsunset)

if [ $status = "active" ]; then
  systemctl stop --user wlsunset
  echo "stopped"
else
  systemctl start --user wlsunset
  echo "started"
fi
