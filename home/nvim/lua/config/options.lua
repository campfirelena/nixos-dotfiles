vim.g.autoformat = true

local opt = vim.opt

opt.clipboard = vim.env.SSH_TTY and "" or "unnamed"
opt.number = true

opt.autoindent = true
opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2

require("nvim-tree").setup {
  on_attach = my_on_attach,
}
vim.g.loaded_netrw = false
vim.g.loaded_netrwPlugin = false

