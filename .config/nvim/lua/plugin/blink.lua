-- Autocompletion + snippets
return {

    "saghen/blink.cmp",
    lazy = false,
    dependencies = {
        "rafamadriz/friendly-snippets",
        { "l3mon4d3/luasnip", version = "v2.*", build = "make install_jsregexp" },
    },

    -- use a release tag to download pre-built binaries
    version = "1.*", -- current config for v0.1.10

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        cmdline = { enabled = false },
        keymap = {
            preset = "enter",
        },
        snippets = {
            preset = "luasnip",
        },
        completion = {
            keyword = {
                range = "full",
            },
            list = {
                selection = {
                    preselect = false,
                },
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
            default = {
                "lsp",
                "path",
                "snippets",
                "buffer",
            },
        },
    },
}
