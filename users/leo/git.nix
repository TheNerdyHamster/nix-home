{ config, pkgs, ... }:

let
  name = "Leo Rönnebro";
  email = "leo.ronnebro@nerdyhamster.net";
  gpgKey = "E7C90F51";
in
{
  programs.git = {
    enable = true;
    userName = "${name}";
    userEmail = "${email}";

    signing = {
      key = "${gpgKey}";
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
}
