#!/usr/bin/env bash

set -e

mkdir -p "$MODS_DIR"

urls=(
  "https://mods.vintagestory.at/download?fileid=29227" # Primitive Survival v3.7.5
  "https://mods.vintagestory.at/download?fileid=31297" # Expanded Foods v1.7.3
  "https://mods.vintagestory.at/download?fileid=31302" # A Culinary Artillery v1.2.3
  "https://mods.vintagestory.at/download?fileid=26136" # CarryOn v1.8.0-pre.1
  "https://mods.vintagestory.at/download?fileid=30660" # BetterRuins v0.4.6
  "https://mods.vintagestory.at/download?fileid=31137" # ConfigLib v1.4.4
  "https://mods.vintagestory.at/download?fileid=26632" # ImGui v1.1.7
  "https://mods.vintagestory.at/download?fileid=30915" # Ancient Dungeons (Th3Dungeon) v0.4.0
)

rm -rf "${MODS_DIR:?}"/*
cd "$MODS_DIR"
for url in "${urls[@]}"; do
  curl -LOJs "$url"
done

echo "Downloads completed."
