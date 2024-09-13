return {
    "vonheikemen/lsp-zero.nvim",

    branch = "v4.x",
    dependencies = {
        -- lsp support
        { "neovim/nvim-lspconfig" }, -- required
        {
            "williamboman/mason.nvim",
            build = function()
                pcall(vim.cmd, "MasonUpdate")
            end,
        },                                       -- optional
        { "williamboman/mason-lspconfig.nvim" }, -- optional

        -- autocompletion
        { "hrsh7th/nvim-cmp" },         -- required
        { "hrsh7th/cmp-nvim-lsp" },     -- required
        { "hrsh7th/cmp-buffer" },       -- optional
        { "hrsh7th/cmp-path" },         -- optional
        { "saadparwaiz1/cmp_luasnip" }, -- optional
        { "hrsh7th/cmp-nvim-lua" },     -- optional

        -- snippets
        { "l3mon4d3/luasnip" },             -- required
        { "rafamadriz/friendly-snippets" }, -- optional
    },

    config = function()
        -----------------------------------------------------------------------
        --- Mason setup -------------------------------------------------------
        -----------------------------------------------------------------------
        require("mason").setup({})

        -----------------------------------------------------------------------
        --- lsp-zero setup ----------------------------------------------------
        -----------------------------------------------------------------------
        local lsp_zero = require("lsp-zero")

        local lsp_attach = function(client, bufnr)
            lsp_zero.default_keymaps({
                buffer = bufnr,
                exclude = { -- These are provided via Telescope
                    "gr",
                    "gi",
                    "gd",
                    "go",
                    "<F4>",
                },
            })
            require("lsp_signature").on_attach()
        end

        lsp_zero.extend_lspconfig({
            lsp_attach = lsp_attach,
            sign_text = true,
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
        })

        -----------------------------------------------------------------------
        --- lspconfig setup ---------------------------------------------------
        -----------------------------------------------------------------------

        local lspconfig = require("lspconfig")


        -------- Lua
        lspconfig.lua_ls.setup(lsp_zero.nvim_lua_ls())

        -------- TeX / LaTeX
        lspconfig.texlab.setup({})

        lspconfig.ltex.setup({
            filetypes = { "tex", "bib" },
        })

        -------- C/C++
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.offsetEncoding = { "utf-16" }
        capabilities.textDocument.completion.completionItem.snippetSupport = true

        lspconfig.clangd.setup({
            force_setup = true,
            capabilities = capabilities,
            on_attach = function(client, bufnr)
                local opts = { buffer = bufnr, remap = false }

                vim.keymap.set("n", "<F8>", "<cmd>ClangdSwitchSourceHeader<CR>", opts)
            end,
            cmd = {
                "clangd",
                "--completion-style=detailed",
                "--suggest-missing-includes",
                "--all-scopes-completion",
                "--background-index",
            },
        })

        -------- Python
        lspconfig.pylsp.setup({
            settings = {
                pylsp = {
                    plugins = {
                        pycodestyle = {
                            ignore = { "W391" },
                            maxLineLength = 100,
                        },
                    },
                },
            },
        })

        lspconfig.pyright.setup({})

        --------- Rust
        lspconfig.rust_analyzer.setup({
            settings = {
                ["rust-analyzer"] = {
                    diagnostics = {
                        enable = true,
                        experimental = {
                            enable = true,
                        },
                    },
                },
            },
        })

        --------- Bash
        lspconfig.bashls.setup({})

        --------- CMake
        lspconfig.cmake.setup({})

        --------- XML
        lspconfig.lemminx.setup({})

        --------- Markdown
        lspconfig.marksman.setup({})


        --------- Borders around hover and signature help floating windows
        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
            border = "rounded",
        })
        vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
            border = "rounded",
        })

        -----------------------------------------------------------------------
        --- cmp setup ---------------------------------------------------------
        -----------------------------------------------------------------------
        local has_words_before = function()
            unpack = unpack or table.unpack
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0
                and vim.api
                .nvim_buf_get_lines(0, line - 1, line, true)[1]
                :sub(col, col)
                :match("%s")
                == nil
        end

        local kind_icons = {
            Text = "",
            Method = "󰆧",
            Function = "󰊕",
            Constructor = "",
            Field = "󰇽",
            Variable = "󰂡",
            Class = "󰠱",
            Interface = "",
            Module = "",
            Property = "󰜢",
            Unit = "",
            Value = "󰎠",
            Enum = "",
            Keyword = "󰌋",
            Snippet = "",
            Color = "󰏘",
            File = "󰈙",
            Reference = "",
            Folder = "󰉋",
            EnumMember = "",
            Constant = "󰏿",
            Struct = "",
            Event = "",
            Operator = "󰆕",
            TypeParameter = "󰅲",
        }

        local luasnip = require("luasnip")
        local cmp = require("cmp")
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

        require("luasnip.loaders.from_vscode").lazy_load()

        cmp.setup({
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<CR>"] = cmp.mapping.confirm({ select = false }),
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                        -- elseif has_words_before() then
                        --     cmp.complete()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<C-Space>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    elseif has_words_before() then
                        cmp.complete()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "luasnip" },
                { name = "path" },
                { name = "nvim_lua" },
                { name = "buffer",  keyword_length = 3 },
            }),
            formatting = {
                fields = { "menu", "kind", "abbr" },
                format = function(entry, vim_item)
                    -- Kind icons (with names)
                    -- vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind) -- This concatenates the icons with the name of the item kind
                    -- Kind icons (without names)
                    vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
                    -- Source
                    vim_item.menu = ({
                        buffer = "",
                        nvim_lsp = "",
                        luasnip = "",
                        nvim_lua = "󰏿",
                        path = "󰈙",
                    })[entry.source.name]
                    return vim_item
                end,
            },
            enabled = function()
                -- disable autocompletion in prompt
                local buftype = vim.api.nvim_get_option_value("buftype", {})
                if buftype == "prompt" then
                    return false
                end

                -- disable completion in comments
                local context = require("cmp.config.context")
                -- keep command mode completion enabled when cursor is in a comment
                if vim.api.nvim_get_mode().mode == "c" then
                    return false
                else
                    return not context.in_treesitter_capture("comment")
                        and not context.in_syntax_group("Comment")
                end
            end,
            window = {
                documentation = cmp.config.window.bordered(),
                completion = cmp.config.window.bordered(),
            },
        })
    end,
}
