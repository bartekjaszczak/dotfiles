return {
    "https://gitlab.com/bartekjaszczak/finale-nvim",
    dev = true,

    priority = 1000,

    config = function()
        vim.cmd.colorscheme("finale")

        -- Disable semantic highlights for comment
        vim.api.nvim_set_hl(0, '@lsp.type.comment', {})
    end,
}
