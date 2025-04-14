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

            security.pam.services.sudo_local.touchIdAuth = true;

# List packages installed in system profile. To search by name, run:
# $ nix-env -qaP | grep wget
            environment.systemPackages = with pkgs; [ 
                (pkgs.stdenv.mkDerivation {
                     name = "python-clang-format";
                     src = pkgs.fetchurl {
                         url = "https://github.com/llvm/llvm-project/releases/download/llvmorg-14.0.6/clang-14.0.6.src.tar.xz";
                         sha256 = "sha256-K1hHtqYxGLnv5chVSDY8gf/glrZsOzZ16VPiY0KuQDE=";
                     };
                     sourceRoot = "clang-14.0.6.src";
                     phases = [ "unpackPhase" "installPhase" "fixupPhase" ];
                     propagatedBuildInputs = [ pkgs.python3 pkgs.clang-tools_14 ];
                     installPhase = ''
                         mkdir -p $out/bin
                         cp tools/clang-format/clang-format-diff.py $out/bin
                         cp tools/clang-format/clang-format-diff.py $out/bin/clang-format-diff
                     '';
                 })
                (python3.withPackages (ps: with ps; [
                                       pip
                                       regex
                                       requests
                                       pyserial
                                       pyserial-asyncio
                                       python-lsp-server
                                       python-lsp-ruff
                                       flake8
                                       ruff
                ]))

# Workflow
                starship
                tmux
                zsh
                neovim
                git
                git-absorb
                vscode

# Utils 
                ffmpeg
                vim
                htop
                fzf
                nmap
                ripgrep
                rsync
                borgmatic

# Nix Programming Lanuages
                nil # Language server: https://github.com/oxalica/nil

# General Dev
                cmake
                ninja
                clang-tools
                libclang.python

# AVR
                avrdude
                pkgsCross.avr.buildPackages.gcc
# ARM Embedded
                gcc-arm-embedded-13-local
                gtest
# RPi Microcontrollers
                picotool

# Graphical Applications
                alacritty
                spotify
                vlc-bin
                openscad
                ];

            homebrew = {
                enable = true;
                onActivation.cleanup = "uninstall";

                taps = [];
                brews = [];
                casks = [ 
                    "obsidian"
                    "minecraft"
                    "google-chrome"
                    "raycast"
                    "bambu-studio"
                    "microsoft-teams"
                    "microsoft-auto-update"
                    "mattermost"
                    "ibkr"
                    "gqrx"
                    "disk-inventory-x"
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
