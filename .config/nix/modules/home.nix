{ pkgs, ...}:
{
    home-manager.useGlobalPkgs = true;

    home-manager.users.archie = {
        home.stateVersion = "25.11";

        home.file.".config/nvim" = {
            source = ../../nvim;
            recursive = true;
        };

        home.file.".tmux.conf" = {
            source = ../../../.tmux.conf;
            recursive = true;
        };
    };
}
