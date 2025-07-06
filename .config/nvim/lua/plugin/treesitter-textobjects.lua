-- Function, class and parameter textobjects
return {
    "nvim-treesitter/nvim-treesitter-textobjects",

    config = function()
        require("nvim-treesitter.configs").setup({
            textobjects = {
                select = {
                    enable = true,

                    lookahead = true,

                    keymaps = {
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ac"] = "@class.outer",
                        ["ic"] = "@class.inner",
                        ["aa"] = "@parameter.outer",
                        ["ia"] = "@parameter.inner",
                    },
                    selection_modes = {
                        ["@parameter.outer"] = "v", -- charwise
                        ["@function.outer"] = "V", -- linewise
                        ["@class.outer"] = "V", -- linewise
                    },
                },
                move = {
                    enable = true,
                    set_jumps = true,
                    goto_next_start = {
                        ["]a"] = "@parameter.inner",
                    },
                    goto_previous_start = {
                        ["[a"] = "@parameter.inner",
                    },
                },
            },
        })
    end,
}
