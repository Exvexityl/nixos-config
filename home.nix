# home.nix — Home Manager entry point for exvexityl
{
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ./Modules/home/shell.nix
    ./Modules/home/editors.nix
    ./Modules/home/packages.nix
    ./Modules/home/waybar.nix
    ./Modules/home/dunst.nix
    ./Modules/home/kitty.nix
    ./Modules/home/ghostty.nix
    ./Modules/home/niri-config.nix
  ];

  # ── Identity ────────────────────────────────────────────────────────────────
  home = {
    username = "exvexityl";
    homeDirectory = "/home/exvexityl";
    stateVersion = "25.05";
  };

  # ── Catppuccin Mocha (Noctalia-adjacent dark theme) ─────────────────────────
  # sodiboo's catppuccin-nix handles gtk, qt, icons, cursors automatically
  catppuccin = {
    enable = true;
    flavor = "mocha";
    accent = "lavender";
  };
  # ── XDG dirs ────────────────────────────────────────────────────────────────
  xdg = {
    enable = true;
    userDirs.enable = true;
    userDirs.createDirectories = true;
    mimeApps.enable = true;
    mimeApps.defaultApplications = {
      "inode/directory" = "org.kde.dolphin.desktop";
      "text/html" = "firefox.desktop";
      "application/pdf" = "org.kde.okular.desktop";
      "image/png" = "org.kde.gwenview.desktop";
      "image/jpeg" = "org.kde.gwenview.desktop";
    };
  };

  # ── Session variables (user-level) ──────────────────────────────────────────
  home.sessionVariables = {
    EDITOR = "hx";
    VISUAL = "hx";
    PAGER = "bat";
    MANPAGER = "sh -c 'col -bx | bat -l man -p'";
  };

  # Let HM manage itself
  programs.home-manager.enable = true;
}
