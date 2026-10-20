#!/usr/bin/env python3

import json

DEFAULT_CONFIG = {
    "defaultapps": [0],
    "programming": [],
    "apps": [],
    "enablekvm": True,
    "DE": "I3 (Very Lightweight)",
    "install": True,
}

with open("options.json", "w", encoding="utf-8") as f:
    json.dump(DEFAULT_CONFIG, f)

print("Auto-install config written to options.json. No install button required.")
