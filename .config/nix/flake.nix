{
    description = "Unified system flake";

    inputs = {
        nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
        nixpkgs.url = "github:NixOS/nixpkgs/25.11";
        nix-darwin.url = "github:LnL7/nix-darwin/nix-darwin-25.11";
        nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    };

    outputs = inputs@{ self, nix-darwin, nixpkgs, nixpkgs-unstable }:
        let
        pkgs-unstable = import nixpkgs-unstable {
            system="aarch64-darwin";
            config.allowUnfree = true;
        };
        system = "aarch64-darwin";
        in
    {
# Build darwin flake using:
# $ darwin-rebuild build --flake .#defiantly
        darwinConfigurations."defiantly" = nix-darwin.lib.darwinSystem {
            inherit system;

            specialArgs = {
                inherit self pkgs-unstable;
            };

            modules = [ 
                    ./modules/base.nix
                    ./modules/users.nix
                    ./modules/fonts.nix
                    ./modules/packages.nix
                    ./modules/homebrew.nix
                    ./modules/overlays.nix
            ];
        };
    };
}
