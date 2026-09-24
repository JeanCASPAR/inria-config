# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./disk-config.nix
    ];

  # Bootloader
  boot.loader = {
    grub = {
      enable = true;
      efiSupport = true;
      efiInstallAsRemovable = true;
      device = "nodev";
    };
    timeout = 10;
  };

  networking.hostName = "jcaspar-pro"; # Define your hostname.
  # Enable networking
  networking.networkmanager.enable = true;
  networking.networkmanager.plugins = with pkgs; [
    networkmanager-openconnect
    networkmanager-openvpn
  ];

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Select internationalisation properties.
  i18n.defaultLocale = "fr_FR.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "fr";
    # useXkbConfig = true; # use xkb.options in tty. (broken if combined with k>
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    xkb = {
      layout = "fr";
      variant = "afnor";
    };
  };

  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  
  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Thunderbolt
  services.hardware.bolt.enable = true;

  # Enable bluetooth.
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };

  # Enable sound with pipewire.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };  

  # Fix text overlap in LibreOffice
  fonts.fontconfig.useEmbeddedBitmaps = true;
  fonts.packages = with pkgs; [
    helvetica-neue-lt-std
    carlito
    font-awesome
    powerline-fonts
    libertinus
    stix-two
  ] ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);

  # Config nix.
  nix = {
    settings.auto-optimise-store = true;
    package = pkgs.nixVersions.stable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # Enable unfree packages
  nixpkgs.config.allowUnfree = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jcaspar = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ]; # Enable ‘sudo’ for the user.
    packages = [];
  };

  # programs.firefox.enable = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    file gparted
    wget python3 firefox
    man-pages man-pages-posix
  ];

  # Use Wayland in Electron
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Install documentation
  documentation.dev.enable = true;
  documentation.man.cache.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this p>
  # and is used to maintain compatibility with application data (e.g. databases>
  #
  # Most users should NEVER change this value after the initial install, for an>
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pul>
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/>
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your sy>
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes>
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manu>
  system.stateVersion = "26.11"; # Did you read the comment?
}
