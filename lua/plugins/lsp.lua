return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'mfussenegger/nvim-jdtls', config = false },
      'mason-org/mason.nvim',
      'j-hui/fidget.nvim',
    },
    config = function()
      vim.lsp.inlay_hint.enable()

      -- local fname = vim.api.nvim_buf_get_name(0)
      -- local util = require('lspconfig.util')
      -- local match = util.root_pattern('Dioxus.toml')(fname)
      -- if match ~= nil then
      --   local default_config = vim.lsp.config['tailwindcss'] or {}
      --   local filetypes = default_config.filetypes or {}
      --   vim.list_extend(filetypes, { 'rust' })
      --   default_config.settings.tailwindCSS = vim.tbl_deep_extend('force', default_config.settings.tailwindCSS, {
      --     includeLanguages = { rust = 'html' },
      --     experimental = { classRegex = { 'class: "(.*)"' } },
      --   })
      --   vim.lsp.config('tailwindcss', default_config)
      -- end

      -- vim.lsp.enable('gdscript')
      -- vim.lsp.enable('gdshader_lsp')
      -- vim.lsp.enable('roslyn_ls')
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
      registry_cache = {
        refresh = false,
      },
      ui = {
        check_outdated_packages_on_open = false,
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
    dependencies = {
      'mason-org/mason.nvim',
      'neovim/nvim-lspconfig',
    },
    opts = {
      ensure_installed = { 'lua_ls' },
      -- automatic_enable = {
      --   exclude = { 'rust_analyzer' },
      -- },
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
    enabled = false,
    version = '^9',
    lazy = false,
    opts = {},
    config = function(_, opts)
      vim.g.rustaceanvim = opts
    end,
  },
}
