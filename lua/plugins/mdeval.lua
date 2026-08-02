return {
    "jubnzv/mdeval.nvim",
    config = function ()
        require("mdeval").setup({
            allowed_file_types = { "lua" },
            eval_options = {
                lua = {
                    command = "nvim",
                    args = { "--headless", "-c", "source", "-c", "q" },
                },
            },
        })

        vim.g.markdown_fenced_languages = { "lua" }
    end
}
