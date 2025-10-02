vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.splitright = true

vim.opt.formatoptions:remove "o"

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.signcolumn = "yes"

vim.opt.list = true
vim.opt.listchars:append { precedes = '<', extends = '>' }

vim.opt.colorcolumn = "100"

vim.g.tex_flavor = 'latex'

vim.lsp.inlay_hint.enable(true);
