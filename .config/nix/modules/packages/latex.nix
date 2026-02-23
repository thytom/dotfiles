{ pkgs, pkgs-unstable, ...}:
{
    environment.systempackages = with pkgs; [ 
        latexmk
        biber
        (texlive.combine {
            inherit (texlive)
                scheme-small
                
                # Fonts
                lmodern
                
                # Core LaTeX
                latex
                latexrecommended
                latexextra
                
                # Bibliography
                bibtexextra

                # Graphics / TikZ
                pgf

                # Extra Tables
                tabularray;
        })
    ];
}
