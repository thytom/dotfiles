{ config, pkgs, ... }: 

let
    keys = import ../../secrets/keys.nix;
in {
    networking.hostName = "archies-home-worklab"; 
    time.timeZone = "Europe/London";
    services.xserver.layout = "uk";


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
        privateKeyfile = config.age.secrets.wg-private.path;
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
