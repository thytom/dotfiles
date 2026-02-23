{ ... }:
{
    homebrew = {
        enable = true;
        onActivation.autoUpdate = true;
        onActivation.upgrade = true;

        masApps = {
            "Whatsapp" = 310633997;
            "Wireguard" = 1451685025;
        };
        taps = [];
        brews = [];
        casks = [ 
            "raspberry-pi-imager"
            "obsidian"
            "prismlauncher"
            "google-chrome"
            "raycast"
            "bambu-studio"
            "microsoft-teams"
            "microsoft-auto-update"
            "gqrx"
            "disk-inventory-x"
            "aldente"
            "hex-fiend"
            "stats"
            "kicad"
            "blender"
            "brave-browser"
        ];
    };
}
