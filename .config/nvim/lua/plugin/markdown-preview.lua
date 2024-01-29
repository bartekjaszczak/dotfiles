return {
    "iamcco/markdown-preview.nvim",

    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    keys = { "<leader>mp" },
    ft = { "markdown" },
    build = function()
        vim.fn["mkdp#util#install"]()
    end,
    config = function()
        vim.keymap.set("n", "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>")
    end,
}
