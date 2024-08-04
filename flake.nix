{
  description = "Home Manager configuration of ionut";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    unstable.url = "nixpkgs/nixos-unstable";
    pollymc = {
      url = "github:fn2006/PollyMC";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    nixpkgs,
    home-manager,
    unstable,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacypackages.${system};
    pkgs-unstable = unstable.legacyPackages.${system};
  in {
    homeConfigurations."ionut" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [./home/home.nix];
      #specialArgs = {inherit pkgs-unstable;};
    };
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit inputs;
        inherit pkgs-unstable;
      };
      modules = [./nixos/configuration.nix];
    };
  };
}
