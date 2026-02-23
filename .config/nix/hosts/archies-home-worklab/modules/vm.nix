{ config, pkgs, ...}:
{
    # Settings specific to getting the vm in a nice state and not the homelab

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    boot.kernelPackages = pkgs.linuxPackages_latest;

    services.xserver = {
        enable = true;

        displayManager.lightdm.enable = true;
        desktopManager.xfce.enable = true;

        xkb = {
            layout = "gb";
            variant = "";
        };
    };

    console.keyMap = "uk";

    programs.firefox.enable = true;

    system.stateVersion = "25.11";
}
