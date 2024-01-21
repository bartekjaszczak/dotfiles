return {
    "danymat/neogen",

    cmd = { "Neogen" },
    keys = { "<leader>cd" },

    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
        require("neogen").setup({ snippet_engine = "luasnip" })
        vim.keymap.set("n", "<leader>cd", vim.cmd.Neogen)
    end,
}
