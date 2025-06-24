#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/hypr/wallpapers"
TARGET_FILE="$HOME/.cache/current-wallpaper.jpg"

mkdir -p "$(dirname "$TARGET_FILE")"

wallpapers=($(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" -o -name "*.webp" \)))

if [ ${#wallpapers[@]} -eq 0 ]; then
    echo "Aucun wallpaper trouvé dans $WALLPAPER_DIR"
    exit 1
fi

# Sélection aléatoire
selected=${wallpapers[$RANDOM % ${#wallpapers[@]}]}

# Copie du fichier
cp "$selected" "$TARGET_FILE"

echo "Wallpaper: $(basename "$selected")"

swww img "$HOME/.cache/current-wallpaper.jpg"
home-manager switch --flake .#nalon --impure
