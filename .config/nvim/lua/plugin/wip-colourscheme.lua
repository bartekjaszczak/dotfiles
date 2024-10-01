return {
    "https://gitlab.com/bartekjaszczak/wip-colourscheme-nvim",
    dev = true,

    priority = 1000,

    config = function()
        require("wip").setup({
            theme = "dark",
            contrast = "medium",
        })
        vim.cmd.colorscheme("wip")
    end,
}
