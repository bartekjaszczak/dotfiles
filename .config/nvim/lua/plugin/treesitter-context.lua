-- Shows code context (function name) if it doesn't fit on screen
return {
    "nvim-treesitter/nvim-treesitter-context",

    config = function()
        require("treesitter-context").setup({
            multiline_threshold = 1,
        })
    end,
}
