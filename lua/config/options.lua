vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.have_nerd_font = true

vim.o.number = true
vim.o.relativenumber = true

vim.o.showmode = true

vim.o.breakindent = false

vim.o.undofile = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.signcolumn = 'yes'

vim.o.splitright = true
vim.o.splitbelow = true

vim.o.list = true
vim.opt.listchars:append { precedes = '<', extends = '>' }

vim.o.inccommand = 'split'

vim.o.cursorline = false

vim.o.scrolloff = 10

vim.o.confirm = true

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.diagnostic.config({
  update_in_insert = false,
  severity_sort = true,
  float = { source = 'if_many' },
  underline = { severity = { min = vim.diagnostic.severity.WARN } },
  -- Can switch between these as you prefer
  virtual_text = true,   -- Text shows up at the end of the line
  virtual_lines = false, -- Text shows up underneath the line, with virtual lines
  -- Auto open the float, so you can easily read the errors when jumping with `[d` and `]d`
  jump = { float = true },
})

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('options-highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

vim.o.foldlevelstart = 99

vim.o.wrap = false

vim.o.swapfile = false
vim.o.backup = false

vim.o.colorcolumn = '100'

vim.o.statusline = '%<%f %h%w%m%r%=%-14.y %-14.(%l,%c%V%) %P'

vim.opt.diffopt:remove({ 'linematch:40' })

vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0
