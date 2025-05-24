{ config, lib, ... }:{
options = {
  nixvim.enable = lib.mkEnableOption "";
};

config = lib.mkIf config.nixvim.enable {
  programs.nixvim = { 
    plugins = {
      lightline = { 
        enable = true;
      };
    };
    colorschemes = {
      gruvbox.enable = true;
    };
    opts = {
      number = true;
      relativenumber = true;

      shiftwidth = 2;
    };
  };
};
}
