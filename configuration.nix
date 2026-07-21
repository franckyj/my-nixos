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
  };

  users.users.zibbble = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ];
    packages = with pkgs; [
      tree
      zsh
    ];
    shell = pkgs.zsh;
  };

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    # display manager
    oxwm
    # basic stuff
    vim
    wget
    zsh
    git
    btop
    brave
    stow
    fzf
    zoxide
    eza
    atuin
    direnv
    alacritty
    ghostty
    starship
    helix
    rofi
    picom
    feh
    # development
    dotnet-sdk_10
    ripgrep
    docker
    vscode
    helix
    pi-coding-agent
    zed
    tmux
    # gaming
    discord
    steam
  ];

  services.xserver.windowManager.oxwm.enable = true;

  programs.zsh.enable = true;
  programs.git.enable = true;
  programs.zoxide.enable = true;
  programs.atuin.enable = true;
  programs.direnv.enable = true;
  virtualisation.docker.enable = true;
  programs.starship.enable = true;
  programs.vscode.enable = true;
  programs.tmux.enable = true;
  programs.steam.enable = true;

  fonts = {
    enableDefaultPackages = true; # Installs basic fonts for Unicode coverage
    packages = with pkgs; [
      noto-fonts
      liberation_ttf
      fira-code
      nerd-fonts.jetbrains-mono
      nerd-fonts.fira-code
    ];
  };

  environment.sessionVariables = {
    EDITOR = "helix";
    BROWSER = "brave";
    TERM = "xterm-256color";

    DOTNET_ROOT = "${pkgs.dotnet-sdk}/share/dotnet";
  };

  nix.gc = {
    automatic = true;
    options = "--delete-older-than 30d --max-free 10G";
  };

  #nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "26.05";
}
