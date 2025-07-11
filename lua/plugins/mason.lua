return {
    {
        "mason-org/mason-lspconfig.nvim",
        config = function ()
            require("mason-lspconfig").setup();

            vim.lsp.config("lua_ls", {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" }
                        }
                    }
                }
            })
        end,
        dependencies = {
            {
                "mason-org/mason.nvim",
                opts = {},
            },
            "neovim/nvim-lspconfig",
        }
    },
}
