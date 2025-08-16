-- Don't trace LSPs by default (they generate a lot of logs)
vim.lsp.set_log_level("off")
-- vim.lsp.set_log_level("trace")

-- Enable inlay hints
vim.lsp.inlay_hint.enable(true, { 0 })

-- On attach (keybinds)
vim.api.nvim_create_autocmd("LspAttach", {
    desc = "LSP actions",
    callback = function(event)
        vim.keymap.set(
            { "n", "x" },
            "<leader>cf",
            "<cmd>lua vim.lsp.buf.format({async = true})<cr>",
            { buffer = event.buf, desc = "Format code" }
        )
        vim.keymap.set(
            { "n", "x" },
            "gd",
            "<cmd>lua vim.lsp.buf.definition()<cr>",
            { buffer = event.buf, desc = "Go to definition" }
        )
        vim.keymap.set(
            { "n", "x" },
            "grc",
            "<cmd>lua vim.lsp.buf.incoming_calls()<cr>",
            { buffer = event.buf, desc = "See incoming calls" }
        )

        vim.lsp.inlay_hint.enable(true, { 0 })
    end,
})

-- Enable servers
vim.lsp.enable("lua_ls")
vim.lsp.enable("rust_analyzer")
vim.lsp.enable("slint_lsp")
vim.lsp.enable("basedpyright")
vim.lsp.enable("pylsp")
vim.lsp.enable("texlab")
vim.lsp.enable("ltex_ls_plus")
vim.lsp.enable("lemminx")
vim.lsp.enable("marksman")
vim.lsp.enable("bashls")
vim.lsp.enable("clangd")
vim.lsp.enable("cmake")
