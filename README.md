# nixos-dotfiles

The folders have specific purposes. 

Config holds all the stuff that would be symlinked into $HOME/.config/ 

Hosts are the machines that will run on this config. To add a machine, just add a folder and a short config to turn the modules on and off. 

systemModules are program-specific configs for the system level. The hosts directory links here.

Users is all the users that can be on any machine. To add a user, add a folder and default.nix and home.nix. 

