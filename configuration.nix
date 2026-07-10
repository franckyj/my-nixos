{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # boot.loader.systemd-boot.enable = true;
  # boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;

  hardware.cpu.intel.updateMicrocode = true;
  hardware.opengl.enable = true;
  hardware.sound.enable = true;
  hardware.pulseaudio.enable = true;

  networking.hostName = "zibbble-nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "America/Toronto";

  services.displayManager.ly.enable = true;
  services.xserver = {
    enable = true;
    autoRepeatDelay = 200;
    autoRepeatInterval = 35;
    # we're using oxwm
    # windowManager.qtile.enable = true;
  };

  users.users.zibbble = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      tree
    ];
    shell = pkgs.zsh;
  };

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    vim
    wget
    docker
    alacritty
    git
    brave
    helix
    discord
    steam
    pi-coding-agent
    zed
  ];

  nixpkgs.overlays = [ alacritty-theme.overlays.default ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  nix.gc = {
    automatic = true;
    automaticOptions = "--delete-older-than 30d --max-free 10G";
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "26.05";
}
