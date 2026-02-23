{ config, pkgs, ...}:
{
    imports = [ ./modules/homebrew.nix ];

    # home-manager.users.archie.home.homeDirectory = /Users/archie;
    users.users.archie.home = "/Users/archie";
}
