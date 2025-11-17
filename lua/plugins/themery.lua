return {
    "zaldih/themery.nvim",
    -- lazy = true,
    config = function()
        local colors = vim.fn.getcompletion("", "color")
        local themes = {}
        for k,v in ipairs(colors) do
            table.insert(themes, v)
        end
        require("themery").setup({
            themes = themes,
            livePreview = true,
        })
    end,
}
