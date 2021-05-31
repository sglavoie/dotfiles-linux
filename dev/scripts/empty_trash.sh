#!/bin/bash

rm -rf $HOME/.local/share/Trash/files/*
rm -rf $HOME/.local/share/Trash/info/*
rm -rf $HOME/.local/share/Trash/expunged/*
notify-send "Trash emptied..."
