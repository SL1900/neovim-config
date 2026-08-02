return {
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        branch = "main",
        build = ":TSUpdate",
        config = function()
            -- vim.api.nvim_create_autocmd("BufReadPost", {
            --     pattern = "*",
            --     callback = function ()
            --         vim.treesitter.start()
            --     end
            -- })
            -- vim.cmd("TSUpdate")
            vim.api.nvim_create_autocmd("FileType", {
                group = vim.api.nvim_create_augroup("LazyTreesitterHighlight", { clear = true, }),
                pattern = "*",
                callback = function (args)
                    local lang = vim.treesitter.language.get_lang(args.match)

                    if not lang or not vim.treesitter.language.add(lang) then
                        return
                    end

                    vim.treesitter.start(args.buf)
                end
            })
            require("nvim-treesitter.install").compilers = {
                "zig",
                "gcc",
                "cc",
                "cl",
                "clang",
                "g++",
            }
            require("nvim-treesitter").setup({
                highlight = { enable = true },
            })
            require("nvim-treesitter").install({
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
                "html",
                "svelte",
                "json",
                "yaml",
                "cpp",
            })
        end
    },
    {
        "nvim-treesitter/nvim-treesitter-context"
    }
}
