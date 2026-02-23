{ pkgs, pkgs-unstable, ...}:
{
    environment.systempackages = with pkgs; [ 
        # Utils 
        ffmpeg

        # Backups
        borgmatic
        borgbackup
    ];
}
