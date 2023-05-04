#!/bin/bash
dnf install -y dnf-automatic
sed -i 's/apply_updates = no/apply_updates = yes/' /etc/dnf/automatic.conf
while :
do 
	sleep 1000
	dnf-automatic
done

