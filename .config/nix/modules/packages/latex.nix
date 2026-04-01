{ pkgs, pkgs-unstable, ...}:
{
    environment.systemPackages = with pkgs; [ 
        biber
        (texlive.combine {
            inherit (texlive)
                scheme-small
                
                # Fonts
                collection-fontsrecommended

                # Core LaTeX
                latex
                latexmk
                collection-latexrecommended
                collection-latexextra
                
                # Bibliography
                collection-bibtexextra

                # Bytefields
                bytefield

                # Graphics / TikZ
                pgf

                # Extra Tables
                tabularray;
        })
    ];
}
