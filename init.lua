package.path = vim.fn.expand("$XDG_CONFIG_HOME") .. "/nvim/?.lua;" .. package.path

pcall(vim.api.nvim_exec, "language en_US", true)

local lazypath = vim.fn.expand("$XDG_CONFIG_HOME") .. "/nvim/lazy/lazy.nvim"

vim.g.mapleader = " "
vim.g.maplocalleader = " "

--Insure lazy.nvim is installed
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath
    })
end
vim.opt.rtp:prepend(lazypath)

local lazy_options = {
    root = vim.fn.expand("$XDG_CONFIG_HOME") .. "/nvim/plugins/lazy/",
    install = {
        missing = true,
        -- colorscheme = { "habamax" }
    }
}

require("lazy").setup("plugins", lazy_options)
require("options")
require("remap")

-- LSP
-- local lsp_servers = require("mason-lspconfig").get_installed_servers()
-- local capabilities = require("cmp_nvim_lsp").default_capabilities()
-- capabilities.textDocument.foldingRange = {
--     dynamicRegistration = false,
--     lineFoldingOnly = true
-- }
--
-- require("lspconfig").glsl_analyzer.setup({})
-- for _, server in pairs(lsp_servers) do
--     if server == "lua_ls" then
--         require("lspconfig")[server].setup({
--             capabilities = capabilities,
--             settings = {
--                 Lua = {
--                     runtime = {
--                         version = "LuaJIT",
--                     },
--                     diagnostics = {
--                         globals = { "vim" }
--                     }
--                 }
--             }
--         })
--         vim.lsp.enable("lua_ls")
--     elseif server == "svelte" then
--         local dyn_cap = vim.lsp.protocol.make_client_capabilities()
--         dyn_cap.workspace.didChangeWatchedFiles.dynamicRegistration = true
--         dyn_cap.textDocument.foldingRange = {
--             dynamicRegistration = false,
--             lineFoldingOnly = true
--         }
--
--         require("lspconfig")[server].setup({
--             capabilities = dyn_cap,
--             on_attach = function(client)
--                 vim.api.nvim_create_autocmd("BufWritePost", {
--                     pattern = { "*.js", "*.ts" },
--                     callback = function(ctx)
--                         client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
--                     end
--                 })
--             end,
--             settings = {
--                 svelte = {
--                     plugin = {
--                         svelte = {
--                             compilerWarnings = {
--                                 ["a11y-no-onchange"] = "ignore",
--                                 ["a11y-aria-attributes"] = "ignore",
--                                 ["a11y-no-static-element-interactions"] = "ignore",
--                                 ["a11y-click-events-have-key-events"] = "ignore",
--                             }
--                         }
--                     }
--                 }
--             }
--         })
--     else
--         require("lspconfig")[server].setup({ capabilities = capabilities })
--     end
-- end

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("LspConfig", {}),
    callback = function(ev)
        vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

        local opts = { buffer = ev.buf }
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
        vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set("n", "<leader>wi", vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set("n", "<leader>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<leader>f", function()
            vim.lsp.buf.format { async = true }
        end, opts)

        -- require("lsp_signature").on_attach({
        --
        -- }, ev.buf)
    end
})

--Color
-- local color = nil
-- vim.cmd.colorscheme(color or "rose-pine")
-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
--

vim.diagnostic.config({
    float = {
        source = "always",
        border = "rounded",
    },
})
