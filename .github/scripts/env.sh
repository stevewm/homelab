#!/usr/bin/env bash
set -e

if [ ! -f ./.env.txt ]; then
    doppler secrets get GITHUB_HOMELAB_TOKEN --plain > ./env.txt
fi

GITHUB_TOKEN=$(cat .env.txt)
export GITHUB_TOKEN
