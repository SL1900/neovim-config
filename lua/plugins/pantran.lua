return {
    "potamides/pantran.nvim",
    config = function ()
        local pantran = require("pantran")
        pantran.setup({
            default_engine = "google",
            window = {
                title_border = { "<<", ">>" },
            }
        })
        vim.keymap.set("n", "<leader>tr", pantran.motion_translate, {expr=true})
        vim.keymap.set("v", "<leader>tr", pantran.motion_translate, {expr=true})
    end,
}
