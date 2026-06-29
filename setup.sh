#!/usr/bin/env bash
#bash -n setup.sh && chmod +x setup.sh && ls -l setup.sh

set -euo pipefail

echo "Updating package lists..."
sudo apt-get update

echo "Installing Python, pip, and build tools..."
sudo apt-get install -y \
  python3 \
  python3-pip \
  python3-venv \
  build-essential \
  libssl-dev \
  libffi-dev \
  python3-dev

echo "Upgrading pip..."
python3 -m pip install --upgrade pip setuptools wheel

echo "Installing Scrapy and Playwright support..."
python3 -m pip install --upgrade scrapy scrapy-playwright playwright

echo "Installing Playwright browser runtime and OS dependencies..."
python3 -m playwright install chromium
sudo python3 -m playwright install-deps chromium

echo "Verification..."
python3 --version
python3 -m pip --version
python3 -m pip show scrapy | sed -n '1,5p'
python3 -m pip show scrapy-playwright | sed -n '1,5p'
