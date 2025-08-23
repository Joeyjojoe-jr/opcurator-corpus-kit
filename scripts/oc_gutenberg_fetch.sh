#!/usr/bin/env bash
set -euo pipefail
sudo mkdir -p /data/gutenberg && sudo chown "$USER":"$USER" /data/gutenberg
cd /data/gutenberg
# downloads omitted for brevity in this short rebuild
