#!/bin/sh
# Github:ashupal86
set -e

cd ~/Desktop

sudo apt update && sudo apt-get  install -y -qq git curl dpkg-dev debian-archive-keyring debhelper po4a devscripts make

clear
echo "cloning live build from https://salsa.debian.org/live-team/live-build"
git clone --depth 1 -q https://salsa.debian.org/live-team/live-build

clear

cd live-build

clear
dpkg-buildpackage -b -uc -us

clear
sudo apt install -y -q ../live-build_*_all.deb

clear
echo "Installed Live Build version: "
lb --version

echo "visit https://github.com/ashupal86/debian-live-os"


