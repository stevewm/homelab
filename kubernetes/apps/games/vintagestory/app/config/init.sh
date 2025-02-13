#!/usr/bin/env sh

set -e

MODS_DIR="${VS_DATA_PATH:?}/Mods"

download_mods() {
  mkdir -p "$MODS_DIR"

  # Mod List (ID: Name Version)
  # 29227: Primitive Survival 3.7.5
  # 31297: Expanded Foods 1.7.3
  # 31302: A Culinary Artillery 1.2.3
  # 26136: Carry-On 1.8.0-pre1
  # 31137: Better Ruins 0.4.6
  # 26632: VSImGui 1.1.7
  # 30915: Th3Dungeon 0.4.0
  # 25132: VintageRCon 1.0
  # 30921: WebCartographer 0.6.1
  # 33205: Primitive Survival Pelt Patch 0.0.1

  urls="\
  https://mods.vintagestory.at/download?fileid=29227 \
  https://mods.vintagestory.at/download?fileid=31297 \
  https://mods.vintagestory.at/download?fileid=31302 \
  https://mods.vintagestory.at/download?fileid=26136 \
  https://mods.vintagestory.at/download?fileid=30660 \
  https://mods.vintagestory.at/download?fileid=31137 \
  https://mods.vintagestory.at/download?fileid=26632 \
  https://mods.vintagestory.at/download?fileid=30915 \
  https://mods.vintagestory.at/download?fileid=25132 \
  https://mods.vintagestory.at/download?fileid=30921 \
  https://mods.vintagestory.at/download?fileid=33205"

  rm -rf "${MODS_DIR:?}"/*
  cd "$MODS_DIR"
  for url in $urls; do
    echo "Downloading $url..."
    curl -LOJsf "$url"
  done

  echo "Mods downloaded!"
}

copy_directories() {
  for dir in /tmp/*/; do
    cp -r "$dir" "$VS_DATA_PATH/"
    echo "Copying $dir to $VS_DATA_PATH"
  done

  echo "Finished copying from $dir"
}

# Main script execution
download_mods
copy_directories
