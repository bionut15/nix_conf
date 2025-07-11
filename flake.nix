{
  description = "Home Manager configuration of ionut";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    unstable.url = "nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    stylix = {
      url = "github:danth/stylix/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";
    hyprland.url = "github:hyprwm/Hyprland";

    pollymc = {
      url = "github:fn2006/PollyMC";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "unstable";
    };
  };

  outputs = inputs @ {
    nixpkgs,
    home-manager,
    unstable,
    stylix,
    hyprpanel,
    nixos-hardware,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    pkgs-unstable = unstable.legacyPackages.${system};
  in {
    homeConfigurations."ionut" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [
        stylix.homeModules.stylix
        ./home/home.nix
      ];
    };
    nixosConfigurations.nixPad = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit inputs;
        inherit system;
        inherit pkgs-unstable;
      };
      modules = [
        {nixpkgs.overlays = [inputs.hyprpanel.overlay];}
        ./nixos/configuration.nix
      ];
    };
  };
}
