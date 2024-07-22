local function map(mode, lhs, rhs, opts)
	opts = opts or {}
	vim.keymap.set(mode, lhs, rhs, opts)
end

vim.g.mapleader = " "

map("n", "<leader>pv", vim.cmd.Ex) 
