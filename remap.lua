vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("x", "<leader>p", "\"_dP")

if package.config:sub(1, 1) == "\\" then
    vim.keymap.set("n", "<leader>oe", ":!explorer .<CR><CR>", { desc = "[O]pen [E]xplorer in current working directory" })
    vim.keymap.set("n", "<leader>ot", ":!wt -w 0 nt -d .<CR><CR>",
        { desc = "[O]pen Windows [T]erminal in current working directory" })
    vim.keymap.set("n", "<leader>oce", function()
        local path = vim.api.nvim_buf_get_name(0)
        local dir = path:sub(1, path:find('\\[^\\]*$'))
        -- vim.cmd(":!echo " .. "(path:sub(1, path:find('\\[^\\]*$')))" .. "<CR><CR>")
        -- print("Check "..dir)
        os.execute("explorer " .. dir)
    end, { desc = "[O]pen [C]urrent buffer [Explorer]" })
end

-- Telescope
local builtin = require("telescope.builtin")
if builtin then
    vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
    vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
    vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
    vim.keymap.set("n", "<leader>sc", builtin.commands, { desc = "[S]earch [C]ommands" })
    vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
    vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
    vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
    vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
    vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
    vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = "[S]earch Recent Files ('.' for repeat)" })
    vim.keymap.set("n", "<leader>bc", ":Telescope file_browser path=%:p:h select_buffer=true<CR>", { noremap = true })
    vim.keymap.set("n", "<leader>fb", ":Telescope file_browser path=. select_buffer=true<CR>", { noremap = true })
    vim.keymap.set("n", "<leader>bb", builtin.buffers, { noremap = true })
    vim.keymap.set("n", "<leader>/", builtin.current_buffer_fuzzy_find, { desc = "[/] Fuzzily search in curent buffer" })
    vim.keymap.set("n", "<leader>s/", function()
            builtin.live_grep({
                grep_open_files = true,
                prompt_title = "Live Grep in Open Files"
            })
        end,
        { desc = "[S]earch [/] in Open files" }
    )
    vim.keymap.set("n", "<leader>sn", function()
            builtin.find_files({ cwd = vim.fn.expand("$XDG_CONFIG_HOME") .. "/nvim/" })
        end,
        { desc = "[S]earch [N]eovim files" }
    )

    vim.api.nvim_create_autocmd("FileType", {
        pattern = { "markdown" },
        callback = function()
            vim.schedule(function()
                vim.keymap.set("n", "gd", function()
                    require("telescope.builtin").grep_string({ search = vim.call("expand", "<cword>") })
                end, { desc = "Grep search word under cursor" })
            end)
        end
    })
end

--LSP
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", function()
    vim.diagnostic.jump({ count = -1, float = true })
end)
vim.keymap.set("n", "]d", function()
    vim.diagnostic.jump({ count = 1, float = true })
end)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

--Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end
})

--ToggleTerm
-- vim.keymap.set("n", "<C-t>", ":execute v:count1 . \"ToggleTerm\"<CR>")
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

--Trouble
-- local trouble = require("trouble")
-- vim.keymap.set("n", "<leader>xx", function() trouble.toggle("workspace_diagnostics") end, { desc = "Toggle Trouble" })
-- vim.keymap.set("n", "<leader>xq", function() trouble.toggle("quickfix") end, { desc = "Toggle [Q]uickfix list" })
-- vim.keymap.set("n", "<leader>xl", function() trouble.toggle("loclist") end, { desc = "Toggle [L]oc list" })
--

vim.keymap.set("n", "<leader>to", ":tabnew<CR>", { desc = "[T]ab [O]pen" })
vim.keymap.set("n", "<leader>tc", ":tabclose<CR>", { desc = "[T]ab [C]lose" })
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "qf" },
    callback = function()
        vim.schedule(function()
            vim.keymap.set("n", "q", ":q<cr>", { desc = "Close current QuickFix buffer" })
            vim.keymap.set("n", "<Escape>", ":q<cr>", { desc = "Close current QuickFix buffer" })
            vim.keymap.set("n", "<leader><CR>", "<C-w><Enter><C-w>L", { desc = "Open quick fix element in vertical split" })
        end)
    end
})
