return {
    "sheimer/tint.nvim",
    opts = {
        tint = -5,
        saturation = 0.6,
        tint_background_colors = true,
    },
    config = function (_, opts)
        require("tint").setup(opts)
    end,
}
