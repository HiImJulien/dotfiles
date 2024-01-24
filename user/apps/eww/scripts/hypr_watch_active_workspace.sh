#!/usr/bin/env bash

on_event() {
    num=$(echo "$1" | grep -Eo "[0-9]+$")
    echo $num
}

handle() {
  case $1 in
      workspace*) on_event $1;;
      focusedmon*) on_event $1;;
  esac
}

socat -U - UNIX-CONNECT:/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do handle "$line"; done
