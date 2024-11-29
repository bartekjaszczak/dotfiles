return {
    "saghen/blink.cmp",
    lazy = false, -- lazy loading handled internally
    -- optional: provides snippets for the snippet source
    dependencies = {
        "rafamadriz/friendly-snippets",
        "saadparwaiz1/cmp_luasnip",
        { "saghen/blink.compat", version = "*", opts = { impersonate_nvim_cmp = true } },
    },

    -- use a release tag to download pre-built binaries
    version = "v0.*",

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        keymap = { preset = "enter" },
        accept = {
            auto_brackets = {
                enabled = true,
            },
        },
        trigger = {
            signature_help = {
                enabled = false,
            },
        },
        windows = {
            autocomplete = {
                border = "rounded",
                selection = "manual",
            },
            documentation = {
                border = "rounded",
                auto_show = true,
            },
            signature_help = {
                border = "rounded",
            },
        },
        sources = {
            completion = {
                enabled_providers = { "lsp", "path", "snippets", "buffer", "luasnip" },
            },
            providers = {
                luasnip = {
                    name = "luasnip",
                    module = "blink.compat.source",

                    score_offset = -3,

                    opts = {
                        use_show_condition = false,
                        show_autosnippets = true,
                    },
                },
            },
            snippets = {
                expand = function(snippet)
                    require("luasnip").lsp_expand(snippet)
                end,
                active = function(filter)
                    if filter and filter.direction then
                        return require("luasnip").jumpable(filter.direction)
                    end
                    return require("luasnip").in_snippet()
                end,
                jump = function(direction)
                    require("luasnip").jump(direction)
                end,
            },
        },
    },
}
