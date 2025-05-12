return {
    {
        'mfussenegger/nvim-dap',
        keys = {
            { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
            { "<leader>db", require("dap").toggle_breakpoint,                                                     desc = "Toggle Breakpoint" },
            { "<leader>dc", require("dap").continue,                                                              desc = "Run/Continue" },
            { "<leader>dC", require("dap").run_to_cursor,                                                         desc = "Run to Cursor" },
            { "<leader>dg", require("dap").goto_,                                                                 desc = "Go to Line (No Execute)" },
            { "<leader>di", require("dap").step_into,                                                             desc = "Step Into" },
            { "<leader>dj", require("dap").down,                                                                  desc = "Down" },
            { "<leader>dk", require("dap").up,                                                                    desc = "Up" },
            { "<leader>dl", require("dap").run_last,                                                              desc = "Run Last" },
            { "<leader>do", require("dap").step_out,                                                              desc = "Step Out" },
            { "<leader>dO", require("dap").step_over,                                                             desc = "Step Over" },
            { "<leader>dP", require("dap").pause,                                                                 desc = "Pause" },
            { "<leader>ds", require("dap").session,                                                               desc = "Session" },
            { "<leader>dt", require("dap").terminate,                                                             desc = "Terminate" },
            { "<leader>dw", require("dap.ui.widgets").hover,                                                      desc = "Widgets" },
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
            'williamboman/mason.nvim',
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
