return {
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      style = 'moon',
      transparent = true,
      on_highlights = function(hl, colors)
        hl.LineNrAbove = vim.tbl_extend('force', hl.LineNrAbove, {
          fg = colors.fg,
          bold = true
        })
        hl.LineNr = vim.tbl_extend('force', hl.LineNr, {
          fg = colors.fg,
          bold = true
        })
        hl.LineNrBelow = vim.tbl_extend('force', hl.LineNrBelow, {
          fg = colors.fg,
          bold = true
        })
      end
    },
    config = function(_, opts)
      require('tokyonight').setup(opts)
      vim.cmd.colorscheme('tokyonight')
    end
  },
  {
    'folke/ts-comments.nvim',
    opts = {},
    event = 'VeryLazy',
    enabled = vim.fn.has('nvim-0.10.0') == 1,
  },
  -- {
  --   'tpope/vim-dispatch',
  --   opts = {},
  --   keys = {
  --     { '<leader>m', ':Dispatch<cr>',  desc = 'Dispatch :Make (Foreground)' },
  --     { '<leader>M', ':Dispatch!<cr>', desc = 'Dispatch :Make! (Background)' },
  --   },
  --   cmd = { 'Make', 'Dispatch', 'Focus', 'Start' },
  --   config = function(_, _)
  --     vim.g.dispatch_tmux_height = '40% -h'
  --   end,
  -- },
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    ---@module 'todo-comments'
    ---@type TodoOptions
    ---@diagnostic disable-next-line: missing-fields
    opts = {},
  },
}
