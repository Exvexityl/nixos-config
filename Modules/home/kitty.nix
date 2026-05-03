# Modules/home/kitty.nix — Kitty terminal (Catppuccin Mocha)
{...}: {
  programs.kitty = {
    enable = true;
    catppuccin.enable = true;   # from catppuccin-nix

    font = {
      name = "JetBrainsMono Nerd Font";
      size = 12;
    };

    settings = {
      # Window
      window_padding_width       = 12;
      hide_window_decorations    = "yes";
      background_opacity         = "0.94";
      dynamic_background_opacity = true;

      # Cursor
      cursor_shape               = "beam";
      cursor_blink_interval      = "0.5";
      cursor_stop_blinking_after = "5.0";

      # Scrollback
      scrollback_lines           = 10000;
      scrollback_pager           = "bat --pager 'less -R'";

      # Performance
      repaint_delay              = 10;
      input_delay                = 3;
      sync_to_monitor            = true;

      # URLs
      url_color                  = "#89b4fa";
      url_style                  = "single";
      open_url_with              = "xdg-open";

      # Bell
      enable_audio_bell          = false;
      visual_bell_duration       = "0.1";

      # Tabs
      tab_bar_edge               = "top";
      tab_bar_style              = "powerline";
      tab_powerline_style        = "slanted";
      tab_title_template         = "{index}: {title}";
      active_tab_font_style      = "bold";
      inactive_tab_font_style    = "normal";
    };

    keybindings = {
      "ctrl+shift+t"    = "new_tab_with_cwd";
      "ctrl+shift+enter" = "new_window_with_cwd";
      "ctrl+shift+h"    = "previous_tab";
      "ctrl+shift+l"    = "next_tab";
    };
  };
}
