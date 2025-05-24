vim.g.autoformat = true

local opt = vim.opt

opt.clipboard = vim.env.SSH_TTY and "" or "unnamed"
opt.number = true
opt.cursorline = true
opt.relativenumber = true

opt.autoindent = true
opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2

vim.g.loaded_netrw = false
vim.g.loaded_netrwPlugin = false

