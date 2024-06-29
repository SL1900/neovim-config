return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            vim.cmd("TSUpdate")
            require("nvim-treesitter.install").compilers = { "zig", "gcc", "cc", "cl", "clang" }
            require("nvim-treesitter.configs").setup({
                highlight = { enable = true }
            })
        end
    }
}
