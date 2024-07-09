return {
    {
        "folke/trouble.nvim",
        config = function()
            vim.keymap.set("n", "<leader>xx", function()
                trouble.toggle("workspace_diagnostics") 
            end, { desc = "Toggle Trouble" })
            vim.keymap.set("n", "<leader>xq", function()
                trouble.toggle("quickfix")
            end, { desc = "Toggle [Q]uickfix list" })
            vim.keymap.set("n", "<leader>xl", function()
                trouble.toggle("loclist")
            end, { desc = "Toggle [L]oc list" })
        end,
        opts = {
        }
    },
}
