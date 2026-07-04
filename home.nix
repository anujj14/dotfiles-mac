{ config, pkgs, ... }: {
  
  home.stateVersion = "24.05";

#cli-tools 
  home.packages = with pkgs; [
    android-tools
    btop
    cmatrix
    fastfetch
    neovim
    pass
    tmux
    tree
    yazi
  ];

#config
  imports = [
    ./modules/aerospace.nix
    ./modules/git.nix
    ./modules/zsh.nix
    ./modules/fzf.nix
    ./modules/btop.nix
  ];

  programs.starship.enable = true;
  programs.zoxide.enable = true;

#config-apps symlinks

  home.file."Library/Application Support/com.mitchellh.ghostty/config".source = ./config/ghostty/config;

  xdg.configFile."nvim".source = ./config/nvim;

  xdg.configFile."fastfetch".source = ./config/fastfetch;

  xdg.configFile."yazi".source = ./config/yazi;

}
