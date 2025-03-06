return {
    "R-nvim/R.nvim",
    -- Only required if you also set defaults.lazy = true
    lazy = false,
    keys = {
        {
            "<LocalLeader>gd",
            "<cmd>lua require('r.send').cmd('tryCatch(httpgd::hgd_browse(),error=function(e) {httpgd::hgd();httpgd::hgd_browse()})')<CR>",
            desc = "httpgd",
        },
    },
    opts = {
        R_args = { "--quiet", "--no-save" },
        external_term = "tmux split-window -h -l 60",
        auto_quit = true,
    },
}
