#!/bin/sh

echo "[1] UPDATING"

sudo dnf update -y
sudo dnf upgrade --refresh

echo "[2] ADDING/ENABLING ADDITIONAL REPOS"

sudo dnf config-manager --set-enabled crb
sudo dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo

sudo dnf install epel-release

# https://computingforgeeks.com/install-use-ffmpeg-on-rocky-alma-9/

sudo dnf install --nogpgcheck https://mirrors.rpmfusion.org/free/el/rpmfusion-free-release-$(rpm -E %rhel).noarch.rpm -y
sudo dnf install --nogpgcheck https://mirrors.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-$(rpm -E %rhel).noarch.rpm -y

echo "[3] REPO LIST"

sudo dnf repolist

echo "[4] FFMPEG PREREQUISITES"

# https://linuxhint.com/error-command-gcc-failed-exit-status-1/

sudo dnf group install "Development Tools"

sudo dnf install gcc clang cmake procps nano python3-pip git git-lfs ffmpeg ffmpeg-devel python-devel

echo "[5] REMOVING PODMAN"

sudo dnf remove podman buildah podman-compose

echo "[6] INSTALLING DOCKER"

# https://docs.rockylinux.org/gemstones/docker/
sudo dnf install docker-ce docker-ce-cli containerd.io docker-compose-plugin

echo "[7] DEV PREREQUISITES"

pip3 install pip -U
git lfs install

echo "[8] CLEANUP & RESTART"

sudo dnf clean all

sudo reboot
