return {
    "mickael-menu/zk-nvim",

    config = function()
        require("zk").setup({
            picker = "telescope",
        })

        -- Create a new note after asking for its title.
        vim.keymap.set(
            "n",
            "<leader>nn",
            "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>",
            { desc = "Create new note" }
        )

        -- Open notes.
        vim.keymap.set(
            "n",
            "<leader>no",
            "<Cmd>ZkNotes { sort = { 'modified' } }<CR>",
            { desc = "Open notes" }
        )
        -- Open notes associated with the selected tags.
        vim.keymap.set("n", "<leader>nt", "<Cmd>ZkTags<CR>", { desc = "Open notes by tags" })

        -- Search for the notes matching a given query.
        vim.keymap.set(
            "n",
            "<leader>nf",
            "<Cmd>ZkNotes { sort = { 'modified' }, match = { vim.fn.input('Search: ') } }<CR>",
            { desc = "Search notes" }
        )
        -- Search for the notes matching the current visual selection.
        vim.keymap.set(
            "v",
            "<leader>nf",
            ":'<,'>ZkMatch<CR>",
            { desc = "Search notes by selection" }
        )
    end,
}
