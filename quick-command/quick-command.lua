---@alias EngineName "Lua" | "Jq" | "Node" | "Nvim"

---@class Argument
---@field value string

---@class Command
---@field name string
---@field engine EngineName
---@field executable_path string
---@field arguments? Argument[]
---@field working_dir? string
---@field output? "terminal" | "register"

local M = {}

---@type table<EngineName, string>
local Engine_prefixes = {
    ["Lua"] = "lua",
    ["Jq"] = "jq",
    ["Node"] = "tsx",
    ["Nvim"] = "source",
}

M.setup = function ()
    vim.api.nvim_create_user_command(
        "QC",
        function(opts) M.execute(opts) end,
        { desc = "[Q]uick [C]ommand" }
    )
end

M.execute = function (opts)
    local options = {}
    package.loaded["quick-command.commands"] = nil
    local commands = require("quick-command.commands")
    for _, v in ipairs(commands) do
        table.insert(options, v.name)
    end

    vim.ui.select(
        options,
        { prompt = "Select command", },
        function (_, idx)
            if not idx then
                return
            end
            local command = commands[idx]
            ExecuteCommand(command)
        end
    )
end

---@param command Command
function ExecuteCommand(command)
    local executable_path = ReplaceVariables(command.executable_path)

    -- if Engine_prefixes[command.engine] then
    --     executable_path = Engine_prefixes[command.engine] .. " " .. executable_path
    -- end

    -- if command.working_dir then
    --     command_text = "cd /d \"" .. command.working_dir .. "\" && " .. command_text
    -- end

    if command.engine == "Nvim" then
        vim.api.nvim_command(":" .. executable_path)
        return
    -- else
    --     command_text = "[[" .. command_text .. "]]"
    --     command_text = ":split | terminal " .. command_text
    end

    local arguments = {}
    table.insert(arguments, Engine_prefixes[command.engine])
    table.insert(arguments, executable_path)
    for _, argument in ipairs(command.arguments or {}) do
        local argument_parsed = ReplaceVariables(argument.value)
        table.insert(arguments, argument_parsed)
    end

    -- if command.engine ~= "Nvim" then

    ---@type vim.SystemOpts
    local options = {
        text = true
    }
    if command.working_dir then
        options.cwd = ReplaceVariables(command.working_dir)
    end
    -- for index, value in ipairs(arguments) do
    --     print(value)
    -- end
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_command("split")
    vim.api.nvim_set_current_buf(buf)
    vim.bo[buf].buftype = "nofile"

    SetBufferContents(buf, { "Executing command..." })
    local time_elapsed = 0
    local timer = vim.uv.new_timer()
    local timer_interval = 100
    if timer then
        timer:start(0, timer_interval, vim.schedule_wrap(function ()
            time_elapsed = time_elapsed + timer_interval
            SetBufferContents(buf, { "Executing command... (" .. (time_elapsed / 1000) .. "s)"})
        end))
    end

    vim.system(
        arguments,
        options,
        function (result)
            local lines = {}
            if result.code == 0 then
                lines = SplitIntoLines(result.stdout)
            else
                lines = SplitIntoLines(result.stdout)
                lines = SplitIntoLines(result.stderr)
            end
            vim.schedule(function ()
                if timer then
                    timer:stop()
                end
                SetBufferContents(buf, lines)
            end)
        end
    )

    -- local result = vim.system(
    --     arguments,
    --     options
    -- ):wait()
    -- local lines = {}
    -- if result.code == 0 then
    --     lines = SplitIntoLines(result.stdout)
    -- else
    --     lines = SplitIntoLines(result.stdout)
    --     lines = SplitIntoLines(result.stderr)
    -- end
    -- vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)


    -- else
    --     -- print(command_text)
    --     local cmd = vim.api.nvim_parse_cmd(executable_path, {})
    --     -- print(command_text)
    --     vim.api.nvim_command(executable_path)
    -- end

end

---@param buf integer
---@param lines string[]
function SetBufferContents(buf, lines)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
end

---@param contents string | nil
---@return string
function CreateTempFile(contents)
    contents = contents or ""
    local temp_name = os.tmpname()
    local file = io.open(temp_name, "w")
    if not file then
        error("Error creating temporary file")
    end
    file:write(contents)
    file:close()
    return temp_name
end

function ReplaceVariables(input)
    local result = input
    result = ReplaceBufferName(result)
    result = ReplaceHomeDirectory(result)
    return result
end

function ReplaceBufferName(input)
    local buf_name = vim.api.nvim_buf_get_name(0)
    if buf_name == "" then
        local buffer_lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
        local buffer_content = table.concat(buffer_lines, "\n")
        buf_name = CreateTempFile(buffer_content)
    end
    return string.gsub(input, "<BUF_NAME>", buf_name)
end

function ReplaceHomeDirectory(input)
    local home_directory = os.getenv("HOME") or os.getenv("USERPROFILE") or os.getenv("HOMEPATH") or "~"
    return string.gsub(input, "<HOME>", home_directory)
end

function SplitIntoLines(text)
    local lines = {}
    for line in (text--[[  .. "\n" ]]):gmatch("(.-)\n") do
        line = line:gsub("\r$", "")
        table.insert(lines, line)
    end
    return lines
end

return M
