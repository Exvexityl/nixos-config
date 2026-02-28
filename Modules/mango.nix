{
  pkgs,
  ...
}:
{
  programs.mango.enable = true;
  programs.dms-shell.enable = true;
  programs.fish.enable = true;
  programs.nix-ld.enable = true;
   environment.systemPackages = with pkgs; [
    lm_sensors
    brightnessctl 
    wireplumber
    pavucontrol
    playerctl 
    networkmanager
    networkmanagerapplet
    bluez
    bluez-tools
    blueman
    jq             
    socat           
    libnotify
    swaynotificationcenter
    wget
    unzip
    git
    gum
    hyprland
    hyprpaper
    wf-recorder
    waybar
    grim
    slurp
    swww
    eww
    nautilus
    quickshell
    dunst
    thunar
    thunar-volman
    thunar-dropbox-plugin
    thunar-vcs-plugin
    thunar-archive-plugin
    thunar-media-tags-plugin
    firefox
    jq
    brightnessctl
    networkmanager
    wireplumber 
    wlogout
    flatpak
    swaynotificationcenter
    matugen
    bluez
    fzf
  ];

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-color-emoji
    inter
    roboto
    liberation_ttf
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    nerd-fonts.hack
  ];
}
