#!/bin/bash

set -eu
setterm blank 0
setterm powerdown 0
exec /usr/bin/i3 >/dev/null 2>&1
