return {
    "https://gitlab.com/bartekjaszczak/distinct-nvim",
    dev = false,

    priority = 1000,

    config = function()
        vim.cmd([[colorscheme distinct]])
    end,
}
