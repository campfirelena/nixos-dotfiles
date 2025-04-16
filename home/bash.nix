{ config, lib, ... }:{
options = {
  bash.enable = lib.mkEnableOption "";
};
config = lib.mkIf config.bash.enable {
  programs.bash = {
    enable = true;
    shellAliases = {
      nrs = "sudo nixos-rebuild switch --flake .";
      btw = "echo I use nixos btw";
    };
    initExtra = ''
      export PS1='\[\e[95;1m\]\u\[\e[0m\] in \[\e[96m\]\W\[\e[0m\] > '
      fastfetch
    '';
    enableCompletion = true;
    sessionVariables = ''
    '';
  };
  home.packages = with pkgs; [
    bat
    fastfetch
  ];
};
}