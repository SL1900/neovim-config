return {
    "luckasRanarison/tailwind-tools.nvim",
    name = "tailwind-tools",
    build = ":UpdateRemotePlugins",
    opts = {},
    config = function()
        require("tailwind-tools").setup({})
    end
}
