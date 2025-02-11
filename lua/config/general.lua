-- Set mapleader key
vim.g.mapleader = " "

-- Set options
vim.opt.cmdheight = 1
vim.opt.completeopt = "preview"
vim.opt.errorbells = false
vim.opt.expandtab = true
vim.opt.fileformats = "unix"
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.infercase = true
vim.opt.lazyredraw = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 999
vim.opt.shiftwidth = 4
vim.opt.showmode = false
vim.opt.spelllang = "en_gb"
vim.opt.swapfile = false
vim.opt.synmaxcol = 250
vim.opt.tabstop = 4
vim.opt.termguicolors = true
vim.opt.title = true
vim.opt.titlelen = 0
vim.opt.titlestring = "nvim - %t"
vim.opt.visualbell = false
vim.opt.wrap = false
vim.opt.writebackup = false

vim.api.nvim_set_keymap("n", "j", "gj", { noremap = true })
vim.api.nvim_set_keymap("n", "k", "gk", { noremap = true })
