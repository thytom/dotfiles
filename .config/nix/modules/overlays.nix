{ ... }:
{
    nixpkgs.overlays = [
        (final: prev: {
            # Override an existing package
            # TODO: Remove this once fixed
            gcc-arm-embedded-13-local = prev.gcc-arm-embedded-13.overrideAttrs (old: {
                patches = [ ../gcc-arm-embedded-13-info-fix.patch ]; # Custom patches
            });
        })
    ];
}
