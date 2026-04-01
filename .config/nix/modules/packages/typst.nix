{ pkgs, pkgs-unstable, ...}:
{
  environment.systemPackages = with pkgs; [ 
    typst
    tinymist
  ];
}
