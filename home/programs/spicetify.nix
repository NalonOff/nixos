{ config, pkgs, inputs, ... }:

let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in
{
  # Full configuration of Spicetify
  programs.spicetify = {
    enable = true;

    # Famous extensions
    enabledExtensions = with spicePkgs.extensions; [
      adblock           # Block ads
      hidePodcasts      # Hide podcast sectio
      shuffle           # Better shuffle
      keyboardShortcut  # Custom hotkeys
      fullAppDisplay    # Better fullscreen
      history           # Listing history
      powerBar          # Advanced control bar
      volumePercentage  # Show the volume percentage
    ];

    # Custom applications
    enabledCustomApps = with spicePkgs.apps; [
      lyricsPlus        # Advanced lyrics
      newReleases       # New albums and others
    ];
  };
}
