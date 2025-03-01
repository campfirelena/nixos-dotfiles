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
    inherit (nixpkgs.lib) nixosSystem;
    supportedSystems = [
      "x86_64-linux"
      "x86_64-darwin"
      "aarch64-linux"
      "aarch64-darwin"
    ];

    # Helper function to generate an attrset '{ x86_64-linux = f "x86_64-linux"; ... }'.
    forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

    # Nixpkgs chooses the system type
    nixpkgsFor = forAllSystems (system: import nixpkgs { inherit system; });
    
    # Function to create nixosConfigurations
    createNixosConfiguration = {
      system,
      username,
      homeDirectory,
      hostname ? null,
      modules ? [],
      includeHomeManager ? true,
    }:
    nixosSystem {
      inherit system;
        specialArgs = {
          inherit
            inputs
            hyprland
            disko
            ;
          inherit username homeDirectory hostname;
    };
    modules = [
      ./hosts/${hostname}/configuration.nix
    ] ++ (
    if includeHomeManager then
      [ home-manager.nixosModules.home-manager {
        home-manager = {
          useUserPackages = true;
          useGlobalPackages = false;
          extraSpecialArgs = {
            inherit
            inputs
            disko
            nixpkgs
            ;
          };
          users."${username}" = import ./home/home.nix {
            inputs = inputs;
            pkgs = nixpkgsFor."${system}";
            inherit username homeDirectory;
        };
        };
      }
      ]
    else
    []
    )
    ++ modules;
  };
    #make other users
    createHomeManagerConfiguration = {
      system,
      username,
      homeDirectory,
      stateVersion ? "24.11",
      modules ? [],
    }:
    home-manager.lib.homeManagerConfiguration {
      extraSpecialArgs = {
        inherit inputs hyprland;
        inherit username homeDirectory stateVersion;
      };
      pkgs = nixpkgsFor."${system}";
      modules = [
        ./home/${username}/home.nix
        { home = {
          username = username;
          homeDirectory = homeDirectory;
          stateVersion = stateVersion;
        };}
      ] ++ modules;
    };
in
  {
    nixosConfigurations = {
      desktop = createNixosConfiguration {
        system = "x86_64-linux";
        hostname = "desktop";
        username = "elena";
        homeDirectory = "/home/elena";
        modules = [
          hyprland.nixosModules.default
        ];
      };
      server = createNixosConfiguration {
        system = "x86_64-linux";
        hostname = "server";
        username = "elena";
        homeDirectory = "home/elena";
        modules = [ ];
      };
    };

    homeConfigurations = {
      "elena" = createHomeManagerConfiguration {
        system = "x86_64-linux";
        username = "elena";
        homeDirectory = "/home/elena";
        stateVersion = "24.11";
        modules = [];
      };
    };
};
}
