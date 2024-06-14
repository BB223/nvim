return {
    {
        'tpope/vim-fugitive',
        event = 'BufWinEnter',
        keys = {
            { "<leader>gs", vim.cmd.Git },
            { "gu", "<cmd>diffget //3<CR>" },
            { "gh", "<cmd>diffget //2<CR>" },
        }
    },
    {
        'f-person/git-blame.nvim',
        event = 'BufWinEnter',
    }
}
