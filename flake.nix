{
  description = "Kyle's flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    nixos-wsl = { url = "github:nix-community/nixos-wsl"; };

    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.inputs.nixpkgs.follows = "nixpkgs";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew, home-manager, nixos-wsl }: {
    darwinConfigurations."macos" = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      specialArgs = { inherit inputs; };
      modules = [ 
        ./darwin
        nix-homebrew.darwinModules.nix-homebrew
        home-manager.darwinModules.home-manager
        {
          users.users.kyle = {
            name = "kyle";
            home = "/Users/kyle";
          };

          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = { inherit inputs; };
            users.kyle = { config, pkgs, ... }: {
              imports = [ ./home ];
              home = {
                username = "kyle";
                homeDirectory = "/Users/kyle";
              };
            };
          };
        }
      ];
    };

    nixosConfigurations."wsl" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./wsl
        nixos-wsl.nixosModules.wsl
        home-manager.nixosModules.home-manager
        {
          users.users.kyle = {
            name = "kyle";
            home = "/home/kyle";
          };

          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = { inherit inputs; };
            users.kyle = { config, pkgs, ... }: {
              imports = [ ./home ];
              home = {
                username = "kyle";
                homeDirectory = "/home/kyle";
              };
            };
          };
        }
      ];
    };
  };
}
