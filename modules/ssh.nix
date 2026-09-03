{ config, pkgs, ... }:

{
  programs.ssh = {
  enable = true;
  extraConfig = ''
    Host github.com
      HostName github.com
      User git
      IdentityFile ~/.ssh/id_ed25519_github
      IdentitiesOnly yes
  '';
  };
}
