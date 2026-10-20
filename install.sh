#!/bin/bash

set -euo pipefail

echo "Starting CleanVM installation..."

if ! command -v jq >/dev/null 2>&1; then
    sudo apt-get update
    sudo apt-get install -y jq
fi

if [[ ! -d CleanVM ]]; then
    git clone https://github.com/laserdg/CleanVM.git
fi

cd CleanVM

cat > options.json <<'JSON'
{"defaultapps":[0],"programming":[],"apps":[],"enablekvm":false,"DE":"I3 (Very Lightweight)","install":true}
JSON

if ! jq -e 'type == "object"' options.json >/dev/null 2>&1; then
    echo "Error: options.json is invalid JSON" >&2
    exit 1
fi

docker build -t cleanvm . --no-cache

cd ..

mkdir -p Save
if [[ -d CleanVM/root/config ]]; then
    cp -r CleanVM/root/config/* Save
fi

json_file="CleanVM/options.json"
if jq -e '.enablekvm == true' "$json_file" >/dev/null 2>&1; then
    docker run -d --name=CleanVM \
        -e PUID=1000 -e PGID=1000 \
        --device=/dev/kvm \
        --security-opt seccomp=unconfined \
        -e TZ=Etc/UTC -e SUBFOLDER=/ -e TITLE=CleanVM \
        -p 3000:3000 \
        --shm-size="2gb" \
        -v "$(pwd)/Save:/config" \
        cleanvm
else
    docker run -d --name=CleanVM \
        -e PUID=1000 -e PGID=1000 \
        --security-opt seccomp=unconfined \
        -e TZ=Etc/UTC -e SUBFOLDER=/ -e TITLE=CleanVM \
        -p 3000:3000 \
        --shm-size="2gb" \
        -v "$(pwd)/Save:/config" \
        cleanvm
fi

clear
echo "CleanVM is installed and starting. Open the KasmVNC page on port 3000 in your browser."
