local M = {}

M.adapters = {
    godot = {
        type = 'server',
        host = '127.0.0.1',
        port = 6006,
    },

    gdb = {
        type = "executable",
        command = "gdb",
        args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
    },
}

M.configurations = {
    gdscript = {
        {
            name = "Launch scene",
            type = "godot",
            request = "launch",
            project = "${workspaceFolder}",
        },
    },

    rust = {
        {
            name = "LLDB: Launch",
            type = "codelldb",
            request = "launch",
            program = function()
                -- local build_job = vim.fn.jobstart('cargo build')
                -- vim.fn.jobwait({ build_job })

                vim.cmd("make build")
                if #vim.fn.getqflist() ~= 0 then
                    return require("dap").ABORT
                end

                local path = vim.fn.input({
                    prompt = 'Path to executable: ',
                    default = vim.fn.getcwd() .. '/target/debug/',
                    completion = 'file'
                })
                return (path and path ~= "") and path or require("dap").ABORT
            end,
            cwd = "${workspaceFolder}",
            stopOnEntry = false,
        },
        {
            name = "GDB: Launch",
            type = "gdb",
            request = "launch",
            program = function()
                local build_job = vim.fn.jobstart('cargo build')
                vim.fn.jobwait({ build_job })
                return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
            end,
            cwd = "${workspaceFolder}",
            stopOnEntry = false,
        },
    },

}

return M
