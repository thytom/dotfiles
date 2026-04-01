{ self, config, pkgs, ...}:
{
    imports = [ 
        ./modules/homebrew.nix 
        ../../modules/base.nix
        ../../modules/users.nix
        ../../modules/home.nix
        ../../modules/fonts.nix
        ../../modules/packages/utility.nix
        ../../modules/packages/tools.nix
        ../../modules/packages/dev.nix
        ../../modules/packages/embedded.nix
        ../../modules/packages/graphical.nix
        ../../modules/packages/latex.nix
        ../../modules/packages/typst.nix
    ];

    environment.systemPackages = with pkgs; [
        # Mac app store command line interface
        mas
    ];

    users.knownUsers = [ "archie" ];
    system.primaryUser = "archie";

    # home-manager.users.archie.home.homeDirectory = /Users/archie;
    users.users.archie.home = "/Users/archie";
    users.users.archie.uid = 501;

    security.pam.services.sudo_local.touchIdAuth = true;

    nixpkgs.overlays = [ (final: prev: {
        inherit (prev.lixPackageSets.stable)
        nixpkgs-review
        nix-eval-jobs
        nix-fast-build
        colmena;
    }) ];

    nix.package = pkgs.lixPackageSets.stable.lix;

    system.stateVersion = 5;

    nixpkgs.hostPlatform = "aarch64-darwin";
}
