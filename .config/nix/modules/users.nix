{ pkgs, ...}:
{
    users.knownUsers = [ "archie" ];

    users.users.archie = {
        uid = 501;
        shell = pkgs.zsh;
    };

    system.primaryUser = "archie";

    programs.zsh.enable = true;
}
