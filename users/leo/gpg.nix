{ config, pkgs, ... }:

{

  programs.gpg = {
    enable = true;
  };

  services = {
    gpg-agent = {
      enable = true;
      enableSshSupport = true;

      defaultCacheTtl = 28800;
      maxCacheTtl = 28800;

      defaultCacheTtlSsh = 28800;
      maxCacheTtlSsh = 28800;
    };
  };
}
