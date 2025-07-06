-- File browser as buffer
return {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},

    config = function()
        require("oil").setup({})
        vim.keymap.set("n", "-", "<cmd>Oil<CR>", { desc = "File explorer" })
        vim.keymap.set(
            "n",
            "<leader>-",
            "<cmd>Oil " .. vim.fn.getcwd() .. "<CR>",
            { desc = "File explorer (cwd)" }
        )
    end,

    dependencies = { "nvim-tree/nvim-web-devicons" },
}
