
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

        # C/C++
        cmake
        ninja
        clang-tools
        libclang.python
        gcc

        # Rust
        rustup

        # Python
        uv

        # Gitea CLI
        tea 

        # Framework for pre-commit hooks
        pre-commit 

        # Java
        zulu # OpenJDK build
        jetbrains.idea-community-bin

        # Static Site Generator
        hugo

        gtest
    ];
}
