# Modules/home/dunst.nix — Dunst notification daemon (Catppuccin Mocha)
{...}: {
  services.dunst = {
    enable = true;

    settings = {
      global = {
        width          = 380;
        height         = 200;
        origin         = "top-right";
        offset         = "16x48";   # clear of waybar
        scale          = 0;
        notification_limit = 5;
        progress_bar   = true;
        progress_bar_height = 8;
        progress_bar_corner_radius = 4;
        indicate_hidden = true;
        transparency   = 8;
        separator_height = 2;
        padding        = 12;
        horizontal_padding = 14;
        text_icon_padding = 10;
        frame_width    = 2;
        gap_size       = 6;
        sort           = true;
        font           = "JetBrainsMono Nerd Font 11";
        line_height    = 2;
        markup         = "full";
        format         = "<b>%s</b>\n%b";
        alignment      = "left";
        vertical_alignment = "center";
        show_age_threshold = 60;
        ellipsize      = "middle";
        ignore_newline = false;
        stack_duplicates = true;
        hide_duplicate_count = false;
        show_indicators = true;
        icon_corner_radius = 4;
        icon_theme     = "Papirus-Dark";
        enable_recursive_icon_lookup = true;
        sticky_history = true;
        history_length = 20;
        dmenu          = "rofi -dmenu -p dunst";
        browser        = "xdg-open";
        always_run_script = true;
        corner_radius  = 10;
        ignore_dbusclose = false;
        force_xwayland = false;
        force_xinerama = false;
        mouse_left_click   = "close_current";
        mouse_middle_click = "do_action, close_current";
        mouse_right_click  = "close_all";
      };

      urgency_low = {
        background   = "#1e1e2e";
        foreground   = "#cdd6f4";
        frame_color  = "#45475a";
        timeout      = 4;
      };

      urgency_normal = {
        background   = "#1e1e2e";
        foreground   = "#cdd6f4";
        frame_color  = "#b4befe";   # lavender
        timeout      = 6;
      };

      urgency_critical = {
        background   = "#1e1e2e";
        foreground   = "#f38ba8";   # red
        frame_color  = "#f38ba8";
        timeout      = 0;
      };
    };
  };
}
