{ config, pkgs, ... }:
let
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;

  configs = {
    alacritty = "alacritty";
    oxwm = "oxwm";
  };
in
{
  xdg.enable = true; # Enable XDG base directory support

  home.username = "zibbble";
  home.homeDirectory = "/home/zibbble";
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    # basic stuff
    brave
    rofi
    picom
    xwallpaper
    # development
    ripgrep
    docker
    helix
    pi-coding-agent
    zed
    tmux
    # gaming
    discord
    steam
  ];

  # programs.bash.enable = true;
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell"; # or "agnoster", "dst", etc.
      plugins = [ "git" "docker" "z" ];
    };

    shellAliases = {
      ll = "ls -la";
      update = "sudo nixos-rebuild switch";
      nrs = "sudo nixos-rebuild switch --flake ~/nixos-dotfiles#zibbble-nixos";
    };

    initContent = ''
      # Custom keybindings or extra config
      bindkey '^f' autosuggest-accept
    '';
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.alacritty = {
    enable = true;
    settings.general.import = [ pkgs.alacritty-theme.cyber_punk_neon ];
  };

  programs.helix.enable = true;

  programs.git.enable = true;

  home.sessionVariables = {
    EDITOR = "helix";
    BROWSER = "brave";
    TERM = "xterm-256color";
  };

  # missing zsh config
  # missing helix config

  xdg.configFile."alacritty".source = ./config/alacritty;
  #xdg.configFile = builtins.mapAttrs
  #  (name: subpath: {
  #    source = create_symlink "${dotfiles}/${subpath}";
  #    recursive = true;
  #  })
  #  configs;
}
