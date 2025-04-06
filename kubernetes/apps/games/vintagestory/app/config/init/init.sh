#!/usr/bin/env sh

set -e

MODS_DIR="${VS_DATA_PATH:?}/Mods"
# shellcheck disable=SC2034 # used in mods.py
MODS_FILE="/init/mods.yaml"

download_mods() {
  mkdir -p "$MODS_DIR"

  uv run --script mods.py --cache-dir /tmp/uv
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
