return {
    {
        'tpope/vim-fugitive',
        event = 'BufWinEnter',
        keys = {
            { "<leader>gs", vim.cmd.Git },
            { "dp",         "<cmd>diffget LOCAL<CR>" },
            { "do",         "<cmd>diffget REMOTE<CR>" },
        }
    },
    {
        'f-person/git-blame.nvim',
        event = 'BufWinEnter',
    }
}
