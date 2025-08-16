local map = vim.keymap.set

-- Center screen on move or next/previous search
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up" })
map("n", "n", "nzzzv", { desc = "Next search" })
map("n", "N", "Nzzzv", { desc = "Previous search" })

-- Paste visual without clearing the register 0
map("x", "<leader>p", '"_dP', { desc = "Paste visual" })

-- Yank to clipboard
map({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to clipboard" })
map("n", "<leader>Y", '"+Y', { desc = "Yank to clipboard" })

-- Delete without clearing the register 0
map({ "n", "v" }, "<leader>d", '"_d', { desc = "Delete" })

-- Create an undo point on punctuation
map("i", ".", ".<c-g>u")
map("i", "!", "!<c-g>u")
map("i", "?", "?<c-g>u")
map("i", ";", ";<c-g>u")
map("i", ":", ":<c-g>u")

-- Move to window
for i = 1, 4 do
    local lhs = "<Leader>" .. i
    local rhs = i .. "<C-W>w"
    map("n", lhs, rhs, { desc = "Move to Window " .. i })
end

-- Copy buffer path to clipboard
map("n", "<leader>bp", ":let @+=@%<cr>", { desc = "Copy relative path to clipboard" })
map("n", "<leader>bP", ":let @+=expand('%:p')<cr>", { desc = "Copy absolute path to clipboard" })
