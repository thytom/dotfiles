{ pkgs, pkgs-unstable, ...}:
{
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
            autopep8
        ]))

        # Workflow
        starship
        tmux
        zsh
        neovim
        git
        git-absorb
        tea # Gitea CLI
        vscode
        uv # Fast python manager
        pre-commit # Framework for pre-commit hooks

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
        minicom # USB-UART Bridges

        # Nix Programming Lanuages
        nil # Language server: https://github.com/oxalica/nil
        nixfmt # Formatter

        # General Dev
        cmake
        ninja
        clang-tools
        libclang.python
        gcc

        dfu-util

        hugo # Static Site Generator

        # Documentation/Text
        texliveFull # Required for proper LaTeX

        # Java
        zulu # OpenJDK build
        jetbrains.idea-community-bin

        # AVR
        avrdude
        pkgsCross.avr.buildPackages.gcc
        # ARM Embedded
        gcc-arm-embedded-13-local
        gtest
        # ESP32
        platformio
        # RPi Microcontrollers
        picotool

        # Graphical Applications
        alacritty
        kitty
        vlc-bin
        openscad
    ];
}
