vim.filetype.add({
  pattern = {
    ['.*[oO]penapi.*%.ya?ml'] = 'yaml.openapi',
    ['.*[oO]penapi.*%.json'] = 'json.openapi',
  },
})
