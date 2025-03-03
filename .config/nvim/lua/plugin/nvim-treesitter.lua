return {
    "nvim-treesitter/nvim-treesitter",

    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {"bash", "c", "comment", "cpp", "diff", "doxygen", "git_config", "git_rebase", "gitattributes", "gitcommit", "gitignore", "json", "json5", "jsonc", "lua", "luadoc", "make", "markdown", "markdown_inline", "printf", "query", "regex", "rust", "ssh_config", "tmux", "toml", "vim", "vimdoc", "xml", "yaml", "zathurarc"},

            -- Install parsers synchronously (only applied to `ensure_installed`)
            sync_install = false,

            -- Automatically install missing parsers when entering buffer
            -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
            auto_install = true,

            ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
            -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

            highlight = {
                -- `false` will disable the whole extension
                enable = true,

                -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                -- Using this option may slow down your editor, and you may see some duplicate highlights.
                -- Instead of true it can also be a list of languages
                additional_vim_regex_highlighting = { "markdown" },
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<cr>",
                    -- scope_incremental = "<cr>",
                    node_incremental = "<cr>",
                    node_decremental = ",",
                },
            },
        })
    end,
}
