#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Function to print error messages
function error() {
    echo "Error: $1"
    exit 1
}

# Create a directory named Theme in the home directory and navigate into it
THEME_DIR="$HOME/Theme"
mkdir -p "$THEME_DIR" || error "Failed to create directory $THEME_DIR"
cd "$THEME_DIR" || error "Failed to navigate to directory $THEME_DIR"

# Clone the WhiteSur repositories
REPOS=(
    "https://github.com/vinceliuice/WhiteSur-gtk-theme.git"
    "https://github.com/vinceliuice/WhiteSur-icon-theme.git"
    "https://github.com/vinceliuice/WhiteSur-cursors.git"
)

for REPO in "${REPOS[@]}"; do
    git clone "$REPO" || error "Failed to clone repository $REPO"
done

# Install WhiteSur GTK theme
cd "WhiteSur-gtk-theme" || error "Failed to navigate to WhiteSur-gtk-theme directory"
./install.sh -a normal -m -N stable -l --round -t all || error "Failed to install WhiteSur GTK theme"

# Apply tweaks for GDM and Flatpak
sudo ./tweaks.sh -g || error "Failed to apply GDM tweaks"
./tweaks.sh -F || error "Failed to apply Flatpak tweaks"
./tweaks.sh -f default || error "Failed to apply Firefox theme tweaks"
sudo flatpak override --filesystem=xdg-config/gtk-4.0 || error "Failed to override Flatpak filesystem"

# Navigate back to Theme directory
cd "$THEME_DIR" || error "Failed to navigate back to $THEME_DIR"

# Install WhiteSur icon theme
cd "WhiteSur-icon-theme" || error "Failed to navigate to WhiteSur-icon-theme directory"
./install.sh -a -b || error "Failed to install WhiteSur icon theme"

# Navigate back to Theme directory
cd "$THEME_DIR" || error "Failed to navigate back to $THEME_DIR"

# Install WhiteSur cursors theme
cd "WhiteSur-cursors" || error "Failed to navigate to WhiteSur-cursors directory"
./install.sh || error "Failed to install WhiteSur cursors theme"

# Navigate back to the original directory
cd "$THEME_DIR" || error "Failed to navigate back to $THEME_DIR"

echo "WhiteSur themes installation is complete."
