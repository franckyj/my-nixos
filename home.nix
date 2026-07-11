{ config, pkgs, ... }:
{
  home.username = "zibbble";
  home.homeDirectory = "/home/zibbble";
  home.stateVersion = "26.05";

  # home.packages = with pkgs; [ helix alacritty ];

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
      ll = "ls -l";
      update = "sudo nixos-rebuild switch";
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
  # missing alacritty config
  # missing helix config
}
