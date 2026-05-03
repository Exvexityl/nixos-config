# Modules/home/shell.nix
{pkgs, ...}: {
  # ── Fish ────────────────────────────────────────────────────────────────────
  programs.fish = {
    enable = true;

    shellAliases = {
      ls   = "eza --icons";
      ll   = "eza -l --icons --git";
      la   = "eza -la --icons --git";
      lt   = "eza --tree --icons";
      cat  = "bat";
      grep = "ugrep";
      cd   = "z";    # zoxide
      vim  = "nvim";
      vi   = "nvim";
      g    = "git";
      lg   = "lazygit";
      rb   = "sudo nixos-rebuild switch --flake /etc/nixos#nixos";
      hms  = "home-manager switch --flake /etc/nixos#exvexityl";
      # Quick niri config reload
      niri-reload = "niri msg action do-screen-transition; niri msg reload-config";
    };

    interactiveShellInit = ''
      # Zoxide — smarter cd
      zoxide init fish | source

      # Remove the greeting
      set -g fish_greeting ""

      # Use Catppuccin Mocha colours in fish syntax highlighting
      set -g fish_color_command       lavender
      set -g fish_color_param         text
      set -g fish_color_keyword       mauve
      set -g fish_color_comment       overlay1
      set -g fish_color_error         red
      set -g fish_color_operator      sky
      set -g fish_color_quote         green
      set -g fish_color_redirection   teal
    '';

    plugins = [
      # autopair — auto-close brackets/quotes
      {
        name = "autopair";
        src  = pkgs.fishPlugins.autopair;
      }
      # done — notify when long commands finish
      {
        name = "done";
        src  = pkgs.fishPlugins.done;
      }
    ];
  };

  # ── Starship prompt ─────────────────────────────────────────────────────────
  programs.starship = {
    enable         = true;
    enableFishIntegration = true;
    settings = {
      format = "$directory$git_branch$git_status$nix_shell$cmd_duration$line_break$character";
      add_newline = true;

      character = {
        success_symbol = "[❯](bold lavender)";
        error_symbol   = "[❯](bold red)";
      };

      directory = {
        style              = "bold sky";
        truncation_length  = 3;
        truncate_to_repo   = true;
      };

      git_branch = {
        symbol = " ";
        style  = "bold mauve";
      };

      git_status = {
        style   = "bold peach";
        ahead   = "⇡$count";
        behind  = "⇣$count";
        diverged = "⇕⇡$ahead_count⇣$behind_count";
        modified = "!$count";
        staged   = "+$count";
        untracked = "?$count";
      };

      nix_shell = {
        symbol = " ";
        style  = "bold blue";
        format = "[$symbol$name]($style) ";
      };

      cmd_duration = {
        min_time = 2000;
        style    = "bold yellow";
        format   = "took [$duration]($style) ";
      };
    };
  };

  # ── Zoxide (smart cd) ───────────────────────────────────────────────────────
  programs.zoxide = {
    enable               = true;
    enableFishIntegration = true;
  };

  # ── Eza ─────────────────────────────────────────────────────────────────────
  programs.eza = {
    enable               = true;
    enableFishIntegration = true;
    icons                = "auto";
    git                  = true;
  };

  # ── Bat ─────────────────────────────────────────────────────────────────────
  programs.bat = {
    enable = true;
    config = {
      theme  = "Catppuccin Mocha";
      pager  = "less -FR";
      map-syntax = ["*.nix:Nix"];
    };
    themes = {
      "Catppuccin Mocha" = {
        src  = pkgs.catppuccin-bat;
        file = "themes/Catppuccin Mocha.tmTheme";
      };
    };
  };

  # ── Lazygit ─────────────────────────────────────────────────────────────────
  programs.lazygit = {
    enable   = true;
    settings = {
      gui.theme = {
        activeBorderColor   = ["#b4befe" "bold"];
        inactiveBorderColor = ["#585b70"];
        selectedLineBgColor = ["#313244"];
      };
      git.paging = {
        colorArg   = "always";
        pager      = "delta --dark --paging=never";
      };
    };
  };

  # ── Yazi (TUI file manager) ──────────────────────────────────────────────────
  programs.yazi = {
    enable               = true;
    enableFishIntegration = true;
    settings = {
      manager = {
        show_hidden  = true;
        sort_by      = "natural";
        sort_dir_first = true;
      };
    };
  };

  # ── Git ─────────────────────────────────────────────────────────────────────
  programs.git = {
    enable      = true;
    delta.enable = true;   # pretty diffs
    extraConfig = {
      init.defaultBranch  = "main";
      pull.rebase         = true;
      push.autoSetupRemote = true;
      core.editor         = "hx";
    };
  };

  # ── Direnv — auto-load nix shells ───────────────────────────────────────────
  programs.direnv = {
    enable               = true;
    nix-direnv.enable    = true;
    enableFishIntegration = true;
  };
}
