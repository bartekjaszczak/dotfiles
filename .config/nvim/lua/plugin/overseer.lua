return {
    "stevearc/overseer.nvim",
    opts = {},
    config = function()
        require("overseer").setup()

        vim.keymap.set("n", "<leader>tt", "<cmd>OverseerToggle<cr>", { desc = "Show tasks" })
        vim.keymap.set("n", "<leader>tr", "<cmd>OverseerRun<cr>", { desc = "Run task" })
    end,
}
