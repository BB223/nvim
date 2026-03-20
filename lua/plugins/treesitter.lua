return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    branch = "main",
    build = ':TSUpdate',
    opts = {},
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    lazy = false,
    opts = {},
  }
}
