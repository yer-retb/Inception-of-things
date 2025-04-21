#!/bin/bash

# Define colors for status messages
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Function to print status messages
print_status() {
    echo -e "${GREEN}[+] $1${NC}"
}

# Function to print error messages and exit
print_error() {
    echo -e "${RED}[-] Error: $1${NC}"
    exit 1
}

# Function to check the status of the last command
check_status() {
    if [ $? -ne 0 ]; then
        print_error "$1 failed"
    fi
}

# Ensure the script is run as root
if [ "$EUID" -ne 0 ]; then 
    print_error "Please run as root (use sudo)"
fi

# Update system packages
print_status "Updating system packages..."
apt-get update && apt-get upgrade -y || print_error "Failed to update system packages"

# Install prerequisites
print_status "Installing prerequisites..."
apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release || print_error "Failed to install prerequisites"

# Install Docker
print_status "Installing Docker..."

# this script will install docker and docker-compose and k3s 