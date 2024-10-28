vim.opt.guicursor = ""

-- Relative line numbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- Tab is 4 spaces
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

-- Don't wrap lines by default
vim.opt.wrap = false

-- Undodir settings
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- Don't highlight all search results, but highlight the current one
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Highlight current line
vim.opt.cursorline = true

-- Fix colours
vim.opt.termguicolors = true

-- Scroll the buffer to keep cursor vaguely in the center
vim.opt.scrolloff = 8

-- Show signcolumn
vim.opt.signcolumn = "yes"

-- Fix '@' in file names
vim.opt.isfname:append("@-@")

-- Used for plugins which trigger actions on inactivity
vim.opt.updatetime = 50

-- Colour some columns
vim.opt.colorcolumn = { "80", "100", "120" }

-- Fix backspace
vim.opt.backspace = "indent,eol,start"

-- Conceal (used for markdown shenanigans)
vim.opt.conceallevel = 2

-- Enabling than will treat '-' as part of a word and select it accordingly
-- vim.iskeyword:append("-")

-- Don't trace LSPs by default (they generate a lot of logs)
vim.lsp.set_log_level("off")
-- vim.lsp.set_log_level("trace")

-- Enable spellchecking
vim.opt.spell = true
vim.opt.spelllang = "en_gb,pl"

-- Diagnostic icons
vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = " ", texthl = "DiagnosticSignHint" })
