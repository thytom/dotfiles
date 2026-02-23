# System tools I would want and expect on every system I have
{ config, pkgs, ...}:
{
    environment.systemPackages = with pkgs; [
        # Shell
        zsh
        starship
        tmux

        # Text editor
        neovim

        # Finding things
        fzf
        ripgrep

        # Fast file transfer
        rsync

        # Process monitoring
        htop
        
        # Git
        git
        # Great for touching things up
        git-absorb

        # Nix
        nil
        nixfmt
    ];
}
