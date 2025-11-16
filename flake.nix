{
  description = "Home Manager configuration of ionut";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    unstable.url = "nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.3";

      # Optional but recommended to limit the size of your system closure.
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "unstable";
    };

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
    nvf,
    nixos-hardware,
    lanzaboote,
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
    nixosConfigurations.pc_dual_boot = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit inputs;
        inherit system;
        inherit pkgs-unstable;
      };
      modules = [
        lanzaboote.nixosModules.lanzaboote
        ./hosts/pc_dual_boot/lanzaboote.nix
        ./nixos/configuration.nix
        nvf.nixosModules.default
      ];
    };
  };
}
