return {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
        -- add any options here
    },
    dependencies = {
        "MunifTanjim/nui.nvim",
    },
    config = function()
        require("noice").setup({
            routes = {
                {
                    view = "notify",
                    filter = {
                        event = "msg_show",
                        kind = {
                            "shell_out",
                            "shell_err",
                        }
                    },
                },
            },
            notify = {
                enabled = true,
                view = "mini",
            },
            history = {
                view = "split",
                opts = { enter = true, format = "details" },
                filter = {
                    any = {
                        { event = "notify" },
                        { event = "msg_show" },
                        { error = true },
                        { warning = true },
                    },
                },
            },
            telescope = {
                enabled = true,
            },
            -- views = {
            --     notify = {
            --         backend = "mini",
            --     },
            -- },
            lsp = {
                -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
            },
            presets = {
                bottom_search = true,
                command_palette = true,
                long_message_to_split = true,
                inc_rename = false,
                lsp_doc_border = true,
            },
        })
    end
}
