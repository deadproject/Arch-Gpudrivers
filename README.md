# Arch GPU Drivers

This project provides a simple script to automatically install the appropriate GPU drivers for your system, whether you have an NVIDIA, Intel, or AMD graphics card.

## Features

- Automatic detection of GPU hardware
- Installation of the latest drivers for NVIDIA, Intel, and AMD GPUs
- Easy to use

## Requirements

- Arch Linux or an Arch-based distribution
- `git` installed on your system
If you haven't got `git` installed, use the following command:
```bash
sudo pacman -S git
```

## Installation

```bash
git clone --depth=1 https://github.com/deadproject/Arch-Gpudrivers.git
cd Arch-Gpudrivers
chmod +x setup.sh
./setup.sh
```