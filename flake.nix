{
  description = "System configuration by @HiImJulian";

  inputs = {
    catppuccin.url = "github:catppuccin/nix";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager-unstable = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    hyprland.url = "github:hyprwm/hyprland";
    hyprpaper.url = "github:hyprwm/hyprpaper";
    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";
    nixpkgs.url = "nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    zen-browser.url = "github:0xc000022070/zen-browser-flake";

    solaar = {
      url = "https://flakehub.com/f/Svenum/Solaar-Flake/*.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    hyprland,
    catppuccin,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    lib = nixpkgs.lib;
    pkgs = import nixpkgs {inherit system;};
  in {
    nixosConfigurations = {
      brisingr = lib.nixosSystem {
        inherit system;
        specialArgs = {
          inputs = inputs;
          unstable = import nixpkgs-unstable {
            inherit system;
          };
        };

        modules = [
          catppuccin.nixosModules.catppuccin
          inputs.solaar.nixosModules.default
          ./overlays
          ./hosts/brisingr
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.kirsch = import ./home;
            home-manager.extraSpecialArgs = {
              inherit inputs;
              unstable = import nixpkgs-unstable {
                inherit system;
              };
            };
            nixpkgs.overlays = [inputs.hyprpanel.overlay];
          }
        ];
      };
    };

    formatter.${system} = pkgs.alejandra;
  };
}
