local capabilities = vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(),
    require("cmp_nvim_lsp").default_capabilities())
return {
    {
        "williamboman/mason.nvim",
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
        "williamboman/mason-lspconfig.nvim",
        depencencies = {
            "williamboman/mason.nvim",
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
                        settings = {
                            java = {
                                configuration = {
                                    runtimes = {
                                        {
                                            name = "JavaSE-21",
                                            path = "/usr/lib/jvm/java-21-openjdk",
                                            default = true
                                        },
                                        {
                                            name = "JavaSE-17",
                                            path = "/usr/lib/jvm/java-17-openjdk",
                                        },
                                        {
                                            name = "JavaSE-11",
                                            path = "/usr/lib/jvm/java-11-openjdk",
                                        },
                                    }
                                }
                            }
                        }
                    })
                end
            }
        },
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "nvim-java/nvim-java",
            "williamboman/mason-lspconfig.nvim",
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
        opts = {
        },
        config = function(_, opts)
            require('java').setup(opts)
        end
    },
    {
        "p00f/clangd_extensions.nvim",
        opts = {},
        enabled = false,
    },
}
