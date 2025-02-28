return {
    {
        'rose-pine/neovim',
        name = 'rose-pine',
        lazy = false,
        priority = 1000,
        opts = {
            styles = {
                transparency = true,
            },
        },
    },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {
            style = "moon",
            transparent = true,
            -- styles = {
            --     comments = { bold = true },
            -- },
        },
        config = function(_, opts)
            require('tokyonight').setup(opts)
            vim.cmd [[colorscheme tokyonight]]
            vim.api.nvim_set_hl(0, 'LineNrAbove', { bold = true })
            vim.api.nvim_set_hl(0, 'LineNr', { bold = true })
            vim.api.nvim_set_hl(0, 'LineNrBelow', { bold = true })
        end,
    },
}
