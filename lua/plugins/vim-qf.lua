return {
    "romainl/vim-qf",
    config = function()
        vim.g.qf_auto_resize = 0

        local qf_group = vim.api.nvim_create_augroup("vimqf_quickfix_autocommands", { clear = true })
        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "qf" },
            callback = function()
                vim.api.nvim_buf_set_keymap(0, "n", "dd", ":Reject<cr>", { desc = "Close current QuickFix buffer" })
            end,
            group = qf_group
        })
    end,
}
