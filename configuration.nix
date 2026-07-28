{ config, lib, pkgs, ... }:
let
  scientifica-nerd = pkgs.stdenvNoCC.mkDerivation {
    name = "scientifica-nerd";

    nativeBuildInputs = [ pkgs.nerd-font-patcher ];

    dontUnpack = true;

    installPhase = ''
      mkdir -p $out/share/fonts/truetype

      cp ${pkgs.scientifica}/share/fonts/truetype/*.ttf .

      for f in *.ttf; do
        nerd-font-patcher \
          --complete \
          --outputdir $out/share/fonts/truetype \
          "$f"
      done
    '';
  };
in
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
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true; # Enables PulseAudio emulation
  };

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
    extraGroups = [ "wheel" "docker" "audio" ];
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
    file
    vim
    wget
    zsh
    git
    bat
    btop
    brave
    stow
    fzf
    zoxide
    eza
    atuin
    direnv
    alacritty
    starship
    rofi
    picom
    feh
    libnotify
    dunst
    lxqt.lxqt-policykit
    thunar
    pavucontrol
    pulsemixer
    pamixer
    wireplumber
    xfce4-power-manager
    flameshot
    xdotool
    fastfetch
    rofi-bluetooth
    scientifica
    # rofi-network-manager
    # rofi-power-menu
    # rofi-rbw
    # development
    helix
    dotnet-sdk_10
    ripgrep
    docker
    vscode
    pi-coding-agent
    zed
    tmux
    # gaming
    discord
    steam
  ];

  services.xserver.windowManager.oxwm.enable = true;

  security.polkit.enable = true;

  programs.zsh.enable = true;
  programs.git.enable = true;
  programs.zoxide.enable = true;
  programs.atuin.enable = true;
  programs.direnv.enable = true;
  programs.thunar.enable = true;
  virtualisation.docker.enable = true;
  programs.starship.enable = true;
  programs.vscode.enable = true;
  programs.tmux.enable = true;
  programs.steam.enable = true;

  fonts = {
    enableDefaultPackages = true; # Installs basic fonts for Unicode coverage
    fontDir.enable = true;

    packages = with pkgs; [
      noto-fonts
      liberation_ttf
      fira-code
      nerd-fonts.jetbrains-mono
      nerd-fonts.fira-code
      scientifica-nerd
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

  system.stateVersion = "26.05";
}
