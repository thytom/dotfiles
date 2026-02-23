{
    description = "Unified system flake";

    inputs = {
        nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
        nixpkgs.url = "github:NixOS/nixpkgs/25.11";
        nix-darwin.url = "github:LnL7/nix-darwin/nix-darwin-25.11";
        nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
        agenix.url = "github:ryantm/agenix";
        agenix.inputs.nixpkgs.follows = "nixpkgs";
    };

    outputs = inputs@{ self, nix-darwin, nixpkgs, nixpkgs-unstable, agenix }:
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
                    ./modules/base.nix
                    ./modules/users.nix
                    ./modules/fonts.nix
                    ./modules/base-packages.nix
                    ./modules/packages.nix
                    ./modules/homebrew.nix
                    ./modules/overlays.nix
            ];
        };

        nixosConfigurations."archies-home-worklab" = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";

            specialArgs = {
                inherit self;
                pkgs-unstable = pkgs-unstable-x86_64;
            };

            modules = [
                agenix.nixosModules.default
                ./modules/base-packages.nix
                ./hosts/archies-home-worklab/configuration.nix
                /etc/nixos/hardware-configuration.nix
            ];
        };
    };
}
