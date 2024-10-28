return {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},

    config = function()
        require("oil").setup({})
        vim.keymap.set("n", "-", "<cmd>Oil<CR>")
        vim.keymap.set("n", "<leader>-", "<cmd>Oil " .. vim.fn.getcwd() .. "<CR>")
    end,

    dependencies = { "nvim-tree/nvim-web-devicons" },
}
