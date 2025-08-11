return {
    "nvimdev/lspsaga.nvim",
    enabled = true,
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
    },
    config = function ()
        require("lspsaga").setup({
            lightbulb = { enable = false },
        })

        vim.lsp.buf.hover = function ()
            vim.cmd("Lspsaga hover_doc")
        end
    end
}
