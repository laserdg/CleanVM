#!/bin/bash

set -euo pipefail

echo "Starting CleanVM installation..."

git clone https://github.com/laserdg/CleanVM.git
cd CleanVM

cat > options.json <<'JSON'
{"defaultapps":[0],"programming":[],"apps":[],"enablekvm":true,"DE":"I3 (Very Lightweight)","install":true}
JSON

if [[ ! -f options.json ]]; then
    echo "Error: no installer config was generated" >&2
    exit 1
fi
if ! jq -e 'type == "object"' options.json >/dev/null 2>&1; then
    echo "Error: options.json is invalid JSON" >&2
    exit 1
fi

docker build -t cleanvm . --no-cache
cd ..

sudo apt update
sudo apt install -y jq

mkdir -p Save
cp -r CleanVM/root/config/* Save

json_file="CleanVM/options.json"
if jq ".enablekvm" "$json_file" | grep -q true; then
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
