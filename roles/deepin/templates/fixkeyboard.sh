#!/bin/sh
export DISPLAY=:0.0
dbus-monitor --session "interface='com.deepin.SessionManager'" | \
(
#  while read x; do
  while true; do
    read x
    case $x in
      *"boolean true"*) echo "Screen locked";;
      *"boolean false"*) setxkbmap -layout {{ kb_layout.stdout }} -variant {{ kb_variant.stdout }} && echo "KB fixed";;
    esac
  done
)
