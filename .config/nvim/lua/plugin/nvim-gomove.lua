-- Move lines/selections up and down
return {
    "booperlv/nvim-gomove",

    config = function()
        require("gomove").setup({
            -- whether or not to map default key bindings, (true/false)
            map_defaults = false,
            -- whether or not to reindent lines moved vertically (true/false)
            reindent = true,
            -- whether or not to undojoin same direction moves (true/false)
            undojoin = true,
            -- whether to not to move past end column when moving blocks horizontally, (true/false)
            move_past_end_col = false,
        })

        local map = vim.api.nvim_set_keymap

        map("n", "<S-Left>", "<Plug>GoNSMLeft", {})
        map("n", "<S-Down>", "<Plug>GoNSMDown", {})
        map("n", "<S-Up>", "<Plug>GoNSMUp", {})
        map("n", "<S-Right>", "<Plug>GoNSMRight", {})

        map("x", "<S-Left>", "<Plug>GoVSMLeft", {})
        map("x", "<S-Down>", "<Plug>GoVSMDown", {})
        map("x", "<S-Up>", "<Plug>GoVSMUp", {})
        map("x", "<S-Right>", "<Plug>GoVSMRight", {})
    end,
}
