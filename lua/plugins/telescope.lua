return {
    'nvim-telescope/telescope.nvim', tag = '0.1.5',
-- or                              , branch = '0.1.x',
      dependencies = { 'nvim-lua/plenary.nvim' },
      lazy = false,
      keys = {
          vim.keymap.set('n', '<leader>pf', ":Telescope find_files<CR>"),
          vim.keymap.set('n', '<C-p>', ":Telescope git_files<CR>"),
          vim.keymap.set('n', '<leader>vh',":Telescope help_tags<CR>"),
          vim.keymap.set('n', '<leader>ps', function()
              require('telescope.builtin').grep_string({ search = vim.fn.input("Grep > ") })
          end)
      },
}
