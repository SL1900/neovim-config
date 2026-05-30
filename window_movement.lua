local window_picker = require("window-picker")

local M = {}

M.setup = function ()
    vim.api.nvim_create_user_command(
        "WindowMove",
        function ()
            M.run()
        end,
        { desc = "Move window close to another one" }
    )
    vim.keymap.set("n", "<C-w>m", M.run, { desc = "Move window"})
end

local function OpenActionSelectionWindow(target_win_id)
    local buf = vim.api.nvim_create_buf(false, true)

    local lines = {
        "",
        "Select direction to attach current buffer to",
        "K/↑ - Up   ",
        "J/↓ - Down ",
        "H/← - Left ",
        "L/→ - Right",
    }
    local max_width = 0
    for _,value in ipairs(lines) do
        if max_width < #value then
            max_width = #value
        end
    end
    max_width = max_width + 2
    for index,value in ipairs(lines) do
        lines[index] = string.rep(" ", max_width / 2 - math.floor(#value / 2)) .. value
    end

    local window_size = {
        width = max_width,
        height = #lines + 1,
    }

    local opts = {
        relative = "editor",
        width = window_size.width,
        height = window_size.height,
        col = (vim.o.columns - window_size.width) / 2,
        row = (vim.o.lines - window_size.height) / 2,
        anchor = "NW",
        style = "minimal",
        border = "rounded",
    }

    local win = vim.api.nvim_open_win(buf, true, opts)

    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

    local keymap_opts = { noremap = true, silent = true, buffer = buf }

    vim.keymap.set("n", "q", "<cmd>close<CR>", keymap_opts)
    vim.keymap.set("n", "<Esc>", "<cmd>close<CR>", keymap_opts)

    -- vim.keymap.set("n", "<CR>", function ()
    --     vim.api.nvim_win_close(win, true)
    -- end, keymap_opts)

    local function CloseCurrentBuffer()
        local current_buffer = vim.api.nvim_get_current_buf()
        vim.api.nvim_win_close(vim.api.nvim_get_current_win(), true)
        return current_buffer
    end

    ---@param direction "left" | "right" | "above" | "below"
    local function SplitWindow(direction)
        vim.api.nvim_win_close(vim.api.nvim_get_current_win(), true)
        local buf_id = CloseCurrentBuffer()
        vim.api.nvim_open_win(buf_id, true, {
            win = target_win_id,
            split = direction,
        })
    end

    local function MoveToDown()
        SplitWindow("below")
    end
    local function MoveToUp()
        SplitWindow("above")
    end
    local function MoveToLeft()
        SplitWindow("left")
    end
    local function MoveToRight()
        SplitWindow("right")
    end
    vim.keymap.set("n", "j", MoveToDown, keymap_opts)
    vim.keymap.set("n", "<Down>", MoveToDown, keymap_opts)
    vim.keymap.set("n", "k", MoveToUp, keymap_opts)
    vim.keymap.set("n", "<Up>", MoveToUp, keymap_opts)
    vim.keymap.set("n", "h", MoveToLeft, keymap_opts)
    vim.keymap.set("n", "<Left>", MoveToLeft, keymap_opts)
    vim.keymap.set("n", "l", MoveToRight, keymap_opts)
    vim.keymap.set("n", "<Right>", MoveToRight, keymap_opts)
end

M.run = function ()
    local win_id = window_picker.pick_window()
    if not win_id then return end
    OpenActionSelectionWindow(win_id)
end

return M;
