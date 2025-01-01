{
  description = "System configuration by @HiImJulian";

  inputs = {
    catppuccin.url = "github:catppuccin/nix";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/hyprland";
    hyprpaper.url = "github:hyprwm/hyprpaper";
    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";
    nixpkgs.url = "nixpkgs/nixos-24.11";

    zen-browser.url = "github:0xc000022070/zen-browser-flake";
  };

  outputs = { self, nixpkgs, home-manager, hyprland, catppuccin, ... }@inputs:
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
            ./overlays
            ./hosts/brisingr
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.kirsch = import ./home;
              home-manager.extraSpecialArgs = { inherit inputs; };
              nixpkgs.overlays = [ inputs.hyprpanel.overlay ];
            }
          ];
        };
      };
  };
}
