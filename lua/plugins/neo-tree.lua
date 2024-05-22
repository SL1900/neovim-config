return {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim"
    },
    cmd = "Neotree",
    keys = {
        { "\\", ":Neotree reveal<CR>", { desc = "Neotree reveal" }},
    },
    opts = {
        filesystem = {
            window = {
                mappings = {
                    ["\\"] = "close_window",
                }
            }
        }
    },
}
