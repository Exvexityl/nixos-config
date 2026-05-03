# Modules/niri.nix — Niri scrollable-tiling Wayland compositor (system side)
{
  inputs,
  pkgs,
  ...
}: {
  # sodiboo's niri-flake exposes this — enables the niri package + the
  # niri-session systemd target + polkit rules
  programs.niri = {
    enable  = true;
    package = inputs.niri.packages.${pkgs.system}.niri-stable;
  };

  # Niri needs these to run properly alongside KDE
  services.gnome.at-spi2-core.enable = true;

  environment.systemPackages = with pkgs; [
    # Wayland clipboard / screenshot helpers used in niri keybinds
    wl-clipboard
    grim
    slurp
    swappy      # annotation tool
    wtype       # wayland keyboard emulation
    brightnessctl
    playerctl
    networkmanagerapplet
    pavucontrol
  ];
}
