{ self, config, pkgs, ... }:
let 
  keys = import ../../secrets/keys.nix;
in {
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = ["zfs"];
  boot.kernelPackages = pkgs.linuxPackages_6_12;
  boot.zfs.extraPools = ["media_pool"];

  age.secrets.triton-wg.file = ../../secrets/triton-wg.age;

  networking = {
    hostName = "triton";
    hostId = "c58c2ec1";
    
    networkmanager.enable = true;

    interfaces.wlp3s0.wakeOnLan.enable = true;

    wireguard.interfaces.icarus = {
      ips = ["10.34.34.3/24"];
      listenPort = 51820;

      postSetup = ''
        ${pkgs.sysctl}/bin/sysctl net.ipv4.ip_forward=1
        ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s 10.34.34.0/24 -d 192.168.1.0/24 -j MASQUERADE
      '';

      postShutdown = ''
        ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s 10.34.34.0/24 -d 192.168.1.0/24 -j MASQUERADE
      '';

      privateKeyFile = config.age.secrets.triton-wg.path;

      peers = [
        {
          publicKey = "5Wtd9bTJYRp0VsyF585ek3jWbcVVPwTpl8cF5u4T21g=";
          allowedIPs = [ "10.34.34.0/24" ];
          endpoint = "vpn.hiltons.xyz:51280";
          persistentKeepalive = 25;
        }
      ];
    };

    firewall = {
      enable = true;

      allowedUDPPorts = [
        51820
      ];
    };
  };

  time.timeZone = "Europe/London";
  console.keyMap = "uk";
  
  i18n.defaultLocale = "en_GB.UTF-8";

  users.users.archie = {
    isNormalUser = true;
    extraGroups = [ "wheel" "media" ];

    hashedPassword = "$y$j9T$qENtrzJ7YvhCgkhKZWo9t0$wR1Q2XIedL9XVY78EwCxnDYNpIC5Kcg1ykZzNPJZnL7";

    openssh.authorizedKeys.keys = [
      keys.defiantly
    ];
  };

  users.groups.media = {};

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
    docker
    docker-compose
    borgbackup
    borgmatic
    jellyfin
    jellyfin-ffmpeg
    yt-dlp
    sabnzbd
    wireguard-tools
  ];

  security.pam.services.samba.enable = true;

  services = {
    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "yes";
      };
    };

    samba = {
      enable = true;
      openFirewall = true;
      settings = {
        global = {
          workgroup = "WORKGROUP";
          "server string" = "smbnix";
          "netbios name" = "smbnix";
          security = "user";
          "guest account" = "nobody";
          "map to guest" = "bad user";
        };

        media = {
          path = "/media_pool";
          browseable = "yes";
          "read only" = "no";
          "guest ok" = "no";
          "create mask" = "0664";
          "directory mask" = "2775";
          "inherit permissions" = "yes";
        };
      };
    };

    tailscale.enable = true;

    sabnzbd = {
      enable = true;
      openFirewall = true;
    };

    jellyfin = {
      enable = true;
      openFirewall = true;
    };

    radarr = {
      enable = true;
      openFirewall = true;
    };

    sonarr = {
      enable = true;
      openFirewall = true;
    };

    lidarr = {
      enable = true;
      openFirewall = true;
    };
  };

  virtualisation.docker.enable = true;
  virtualisation.oci-containers = {
    backend = "docker";
    containers.calibre-web = {
      image = "lscr.io/linuxserver/calibre-web:latest";
      ports = ["8083:8083"];
      volumes = [
        "/var/lib/calibre-web/config:/config"
        "/media_pool/Media/Books:/books"
      ];
      environment = {
        PUID = "1000";
        PGID = "1000";
        TZ = "Europe/London";
        
        # Enable book conversion
        DOCKER_MODS = "linuxserver/mods:universal-calibre";
      };

      autoStart = true;
    };
  };

  # Swapfile
  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 16*1024;
  }];

  users.users.sabnzbd.extraGroups = ["video" "render" "media"];

  users.users.jellyfin.extraGroups = ["media"];
  users.users.radarr.extraGroups = ["media"];
  users.users.sonarr.extraGroups = ["media"];
  users.users.lidarr.extraGroups = ["media"];

  systemd.tmpfiles.rules = [
    "d /var/media 2775 root media"
  ];

  # TODO: figure this out
  services.borgmatic.enable = false; 
  services.borgmatic.settings = {
    source_directories = [
      "/var/lib/jellyfin"
      "/var/lib/sabnzbd"
      "/var/lib/radarr"
      "/var/lib/sonarr"
      "/var/lib/lidarr"
    ];

    exclude_patterns = [
      "/var/lib/sabnzbd/download"
    ];

    repositories = [
      {
        label = "BorgBase";
        path = "ssh://t2zuak0p@t2zuak0p.repo.borgbase.com/./repo";
      }
    ];

    keep_weekly = 4;
  };

  system.stateVersion = "25.05";
}
