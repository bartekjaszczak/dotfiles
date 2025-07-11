-- Visualises code actions
return {
    "rachartier/tiny-code-action.nvim",
    dependencies = {
        { "nvim-lua/plenary.nvim" },
        { "nvim-telescope/telescope.nvim" },
    },
    event = "LspAttach",
    config = function()
        require("tiny-code-action").setup()

        vim.keymap.set("n", "<leader>ca", function()
            require("tiny-code-action").code_action()
        end, { noremap = true, silent = true, desc = "Code actions" })
    end,
}
