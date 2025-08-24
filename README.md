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
- **Editor**: Neovim (via Nixvim)
- **Launcher**: Rofi
- **Bar**: Waybar
- **Music**: Spotify (via Spicetify)
- **Discord**: Nixcord
- **Theming**: Stylix

## 📁 Structure

```
.
├── flake.nix                    # Main flake configuration
├── hosts/
│   └── nixos/
│       ├── default.nix          # System configuration
│       └── hardware-configuration.nix
├── modules/                     # System modules
│   ├── boot/
│   ├── networking/
│   ├── users/
│   ├── system/
│   ├── fonts/
│   ├── ssh/
│   └── audio/
└── home/
    ├── default.nix              # nalon user configuration
    ├── programs/                # Program configurations
    │   ├── git.nix
    │   ├── zsh.nix
    │   ├── hyprland.nix
    │   ├── kitty.nix
    │   ├── firefox.nix
    │   ├── nixcord.nix
    │   ├── waybar.nix
    │   ├── spicetify.nix
    │   ├── steam.nix
    │   ├── nixvim.nix
    │   └── stylix.nix
    └── [other-users].nix        # Additional user configurations
```

## 🚀 Installation

### Prerequisites
- NixOS installed
- Flakes enabled in Nix configuration

### Quick installation
```bash
# Clone the repository
git clone https://github.com/NalonOff/nixos ~/.config/dotfiles
cd ~/.config/dotfiles

# Apply system configuration
sudo nixos-rebuild switch --flake .#nixos

# Apply Home Manager configuration
home-manager switch --flake .#nalon
```

## 🔧 Configuration Management

### Adding a New System

1. **Create system configuration**:
   ```bash
   mkdir hosts/new-system
   ```

2. **Generate hardware configuration**:
   ```bash
   sudo nixos-generate-config --dir hosts/new-system
   ```

3. **Create system config** in `hosts/new-system/default.nix`:
   ```nix
   { config, pkgs, inputs, ... }: {
     imports = [
       ./hardware-configuration.nix
       ../../modules/boot
       ../../modules/networking
       ../../modules/users
       ../../modules/system
       ../../modules/fonts
       ../../modules/ssh
       ../../modules/audio
     ];

     system.stateVersion = "25.05";
     networking.hostName = "new-system";
     # System-specific configuration...
   }
   ```

4. **Add to flake.nix**:
   ```nix
   nixosConfigurations = {
     nixos = nixpkgs.lib.nixosSystem { /* existing config */ };
     
     new-system = nixpkgs.lib.nixosSystem {
       inherit system;
       modules = [
         ./hosts/new-system
         # ... other modules
       ];
     };
   };
   ```

5. **Deploy**:
   ```bash
   sudo nixos-rebuild switch --flake .#new-system
   ```

### Adding a New User

1. **Create user Home Manager config** in `home/new-user.nix`:
   ```nix
   { config, pkgs, ... }: {
     imports = [
       ./programs/git.nix
       ./programs/zsh.nix
       # Add programs as needed
     ];

     home = {
       username = "new-user";
       homeDirectory = "/home/new-user";
       stateVersion = "25.05";
     };

     home.packages = with pkgs; [
       # User-specific packages
     ];

     programs.home-manager.enable = true;
   }
   ```

2. **Add system user** in `modules/users/default.nix`:
   ```nix
   users.users = {
     nalon = { /* existing config */ };
     
     new-user = {
       isNormalUser = true;
       description = "New User";
       extraGroups = [ "networkmanager" "wheel" ];
       shell = pkgs.zsh;
     };
   };
   ```

3. **Update flake.nix**:
   ```nix
   # In nixosConfigurations
   home-manager.users = {
     nalon = import ./home;
     new-user = import ./home/new-user.nix;
   };

   # Add standalone configuration
   homeConfigurations = {
     nalon = home-manager.lib.homeManagerConfiguration { /* existing */ };
     
     new-user = home-manager.lib.homeManagerConfiguration {
       inherit pkgs;
       modules = [ ./home/new-user.nix ] ++ commonHomeModules;
       extraSpecialArgs = commonExtraArgs;
     };
   };
   ```

4. **Deploy**:
   ```bash
   # System-wide
   sudo nixos-rebuild switch --flake .

   # User-specific
   home-manager switch --flake .#new-user
   ```

### Adding Programs

Create a new file in `home/programs/`:
```nix
{ config, pkgs, ... }: {
  programs.myProgram = {
    enable = true;
    # configuration...
  };
}
```

Then import it in the relevant user configuration.

## 🛠️ Useful Commands

```bash
# System management
sudo nixos-rebuild switch --flake .#[hostname]  # Apply system config
sudo nixos-rebuild switch --flake .             # Use default hostname

# Home Manager
home-manager switch --flake .#[username]        # Apply user config
home-manager generations                        # List generations

# Maintenance
nix flake update                                # Update inputs
sudo nix-collect-garbage -d                     # Clean old generations
sudo nix-store --optimise                       # Optimize store
nix-store --gc                                  # Garbage collect

# Debugging
journalctl -xeu nixos-rebuild                   # System rebuild logs
sudo nixos-rebuild switch --rollback            # Rollback system
home-manager switch --rollback                  # Rollback user config
```

## 📝 Notes

### Available Configurations

**Systems:**
- `nixos` - Main desktop system

**Users:**
- `nalon` - Primary user with full desktop environment

### Backup
Before applying this configuration:
```bash
# Backup current configuration
sudo cp -r /etc/nixos /etc/nixos.backup
cp -r ~/.config/home-manager ~/.config/home-manager.backup
```

### Troubleshooting
- Check logs: `journalctl -xeu nixos-rebuild`
- Rollback to previous generation: `sudo nixos-rebuild switch --rollback`
- Home Manager issues: `home-manager generations`
- Flake issues: `nix flake check`

### Key Features
- **Reproducible**: Entire system defined in code
- **Modular**: Easy to add/remove components
- **Multi-user**: Support for multiple user configurations
- **Multi-system**: Support for multiple machine configurations
- **Modern**: Wayland-native with contemporary tools

---

<div align="center">

*Made with ❤️ and a lot of patience...*

</div>
