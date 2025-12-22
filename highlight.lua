local M = {}

HlPrefix = "SL_Highlight_"
Colors = {
    { name="Red",               ctermfg="red",                              fg = "red" },
    { name="Green",             ctermfg="green",                            fg = "green" },
    { name="Blue",              ctermfg="blue",                             fg = "blue" },
    { name="Black on Red",      ctermfg="black",    ctermbg="magenta",      fg="black",         bg="IndianRed" },
    { name="Black on Green",    ctermfg="black",    ctermbg="green",        fg="black",         bg="chartreuse" },
    { name="Black on Cyan",     ctermfg="black",    ctermbg="cyan",         fg="black",         bg="DeepSkyBlue" },
    { name="White on Red",      ctermfg="white",    ctermbg="DarkRed",      fg="white",         bg="firebrick" },
    { name="White on Green",    ctermfg="white",    ctermbg="DarkGreen",    fg="white",         bg="DarkGreen" },
    { name="White on Blue",     ctermfg="white",    ctermbg="DarkBlue",     fg="white",         bg="DarkSlateBlue" },
    { name="Black on White",                                                fg="black",         bg="thistle" },
    { name="Black on Baige",                                                fg="black",         bg="burlywood" },
    { name="Black on Powder Blue",                                          fg="black",         bg="PowderBlue" },
    { name="Black on Orange",                                               fg="black",         bg="peru" },
    { name="Black on Dark Sea Green",                                       fg="black",         bg="DarkSeaGreen" },
    { name="Black on Steel Blue",                                           fg="black",         bg="SteelBlue" },
    { name="Black on Dark Orange",                                          fg="black",         bg="DarkOrange" },
    { name="Black on Dark Olive Green",                                     fg="black",         bg="DarkOliveGreen" },
    { name="Black on Slate Gray",                                           fg="black",         bg="SlateGray" },
    { name="Red on Dark Grey",                                              fg="red",           bg="grey20" },
    { name="Green on Dark Grey",                                            fg="green",         bg="grey20" },
    { name="Blue on Dark Grey",                                             fg="CornflowerBlue",bg="grey20" },
    { name="Red on Semi Dark Grey",                                         fg="red",           bg="grey40" },
    { name="Green on Semi Dark Grey",                                       fg="green",         bg="grey40" },
    { name="Blue on Semi Dark Grey",                                        fg="blue",          bg="grey40" },
    { name="Red on Grey",                                                   fg="red",           bg="grey70" },
    { name="Green on Grey",                                                 fg="DarkGreen",     bg="grey70" },
    { name="Blue on Grey",                                                  fg="blue",          bg="grey70" },
}
ActiveHighlights = { }

M.setup = function ()
    table.sort(Colors, function (a, b) return a.name < b.name end)
    -- Defining highlight groups
    for _, v in ipairs(Colors) do
        local params = {}
        for field, value in pairs(v) do
            if field == "name" then
                goto continue
            end
            params[field] = value
            ::continue::
        end
        local key = (v.ctermfg or "") .. (v.ctermbg or "") .. (v.fg or "") .. (v.bg or "")
        vim.api.nvim_set_hl(0, HlPrefix .. key, params)
    end

    -- Defining command for applying highlight
    vim.api.nvim_create_user_command(
        "HL",
        function(opts) PerformHighlight(opts) end,
        {
            desc = "idk",
            range = true,
        }
    )

    -- Defining command for opening highlight removal menu
    vim.api.nvim_create_user_command(
        "HC",
        function(opts) ClearHighlight(opts) end,
        {
            desc = "idk",
            range = true,
        }
    )
end

function PerformHighlight(opts)
    local pattern = ""

    -- If command argument provided, use it whole as highlight pattern
    if string.len(opts.args) > 0 then
        pattern = opts.args
    -- If command is called with visual selection, extract text and use as pattern
    elseif opts.range > 0  then
        local region = vim.fn.getregion(
            vim.fn.getpos("'<"),
            vim.fn.getpos("'>"),
            { type = vim.fn.visualmode() }
        )
        pattern = table.concat(region, "\\n")
    -- If nothing is provided, use current word under the cursor
    else
        pattern = vim.fn.expand("<cword>")
    end

    local options = { }

    -- Defining options for highlight selection menu
    for _, v in ipairs(Colors) do
        table.insert(options, v.name)
    end
    -- Opening highlight selection menu
    vim.ui.select(
        options,
        { prompt = "Select highlight:" },
        function(_, index)
            if index == nil then
                return
            end
            local v = Colors[index]
            local key = (v.ctermfg or "") .. (v.ctermbg or "") .. (v.fg or "") .. (v.bg or "")
            local match_id = vim.fn.matchadd(HlPrefix .. key, pattern, 10, -1)
            table.insert(ActiveHighlights, {
                id = match_id,
                pattern = pattern,
                hl = HlPrefix .. key,
            })
        end
    )

    -- Call matchadd function on highlight selection menu to provide highlighting preview
    vim.defer_fn(function ()
        local win = vim.api.nvim_get_current_win()
        for i, v in ipairs(Colors) do
            local key = (v.ctermfg or "") .. (v.ctermbg or "") .. (v.fg or "") .. (v.bg or "")
            vim.fn.matchadd(HlPrefix .. key, i .. ". " .. v.name, 10, -1, { window = win + 1 })
        end
    end, 50)
end

function ClearHighlight(opts)
    if opts.args == "*" then
        vim.fn.clearmatches()
        return
    end

    local options = { "All" }
    for _, v in ipairs(ActiveHighlights) do
        table.insert(options, v.pattern)
    end

    vim.ui.select(
        options,
        { prompt = "Select highlight:" },
        function(_, index)
            if index == nil then
                return
            end
            if index == 1 then
                for _, v in ipairs(ActiveHighlights) do
                    vim.fn.matchdelete(v.id)
                end
                ActiveHighlights = { }
                return
            end
            print(ActiveHighlights[index - 1].pattern)
            vim.fn.matchdelete(ActiveHighlights[index - 1].id)
            table.remove(ActiveHighlights, index - 1)
        end
    )

    -- Call matchadd function on highlight removal menu to provide highlighting preview
    vim.defer_fn(function ()
        local win = vim.api.nvim_get_current_win()
        for i, v in ipairs(ActiveHighlights) do
            local pattern = string.gsub(v.pattern, "\\n", "\\\\n")
            print(pattern)
            vim.fn.matchadd(v.hl, (i + 1) .. ". " .. pattern, 10, -1, { window = win + 1 })
        end
    end, 50)
end

return M
