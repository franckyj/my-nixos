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
  home.username = "zibbble";
  home.homeDirectory = "/home/zibbble";
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    # basic stuff
    btop
    brave
    starship
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
    theme = pkgs.alacritty-theme.cyber_punk_neon
    # theme = "cyber_punk_neon";
    # settings.general.import = [ pkgs.alacritty-theme.cyber_punk_neon ];
  };

  programs.helix.enable = true;

  programs.git = {
    enable = true;
    userName = "Francois Joly";
    userEmail = "joly.francois@gmail.com";
  };

  programs.starship = {
    enable = true;
  };

  home.sessionVariables = {
    EDITOR = "helix";
    BROWSER = "brave";
    TERM = "xterm-256color";
  };

  # missing zsh config
  # missing helix config

  #xdg.configFile = {
  #  "alacritty" = {
  #    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-dotfiles/config/alacritty";
  #    # recursive = true;
  #  };
  #};

  xdg.configFile."alacritty/alacritty.toml".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-dotfiles/config/alacritty/alacritty.toml";
  xdg.configFile."oxwm/config.lua".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-dotfiles/config/oxwm/config.lua";
  xdg.configFile."oxwm/.luarc.json".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-dotfiles/config/oxwm/.luarc.json";
  xdg.configFile."oxwm/colors/custom.lua".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-dotfiles/config/oxwm/colors/custom.lua";
  xdg.configFile."oxwm/colors/gruvbox.lua".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-dotfiles/config/oxwm/colors/gruvbox.lua";
  xdg.configFile."oxwm/colors/tokyonight.lua".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-dotfiles/config/oxwm/colors/tokyonight.lua";

  home.file."walls/nixos-wallpaper-1.png".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-dotfiles/walls/nixos-wallpaper-1.png";
  home.file."walls/nixos-wallpaper-2.png".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-dotfiles/walls/nixos-wallpaper-2.png";
  home.file."walls/wallpaper-1.jpg".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-dotfiles/walls/wallpaper-1.jpg";
  home.file."walls/wallpaper-2.jpg".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-dotfiles/walls/wallpaper-2.jpg";
  home.file."walls/wallpaper-3.png".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-dotfiles/walls/wallpaper-3.png";

  #xdg.configFile."alacritty".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-dotfiles/config/alacritty";

  # try and use lib.attrsets.mapAttrs' at some point
  #xdg.configFile."alacritty" = {
  #  # source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-dotfiles/config/alacritty";
  #  source = config.lib.file.mkOutOfStoreSymlink "/home/zibbble/nixos-dotfiles/config/alacritty";
  #  recursive = true;
  #};
  #home.file.".config/oxwm" = {
  #  source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-dotfiles/config/oxwm";
  #  recursive = true;
  #};

  # for some reason this doesn't work => "error installing file outside $HOME"
  #xdg.configFile = builtins.mapAttrs
  #  (name: subpath: {
  #    source = create_symlink "${dotfiles}/${subpath}";
  #    recursive = true;
  #  })
  #  configs;
}
