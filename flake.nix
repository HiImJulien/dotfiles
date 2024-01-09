{
  description = "Amaterasu Config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${system};
      dotfilesRoot = "~/Repositories/dotfiles";
    in {
      nixosConfigurations = {
        amaterasu = lib.nixosSystem {
          inherit system;
          modules = [ ./system/configuration.nix ];
        };
      };

      homeConfigurations = {
        kirsch = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./user/home.nix ];
          extraSpecialArgs = { inherit dotfilesRoot; };
        };
      };
  };
}
