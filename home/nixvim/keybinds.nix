{ ... }:{
programs.nixvim = {
    mappings = [
      {
        key = "<C-j>";
        action = "<C-w>j";
        mode = "n";
        options.desc = "Window down";
      }
      {
        key = "<C-h>";
        action = "<C-w>h";
        mode = "n";
        options.desc = "Window left";
      }
      {
        key = "<C-k>";
        action = "<C-w>k";
        mode = "n";
        options.desc = "Window up";
      }
      {
        key = "<C-l>";
        action = "<C-w>l";
        mode = "n";
        options.desc = "Window right";
      }
    ];
};
}
