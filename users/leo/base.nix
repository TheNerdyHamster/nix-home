{ config, pkgs, ... }:
{
  imports = [
    ./git.nix
    ./gpg.nix
    ./zsh.nix
    ./starship
    ./golang.nix
  ];

  #programs.home-manager.enable = true;

  programs.command-not-found.enable = true;

}
