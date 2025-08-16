vim.opt.guicursor = ""

-- Relative line numbers
vim.opt.number = true
vim.opt.relativenumber = false

-- Tab is 4 spaces
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

-- Don't wrap lines by default
vim.opt.wrap = false

-- Don't wrap in the middle of a word
vim.opt.linebreak = true

-- Show whitespace characters
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", space = "·", nbsp = "␣" }

-- Undodir settings
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- Don't highlight all search results, but highlight the current one
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Smart case search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Show substitutions in separate pane
vim.opt.inccommand = "split"

-- Highlight current line
vim.opt.cursorline = true

-- Fix colours
vim.opt.termguicolors = true

-- Scroll the buffer to keep cursor vaguely in the center
vim.opt.scrolloff = 3

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

-- Don't show cmdline by default
vim.opt.cmdheight = 0

-- Enabling than will treat '-' as part of a word and select it accordingly
-- vim.iskeyword:append("-")

-- Enable spellchecking
vim.opt.spell = true
vim.opt.spelllang = "en_gb,pl"

-- Rounded borders
vim.opt.winborder = "rounded"
