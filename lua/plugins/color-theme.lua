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
        config = function()
            -- vim.cmd("colorscheme tokyonight-night")
        end
    },
    {
        "rebelot/kanagawa.nvim"
    },
    {
        'projekt0n/github-nvim-theme', name = 'github-theme',
    },
    {
        "sainnhe/gruvbox-material",
    },
    {
        "navarasu/onedark.nvim",
        priority = 1000,
    },
    {
        "EdenEast/nightfox.nvim",
        config = function()
            require("nightfox").setup({})
        end,
    },
    {
        "eldritch-theme/eldritch.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
    },
    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000,
        config = true,
    },
    {
        "ricardoraposo/nightwolf.nvim",
        priority = 1000,
        opts = {},
    },
}
