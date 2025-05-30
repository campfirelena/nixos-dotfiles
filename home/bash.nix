{ config, lib, pkgs, ... }:{
options = {
  userModules.bash.enable = lib.mkEnableOption "";
};
config = lib.mkIf config.userModules.bash.enable {
  programs.bash = {
    enable = true;
    shellAliases = {
      nrs = "sudo nixos-rebuild switch --flake .";
      nrt = "sudo nixos-rebuild test --flake .";
      btw = "echo I use nixos btw";
    };
    initExtra = ''
      export PS1='\[\e[95;1m\]\u\[\e[0m\] in \[\e[96m\]\W\[\e[0m\] > '
      fastfetch
    '';
    enableCompletion = true;
  };
  home.packages = with pkgs; [
    bat
    fastfetch
  ];
};
}
