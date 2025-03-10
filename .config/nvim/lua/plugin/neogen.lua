return {
    "danymat/neogen",

    cmd = { "Neogen" },
    keys = { "<leader>cg" },

    dependencies = { "nvim-treesitter/nvim-treesitter", "l3mon4d3/luasnip" },
    config = function()
        require("neogen").setup({ snippet_engine = "luasnip" })
        vim.keymap.set("n", "<leader>cg", vim.cmd.Neogen, { desc = "Generate doxygen" })
    end,
}
