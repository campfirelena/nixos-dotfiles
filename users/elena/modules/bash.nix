{ pkgs, ... }:{
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
  ];
    programs.starship = {
      enable = true;
    settings = {
      add_newline = false;
      format = "$nix_shell$git_status| $username@$hostname in $directory > ";
        username = {
          show_always = true;
          style_user = "bold yellow";
          format = "[$user]($style)";
        };
        hostname = {
          ssh_only = false;
          style = "bold green";
          format = "[$ssh_symbol$hostname]($style)";
        };
    };
      };
      programs.zoxide = {
        enable = true;
        enableBashIntegration = true;
      };
}
