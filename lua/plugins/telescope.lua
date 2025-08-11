return {
    {
        "nvim-telescope/telescope.nvim",
        config = function()
            require("telescope").setup({
                pickers = {
                    find_files = {
                        hidden = true
                    },
                    buffers = {
                        layout_strategy = "vertical",
                        layout_config = {
                            width = 0.75,
                        },
                        mappings = {
                            i = {
                                ["<c-d>"] = "delete_buffer",
                            },
                            n = {
                                ["dd"] = "delete_buffer",
                            },
                        },
                    },
                    live_grep = {
                        layout_strategy = "vertical",
                        layout_config = {
                            width = 0.75,
                        },
                    },
                    current_buffer_fuzzy_find = {
                        layout_strategy = "vertical",
                        layout_config = {
                            width = 0.75,
                        },
                    },
                },
                extensions = {
                    file_browser = {
                        hijack_netrw = true,
                        grouped = true,
                    },
                },
            })
        end
    },
    {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim"
        },
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build =
        "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
        opts = {
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                },
            }
        },
        config = function(_, opts)
            require("telescope").setup(opts)
            pcall(require("telescope").load_extension, "fzf")
        end
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
        opts = {
            extensions = {
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown(),
                }
            }
        },
        config = function(_, opts)
            require("telescope").setup(opts)
            require("telescope").load_extension("ui-select")
        end
    },
    {
        "debugloop/telescope-undo.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = {
            {
                "<leader>u",
                "<cmd>Telescope undo<cr>",
                desc = "[u]ndo history"
            }
        },
        opts = {
            extensions = {
                undo = {}
            }
        },
        config = function(_, opts)
            require("telescope").setup(opts)
            require("telescope").load_extension("undo")
        end
    },
    {
        "nvim-telescope/telescope-live-grep-args.nvim",
        config = function()
            local lga_actions = require("telescope-live-grep-args.actions")
            require("telescope").setup({
                extensions = {
                    live_grep_args = {
                        auto_quoting = true,
                        mappings = {
                            i = {
                                ["<C-k>"] = lga_actions.quote_prompt(),
                                ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob "}),
                                ["<C-space>"] = lga_actions.to_fuzzy_refine,
                            }
                        }
                    }
                }
            })
            require("telescope").load_extension("live_grep_args")
            vim.keymap.set("n", "<leader>fg", ":lua require(\"telescope\").extensions.live_grep_args.live_grep_args()<CR>")
        end
    },
}
