---@type vim.lsp.Config
return {
  ---@type lspconfig.settings.lemminx
  settings = {
    xml = {
      catalogs = { '/etc/xml/catalog' },
    },
    redhat = {
      telemetry = {
        enabled = false,
      },
    },
  },
}
