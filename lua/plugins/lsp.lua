return {
  {
    "mason-org/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
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
      automatic_enable = {
        exclude = { "rust_analyzer", },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      ['vtsls'] = {
        settings = {
          vtsls = {
            tsserver = {
              globalPlugins = {
                {
                  name = '@vue/typescript-plugin',
                  location = vim.fn.stdpath('data') ..
                      "/mason/packages/vue-language-server/node_modules/@vue/language-server",
                  languages = { 'vue' },
                  configNamespace = 'typescript',
                }
              },
            },
          },
        },
        filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
      },
      ['yamlls'] = {
        settings = {
          yaml = {
            schemaStore = {
              enable = false,
              url = "",
            },
            schemas = {
              ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = {
                ".gitlab-ci.yml",
                ".gitlab-ci.yaml",
              },
              ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
            }
          }
        }
      },
    },
    config = function(_, opts)
      local capabilities = vim.tbl_deep_extend("force", {}, vim.lsp.protocol.make_client_capabilities(),
        require("cmp_nvim_lsp").default_capabilities())
      vim.lsp.config("*", {
        capabilities = capabilities
      })

      for lsp, opt in pairs(opts) do
        vim.lsp.config(lsp, opt)
      end
      vim.lsp.inlay_hint.enable()
    end
  },
  {
    "j-hui/fidget.nvim",
    opts = {
      notification = {
        window = {
          winblend = 0,
        },
        override_vim_notify = true,
      }
    }
  },
  {
    "mfussenegger/nvim-jdtls",
    opts = {
      flags = {
        allow_incremental_sync = false,
      },
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
              },
              {
                name = "JavaSE-25",
                path = "/usr/lib/jvm/java-25-openjdk/",
                default = true,
              },
            }
          },
          format = {
            settings = {
              url = 'https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml',
              profile = 'GoogleStyle',
            }
          },
          inlayHints = {
            parameterNames = {
              enabled = "all",
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

      local lombok_jar = vim.fn.stdpath("data") .. "/mason/packages/jdtls/lombok.jar"
      vim.env.JDTLS_JVM_ARGS = string.format("-javaagent:%s", lombok_jar)
      vim.lsp.config("jdtls", opts)
    end,
  },
  {
    'mrcjkb/rustaceanvim',
    version = '^6', -- Recommended
    lazy = false,   -- This plugin is already lazy
    opts = {},
    config = function(_, opts)
      vim.g.rustaceanvim = opts
    end
  }
}
