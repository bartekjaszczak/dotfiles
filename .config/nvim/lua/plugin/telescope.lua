return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },

    lazy = true,
    keys = {
        "<leader>fb",
        "<leader>ff",
        "<leader>fg",
        "<leader>fr",

        "<leader>fh",
        "<leader>fq",
        "<leader>fw",
        "<leader>fl",

        "<leader>cd",
        "<leader>cs",
        "gr",
        "gi",
        "gd",
        "go",

        "<leader>fp",
        "<leader>ct",
    },

    config = function()
        local builtin = require("telescope.builtin")

        -- Files
        vim.keymap.set("n", "<leader>fb", builtin.buffers, { noremap = true, silent = true, desc = "Find buffers"})
        vim.keymap.set("n", "<leader>ff", builtin.find_files, { noremap = true, silent = true, desc = "Find files"})
        vim.keymap.set("n", "<leader>fg", builtin.git_files, { noremap = true, silent = true, desc = "Find files (git)"})
        vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { noremap = true, silent = true, desc = "Recent files"})

        -- Search
        vim.keymap.set("n", "<leader>fh", builtin.search_history, { noremap = true, silent = true, desc = "Search history"})
        vim.keymap.set("n", "<leader>fq", builtin.quickfix, { noremap = true, silent = true, desc = "Quickfix list"})
        vim.keymap.set(
            { "x", "n" },
            "<leader>fw",
            builtin.grep_string,
            { noremap = true, silent = true, desc = "Search word under cursor" }
        )
        vim.keymap.set("n", "<leader>fl", builtin.live_grep, { noremap = true, silent = true, desc = "Search for string..."})

        -- LSP
        vim.keymap.set("n", "<leader>cd", function()
            builtin.diagnostics({ bufnr = 0 })
        end, { noremap = true, silent = true, desc = "Show diagnostics" })
        vim.keymap.set(
            "n",
            "<leader>cs",
            builtin.lsp_workspace_symbols,
            { noremap = true, silent = true, desc = "Find workspace symbols" }
        )
        vim.keymap.set("n", "gr", builtin.lsp_references, { noremap = true, silent = true, desc = "Go to references" })
        vim.keymap.set("n", "gi", builtin.lsp_implementations, { noremap = true, silent = true, desc = "Go to implementation" })
        vim.keymap.set("n", "gd", builtin.lsp_definitions, { noremap = true, silent = true, desc = "Go to definition" })
        vim.keymap.set("n", "go", builtin.lsp_type_definitions, { noremap = true, silent = true, desc = "Go to type definition" })

        -- Other
        vim.keymap.set("n", "<leader>fp", builtin.resume, { noremap = true, silent = true, desc = "Previous search" })
        vim.keymap.set("n", "<leader>ct", builtin.treesitter, { noremap = true, silent = true, desc = "Treesitter" })

        require("telescope").setup({
            defaults = {
                file_ignore_patterns = { "node_modules", ".git" },
                mappings = {
                    i = {
                        ["<C-j>"] = require("telescope.actions").move_selection_next,
                        ["<C-k>"] = require("telescope.actions").move_selection_previous,
                        ["<C-q>"] = require("telescope.actions").smart_send_to_qflist
                            + require("telescope.actions").open_qflist,
                        ["<Esc>"] = require("telescope.actions").close,

                        ["<C-s>"] = require("telescope.actions").select_vertical,
                    },
                },
            },
        })

        require("telescope").load_extension("fzf")
    end,
}
