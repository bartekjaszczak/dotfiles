return {
    "neovim/nvim-lspconfig",

    dependencies = {
        "saghen/blink.cmp",
    },

    config = function()
        vim.api.nvim_create_autocmd("LspAttach", {
            desc = "LSP actions",
            callback = function(event)
                vim.keymap.set(
                    "n",
                    "K",
                    "<cmd>lua vim.lsp.buf.hover({border = 'rounded'})<cr>",
                    { buffer = event.buf, desc = "Show hover information" }
                )
                vim.keymap.set(
                    { "n", "i" },
                    "<C-s>",
                    "<cmd>lua vim.lsp.buf.signature_help({border = 'rounded'})<cr>",
                    { buffer = event.buf, desc = "Show signature help" }
                )
                vim.keymap.set(
                    "n",
                    "<C-q>",
                    "<cmd>lua vim.diagnostic.open_float()<cr>",
                    { buffer = event.buf, desc = "Open diagnostics in floating window" }
                )
                vim.keymap.set(
                    { "n", "x" },
                    "<leader>cf",
                    "<cmd>lua vim.lsp.buf.format({async = true})<cr>",
                    { buffer = event.buf, desc = "Format code" }
                )

                if vim.lsp.inlay_hint then
                    vim.lsp.inlay_hint.enable(true, { 0 })
                end
            end,
        })

        -----------------------------------------------------------------------
        --- lspconfig setup ---------------------------------------------------
        -----------------------------------------------------------------------

        local capabilities = require("blink.cmp").get_lsp_capabilities()

        local lspconfig = require("lspconfig")

        -------- Lua
        lspconfig.lua_ls.setup({
            on_init = function(client)
                if client.workspace_folders then
                    local path = client.workspace_folders[1].name
                    if
                        path ~= vim.fn.stdpath("config")
                        and (
                            vim.loop.fs_stat(path .. "/.luarc.json")
                            or vim.loop.fs_stat(path .. "/.luarc.jsonc")
                        )
                    then
                        return
                    end
                end

                client.config.settings.Lua =
                    vim.tbl_deep_extend("force", client.config.settings.Lua, {
                        runtime = {
                            -- Tell the language server which version of Lua you're using
                            -- (most likely LuaJIT in the case of Neovim)
                            version = "LuaJIT",
                        },
                        -- Make the server aware of Neovim runtime files
                        workspace = {
                            checkThirdParty = false,
                            library = {
                                vim.env.VIMRUNTIME,
                                -- Depending on the usage, you might want to add additional paths here.
                                -- "${3rd}/luv/library"
                                -- "${3rd}/busted/library",
                            },
                            -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
                            -- library = vim.api.nvim_get_runtime_file("", true)
                        },
                    })
            end,
            settings = {
                Lua = {},
            },
            capabilities = capabilities,
        })

        -------- TeX / LaTeX
        lspconfig.texlab.setup({ capabilities = capabilities })

        lspconfig.ltex.setup({
            filetypes = { "tex", "bib" },
            capabilities = capabilities,
        })

        -------- C/C++
        local clangd_capabilities = vim.lsp.protocol.make_client_capabilities()
        clangd_capabilities.offsetEncoding = { "utf-16" }
        clangd_capabilities.textDocument.completion.completionItem.snippetSupport = true
        clangd_capabilities = require("blink.cmp").get_lsp_capabilities(clangd_capabilities)

        lspconfig.clangd.setup({
            force_setup = true,
            capabilities = clangd_capabilities,
            on_attach = function(client, bufnr)
                vim.keymap.set("n", "<leader>ch", "<cmd>ClangdSwitchSourceHeader<CR>", {
                    buffer = bufnr,
                    desc = "Switch between source/header",
                })
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
            capabilities = capabilities,
        })

        lspconfig.pyright.setup({ capabilities = capabilities })

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
                    check = {
                        command = "clippy",
                        extraArgs = {
                            "--",
                            "-Dclippy::all",
                            "-Dclippy::cargo",
                            "-Dclippy::pedantic",
                        },
                    },
                },
            },
            capabilities = capabilities,
        })

        --------- Slint
        lspconfig.slint_lsp.setup({ capabilities = capabilities })

        --------- Bash
        lspconfig.bashls.setup({ capabilities = capabilities })

        --------- CMake
        lspconfig.cmake.setup({ capabilities = capabilities })

        --------- XML
        lspconfig.lemminx.setup({ capabilities = capabilities })

        --------- Markdown
        lspconfig.marksman.setup({ capabilities = capabilities })

        --------- HTML
        local html_css_capabilities = vim.lsp.protocol.make_client_capabilities()
        html_css_capabilities.textDocument.completion.completionItem.snippetSupport = true
        html_css_capabilities = require("blink.cmp").get_lsp_capabilities(html_css_capabilities)

        lspconfig.html.setup({
            capabilities = html_css_capabilities,
            on_attach = function(client, bufnr)
                -- Formatting done with prettier (none-ls)
                client.server_capabilities.documentFormattingProvider = false
            end,
        })

        lspconfig.superhtml.setup({
            capabilities = capabilities,
            on_attach = function(client, bufnr)
                -- Formatting done with prettier (none-ls)
                client.server_capabilities.documentFormattingProvider = false
            end,
        })

        --------- CSS
        lspconfig.cssls.setup({
            capabilities = html_css_capabilities,
            on_attach = function(client, bufnr)
                -- Formatting done with prettier (none-ls)
                client.server_capabilities.documentFormattingProvider = false
            end,
        })

        --------- Javascript + Typescript
        lspconfig.ts_ls.setup({
            settings = {
                typescript = {
                    inlayHints = {
                        includeInlayEnumMemberValueHints = true,
                        includeInlayFunctionLikeReturnTypeHints = true,
                        includeInlayFunctionParameterTypeHints = true,
                        includeInlayParameterNameHints = "all",
                        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                        includeInlayPropertyDeclarationTypeHints = true,
                        includeInlayVariableTypeHints = true,
                        includeInlayVariableTypeHintsWhenArgumentMatchesName = true,
                    },
                },
                javascript = {
                    inlayHints = {
                        includeInlayEnumMemberValueHints = true,
                        includeInlayFunctionLikeReturnTypeHints = true,
                        includeInlayFunctionParameterTypeHints = true,
                        includeInlayParameterNameHints = "all",
                        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                        includeInlayPropertyDeclarationTypeHints = true,
                        includeInlayVariableTypeHints = true,
                        includeInlayVariableTypeHintsWhenArgumentMatchesName = true,
                    },
                },
            },
            capabilities = html_css_capabilities,
        })

        --------- Svelte
        lspconfig.svelte.setup({
            on_attach = function(client, bufnr)
                -- Formatting done with prettier (none-ls)
                client.server_capabilities.documentFormattingProvider = false
            end,
            capabilities = html_css_capabilities,
        })

        --------- Borders around hover and signature help floating windows
        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
            border = "rounded",
        })
        vim.lsp.handlers["textDocument/signatureHelp"] =
            vim.lsp.with(vim.lsp.handlers.signature_help, {
                border = "rounded",
            })

        vim.diagnostic.config({
            float = {
                border = "rounded",
            },
        })
    end,
}
