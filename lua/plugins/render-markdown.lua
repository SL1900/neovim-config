return {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim", "nvim-mini/mini.icons" },
    ---@module "render-markdown"
    ---@type render.md.UserConfig
    opts = {
        completions = { lsp = { enabled = true } },
        file_types = { "markdown" },
        render_modes = true,
        checkbox = {
            unchecked = { icon = '󰄱     ', },
            checked = { icon = '󰱒 DONE', },
            custom = {
                todo = { raw = "[-]", rendered = "󰥔 TODO", highlight = "RenderMarkdownTodo" },
                failed = { raw = "[~]", rendered = " FAIL", highlight = "RenderMarkdownError", scope_highlight = nil },
                swap = { raw = "[>]", rendered = " SWAP", highlight = "RenderMarkdownWarn", scope_highlight = nil },
            }
        }
    },
    config = function(_, opts)
        require("mini.icons").setup()
        require("render-markdown").setup(opts)
    end
}
