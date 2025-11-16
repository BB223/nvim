return {
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-fzf-native.nvim',
    },
    keys = {
      { "<leader>pf", "<cmd>lua require('telescope.builtin').find_files()<cr>",          desc = 'Telescope find files', },
      { "<leader>ps", "<cmd>lua require('config.telescope-picker').project_files()<cr>", desc = 'Telescope find files', },
      { "<leader>lg", "<cmd>lua require('telescope.builtin').live_grep()<cr>",           desc = 'Telescope live grep', },
      { "<leader>vh", "<cmd>lua require('telescope.builtin').help_tags()<cr>",           desc = 'Telescope help tags', },
    },
    opts = {
      defaults = {
        path_display = {
          "truncate",
          shorten = {
            len = 4,
            exclude = { -2, -1 }
          }
        }
      }
    },
    config = function(_, opts)
      require('telescope').setup(opts)
      require('telescope').load_extension('fzf')
    end,
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
  },
}
