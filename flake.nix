{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur.url = "github:nix-community/NUR";
  };

  outputs = { self, nixpkgs, home-manager, nixvim, nur }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [ nur.overlays.default ];
      };
      homeManagerModules = [ nixvim.homeManagerModules.nixvim ];
    in {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit pkgs; inherit nixvim; };
        modules = [
          home-manager.nixosModules.home-manager
          nur.modules.nixos.default
          ./config.nix
        ];
      };
    };
}
