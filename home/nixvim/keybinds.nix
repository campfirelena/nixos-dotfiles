{ ... }:{
programs.nixvim = {
    mappings = [
        key = "<C-j>";
        action = "<C-w>j";
        mode = "n";
        options.desc = "Window down";
    ];
};
}
