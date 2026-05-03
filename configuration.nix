{
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ./Modules/garbage.nix
    ./Modules/gaming.nix
    ./Modules/waydroid.nix
    ./Modules/kde.nix
    ./Modules/niri.nix
  ];

  # ── Boot ────────────────────────────────────────────────────────────────────
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    # CachyOS kernel via chaotic-nyx
    kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest;

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

  # ── Networking ──────────────────────────────────────────────────────────────
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    firewall.enable = true;
  };

  # ── Locale / Time ───────────────────────────────────────────────────────────
  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";
  services.xserver.xkb.layout = "gb";
  console.keyMap = "uk";

  # ── Display server (X needed by KDE Xwayland apps) ──────────────────────────
  services.xserver.enable = true;

  # ── Session variables (system-wide, Wayland / NVIDIA) ───────────────────────
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    __GL_THREADED_OPTIMIZATION = "1";
    __GL_SHADER_DISK_CACHE = "1";
    __GL_SHADER_DISK_CACHE_SKIP_CLEANUP = "1";
    # Niri prefers this for Wayland-native apps
    NIXOS_WL_DISPLAY = "wayland-1";
  };

  # ── System services ─────────────────────────────────────────────────────────
  services.flatpak.enable = true;
  services.printing.enable = true;
  services.thermald.enable = true;
  services.fprintd.enable = true;
  services.blueman.enable = true;

  hardware.bluetooth.enable = true;

  # Polkit — required by KDE, niri, and virt-manager
  security.polkit.enable = true;

  # Keyring — KDE Wallet replaces gnome-keyring; keep the PAM integration
  security.pam.services.login.enableGnomeKeyring = false;
  services.gnome.gnome-keyring.enable = true; # still used by some apps, optional

  # ── Virtualisation ──────────────────────────────────────────────────────────
  virtualisation.libvirtd = {
    enable = true;
    qemu.swtpm.enable = true;
  };
  virtualisation.spiceUSBRedirection.enable = true;

  # ── User ────────────────────────────────────────────────────────────────────
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

  # ── System-only packages (tools that must be root-accessible) ───────────────
  # Everything else lives in home.nix
  environment.systemPackages = with pkgs; [
    wget
    curl
    git
    vim # emergency editor before HM activates
    exfat
    exfatprogs
    libvirt
    virt-manager
    fwupd
    powertop
    alsa-utils
    fprintd
  ];

  # ── Global programs ─────────────────────────────────────────────────────────
  programs.kdeconnect.enable = true;
  programs.eden.enable = true;
  programs.fish.enable = true; # needed so /etc/shells gets fish
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "25.05";

  # ── Nix settings ────────────────────────────────────────────────────────────
  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      auto-optimise-store = true;
      substituters = [
        "https://cache.nixos.org/"
        "https://attic.xuyh0120.win/lantian"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypb1m8f3p7j9r8xkC+0y5pZ8wQ="
        "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
      ];
    };
  };
}
