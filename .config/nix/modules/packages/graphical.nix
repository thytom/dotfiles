{ pkgs, pkgs-unstable, ...}:
{
    environment.systemPackages = with pkgs; [ 
        alacritty
        openscad
        vlc-bin
        vscode
    ];
}
