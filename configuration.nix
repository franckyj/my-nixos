{ config, lib, pkgs, ... }:

{
  imports =
    [
      /etc/nixos/hardware-configuration.nix
    ];

  # boot.loader.systemd-boot.enable = true;
  # boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.devices = [ "/dev/sda" ];

  hardware.cpu.intel.updateMicrocode = true;
  hardware.graphics.enable = true;

  services.pulseaudio.enable = false;

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

  programs.zsh.enable = true;
  users.users.zibbble = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      tree
      zsh
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

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  nix.gc = {
    automatic = true;
    options = "--delete-older-than 30d --max-free 10G";
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "26.05";
}
