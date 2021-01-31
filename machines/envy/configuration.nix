# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    /etc/nixos/hardware-configuration.nix
    ./system.nix
    ../../users/home-manager.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        version = 2;
        efiSupport = true;
        enableCryptodisk = true;
        device = "nodev";
      };
    };

    initrd.luks.devices = {
      crypted = {
        device = "/dev/disk/by-uuid/550bfc58-c8cd-429d-8acd-341e3295263c";
        preLVM = true;
      };
    };
  };

  nix = {
    trustedUsers = [ "root" "leo" ];
    maxJobs = 8;
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  hardware = {
    cpu.intel.updateMicrocode = true;

    opengl.enable = true;
    opengl.extraPackages = with pkgs; [ vaapiIntel libvdpau-va-gl ];

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
    iproute2.enable = true;
    networkmanager.enable = true;
  };

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

  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";

  };

  time.timeZone = "Europe/Stockholm";

  virtualisation = {
    docker = {
      enable = true;
      enableOnBoot = true;
    };

    kvmgt = { enable = true; };
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  security.sudo.enable = false;
  security.doas.enable = true;
  security.doas.extraRules = [
    {
      groups = [ "wheel" ];
      keepEnv = true;
      persist = true;
    }
  ];
  # Configure keymap in X11
  services = {
    xserver = {
      enable = true;
      layout = "us,se";
      xkbOptions = "eurosign:e";
      displayManager.startx.enable = true;
      windowManager = { spectrwm.enable = true; };

      #falsevideoDrivers = [ "nvidia" ];

      # Enable touchpad support
      libinput.enable = true;
    };

    printing.enable = true;

    openssh.enable = true;

    tlp.enable = true;

    sysstat.enable = true;

    mullvad-vpn.enable = true;

    locate = {
      enable = true;
      interval = "hourly";
    };

  };

  nixpkgs.config = {
    allowUnfree = true;

    manual.manpages.enable = true;
  };

  programs.steam.enable = true;
  services.yubikey-agent.enable = true;
  services.pcscd.enable = true;

  system = {
    autoUpgrade = {
      # enable = true;
      # dates = "20:30";
      # flake = "github:TheNerdyHamster/nix-home";
      # flags = [ "--update-input nixpkgs" "--no-write-lock-file" ];
    };
  };
  # Enable sound.
  sound.enable = true;

  # Enable Redshift.
  services.redshift = {
    enable = true;
    brightness = {
      day = "1";
      night = "0.80";
    };
    temperature = {
      day = 6500;
      night = 3500;
    };
  };
  location.provider = "geoclue2";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Commandline
    wget
    mkpasswd
    unzip
    zip
    feh
    diff-so-fancy
    autorandr
    pinentry

    dmenu
    neofetch
    picom

    docker-compose
    nodejs
    ruby
    yarn
    python3
    ansible
    # Terminal applications
    nerdfonts
    neovim
    kitty
    minecraft
    mullvad-vpn
    spotify
    openfortivpn
    openssl
    opensc
    jq

    # Programming

    # Browsers
    firefox
    brave
    discord
    slack
    betterlockscreen
  ];

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.03"; # Did you read the comment?

}

