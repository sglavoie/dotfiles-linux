#!/bin/bash

# Set up monitor at launch automatically and set laptop screen as the
# primary one. Set monitor to the right.
xrandr --output eDP --primary --mode 1920x1080 --pos 0x0 \
    --rotate normal --output HDMI-A-0 --mode 1920x1080 --pos 1920x0 --rotate normal
