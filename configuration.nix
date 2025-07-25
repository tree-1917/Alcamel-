{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Africa/Cairo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ar_EG.UTF-8";
    LC_IDENTIFICATION = "ar_EG.UTF-8";
    LC_MEASUREMENT = "ar_EG.UTF-8";
    LC_MONETARY = "ar_EG.UTF-8";
    LC_NAME = "ar_EG.UTF-8";
    LC_NUMERIC = "ar_EG.UTF-8";
    LC_PAPER = "ar_EG.UTF-8";
    LC_TELEPHONE = "ar_EG.UTF-8";
    LC_TIME = "ar_EG.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

   services.xserver.windowManager.leftwm.enable = true;
   services.xserver.displayManager.lightdm.enable = true;
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us,ara";
    options = "grp:win_space_toggle";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    };

  users.users.alcamel = {
    isNormalUser = true;
    description = "alcamel";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # System Packages
  environment.systemPackages = with pkgs; [
    neovim
    wget
    brave
    git
    curl
    picom
    feh
    rofi
    dust
    htop
    polybar
    sxhkd
    dmenu
    alacritty
    rustup
    gcc
    pkg-config
    openssl
    leftwm-theme
    leftwm-config
  ];
  #----=[ Fonts ]=----#
  fonts = {
  	enableDefaultPackages = true;
 	 packages = with pkgs; [
    	ubuntu_font_family
    liberation_ttf
    # Persian Font
    vazir-fonts
  ];

  fontconfig = {
    defaultFonts = {
      serif = [  "Liberation Serif" "Vazirmatn" ];
      sansSerif = [ "Ubuntu" "Vazirmatn" ];
      monospace = [ "Ubuntu Mono" ];
    };
  };
 };

  # System Version
  system.stateVersion = "25.05";
}