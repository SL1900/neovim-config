vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.showmode = false

-- vim.opt.guicursor = ""
vim.opt.cursorline = true

vim.opt.nu = true
vim.opt.relativenumber = true
vim.o.statuscolumn = "%l %=%{v:relnum?v:relnum:v:lnum} "

vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.tabstop = 4

vim.opt.smartindent = true

vim.opt.wrap = true

vim.opt.swapfile = false

vim.opt.incsearch = true
vim.opt.inccommand = "split"

vim.opt.termguicolors = true

vim.opt.scrolloff = 10
vim.opt.signcolumn  ="yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

vim.opt.clipboard = "unnamedplus"
-- vim.opt.breakindent = true
vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

vim.opt.hlsearch = false
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
