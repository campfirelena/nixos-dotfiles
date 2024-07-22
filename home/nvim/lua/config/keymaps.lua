local function map(mode, one, two, fcn)
	if not key.active[keys.parse({ one, mode = mode }).id] then
		fcn = fcn or {}
		fcn.silent = fcn.silent ~= false
		vim.keymap.set(mode, one, two, fcn)
	end
end

vim.g.mapleader = " "

map("n" "<leader>pv" ":Ex")

