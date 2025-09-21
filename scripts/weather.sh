#!/bin/bash

# Configuration
CITY="Tarbes"
COUNTRY="FRANCE"

# Vérifier si les variables sont définies
if [[ -z "$CITY" || -z "$COUNTRY" ]]; then
    echo "Erreur: Ville ou pays non défini"
    exit 1
fi

# Récupérer les données météo
weather_info=$(curl -s --fail "https://wttr.in/$CITY?format=%c+%t" 2>/dev/null)

# Vérifier si la requête a réussi
if [[ $? -ne 0 || -z "$weather_info" ]]; then
    echo "Erreur: Impossible de récupérer la météo pour $CITY"
    exit 1
fi

# Afficher le résultat
echo "$weather_info"
