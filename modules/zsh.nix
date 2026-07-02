{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    history = {
      path = "$HOME/.zsh_history";
      size = 50000;
      save = 50000;
      ignoreDups = true;
      ignoreSpace = true;
      shareHistory = true; 
    };
    initContent = ''
      eval "$(/opt/homebrew/bin/brew shellenv)"
    '';
  };
}
