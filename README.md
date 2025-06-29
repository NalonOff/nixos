# 🏠 NixOS Dotfiles
> *Personal configuration for a modern NixOS environment with Hyprland*

![NixOS](https://img.shields.io/badge/NixOS-5277C3?style=for-the-badge&logo=nixos&logoColor=white)
![Hyprland](https://img.shields.io/badge/Hyprland-00D9FF?style=for-the-badge&logo=wayland&logoColor=black)
![Home Manager](https://img.shields.io/badge/Home_Manager-FD6C6C?style=for-the-badge)

## ✨ Overview
This configuration provides a modern and minimalist desktop environment based on:
- **NixOS** for declarative system management
- **Hyprland** as Wayland compositor
- **Home Manager** for user configuration management
- A modular and reproducible approach

### 🖥️ Environment
- **WM**: Hyprland (Wayland compositor)
- **Terminal**: Kitty
- **Shell**: Zsh
- **Editor**: Neovim / VSCode
- **Launcher**: Rofi
- **Bar**: Waybar
- **Notifications**: Dunst

## 🚀 Installation

### Prerequisites
- NixOS installed
- Flakes enabled in Nix configuration

### Quick installation
```bash
# Clone the repository
git clone https://github.com/NalonOff/nixos ~/.config/dotfiles

# Navigate to the folder
cd ~/.config/nixos

# Apply system configuration
sudo nixos-rebuild switch --flake .#[hostname]

# Apply Home Manager configuration
home-manager switch --flake .#[username]
```

### Custom installation
1. **Adapt the configuration**:
   ```bash
   # Modify settings in flake.nix
   vim flake.nix
   ```

2. **Configure hostname**:
   ```bash
   # Check your hostname
   hostname
   
   # Adapt in configuration if necessary
   ```

3. **First application**:
   ```bash
   sudo nixos-rebuild switch --flake .
   ```

### Adding programs
Create a new file in `home/programs/`:
```nix
{ config, pkgs, ... }: {
  programs.myProgram = {
    enable = true;
    # configuration...
  };
}
```

## 🔧 Useful commands
```bash
# Rebuild the system
sudo nixos-rebuild switch --flake .

# Rebuild Home Manager
home-manager switch --flake .

# Update inputs
nix flake update

# Clean old generations
sudo nix-collect-garbage -d

# Optimize Nix store
sudo nix-store --optimise
```

## 📝 Notes

### Backup
Before applying this configuration:
```bash
# Backup current configuration
sudo cp -r /etc/nixos /etc/nixos.backup
```

### Troubleshooting
- Check logs: `journalctl -xeu nixos-rebuild`
- Rollback to previous generation: `sudo nixos-rebuild switch --rollback`
- Home Manager issues: `home-manager generations`

<div align="center">
*Made with ❤️ and a lot of patience...*
</div>
