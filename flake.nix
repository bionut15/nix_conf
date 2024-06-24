{
  description = "Home Manager configuration of ionut";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    pollymc = {
      url = "github:fn2006/PollyMC";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations."ionut" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        	modules = [ ./home/home.nix ];
      };
	#nixosConfigurations.foo = nixpkgs.lib.nixosSystem {
    #    system = "x86_64-linux";
    #    specialArgs = {
    #      inherit inputs;
    #    };

    #    modules = [ .nixos/configuration.nix];
    #  };
    };
}
