{ config, pkgs, ...}:
{
    imports = [ ./modules/homebrew.nix ];

    # home-manager.users.archie.home.homeDirectory = /Users/archie;
}
