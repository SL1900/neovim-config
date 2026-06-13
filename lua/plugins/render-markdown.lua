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
            custom = {
                todo = { raw = "[-]", rendered = "󰥔 ", highlight = "RenderMarkdownTodo", scope_highlight = nil}
            }
        }
    },
    config = function(opts)
        require("mini.icons").setup()
        require("render-markdown").setup(opts)
    end
}
