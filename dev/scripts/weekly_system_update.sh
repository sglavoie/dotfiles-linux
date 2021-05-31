#!/bin/bash

# run as root to avoid entering password

notify-send "Starting weekly update..."
apt update
apt dist-upgrade -y
snap refresh
apt autoremove -y
notify-send "Weekly update done..."
