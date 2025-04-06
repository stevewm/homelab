#!/usr/bin/env sh

set -e

MODS_DIR="/data/Mods"
# shellcheck disable=SC2034 # used in mods.py


download_mods() {
  mkdir -p "$MODS_DIR"

  uv run --script /init/mods.py --env-file /init/.env
}

copy_directories() {
  for dir in /tmp/*/; do
    cp -r "$dir" "$VS_DATA_PATH/"
    echo "Copying $dir to $VS_DATA_PATH"
  done

  echo "Finished copying from $dir"
}

download_mods
copy_directories
