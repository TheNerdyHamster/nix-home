{ config, pkgs, ... }:

{
  programs.zsh = {
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
      sudo = "doas"; # The reason behind this is becuase of the sudo plugin for Oh-My-ZSH
      bc = "bc -l";
      c = "clear";
      ls = "ls -l --color=auto";
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
}
