#!/bin/bash

set -eu
setterm blank 0
setterm powerdown 0
exec /usr/bin/cinnamon-session >/dev/null 2>&1
