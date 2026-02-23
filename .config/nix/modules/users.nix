{ pkgs, ...}:
{
    users.users.archie = {
        shell = pkgs.zsh;
    };

    programs.zsh.enable = true;
}
