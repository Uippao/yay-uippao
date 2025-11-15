#!/usr/bin/env bash
set -euo pipefail

AUR_REPO="https://aur.archlinux.org/yay.git"
TMP_DIR="$(mktemp -d)"
PATCH_URL="https://github.com/Uippao/yay-uippao/raw/main/PKGBUILD.patch"

echo "Temporary build directory: $TMP_DIR"

cleanup() {
    rm -rf "$TMP_DIR"
}
trap cleanup EXIT

echo "Cloning yay AUR repo..."
git clone "$AUR_REPO" "$TMP_DIR/yay"

cd "$TMP_DIR/yay"
echo "Downloading PKGBUILD patch..."
curl -L -o PKGBUILD.patch "$PATCH_URL"

echo "Applying PKGBUILD patch..."
patch -Np1 -i PKGBUILD.patch

echo "Building and installing yay-uippao..."
makepkg -si

echo "yay-uippao has been installed successfully!"
