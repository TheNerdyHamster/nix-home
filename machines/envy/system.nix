{ config, pkgs, lib, ... }:

let
  unstable = import <nixos-unstable> {};
  inherit (lib) optionals;
in
{

  boot = {
    hardwareScan = true;
    cleanTmpDir = true;
    tmpOnTmpfs = true;
    kernelPackages = pkgs.linuxPackages_latest;
  };
}
