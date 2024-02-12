#!/bin/sh

echo "[1] Verify You Have a CUDA-Capable GPU"

lspci | grep -i nvidia

echo "[2] Verify You Have a Supported Version of Linux"

uname -m && cat /etc/*release

echo "[3] Verify the System Has gcc Installed"

gcc --version

echo "[4] Verify the System has the Correct Kernel Headers and Development Packages Installed"

uname -r

echo "[5] Install NVIDIA GPU drivers"

sudo dnf config-manager --add-repo https://developer.download.nvidia.com/compute/cuda/repos/rhel9/x86_64/cuda-rhel9.repo

sudo dnf install kernel-devel-$(uname -r) kernel-headers-$(uname -r)

sudo dnf install nvidia-driver nvidia-settings

sudo dnf install cuda-driver cuda-toolkit

sudo dnf install libcudnn8

echo "[6] CLEANUP & RESTART"

sudo dnf clean all

sudo reboot
