{ config, pkgs, ... }: 

let
    keys = import ../../secrets/keys.nix;
in {
    imports = [
        ./hardware-configuration.nix
    ];

    networking.hostName = "archies-home-worklab"; 
    time.timeZone = "Europe/London";

    networking.networkmanager.enable = true;
    
    i18n.defaultLocale = "en_GB.UTF-8";

    i18n.extraLocaleSettings = {
        LC_ADDRESS = "en_GB.UTF-8";
        LC_IDENTIFICATION = "en_GB.UTF-8";
        LC_MEASUREMENT = "en_GB.UTF-8";
        LC_MONETARY = "en_GB.UTF-8";
        LC_NAME = "en_GB.UTF-8";
        LC_NUMERIC = "en_GB.UTF-8";
        LC_PAPER = "en_GB.UTF-8";
        LC_TELEPHONE = "en_GB.UTF-8";
        LC_TIME = "en_GB.UTF-8";
    };


    age.secrets.user-password.file = ../../secrets/user-password.age;
    users.users.archie = {
        extraGroups = [ "wheel" "networkmanager" ];
        isNormalUser = true;
        hashedPasswordFile = config.age.secrets.user-password.path;

        openssh.authorizedKeys.keys = [
            keys.defiantly
        ];
    };

    # Enable the OpenSSH daemon
    services.openssh.enable = true;

    age.secrets.wg-private.file = ../../secrets/user-password.age;
    networking.wireguard.interfaces.wg0 = {
        ips = ["10.0.0.3/24"];
        privateKeyFile = config.age.secrets.wg-private.path;
        peers = [
            { # Work gitea server
                publicKey = "yurq5BLOyxvyLfGNuTRx7LoUfwR4vkb69AmV4hGcvCc=";
                endpoint = "lakeside.sabretechnology.co.uk:51280";
                allowedIPs = ["10.0.0.1/32" "192.168.64.0/19"];
                persistentKeepalive = 25;
            }
        ];
    };
}
