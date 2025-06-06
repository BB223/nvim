return {
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-fzf-native.nvim',
        },
        keys = {
            { "<leader>pf", "<cmd>lua require('telescope.builtin').find_files()<cr>", desc = 'Telescope find files', },
            { "<leader>ps", "<cmd>lua require('telescope.builtin').live_grep()<cr>",  desc = 'Telescope live grep', },
            { "<C-p>",      "<cmd>lua require('telescope.builtin').git_files()<cr>",  desc = 'Telescope git files', },
            { "<leader>vh", "<cmd>lua require('telescope.builtin').help_tags()<cr>",  desc = 'Telescope help tags', },
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
