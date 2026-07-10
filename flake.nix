{
  description = "my nixos";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    oxwm = {
      url = "github:tonybanters/oxwm";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    alacritty-theme = {
      url = "github:alexghr/alacritty-theme.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = input@{ self, nixpkgs, home-manager, oxwm, alacritty-theme, ... }: {
    nixosConfigurations.zibbble-nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        ({ config, pkgs, ...}: {
          # install the overlay
          nixpkgs.overlays = [ alacritty-theme.overlays.default ];
        })
        #oxwm.nixosModules.default
        #{
        #  services.xserver = {
        #    # enable = true;
        #    # windowManager.oxwm.enable = true;
        #  };
        #}
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.zibbble = import ./home.nix;
            backupFileExtension = "backup";
          };
        }
      ];
    };
  };
}
