---@type vim.lsp.Config
return {
  settings = {
    yaml = {
      schemaStore = {
        enable = false,
        url = '',
      },
      schemas = {
        ['https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json'] = {
          '.gitlab-ci.yml',
          '.gitlab-ci.yaml',
        },
        ['https://json.schemastore.org/github-workflow.json'] = '/.github/workflows/*',
      },
    },
  },
}
