return {
    {
        "rose-pine/neovim",
        config = function()
            require("rose-pine").setup({
                variant = "moon",
                extend_background_behind_borders = true,

                enable = {
                    terminal = true,
                    legacy_highlights = true,
                    migrations = true,
                },

                styles = {
                    bold = true,
                    italic = true,
                    transparency = false
                }
            })
            -- vim.cmd("colorscheme rose-pine-moon")
            -- vim.cmd.colorscheme("rose-pine")
        end
    },
    {
        "folke/tokyonight.nvim",
        config = function ()
            vim.cmd("colorscheme tokyonight-night")
        end
    }
}
