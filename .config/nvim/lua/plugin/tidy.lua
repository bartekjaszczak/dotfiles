-- Removes whitespaces on save (empty lines at the end, spaces at the end of lines)
return {
    "mcauley-penney/tidy.nvim",

    config = function()
        require("tidy").setup()
    end,
}
