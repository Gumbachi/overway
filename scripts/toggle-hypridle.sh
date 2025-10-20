#! /bin/sh

status=$(systemctl is-active --user hypridle)

if [ $status = "active" ]; then
  systemctl stop --user hypridle
  echo "stopped"
else
  systemctl start --user hypridle
  echo "started"
fi
