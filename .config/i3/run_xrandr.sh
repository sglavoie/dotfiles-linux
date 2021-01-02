#!/bin/bash

# Set up monitor at launch automatically and set laptop screen as the
# primary one. Set monitor to the top (being on the vertical axis
# makes it possible to focus bottom/top and jump from one monitor to
# the next, which is not possible if the monitor is set to top-left or
# top-right in diagonal, for instance)
xrandr --output eDP --primary --mode 1920x1080 --pos 0x1080 \
    --rotate normal --output HDMI-A-0 --mode 1920x1080 --pos 0x0 --rotate normal
