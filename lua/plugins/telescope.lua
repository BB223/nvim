return {
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-fzf-native.nvim',
        },
        opts = {},
        config = function(_, opts)
            require('telescope').setup(opts)
            require('telescope').load_extension('fzf')

            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = 'Telescope find files' })
            vim.keymap.set('n', '<leader>ps', builtin.live_grep, { desc = 'Telescope live grep' })
            vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'Telescope git files' })
            vim.keymap.set('n', '<leader>vh', builtin.help_tags, { desc = 'Telescope help tags' })
        end,
    },
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
    },
    {
        'nvim-telescope/telescope-symbols.nvim',
        opts = {
            sources = { 'emoji', 'kaomoji', 'gitmoji' },
        },
        enabled = false,
    }
}
