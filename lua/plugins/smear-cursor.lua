return {
    "sphamba/smear-cursor.nvim",
    opts = {
        stiffness = 0.5,
        trailing_stiffness = 0.5,
        matrix_pixel_threshold = 0.5,
        -- trailing_exponent = 2,
        -- hide_target_hack = true,
        -- gamma = 1,
    },
    config = function (win, opts)
        require("smear_cursor").setup(opts)
    end,
}
