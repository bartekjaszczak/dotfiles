-- Split/join line
return {
    "Wansmer/treesj",

    keys = { "<leader>cj" },

    dependencies = { "nvim-treesitter/nvim-treesitter" },

    config = function()
        require("treesj").setup({
            use_default_keymaps = false,
            max_join_length = 200,
        })

        vim.keymap.set("n", "<leader>cj", "<cmd>TSJToggle<CR>", { desc = "Join/split line" })
        -- vim.keymap.set("n", "<leader>bj", "<cmd>TSJJoin<CR>")
        -- vim.keymap.set("n", "<leader>bs", "<cmd>TSJSplit<CR>")
    end,
}
