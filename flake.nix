{
  description = "System configuration by @HiImJulian";

  inputs = {
    ags.url = "github:Aylur/ags";
    catppuccin.url = "github:catppuccin/nix/a48e70a31616cb63e4794fd3465bff1835cc4246";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    hyprpaper.url = "github:hyprwm/hyprpaper";

    nixpkgs.url = "nixpkgs/nixos-23.11";
  };

  outputs = inputs @ { self, nixpkgs, home-manager, hyprland, catppuccin, ... }:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations = {
        brisingr = lib.nixosSystem {
          inherit system;
          specialArgs.inputs = inputs;

          modules = [
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
