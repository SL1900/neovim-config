return {
    {
        "ray-x/lsp_signature.nvim",
        event = "VeryLazy",
        opts = {
            ignore_error = function (err, ctx, config)
                if ctx and ctx.client_id then
                    local client = vim.lsp.get_client_by_id(ctx.client_id)
                    if client and vim.tbl_contains({ "powershell_es" }, client.name) then
                        if err.message == "Content Modified" then
                            return true
                        end
                    end
                end
            end
        },
        config = function (_, opts) require("lsp_signature").setup(opts) end
    },
}
