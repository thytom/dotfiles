{ self, config, pkgs, ...}:
{
    nixpkgs.config.allowUnfree = true;

    nix.settings.experimental-features = "nix-command flakes";

    environment.systemPackages = with pkgs; [
        # Nix
        nil
        nixfmt
    ];

    system.configurationRevision = self.rev or self.dirtyRev or null;
}
