{ config, pkgs, ... }:

{
  users.users = {
    leo = {
      hashedPassword = "$6$RUyDB/Dhf7YYb1Ei$19sZsm9C5MS6tV2OyWS/IQM46f1S./7uBEA8avSxjNnUf.FL8hetMoT3xLmGzphluEvp9coAUcWoug5mJgeub0";
      description = "Leo Ronnebro";
      isNormalUser = true;
      extraGroups = [ "wheel" "docker" "kvm" "networkmanager" "libvirtd" ];
      uid = 1000;
      shell = pkgs.zsh;
    };
  };
}
