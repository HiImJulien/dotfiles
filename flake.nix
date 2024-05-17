{
  description = "System configuration by @HiImJulian";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ags = {
      url = "github:Aylur/ags";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
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
          ];
        };
      };

      homeConfigurations = {
        kirsch = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./home ];
          extraSpecialArgs = { inherit self; inherit inputs; };
        };
      };
  };
}
