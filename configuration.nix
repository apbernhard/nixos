# check: configuration.nix(5) man page
# and NixOS manual (run ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      <nixos-hardware/lenovo/thinkpad/x220>
      ./hardware-configuration.nix
      ./home.nix
    ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;

  # Networking
  networking.networkmanager.enable = true;
  networking.hostName = "trudix"; # Define your hostname.

  # Time zone
  time.timeZone = "Europe/Berlin";

  # Internationalisation
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Sound configuration 
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # mainUser
  users.users.mainUser = {
    name = "dertrudi";
    isNormalUser = true;
    description = "dertrudi";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" ];
  };

  # Allow unfree packages
  nixpkgs.config = {
    allowUnfree = true;
  };
  # Activate vi shortcuts in bash
  programs.bash.interactiveShellInit = "set -o vi";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs;
    [
      firefox
      vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      wget
    ];


  ########################################
  # Services
  # 
  # X11 windowing system.
  # Enable the OpenSSH server.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # NixOS release 
  system.stateVersion = "23.05";

}
