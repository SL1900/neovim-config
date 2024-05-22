return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            vim.cmd("TSUpdate")
            require("nvim-treesitter.configs").setup({
                highlight = { enable = true }
            })
        end
    }
}
