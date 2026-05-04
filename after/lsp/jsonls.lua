---@type vim.lsp.Config
return {
  ---@type lspconfig.settings.jsonls
  settings = {
    json = {
      schemas = {
        {
          fileMatch = { '.luarc.json', '.luarc.jsonc' },
          url = 'https://raw.githubusercontent.com/LuaLS/vscode-lua/master/setting/schema.json',
        }
      },
    },
  },
}
