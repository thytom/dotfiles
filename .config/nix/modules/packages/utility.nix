{ pkgs, pkgs-unstable, ...}:
{
    environment.systemPackages = with pkgs; [ 
        # Utils 
        ffmpeg

        # Backups
        borgmatic
        borgbackup
    ];
}
