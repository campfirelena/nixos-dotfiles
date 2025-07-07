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
      vi = "nvim";
      svi = "sudo vi";
      ping = "ping -c 10";
      cls = "clear";
      cp = "cp -i";
      mv = "mv -i";
      mkdir = "mkdir -p";
    };
    initExtra = ''
      fastfetch
      eval "$(starship init bash)"
    '';
    enableCompletion = true;
  };
  home.packages = with pkgs; [
    bat
    fastfetch
    starship
  ];
};
}
