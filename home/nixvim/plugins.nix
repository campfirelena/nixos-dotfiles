{ ... }:{
programs.nixvim = {
    plugins = {
        lualine = { 
            enable = true;
            settings = {
                settings.options:disabled_filetypes = 
                let
                disabled = [
                    "NvimTree"
                    "NVimTree"
                    "NvimTree_1"
                    "toggleterm"
                ];
                in
                {
                    statusline = disabled;
                    winbar = disabled;
                };
            };
        };

        nvim-tree.enable = true;
    };
}
}