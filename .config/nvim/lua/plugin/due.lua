return {
    "NFrid/due.nvim",

    config = function()
        require("due_nvim").setup({
            ft = "*.md",
            prescript_hi = "@annotation",
            due_hi = "@field",
        })
    end,
}
