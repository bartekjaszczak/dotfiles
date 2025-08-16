vim.cmd.colorscheme("finale")

-- Semantic highlights interfere with NOTE, FIX, TODO comments
vim.api.nvim_set_hl(0, "@lsp.type.comment", {})
