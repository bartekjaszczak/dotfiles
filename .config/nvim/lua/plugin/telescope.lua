return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },

    lazy = true,
    keys = {
        "<leader>e",
        "<leader>ff",
        "<leader>fg",
        "<leader>fr",
        "<leader>fp",
        "<leader>fh",
        "<leader>fl",
        "<leader>q",
    },

    config = function()
        local builtin = require("telescope.builtin")

        vim.keymap.set("n", "<leader>e", builtin.buffers, { noremap = true, silent = true })
        vim.keymap.set("n", "<leader>ff", builtin.find_files, { noremap = true, silent = true })
        vim.keymap.set("n", "<leader>fg", builtin.git_files, { noremap = true, silent = true })
        vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { noremap = true, silent = true })
        vim.keymap.set("n", "<leader>fp", builtin.resume, { noremap = true, silent = true }) -- Previous search
        vim.keymap.set("n", "<leader>fh", builtin.search_history, { noremap = true, silent = true })
        vim.keymap.set("n", "<leader>q", builtin.quickfix, { noremap = true, silent = true })
        vim.keymap.set(
            { "x", "n" },
            "<leader>fw",
            builtin.grep_string,
            { noremap = true, silent = true }
        )
        vim.keymap.set("n", "<leader>fl", builtin.live_grep, { noremap = true, silent = true })
    end,
}
