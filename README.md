# CleanVM

A browser-only, performance-focused VM setup optimized for a minimal desktop experience.

## Overview

CleanVM is a lightweight virtual machine environment designed to run in the browser with a streamlined installation flow. It defaults to i3, keeps the desktop minimal, and runs through a KasmVNC browser interface for fast interaction.

## Default setup

- Desktop environment: i3
- Default browser: Helium Browser
- Minimal app bundle focused on utility and performance
- KasmVNC browser session on port 3000

## Installation

Open a blank GitHub Codespace and run:

```bash
curl -fsSL https://raw.githubusercontent.com/laserdg/CleanVM/main/install.sh -o install.sh && chmod +x install.sh && ./install.sh
```

Then:

1. Paste the install command in the terminal
2. Click Install in the CleanVM installer UI
3. Open the forwarded KasmVNC page on port 3000

The VM is designed to launch directly in the browser once the install completes.

## Project goals

- browser-only VM experience
- performance focused
- minimal default software footprint
- default to i3 and Helium
- simple single-page installer flow

## Notes

This project is a clean, stripped-down browser VM setup designed for a focused desktop experience without unnecessary default apps.
