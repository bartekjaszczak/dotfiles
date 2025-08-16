-- Show indentations in buffer
return {
    "lukas-reineke/indent-blankline.nvim",

    config = function()

        require("ibl").setup({
            scope = {
                enabled = false,
            },
        })
    end,
}
