{ ... }:
{ #This is anything that needs to run at root level
  imports = [
    ./nixos/configuration.nix
    ./xorg
  ];
}
