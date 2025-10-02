local capabilities = vim.tbl_deep_extend("force", {}, vim.lsp.protocol.make_client_capabilities(),
  require("cmp_nvim_lsp").default_capabilities())
return {
  {
    "mason-org/mason.nvim",
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
        }
      },
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    depencencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {
      ensure_installed = { "lua_ls" },
      -- handlers = {
      --   ["jdtls"] = function()
      --     require('lspconfig').jdtls.setup({
      --       capabilities = capabilities,
      --       flags = {
      --         allow_incremental_sync = true,
      --       },
      --     })
      --   end,
      --   ["texlab"] = function()
      --     require('lspconfig').texlab.setup({
      --       capabilities = capabilities,
      --       settings = {
      --         texlab = {
      --           build = {
      --             executable = "arara",
      --             args = { "%f" },
      --           },
      --         },
      --       },
      --     })
      --   end
      -- }
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {},
    config = function()
    end
  },
  {
    "j-hui/fidget.nvim",
    opts = {
      notification = {
        window = {
          winblend = 0,
        },
      }
    }
  },
  {
    "mfussenegger/nvim-jdtls",
    opts = {
      settings = {
        java = {
          configuration = {
            runtimes = {
              {
                name = "JavaSE-17",
                path = "/usr/lib/jvm/java-17-openjdk/",
              },
              {
                name = "JavaSE-21",
                path = "/usr/lib/jvm/java-21-openjdk/",
                default = true,
              },
            }
          }
        }
      }
    },
    config = function(_, opts)
      local bundles = {
        vim.fn.glob(
          vim.fn.stdpath("data") ..
          "/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar", true
        ),
      }
      local java_test_bundles = vim.split(
        vim.fn.glob(
          vim.fn.stdpath("data") ..
          "/mason/packages/java-test/extension/server/*.jar", true
        ), "\n"
      )
      local excluded = {
        "com.microsoft.java.test.runner-jar-with-dependencies.jar",
        "jacocoagent.jar",
      }
      for _, java_test_jar in ipairs(java_test_bundles) do
        local fname = vim.fn.fnamemodify(java_test_jar, ":t")
        if not vim.tbl_contains(excluded, fname) then
          table.insert(bundles, java_test_jar)
        end
      end

      opts.init_options = {
        bundles = bundles
      }

      vim.lsp.config("jdtls", opts)
    end,
  }
}
