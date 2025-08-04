{
  description = "Ellie's NixOS Config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:nix-community/stylix";
    flatpaks.url = "github:in-a-dil-emma/declarative-flatpak/stable-v3";
    nixvim.url = "github:campfirelena/nixvim";
    niri.url = "github:sodiboo/niri-flake";
  };

  outputs = {self, nixpkgs, home-manager, spicetify-nix, stylix, flatpaks, nixvim, niri, ... }@inputs:
    let
      inherit (self) outputs;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in

      # This part is inspired by sebastianrasor's flake.
      {
      nixosConfigurations = builtins.listToAttrs (
        map(
          host: with pkgs.lib; {
            name = removeSuffix ".nix" host;
            value = nixpkgs.lib.nixosSystem {
              specialArgs = { inherit inputs outputs; };
              modules = [
                home-manager.nixosModules.home-manager
                niri.nixosModules.niri
                (./hosts + ("/" + host)) # Uses the name that nixosConfiguration is focusing on
              ] ++ attrsets.attrValues self.nixosModules; 
            };
          }
        ) (builtins.attrNames (builtins.readDir ./hosts)) # Reads the directory "hosts" and uses the folder names as attribute names
      );

      homeConfigurations = with pkgs.lib; concatMapAttrs (
        hostName: usernames: builtins.listToAttrs(
          map (username: {
            name = "${username}@${hostName}";
            value = home-manager.lib.homeManagerConfiguration {
              inherit pkgs;
              extraSpecialArgs = inputs;
              modules = [
                nixvim.homeManagerModules.nixvim
                flatpaks.homeModule
                ./users/${username}/home.nix
              ];
            };
          }) usernames
        )
      )
        ( mapAttrs'(
          hostName: _:
          nameValuePair hostName (attrNames (builtins.readDir ./users))) (builtins.readDir ./hosts)
        );
    
    nixosModules = {
      flake-home-manager = home-manager.nixosModules.home-manager;
      home-manager-extra = {
        home-manager = {
          extraSpecialArgs = { inherit inputs outputs; };
        };
      };
    };
  };
}
