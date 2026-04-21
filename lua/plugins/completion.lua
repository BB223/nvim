return {
  'saghen/blink.cmp',
  version = '1.*',
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    completion = {
      documentation = { auto_show = true },
      list = { selection = { preselect = true, auto_insert = false } },
      menu = { draw = { columns = { { 'label', 'label_description', gap = 1 }, { 'kind' }, { 'source_name' } } } },
    },
    cmdline = {
      completion = { list = { selection = { preselect = false, auto_insert = true } }, menu = { auto_show = true } },
    },
    sources = {
      default = {
        'lsp',
        'buffer',
        'snippets',
        'path',
      },
    },
  },
  config = function(_, opts)
    local capabilities = require('blink.cmp').get_lsp_capabilities({}, true)
    vim.lsp.config('*', { capabilities = capabilities })

    require('blink.cmp').setup(opts)
  end,
}
