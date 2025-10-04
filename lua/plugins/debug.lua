return {
  {
    'mfussenegger/nvim-dap',
    keys = {
      { '<F5>',       function() require('dap').continue() end,                                                    desc = "Run/Continue" },
      { '<F29>',      function() require('dap').run_last() end,                                                    desc = "Run Last" },
      { '<F17>',      function() require('dap').terminate() end,                                                   desc = "Terminate" },
      { '<F10>',      function() require('dap').step_over() end,                                                   desc = "Step Over" },
      { '<F11>',      function() require('dap').step_into() end,                                                   desc = "Step Into" },
      { '<F23>',      function() require('dap').step_out() end,                                                    desc = "Step Out" },
      { '<F9>',       function() require('dap').toggle_breakpoint() end,                                           desc = "Toggle Breakpoint" },
      { '<F21>',      function() require('dap').set_breakpoint() end,                                              desc = "Set Breakpoint" },
      { '<F33>',      function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, desc = "Set Log Point" },
      { '<Leader>dh', function() require('dap.ui.widgets').hover() end,                                            desc = "Widgets Hover",    mode = { 'n', 'v' } },
      { '<Leader>dp', function() require('dap.ui.widgets').preview() end,                                          desc = "Widgets Preview",  mode = { 'n', 'v' } },
      {
        '<Leader>df',
        function()
          local widgets = require('dap.ui.widgets')
          widgets.centered_float(widgets.frames)
        end,
        desc = "Widgets Frames"
      },
      {
        '<Leader>ds',
        function()
          local widgets = require('dap.ui.widgets')
          widgets.centered_float(widgets.scopes)
        end,
        desc = "Widgets Scopes"
      },
    },
    config = function()
      local dap, options = require('dap'), require('config.dap')
      dap.adapters = options.adapters
      dap.configurations = options.configurations
    end,
  },
  {
    'rcarriga/nvim-dap-ui',
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    opts = {},
    config = function(_, opts)
      local dap, dapui = require("dap"), require("dapui")
      dapui.setup(opts)
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    end,
  },
  {
    'theHamsta/nvim-dap-virtual-text',
    opts = {},
  },
  {
    'jay-babu/mason-nvim-dap.nvim',
    enabled = false,
    dependencies = {
      'mason-org/mason.nvim',
      'mfussenegger/nvim-dap',
    },
    opts = {
      handlers = {
        function(config)
          require('mason-nvim-dap').default_setup(config)
        end,
      }
    }
  },
}
