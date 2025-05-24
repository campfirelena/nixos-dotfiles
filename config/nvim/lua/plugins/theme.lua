local function enable_transparency()
  vim.api.nvim_set_hl(0, "Normal", { bg = "None" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "None" })
  vim.api.nvim_set_hl(0, "LineNr", { bg = "None" })
end
return {
  {
	"rebelot/kanagawa.nvim",
    config = function()
      vim.cmd.colorscheme "kanagawa"
    end,
  },
}
