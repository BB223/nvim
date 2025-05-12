return {
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-fzf-native.nvim',
        },
        keys = {
            { "<leader>pf", require('telescope.builtin').find_files, desc = 'Telescope find files', },
            { "<leader>ps", require('telescope.builtin').live_grep,  desc = 'Telescope live grep', },
            { "<C-p>",      require('telescope.builtin').git_files,  desc = 'Telescope git files', },
            { "<leader>vh", require('telescope.builtin').help_tags,  desc = 'Telescope help tags', },
        },
        opts = {},
        config = function(_, opts)
            require('telescope').setup(opts)
            require('telescope').load_extension('fzf')
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
