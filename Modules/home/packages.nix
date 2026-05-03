# Modules/home/packages.nix — user packages via Home Manager
{pkgs, ...}: {
  home.packages = with pkgs; [
    # ── Terminals ──────────────────────────────────────────────────────────────
    kitty
    ghostty
    alacritty

    # ── Editors / IDEs ─────────────────────────────────────────────────────────
    zed-editor
    micro

    # ── File management ────────────────────────────────────────────────────────
    gparted
    nautilus
    thunar
    unzip

    # ── System utilities ───────────────────────────────────────────────────────
    fastfetch
    neofetch
    stow
    ugrep
    triton-llvm

    # ── Wayland / compositor tools ─────────────────────────────────────────────
    waybar
    dunst
    rofi-wayland   # wayland-native rofi fork
    wl-clipboard
    grim
    slurp
    swappy
    wtype
    brightnessctl
    playerctl
    networkmanagerapplet
    pavucontrol

    # ── Media & downloads ──────────────────────────────────────────────────────
    qbittorrent

    # ── Gaming & launchers ─────────────────────────────────────────────────────
    hydralauncher

    # ── AI / ML ────────────────────────────────────────────────────────────────
    vllm

    # ── Fonts (nerd fonts for eza icons & starship) ─────────────────────────────
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.iosevka

    # ── Theming ────────────────────────────────────────────────────────────────
    papirus-icon-theme
    catppuccin-cursors
    kvantum          # Qt style engine for KDE theming

    # ── Fingerprint UI ─────────────────────────────────────────────────────────
    fprintd

    # ── Misc ───────────────────────────────────────────────────────────────────
    gnome-tweaks     # handy even without gnome shell for GTK prefs
    gnome-extension-manager
    seahorse
    typr             # typing speed test
    vicinae          # vim training
  ];
}
