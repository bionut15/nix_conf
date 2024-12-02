{
  description = "Home Manager configuration of ionut";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    unstable.url = "nixpkgs/nixos-unstable";

    stylix = {
      url = "github:danth/stylix/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    hyprland.url = "github:hyprwm/Hyprland";
    pollymc = {
      url = "github:fn2006/PollyMC";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "unstable";
    };
  };

  outputs = inputs @ {
    nixpkgs,
    home-manager,
    unstable,
    stylix,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    pkgs-unstable = unstable.legacyPackages.${system};
  in {
    homeConfigurations."ionut" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [
        stylix.homeManagerModules.stylix
        ./home/home.nix
      ];
    };
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit inputs;
        inherit pkgs-unstable;
      };
      modules = [
        ./nixos/configuration.nix
      ];
    };
  };
}
