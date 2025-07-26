return {
    {
        'mfussenegger/nvim-dap',
        keys = {
            { "<leader>dB", "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>",  desc = "Breakpoint Condition" },
            { "<leader>db", "<cmd>lua require('dap').toggle_breakpoint()<cr>",                                     desc = "Toggle Breakpoint" },
            { "<leader>dc", "<cmd>lua require('dap').continue()<cr>",                                              desc = "Run/Continue" },
            { "<leader>dC", "<cmd>lua require('dap').run_to_cursor()<cr>",                                         desc = "Run to Cursor" },
            { "<leader>dg", "<cmd>lua require('dap').goto_()<cr>",                                                 desc = "Go to Line (No Execute)" },
            { "<leader>di", "<cmd>lua require('dap').step_into()<cr>",                                             desc = "Step Into" },
            { "<leader>dj", "<cmd>lua require('dap').down()<cr>",                                                  desc = "Down" },
            { "<leader>dk", "<cmd>lua require('dap').up()<cr>",                                                    desc = "Up" },
            { "<leader>dl", "<cmd>lua require('dap').run_last()<cr>",                                              desc = "Run Last" },
            { "<leader>do", "<cmd>lua require('dap').step_out()<cr>",                                              desc = "Step Out" },
            { "<leader>dO", "<cmd>lua require('dap').step_over()<cr>",                                             desc = "Step Over" },
            { "<leader>dP", "<cmd>lua require('dap').pause()<cr>",                                                 desc = "Pause" },
            { "<leader>ds", "<cmd>lua require('dap').session()<cr>",                                               desc = "Session" },
            { "<leader>dt", "<cmd>lua require('dap').terminate()<cr>",                                             desc = "Terminate" },
            { "<leader>dw", "<cmd>lua require('dap.ui.widgets').hover()<cr>",                                      desc = "Widgets" },
        },
        config = function()
            local dap, options = require('dap'), require('config.dap')
            dap.adapters = options.adapters
            dap.configurations = options.configurations
        end,
    },
    {
        'jay-babu/mason-nvim-dap.nvim',
        event = "VeryLazy",
        dependencies = {
            'mason-org/mason.nvim',
            'mfussenegger/nvim-dap',
        },
        cmd = {
            "DapInstall",
            "DapUninstall"
        },
        opts = {
            handlers = {
                function(config)
                    require('mason-nvim-dap').default_setup(config)
                end,
            }
        }
    },
    {
        'rcarriga/nvim-dap-ui',
        event = "VeryLazy",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio",
        },
        opts = {},
        config = function(_, opts)
            local dap, dapui = require('dap'), require('dapui')
            dapui.setup(opts)
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end
        end,
    },
    {
        'theHamsta/nvim-dap-virtual-text',
        opts = {},
    },
}
