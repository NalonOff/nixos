{ config, lib, pkgs, ... }:

{
  # OpenGL configuration
  hardware.graphics = {
    enable = true;

    extraPackages = with pkgs; [
      intel-media-driver
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
      nvidia-vaapi-driver
    ];

    extraPackages32 = with pkgs.pkgsi686Linux; [
      vaapiIntel
      nvidia-vaapi-driver
    ];
  };

  # Video drivers
  services.xserver.videoDrivers = [ "nvidia" ];

  # NVIDIA configuration
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    nvidiaSettings = true;

    # Use open-source kernel modules for RTX/GTX 16xx series, closed for older
    open = true;  # Set to false for older GPUs (GTX 10xx and older)

    # Hybrid GPU setup - MUST configure bus IDs when using PRIME
    prime = {
      # Disable PRIME by default to avoid configuration errors
      # Enable one of the modes below and configure bus IDs if you have hybrid GPU

      # Option 1: Offload mode (recommended for laptops)
      # offload = {
      #   enable = true;
      #   enableOffloadCmd = true;  # Adds nvidia-offload command
      # };

      # Option 2: Sync mode (all displays through NVIDIA)
      # sync.enable = true;

      # Option 3: Reverse sync mode (NVIDIA as primary)
      # reverseSync.enable = true;

      # REQUIRED when any PRIME mode is enabled:
      # Find your bus IDs with: lspci | grep -E "(VGA|3D)"
      # intelBusId = "PCI:0:2:0";    # Intel GPU bus ID
      # nvidiaBusId = "PCI:1:0:0";   # NVIDIA GPU bus ID
    };
  };

  # Environment variables
  environment.sessionVariables = {
    GBM_BACKEND = "nvidia-drm";
    LIBVA_DRIVER_NAME = "nvidia";
    WLR_NO_HARDWARE_CURSORS = "1";
    WLR_BACKEND = "vulkan";
    NIXOS_OZONE_WL = "1";
  };

  # System packages
  environment.systemPackages = with pkgs; [
    #nvtopPackages.nvidia
    gpu-viewer
    vulkan-loader
    vulkan-validation-layers
    vulkan-tools
    opencl-headers
    ocl-icd
  ];

  # Kernel configuration
  boot.kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];
  boot.kernelParams = [
    "nvidia-drm.modeset=1"
    "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
  ];
  boot.blacklistedKernelModules = [ "nouveau" ];

  # System services
  systemd.services.nvidia-suspend = {
    description = "NVIDIA suspend actions";
    after = [ "suspend.target" ];
    script = "${pkgs.kmod}/bin/modprobe -r nvidia_uvm nvidia_drm nvidia_modeset nvidia";
    wantedBy = [ "suspend.target" ];
    serviceConfig.Type = "oneshot";
  };

  systemd.services.nvidia-resume = {
    description = "NVIDIA resume actions";
    after = [ "suspend.target" ];
    script = "${pkgs.kmod}/bin/modprobe nvidia nvidia_modeset nvidia_drm nvidia_uvm";
    wantedBy = [ "suspend.target" ];
    serviceConfig.Type = "oneshot";
  };

  # Udev rules
  services.udev.extraRules = ''
    KERNEL=="nvidia*", MODE="0666"
    KERNEL=="nvidiactl", MODE="0666"
  '';
}
