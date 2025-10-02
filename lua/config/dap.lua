local M = {}

M.adapters = {
}

M.configurations = {
  java = {
    {
      type = 'java',
      request = 'attach',
      name = "Debug (Attach) - Remote",
      hostName = "127.0.0.1",
      port = 5005,
    },
  }
}

return M
