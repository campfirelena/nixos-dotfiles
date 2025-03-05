{ inputs, pkgs, username, homeDirectory, ... }:
{
  imports = [
    ../pkgs
    ./elena
    ./river
  ];

  home = {
    inherit username;
    stateVersion = "24.11";
    sessionPath = [ "$HOME/.local/bin" ];
    homeDirectory = pkgs.lib.mkDefault "/home/${username}";
  };
  ${username}.enable = true;

  #Turn modules on and off for each user
  nvim.enable = true;

  home.packages = with pkgs; [
  # Essentials
    btop
    nerdfonts
    unzip
    
  # Optional Stuff
    fastfetch
    keepassxc
    ];

  programs.bash.enable = true;
  programs.bash.enableCompletion = true;
  

}
