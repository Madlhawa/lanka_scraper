#!/usr/bin/env bash

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

echo "Creating and activating virtual environment..."
# This creates a folder called 'venv' in your current directory
python3 -m venv venv
# This activates the virtual environment
source venv/bin/activate

echo "Upgrading pip..."
python3 -m pip install --upgrade pip setuptools wheel

echo "Installing Scrapy and Playwright support..."
python3 -m pip install --upgrade scrapy scrapy-playwright playwright

echo "Installing Playwright browser runtime and OS dependencies..."
playwright install chromium
sudo playwright install-deps chromium

echo "Verification..."
python3 --version
python3 -m pip --version
python3 -m pip show scrapy | sed -n '1,5p'
python3 -m pip show scrapy-playwright | sed -n '1,5p'

# This installs the required system libraries for Chromium
sudo apt-get install -y libnss3 libatk-bridge2.0-0 libatk1.0-0 libcups2 libdrm2 libxkbcommon0 libxcomposite1 libxdamage1 libxrandr2 libgbm1 libasound2t64 libpangocairo-1.0-0 libx11-xcb1

echo "============================================================"
echo "SETUP COMPLETE!"
echo "IMPORTANT: Before running your scraper, you must activate the environment by typing:"
echo "source venv/bin/activate"
echo "============================================================"