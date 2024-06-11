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
        config = function(_, opts)
            require('rose-pine').setup(opts)
            vim.api.nvim_set_hl(0, 'LineNrAbove', { bold = true })
            vim.api.nvim_set_hl(0, 'LineNr', { bold = true })
            vim.api.nvim_set_hl(0, 'LineNrBelow', { bold = true })
            vim.cmd.colorscheme('rose-pine')
        end,
    },
    {
        "folke/tokyonight.nvim",
        lazy = true,
        opts = {
            style = "moon",
            transparent = true,
            styles = {
                floats = "transparent"
            }
        },
        config = function(_, opts)
            require('tokyonight').setup(opts)
            vim.api.nvim_set_hl(0, 'LineNrAbove', { bold = true })
            vim.api.nvim_set_hl(0, 'LineNr', { bold = true })
            vim.api.nvim_set_hl(0, 'LineNrBelow', { bold = true })
        end,
    },
}
