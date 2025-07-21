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
        opts = {
            extensions = {
                undo = {}
            }
        },
        config = function(_, opts)
            require("telescope").setup(opts)
            require("telescope").load_extension("undo")
        end
    }
}
