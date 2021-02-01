{ config, pkgs, ... }:

{

  home.packages = with pkgs; [ go go-tools gotools gopls gcc ];
}
