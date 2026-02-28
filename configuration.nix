{
  pkgs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ./Modules/garbage.nix
    ./Modules/gaming.nix
    ./Modules/mango.nix
    ./Modules/waydroid.nix
    ./Modules/qtile/qtile.nix
    ./Modules/awesome/awesomewm.nix
  ];
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    kernelPackages = pkgs.linuxPackages_xanmod_latest;

    kernelParams = [
      "mitigations=off"
      "nowatchdog"
      "split_lock_detect=off"
      "nvidia-drm.modeset=1"
      "acpi_rev_override=1"
    ];

    initrd.kernelModules = [
      "nvidia"
      "nvidia_modeset"
      "nvidia_uvm"
      "nvidia_drm"
    ];

    kernel.sysctl = {
      "net.core.netdev_max_backlog" = 16384;
      "net.core.somaxconn" = 8192;
      "net.core.rmem_default" = 1048576;
      "net.core.rmem_max" = 16777216;
      "net.core.wmem_default" = 1048576;
      "net.core.wmem_max" = 16777216;

      "net.ipv4.tcp_fastopen" = 3;
      "net.ipv4.tcp_congestion_control" = "bbr";
      "net.ipv4.tcp_mtu_probing" = 1;

      "vm.max_map_count" = 2147483642;
      "vm.swappiness" = 10;
    };
  };
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    firewall.enable = true;
  };
  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";
  services.xserver.xkb.layout = "gb";
  console.keyMap = "uk";
  services.xserver.enable = true;
  services.displayManager.gdm = {
    enable = true;
    wayland = true;
  };
  services.desktopManager.gnome.enable = true;
  services.flatpak.enable = true;
  services.printing.enable = true;
  services.thermald.enable = true;
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    __GL_THREADED_OPTIMIZATION = "1";
    __GL_SHADER_DISK_CACHE = "1";
    __GL_SHADER_DISK_CACHE_SKIP_CLEANUP = "1";
  };
  users.users.exvexityl = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
      "audio"
      "input"
      "gamemode"
      "libvirtd"
    ];
  };
virtualisation.libvirtd.enable = true;
virtualisation.libvirtd.qemu = {
  swtpm.enable = true;
};

# Enable USB redirection (optional)
virtualisation.spiceUSBRedirection.enable = true;
  services.fprintd.enable = true;
  environment.systemPackages = with pkgs; [
    wget
    curl
    git
    micro
    libvirt
    triton-llvm
    pipx
    vim
    exfat
    exfatprogs
    neovim
    gparted
    helix
    yazi
    lazygit
    scrot
    xclip
    nitrogen
    glfw
    virt-manager
    playerctl
    prettier
    temurin-jre-bin
    vllm
    neofetch
    rofi
    dunst
    alsa-utils
    kitty
    stow
    picom
    fastfetch
    qbittorrent
    zed-editor
    alacritty
    better-control
    ulauncher
    unzip
    gcc
    nautilus
    gnome-tweaks
    gnome-extension-manager
    fish
    waybar
    eza
    bat
    starship
    typr
    fprintd
    hydralauncher
    nixd
    nil
    alejandra
    vicinae
    ugrep
    kdePackages.dolphin
    gnome-keyring
    seahorse
    brightnessctl
    thunar
    pavucontrol
    playerctl
    networkmanagerapplet
    powertop
    fwupd
  ];
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    auto-optimise-store = true;
  };

  nixpkgs.config.allowUnfree = true;
  programs.kdeconnect.enable = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
  security.polkit.enable = true;
  system.stateVersion = "25.05";
}
