return {
  {
    'neovim/nvim-lspconfig',
    depencencies = {
      'mfussenegger/nvim-jdtls',
      'mason-org/mason.nvim',
      'mason-org/mason-lspconfig.nvim',
      'j-hui/fidget.nvim',
    },
    config = function()
      vim.lsp.inlay_hint.enable()

      vim.lsp.enable('gdscript')
      -- vim.lsp.enable('gdshader_lsp')
      vim.lsp.enable('roslyn_ls')
    end,
  },
  {
    'mason-org/mason.nvim',
    cmd = 'Mason',
    build = ':MasonUpdate',
    ---@module 'mason.settings'
    ---@type MasonSettings
    ---@diagnostic disable-next-line: missing-fields
    opts = {
      ui = {
        icons = {
          package_installed = '✓',
          package_pending = '➜',
          package_uninstalled = '✗',
        },
      },
    },
  },
  {
    'mason-org/mason-lspconfig.nvim',
    opts = {
      ensure_installed = { 'lua_ls' },
      automatic_enable = {
        exclude = { 'rust_analyzer' },
      },
    },
  },
  {
    'j-hui/fidget.nvim',
    opts = {
      notification = {
        window = {
          winblend = 0,
        },
        override_vim_notify = true,
      },
    },
  },
  {
    'mrcjkb/rustaceanvim',
    version = '^8',
    lazy = false,
    opts = {},
    config = function(_, opts)
      vim.g.rustaceanvim = opts
    end,
  },
}
