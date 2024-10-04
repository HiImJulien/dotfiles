{
  description = "System configuration by @HiImJulian";

  inputs = {
    ags.url = "github:aylur/ags";
    catppuccin.url = "github:catppuccin/nix";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    hyprpaper.url = "github:hyprwm/hyprpaper";
    nixpkgs.url = "nixpkgs/nixos-24.05";
  };

  outputs = inputs @ { self, nixpkgs, home-manager, hyprland, catppuccin, ... }:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = import nixpkgs { inherit system; };
    in {
      nixosConfigurations = {
        brisingr = lib.nixosSystem {
          inherit system;
          specialArgs.inputs = inputs;

          modules = [
            catppuccin.nixosModules.catppuccin
            ./hosts/brisingr
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.kirsch = import ./home;
              home-manager.extraSpecialArgs = { inherit inputs; };
            }
          ];
        };
      };
  };
}
