return {
  {
    'nvim-telescope/telescope.nvim',
    tag = 'v0.1.9',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-fzf-native.nvim',
    },
    keys = {
      { "<leader>pf", function() require('telescope.builtin').find_files() end,          desc = 'Telescope find files', },
      { "<leader>ps", function() require('config.telescope-picker').project_files() end, desc = 'Telescope find files', },
      { "<leader>lg", function() require('telescope.builtin').live_grep() end,           desc = 'Telescope live grep', },
      { "<leader>vh", function() require('telescope.builtin').help_tags() end,           desc = 'Telescope help tags', },
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
