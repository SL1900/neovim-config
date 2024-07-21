return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            vim.cmd("TSUpdate")
            require("nvim-treesitter.install").compilers = { "zig", "gcc", "cc", "cl", "clang" }
            require("nvim-treesitter.configs").setup({
                highlight = { enable = true },
                ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "typescript", "javascript", "css", "scss", "html", "svelte", "json", "yaml" }
            })
        end
    }
}
