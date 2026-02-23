{ config, lib, pkgs, modulesPath, ...}:
{
    # WARNING: If you're making a new machine, this is probably not the right
    # thing and your system will likely not work. 
    #
    # You need to rebuild this file and replace it in the repository.

    imports = [];

    boot.initrd.availableKernelModules = [ "ehci_pci" "xhci_pci" "usbhid" "sr_mod"];
    boot.initrd.kernelModules = [];
    boot.kernelModules = [];
    boot.extraModulePackages = [];

    fileSystems."/" = {
        device = "/dev/disk/by-uuid/6924a5e1-5ba4-45e4-94d7-43abbfe3a874";
        fsType = "ext4";
    };

    fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/6D42-70CD";
        fsType = "vfat";
        options = [ "fmask=0077" "dmask=0077"];
    };

    swapDevices = [
        {
            devices = "/dev/disk/by-uuid/877876c8-ed3c-4a9a-bffa-2e443e5b856e";
        }
    ]

    nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
    hardware.parallels.enable = true;
    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [ "prl-tools" ];
}
