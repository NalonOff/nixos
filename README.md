# 🏠 Dotfiles NixOS

> *Configuration personnelle pour un environnement NixOS moderne avec Hyprland*

![NixOS](https://img.shields.io/badge/NixOS-5277C3?style=for-the-badge&logo=nixos&logoColor=white)
![Hyprland](https://img.shields.io/badge/Hyprland-00D9FF?style=for-the-badge&logo=wayland&logoColor=black)
![Home Manager](https://img.shields.io/badge/Home_Manager-FD6C6C?style=for-the-badge)

## ✨ Aperçu

Cette configuration offre un environnement de bureau moderne et minimaliste basé sur :
- **NixOS** pour la gestion système déclarative
- **Hyprland** comme compositeur Wayland
- **Home Manager** pour la gestion des configurations utilisateur
- Une approche modulaire et reproductible

### 🖥️ Environnement
- **WM** : Hyprland (Wayland compositor)
- **Terminal** : Kitty
- **Shell** : Zsh
- **Éditeur** : Neovim / VSCode
- **Launcher** : Rofi
- **Bar** : Waybar
- **Notifications** : Dunst

## 🚀 Installation

### Prérequis
- NixOS installé
- Flakes activés dans la configuration Nix

### Installation rapide

```bash
# Cloner le repository
git clone https://github.com/NalonOff/nixos ~/.config/dotfiles

# Naviguer dans le dossier
cd ~/.config/nixos

# Appliquer la configuration système
sudo nixos-rebuild switch --flake .#[hostname]

# Appliquer la configuration Home Manager
home-manager switch --flake .#[username]
```

### Installation personnalisée

1. **Adapter la configuration** :
   ```bash
   # Modifier les paramètres dans flake.nix
   vim flake.nix
   ```

2. **Configurer l'hostname** :
   ```bash
   # Vérifier votre hostname
   hostname
   
   # Adapter dans la configuration si nécessaire
   ```

3. **Première application** :
   ```bash
   sudo nixos-rebuild switch --flake .
   ```

### Ajouter des programmes
Créez un nouveau fichier dans `home/programs/` :
```nix
{ config, pkgs, ... }: {
  programs.monProgramme = {
    enable = true;
    # configuration...
  };
}
```

## 🔧 Commandes utiles

```bash
# Rebuilder le système
sudo nixos-rebuild switch --flake .

# Rebuilder Home Manager
home-manager switch --flake .

# Mettre à jour les inputs
nix flake update

# Nettoyer les générations anciennes
sudo nix-collect-garbage -d

# Optimiser le store Nix
sudo nix-store --optimise
```

## 📝 Notes

### Sauvegarde
Avant d'appliquer cette configuration :
```bash
# Sauvegarder la configuration actuelle
sudo cp -r /etc/nixos /etc/nixos.backup
```

### Résolution de problèmes
- Vérifiez les logs : `journalctl -xeu nixos-rebuild`
- Retour à la génération précédente : `sudo nixos-rebuild switch --rollback`
- Problèmes Home Manager : `home-manager generations`


<div align="center">

*Fait avec ❤️ et beaucoup de patience...*

</div>
