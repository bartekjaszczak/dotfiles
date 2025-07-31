-- Collection of linters/formatters
return {
    "nvimtools/none-ls.nvim", -- null-ls is archived, none-ls is a fork

    config = function()
        local null_ls = require("null-ls")

        null_ls.setup({
            sources = {
                -- Formatting
                null_ls.builtins.formatting.stylua,
                null_ls.builtins.formatting.clang_format,
                null_ls.builtins.formatting.prettierd,
                null_ls.builtins.formatting.shfmt,
            },
        })
    end,
}
