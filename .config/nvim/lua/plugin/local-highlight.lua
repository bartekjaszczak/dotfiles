return {
    "tzachar/local-highlight.nvim",
    config = function()
        require("local-highlight").setup({
            min_match_len = 3,
        })
    end,
}
