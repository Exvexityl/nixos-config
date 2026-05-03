# Modules/kde.nix — KDE Plasma 6 (Wayland-first, no GNOME)
{pkgs, ...}: {
  # SDDM is the canonical KDE display manager
  services.displayManager.sddm = {
    enable      = true;
    wayland.enable = true;
    theme       = "breeze";
  };

  services.desktopManager.plasma6.enable = true;

  # Remove GNOME entirely
  services.desktopManager.gnome.enable  = false;
  services.displayManager.gdm.enable    = false;

  # KDE-friendly portal
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      kdePackages.xdg-desktop-portal-kde
      xdg-desktop-portal-wlr   # for niri/wlroots apps
    ];
    config.common.default = "kde";
  };

  environment.systemPackages = with pkgs; [
    kdePackages.dolphin
    kdePackages.ark
    kdePackages.kate
    kdePackages.konsole
    kdePackages.spectacle
    kdePackages.gwenview
    kdePackages.okular
    kdePackages.plasma-browser-integration
    kdePackages.kdeconnect-kde
    gnome-keyring   # kept for non-KDE apps that speak libsecret
    seahorse
  ];
}
