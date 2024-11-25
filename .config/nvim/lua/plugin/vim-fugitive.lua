return {
    "tpope/vim-fugitive",

    keys = { "<leader>gg" },

    config = function()
        vim.keymap.set("n", "<leader>gg", vim.cmd.Git)
    end,
}
