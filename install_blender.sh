#!/bin/bash

# Ensure script is executable
chmod +x "$0"

# Get processor type
if [[ $(uname -m) == 'arm64' ]]; then
    ARCH="arm64"
# Set Blender version and download URL 
    DOWNLOAD_URL="https://download.blender.org/release/Blender4.2/blender-4.2.1-macos-arm64.dmg"

else
    ARCH="x64"
# Set Blender version and download URL
    DOWNLOAD_URL="https://download.blender.org/release/Blender4.2/blender-4.2.1-macos-x64.dmg"
fi
             
# Download 
echo "Downloading Blender for ${ARCH}..."
curl -L -o blender.dmg "${DOWNLOAD_URL}"

# Mount 
echo "Mounting Blender DMG..."
hdiutil attach blender.dmg


# Check if the DMG was mounted successfully
if [ ! -d "/Volumes/Blender" ]; then
    echo "Failed to mount the DMG."
    exit 1
fi

# Install
echo "Installing Blender..."
cp -R "/Volumes/Blender/Blender.app" /Applications/

# Unmount 
echo "Cleaning up..."
hdiutil detach "/Volumes/Blender"
rm blender.dmg

exit 0
