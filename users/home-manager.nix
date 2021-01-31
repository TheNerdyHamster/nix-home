{ config, pkgs, ... }:

{
  imports = [ <home-manager/nixos> ];


  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;

  home-manager.users.leo = (import ./leo/base.nix);
}
