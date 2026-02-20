{ pkgs, pkgs-unstable, ...}:
{
    environment.systemPackages = with pkgs; [ 
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
