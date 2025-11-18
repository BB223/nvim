return {
  {
    "folke/trouble.nvim",
    opts = {
      modes = {
        lsp = {
          win = { position = "right" }
        }
      }
    },
    cmd = { "Trouble" },
    keys = {
      { "<leader>tt", ":Trouble diagnostics toggle<cr>",              desc = "Diagnostics (Trouble)" },
      { "<leader>tT", ":Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
      { "<leader>cs", ":Trouble symbols toggle focus=false<cr>",      desc = "Symbols (Trouble)" },
      { "<leader>cl", ":Trouble lsp toggle focus=false<cr>",          desc = "LSP Definitions / references / ... (Trouble)" },
      { "<leader>tL", ":Trouble loclist toggle<cr>",                  desc = "Location List (Trouble)" },
      { "<leader>tQ", ":Trouble qflist toggle<cr>",                   desc = "Quickfix List (Trouble)" },
    },
  }
}
