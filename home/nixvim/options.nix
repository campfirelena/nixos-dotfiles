{ config, lib, pkgs , ... }:{
programs.nixvim = {
    globalOpts = {
      # numbers on the side :3
        number = true;
        relativenumber = true;
      # 2 spaces per tab PLEASE
        tabstop = 2;
        shiftwidth = 2;
      # apparently these are good?
        cursorline = true;
        autoindent = true;
        expandtab = true;
      # how nvim handles split windows
        splitright = true;
        splitbelow = true;
      # scroll a few lines before the bottom
        scrolloff = 5;
    };
    globals.mapleader = " ";
};
}
