# These are the packages that I want to be on every machine I set up
{ pkgs, pkgs-unstable }:
{
    environment.systemPackages = with pkgs; [
        # Workflow
        zsh
        starship
        tmux
        neovim
        fzf
        ripgrep

        # Utility
        rsync
        htop

        # Development
        git

        # C/C++
        cmake
        ninja
        clang-tools
        libclang.python
        gcc

        # Python
        uv

        # Nix
        nil
        nixfmt
    ];
}
