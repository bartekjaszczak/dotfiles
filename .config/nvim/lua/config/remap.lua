local map = vim.keymap.set

vim.g.mapleader = " "

-- Center screen on move or next/previous search
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up" })
map("n", "n", "nzzzv", { desc = "Next search" })
map("n", "N", "Nzzzv", { desc = "Previous search" })

-- Paste visual without clearing the register 0
map("x", "<leader>p", '"_dP', { desc = "Paste visual" })

-- Yank to clipboard
map("n", "<leader>y", '"+y', { desc = "Yank to clipboard" })
map("v", "<leader>y", '"+y', { desc = "Yank to clipboard" })
map("n", "<leader>Y", '"+Y', { desc = "Yank to clipboard" })

-- Delete without clearing the register 0
map("n", "<leader>d", '"_d', { desc = "Delete" })
map("v", "<leader>d", '"_d', { desc = "Delete" })

-- Substitute word under cursor
map(
    "n",
    "<leader>rs",
    [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = "Substitute word under cursor" }
)

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
