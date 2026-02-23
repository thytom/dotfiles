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
    ];

    environment.systempackages = with pkgs; [
        # Mac app store command line interface
        mas
    ];

    users.knownUsers = [ "archie" ];
    system.primaryUser = "archie";

    # home-manager.users.archie.home.homeDirectory = /Users/archie;
    users.users.archie.home = "/Users/archie";

    security.pam.services.sudo_local.touchIdAuth = true;

    system.stateVersion = 5;

    nixpkgs.hostPlatform = "aarch64-darwin";
}
