#!/bin/bash

set -eu
setterm blank 0
setterm powerdown 0
export XDG_CURRENT_DESKTOP=GNOME
export XDG_SESSION_TYPE=x11
sudo service dbus start
exec /usr/bin/gnome-shell --x11 -r >/dev/null 2>&1
