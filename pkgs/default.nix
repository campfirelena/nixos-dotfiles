{...}:{
  inputs = [
    ./firefox.nix
    ./neovim.nix
    ./spicetify.nix
    ./awesome.nix
  ];

  firefox.enable = true;
  neovim.enable = true;
  awesome.enable = true;
  spicetify.enable = true;
}