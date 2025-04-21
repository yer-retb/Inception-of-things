#!/bin/bash


GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

print_status() {
    echo -e "${GREEN}[+] $1${NC}"
}

print_error() {
    echo -e "${RED}[-] Error: $1${NC}"
    exit 1
}

check_status() {
    if [ $? -ne 0 ]; then
        print_error "$1 failed"
    fi
}

if [ "$EUID" -ne 0 ]; then 
    print_error "Please run as root (use sudo)"
fi

print_status "Updating system packages..."
apt-get update && apt-get upgrade -y || print_error "Failed to update system packages"

print_status "Installing prerequisites..."
apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release || print_error "Failed to install prerequisites"

print_status "Installing Docker..."


# at this point, you can install anything you need