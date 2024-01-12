return {
    "tpope/vim-fugitive",
    lazy = false,
    keys = {
        vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
    }
}
