return {
    {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        cmd = "LazyDev",
        opts = {
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                "nvim-dap-ui",
            },
        },
    },
    {
        "hrsh7th/nvim-cmp",
        opts = function(_, opts)
            opts.sources = opts.sources or {}
            table.insert(opts.sources, {
                name = "lazydev",
                group_index = 0, -- set group index to 0 to skip loading LuaLS completions
            })
        end,
    },
    {
        "folke/ts-comments.nvim",
        event = "VeryLazy",
        opts = {},
    },
    {
        "tpope/vim-dispatch",
        opts = {},
        keys = {
            { "<leader>m", "<cmd>Dispatch<cr>", desc = "Dispatch :Make (Foreground)" },
            { "<leader>M", "<cmd>Dispatch!<cr>", desc = "Dispatch :Make! (Background)" },
        },
        cmd = { "Make", "Dispatch", "Focus", "Start" },
        config = function(_, _)
            vim.g.dispatch_tmux_height = '40% -h'
        end,
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {},
    },
}
