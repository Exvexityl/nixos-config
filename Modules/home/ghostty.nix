# Modules/home/ghostty.nix — Ghostty terminal (Catppuccin Mocha)
{pkgs, ...}: {
  # Ghostty doesn't have a HM module yet — write config file directly
  home.packages = [pkgs.ghostty];

  xdg.configFile."ghostty/config".text = ''
    # ── Catppuccin Mocha ──────────────────────────────────────────────────────
    background            = 1e1e2e
    foreground            = cdd6f4
    selection-background  = 45475a
    selection-foreground  = cdd6f4

    # Palette
    palette = 0=#45475a
    palette = 1=#f38ba8
    palette = 2=#a6e3a1
    palette = 3=#f9e2af
    palette = 4=#89b4fa
    palette = 5=#cba6f7
    palette = 6=#94e2d5
    palette = 7=#bac2de
    palette = 8=#585b70
    palette = 9=#f38ba8
    palette = 10=#a6e3a1
    palette = 11=#f9e2af
    palette = 12=#89b4fa
    palette = 13=#cba6f7
    palette = 14=#94e2d5
    palette = 15=#a6adc8

    # ── Font ─────────────────────────────────────────────────────────────────
    font-family           = JetBrainsMono Nerd Font
    font-size             = 12
    font-feature          = calt, liga, zero

    # ── Window ───────────────────────────────────────────────────────────────
    window-padding-x      = 12
    window-padding-y      = 12
    background-opacity    = 0.94
    window-decoration     = none

    # ── Cursor ───────────────────────────────────────────────────────────────
    cursor-style          = bar
    cursor-style-blink    = true

    # ── Shell ────────────────────────────────────────────────────────────────
    shell                 = fish

    # ── Performance ──────────────────────────────────────────────────────────
    gtk-single-instance   = true
  '';
}
