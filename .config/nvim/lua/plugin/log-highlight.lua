-- Highlight patterns for most common log files
return {
    "fei6409/log-highlight.nvim",

    config = function()
        require("log-highlight").setup({})
    end,
}
