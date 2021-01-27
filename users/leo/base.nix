{ config, pkgs, lib, ... }:
{
  imports = [
    <home-manager/nixos>
  ];

  users.users = {
    leo = {
      hashedPassword = "$6$RUyDB/Dhf7YYb1Ei$19sZsm9C5MS6tV2OyWS/IQM46f1S./7uBEA8avSxjNnUf.FL8hetMoT3xLmGzphluEvp9coAUcWoug5mJgeub0";
      description = "Leo Ronnebro";
      isNormalUser = true;
      extraGroups = [ "wheel" "docker" "kvm" "networkmanager" ];
      uid = 1000;
      shell = pkgs.zsh;
    };
  };

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;

  home-manager.users.leo = { pkgs, ... }: {
    #home.packages = with pkgs; [...]

    programs = {

      git = {
        enable = true;
        userName = "Leo Rönnebro";
        userEmail = "leo.ronnebro@nerdyhamster.net";

        signing = {
          key = "E7C90F51";
          signByDefault = true;
        };

        extraConfig = {
          color = {
            status = "auto";
            branch = "auto";
            ui = true;

            diff = {
              meta = "yellow";
              frag = "magenta bold";
              commit = "yellow bold";
              old = "red bold";
              new = "green bold";
              whitespace = "red reverse";
            };

            diff-highlight = {
              oldNormal = "red bold";
              oldHighlight = "red bold 52";
              newNormal = "green bold";
              newHighlight = "green bold 22";
            };

          };

          core = {
            editor = "nvim";
            pager = "diff-so-fancy | less --tabs=2 -RFXS";
          };

          diff-so-fancy = {
            changeHunkIndicators = true;
            stripLeadingSymbols = true;
            markEmptyLines = false;
          };

        };

        aliases = {
          s = "status";
          d = "diff";
          co = "checkout";
          br = "branch";
          last = "log -i HEAD";
          cane = "commit --amend --no-edit";
          lo = "log -1 HEAD";
          pr = "pull --rebase";
          cm = "commit";
          rh = "reset --hard";
          a = "add";
          aa = "add .";
          ap = "add -p";
          pu = "push";
          loa = "log --oneline --all --decorate --graph";
          patch = "!git --no-pager diff --no-color";
        };
      };

      gpg = {
        enable = true;
      };


      # Terminal
      command-not-found.enable = true;
      zsh = {
        enable = true;
        enableAutosuggestions = true;
        enableCompletion = true;
        history.ignoreSpace = true;

        initExtraFirst = "neofetch";
        envExtra = "export GPG_TTY=$(tty)";
        sessionVariables = {
            # Start blinking
            LESS_TERMCAP_mb = "$(tput bold; tput setaf 4)"; # Blue
            # Start bold
            LESS_TERMCAP_md = "$(tput bold; tput setaf 4)"; # Blue
            # Start standout
            LESS_TERMCAP_so = "$(tput bold; tput rev; tput setaf 6)"; # Cyan
            # End standout
            LESS_TERMCAP_se = "$(tput rmso; tput sgr0)";
            # Start underline
            LESS_TERMCAP_us = "$(tput smul; tput bold; tput setaf 5)"; # Magenta
            # End bold, blinking, standout, underline
            LESS_TERMCAP_me = "$(tput sgr0)";
          };



        shellAliases = {
          bc = "bc -l";
          c = "clear";
          ls = "ls -lA --color=auto";
          ping = "ping -c 5";

          vi = "nvim";
          edit = "vi";
          vis = "nvim '+set si'";

          ctrlc = "xclip -selection c";
          ctrlv = "xclip -selection c -o";
          myip = "curl http://ipecho.net/plain; echo";
          ports = "netstat -tulanp";

          cpic = "feh --bg-fill --randomize ~/Pictures/";
          connjabra = "bluetoothctl connect 70:BF:92:D1:07:D3";
          discjabra = "bluetoothctl disconnect 70:BF:92:D1:07:D3";

        };

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

      starship = {
        enable = true;
        enableZshIntegration = true;

      };

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
  };
}
