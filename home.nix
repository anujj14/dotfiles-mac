{ config, pkgs, ... }: {
  
  home.stateVersion = "26.05";

#cli-tools 
  home.packages = with pkgs; [
    android-tools
    cmatrix
    fastfetch
    pass
    tmux
    tree
    yazi
    ghostty-bin
    zed-editor
    localsend
    ice-bar
    iina
    image_optim
  ];

#config
  imports = [
    ./modules/aerospace.nix
    ./modules/nvim.nix
    ./modules/git.nix
    ./modules/zsh.nix
    ./modules/fzf.nix
    ./modules/btop.nix
  ];

  programs.starship.enable = true;
  programs.zoxide.enable = true;

#config-apps symlinks

  home.file."Library/Application Support/com.mitchellh.ghostty/config".source = ./config/ghostty/config;

  xdg.configFile."fastfetch".source = ./config/fastfetch;

  xdg.configFile."yazi".source = ./config/yazi;

}
