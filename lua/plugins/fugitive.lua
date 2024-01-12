return {
    'tpope/vim-fugitive',
    event = 'BufWinEnter',
    keys = {
        {"<leader>gs", vim.cmd.Git},
    }
}

