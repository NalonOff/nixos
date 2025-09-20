{ config, lib, pkgs, ... }:

{
  # Configuration OpenGL
  hardware.graphics = {
    enable = true;

    extraPackages = with pkgs; [
      mesa                    # Mesa drivers for 64-bit applications
      libva                   # Video Acceleration API
      libva-utils            # VAAPI utilities
      libva-vdpau-driver     # VAAPI to VDPAU driver
      vaapiVdpau             # VDPAU backend for VAAPI
      libvdpau-va-gl         # VDPAU to OpenGL bridge
      amdvlk                 # AMD Vulkan driver (64-bit)
    ];

    extraPackages32 = with pkgs.pkgsi686Linux; [
      mesa                    # Mesa drivers for 32-bit applications
      libva                   # Video Acceleration API (32-bit)
      libva-vdpau-driver     # VAAPI to VDPAU driver (32-bit)
      vaapiVdpau             # VDPAU backend for VAAPI (32-bit)
      libvdpau-va-gl         # VDPAU to OpenGL bridge (32-bit)
      amdvlk                 # AMD Vulkan driver (32-bit)
    ];
  };

  # Pilotes vidéo
  services.xserver.videoDrivers = [ "amdgpu" ];

  # Configuration AMD
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  hardware.enableRedistributableFirmware = true;

  # Variables d'environnement
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "radeonsi";
    VDPAU_DRIVER = "radeonsi";
    MESA_LOADER_DRIVER_OVERRIDE = "radeonsi";
    WLR_RENDERER = "vulkan";
    WLR_DRM_DEVICES = "/dev/dri/card0";
    NIXOS_OZONE_WL = "1";
    QT_QPA_PLATFORM = "wayland";
    MOZ_ENABLE_WAYLAND = "1";
    MOZ_WEBRENDER = "1";
    MOZ_USE_XINPUT2 = "1";
  };

  # Packages système
  environment.systemPackages = with pkgs; [
    radeontop
    #nvtopPackages.amd
    gpu-viewer
    libva-utils
    vdpauinfo
    vulkan-loader
    vulkan-validation-layers
    vulkan-tools
    opencl-headers
    ocl-icd
    clinfo
  ];

  # Configuration kernel
  boot.kernelModules = [ "amdgpu" ];
  boot.kernelParams = [
    "amdgpu.modeset=1"
    "amdgpu.gpu_recovery=1"
    "amdgpu.dc=1"
    "amdgpu.dpm=1"
    "amdgpu.si_support=1"
    "amdgpu.cik_support=1"
    "amdgpu.runpm=0"
  ];
  boot.blacklistedKernelModules = [ ];

  # Services système
  powerManagement.cpuFreqGovernor = lib.mkDefault "performance";

  systemd.services.amd-gpu-setup = {
    description = "AMD GPU optimization setup";
    after = [ "graphical.target" ];
    wantedBy = [ "graphical.target" ];
    script = ''
      if [ -f /sys/class/drm/card0/device/power_dpm_force_performance_level ]; then
        echo "auto" > /sys/class/drm/card0/device/power_dpm_force_performance_level || true
      fi
    '';
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
  };

  # Règles udev
  services.udev.extraRules = ''
    KERNEL=="card*", MODE="0666"
    KERNEL=="renderD*", MODE="0666"
    SUBSYSTEM=="drm", KERNEL=="card*", ATTRS{vendor}=="0x1002", TAG+="seat", TAG+="master-of-seat"
    SUBSYSTEM=="drm", KERNEL=="card*", ATTR{device/power_dpm_force_performance_level}="auto"
  '';
}
