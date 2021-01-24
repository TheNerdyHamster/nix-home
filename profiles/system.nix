{ config, pkgs, lib, ... }:

let
  unstable = import <nixos-unstable> {};
  inherit (lib) optionals;
in
{

  imports = [
    ../users/leo/base.nix
  ];

  boot = {
    hardwareScan = true;
    cleanTmpDir = true;
    tmpOnTmpfs = true;
    kernelPackages = pkgs.linuxPackages_latest;
  };
}
