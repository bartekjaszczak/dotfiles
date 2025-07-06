-- Jump to any letter
return {
    "rlane/pounce.nvim",

    config = function()
        vim.keymap.set({ "n", "x" }, "<leader>j", function()
            require("pounce").pounce({})
        end, { desc = "Jump to..." })
    end,
}
