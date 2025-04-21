#!/bin/bash

echo "Starting removal of k3d, Docker, and kubectl..."

# Remove k3d
echo "Removing k3d..."
if command -v k3d &> /dev/null; then
  sudo rm -f /usr/local/bin/k3d
  echo "k3d removed."
else
  echo "k3d is not installed."
fi

# Remove Docker
echo "Removing Docker..."

#this script will remove all docker containers, images, volumes, and networks