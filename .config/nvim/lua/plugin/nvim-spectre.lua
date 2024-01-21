return {
    "nvim-pack/nvim-spectre",

    keys = { "<leader>R", "<leader>rw", "<leader>rp" },

    config = function()
        vim.keymap.set("n", "<leader>R", '<cmd>lua require("spectre").open()<CR>', {
            desc = "Open Spectre",
        })
        vim.keymap.set(
            "n",
            "<leader>rw",
            '<cmd>lua require("spectre").open_visual({select_word=true})<CR>',
            {
                desc = "Search current word",
            }
        )
        vim.keymap.set("v", "<leader>rw", '<esc><cmd>lua require("spectre").open_visual()<CR>', {
            desc = "Search current word",
        })
        vim.keymap.set(
            "n",
            "<leader>rp",
            '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>',
            {
                desc = "Search on current file",
            }
        )

        -- Reload colorscheme after Spectre is loaded as Spectre overrides it
        local colorscheme = vim.g.colors_name

        vim.cmd("colorscheme " .. colorscheme)
    end,
}
