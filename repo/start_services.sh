#!/bin/bash
echo "Script starting"
/usr/sbin/sshd
nginx -g 'daemon off;'
