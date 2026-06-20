{ config, pkgs, ... }:
{
  home.username = "zibbble";
  home.homeDirectory = "/home/zibbble";

  home.packages = with pkgs; [ helix alacritty ];

  # programs.bash.enable = true;
  programs.zsh.enable = true;
  programs.alacritty.enable = true;
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
