-- Highlight other occurrences of a word under the cursor
return {
    "tzachar/local-highlight.nvim",

    config = function()
        require("local-highlight").setup({
            min_match_len = 3,
            animate = {
                enabled = false,
            },
        })
    end,
}
