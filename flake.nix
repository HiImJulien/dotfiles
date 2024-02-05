{
  description = "Amaterasu Config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";
    unstable.url = "nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${system};
      dotfilesRoot = "~/Repositories/dotfiles";
    in {
      nixosConfigurations = {
        amaterasu = lib.nixosSystem {
          inherit system;
          specialArgs.inputs = inputs;
          modules = [ ./system/configuration.nix ];
        };
      };

      homeConfigurations = {
        kirsch = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./user/home.nix ];
          extraSpecialArgs = { inherit dotfilesRoot; inherit self; };
        };
      };
  };
}
