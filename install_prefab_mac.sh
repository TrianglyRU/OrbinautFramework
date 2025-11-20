#!/bin/bash

# Script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Source directory
SOURCE_DIR="${SCRIPT_DIR}/io.gamemaker.gm_orbinaut_filter_distortion-1.0.0"

# Destination directory
DEST_DIR="/Users/Shared/GameMakerStudio2/Prefabs"

# Check if source exists
if [ ! -d "$SOURCE_DIR" ]; then
  echo "Source folder not found: ${SOURCE_DIR}"
  exit 1
fi

# Ensure destination exists
if [ ! -d "$DEST_DIR" ]; then
  echo "Destination folder not found: ${DEST_DIR}"
  exit 1
fi

# Remove old copy if exists
if [ -d "${DEST_DIR}/io.gamemaker.gm_orbinaut_filter_distortion-1.0.0" ]; then
  echo "Removing existing folder..."
  rm -rf "${DEST_DIR}/io.gamemaker.gm_orbinaut_filter_distortion-1.0.0"
fi

# Copy folder
echo "Copying..."
cp -R "$SOURCE_DIR" "$DEST_DIR"

if [ $? -eq 0 ]; then
  echo "Effect installed successfully."
else
  echo "Error installing effect."
  exit 1
fi

exit 0