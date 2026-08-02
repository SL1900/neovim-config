return {
    "obsidian-nvim/obsidian.nvim",
    ---@module "obsidian"
    ---@type obsidian.config
    opts = {
        legacy_commands = false,
        workspaces = {
            {
                name = "Main vault",
                path = "E:/_ObsidianVault/"
            }
        }
    },
}
