# Modules/home/niri-config.nix — Niri scrollable-tiling compositor (home side)
# Uses sodiboo's niri-flake HM module for typed config
{
  pkgs,
  config,
  ...
}: let
  # Catppuccin Mocha hex values for niri layout colours
  c = {
    base    = "1e1e2e";
    surface = "313244";
    lavender = "b4befe";
    mauve   = "cba6f7";
    red     = "f38ba8";
    overlay = "7f849c";
  };
in {
  programs.niri = {
    # sodiboo's HM module uses `settings` with a typed Nix DSL
    settings = {
      # ── Input ───────────────────────────────────────────────────────────────
      input = {
        keyboard = {
          xkb.layout = "gb";
          repeat-delay = 200;
          repeat-rate  = 40;
        };

        touchpad = {
          tap            = true;
          natural-scroll = true;
          accel-profile  = "flat";
          accel-speed    = 0.3;
        };

        mouse = {
          accel-profile = "flat";
          accel-speed   = 0.0;
        };
      };

      # ── Outputs ─────────────────────────────────────────────────────────────
      # Niri auto-detects outputs; override here if needed
      # outputs."eDP-1" = { scale = 1.5; };

      # ── Layout ──────────────────────────────────────────────────────────────
      layout = {
        gaps          = 12;
        center-focused-column = "never";
        always-center-single-column = false;

        preset-column-widths = [
          { proportion = 0.33; }
          { proportion = 0.5;  }
          { proportion = 0.67; }
          { proportion = 1.0;  }
        ];

        default-column-width = { proportion = 0.5; };

        focus-ring = {
          enable = true;
          width  = 2;
          active.color   = "#${c.lavender}";
          inactive.color = "#${c.overlay}";
        };

        border = {
          enable = false;   # use focus-ring only to keep it clean
        };

        shadow = {
          enable     = true;
          softness   = 30;
          spread     = 5;
          offset.x   = 0;
          offset.y   = 5;
          color      = "#00000066";
        };
      };

      # ── Window rules ────────────────────────────────────────────────────────
      window-rules = [
        # Terminals: fixed narrow column
        {
          matches = [
            { app-id = "^kitty$"; }
            { app-id = "^ghostty$"; }
            { app-id = "^Alacritty$"; }
          ];
          default-column-width = { proportion = 0.45; };
          draw-border-with-background = false;
          geometry-corner-radius = {
            top-left     = 12.0;
            top-right    = 12.0;
            bottom-left  = 12.0;
            bottom-right = 12.0;
          };
          clip-to-geometry = true;
        }
        # Floating dialogs
        {
          matches = [
            { app-id = "^org.kde.polkit-kde-authentication-agent-1$"; }
            { app-id = "^nm-connection-editor$"; }
            { app-id = "^pavucontrol$"; }
            { app-id = "^org.gnome.seahorse$"; }
          ];
          open-floating = true;
        }
        # File managers: wider
        {
          matches = [
            { app-id = "^org.kde.dolphin$"; }
            { app-id = "^org.gnome.Nautilus$"; }
          ];
          default-column-width = { proportion = 0.55; };
        }
        # Global rounded corners
        {
          matches = [{}];
          geometry-corner-radius = {
            top-left     = 10.0;
            top-right    = 10.0;
            bottom-left  = 10.0;
            bottom-right = 10.0;
          };
          clip-to-geometry = true;
        }
      ];

      # ── Animations ──────────────────────────────────────────────────────────
      animations = {
        slowdown = 0.8;   # slightly faster than default

        workspace-switch.spring = {
          damping-ratio = 1.0;
          stiffness     = 1000;
          epsilon       = 0.0001;
        };

        window-open.duration-ms  = 200;
        window-close.duration-ms = 150;

        horizontal-view-movement.spring = {
          damping-ratio = 1.0;
          stiffness     = 800;
          epsilon       = 0.0001;
        };
      };

      # ── Binds ────────────────────────────────────────────────────────────────
      binds = with builtins; let
        # Shorthand helpers
        spawn  = cmd: { action.spawn = cmd; };
        niriMsg = args: { action.do-screen-transition = null; } // args;
      in {
        # ── Apps ───────────────────────────────────────────────────────────────
        "Super+Return".action.spawn     = ["ghostty"];
        "Super+Shift+Return".action.spawn = ["kitty"];
        "Super+Space".action.spawn      = ["rofi" "-show" "drun" "-show-icons"];
        "Super+E".action.spawn          = ["dolphin"];
        "Super+B".action.spawn          = ["xdg-open" "https://"];
        "Super+Shift+S".action.spawn    = ["grim" "-g" "$(slurp)" "-" "|" "swappy" "-f" "-"];

        # ── Window management ──────────────────────────────────────────────────
        "Super+Q".action.close-window        = {};
        "Super+F".action.fullscreen-window   = {};
        "Super+Shift+F".action.toggle-windowed-fullscreen = {};
        "Super+V".action.toggle-window-floating = {};
        "Super+C".action.center-column       = {};

        # Focus
        "Super+H".action.focus-column-left   = {};
        "Super+L".action.focus-column-right  = {};
        "Super+J".action.focus-window-down   = {};
        "Super+K".action.focus-window-up     = {};
        # Arrow keys too
        "Super+Left".action.focus-column-left   = {};
        "Super+Right".action.focus-column-right = {};
        "Super+Down".action.focus-window-down   = {};
        "Super+Up".action.focus-window-up       = {};

        # Move windows
        "Super+Shift+H".action.move-column-left    = {};
        "Super+Shift+L".action.move-column-right   = {};
        "Super+Shift+J".action.move-window-down    = {};
        "Super+Shift+K".action.move-window-up      = {};

        # Resize columns
        "Super+Minus".action.set-column-width = "-10%";
        "Super+Equal".action.set-column-width = "+10%";
        "Super+Shift+Minus".action.set-window-height = "-10%";
        "Super+Shift+Equal".action.set-window-height = "+10%";

        # Preset widths
        "Super+R".action.switch-preset-column-width = {};

        # ── Workspaces ─────────────────────────────────────────────────────────
        "Super+1".action.focus-workspace = 1;
        "Super+2".action.focus-workspace = 2;
        "Super+3".action.focus-workspace = 3;
        "Super+4".action.focus-workspace = 4;
        "Super+5".action.focus-workspace = 5;
        "Super+Shift+1".action.move-column-to-workspace = 1;
        "Super+Shift+2".action.move-column-to-workspace = 2;
        "Super+Shift+3".action.move-column-to-workspace = 3;
        "Super+Shift+4".action.move-column-to-workspace = 4;
        "Super+Shift+5".action.move-column-to-workspace = 5;
        "Super+Tab".action.focus-workspace-previous       = {};
        "Super+Shift+Tab".action.move-column-to-workspace-previous = {};

        # ── Media / brightness ─────────────────────────────────────────────────
        "XF86AudioRaiseVolume".action.spawn  = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%+"];
        "XF86AudioLowerVolume".action.spawn  = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-"];
        "XF86AudioMute".action.spawn         = ["wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"];
        "XF86MonBrightnessUp".action.spawn   = ["brightnessctl" "set" "+10%"];
        "XF86MonBrightnessDown".action.spawn = ["brightnessctl" "set" "10%-"];
        "XF86AudioPlay".action.spawn         = ["playerctl" "play-pause"];
        "XF86AudioNext".action.spawn         = ["playerctl" "next"];
        "XF86AudioPrev".action.spawn         = ["playerctl" "previous"];

        # ── Niri / session ─────────────────────────────────────────────────────
        "Super+Shift+E".action.quit           = { skip-confirmation = true; };
        "Super+Shift+R".action.reload-config  = {};
        "Super+P".action.screenshot           = {};
        "Super+Shift+P".action.screenshot-screen = {};
      };

      # ── Startup ─────────────────────────────────────────────────────────────
      spawn-at-startup = [
        { command = ["waybar"]; }
        { command = ["dunst"];  }
        { command = ["nm-applet" "--indicator"]; }
        {
          command = [
            "${pkgs.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1"
          ];
        }
      ];

      # ── Prefer no CSD (use niri SSD instead) ────────────────────────────────
      prefer-no-csd = true;
    };
  };

  # Rofi config for niri (Wayland-native, Catppuccin Mocha)
  programs.rofi = {
    enable   = true;
    package  = pkgs.rofi-wayland;
    terminal = "${pkgs.ghostty}/bin/ghostty";
    theme    = builtins.toFile "catppuccin-mocha.rasi" ''
      * {
        bg0:  #1e1e2eF2;
        bg1:  #313244;
        fg0:  #cdd6f4;
        fg1:  #bac2de;
        ac:   #b4befe;
        ur:   #f38ba8;

        background-color: transparent;
        text-color:       @fg0;
        border-color:     @ac;
      }
      window {
        background-color: @bg0;
        border:           2px;
        border-color:     @ac;
        border-radius:    12px;
        width:            480px;
        padding:          12px;
      }
      mainbox  { background-color: transparent; }
      inputbar { background-color: @bg1; border-radius: 8px; padding: 8px 12px; }
      entry    { background-color: transparent; text-color: @fg0; }
      prompt   { background-color: transparent; text-color: @ac; }
      listview { background-color: transparent; lines: 8; }
      element  { background-color: transparent; padding: 6px 10px; border-radius: 6px; }
      element selected { background-color: @bg1; text-color: @ac; }
    '';
  };
}
