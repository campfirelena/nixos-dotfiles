vim.g.autoformat = true

local opt = vim.opt

opt.clipboard = vim.env.SSH_TTY and "" or "unnamed"
opt.number = true

vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

require("nvim-tree").setup({
	filters = {
		dotfiles = true,
	},
	on_attach = my_on_attach,
})
vim.g.loaded_netrw = false
vim.g.loaded_netrwPlugin = false


