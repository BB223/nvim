local capabilities = vim.tbl_deep_extend("force", {},  vim.lsp.protocol.make_client_capabilities(),
    require("cmp_nvim_lsp").default_capabilities())
return {
    {
        "mason-org/mason.nvim",
        version = "^1.0.0",
        build = ":MasonUpdate",
        cmd = "Mason",
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
        version = "^1.0.0",
        depencencies = {
            "mason-org/mason.nvim",
        },
        opts = {
            ensure_installed = { "lua_ls" },
            handlers = {
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup({
                        capabilities = capabilities
                    })
                end,
                ["jdtls"] = function()
                    require('lspconfig').jdtls.setup({
                        capabilities = capabilities,
                        flags = {
                            allow_incremental_sync = true,
                        },
                    })
                end,
                ["texlab"] = function()
                    require('lspconfig').texlab.setup({
                        capabilities = capabilities,
                        settings = {
                            texlab = {
                                build = {
                                    executable = "arara",
                                    args = { "%f" },
                                },
                            },
                        },
                    })
                end
            }
        },
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "nvim-java/nvim-java",
            "mason-org/mason-lspconfig.nvim",
        },
        config = function()
            local lspconfig = require('lspconfig')
            lspconfig.dartls.setup({
                capabilities = capabilities
            })
            lspconfig.gdscript.setup({
                capabilities = capabilities
            })
        end
    },
    {
        "github/copilot.vim",
        lazy = false,
        enabled = false,
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
        "nvim-java/nvim-java",
        opts = {},
        main = 'java',
    },
}
