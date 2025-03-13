{
  description = "Ellie's NixOS Config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    disko.url = "github:nix-community/disko";
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = {self, nixpkgs, nixpkgs-unstable, home-manager, disko, hyprland, ... }@inputs:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in

  # This part is heavily inspired by sebastianrasor's flake. Eventually I will change this to make it more different and as my own as possible.
  {
    nixosConfigurations = builtins.listToAttrs (
        map(
            nixosConfiguration: with pkgs.lib; {
                name = ;
                value = nixpkgs.lib.nixosSystem = {
                    specialArgs = {inherit inputs hyprland disko};
                    modules = [
                        (./hosts + ("/" + nixosConfiguration))
                    ] ++ attrsets.attrValues self.nixosModules;
                };
            }
        ) (builtins.attrNames (builtins.readDir ./hosts))
    );

    homeConfigurations = with pkgs.lib; concatMapAttrs (
        map (username: {
            name = username + "@" hostname;
            value = home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                extraSpecialArgs = {
                    inherit inputs hyprland;
                    inherit username hostname;
                };
                modules = [ ./users/${username}/home.nix] ++ attrsets.attrValues self.homeModules;
            };
        })
    )
    homeModules = with pkgs.lib; attrsets.mapAttrs (
        name: _:
        attrsets.nameValuePair (removeSuffix ".nix" name) (import (./pkgs + ("/" + name))) ( builtins.readDir ./pkgs)
    )

    nixosModules = with pkgs.lib; attrsets.mapAttrs (
        name: _:
        attrsets.nameValuePair (removeSuffix ".nix" name) (import (./modules + ("/" + name))) ( builtins.readDir ./modules)
    // {
        home-manager-extra = {
            home-manager = {
                extraSpecialArgs = { inherit inputs };
                sharedModules = attrsets.attrValues self.homeModules;
            };
        };
    })
  }
}