# Modules/home/editors.nix
{pkgs, ...}: {
  # ── Helix ───────────────────────────────────────────────────────────────────
  programs.helix = {
    enable         = true;
    defaultEditor  = true;
    catppuccin.enable = true;   # from catppuccin-nix HM module

    settings = {
      theme = "catppuccin_mocha";
      editor = {
        line-number           = "relative";
        cursorline            = true;
        color-modes           = true;
        cursor-shape.insert   = "bar";
        cursor-shape.normal   = "block";
        cursor-shape.select   = "underline";
        indent-guides.render  = true;
        lsp.display-inlay-hints = true;
        soft-wrap.enable      = true;
        file-picker.hidden    = false;
      };
      keys.normal = {
        space.space = "file_picker";
        space.w     = ":w";
        space.q     = ":q";
        "C-/"       = "toggle_comments";
      };
    };

    languages = {
      language-server.nixd = {
        command = "nixd";
      };
      language-server.nil = {
        command = "nil";
      };
      language = [
        {
          name                = "nix";
          language-servers    = ["nixd"];
          formatter.command   = "alejandra";
          auto-format         = true;
        }
        {
          name                = "rust";
          auto-format         = true;
        }
        {
          name                = "python";
          auto-format         = true;
        }
      ];
    };
  };

  # ── Neovim (minimal, for emergencies / muscle memory) ───────────────────────
  programs.neovim = {
    enable        = true;
    viAlias       = true;
    vimAlias      = true;
    defaultEditor = false;  # helix is default
    extraConfig   = ''
      set number relativenumber
      set tabstop=2 shiftwidth=2 expandtab
      set termguicolors
    '';
    plugins = with pkgs.vimPlugins; [
      catppuccin-nvim
      nvim-treesitter.withAllGrammars
    ];
    extraLuaConfig = ''
      require("catppuccin").setup({ flavour = "mocha" })
      vim.cmd.colorscheme("catppuccin")
    '';
  };

  # ── LSP / dev tools (shared across editors) ─────────────────────────────────
  home.packages = with pkgs; [
    nixd
    nil
    alejandra
    nodePackages.prettier
    gcc
    pipx
    temurin-jre-bin
  ];
}
