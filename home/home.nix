{ inputs, pkgs, username, homeDirectory, hostname, ... }:
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

  home.packages = with pkgs; [
  # Essentials for every user
    btop
    nerdfonts
    unzip
    keepassxc
    bitwarden
    ];

  # Running without bash would be stupid
  programs.bash.enable = true;
  programs.bash.enableCompletion = true;
}
