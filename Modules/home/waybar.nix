# Modules/home/waybar.nix — Waybar configured for Niri (Catppuccin Mocha)
{...}: {
  programs.waybar = {
    enable    = true;
    systemd.enable = true;   # start waybar as a systemd user service

    settings = [{
      layer   = "top";
      position = "top";
      height  = 36;
      spacing = 4;
      margin-top = 6;
      margin-left = 12;
      margin-right = 12;

      modules-left   = ["niri/workspaces" "niri/window"];
      modules-center = ["clock"];
      modules-right  = [
        "pulseaudio"
        "network"
        "battery"
        "backlight"
        "cpu"
        "memory"
        "tray"
      ];

      "niri/workspaces" = {
        format     = "{icon}";
        on-click   = "activate";
        format-icons = {
          "1" = "󰊠";
          "2" = "󰊠";
          "3" = "󰊠";
          active  = "󰮯";
          default = "󰊠";
        };
      };

      "niri/window" = {
        max-length = 50;
        icon       = true;
      };

      clock = {
        format           = "  {:%H:%M}";
        format-alt       = "  {:%A, %d %B %Y}";
        tooltip-format   = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
      };

      battery = {
        states = {
          good     = 80;
          warning  = 30;
          critical = 15;
        };
        format           = "{icon}  {capacity}%";
        format-charging  = "󰂄  {capacity}%";
        format-plugged   = "󰚥  {capacity}%";
        format-icons     = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
      };

      network = {
        format-wifi        = "  {signalStrength}%";
        format-ethernet    = "󰈀 {ipaddr}";
        format-linked      = "󰈁 (No IP)";
        format-disconnected = "󰤭 ";
        tooltip-format     = "{essid} ({signalStrength}%) via {gwaddr}";
        on-click           = "nm-connection-editor";
      };

      pulseaudio = {
        format          = "{icon}  {volume}%";
        format-muted    = "󰝟 ";
        format-icons    = { default = ["󰕿" "󰖀" "󰕾"]; };
        on-click        = "pavucontrol";
        scroll-step     = 5;
      };

      backlight = {
        device  = "intel_backlight";
        format  = "{icon}  {percent}%";
        format-icons = ["󰃞" "󰃟" "󰃠"];
        on-scroll-up   = "brightnessctl set +5%";
        on-scroll-down = "brightnessctl set 5%-";
      };

      cpu = {
        interval = 5;
        format   = "󰘚  {usage}%";
        tooltip  = false;
      };

      memory = {
        interval = 5;
        format   = "  {percentage}%";
        tooltip-format = "{used:0.1f}G / {total:0.1f}G";
      };

      tray = {
        spacing = 8;
      };
    }];

    # Catppuccin Mocha colour palette
    style = ''
      @define-color base   #1e1e2e;
      @define-color mantle #181825;
      @define-color crust  #11111b;
      @define-color text   #cdd6f4;
      @define-color subtext1 #bac2de;
      @define-color overlay1 #7f849c;
      @define-color surface0 #313244;
      @define-color surface1 #45475a;
      @define-color lavender #b4befe;
      @define-color mauve   #cba6f7;
      @define-color blue    #89b4fa;
      @define-color sky     #89dceb;
      @define-color teal    #94e2d5;
      @define-color green   #a6e3a1;
      @define-color yellow  #f9e2af;
      @define-color peach   #fab387;
      @define-color red     #f38ba8;

      * {
        font-family: "JetBrainsMono Nerd Font", monospace;
        font-size: 13px;
        border: none;
        border-radius: 0;
        min-height: 0;
      }

      window#waybar {
        background-color: alpha(@base, 0.92);
        color: @text;
        border-radius: 12px;
        border: 1px solid @surface1;
      }

      .modules-left, .modules-center, .modules-right {
        background: transparent;
      }

      #workspaces button {
        padding: 0 8px;
        color: @overlay1;
        background: transparent;
        border-radius: 8px;
        transition: all 0.2s ease;
      }

      #workspaces button.active {
        color: @lavender;
        background: @surface0;
      }

      #workspaces button:hover {
        color: @text;
        background: @surface1;
      }

      #clock {
        color: @lavender;
        font-weight: bold;
        padding: 0 12px;
      }

      #battery { color: @green; }
      #battery.warning { color: @yellow; }
      #battery.critical { color: @red; }
      #battery.charging { color: @teal; }

      #network { color: @blue; }
      #network.disconnected { color: @red; }

      #pulseaudio { color: @mauve; }
      #pulseaudio.muted { color: @overlay1; }

      #backlight { color: @yellow; }
      #cpu { color: @peach; }
      #memory { color: @sky; }

      #tray {
        padding: 0 8px;
      }

      tooltip {
        background: @mantle;
        border: 1px solid @surface1;
        border-radius: 8px;
        color: @text;
      }
    '';
  };
}
