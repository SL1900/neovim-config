return {
    {
        "nvim-telescope/telescope.nvim",
        config = function ()
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
                },
                extensions = {
                    file_browser = {
                        hijack_netrw = true,
                        grouped = true,
                    },
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = "smart_case",
                    },
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown(),
                    },
                },
            })
            pcall(require("telescope").load_extension, "fzf")
            pcall(require("telescope").load_extension, "ui-select")
        end
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
    },
    { "nvim-telescope/telescope-ui-select.nvim" },
}
