return {
    "echasnovski/mini.nvim",
    config = function()
        require("mini.ai").setup({
            n_lines = 500,
            -- custom_textobjects = {
            --     n = require('mini.ai').gen_spec.treesitter({
            --         a = { "@block.outer", "@conditional.outer", "@loop.outer", "@function.outer", "@class.outer" },
            --         i = { "@block.inner", "@conditional.inner", "@loop.inner", "@function.inner", "@class.inner" },
            --     })
            -- }
        })
        local statusline = require("mini.statusline")
        statusline.setup({ use_icons = vim.g.have_nerd_font })
        -- statusline.section_location = function()
        --     return "%21:%-2v"
        -- end
        require("mini.notify").setup({
            lsp_progress = { enable = false },
        })
        require("mini.sessions").setup({
            directory = ('%s/sessions/'):format(vim.fn.stdpath('data')),
            hooks = {
                pre = {
                    write = function()
                        for _, win_id in ipairs(vim.api.nvim_list_wins()) do
                            local buf_id = vim.api.nvim_win_get_buf(win_id)
                            if vim.bo[buf_id].buftype ~= '' then pcall(vim.api.nvim_win_close, win_id, true) end
                        end
                    end
                }
            }
        })
        vim.keymap.set("n", "<leader>ws", function()
            vim.ui.input({ prompt = "Enter session name: " }, function(input)
                if input and input ~= "" then
                    require("mini.sessions").write(input)
                else
                    print("Session name is required.")
                end
            end)
        end, { desc = "[w]rite [s]ession with custom name" })
        vim.keymap.set("n", "<leader>os", function()
            local sessions = require("mini.sessions").detected
            local list = {}
            for _, session_details in pairs(sessions) do
                list[#list + 1] = session_details
            end
            table.sort(list, function(a, b)
                return a.modify_time > b.modify_time
            end)

            local current_session = vim.fn.fnamemodify(vim.v.this_session, ":t:r")
            print("Current session: " .. current_session)

            vim.ui.select(list, {
                prompt = "Select session to open",
                format_item = function(item)
                    return string.format("%-40s | %s", item.name, os.date("%Y-%m-%d %H:%M:%S", item.modify_time))
                end
            }, function(choice)
                if choice and choice ~= "" then
                    if current_session and current_session ~= "" then
                        require("mini.sessions").write(current_session)
                    end
                    require("mini.sessions").read(choice.name)
                else
                    print("Session was not selected")
                end
            end)
        end, { desc = "[o]pen [s]ession" })
        vim.keymap.set("n", "<leader>ds", function()
            local sessions = require("mini.sessions").detected
            local list = {}
            for k, _ in pairs(sessions) do list[#list + 1] = k end

            vim.ui.select(list, { prompt = "Select session to delete" }, function(choice)
                if choice and choice ~= "" then
                    require("mini.sessions").delete(choice)
                else
                    print("Session was not selected")
                end
            end)
        end, { desc = "[d]elete [s]ession" })
        require("mini.starter").setup()
        vim.opt.sessionoptions:remove('blank')

        require("mini.align").setup()
    end
}
