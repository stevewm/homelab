#!/usr/bin/env sh

set -e

MODS_DIR="${VS_DATA_PATH:?}/Mods"

download_mods() {
  mkdir -p "$MODS_DIR"

  urls="\
  https://mods.vintagestory.at/download/35898/primitivesurvival_3.7.6.zip \
  https://mods.vintagestory.at/download/33380/ExpandedFoods%201.7.4.zip \
  https://mods.vintagestory.at/download/35171/ACulinaryArtillery%201.2.5.zip \
  https://mods.vintagestory.at/download/38654/CarryOn-1.20_v1.8.0-rc.4.zip \
  https://mods.vintagestory.at/download/37908/BetterRuinsv0.4.9.zip \
  https://mods.vintagestory.at/download/39899/vsimgui_1.1.8.zip \
  https://mods.vintagestory.at/download/39423/th3dungeon_0.4.2.zip \
  https://mods.vintagestory.at/download/25132/VintageRCon-1.0.zip \
  https://mods.vintagestory.at/download/34353/webcartographer_0.7.0.zip \
  https://mods.vintagestory.at/download/33205/ps-peltpatch-0.0.1.zip"

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
