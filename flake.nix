{
  description = "macbook-air-m1";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    darwin.url = "github:LnL7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-homebrew, darwin, nixpkgs, home-manager }:
  let 
    username = "anujpokhriyal";
  in {
    darwinConfigurations."anuj-macbook" = darwin.lib.darwinSystem {
      specialArgs = { inherit username; };
      modules = [
        nix-homebrew.darwinModules.nix-homebrew
        ./darwin.nix
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          
          home-manager.backupFileExtension = "bak";

          home-manager.users.${username} = import ./home.nix;
        }
      ];
    };
  };
}
