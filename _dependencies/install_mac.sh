#!/bin/bash

# Script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Source directory
SOURCE_DIR="${SCRIPT_DIR}/_orbinaut_filter_distortion"

# Check if source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
  echo "${SOURCE_DIR} does not exist. Make sure it is located in the same directory as this script."
  exit 1
fi

# Destination base directory
DEST_DIR_BASE="/Users/Shared/GameMakerStudio2/Cache/runtimes"

# Get latest runtime directory
LATEST_DIR=$(ls -td "${DEST_DIR_BASE}"/* | head -1)

# Check if destination directory exists
if [ ! -d "$LATEST_DIR" ]; then
  echo "${LATEST_DIR} runtime does not exist. Make sure GameMaker is installed."
  exit 1
fi

# FiltersAndEffects path
DEST_DIR="${LATEST_DIR}/bin/FiltersAndEffects"

# Copy folder
cp -r "$SOURCE_DIR" "$DEST_DIR"

# Check if copying was successful
if [ $? -eq 0 ]; then
  echo "Effect has been succesfully installed for runtime ${LATEST_DIR}"
else
  echo "An error has occured while installing the effect..."
  exit 1
fi