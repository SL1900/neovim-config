return {
    {
        "nvim-telescope/telescope.nvim",
        config = function()
            local actions = require("telescope.actions")
            local action_state = require("telescope.actions.state")
            local function multi_split(prompt_bufnr, mode)
                local picker = action_state.get_current_picker(prompt_bufnr)
                local multi_selection = picker:get_multi_selection()

                -- print(#multi_selection)
                if #multi_selection > 1 then
                    actions.close(prompt_bufnr)
                    for i, entry in ipairs(multi_selection) do
                        local split_command = mode == "v" and "vsplit" or "split"
                        local command = (i == 1) and "edit" or split_command

                        local path = entry.path or entry.filename
                        local row = entry.lnum or 1
                        local col = entry.col or 1

                        vim.cmd(string.format("%s +%d %s", command, row, path))
                        vim.api.nvim_win_set_cursor(0, { row, col - 1 })
                    end
                else
                    actions.file_vsplit(prompt_bufnr)
                end
            end
            require("telescope").setup({
                defaults = {
                    cache_picker = {
                        num_pickers = 100,
                    },
                },
                pickers = {
                    find_files = {
                        hidden = true,
                        sorter = require("telescope.sorters").get_fuzzy_file(),
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
                        mappings = {
                            i = {
                                ["<C-q>"] = actions.smart_send_to_loclist + actions.open_loclist,
                                ["<C-v>"] = function (bufnr) multi_split(bufnr, "v") end,
                                ["<C-s>"] = function (bufnr) multi_split(bufnr, "s") end,
                            },
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
                    case_mode = "ignore_case",
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
                        layout_strategy = "vertical",
                        layout_config = {
                            width = 0.75,
                        },
                        auto_quoting = true,
                        mappings = {
                            i = {
                                ["<C-k>"] = lga_actions.quote_prompt(),
                                ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
                                ["<C-space>"] = lga_actions.to_fuzzy_refine,
                            }
                        }
                    }
                }
            })
            require("telescope").load_extension("live_grep_args")
            vim.keymap.set("n", "<leader>fg",
                ":lua require(\"telescope\").extensions.live_grep_args.live_grep_args()<CR>")
        end
    },
    {
        "fdschmidt93/telescope-egrepify.nvim",
        config = function()
            require("telescope").load_extension("egrepify")
        end
    }
}
