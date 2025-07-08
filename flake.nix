{
  description = "Ellie's NixOS Config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #disko.url = "github:nix-community/disko";
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:nix-community/stylix";
    flatpaks.url = "github:in-a-dil-emma/declarative-flatpak/stable-v3";
    nixvim.url = "github:campfirelena/nixvim";
    niri.url = "github:sodiboo/niri-flake";
  };

  outputs = {self, nixpkgs, home-manager, spicetify-nix, flatpaks, nixvim, niri, ... }@inputs:
  let
    inherit (self) outputs;
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
                    specialArgs = { inherit inputs outputs; };
                    modules = [
                      niri.nixosModules.niri
                        (./hosts + ("/" + nixosConfiguration)) # Uses the name that nixosConfiguration is focusing on
                    ] ++ attrsets.attrValues self.nixosModules;
                };
            }
        ) (builtins.attrNames (builtins.readDir ./hosts)) # Reads the directory "hosts" and uses the folder names as attribute names
    );

    homeConfigurations = with pkgs.lib; concatMapAttrs (
      hostName: usernames: builtins.listToAttrs(
        map (username: {
            name = username + "@" hostName;
            value = home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                extraSpecialArgs = inputs // {
                    inherit inputs outputs;
                    inherit (config.networking) hostName;
                };
                modules = [
                  flatpaks.homeModule.declarative-flatpak
                  nixvim.homeManagerModules.nixvim
		              ./users/${username}/home.nix
		            ] ++ attrsets.attrValues self.homeModules;
            };
        })
	usernames
      )
    )
    ( mapAttrs'(
	    hostName: _:
	    nameValuePair hostName (attrNames (builtins.readDir ./users))) (builtins.readDir ./hosts)
    );

    # Imports all system-based modules as nixosModules
    nixosModules = with pkgs.lib; attrsets.mapAttrs' (
      name: _:
      attrsets.nameValuePair (removeSuffix ".nix" name) (import (./modules + ("/" + name)))) ( builtins.readDir ./modules)
    // {
      flake-home-manager = home-manager.nixosModules.home-manager;
      home-manager-extra = {
	      home-manager = {
	        extraSpecialArgs = { inherit inputs outputs; };
	        sharedModules = attrsets.attrValues self.homeModules;
	      };
	    };
    };
     # Imports all user-based modules as homeModules into home manager
    homeModules = with pkgs.lib; attrsets.mapAttrs' (
      name: _:
      attrsets.nameValuePair (removeSuffix ".nix" name) (import (./home + ("/" + name)))) ( builtins.readDir ./home);
 };
}
