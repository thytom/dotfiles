{
    description = "Unified system flake";

    inputs = {
        nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
        nixpkgs.url = "github:NixOS/nixpkgs/25.11";
        nix-darwin.url = "github:LnL7/nix-darwin/nix-darwin-25.11";
        nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
        agenix.url = "github:ryantm/agenix";
        agenix.inputs.nixpkgs.follows = "nixpkgs";
        home-manager.url = "github:nix-community/home-manager/release-25.11";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
    };

    outputs = inputs@{ self, nix-darwin, nixpkgs, nixpkgs-unstable, agenix, home-manager }:
        let
        pkgs-unstable-darwin = import nixpkgs-unstable {
            system="aarch64-darwin";
            config.allowUnfree = true;
        };
        pkgs-unstable-x86_64 = import nixpkgs-unstable {
            system="x86_64-linux";
            config.allowUnfree = true;
        };
        in
    {
# Build darwin flake using:
# $ darwin-rebuild build --flake .#defiantly
        darwinConfigurations."defiantly" = nix-darwin.lib.darwinSystem {
            system = "aarch64-darwin";

            specialArgs = {
                inherit self;
                pkgs-unstable = pkgs-unstable-darwin;
            };

            modules = [ 
                    home-manager.darwinModules.home-manager
                    ./hosts/defiantly/configuration.nix
            ];
        };

        nixosConfigurations."archies-home-worklab" = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";

            specialArgs = {
                inherit self;
                pkgs-unstable = pkgs-unstable-x86_64;
            };

            modules = [
                home-manager.nixosModules.home-manager
                ./modules/home.nix
                agenix.nixosModules.default
                ./modules/base-packages.nix
                ./hosts/archies-home-worklab/configuration.nix
                ./hosts/archies-home-worklab/hardware-configuration.nix
                ./hosts/archies-home-worklab/modules/vm.nix
            ];
        };
    };
}
