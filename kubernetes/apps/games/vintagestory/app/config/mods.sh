#!/usr/bin/env sh

set -e

mkdir -p "$MODS_DIR"

urls="\
https://mods.vintagestory.at/download?fileid=29227 \
https://mods.vintagestory.at/download?fileid=31297 \
https://mods.vintagestory.at/download?fileid=31302 \
https://mods.vintagestory.at/download?fileid=26136 \
https://mods.vintagestory.at/download?fileid=30660 \
https://mods.vintagestory.at/download?fileid=31137 \
https://mods.vintagestory.at/download?fileid=26632 \
https://mods.vintagestory.at/download?fileid=30915"

rm -rf "${MODS_DIR:?}"/*
cd "$MODS_DIR"
for url in $urls; do
  curl -LOJs "$url"
done

echo "Downloads completed."
