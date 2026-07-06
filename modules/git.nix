{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Anuj Pokhriyal";
        email = "77380156+anujj14@users.noreply.github.com";
        signingkey = "~/.ssh/id_ed25519_signing.pub"; 
      };
      commit.gpgsign = true;
      gpg.format = "ssh";
    };
    ignores = [
      ".DS_Store"
      "**/.DS_Store"
    ];
  };
}
