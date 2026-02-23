{ config, pkgs, ...}:
{
    imports = [ 
        ./modules/homebrew.nix 
        ../../modules/base.nix
        ../../modules/users.nix
        ../../modules/home.nix
        ../../modules/fonts.nix
        ../../modules/base-packages.nix
        ../../modules/packages/utility.nix
        ../../modules/packages/dev.nix
        ../../modules/packages/embedded.nix
        ../../modules/packages/graphical.nix
        ../../modules/packages/latex.nix
    ];

    environment.systempackages = with pkgs; [
        # Mac app store command line interface
        mas
    ];

    # home-manager.users.archie.home.homeDirectory = /Users/archie;
    users.users.archie.home = "/Users/archie";


}
