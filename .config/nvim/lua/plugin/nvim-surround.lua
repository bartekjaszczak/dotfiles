-- Edit/add/remove delimiters/brackets
return {
    "kylechui/nvim-surround",

    event = "VeryLazy",

    config = function()
        require("nvim-surround").setup()
    end,
}
