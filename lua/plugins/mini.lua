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
        require("mini.sessions").setup({
            directory = ('%s/sessions/'):format(vim.fn.stdpath('data')),
            hooks = {
                pre = {
                    write = function ()
                        for _, win_id in ipairs(vim.api.nvim_list_wins()) do
                            local buf_id = vim.api.nvim_win_get_buf(win_id)
                            if vim.bo[buf_id].buftype ~= '' then pcall( vim.api.nvim_win_close, win_id, true ) end
                        end
                    end
                }
            }
        })
        require("mini.starter").setup()
    end
}
