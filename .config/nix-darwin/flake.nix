{
    description = "Example nix-darwin system flake";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
        nixpkgs-stable.url = "github:NixOS/nixpkgs/nixpkgs-25.05-darwin";
        nix-darwin.url = "github:LnL7/nix-darwin/master";
        nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    };

    outputs = inputs@{ self, nix-darwin, nixpkgs, nixpkgs-stable }:
        let
        pkgs-stable = import nixpkgs-stable {
            system="aarch64-darwin";
            config.allowUnfree = true;
        };

        configuration = { pkgs, config, ... }: {
            nixpkgs.config.allowUnfree = true;

            users.knownUsers = ["archie"];
            users.users.archie.uid = 501;

            programs.zsh.enable = true;

            users.users.archie.shell = pkgs.zsh;

# XXX: This was added due to the removal of user-based install steps by nix-darwin.
# At some point in the future, this is probably going to be deprecated in favour of something else.
# Including the error verbatim:
#
# Failed assertions:
#       - The `system.activationScripts.postUserActivation` option has
#       been removed, as all activation now takes place as `root`. Please
#       restructure your custom activation scripts appropriately,
#       potentially using `sudo` if you need to run commands as a user.
#
#       - Previously, some nix-darwin options applied to the user running
#       `darwin-rebuild`. As part of a long‐term migration to make
#       nix-darwin focus on system‐wide activation and support first‐class
#       multi‐user setups, all system activation now runs as `root`, and
#       these options instead apply to the `system.primaryUser` user.
#
#       You currently have the following primary‐user‐requiring options set:
#
#       * `homebrew.enable`
#
#       To continue using these options, set `system.primaryUser` to the name
#       of the user you have been using to run `darwin-rebuild`. In the long
#       run, this setting will be deprecated and removed after all the
#       functionality it is relevant for has been adjusted to allow
#       specifying the relevant user separately, moved under the
#       `users.users.*` namespace, or migrated to Home Manager.
#
#       If you run into any unexpected issues with the migration, please
#       open an issue at <https://github.com/nix-darwin/nix-darwin/issues/new>
#       and include as much information as possible.
            system.primaryUser = "archie";

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
                                       python-lsp-black
                                       flake8
                                       ruff
                                       black
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
                borgbackup
                mas # Mac App Store cmdline interface

# Nix Programming Lanuages
                nil # Language server: https://github.com/oxalica/nil

# General Dev
                cmake
                ninja
                clang-tools
                libclang.python
                pkgs-stable.gcc
                
# Java
                jetbrains.idea-community-bin

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
                kitty
                vlc-bin
                pkgs-stable.openscad
                ];

            homebrew = {
                enable = true;
                onActivation.autoUpdate = true;
                onActivation.upgrade = true;

                masApps = {
                    "Whatsapp" = 310633997;
                    "Wireguard" = 1451685025;
                };
                taps = [];
                brews = [];
                casks = [ 
                    "raspberry-pi-imager"
                    "spotify"
                    "obsidian"
                    "minecraft"
                    "google-chrome"
                    "raycast"
                    "bambu-studio"
                    "microsoft-teams"
                    "microsoft-auto-update"
                    "mattermost"
                    "gqrx"
                    "disk-inventory-x"
                    "aldente"
                    "hex-fiend"
                    "stats"
                    "kicad"
                ];
            };

            fonts.packages = with pkgs; [
                nerd-fonts.go-mono
                    b612
            ];

            # system.activationScripts.postActivation.text = ''
            #     apps_source="${config.system.build.applications}/Applications"
            #     moniker="Nix Trampolines"
            #     app_target_base="$HOME/Applications"
            #     app_target="$app_target_base/$moniker"
            #     mkdir -p "$app_target"
            #     ${pkgs.rsync}/bin/rsync --archive --checksum --chmod=-w --copy-unsafe-links --delete "$apps_source/" "$app_target"
            #     '';

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
                      # TODO: Remove this once fixed
                      gcc-arm-embedded-13-local = prev.gcc-arm-embedded-13.overrideAttrs (old: {
                              patches = [ ./gcc-arm-embedded-13-info-fix.patch ]; # Custom patches
                      });
                  })
                 ];
              })
            ];
            specialArgs = {
                inherit pkgs-stable;
            };
        };
    };
}
