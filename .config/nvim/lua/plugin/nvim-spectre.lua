-- Search and replace plugin
return {
    "nvim-pack/nvim-spectre",

    keys = { "<leader>rr", "<leader>rw", "<leader>rf" },

    config = function()
        vim.keymap.set("n", "<leader>rr", '<cmd>lua require("spectre").open()<CR>', {
            desc = "Replace...",
        })
        vim.keymap.set(
            "n",
            "<leader>rw",
            '<cmd>lua require("spectre").open_visual({select_word=true})<CR>',
            {
                desc = "Replace current word",
            }
        )
        vim.keymap.set("v", "<leader>rw", '<esc><cmd>lua require("spectre").open_visual()<CR>', {
            desc = "Replace current word",
        })
        vim.keymap.set(
            "n",
            "<leader>rf",
            '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>',
            {
                desc = "Replace in current file...",
            }
        )
        require("spectre").setup({
            highlight = {
                ui = "WinSeparator",
                filename = "FloatTitle",
                filedirectory = "Directory",
                search = "DiffDelete",
                border = "FloatBorder",
                replace = "DiffAdd",
            },
            is_insert_mode = true,
        })
    end,
}
