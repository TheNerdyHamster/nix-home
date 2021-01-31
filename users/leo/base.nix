{ config, pkgs, ... }:
{
  imports = [
    ./git.nix
    ./gpg.nix
    ./zsh.nix
    ./starship
  ];

  #programs.home-manager.enable = true;

  programs.command-not-found.enable = true;

}
