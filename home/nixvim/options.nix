{ config, lib, pkgs , ... }:{
programs.nixvim = {
    opts = {
        number = true;
        relativenumber = true;
        tabstop = 2;
        shiftwidth = 2;
        cursorline = true;
        autoindent = true;
        expandtab = true;
    };
    globals = {
        mapleader = " ";
    };
};
}
