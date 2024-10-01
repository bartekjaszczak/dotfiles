return {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },

    config = function()
        require("telescope").load_extension("file_browser")
        vim.keymap.set("n", "<leader>e", "<cmd>Telescope file_browser<CR>")
    end,
}
