{ config, pkgs, lib, ... }:
{
  imports = [
      <home-manager/nixos>
  ];

  users.users = {
    leo = {
      hashedPassword =
        "$6$RUyDB/Dhf7YYb1Ei$19sZsm9C5MS6tV2OyWS/IQM46f1S./7uBEA8avSxjNnUf.FL8hetMoT3xLmGzphluEvp9coAUcWoug5mJgeub0";
      description = "Leo Ronnebro";
      isNormalUser = true;
      extraGroups = [ "wheel" "docker" "kvm" "networkmanager" ];
      uid = 1000;
      shell = pkgs.zsh;
    };
  };

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;

  home-manager.users.davidk = { pkgs, ... }: {
    #home.packages = with pkgs; [...]

    programs = {
      zsh = {
        enable = true;
        enableAutosuggestions = true;
        enableCompletion = true;
        cdpath = true;
        ignoreSpace = true;

        initExtraFirst = "neofetch";

        plugins = [
          {
            name = "zsh";
            src = pkgs.fetchFromGitHub {
              owner = "MichaelAquilina";
              repo = "zsh-you-should-use";
              rev = "b4aec740f23d195116d1fddec91d67b5e9c2c5c7";
              sha256 = "WCltJcamURZymBegL+wNjRBzZWy1OblWY6CcKU0rAS8=";
              fetchSubmodules = true;
            };
          }
        ];

        oh-my-zsh = {
          enable = true;
          plugins = [ "git" "sudo" "ssh-agent" ];
        };
      };

    };
  };
}
