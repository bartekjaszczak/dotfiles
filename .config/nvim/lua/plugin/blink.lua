return {
    "saghen/blink.cmp",
    lazy = false, -- lazy loading handled internally
    -- optional: provides snippets for the snippet source
    dependencies = {
        "rafamadriz/friendly-snippets",
        { "l3mon4d3/luasnip", version = "v2.*", build = "make install_jsregexp" },
    },

    -- use a release tag to download pre-built binaries
    version = "*", -- current config for v0.13.1

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        keymap = {
            preset = "enter",
        },
        snippets = {
            -- expand = function(snippet)
            --     require("luasnip").lsp_expand(snippet)
            -- end,
            -- active = function(filter)
            --     if filter and filter.direction then
            --         return require("luasnip").jumpable(filter.direction)
            --     end
            --     return require("luasnip").in_snippet()
            -- end,
            -- jump = function(direction)
            --     require("luasnip").jump(direction)
            -- end,
            preset = "luasnip",
        },
        completion = {
            keyword = {
                range = "full",
            },
            list = {
                -- selection = "manual",
                selection = {
                    preselect = false,
                }
            },
            menu = {
                auto_show = function(ctx)
                    return ctx.mode ~= "cmdline"
                end,
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
            default = {
                "lsp",
                "path",
                "snippets",
                "buffer",
            },
        },
    },
}
