#!/bin/bash
set -e

# Wait for cloud-init to release the dpkg lock before running apt
while fuser /var/lib/dpkg/lock-frontend >/dev/null 2>&1 || fuser /var/lib/apt/lists/lock >/dev/null 2>&1; do
  sleep 5
done

# Repair any partially configured packages left by cloud-init
DEBIAN_FRONTEND=noninteractive dpkg --configure -a
DEBIAN_FRONTEND=noninteractive apt-get -y --fix-broken install

DEBIAN_FRONTEND=noninteractive apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install -y wget unzip apache2
systemctl enable --now apache2
wget https://www.tooplate.com/zip-templates/2117_infinite_loop.zip
unzip -o 2117_infinite_loop.zip
cp -r 2117_infinite_loop/* /var/www/html/
systemctl restart apache2
