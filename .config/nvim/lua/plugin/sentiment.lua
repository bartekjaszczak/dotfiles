-- Highlight current parenthesis scope
return {
    "utilyre/sentiment.nvim",
    version = "*",

    config = function()
        require("sentiment").setup()
    end,
}
