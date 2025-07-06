-- Show indentations in buffer
return {
    "lukas-reineke/indent-blankline.nvim",

    config = function()
        vim.opt.list = true
        vim.opt.listchars:append("space:⋅")

        require("ibl").setup({
            scope = {
                enabled = false,
            },
        })
    end,
}
