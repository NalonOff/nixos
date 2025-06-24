#!/bin/bash

# Configuration
SOURCE_DIR="$HOME/hypr/wallpapers"    # Dossier source des images
CACHE_DIR="$HOME/.cache"              # Dossier cache pour l'image et le colorscheme
COLORSCHEME_NAME="colors.json"        # Nom du fichier colorscheme

# Créer les dossiers s'ils n'existent pas
mkdir -p "$CACHE_DIR"

# Vérifier si le dossier source existe
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Erreur: Le dossier source '$SOURCE_DIR' n'existe pas"
    echo "Modifiez la variable SOURCE_DIR dans le script"
    exit 1
fi

# Extensions d'images supportées
EXTENSIONS="jpg jpeg png bmp gif tiff webp"

# Trouver toutes les images dans le dossier source
IMAGES=()
for ext in $EXTENSIONS; do
    while IFS= read -r -d '' file; do
        IMAGES+=("$file")
    done < <(find "$SOURCE_DIR" -type f -iname "*.$ext" -print0 2>/dev/null)
done

# Vérifier s'il y a des images
if [ ${#IMAGES[@]} -eq 0 ]; then
    echo "Erreur: Aucune image trouvée dans '$SOURCE_DIR'"
    echo "Extensions supportées: $EXTENSIONS"
    exit 1
fi

# Sélectionner une image au hasard
RANDOM_IMAGE="${IMAGES[$RANDOM % ${#IMAGES[@]}]}"
IMAGE_NAME=$(basename "$RANDOM_IMAGE")

echo "Image sélectionnée: $IMAGE_NAME"

# Copier l'image vers le dossier cache avec un nom standardisé
cp "$RANDOM_IMAGE" "$CACHE_DIR/current-wallpaper"
if [ $? -eq 0 ]; then
    echo "Image copiée vers: $CACHE_DIR/current-wallpaper"
else
    echo "Erreur: Impossible de copier l'image"
    exit 1
fi

# Générer le colorscheme avec hellwal
echo "Génération du colorscheme..."
hellwal -i "$RANDOM_IMAGE" --json > "$HOME/$COLORSCHEME_NAME"

if [ $? -eq 0 ]; then
    echo "Colorscheme généré: $CACHE_DIR/$COLORSCHEME_NAME"
    echo "Couleurs extraites avec succès!"
    
    # Optionnel: afficher un aperçu des couleurs principales
    if command -v jq &> /dev/null; then
        echo -e "\nCouleurs principales:"
        jq -r '.colors | to_entries | .[] | "\(.key): \(.value)"' "$CACHE_DIR/$COLORSCHEME_NAME" | head -8
    fi
else
    echo "Erreur: Impossible de générer le colorscheme"
    exit 1
fi

echo -e "\n✓ Terminé!"
echo "Image active: $CACHE_DIR/current-wallpaper"
echo "Colorscheme: $CACHE_DIR/$COLORSCHEME_NAME"

swww img "$CACHE_DIR/current-wallpaper"
home-manager switch --flake .#nalon --impure
