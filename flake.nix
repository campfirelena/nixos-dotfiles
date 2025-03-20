{
  description = "Ellie's NixOS Config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    #disko.url = "github:nix-community/disko";
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = {self, nixpkgs, nixpkgs-unstable, home-manager, hyprland, ... }@inputs:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in

  # This part is heavily inspired by sebastianrasor's flake. Eventually I will change this to make it more different and as my own as possible.
  {
    nixosConfigurations = builtins.listToAttrs (
        map(
            nixosConfiguration: with pkgs.lib; {
                name = removeSuffix ".nix" nixosConfiguration;
                value = nixpkgs.lib.nixosSystem {
                    specialArgs = inputs // { inherit inputs; };
                    modules = [
                        (./hosts + ("/" + nixosConfiguration)) # Uses the name that nixosConfiguration is focusing on
                    ] ++ attrsets.attrValues self.nixosModules;
                };
            }
        ) (builtins.attrNames (builtins.readDir ./hosts)) # Reads the directory "hosts" and uses the folder names as attribute names
    );

    homeConfigurations = with pkgs.lib; concatMapAttrs (
      hostname:usernames: builtins.listToAttrs(
        map (username: {
            name = username + "@" hostname;
            value = home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                extraSpecialArgs = inputs // {
                    inherit inputs;
                    inherit username hostname;
                };
                modules = [ 
		./users/${username}/home.nix
		./modules/home-manager.nix
		] ++ attrsets.attrValues self.homeModules;
            };
        })
	usernames
      )
      )
      (
        mapAttrs'(
	  hostName: _:
	    nameValuePair hostName (attrNames (builtins.readDir ./users))) (builtins.readDir ./hosts)
      );

    # Imports all user-based modules as homeModules into home manager
    homeModules = with pkgs.lib; attrsets.mapAttrs' (
        name: _:
        attrsets.nameValuePair (removeSuffix ".nix" name) (import (./home + ("/" + name))) ( builtins.readDir ./home)
    );

    # Imports all system-based modules as nixosModules
    nixosModules = with pkgs.lib; attrsets.mapAttrs' (
        name: _:
        attrsets.nameValuePair (removeSuffix ".nix" name) (import (./modules + ("/" + name)))) ( builtins.readDir ./modules)
    // {
        flake-home-manager = home-manager.nixosModules.home-manager;
        home-manager-extra = {
	  home-manager = {
	    extraSpecialArgs = inputs // { inherit inputs; };
	    #sharedModules = attrsets.attrValues self.homeModules;
	  };
	};
    };
  };
}
