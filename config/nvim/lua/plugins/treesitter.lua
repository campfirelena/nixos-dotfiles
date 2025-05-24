return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup {
                highlight = {
                    enable = true,
                },
                indent = { enable = true },
                autotag = { enable = true },
                ensure_installed = {
                    "lua",
                    "nix",
                    "python",
                    "vim",
                    "vimdoc",
                },
                auto_install = false,
            }
        end
    }
}
