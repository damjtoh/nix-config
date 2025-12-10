{
  description = "Mac Studio Nix Configuration";

  inputs = {
    # 1. Official Nix Packages (Unstable = Bleeding Edge)
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    # 2. Nix-Darwin (MacOS System Management)
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    # 3. Home Manager (User / Dotfiles Management)
    home-manager.users.damiancrespi.home.homeDirectory = "/Users/damiancrespi";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, nix-darwin, home-manager, ... }:
  let
    # TODO: CHANGE THIS TO YOUR ACTUAL USERNAME
    user = "damiancrespi"; 
    # TODO: CHANGE THIS TO YOUR ACTUAL HOSTNAME (run `hostname -s`)
    hostname = "Damians-Mac-Studio";
    
    system = "aarch64-darwin"; # Apple Silicon
  in {
    darwinConfigurations."${hostname}" = nix-darwin.lib.darwinSystem {
      inherit system;
      modules = [
        ./darwin.nix
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${user} = import ./home.nix;
        }
      ];
    };
  };
}