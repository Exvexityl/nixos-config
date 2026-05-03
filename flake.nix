{
  description = "exvexityl's NixOS flake — KDE + Niri + Home Manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # CachyOS kernels
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
    # Niri — stable compositor releases
    niri.url = "github:sodiboo/niri-flake";
    eden.url = "github:daaboulex/eden-nix";

    # Catppuccin for consistent theming across apps
    catppuccin.url = "github:catppuccin/nix";
  };

  outputs =
    {
      nixpkgs,
      eden,
      home-manager,
      niri,
      catppuccin,
      nix-cachyos-kernel,
      ...
    }@inputs:
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          niri.nixosModules.niri
          home-manager.nixosModules.home-manager
          catppuccin.nixosModules.catppuccin
          eden.nixosModules.default

          ./configuration.nix

          {
            home-manager = {
              useGlobalPkgs = true; # share system nixpkgs — no double eval
              useUserPackages = true; # install HM packages into /etc/profiles
              extraSpecialArgs = { inherit inputs; };
              users.exvexityl = import ./home.nix;
              sharedModules = [
                catppuccin.homeManagerModules.catppuccin
                niri.homeModules.niri
              ];
            };
          }
        ];
      };
    };
}
