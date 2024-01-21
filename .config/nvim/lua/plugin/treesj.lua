return {
    "Wansmer/treesj",

    keys = { "<leader>bt", "<leader>bj", "<leader>bs" },

    dependencies = { "nvim-treesitter/nvim-treesitter" },

    config = function()
        require("treesj").setup({
            use_default_keymaps = false,
            max_join_length = 200,
        })

        vim.keymap.set("n", "<leader>bt", "<cmd>TSJToggle<CR>")
        vim.keymap.set("n", "<leader>bj", "<cmd>TSJJoin<CR>")
        vim.keymap.set("n", "<leader>bs", "<cmd>TSJSplit<CR>")
    end,
}
