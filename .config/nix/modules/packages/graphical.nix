{ pkgs, pkgs-unstable, ...}:
{
    environment.systempackages = with pkgs; [ 
        alacritty
        openscad
        vlc-bin
        vscode
    ];
}
