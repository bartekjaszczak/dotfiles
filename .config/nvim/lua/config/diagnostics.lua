-- Diagnostic icons
-- NOTE: Currently there's no texthl option in vim.diagnostic.config.signs so keeping this legacy solution
vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })

vim.diagnostic.config({
    virtual_text = false,
    virtual_lines = {
        current_line = true,
    },
    -- signs = {
    --     text = {
    --         [vim.diagnostic.severity.ERROR] = "",
    --         [vim.diagnostic.severity.WARN] = "",
    --         [vim.diagnostic.severity.INFO] = "",
    --         [vim.diagnostic.severity.HINT] = "",
    --     },
    -- },
})
