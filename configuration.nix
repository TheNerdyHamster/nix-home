
# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  unstableTarball =
		fetchTarball
			https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz;
in
{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot = {
  	loader = {
		  systemd-boot.enable = true;
 		  efi.canTouchEfiVariables = true;
	  };

 	  #boot.loader.grub.devices = "/dev/by-name";
	  hardwareScan = true;
    cleanTmpDir = true;
    tmpOnTmpfs = true;
    #kernelPackages = pkgs.linuxPackages;
  };


  nix = {
    trustedUsers = ["root" "leo"];
    maxJobs = 8;
    package = pkgs.nixUnstable;
  };

  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: {
      unstable = import unstableTarball {
        config = config.nixpkgs.config;
      };
    };
  };

  hardware = {
  	cpu.intel.updateMicrocode = true;

    pulseaudio = {
      enable = true;
      support32Bit = true;
      package = pkgs.pulseaudioFull;
      tcp.enable = true;
      tcp.anonymousClients.allowAll = true;
    };

    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };

  };

  networking = {
  	hostName = "tnh-laptop"; # Define your hostname.
  	wireless.enable = true;
  };

  programs = {
  	command-not-found.enable = true;
    zsh = {
      enable = true;
      shellInit = "neofetch";
      ohMyZsh = {
        enable = true;
      };
    };

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

  };

  time.timeZone = "Europe/Stockholm";

  virtualisation = {
  	docker = {
      enable = true;
      enableOnBoot = true;
    };

    kvmgt = {
      enable = true;
    };
  };


  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp1s0.useDHCP = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Configure keymap in X11
  services = {
  	xserver = {
      enable = false;
      layout = "us";
      xkbOptions = "eurosign:e";
      desktopManager = {
        mate.enable = true;
      };
      windowManager = {
        dwm.enable = true;
      };

      videoDrivers = ["nvidia"];

      # Enable touchpad support
      libinput.enable = true;
    };

    printing.enable = true;

  	openssh.enable = true;

    tlp.enable = true;

    sysstat.enable = true;

    locate = {
      enable = true;
      interval = "hourly";
    };

  };

  system = {
    autoUpgrade = {
      enable = true;
      dates = "20:30";
      flake =  "github:TheNerdyHamster/nix-config";
      flags = [
        "--update-input nixpkgs"
        "--no-write-lock-file"
      ];
    };
  };
  # Enable sound.
  sound.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users = {
  	leo = {
      hashedPassword = "$6$RUyDB/Dhf7YYb1Ei$19sZsm9C5MS6tV2OyWS/IQM46f1S./7uBEA8avSxjNnUf.FL8hetMoT3xLmGzphluEvp9coAUcWoug5mJgeub0";
      description = "Leo Ronnebro";
  		isNormalUser = true;
   		extraGroups = [ "wheel" "docker" "kvm" ];
  		uid = 1000;
  		shell = pkgs.zsh;
  	};
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  # Commandline
    wget
    mkpasswd
    git
    feh
    xorg.xkill
    xorg.xrandr
    xorg.xinit
    xorg.xauth
    neofetch
    picom
  # Terminal applications
    neovim
    kitty
  # Programming

  # Browsers
    firefox
    brave
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?

}

