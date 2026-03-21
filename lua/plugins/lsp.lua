return {
  {
    'neovim/nvim-lspconfig',
    depencencies = {
      'mason-org/mason.nvim',
      'mason-org/mason-lspconfig.nvim',
      'j-hui/fidget.nvim',
    },
    ---@type table<string, vim.lsp.Config>
    opts = {
      ['vtsls'] = {
        settings = {
          vtsls = {
            tsserver = {
              globalPlugins = {
                {
                  name = '@vue/typescript-plugin',
                  location = vim.fn.stdpath('data') ..
                      '/mason/packages/vue-language-server/node_modules/@vue/language-server',
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
              url = '',
            },
            schemas = {
              ['https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json'] = {
                '.gitlab-ci.yml',
                '.gitlab-ci.yaml',
              },
              ['https://json.schemastore.org/github-workflow.json'] = '/.github/workflows/*',
            }
          }
        }
      },
      ['lemminx'] = {
        settings = {
          xml = {
            catalogs = { '/etc/xml/catalog' }
          }
        }
      },
      ['lua_ls'] = {
        on_init = function(client)
          if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if path ~= vim.fn.stdpath 'config' and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then return end
          end

          client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
              version = 'LuaJIT',
              path = { 'lua/?.lua', 'lua/?/init.lua' },
            },
            workspace = {
              checkThirdParty = false,
              -- NOTE: this is a lot slower and will cause issues when working on your own configuration.
              --  See https://github.com/neovim/nvim-lspconfig/issues/3189
              library = vim.tbl_extend('force', vim.api.nvim_get_runtime_file('', true), {
                '${3rd}/luv/library',
                -- '${3rd}/busted/library',
              }),
            },
          })
        end,
        settings = {
          Lua = {},
        },
      },
    },
    config = function(_, opts)
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lspconfig-lsp-attach', { clear = true }),
        callback = function(event)
          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client:supports_method('textDocument/documentHighlight', event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('lspconfig-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('lspconfig-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'lspconfig-lsp-highlight', buffer = event2.buf }
              end,
            })
          end
          -- The following code creates a keymap to toggle inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          if client and client:supports_method('textDocument/inlayHint', event.buf) then
            vim.keymap.set('n', '<leader>th',
              function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }) end,
              { buffer = event.buf, desc = 'LSP: [T]oggle Inlay [H]ints' })
          end
        end,
      })

      for lsp, opt in pairs(opts) do
        vim.lsp.config(lsp, opt)
        vim.lsp.enable(lsp)
      end
      vim.lsp.inlay_hint.enable()

      vim.lsp.enable('gdscript')
      -- vim.lsp.enable('gdshader_lsp')
      vim.lsp.enable('roslyn_ls')
    end
  },
  {
    'mason-org/mason.nvim',
    cmd = 'Mason',
    build = ':MasonUpdate',
    ---@module 'mason.settings'
    ---@type MasonSettings
    ---@diagnostic disable-next-line: missing-fields
    opts = {
      ui = {
        icons = {
          package_installed = '✓',
          package_pending = '➜',
          package_uninstalled = '✗'
        }
      },
    },
  },
  {
    'mason-org/mason-lspconfig.nvim',
    opts = {
      ensure_installed = { 'lua_ls' },
      automatic_enable = {
        exclude = { 'rust_analyzer', },
      },
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
      }
    }
  },
  {
    'mfussenegger/nvim-jdtls',
    opts = {
      flags = {
        allow_incremental_sync = false,
      },
      settings = {
        java = {
          configuration = {
            runtimes = {
              {
                name = 'JavaSE-17',
                path = '/usr/lib/jvm/java-17-openjdk/',
              },
              {
                name = 'JavaSE-21',
                path = '/usr/lib/jvm/java-21-openjdk/',
              },
              {
                name = 'JavaSE-25',
                path = '/usr/lib/jvm/java-25-openjdk/',
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
              enabled = 'all',
            }
          },
          telemetry = false,
        }
      }
    },
    config = function(_, opts)
      local bundles = {
        vim.fn.glob(
          vim.fn.stdpath('data') ..
          '/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar', true
        ),
      }
      local java_test_bundles = vim.split(
        vim.fn.glob(
          vim.fn.stdpath('data') ..
          '/mason/packages/java-test/extension/server/*.jar', true
        ), '\n'
      )
      local excluded = {
        'com.microsoft.java.test.runner-jar-with-dependencies.jar',
        'jacocoagent.jar',
      }
      for _, java_test_jar in ipairs(java_test_bundles) do
        local fname = vim.fn.fnamemodify(java_test_jar, ':t')
        if not vim.tbl_contains(excluded, fname) then
          table.insert(bundles, java_test_jar)
        end
      end

      opts.init_options = {
        bundles = bundles
      }

      if vim.env.MAVEN_ARGS then
        opts.settings.java.configuration.maven = {
          userSettings = vim.fn.slice(vim.env.MAVEN_ARGS, 3)
        }
      end

      local lombok_jar = vim.fn.stdpath('data') .. '/mason/packages/jdtls/lombok.jar'
      vim.env.JDTLS_JVM_ARGS = string.format('-javaagent:%s', lombok_jar)
      vim.lsp.config('jdtls', opts)
      vim.lsp.enable('jdtls')
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
