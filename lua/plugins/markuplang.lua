return {
  {
    'tigion/nvim-asciidoc-preview',
    ft = { 'asciidoc' },
    build = 'cd server && npm install --omit=dev --no-save',
    ---@module 'asciidoc-preview'
    ---@type asciidoc-preview.Config
    opts = {},
    enabled = false,
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' }, -- if you use standalone mini plugins
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      completion = {
        lsp = {
          enabled = true
        }
      },
    },
  }
}
