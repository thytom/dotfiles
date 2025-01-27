{
    description = "Example nix-darwin system flake";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
        nix-darwin.url = "github:LnL7/nix-darwin/master";
        nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    };

    outputs = inputs@{ self, nix-darwin, nixpkgs }:
        let
        configuration = { pkgs, config, ... }: {
            nixpkgs.config.allowUnfree = true;

            security.pam.enableSudoTouchIdAuth = true;

# List packages installed in system profile. To search by name, run:
# $ nix-env -qaP | grep wget
            environment.systemPackages = with pkgs; [ 
                (python3.withPackages (ps: with ps; [
                                       pip
                                       regex
                                       requests
                                       pyserial
                                       pyserial-asyncio
                                       python-lsp-server
                                       python-lsp-ruff
                ]))

# Workflow
                starship
                tmux
                zsh
                neovim

# Utils 
                ffmpeg
                vim
                htop
                fzf
                nmap
                ripgrep
                rsync

# Nix Programming Lanuages
                nil # Language server: https://github.com/oxalica/nil

# General Dev
                cmake
                ninja

# AVR
                avrdude
                pkgsCross.avr.buildPackages.gcc
# ARM Embedded
                gcc-arm-embedded-13-local

# Graphical Applications
                alacritty
                spotify
                vlc-bin
                ];

            homebrew = {
                enable = true;
#onActivation.cleanup = "uninstall";

                taps = [];
                brews = [];
                casks = [ 
                    "thunderbird" 
                    "obsidian"
                    "minecraft"
                    "google-chrome"
                ];
            };

            fonts.packages = with pkgs; [
                nerd-fonts.go-mono
                    b612
            ];

            system.activationScripts.postUserActivation.text = ''
                apps_source="${config.system.build.applications}/Applications"
                moniker="Nix Trampolines"
                app_target_base="$HOME/Applications"
                app_target="$app_target_base/$moniker"
                mkdir -p "$app_target"
                ${pkgs.rsync}/bin/rsync --archive --checksum --chmod=-w --copy-unsafe-links --delete "$apps_source/" "$app_target"
                '';

# Necessary for using flakes on this system.
            nix.settings.experimental-features = "nix-command flakes";

# Enable alternative shell support in nix-darwin.
# programs.fish.enable = true;

# Set Git commit hash for darwin-version.
            system.configurationRevision = self.rev or self.dirtyRev or null;

# Used for backwards compatibility, please read the changelog before changing.
# $ darwin-rebuild changelog
            system.stateVersion = 5;

# The platform the configuration will be used on.
            nixpkgs.hostPlatform = "aarch64-darwin";
        };
    in
    {
# Build darwin flake using:
# $ darwin-rebuild build --flake .#defiantly
        darwinConfigurations."defiantly" = nix-darwin.lib.darwinSystem {
            modules = [ 
                configuration 
                ({ pkgs, ... }: {
                  # Package overrides using overlays
                 nixpkgs.overlays = [
                 (final: prev: {
                      # Override an existing package
                      gcc-arm-embedded-13-local = prev.gcc-arm-embedded-13.overrideAttrs (old: {
                              patches = [ ./gcc-arm-embedded-13-info-fix.patch ]; # Custom patches
                      });
                  })
                 ];
              })
            ];
        };
    };
}
