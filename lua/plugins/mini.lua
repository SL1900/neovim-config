return {
    "echasnovski/mini.nvim",
    config = function()
        require("mini.ai").setup({ n_lines = 500 })
        local statusline = require("mini.statusline")
        statusline.setup({ use_icons = vim.g.have_nerd_font })
        -- statusline.section_location = function()
        --     return "%21:%-2v"
        -- end
        require("mini.notify").setup()
        require("mini.sessions").setup()
        require("mini.starter").setup()
    end
}
