{
  pkgs,
  config,
  ...
}:
{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;

    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
      intel-compute-runtime
    ];
  };

  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  programs.gamemode.enable = true;

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    open = true;
    modesetting.enable = true;
    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
    powerManagement = {
      enable = true;
      finegrained = true;
    };
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };
  services.thermald.enable = true;
  services.auto-cpufreq.enable = true;
  services.auto-cpufreq.settings = {
    battery = {
       governor = "balanced";
       turbo = "never";
    };
    charger = {
       governor = "performance";
       turbo = "auto";
    };
  };
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
    extraConfig.pipewire."10-gaming".context.properties = {
      default.clock.rate = 48000;
      default.clock.quantum = 256;
      default.clock.min-quantum = 256;
    };
  };

  services.power-profiles-daemon.enable = false;
  environment.systemPackages = [
    pkgs.brightnessctl
    pkgs.gpu-screen-recorder
    pkgs.cliphist
    pkgs.cava
    pkgs.sysstat
    pkgs.wlsunset
    pkgs.playerctl
    pkgs.mangohud
    pkgs.goverlay
    pkgs.gamemode
    pkgs.gamescope
    pkgs.protonup-qt
    pkgs.wine
    pkgs.winetricks
    pkgs.lutris
    pkgs.heroic
    pkgs.btop
    pkgs.ryubing
    pkgs.gearlever
    pkgs.zenith
  ];

  imports = [
  ];
  fonts.packages = with pkgs; [
    roboto
    inter
    noto-fonts
    noto-fonts-color-emoji
  ];
}
