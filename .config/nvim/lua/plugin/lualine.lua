-- Statusline
return {
    "nvim-lualine/lualine.nvim",

    dependencies = { "nvim-tree/nvim-web-devicons" },

    config = function()
        -- Make a global table
        wordCount = {}
        -- Now add a function to it for the job needed
        function wordCount.getWords()
            if
                vim.bo.filetype == "md"
                or vim.bo.filetype == "txt"
                or vim.bo.filetype == "markdown"
            then
                if vim.fn.wordcount().visual_words == 1 then
                    return tostring(vim.fn.wordcount().visual_words) .. " word"
                elseif not (vim.fn.wordcount().visual_words == nil) then
                    return tostring(vim.fn.wordcount().visual_words) .. " words"
                else
                    return tostring(vim.fn.wordcount().words) .. " words"
                end
            else
                return "Not a text file"
            end
        end

        local function window()
            return vim.api.nvim_win_get_number(0)
        end

        local function show_macro_recording()
            local recording_register = vim.fn.reg_recording()
            if recording_register == "" then
                return ""
            else
                return "󰑋  " .. recording_register
            end
        end

        local function place()
            local colPre = "C:"
            local col = "%c"
            local linePre = " L:"
            local line = "%l/%L"
            return string.format("%s%s%s%s", colPre, col, linePre, line)
        end

        local lualine = require("lualine")

        lualine.setup({
            options = {
                component_separators = { " ", " " },
                section_separators = { left = "", right = "" },
            },
            extensions = {
                "fugitive",
                "lazy",
                "mason",
                "oil",
            },
            sections = {
                lualine_b = {
                    { "branch", icon = "󰘬" },
                    {
                        "diff",
                        colored = true,
                    },
                },
                lualine_c = {
                    { "diagnostics" },
                    function()
                        return "%="
                    end,
                    {
                        "filename",
                        file_status = true,
                        path = 0,
                        shorting_target = 40,
                        symbols = {
                            modified = "󰐖", -- Text to show when the file is modified.
                            readonly = "", -- Text to show when the file is non-modifiable or readonly.
                            unnamed = "[No Name]", -- Text to show for unnamed buffers.
                            newfile = "[New]", -- Text to show for new created file before first writting
                        },
                    },
                    {
                        wordCount.getWords,
                        color = { fg = "#201d17", bg = "#dfd9c2" },
                        separator = { left = "", right = "" },
                        cond = function()
                            return wordCount.getWords() ~= "Not a text file"
                        end,
                    },
                    {
                        "selectioncount",
                    },
                    {
                        show_macro_recording,
                        color = { fg = "#201d17", bg = "#fb4934" },
                        separator = { left = "", right = "" },
                    },
                },
                lualine_z = {
                    { place, padding = { left = 1, right = 1 } },
                },
            },
            inactive_sections = {
                lualine_a = { { window, color = { fg = "#f752a4" } } },
                lualine_c = {
                    function()
                        return "%="
                    end,
                    {
                        "filename",
                        path = 1,
                        shorting_target = 40,
                        symbols = {
                            modified = "󰐖", -- Text to show when the file is modified.
                            readonly = "", -- Text to show when the file is non-modifiable or readonly.
                            unnamed = "[No Name]", -- Text to show for unnamed buffers.
                            newfile = "[New]", -- Text to show for new created file before first writting
                        },
                    },
                },
            },
        })

        vim.api.nvim_create_autocmd("RecordingEnter", {
            callback = function()
                lualine.refresh()
            end,
        })

        vim.api.nvim_create_autocmd("RecordingLeave", {
            callback = function()
                -- This is going to seem really weird!
                -- Instead of just calling refresh we need to wait a moment because of the nature of
                -- `vim.fn.reg_recording`. If we tell lualine to refresh right now it actually will
                -- still show a recording occuring because `vim.fn.reg_recording` hasn't emptied yet.
                -- So what we need to do is wait a tiny amount of time (in this instance 50 ms) to
                -- ensure `vim.fn.reg_recording` is purged before asking lualine to refresh.
                local timer = vim.loop.new_timer()
                timer:start(
                    50,
                    0,
                    vim.schedule_wrap(function()
                        lualine.refresh()
                    end)
                )
            end,
        })
    end,
}
