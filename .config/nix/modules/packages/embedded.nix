{ pkgs, pkgs-unstable, ...}:
{
    nixpkgs.overlays = [
        (final: prev: {
            # Override an existing package
            # TODO: Remove this once fixed
            gcc-arm-embedded-13-local = prev.gcc-arm-embedded-13.overrideAttrs (old: {
                patches = [ ../../gcc-arm-embedded-13-info-fix.patch ]; # Custom patches
            });
        })
    ];

    environment.systemPackages = with pkgs; [
        # AVR
        avrdude
        pkgsCross.avr.buildPackages.gcc

        # ARM Embedded
        gcc-arm-embedded-13-local

        # ESP32
        platformio
        dfu-util

        # RPi Microcontrollers
        picotool

        # USB-UART Bridges
        minicom 
    ];
}
