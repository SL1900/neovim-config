return {
    {
        "nvim-treesitter/nvim-treesitter",
        -- build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            -- vim.cmd("TSUpdate")
            require("nvim-treesitter.install").compilers = {
                "zig",
                "gcc",
                "cc",
                "cl",
                "clang",
                "g++",
            }
            require("nvim-treesitter.configs").setup({
                highlight = { enable = true },
                ensure_installed = {
                    "c",
                    "lua",
                    "vim",
                    "vimdoc",
                    "query",
                    "markdown",
                    "markdown_inline",
                    "typescript",
                    "javascript",
                    "css",
                    "scss",
                    "html",
                    "svelte",
                    "json",
                    "yaml",
                    "cpp",
                    "glsl"
                }
            })
        end
    },
    {
        "nvim-treesitter/nvim-treesitter-context"
    }
}
