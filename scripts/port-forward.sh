#!/bin/bash
# requires User to have passwordless ssh access to localhost

/usr/bin/ssh -4 -L 0.0.0.0:3306:172.30.1.121:3306 0.0.0.0 -N

# run as a systemd service
function install () {
  cat <<EOF > "/etc/systemd/system/port-fwd.service"
[Unit]
Description=mysql port forward

[Service]
Type=simple
User=ec2-user
ExecStart=/opt/port-fwd/port-forward.sh

[Install]
WantedBy=default.target
EOF

}
