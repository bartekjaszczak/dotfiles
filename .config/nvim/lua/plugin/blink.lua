return {
    "saghen/blink.cmp",
    lazy = false, -- lazy loading handled internally
    -- optional: provides snippets for the snippet source
    dependencies = {
        "rafamadriz/friendly-snippets",
        "saadparwaiz1/cmp_luasnip",
        "l3mon4d3/luasnip",
        { "saghen/blink.compat", version = "*", opts = { impersonate_nvim_cmp = true } },
    },

    -- use a release tag to download pre-built binaries
    version = "v0.*",

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        keymap = {
            preset = "enter",
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
        completion = {
            list = {
                selection = "manual",
            },
            menu = {
                border = "rounded",
            },
            documentation = {
                auto_show = true,
                window = {
                    border = "rounded",
                },
            },
        },
        signature = {
            enabled = true,
            window = {
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
        },
    },
}
