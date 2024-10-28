return {
    "https://gitlab.com/bartekjaszczak/luma-nvim",
    dev = false,

    priority = 1000,

    config = function()
        require("luma").setup({
            theme = "dark",
            contrast = "medium",
        })
        vim.cmd.colorscheme("luma")

        -- Disable semantic highlights for comment
        vim.api.nvim_set_hl(0, '@lsp.type.comment', {})
    end,
}
