return {
    "tzachar/local-highlight.nvim",

    dependencies = {
        "folke/snacks.nvim",
    },
    config = function()
        require("local-highlight").setup({
            min_match_len = 3,
            animate = {
                enabled = true,
                easing = "linear",
                duration = {
                    step = 10,
                    total = 100,
                },
            },
        })
    end,
}
