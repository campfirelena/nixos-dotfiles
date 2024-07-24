local telescope = require("telescope.builtin")
local api = require("nvim-tree.api")
local harpoon = require("harpoon")
local map = vim.keymap.set

vim.mapleader = " "

-- 1 NAVIGATION OUTSIDE FILES
map("n", "<leader>pv", vim.cmd.q)
map("n", "<leader>pf", telescope.find_files)
map("n", "<leader>gf", telescope.git_files)
map("n", "<leader>rg", telescope.live_grep)

-- 2 NAVIGATION INSIDE FILES

-- 3 FILE MANIPULATION
map("n", "<leader>pw", vim.cmd.w)

-- NVIM TREE
function my_on_attach(bufnr)
  local api = require("nvim-tree.api")

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  vim.keymap.set('n', 'n', api.fs.create, opts('New File or Directory (use \\ for directory)'))
  vim.keymap.set('n', '?',     api.tree.toggle_help, opts('Help'))
end

