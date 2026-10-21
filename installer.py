#!/usr/bin/env python3

# Deprecated: interactive TUI installer removed.
# This file is intentionally kept as a no-op to avoid breaking
# older references while the automatic install flow is used.

import json

DEFAULT_CONFIG = {
    "defaultapps": [0],
    "programming": [],
    "apps": [],
    "enablekvm": False,
    "DE": "I3 (Very Lightweight)",
    "install": True,
}

with open("options.json", "w", encoding="utf-8") as f:
    json.dump(DEFAULT_CONFIG, f)

print("Auto-install config written to options.json. The old TUI installer is disabled.")
