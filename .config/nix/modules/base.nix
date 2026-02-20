{ self, ...}:
{
    nixpkgs.config.allowUnfree = true;

    security.pam.services.sudo_local.touchIdAuth = true;

    nix.settings.experimental-features = "nix-command flakes";

    system.configurationRevision = self.rev or self.dirtyRev or null;
    system.stateVersion = 5;

    nixpkgs.hostPlatform = "aarch64-darwin";
}
